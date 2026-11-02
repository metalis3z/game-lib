--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local CommandButton = require(frontend.Components.CommandButton)
local ScrollList = require(frontend.Components.ScrollList)
local SearchBar = require(frontend.Components.SearchBar)
local SearchRowToggle = require(frontend.Components.SearchRowToggle)
local HeadingRow = require(frontend.Components.HeadingRow)
local Icons = require(frontend.Config.Icons)
local CommandAccess = require(frontend.Util.CommandAccess)
local RoleInfoPopup = require(frontend.Components.RoleInfoPopup)
local VetToggle = require(frontend.Components.VetToggle)
local VettingState = require(frontend.Config.VettingState)
local Permissions = require(frontend.Util.Permissions)
local Remote = require(modules.Objects.Remote)
local isInternalRole = require(modules.RoleUtil.isInternalRole)
local getActiveCommands = Remote.get("GetActiveCommands")
local updateActiveCommands = Remote.get("UpdateActiveCommands")


-- TYPES
type Scope = Fusion.Scope
type Props = {
	isActive: Fusion.UsedAs<boolean>?,
	onRunPageOpen: ((commandKey: string, opts: {unlockRole: string?}?) -> ())?,
	idle: Fusion.UsedAs<boolean>?,
	filterTag: Fusion.UsedAs<string>?, -- only show commands carrying this tag
	filterRole: Fusion.UsedAs<string>?, -- only show commands this role can access (junior-inherited included)
	activeRoleFilter: Fusion.Value<string?>?, -- shared with PanelGui so RoleSettings' "View Commands" writes the same Value
	readonly: boolean?, -- hides the cmdbar toggle, disables clicks, skips active-command refresh
}
type CommandEntry = {
	key: string,
	name: string,
	args: { string },
	tags: { string }?,
	primaryRole: string?,
	directRoles: {string}?,
	roles: { string }?,
	prefix: string?,
}
type RoleSummary = {
	key: string,
	name: string,
	color: Color3,
	rank: number,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local commands = scope:Fuse("everyone", "Commands")
	local roleInfo = scope:Fuse("everyone", "RoleInfo")
	local youMember = scope:Fuse("temp", "YouMember")
	local commandPrefix = scope:Fuse("perm", {"YouSettings", "Prefix"})
	local searchText = scope:Value("")

	local activeCommands: Fusion.Value<{[string]: boolean}> = scope:Value({})
	if not props.readonly then
		local function refreshActiveCommands()
			task.defer(function()
				local success, result = getActiveCommands:invokeServerAsync()
				if type(result) == "table" then
					activeCommands:set(result)
				end
			end)
		end
		if props.isActive then
			scope:Observer(props.isActive):onChange(function()
				local val = Fusion.peek(props.isActive)
				if val then
					refreshActiveCommands()
				end
			end)
		end
		refreshActiveCommands()

		local updateConnection = updateActiveCommands:onClientEvent(function(newActiveCommands)
			if type(newActiveCommands) == "table" then
				activeCommands:set(newActiveCommands)
			end
		end)
		table.insert(scope, function()
			updateConnection:Disconnect()
		end)
	end

	local function cmdPassesSearch(cmd: CommandEntry, search: string): boolean
		if search == "" then return true end
		return cmd.name:lower():find(search, 1, true) ~= nil
	end
	local function cmdHasTag(cmd: CommandEntry, tag: string): boolean
		local cmdTags = (cmd :: any).tags
		if typeof(cmdTags) ~= "table" then return false end
		for _, cmdTag in cmdTags :: {any} do
			if cmdTag == tag then return true end
		end
		return false
	end
	local function cmdAccessibleByRole(cmd: CommandEntry, roleKey: string): boolean
		local cmdRoles = (cmd :: any).roles
		if typeof(cmdRoles) ~= "table" then return false end
		for _, cmdRoleKey in cmdRoles :: {any} do
			if cmdRoleKey == roleKey then return true end
		end
		return false
	end

	-- Keyed by command key, a server republish hands out fresh tables and keying
	-- on those reads as all-new rows, snapping the scroll back to the top
	local commandRowCache: {[string]: {fingerprint: string, row: any}} = {}
	local function getCommandRow(sectionRoleKey: string?, cmd: CommandEntry): any
		local cacheKey = (sectionRoleKey or "") .. "\0" .. tostring(cmd.key)
		local fingerprint = tostring(cmd.name) .. "\0" .. tostring((cmd :: any).prefix)
		local hit = commandRowCache[cacheKey]
		if hit and hit.fingerprint == fingerprint then
			hit.row.entry = cmd
			return hit.row
		end
		local row = {isCommandRow = true, key = cacheKey, entry = cmd, sectionRole = sectionRoleKey}
		commandRowCache[cacheKey] = {fingerprint = fingerprint, row = row}
		return row
	end

	local function buildFlat(cmds: { CommandEntry }, search: string, tagFilter: string?, roleFilter: string?): { any }
		debug.profilebegin("HD_BuildFlat")
		local result: { any } = {}
		for _, cmd in cmds do
			if tagFilter and not cmdHasTag(cmd, tagFilter) then continue end
			if roleFilter and not cmdAccessibleByRole(cmd, roleFilter) then continue end
			if not cmdPassesSearch(cmd, search) then continue end
			table.insert(result, getCommandRow(nil, cmd))
		end
		debug.profileend()
		return result
	end

	local headerCache: {[string]: any} = {}
	local function getHeader(role: RoleSummary): any
		local existing = headerCache[role.key]
		if existing and existing.name == role.name and existing.color == role.color then
			return existing
		end
		local sentinel = {
			isHeader = true,
			key = "__role_" .. role.key,
			roleKey = role.key,
			name = role.name,
			color = role.color,
		}
		headerCache[role.key] = sentinel
		return sentinel
	end

	local spacerCache: {[string]: any} = {}
	local function getSpacer(roleKey: string): any
		local existing = spacerCache[roleKey]
		if existing then return existing end
		local sentinel = { isSpacer = true, key = "__spacer_" .. roleKey }
		spacerCache[roleKey] = sentinel
		return sentinel
	end

	local youMemberFuse: any = (scope :: any):Fuse("temp", "YouMember")
	local roleInfoFuse: any = (scope :: any):Fuse("everyone", "RoleInfo")

	-- Shared with the cmdbar so the two never disagree on what's buyable
	local function bestGiverForRole(role: any): any
		return CommandAccess.bestGiverForRole(role)
	end

	local INHERITS_HINT = "Inherits commands from junior roles"
	local function roleInheritsJuniors(info: any, roleKey: any): boolean
		if typeof(info) ~= "table" or typeof(roleKey) ~= "string" then return false end
		local role = (info :: any)[roleKey]
		return typeof(role) == "table" and (role :: any).inheritCommandsFromJuniorRoles == true
	end

	local function makeUnlockStateComputed(roleKey: string): any
		if roleKey == "" then return nil end
		return scope:Computed(function(use): string?
			return CommandAccess.unlockStateForRole(use(youMemberFuse), use(roleInfoFuse), roleKey)
		end)
	end

	local function onUnlockRole(roleKey: string)
		CommandAccess.promptUnlock(Fusion.peek(roleInfoFuse), roleKey)
	end

	local activeRoleFilter: Fusion.Value<string?> = props.activeRoleFilter or scope:Value(nil)
	local scrollerRef: ScrollingFrame? = nil
	-- Restored when the filter clears, role switches leave it untouched
	local savedCanvasPosition: Vector2? = nil
	local headerRefs: {[string]: GuiObject} = {}
	-- Rank-ascending so updateStickyHeader doesn't re-sort every scroll fire
	local orderedRoleKeys: {string} = {}
	local scrollDerivedKey: Fusion.Value<string?> = scope:Value(nil)
	-- Pins the sticky during the exit transition. The per-frame scrollDerivedKey
	-- writes underneath are what nudge Roblox's layout into settling, this just
	-- hides them from the user until the retry loop finishes
	local transitionPinKey: Fusion.Value<string?> = scope:Value(nil)
	local currentStickyRoleKey: Fusion.Computed<string?> = scope:Computed(function(use)
		local pin = use(transitionPinKey)
		if pin ~= nil then return pin end
		local filter = use(activeRoleFilter)
		if filter and filter ~= "" then
			return filter
		end
		return use(scrollDerivedKey)
	end)

	local function rebuildOrderedKeys()
		local info = Fusion.peek(roleInfo)
		if typeof(info) ~= "table" then
			orderedRoleKeys = {}
			return
		end
		local list: {RoleSummary} = {}
		for _, role in info :: any do
			if isInternalRole(role) then continue end
			table.insert(list, role :: RoleSummary)
		end
		table.sort(list, function(roleA, roleB)
			if roleA.rank ~= roleB.rank then return roleA.rank < roleB.rank end
			return roleA.key < roleB.key
		end)
		local out: {string} = {}
		for _, role in list do
			table.insert(out, role.key)
		end
		orderedRoleKeys = out
	end
	rebuildOrderedKeys()

	local STICKY_LEAD = 12

	local function updateStickyHeader()
		local scroller = scrollerRef
		if not scroller then return end
		-- At the very top nothing can be stuck. Headers rebuilt after an idle teardown read AbsolutePosition 0 until their first layout pass, which faked a match here
		if scroller.CanvasPosition.Y <= 0 then
			if Fusion.peek(scrollDerivedKey) ~= nil then
				scrollDerivedKey:set(nil)
			end
			return
		end
		debug.profilebegin("HD_StickyHeader")
		local scrollTop = scroller.AbsolutePosition.Y
		local currentKey: string? = nil
		for _, key in orderedRoleKeys do
			local header = headerRefs[key]
			if not header then continue end
			if not header.Visible then continue end
			local triggerY = scrollTop + (if currentKey == nil then 0 else STICKY_LEAD)
			if header.AbsolutePosition.Y <= triggerY then
				currentKey = key
			else
				-- Headers sit in rank-ascending canvas order, so none further down can be above
				break
			end
		end
		if Fusion.peek(scrollDerivedKey) ~= currentKey then
			scrollDerivedKey:set(currentKey)
		end
		debug.profileend()
	end

	-- Defer a frame so UIListLayout repositions before we read AbsolutePosition
	local function deferredUpdateStickyHeader()
		task.spawn(function()
			task.wait()
			updateStickyHeader()
		end)
	end

	scope:Observer(roleInfo):onBind(function()
		rebuildOrderedKeys()
		deferredUpdateStickyHeader()
	end)
	scope:Observer(activeRoleFilter):onChange(deferredUpdateStickyHeader)
	scope:Observer(searchText):onChange(deferredUpdateStickyHeader)
	if props.filterRole then
		scope:Observer(props.filterRole :: any):onChange(deferredUpdateStickyHeader)
	end
	if props.filterTag then
		scope:Observer(props.filterTag :: any):onChange(deferredUpdateStickyHeader)
	end

	local roleInfoPopupVisible: Fusion.Value<boolean> = scope:Value(false)
	local roleInfoPopupRoleKey: Fusion.Value<string> = scope:Value("")
	local function openRoleInfoPopup(key: string)
		roleInfoPopupRoleKey:set(key)
		roleInfoPopupVisible:set(true)
	end

	local previousFilter: string? = Fusion.peek(activeRoleFilter)
	scope:Observer(activeRoleFilter):onChange(function()
		local newRaw = Fusion.peek(activeRoleFilter)
		local newKey: string? = if typeof(newRaw) == "string" and newRaw ~= "" then newRaw else nil
		local oldKey: string? = if typeof(previousFilter) == "string" and previousFilter ~= "" then previousFilter else nil
		previousFilter = newRaw
		if oldKey == newKey then return end

		if newKey ~= nil then
			if oldKey == nil and scrollerRef then
				savedCanvasPosition = scrollerRef.CanvasPosition
			end
			if scrollerRef then
				scrollerRef.CanvasPosition = Vector2.zero
			end
		else
			if oldKey then
				transitionPinKey:set(oldKey)
			end
			local target = savedCanvasPosition
			savedCanvasPosition = nil
			task.spawn(function()
				task.wait()
				if target and scrollerRef then
					scrollerRef.CanvasPosition = target :: Vector2
					-- Roblox refreshes AbsolutePositions one batch per frame after a
					-- CanvasPosition write, so jiggle between target-1 and target to force
					-- each pass. Down not up, target+1 clamps at the canvas bottom
					local nudgeY = math.max(0, target.Y - 1)
					for frameIndex = 1, 16 do
						task.wait()
						scrollerRef.CanvasPosition = if frameIndex % 2 == 1
							then Vector2.new(target.X, nudgeY)
							else target :: Vector2
					end
				end
				for _ = 1, 5 do
					task.wait()
					updateStickyHeader()
				end
				transitionPinKey:set(nil)
			end)
		end
	end)

	local stickyActive = scope:Computed(function(use)
		local key = use(currentStickyRoleKey)
		return key ~= nil and use(activeRoleFilter) == key
	end)

	-- A nil key hides the overlay anyway, so the placeholder entry never renders
	local stickyEntry = scope:Computed(function(use): HeadingRow.Entry
		local key = use(currentStickyRoleKey)
		if not key then
			return { key = "", name = "", color = nil }
		end
		return { key = key, name = key, color = nil }
	end)

	local stickyHeaderOverlay = scope:New "Frame" {
		Name = "StickyRoleHeader",
		AnchorPoint = Vector2.new(0, 0),
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.new(1, 0, 0, 44),
		Visible = scope:Computed(function(use)
			return use(currentStickyRoleKey) ~= nil
		end),
		[Children] = {
			-- Fills the rounded-corner pockets so content can't peek through
			scope:New "Frame" {
				Name = "BackgroundBlock",
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Theme.Color.Base,
				BorderSizePixel = 0,
				Position = UDim2.new(0.5, 0, 0, 0),
				Size = UDim2.new(1, 10, 0, 38),
			},

			HeadingRow(scope, {
				entry = stickyEntry,
				hideDrag = true,
				roleInfoFuse = roleInfo,
				active = stickyActive,
				nameFontWeight = Theme.FontWeight.Bold,
				unlockState = scope:Computed(function(use): string?
					local key = use(currentStickyRoleKey)
					if not key or key == "" then return nil end
					local you = use(youMemberFuse)
					if typeof(you) == "table" and typeof((you :: any).roleKeys) == "table" then
						for _, ownedRoleKey in (you :: any).roleKeys :: {string} do
							if ownedRoleKey == key then return "unlocked" end
						end
					end
					local info = use(roleInfoFuse)
					if typeof(info) ~= "table" then return nil end
					return if bestGiverForRole((info :: any)[key]) then "unlock" else nil
				end),
				onUnlock = onUnlockRole,
				onActivate = openRoleInfoPopup,
				hintIcon = scope:Computed(function(use): string?
					return if roleInheritsJuniors(use(roleInfoFuse), use(currentStickyRoleKey))
						then Icons.InheritJuniors
						else nil
				end),
				hintText = INHERITS_HINT,
			}),

			scope:New "Frame" {
				Name = "GapExtension",
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Theme.Color.Base,
				BorderSizePixel = 0,
				Position = UDim2.new(0.5, 0, 0, 38),
				Size = UDim2.new(1, 10, 0, 6),
			},
		},
	}

	local function buildGrouped(cmds: { CommandEntry }, search: string, info: {[string]: RoleSummary}, pinnedRoleKey: string?, you: any): { any }
		debug.profilebegin("HD_BuildGrouped")
		-- Sections render per direct grant, so a command granted to several roles
		-- appears under each of them
		local ownedRoles: {[string]: true} = {}
		if typeof(you) == "table" and typeof((you :: any).roleKeys) == "table" then
			for _, ownedKey in (you :: any).roleKeys :: {string} do
				ownedRoles[ownedKey] = true
			end
		end
		local canViewAll = CommandAccess.mayViewAll(you, info)
		local sectionVisible: {[string]: boolean} = {}
		local function isSectionVisible(roleKey: string): boolean
			local cached = sectionVisible[roleKey]
			if cached ~= nil then return cached end
			local visible = canViewAll or ownedRoles[roleKey] == true or bestGiverForRole((info :: any)[roleKey]) ~= nil
			sectionVisible[roleKey] = visible
			return visible
		end
		local buckets: {[string]: { CommandEntry }} = {}
		for _, cmd in cmds do
			local direct = (cmd :: any).directRoles
			if typeof(direct) ~= "table" then continue end
			if not cmdPassesSearch(cmd, search) then continue end
			for _, roleKey in direct :: {string} do
				if typeof(roleKey) ~= "string" or not info[roleKey] then continue end
				if pinnedRoleKey ~= nil and roleKey ~= pinnedRoleKey then continue end
				if not isSectionVisible(roleKey) then continue end
				local bucket = buckets[roleKey]
				if not bucket then
					bucket = {}
					buckets[roleKey] = bucket
				end
				table.insert(bucket, getCommandRow(roleKey, cmd))
			end
		end

		local ordered: { RoleSummary } = {}
		for _, role in info do
			if isInternalRole(role) then continue end
			if pinnedRoleKey ~= nil and role.key ~= pinnedRoleKey then continue end
			table.insert(ordered, role)
		end
		table.sort(ordered, function(roleA, roleB)
			if roleA.rank ~= roleB.rank then return roleA.rank < roleB.rank end
			return roleA.key < roleB.key
		end)

		local result: { any } = {}
		for _, role in ordered do
			local bucket = buckets[role.key]
			if not bucket or #bucket == 0 then continue end
			table.insert(result, getSpacer(role.key))
			table.insert(result, getHeader(role))
			for _, cmd in bucket do
				table.insert(result, cmd)
			end
		end
		debug.profileend()
		return result
	end

	local mayVet = Permissions.hasPermission(scope, "mayVetCommands")
	local vetting = scope:Fuse("everyone", "CommandVetting")

	local viewableCommands: Fusion.Computed<{CommandEntry}> = scope:Computed(function(use): {CommandEntry}
		debug.profilebegin("HD_BuildViewable")
		local viewable = CommandAccess.buildViewable(use(commands), use(youMember), use(roleInfo)) :: any
		debug.profileend()
		-- Disabled and pending commands never list here, even for vetters. This
		-- page only shows what the game has actually accepted
		local data = use(vetting)
		local states = if typeof(data) == "table" then (data :: any).states else nil
		if typeof(states) ~= "table" or next(states) == nil then
			return viewable
		end
		local filtered: {CommandEntry} = {}
		for _, cmd in viewable :: {any} do
			local identity = (cmd :: any).identity or (cmd :: any).key
			local status = if typeof(identity) == "string" then states[identity] else nil
			if status == "disabled" or status == "pending" then continue end
			table.insert(filtered, cmd)
		end
		return filtered
	end)

	local visibleItems: Fusion.Computed<{ any }> = scope:Computed(function(use)
		local cmds: { CommandEntry } = use(viewableCommands) :: any
		if type(cmds) ~= "table" then return {} end
		local search = use(searchText):lower()
		local tagFilter: string? = if props.filterTag then use(props.filterTag :: any) else nil
		if tagFilter == "" then tagFilter = nil end
		local roleFilter: string? = if props.filterRole then use(props.filterRole :: any) else nil
		if roleFilter == "" then roleFilter = nil end

		if tagFilter or roleFilter then
			return buildFlat(cmds, search, tagFilter, roleFilter)
		end
		local info = use(roleInfo) :: {[string]: RoleSummary}
		if typeof(info) ~= "table" then return {} end
		local activeFilter = use(activeRoleFilter)
		if activeFilter and activeFilter ~= "" then
			-- The filter only unhides rows that exist in allItems by table identity, so pick from the same grouped row objects rather than building flat ones
			local grouped = buildGrouped(cmds, search, info, nil, use(youMember))
			local filtered: { any } = {}
			for _, row in grouped do
				if (row :: any).isCommandRow == true and cmdAccessibleByRole((row :: any).entry, activeFilter) then
					table.insert(filtered, row)
				end
			end
			return filtered
		end
		return buildGrouped(cmds, search, info, nil, use(youMember))
	end)

	local allItems: Fusion.Computed<{ any }> = scope:Computed(function(use)
		local cmds: { CommandEntry } = use(viewableCommands) :: any
		if type(cmds) ~= "table" then return {} end
		local tagFilter: string? = if props.filterTag then use(props.filterTag :: any) else nil
		if tagFilter == "" then tagFilter = nil end
		local roleFilter: string? = if props.filterRole then use(props.filterRole :: any) else nil
		if roleFilter == "" then roleFilter = nil end

		if tagFilter or roleFilter then
			return buildFlat(cmds, "", tagFilter, roleFilter)
		end
		local info = use(roleInfo) :: {[string]: RoleSummary}
		if typeof(info) ~= "table" then return {} end
		return buildGrouped(cmds, "", info, nil, use(youMember))
	end)

	local CmdbarState = require(frontend.Config.CmdbarState)
	local commandBarSelected = CmdbarState.visible

	return scope:New "Frame" {
		Name = "Commands",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 0),

		[Children] = {
			scope:New "UIPadding" {
				PaddingBottom = UDim.new(0, 1),
				PaddingLeft = UDim.new(0, 1),
				PaddingRight = UDim.new(0, 1),
				PaddingTop = UDim.new(0, 1),
			},
			scope:New "UIListLayout" {
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			ScrollList(scope, {
				isReady = scope:Computed(function(use)
					local cmds = use(commands)
					return type(cmds) == "table" and next(cmds) ~= nil
				end),
				items = allItems,
				visibleItems = visibleItems,
				-- Stable string keys keep untouched rows alive across republishes,
				-- otherwise the whole list tears down and the scroll snaps to the top
				itemKey = function(item)
					return tostring((item :: any).key)
				end,
				renderItem = function(itemScope, item: any)
					if (item :: any).isSpacer == true then
						return itemScope:New "Frame" {
							Name = "RoleGroupSpacer",
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 0),
						}
					end
					if (item :: any).isHeader == true then
						local roleKey: string = (item :: any).roleKey
						local isActive = itemScope:Computed(function(use)
							return use(activeRoleFilter) == roleKey
						end)
						local roleRow = HeadingRow(itemScope, {
							entry = {
								key = roleKey,
								name = (item :: any).name,
								color = (item :: any).color,
							},
							hideDrag = true,
							roleInfoFuse = roleInfo,
							active = isActive,
							nameFontWeight = Theme.FontWeight.Bold,
							onActivate = openRoleInfoPopup,
							unlockState = makeUnlockStateComputed(roleKey),
							onUnlock = onUnlockRole,
							hintIcon = itemScope:Computed(function(use): string?
								return if roleInheritsJuniors(use(roleInfoFuse), roleKey)
									then Icons.InheritJuniors
									else nil
							end),
							hintText = INHERITS_HINT,
						})
						headerRefs[roleKey] = roleRow :: GuiObject
						table.insert(itemScope, function()
							if headerRefs[roleKey] == roleRow then
								headerRefs[roleKey] = nil
							end
							deferredUpdateStickyHeader()
						end)
						deferredUpdateStickyHeader()
						return roleRow
					end
					local sectionRole: string? = nil
					local entry = item :: CommandEntry
					if (item :: any).isCommandRow == true then
						sectionRole = (item :: any).sectionRole
						entry = (item :: any).entry :: CommandEntry
					end
					return CommandButton(itemScope, {
						commandKey = entry.key,
						commandName = entry.name,
						commandPrefix = entry.prefix,
						customPrefix = commandPrefix,
						unlockRole = sectionRole,
						activeCommands = activeCommands,
						onCommandActivate = if props.readonly == true
							then nil
							elseif props.onRunPageOpen
								then function() (props.onRunPageOpen :: (string, any?) -> ())(entry.key, if sectionRole then {unlockRole = sectionRole} else nil) end
								else nil,
					})
				end,
				padding = UDim.new(0, 8),
				layoutOrder = 1,
				paddingRight = 10,
				idle = props.idle,
				headerGap = UDim.new(0, 8),
				overlay = stickyHeaderOverlay,
				onScrollerReady = function(scroller: ScrollingFrame)
					scrollerRef = scroller
					local conn = scroller:GetPropertyChangedSignal("CanvasPosition"):Connect(updateStickyHeader)
					table.insert(scope, function() conn:Disconnect() end)
					-- A filter already set at mount snaps to the top of the filtered view
					local initial = Fusion.peek(activeRoleFilter)
					if initial and initial ~= "" then
						scroller.CanvasPosition = Vector2.zero
					end
					deferredUpdateStickyHeader()
				end,
				header = scope:New "Frame" {
					Name = "HeaderArea",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					LayoutOrder = 0,
					Size = UDim2.fromScale(1, 0),
					[Children] = {
						scope:New "UIListLayout" {
							HorizontalFlex = Enum.UIFlexAlignment.Fill,
							SortOrder = Enum.SortOrder.LayoutOrder,
						},
						scope:New "Frame" {
							Name = "StickySpacer",
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							LayoutOrder = 1,
							Size = scope:Computed(function(use)
								local filter = use(activeRoleFilter)
								local active = filter ~= nil and filter ~= ""
								return UDim2.new(1, 0, 0, if active then 44 else 0)
							end),
						},
						SearchBar(scope, {
							searchText = searchText,
							placeholderText = "Search",
							layoutOrder = 2,
							gap = UDim.new(0, 8), -- matches the toggle gap so all three read evenly spaced
							slot = if props.readonly == true then nil else scope:New "Frame" {
								Name = "SearchToggles",
								AutomaticSize = Enum.AutomaticSize.X,
								BackgroundTransparency = 1,
								Size = UDim2.fromScale(0, 1),
								[Children] = {
									scope:New "UIListLayout" {
										FillDirection = Enum.FillDirection.Horizontal,
										VerticalAlignment = Enum.VerticalAlignment.Center,
										Padding = UDim.new(0, 8),
										SortOrder = Enum.SortOrder.LayoutOrder,
									},
									-- Always visible to vetters so they can revisit decisions
									VetToggle(scope, {
										isActive = false,
										isVisible = mayVet,
										layoutOrder = 1,
										onActivate = function()
											VettingState.open()
										end,
									}),
									SearchRowToggle(scope, {
										name = "CommandBarToggle",
										icon = Icons.CmdbarDeselected,
										activeIcon = Icons.CmdbarSelected,
										isActive = commandBarSelected,
										isVisible = CmdbarState.canOpen,
										layoutOrder = 2,
										onActivate = function()
											CmdbarState.toggle()
										end,
									}),
								},
							},
							slotVisible = scope:Computed(function(use)
								if props.readonly == true then return false end
								local filter = use(activeRoleFilter)
								if filter ~= nil and filter ~= "" then return false end
								return use(CmdbarState.canOpen) or use(mayVet)
							end),
						}),
					},
				},
			}),

			-- The Folder keeps the popup out of the UIListLayout, otherwise it stacks as a list entry and squashes the ScrollList to a sliver at the bottom
			scope:New "Folder" {
				Name = "RoleInfoPopupHolder",
				[Children] = {
					RoleInfoPopup(scope, {
						visible = roleInfoPopupVisible,
						roleKey = roleInfoPopupRoleKey,
						roleInfoFuse = roleInfo,
						youMemberFuse = youMember,
						commandsFuse = commands,
					}),
				},
			},
		},
	}
end
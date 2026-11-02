--!strict
-- LOCAL FIRST
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local Icons = require(frontend.Config.Icons)


-- CONFIG
local TAB_DEFS: { TabBar.Tab } = {
	{ label = "Members", icon = Icons.ShieldPersonFill },
	{ label = "Roles", icon = Icons.TagFill },
}


-- LOCAL
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local UserDetails = require(frontend.Components.UserDetails)
local SplitRow = require(frontend.Components.SplitRow)
local TabBar = require(frontend.Components.TabBar)
local UnderscoreTabBar = require(frontend.Components.UnderscoreTabBar)
local TabbedScroller = require(frontend.Components.TabbedScroller)
local Pressable = require(frontend.Components.Pressable)
local SearchRowToggle = require(frontend.Components.SearchRowToggle)
local InlineToggleRow = require(frontend.Components.InlineToggleRow)
local LoadingSpinner = require(frontend.Components.LoadingSpinner)
local HeadingRow = require(frontend.Components.HeadingRow)
local StreamList = require(frontend.Components.StreamList)
local SearchBar = require(frontend.Components.SearchBar)
local LoadingGate = require(frontend.Components.LoadingGate)
local Givers = require(frontend.Util.extractGivers)
local stableRows = require(frontend.Util.stableRows)
local Permissions = require(frontend.Util.Permissions)
local isInternalRole = require(modules.RoleUtil.isInternalRole)
local NoPermissionPlaceholder = require(frontend.Components.NoPermissionPlaceholder)
local ScrollLock = require(frontend.Util.ScrollLock)
local Remote = require(modules.Objects.Remote)
local clientUser = require(modules.References.clientUser)
local Children = Fusion.Children
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local _activeDragOnMove: ((InputObject) -> ())? = nil
local _activeDragOnEnd: ((InputObject) -> ())? = nil
local _dragListenersConnected = false
local _dragStartFrame: number = 0
local _frameCount: number = 0


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type RoleEntry = {
	key: string,
	name: string,
	hide: boolean?,
	color: Color3?,
}
type Member = {
	userId: number,
	userName: string,
	userDisplayName: string,
	userImage: string,
	roleKeys: {string},
}
type Props = {
	onRoleActivate: UsedAs<(roleKey: string) -> ()>?,
	onMemberActivate: UsedAs<(userId: number) -> ()>?,
	onRoleCreate: (() -> ())?,
	onRunPageOpen: ((commandKey: string, opts: {autoOpenUserArg: boolean?}?) -> ())?, -- the Permanent "+" launching ;givePermRole
	onGiverActivate: ((giver: any) -> ())?, -- opens Profile in read-only giver mode
}


-- LOCAL FUNCTIONS
-- Fingerprints cover exactly what a row renders, so only changed rows rebuild
local function roleKeysFingerprint(roleInfo: any, roleKeys: {string}): string
	local parts: {string} = {}
	for _, roleKey in roleKeys do
		local role = if typeof(roleInfo) == "table" then (roleInfo :: any)[roleKey] else nil
		local marker = ""
		if typeof(role) == "table" then
			marker = if isInternalRole(role) then "x"
				elseif typeof((role :: any).color) == "Color3" then (role :: any).color:ToHex()
				else ""
		end
		table.insert(parts, roleKey .. marker)
	end
	return table.concat(parts, ",")
end

local function memberFingerprint(roleInfo: any, member: Member): string
	return `{member.userId}|{member.userName}|{member.userDisplayName}|{roleKeysFingerprint(roleInfo, member.roleKeys)}`
end

local function giverFingerprint(roleInfo: any, giver: any): string
	return `{giver.type}|{giver.id}|{giver.name}|{roleKeysFingerprint(roleInfo, giver.roleKeys)}`
end

local function memberItemKey(item: any): string
	local entry = item :: any
	if entry.isGiver then
		return `giver:{(entry.giver :: any).type}:{(entry.giver :: any).id}`
	end
	return `member:{(entry.member :: any).userId}`
end

local function ensureDragListeners()
	if _dragListenersConnected then return end
	_dragListenersConnected = true
	local RunService = game:GetService("RunService")
	RunService.Heartbeat:Connect(function()
		_frameCount += 1
	end)

	UserInputService.InputChanged:Connect(function(input: InputObject)
		local callback = _activeDragOnMove
		if callback and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch) then
			callback(input)
		end
	end)
	UserInputService.InputEnded:Connect(function(input: InputObject)
		local callback = _activeDragOnEnd
		if callback and (input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch) then
			callback(input)
		end
	end)
	-- Any new press while dragging forces end, skipping the frame that started it
	UserInputService.InputBegan:Connect(function(input: InputObject)
		if _frameCount <= _dragStartFrame then return end
		local callback = _activeDragOnEnd
		if callback and (input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch) then
			callback(input)
		end
	end)
	UserInputService.WindowFocusReleased:Connect(function()
		local callback = _activeDragOnEnd
		if callback then
			callback(nil :: any)
		end
	end)
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local rolesRaw = scope:Fuse("everyone", "Roles")
	local defaultRoleInfoRaw = scope:Fuse("everyone", "DefaultRoleInfo")
	-- The server builds these with the USD=false overlay applied, so USD-off preview
	-- renders correct names even when committed USD is on
	local savedRolesRaw = scope:Fuse("everyone", "SavedRoles")
	local savedRoleInfoRaw = scope:Fuse("everyone", "SavedRoleInfo")
	local useDefaultRolesFuse: any = (scope :: any):Fuse("everyone", {"GameSettings", "SystemSettings", "UseDefaultRoles"})

	local isRolesReady: Fusion.Computed<boolean> = scope:Computed(function(use)
		local raw = use(rolesRaw)
		return typeof(raw) == "table"
	end)

	-- When this differs from the committed fuse, the display previews the target
	-- state without committing
	local localUseDefaultRoles: Fusion.Value<boolean> = scope:Value(Fusion.peek(useDefaultRolesFuse) == true)

	-- The reactive source of truth for the displayed role set, updated in lockstep
	-- with localKeys
	local localKeysValue: Fusion.Value<{string}> = scope:Value({})

	local roles = scope:Computed(function(use)
		local keys = use(localKeysValue)
		local localUsd = use(localUseDefaultRoles) == true
		local savedList = use(savedRolesRaw)
		local defaults = use(defaultRoleInfoRaw)
		-- USD-on preview wants defaults back (tombstoned ones reappear), USD-off
		-- wants the saved view
		local savedLookup: {[string]: any} = {}
		if typeof(savedList) == "table" then
			for _, entry in savedList :: {any} do
				if typeof(entry) == "table" and typeof(entry.key) == "string" then
					savedLookup[entry.key] = entry
				end
			end
		end
		local out: {RoleEntry} = {}
		for _, key in keys do
			local entry: any
			if localUsd then
				if typeof(defaults) == "table" then
					local data = (defaults :: any)[key]
					if typeof(data) == "table" then
						entry = { key = key, name = data.name or key, color = data.color, hide = data.hide }
					end
				end
			else
				entry = savedLookup[key]
				if entry == nil and typeof(defaults) == "table" then
					local data = (defaults :: any)[key]
					if typeof(data) == "table" then
						entry = { key = key, name = data.name or key, color = data.color, hide = data.hide }
					end
				end
			end
			if typeof(entry) == "table" and entry.hide ~= true then
				table.insert(out, entry :: RoleEntry)
			end
		end
		-- Pre-first-sync fallback so the initial render isn't empty
		if #out == 0 and #keys == 0 and typeof(savedList) == "table" then
			for _, entry in savedList :: {any} do
				if typeof(entry) == "table" and entry.hide ~= true and not isInternalRole(entry) then
					table.insert(out, entry :: RoleEntry)
				end
			end
		end
		return out
	end)
	local onRoleActivate = props.onRoleActivate
	local onMemberActivate = props.onMemberActivate

	local youMemberFuse: any = (scope :: any):Fuse("temp", "YouMember")
	local serverMembersFuse: any = (scope :: any):Fuse("everyone", "ServerMembers")
	local permanentMembersFuse: any = (scope :: any):Fuse("everyone", "PermanentMembers")
	local roleInfoFuse: any = (scope :: any):Fuse("everyone", "RoleInfo")
	local localUserId = Players.LocalPlayer.UserId

	-- Warm the command info on mount so the first "+" press opens the picker instantly
	if props.onRunPageOpen then
		task.spawn(function()
			clientUser.everyone:fetchAsync("CommandInfo", "givepermrole")
		end)
	end

	local reuseServerRow, sweepServerRows = stableRows()
	local reusePermanentRow, sweepPermanentRows = stableRows()

	local function topRankOfKeys(roleInfo: any, roleKeys: {string}): number
		local top = 0
		local seen = false
		if typeof(roleInfo) == "table" and typeof(roleKeys) == "table" then
			for _, roleKey in roleKeys do
				local role = (roleInfo :: any)[roleKey]
				if typeof(role) == "table" and typeof((role :: any).rank) == "number" then
					local rank = (role :: any).rank
					if not seen or rank > top then
						top = rank
						seen = true
					end
				end
			end
		end
		return top
	end

	local serverMembersItems: any = scope:Computed(function(use): {any}
		local server = use(serverMembersFuse)
		local roleInfo = use(roleInfoFuse)
		local list: {Member} = {}
		if typeof(server) == "table" then
			for _, member in server :: any do
				if typeof(member) == "table" and typeof((member :: any).userId) == "number" then
					table.insert(list, member :: Member)
				end
			end
			table.sort(list, function(memberA, memberB)
				return (memberA.userDisplayName or "") < (memberB.userDisplayName or "")
			end)
		end
		local out: {any} = {}
		for _, member in list do
			table.insert(out, reuseServerRow(`member:{member.userId}`, memberFingerprint(roleInfo, member), function()
				return { isMember = true, sectionKey = "Server", member = member }
			end))
		end
		sweepServerRows()
		return out
	end)

	local permanentMembersItems: any = scope:Computed(function(use): {any}
		-- Givers collapse on type:id so one group on multiple roles shows as one entry
		local roleInfo = use(roleInfoFuse)
		local out: {any} = {}

		local givers = Givers.extract(roleInfo)
		table.sort(givers, function(giverA, giverB)
			local rankA = topRankOfKeys(roleInfo, giverA.roleKeys)
			local rankB = topRankOfKeys(roleInfo, giverB.roleKeys)
			if rankA ~= rankB then return rankA > rankB end
			return (giverA.name or "") < (giverB.name or "")
		end)
		for _, giver in givers do
			table.insert(out, reusePermanentRow(`giver:{giver.type}:{giver.id}`, giverFingerprint(roleInfo, giver), function()
				return { isGiver = true, sectionKey = "Permanent", giver = giver }
			end))
		end

		local permanent = use(permanentMembersFuse)
		local list: {Member} = {}
		if typeof(permanent) == "table" then
			for _, member in permanent :: any do
				if typeof(member) == "table" and typeof((member :: any).userId) == "number" then
					table.insert(list, member :: Member)
				end
			end
			table.sort(list, function(memberA, memberB)
				local rankA = topRankOfKeys(roleInfo, memberA.roleKeys)
				local rankB = topRankOfKeys(roleInfo, memberB.roleKeys)
				if rankA ~= rankB then return rankA > rankB end
				return (memberA.userDisplayName or "") < (memberB.userDisplayName or "")
			end)
		end
		for _, member in list do
			table.insert(out, reusePermanentRow(`member:{member.userId}`, memberFingerprint(roleInfo, member), function()
				return { isMember = true, sectionKey = "Permanent", member = member }
			end))
		end
		sweepPermanentRows()
		return out
	end)

	local serverSearchText: Fusion.Value<string> = scope:Value("")
	local permanentSearchText: Fusion.Value<string> = scope:Value("")
	local function filterMembersByText(items: {any}, query: string): {any}
		local loweredQuery = string.lower(query)
		if loweredQuery == "" then return items end
		local out: {any} = {}
		for _, item in items do
			local entry = item :: any
			if entry.isGiver then
				local giver: any = entry.giver
				if typeof(giver) ~= "table" then continue end
				local name = string.lower((giver :: any).name or "")
				local id = string.lower((giver :: any).id or "")
				if string.find(name, loweredQuery, 1, true) or string.find(id, loweredQuery, 1, true) then
					table.insert(out, item)
				end
			elseif entry.isMember then
				local member: any = entry.member
				if typeof(member) ~= "table" then continue end
				local name: string = string.lower((member :: any).userName or "")
				local display: string = string.lower((member :: any).userDisplayName or "")
				if string.find(name, loweredQuery, 1, true) or string.find(display, loweredQuery, 1, true) then
					table.insert(out, item)
				end
			end
		end
		return out
	end
	local serverVisibleItems: any = scope:Computed(function(use)
		return filterMembersByText(use(serverMembersItems), use(serverSearchText))
	end)
	local permanentVisibleItems: any = scope:Computed(function(use)
		return filterMembersByText(use(permanentMembersItems), use(permanentSearchText))
	end)

	-- Tabs always render, a denied tab swaps its content for a placeholder
	local canViewMembersServer = Permissions.canViewPage(scope, "MembersServer")
	local canViewMembersPermanent = Permissions.canViewPage(scope, "MembersPermanent")
	local canViewRoles = Permissions.canViewPage(scope, "Roles")

	local previewingRolesFuse: any = (scope :: any):Fuse("temp", "PreviewingRoles")
	local mayPreviewAny = scope:Computed(function(use): boolean
		local you = use(youMemberFuse)
		local info = use(roleInfoFuse)
		if typeof(you) ~= "table" or typeof(info) ~= "table" then return false end
		local keys: any = (you :: any).roleKeys
		if typeof(keys) ~= "table" then return false end
		for _, key in keys :: {string} do
			local role: any = (info :: any)[key]
			if typeof(role) == "table" and (role :: any).mayPreviewRoles == true then return true end
		end
		return false
	end)
	local youTopRank = scope:Computed(function(use): number
		local you = use(youMemberFuse)
		local info = use(roleInfoFuse)
		if typeof(you) ~= "table" or typeof(info) ~= "table" then return 0 end
		local keys: any = (you :: any).roleKeys
		if typeof(keys) ~= "table" then return 0 end
		local best = 0
		for _, key in keys :: {string} do
			local role: any = (info :: any)[key]
			if typeof(role) == "table" and typeof((role :: any).rank) == "number" then
				if (role :: any).rank > best then best = (role :: any).rank end
			end
		end
		return best
	end)
	-- Staged client-side. Instant preview could lock the caller out of this page
	-- if the previewed role can't view it, so nothing commits until the ConfirmBar
	local function snapshotServerPreview(): {string}
		local list = Fusion.peek(previewingRolesFuse)
		local out: {string} = {}
		if typeof(list) == "table" then
			for _, key in list :: {string} do
				if typeof(key) == "string" then table.insert(out, key) end
			end
		end
		return out
	end
	local pendingPreviewKeys: Fusion.Value<{string}> = scope:Value(snapshotServerPreview())
	scope:Observer(previewingRolesFuse):onChange(function()
		pendingPreviewKeys:set(snapshotServerPreview())
	end)
	task.defer(function()
		pendingPreviewKeys:set(snapshotServerPreview())
	end)

	local previewingSet = scope:Computed(function(use): {[string]: boolean}
		local list = use(pendingPreviewKeys)
		local out: {[string]: boolean} = {}
		for _, key in list do out[key] = true end
		return out
	end)

	local hasPendingPreview = scope:Computed(function(use): boolean
		local pending = use(pendingPreviewKeys)
		local serverList = use(previewingRolesFuse)
		local serverArr: {string} = if typeof(serverList) == "table" then serverList :: {string} else {}
		if #pending ~= #serverArr then return true end
		local serverSet: {[string]: boolean} = {}
		for _, key in serverArr do serverSet[key] = true end
		for _, key in pending do
			if not serverSet[key] then return true end
		end
		return false
	end)

	local setPreviewingRemote = Remote.get("SetPreviewingRoles")
	local clearPreviewingRemote = Remote.get("ClearPreviewingRoles")

	-- mayPreviewAny is checked first so both eye states vanish when previewing as a
	-- role without mayPreviewRoles. The PreviewBanner's Exit is the escape hatch
	local function makePreviewStateComputed(rowScope: Fusion.Scope, entry: RoleEntry)
		return rowScope:Computed(function(use): string?
			if not use(mayPreviewAny) then return nil end
			if use(previewingSet)[entry.key] then return "active" end
			local info = use(roleInfoFuse)
			local roleData = if typeof(info) == "table" then (info :: any)[entry.key] else nil
			local targetRank = if typeof(roleData) == "table" and typeof((roleData :: any).rank) == "number"
				then (roleData :: any).rank else 0
			if use(youTopRank) <= targetRank then return nil end
			return "inactive"
		end)
	end

	local function onPreviewToggle(roleKey: string)
		local current = Fusion.peek(pendingPreviewKeys)
		local newList: {string} = {}
		local wasPending = false
		for _, key in current do
			if key == roleKey then
				wasPending = true
			else
				table.insert(newList, key)
			end
		end
		if not wasPending then
			table.insert(newList, roleKey)
		end
		pendingPreviewKeys:set(newList)
	end

	-- An empty pending list uses the dedicated Clear remote to keep the log surface clean
	local function confirmPreview()
		local pending = Fusion.peek(pendingPreviewKeys)
		if #pending == 0 then
			task.spawn(function()
				(clearPreviewingRemote :: any):invokeServerAsync()
			end)
		else
			task.spawn(function()
				local ok, reason = (setPreviewingRemote :: any):invokeServerAsync(pending)
				if not ok then
					local Prompt = require(modules.Prompt)
					Prompt.error(tostring(reason or "Failed to enter preview"))
				end
			end)
		end
	end
	local function cancelPreview()
		pendingPreviewKeys:set(snapshotServerPreview())
	end

	local MEMBERS_SUBTAB_LABELS = { "Server", "Permanent" }
	local membersSubTabs: { TabBar.Tab } = {
		{ label = "Server" },
		{ label = "Permanent" },
	}

	local activeMembersSubTab: Fusion.Value<number> = scope:Value(1)

	local activeMembersSubTabLabel = scope:Computed(function(use): string
		local idx = use(activeMembersSubTab)
		return MEMBERS_SUBTAB_LABELS[idx] or ""
	end)

	local outerActiveTab: Fusion.Value<number> = scope:Value(1)

	local changeGameSetting = Remote.get("ChangeGameSetting")
	local changeRoleSetting = Remote.get("ChangeRoleSetting")
	local changeRolesOrder = Remote.get("ChangeRolesOrder")
	local localKeys: {string} = {}
	local originalKeys: {string} = {}
	local function setLocalKeys(newKeys: {string})
		localKeys = newKeys
		localKeysValue:set(table.clone(newKeys))
	end
	local function syncLocalKeysValue()
		localKeysValue:set(table.clone(localKeys))
	end
	local layoutOrders: {[string]: Fusion.Value<number>} = {}
	local hasPendingChanges: Fusion.Value<boolean> = scope:Value(false)
	local pendingOrderChange: {string}? = nil -- full ordered keys list if order changed
	local pendingUseDefaultRoles: boolean? = nil -- GameSettings.UseDefaultRoles change
	local savedKeysBeforeDefaults: {string}? = nil -- saved order before toggling defaults on
	local ROW_GAP = 8

	local function getLayoutOrder(key: string): Fusion.Value<number>
		if not layoutOrders[key] then
			layoutOrders[key] = scope:Value(1)
		end
		return layoutOrders[key]
	end

	local function syncLayoutOrders()
		for index, key in localKeys do
			local lo = getLayoutOrder(key)
			if Fusion.peek(lo) ~= index then
				lo:set(index)
			end
		end
	end

	local function findKeyIndex(key: string): number
		for index, existingKey in localKeys do
			if existingKey == key then return index end
		end
		return 1
	end

	local function getDefaultKeys(): {string}
		local defaults = Fusion.peek(defaultRoleInfoRaw)
		if typeof(defaults) ~= "table" then return {} end
		local entries: {{key: string, rank: number}} = {}
		for key, data in defaults :: any do
			if typeof(data) == "table" and data.hide ~= true and not isInternalRole(data) then
				table.insert(entries, { key = key, rank = if typeof(data.rank) == "number" then data.rank else 1 })
			end
		end
		table.sort(entries, function(entryA, entryB) return entryA.rank > entryB.rank end)
		local keys: {string} = {}
		for _, entry in entries do
			table.insert(keys, entry.key)
		end
		return keys
	end

	-- originalKeys is the saved committed order, localKeys is the displayed order
	local function getSavedKeys(): {string}
		local raw = Fusion.peek(savedRolesRaw)
		local out: {string} = {}
		if typeof(raw) == "table" then
			for _, entry in raw :: {any} do
				if typeof(entry) == "table" and typeof(entry.key) == "string" and entry.hide ~= true and not isInternalRole(entry) then
					table.insert(out, entry.key)
				end
			end
		end
		return out
	end

	local function syncFromFused()
		if Fusion.peek(hasPendingChanges) then return end
		originalKeys = getSavedKeys()
		if Fusion.peek(localUseDefaultRoles) then
			setLocalKeys(getDefaultKeys())
		else
			setLocalKeys(getSavedKeys())
		end
		syncLayoutOrders()
	end
	scope:Observer(savedRolesRaw):onChange(syncFromFused)
	syncFromFused()
	scope:Observer(defaultRoleInfoRaw):onChange(syncFromFused)
	scope:Observer(useDefaultRolesFuse):onChange(function()
		if Fusion.peek(hasPendingChanges) then return end
		localUseDefaultRoles:set(Fusion.peek(useDefaultRolesFuse) == true)
		syncFromFused()
	end)

	local rowCache: {[string]: Instance} = {}

	local dragKey = ""
	local rolesListInstance: Frame? = nil
	local measuredRowHeight: number = 44
	local dragOverlay: ScreenGui? = nil
	local dragClone: Frame? = nil
	local draggedWrapper: Frame? = nil
	local dragOffsetY: number = 0
	local dragOffsetX: number = 0
	local dragOriginalTransparencies: {[Instance]: {[string]: number}} = {}
	local firstRoleAbsY: number = 0
	-- Lowest index the drag can land at, senior-or-peer rows can't be overtaken
	local dragMinTargetIdx: number = 1

	local computePendingChanges: () -> ()

	local function cleanupDrag()
		for inst, savedProps in dragOriginalTransparencies do
			for prop, val in savedProps do
				(inst :: any)[prop] = val
			end
		end
		table.clear(dragOriginalTransparencies)
		draggedWrapper = nil
		local playerGui = Players.LocalPlayer and Players.LocalPlayer:FindFirstChild("PlayerGui")
		if playerGui then
			for _, child in playerGui:GetChildren() do
				if child.Name == "DragOverlay" then
					child:Destroy()
				end
			end
		end
		dragOverlay = nil
		dragClone = nil
		local wasDragging = dragKey ~= ""
		dragKey = ""
		_activeDragOnMove = nil
		_activeDragOnEnd = nil
		ScrollLock.unlock()
		if wasDragging then
			computePendingChanges()
		end
	end

	table.insert(scope, cleanupDrag)

	ensureDragListeners()

	local function onDragMove(input: InputObject)
		if dragKey == "" then return end
		if dragClone then
			dragClone.Position = UDim2.fromOffset(
				input.Position.X - dragOffsetX,
				input.Position.Y - dragOffsetY
			)
		end
		if not rolesListInstance then return end
		local listY = firstRoleAbsY
		local cursorY = input.Position.Y
		local step = measuredRowHeight + ROW_GAP
		local currentIdx = findKeyIndex(dragKey)
		-- A junior can't drop into a senior-or-peer slot, matching the server check
		local targetIdx = math.clamp(
			math.floor((cursorY - listY + step / 2) / step) + 1,
			dragMinTargetIdx, #localKeys
		)
		if targetIdx ~= currentIdx then
			table.remove(localKeys, currentIdx)
			table.insert(localKeys, targetIdx, dragKey)
			syncLocalKeysValue()
			syncLayoutOrders()
		end
	end

	computePendingChanges = function()
		local info = Fusion.peek(savedRoleInfoRaw)
		if typeof(info) ~= "table" then return end

		-- A drag under USD-on is remembered in savedKeysBeforeDefaults and applies
		-- when defaults toggles off
		pendingOrderChange = nil
		local keysForOrder: {string}? = nil
		if Fusion.peek(localUseDefaultRoles) then
			keysForOrder = savedKeysBeforeDefaults
		else
			keysForOrder = localKeys
		end
		if keysForOrder then
			local differsFromOriginal = #keysForOrder ~= #originalKeys
			if not differsFromOriginal then
				for index, key in keysForOrder do
					if originalKeys[index] ~= key then
						differsFromOriginal = true
						break
					end
				end
			end
			if differsFromOriginal then
				pendingOrderChange = table.clone(keysForOrder)
			end
		end

		local currentServerValue = Fusion.peek(useDefaultRolesFuse) == true
		local localValue = Fusion.peek(localUseDefaultRoles)
		if localValue ~= currentServerValue then
			pendingUseDefaultRoles = localValue
		else
			pendingUseDefaultRoles = nil
		end

		local hasChanges = pendingOrderChange ~= nil or pendingUseDefaultRoles ~= nil
		hasPendingChanges:set(hasChanges)
	end

	local function toggleUseDefaultRoles()
		local newValue = not Fusion.peek(localUseDefaultRoles)
		localUseDefaultRoles:set(newValue)
		if newValue then
			savedKeysBeforeDefaults = table.clone(localKeys)
			setLocalKeys(getDefaultKeys())
			syncLayoutOrders()
		else
			if savedKeysBeforeDefaults then
				setLocalKeys(table.clone(savedKeysBeforeDefaults))
				savedKeysBeforeDefaults = nil
			else
				-- No snapshot on the first USD-off toggle, so derive the saved view
				setLocalKeys(getSavedKeys())
			end
			syncLayoutOrders()
		end
		computePendingChanges()
	end

	local function confirmChanges()
		if pendingOrderChange then
			local orderToSend = pendingOrderChange
			task.spawn(function()
				local success, err = (changeRolesOrder :: any):invokeServerAsync(orderToSend)
				if not success then
					local Prompt = require(modules.Prompt)
					Prompt.warn(tostring(err or "Failed to save roles order"))
				end
			end)
			pendingOrderChange = nil
		end
		if pendingUseDefaultRoles ~= nil then
			local toSend = pendingUseDefaultRoles
			task.spawn(function()
				pcall(function()
					return (changeGameSetting :: any):invokeServerAsync({"SystemSettings", "UseDefaultRoles"}, toSend)
				end)
			end)
			pendingUseDefaultRoles = nil
		end
		hasPendingChanges:set(false)
		if Fusion.peek(localUseDefaultRoles) and savedKeysBeforeDefaults then
			-- The drag order committed alongside defaults, so original follows it
			originalKeys = table.clone(savedKeysBeforeDefaults)
			savedKeysBeforeDefaults = nil
		elseif not Fusion.peek(localUseDefaultRoles) then
			originalKeys = table.clone(localKeys)
		end
	end

	local function undoChanges()
		setLocalKeys(table.clone(originalKeys))
		syncLayoutOrders()
		pendingOrderChange = nil
		pendingUseDefaultRoles = nil
		savedKeysBeforeDefaults = nil
		localUseDefaultRoles:set(Fusion.peek(useDefaultRolesFuse) == true)
		hasPendingChanges:set(false)
	end

	local function onDragEnd(_input: InputObject)
		cleanupDrag()
	end

	local function startDrag(key: string, handleInstance: Instance, cursorY: number, cursorX: number)
		if Fusion.peek(localUseDefaultRoles) then return end
		-- Rank is enforced uniformly, mayEditAll does not bypass it so the top role
		-- stays put. One-shot peek to avoid leaking a Computed per drag start
		dragMinTargetIdx = 1
		do
			local you: any = clientUser.temp:get("YouMember")
			local info: any = clientUser.everyone:get("RoleInfo")
			if typeof(you) == "table" and typeof(info) == "table" then
				local myKeys: any = (you :: any).roleKeys
				if typeof(myKeys) == "table" then
					local hasEditRoles = false
					local myTop = 0
					for _, rk in myKeys :: {string} do
						local role: any = (info :: any)[rk]
						if typeof(role) == "table" then
							local rank: number = if typeof((role :: any).rank) == "number" then (role :: any).rank else 0
							if rank > myTop then myTop = rank end
							-- mayEditAll umbrella-covers mayEditRoles, so this single check is enough
							if (role :: any).mayEditRoles == true or (role :: any).mayEditAll == true then hasEditRoles = true end
						end
					end
					if not hasEditRoles then return end
					local target: any = (info :: any)[key]
					local targetRank: number = if typeof(target) == "table" and typeof((target :: any).rank) == "number"
						then (target :: any).rank else 0
					if myTop <= targetRank then return end
					local seniorOrPeerCount = 0
					for _, otherKey in localKeys do
						local role: any = (info :: any)[otherKey]
						local rank: number = if typeof(role) == "table" and typeof((role :: any).rank) == "number"
							then (role :: any).rank else 0
						if rank >= myTop then seniorOrPeerCount += 1 end
					end
					dragMinTargetIdx = seniorOrPeerCount + 1
				end
			end
		end
		if dragKey ~= "" then
			cleanupDrag()
		end
		_dragStartFrame = _frameCount
		dragKey = key
		if #localKeys > 0 then
			local firstWrapper = rowCache[localKeys[1]]
			if firstWrapper and firstWrapper:IsA("GuiObject") then
				measuredRowHeight = firstWrapper.AbsoluteSize.Y
				firstRoleAbsY = firstWrapper.AbsolutePosition.Y
			end
		end
		_activeDragOnMove = onDragMove
		_activeDragOnEnd = onDragEnd
		ScrollLock.lock(handleInstance)

		local wrapper = rowCache[key]
		if not wrapper then return end
		draggedWrapper = wrapper
		local innerRow: Frame? = nil
		for _, child in wrapper:GetChildren() do
			if child:IsA("Frame") and child.Name:sub(1, 11) == "HeadingRow_" then
				innerRow = child :: Frame
				break
			end
		end
		if not innerRow then return end

		dragOffsetX = cursorX - innerRow.AbsolutePosition.X
		dragOffsetY = cursorY - innerRow.AbsolutePosition.Y
		local rowWidth = innerRow.AbsoluteSize.X
		local rowHeight = innerRow.AbsoluteSize.Y

		local playerGui = Players.LocalPlayer and Players.LocalPlayer:FindFirstChild("PlayerGui")
		if not playerGui then return end
		dragOverlay = Instance.new("ScreenGui")
		dragOverlay.Name = "DragOverlay"
		dragOverlay.DisplayOrder = 999
		dragOverlay.IgnoreGuiInset = false
		dragOverlay.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		dragOverlay.Parent = playerGui

		dragClone = innerRow:Clone()
		dragClone.Size = UDim2.fromOffset(rowWidth, rowHeight)
		dragClone.AutomaticSize = Enum.AutomaticSize.None
		dragClone.Position = UDim2.fromOffset(cursorX - dragOffsetX, cursorY - dragOffsetY)
		dragClone.Parent = dragOverlay

		local shadow = Instance.new("UIStroke")
		shadow.Name = "DragShadow"
		shadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		shadow.Color = Color3.new(0, 0, 0)
		shadow.Transparency = 0.7
		shadow.Thickness = 3
		shadow.Parent = dragClone

		table.clear(dragOriginalTransparencies)
		dragOriginalTransparencies[innerRow] = { BackgroundTransparency = innerRow.BackgroundTransparency }
		innerRow.BackgroundTransparency = 0.85
		for _, desc in innerRow:GetDescendants() do
			if desc:IsA("TextLabel") then
				dragOriginalTransparencies[desc] = { TextTransparency = desc.TextTransparency }
				desc.TextTransparency = 0.85
			elseif desc:IsA("ImageLabel") then
				dragOriginalTransparencies[desc] = { ImageTransparency = desc.ImageTransparency }
				desc.ImageTransparency = 0.85
			elseif desc:IsA("Frame") then
				dragOriginalTransparencies[desc] = { BackgroundTransparency = desc.BackgroundTransparency }
				desc.BackgroundTransparency = math.max(desc.BackgroundTransparency, 0.85)
			end
		end
	end

	local function ensureRow(entry: RoleEntry): Instance
		if rowCache[entry.key] then return rowCache[entry.key] end
		local lo = getLayoutOrder(entry.key)
		local previewState = makePreviewStateComputed(scope, entry)
		-- Same source of truth as the server ChangeRolesOrder check so the UI matches what saves
		local canEditThisRole = Permissions.canEditRoleByKey(scope, entry.key)
		local hasEditRolesPerm = Permissions.hasPermission(scope, "mayEditRoles")
		local hideDragForRow = scope:Computed(function(use)
			if use(localUseDefaultRoles) == true then return true end
			return use(canEditThisRole) ~= true
		end)
		local wrapper = scope:New "Frame" {
			Name = "RoleEntry_" .. entry.key,
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = lo,
			Size = UDim2.new(1, 0, 0, 0),
			[Children] = {
				HeadingRow(scope, {
					entry = entry,
					onActivate = function(key: string)
						-- A read-only role settings view would be meaningless, so block and warn
						if Fusion.peek(hasEditRolesPerm) ~= true then
							local Prompt = require(modules.Prompt)
							Prompt.warn("You don't have permission to edit roles.")
							return
						end
						if onRoleActivate then
							local callback = if typeof(onRoleActivate) == "table" then Fusion.peek(onRoleActivate) else onRoleActivate
							if callback then callback(key) end
						end
					end,
					onDragStart = startDrag,
					hideDrag = hideDragForRow,
					roleInfoFuse = savedRoleInfoRaw,
					defaultRoleInfoFuse = defaultRoleInfoRaw,
					useDefaults = localUseDefaultRoles,
					previewState = previewState,
					onPreviewToggle = onPreviewToggle,
				}),
			},
		}
		rowCache[entry.key] = wrapper
		return wrapper
	end

	local function buildTabContent(innerScope: Fusion.Scope, tabIdx: number): any
		if tabIdx == 2 then
			local rowChildren = innerScope:ForValues(roles, function(_, rowScope, entry: RoleEntry)
				return ensureRow(entry)
			end)

			local defaultsHovered: Fusion.Value<boolean> = innerScope:Value(false)

			local canEditRolesFuse = Permissions.canEditRoles(innerScope)
			local addRoleVisible = innerScope:Computed(function(use)
				if use(localUseDefaultRoles) == true then return false end
				return use(canEditRolesFuse) == true
			end)
			local addRoleButton = SearchRowToggle(innerScope, {
				name = "AddRoleButton",
				icon = Icons.AddFill,
				iconSize = UDim2.fromOffset(14, 14),
				isVisible = addRoleVisible,
				layoutOrder = 0,
				onActivate = function()
					if props.onRoleCreate then props.onRoleCreate() end
				end,
			})

			-- Hidden from users who can't persist the change, it would just toast-reject
			local canEditGameSettings = Permissions.hasPermission(innerScope, "mayEditSettingsGame")
			local toggleRow = innerScope:New "Frame" {
				Name = "UseDefaultsRow",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 0,
				Size = UDim2.fromScale(1, 0),
				Visible = canEditGameSettings,
				[Children] = {
					innerScope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						Padding = UDim.new(0, 8),
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center,
					},

					addRoleButton,

					InlineToggleRow(innerScope, {
						name = "UseDefaultsLabel",
						label = "Use Studio Defaults",
						isOn = localUseDefaultRoles,
						onToggle = toggleUseDefaultRoles,
						fills = true,
						layoutOrder = 1,
					}),
				},
			}

			local list = innerScope:New "Frame" {
				Name = "RolesList",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 0),
				Visible = isRolesReady,
				[Children] = {
					innerScope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						Padding = UDim.new(0, ROW_GAP),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					toggleRow,
					rowChildren,
				},
			}
			rolesListInstance = list

			local loadingSpinner = LoadingSpinner(innerScope, {
				visible = innerScope:Computed(function(use)
					return not use(isRolesReady)
				end),
			})

			local rolesContentInner = innerScope:New "Frame" {
				Name = "RolesContentInner",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				Size = UDim2.fromScale(1, 0),
				Visible = canViewRoles,
				[Children] = {
					innerScope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					list,
					loadingSpinner,
				},
			}
			local rolesDeniedPlaceholder = innerScope:New "Frame" {
				Name = "RolesTab_Denied",
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				Size = UDim2.new(1, 0, 0, 160),
				Visible = innerScope:Computed(function(use): boolean
					return not use(canViewRoles)
				end),
				[Children] = {
					NoPermissionPlaceholder(innerScope, {}),
				},
			}
			return innerScope:New "Frame" {
				Name = "RolesTabContent",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 0),
				[Children] = {
					innerScope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					rolesContentInner,
					rolesDeniedPlaceholder,
				},
			}
		end

		local function buildDotsStrip(itemScope: Fusion.Scope, roleKeys: {string}): Instance
			local roleInfo = Fusion.peek(roleInfoFuse)
			local roleColors: {Color3} = {}
			if typeof(roleInfo) == "table" then
				for _, key in roleKeys do
					local role = (roleInfo :: any)[key]
					if typeof(role) == "table" then
						table.insert(roleColors, (role :: any).color or Color3.fromRGB(161, 161, 170))
					end
				end
			end
			return itemScope:New "Frame" {
				Name = "RoleDots",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				[Children] = {
					itemScope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						Padding = UDim.new(0, 4),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					itemScope:ForValues(roleColors, function(_, dotScope, color: Color3, index: number)
						return dotScope:New "Frame" {
							Name = "Dot_" .. tostring(index),
							BackgroundColor3 = color,
							LayoutOrder = index,
							Size = UDim2.fromOffset(10, 10),
							[Children] = {
								dotScope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
								dotScope:New "UIStroke" {
									ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
									Color = Theme.Color.NeutralStroke,
									Transparency = 0.5,
								},
							},
						}
					end),
				},
			}
		end

		-- Mirrors renderMemberRow's layout exactly
		local function renderGiverRow(itemScope: Fusion.Scope, item: any): Instance
			local giver: any = (item :: any).giver
			local typeLabel: string = tostring((giver :: any).type)
			local nameLabel: string = tostring((giver :: any).name)
			local rowName = `GiverRow_{typeLabel}_{tostring((giver :: any).id)}`
			local dotsStrip = buildDotsStrip(itemScope, (giver :: any).roleKeys :: {string})
			return SplitRow(itemScope, {
				name = rowName,
				height = 46,
				left = {
					name = rowName .. "_Slot",
					fills = true,
					onActivate = function()
						local callback = props.onGiverActivate
						if callback then callback(giver) end
					end,
					[Children] = {
						itemScope:New "Frame" {
							Name = "ContentGroup",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 12, 0.5, 0),
							Size = UDim2.new(1, -24, 1, 0),
							[Children] = {
								itemScope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									VerticalAlignment = Enum.VerticalAlignment.Center,
									Padding = UDim.new(0, 8),
									SortOrder = Enum.SortOrder.LayoutOrder,
								},
								(function()
									local details = UserDetails(itemScope, {
										displayName = Givers.makeNameComputed(itemScope, giver),
										subtitle = Givers.compactSubtitleFor(giver),
										iconImage = Givers.imageUrl(giver),
										layoutOrder = 1,
										iconSize = 32,
										singleLine = true,
									})
									local flex = itemScope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill }
									flex.Parent = details
									return details
								end)(),
								itemScope:New "Frame" {
									Name = "DotsSlot",
									AutomaticSize = Enum.AutomaticSize.XY,
									BackgroundTransparency = 1,
									LayoutOrder = 2,
									[Children] = { dotsStrip },
								},
							},
						},
					},
				},
			})
		end

		local function renderMemberRow(itemScope: Fusion.Scope, item: any): Instance
			local member = (item :: any).member :: Member
			local roleInfo = Fusion.peek(roleInfoFuse)
			local roleColors: {Color3} = {}
			if typeof(roleInfo) == "table" then
				for _, key in member.roleKeys do
					local role = (roleInfo :: any)[key]
					if typeof(role) == "table" and not isInternalRole(role) then
						table.insert(roleColors, (role :: any).color or Color3.fromRGB(161, 161, 170))
					end
				end
			end
			local dotsStrip = itemScope:New "Frame" {
				Name = "RoleDots",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				[Children] = {
					itemScope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						Padding = UDim.new(0, 4),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					itemScope:ForValues(roleColors, function(_, dotScope, color: Color3, index: number)
						return dotScope:New "Frame" {
							Name = "Dot_" .. tostring(index),
							BackgroundColor3 = color,
							LayoutOrder = index,
							Size = UDim2.fromOffset(10, 10),
							[Children] = {
								dotScope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
								dotScope:New "UIStroke" {
									ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
									Color = Theme.Color.NeutralStroke,
									Transparency = 0.5,
								},
							},
						}
					end),
				},
			}
			return SplitRow(itemScope, {
				name = "MemberRow_" .. tostring(member.userId),
				height = 46,
				left = {
					name = "MemberRowSlot_" .. tostring(member.userId),
					fills = true,
					onActivate = function()
						local callback = onMemberActivate
						if callback then
							local handler = if typeof(callback) == "table" then Fusion.peek(callback) else callback
							if handler then handler(member.userId) end
						end
					end,
					[Children] = {
						itemScope:New "Frame" {
							Name = "ContentGroup",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 12, 0.5, 0),
							Size = UDim2.new(1, -24, 1, 0),
							[Children] = {
								itemScope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									VerticalAlignment = Enum.VerticalAlignment.Center,
									Padding = UDim.new(0, 8),
									SortOrder = Enum.SortOrder.LayoutOrder,
								},
								(function()
									local details = UserDetails(itemScope, {
										userId = member.userId,
										displayName = member.userDisplayName,
										username = member.userName,
										layoutOrder = 1,
										iconSize = 32,
										singleLine = true,
									})
									local flex = itemScope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill }
									flex.Parent = details
									return details
								end)(),
								itemScope:New "Frame" {
									Name = "DotsSlot",
									AutomaticSize = Enum.AutomaticSize.XY,
									BackgroundTransparency = 1,
									LayoutOrder = 2,
									[Children] = { dotsStrip },
								},
							},
						},
					},
				},
			})
		end

		local function renderRow(itemScope: Fusion.Scope, item: any): Instance
			if (item :: any).isGiver then
				return renderGiverRow(itemScope, item)
			end
			return renderMemberRow(itemScope, item)
		end

		local subTabBar = UnderscoreTabBar(innerScope, {
			tabs = membersSubTabs,
			activeTab = activeMembersSubTab,
			layoutOrder = 0,
		})

		local serverContent = innerScope:New "Frame" {
			Name = "MembersSubTab_Server",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 1,
			Size = UDim2.fromScale(1, 0),
			Visible = innerScope:Computed(function(use)
				return use(activeMembersSubTabLabel) == "Server" and use(canViewMembersServer)
			end),
			[Children] = {
				innerScope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				SearchBar(innerScope, {
					searchText = serverSearchText,
					placeholderText = "Search",
					layoutOrder = 0,
				}),
				innerScope:New "Frame" {
					Name = "ListWrap",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					LayoutOrder = 1,
					Size = UDim2.fromScale(1, 0),
					[Children] = {
						LoadingGate(innerScope, {
							isReady = innerScope:Computed(function(use)
								return typeof(use(serverMembersFuse)) == "table"
							end),
							[Children] = {
								StreamList(innerScope, {
									items = serverMembersItems,
									visibleItems = serverVisibleItems,
									itemKey = memberItemKey,
									padding = UDim.new(0, 8),
									renderItem = renderMemberRow,
								}),
							},
						}),
					},
				},
			},
		}

		local permanentContent = innerScope:New "Frame" {
			Name = "MembersSubTab_Permanent",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 1,
			Size = UDim2.fromScale(1, 0),
			Visible = innerScope:Computed(function(use)
				return use(activeMembersSubTabLabel) == "Permanent" and use(canViewMembersPermanent)
			end),
			[Children] = {
				innerScope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				SearchBar(innerScope, {
					searchText = permanentSearchText,
					placeholderText = "Search",
					layoutOrder = 0,
					leadingSlot = SearchRowToggle(innerScope, {
						name = "GivePermRoleToggle",
						icon = Icons.AddFill,
						iconSize = UDim2.fromOffset(14, 14),
						onActivate = function()
							if props.onRunPageOpen then
								(props.onRunPageOpen :: (string, any?) -> ())("givepermrole", {autoOpenUserArg = true})
							end
						end,
					}),
				}),
				innerScope:New "Frame" {
					Name = "ListWrap",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					LayoutOrder = 1,
					Size = UDim2.fromScale(1, 0),
					[Children] = {
						LoadingGate(innerScope, {
							isReady = innerScope:Computed(function(use)
								return typeof(use(permanentMembersFuse)) == "table"
							end),
							[Children] = {
								StreamList(innerScope, {
									items = permanentMembersItems,
									visibleItems = permanentVisibleItems,
									itemKey = memberItemKey,
									padding = UDim.new(0, 8),
									renderItem = renderRow,
								}),
							},
						}),
					},
				},
			},
		}

		local membersDeniedPlaceholder = innerScope:New "Frame" {
			Name = "MembersSubTab_Denied",
			BackgroundTransparency = 1,
			LayoutOrder = 1,
			Size = UDim2.new(1, 0, 0, 160),
			Visible = innerScope:Computed(function(use)
				local label = use(activeMembersSubTabLabel)
				if label == "Server" then return not use(canViewMembersServer) end
				if label == "Permanent" then return not use(canViewMembersPermanent) end
				return false
			end),
			[Children] = {
				NoPermissionPlaceholder(innerScope, {}),
			},
		}

		return innerScope:New "Frame" {
			Name = "MembersTabContent",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0),
			[Children] = {
				innerScope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				subTabBar,
				serverContent,
				permanentContent,
				membersDeniedPlaceholder,
			},
		}
	end

	-- One ConfirmBar covers both pending flows, role order and preview staging. Role
	-- order wins when both are pending
	local rolesOrderHasPending = scope:Computed(function(use)
		if use(outerActiveTab) == 2 then
			return use(hasPendingChanges)
		end
		return false
	end)
	local activeHasPendingChanges = scope:Computed(function(use)
		return use(rolesOrderHasPending) or use(hasPendingPreview)
	end)

	local confirmBarLabel = scope:Computed(function(use): string
		if use(rolesOrderHasPending) then return "Confirm?" end
		if use(hasPendingPreview) then
			local pending = use(pendingPreviewKeys)
			if #pending == 0 then return "Stop?" end
			return "Preview?"
		end
		return ""
	end)
	local confirmButtonLabel = scope:Computed(function(use): string
		if use(rolesOrderHasPending) then return "Confirm" end
		if use(hasPendingPreview) then
			local pending = use(pendingPreviewKeys)
			if #pending == 0 then return "Stop" end
			return "Preview"
		end
		return "Confirm"
	end)
	local cancelButtonLabel = scope:Computed(function(use): string
		if use(rolesOrderHasPending) then return "Undo" end
		return "Cancel"
	end)

	local function activeConfirm()
		if Fusion.peek(rolesOrderHasPending) then
			confirmChanges()
		elseif Fusion.peek(hasPendingPreview) then
			confirmPreview()
		end
	end
	local function activeUndo()
		if Fusion.peek(rolesOrderHasPending) then
			undoChanges()
		elseif Fusion.peek(hasPendingPreview) then
			cancelPreview()
		end
	end

	local confirmBarHeight: any = scope:Spring(scope:Computed(function(use)
		return if use(activeHasPendingChanges) then 54 else 0
	end), 40, 1)

	local confirmBar = scope:New "Frame" {
		Name = "ConfirmBarWrap",
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Size = UDim2.fromScale(1, 1),

		[Children] = {
			scope:New "Frame" {
				Name = "ConfirmBar",
				AnchorPoint = Vector2.new(0, 0.5),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Theme.Color.Neutral,
				Position = UDim2.new(0, 2, 0.5, 0),
				Size = UDim2.new(1, -7, 0, -2),

				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
					scope:New "UIStroke" {
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Color = Theme.Color.NeutralContent,
					},
					scope:New "UIPadding" {
						PaddingBottom = UDim.new(0, 14),
						PaddingLeft = UDim.new(0, 12),
						PaddingRight = UDim.new(0, 4),
						PaddingTop = UDim.new(0, 14),
					},

					scope:New "Frame" {
						Name = "LabelGroup",
						AnchorPoint = Vector2.new(0, 0.5),
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(0, 0.5),
						[Children] = {
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Center,
							},
							scope:New "TextLabel" {
								Name = "Label",
								AutomaticSize = Enum.AutomaticSize.XY,
								BackgroundTransparency = 1,
								FontFace = scope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
								end),
								Text = confirmBarLabel,
								TextColor3 = Theme.Color.BaseContent,
								TextSize = Theme.TextSize.Subtitle,
								TextTruncate = Enum.TextTruncate.AtEnd,
							},
						},
					},

					scope:New "Frame" {
						Name = "ButtonGroup",
						AnchorPoint = Vector2.new(1, 0.5),
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(1, 0.5),
						[Children] = {
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								HorizontalFlex = Enum.UIFlexAlignment.None,
								Padding = UDim.new(0, 6),
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Center,
							},

							Pressable(scope, {
								name = "ConfirmButton",
								size = UDim2.new(0, 0, 0, 0),
								automaticSize = Enum.AutomaticSize.XY,
								backgroundColor = Theme.Color.Primary,
								layoutOrder = 1,
								onActivate = activeConfirm,
								[Children] = {
									scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
									scope:New "UIPadding" {
										PaddingBottom = UDim.new(0, 7),
										PaddingLeft = UDim.new(0, 12),
										PaddingRight = UDim.new(0, 12),
										PaddingTop = UDim.new(0, 7),
									},
									scope:New "TextLabel" {
										Name = "Label",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										FontFace = scope:Computed(function(use)
											return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
										end),
										Text = confirmButtonLabel,
										TextColor3 = Theme.Color.PrimaryContent,
										TextSize = Theme.TextSize.Subtitle,
									},
								},
							}),

							Pressable(scope, {
								name = "UndoButton",
								size = UDim2.new(0, 0, 0, 0),
								automaticSize = Enum.AutomaticSize.XY,
								backgroundColor = Theme.Color.NeutralContent,
								layoutOrder = 2,
								onActivate = activeUndo,
								[Children] = {
									scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
									scope:New "UIPadding" {
										PaddingBottom = UDim.new(0, 7),
										PaddingLeft = UDim.new(0, 12),
										PaddingRight = UDim.new(0, 12),
										PaddingTop = UDim.new(0, 7),
									},
									scope:New "TextLabel" {
										Name = "Label",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										FontFace = scope:Computed(function(use)
											return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
										end),
										Text = cancelButtonLabel,
										TextColor3 = Theme.Color.BaseContent,
										TextSize = Theme.TextSize.Subtitle,
									},
								},
							}),
						},
					},
				},
			},
		},
	}

	return scope:New "Frame" {
		Name = "RolesPage",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),

		[Children] = {
			TabbedScroller(scope, {
				tabs = TAB_DEFS,
				activeTabRef = outerActiveTab,
				buildTabContent = buildTabContent,
				footerSlot = confirmBar,
				footerHeight = confirmBarHeight,
				headerPadding = UDim.new(0, 10),
			}),
		},
	}
end

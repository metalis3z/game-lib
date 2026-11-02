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
local ConfirmBar = require(frontend.Components.ConfirmBar)
local UnderscoreTabBar = require(frontend.Components.UnderscoreTabBar)
local InlineToggleRow = require(frontend.Components.InlineToggleRow)
local SearchBar = require(frontend.Components.SearchBar)
local Icons = require(frontend.Config.Icons)
local Permissions = require(frontend.Util.Permissions)
local VettingState = require(frontend.Config.VettingState)
local Remote = require(modules.Objects.Remote)
local isVettable = require(modules.CommandUtil.isVettable)
local getActiveCommands = Remote.get("GetActiveCommands")
local updateActiveCommands = Remote.get("UpdateActiveCommands")


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	isActive: UsedAs<boolean>?,
	onRunPageOpen: ((commandKey: string, context: any?) -> ())?,
	idle: UsedAs<boolean>?,
	panelClosed: UsedAs<boolean>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local commands = scope:Fuse("everyone", "Commands")
	local commandPrefix = scope:Fuse("perm", {"YouSettings", "Prefix"})
	local vetting = scope:Fuse("everyone", "CommandVetting")

	local activeCommands: Fusion.Value<{[string]: boolean}> = scope:Value({})
	local function refreshActiveCommands()
		task.defer(function()
			local success, result = getActiveCommands:invokeServerAsync()
			if type(result) == "table" then
				activeCommands:set(result)
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

	local VET_TAB_STATUS = {"pending", "approved", "disabled"}
	local decisions: Fusion.Value<{[string]: string}> = scope:Value({})
	local isConfirming = scope:Value(false)
	-- Snapshotted as the page opens, they mark NEW rows for the rest of the session
	local newIdentities: Fusion.Value<{[string]: true}> = scope:Value({})

	-- The dirty flag rather than fuse comparison keeps an outside settings change
	-- from reading as our pending change
	local canEditGameSettings = Permissions.hasPermission(scope, "mayEditSettingsGame")
	local autoApproveFuse = (scope :: any):Fuse("everyone", {"GameSettings", "SystemSettings", "AutoApproveNewCommands"})
	local localAutoApprove: Fusion.Value<boolean> = scope:Value(Fusion.peek(autoApproveFuse) ~= false)
	local autoApproveDirty: Fusion.Value<boolean> = scope:Value(false)
	local function toggleAutoApprove()
		local newValue = not Fusion.peek(localAutoApprove)
		localAutoApprove:set(newValue)
		autoApproveDirty:set(newValue ~= (Fusion.peek(autoApproveFuse) ~= false))
	end
	scope:Observer(autoApproveFuse):onChange(function()
		if Fusion.peek(autoApproveDirty) then return end
		localAutoApprove:set(Fusion.peek(autoApproveFuse) ~= false)
	end)

	local function savedStatus(use: any, identity: string): string
		local data = use(vetting)
		local states = if typeof(data) == "table" then (data :: any).states else nil
		if typeof(states) == "table" and typeof(states[identity]) == "string" then
			return states[identity]
		end
		return "approved"
	end
	local function effectiveStatus(use: any, identity: string): string
		local pending = use(decisions)[identity]
		return if pending then pending else savedStatus(use, identity)
	end
	local function setDecision(identity: string, status: string)
		local current = table.clone(Fusion.peek(decisions))
		if savedStatus(Fusion.peek, identity) == status then
			current[identity] = nil
		else
			current[identity] = status
		end
		decisions:set(current)
	end
	local vetPendingCount = scope:Computed(function(use): number
		local cmds = use(commands)
		if typeof(cmds) ~= "table" then return 0 end
		local count = 0
		for _, command in cmds :: {any} do
			if typeof(command) ~= "table" or not isVettable(command) then continue end
			local identity = (command :: any).identity or (command :: any).key
			if typeof(identity) == "string" and effectiveStatus(use, identity) == "pending" then
				count += 1
			end
		end
		return count
	end)

	local hasVetChanges = scope:Computed(function(use)
		return next(use(decisions)) ~= nil or use(autoApproveDirty)
	end)
	local function confirmVet()
		if Fusion.peek(isConfirming) or not Fusion.peek(hasVetChanges) then return end
		isConfirming:set(true)
		task.spawn(function()
			local approvedCount = 0
			local disabledCount = 0
			local pendingDecisions = Fusion.peek(decisions)
			for _, status in pendingDecisions do
				if status == "approved" then
					approvedCount += 1
				elseif status == "disabled" then
					disabledCount += 1
				end
			end
			if Fusion.peek(autoApproveDirty) then
				local toSend = Fusion.peek(localAutoApprove)
				if toSend then
					-- Flipping on waives the queue server-side, so pending counts as approved too
					approvedCount += Fusion.peek(vetPendingCount)
				end
				pcall(function()
					return (Remote.get("ChangeGameSetting") :: any):invokeServerAsync({"SystemSettings", "AutoApproveNewCommands"}, toSend)
				end)
				autoApproveDirty:set(false)
			end
			local decisionsOk = true
			if next(pendingDecisions) ~= nil then
				local ok, err = Remote.get("VetCommands"):invokeServerAsync(pendingDecisions)
				if ok then
					decisions:set({})
				else
					decisionsOk = false
					local Prompt = require(modules.Prompt)
					Prompt.warn(tostring(err or "Failed to save the vetting decisions"))
				end
			end
			if decisionsOk and (approvedCount > 0 or disabledCount > 0) then
				local Prompt = require(modules.Prompt)
				local message
				if approvedCount > 0 and disabledCount > 0 then
					message = `Approved {approvedCount} command{if approvedCount == 1 then "" else "s"} and disabled {disabledCount} command{if disabledCount == 1 then "" else "s"}`
				elseif approvedCount > 0 then
					message = `Approved {approvedCount} command{if approvedCount == 1 then "" else "s"}`
				else
					message = `Disabled {disabledCount} command{if disabledCount == 1 then "" else "s"}`
				end
				Prompt.info(message)
			end
			isConfirming:set(false)
		end)
	end

	-- Pending disappears while Auto Approve New is on, so land on Approved
	local vetTab: Fusion.Value<number> = scope:Value(if Fusion.peek(autoApproveFuse) ~= false then 2 else 1)
	local VET_TABS: {UnderscoreTabBar.Tab} = {
		{
			label = "Pending",
			visible = scope:Computed(function(use)
				return not use(localAutoApprove)
			end),
		},
		{label = "Approved"},
		{label = "Disabled"},
	}
	-- Judged from the fuse (or the buffered local value), the localAutoApprove
	-- mirror may not have synced when these observers fire
	local function clampHiddenPending()
		local pendingHidden = if Fusion.peek(autoApproveDirty)
			then Fusion.peek(localAutoApprove)
			else Fusion.peek(autoApproveFuse) ~= false
		if pendingHidden and Fusion.peek(vetTab) == 1 then
			vetTab:set(2)
		end
	end
	scope:Observer(localAutoApprove):onChange(clampHiddenPending)
	scope:Observer(autoApproveFuse):onChange(clampHiddenPending)

	-- The set is unconditional, the fuse can still be nil this early and the clamp
	-- moves us off Pending. Snapshot before acknowledging wipes the unacked set
	local function snapshotAndAcknowledge(data: any)
		local unackedKeys = if typeof(data) == "table" then (data :: any).unackedKeys else nil
		if typeof(unackedKeys) == "table" and next(unackedKeys :: any) ~= nil then
			local merged = table.clone(Fusion.peek(newIdentities))
			for identity in unackedKeys :: {[string]: any} do
				if typeof(identity) == "string" then
					merged[identity] = true
				end
			end
			newIdentities:set(merged)
		end
		VettingState.acknowledge()
	end
	local waitingForVetting = false
	local function onPageOpened()
		local data = Fusion.peek(vetting)
		if typeof(data) == "table" then
			snapshotAndAcknowledge(data)
		elseif not waitingForVetting then
			-- Acknowledging before the fuse delivers would wipe the unacked set
			-- before we ever see it, so both wait for the data
			waitingForVetting = true
			local disconnect: any = nil
			disconnect = scope:Observer(vetting):onChange(function()
				local latest = Fusion.peek(vetting)
				if typeof(latest) ~= "table" then
					return
				end
				waitingForVetting = false
				snapshotAndAcknowledge(latest)
				if disconnect then
					(disconnect :: () -> ())()
					disconnect = nil
				end
			end)
		end
		if VettingState.consumePendingFocus() then
			vetTab:set(1)
		end
	end
	if props.isActive then
		scope:Observer(props.isActive):onChange(function()
			if Fusion.peek(props.isActive) then
				onPageOpened()
			end
		end)
		if Fusion.peek(props.isActive) then
			onPageOpened()
		end
	end
	VettingState.setOpenListener(onPageOpened)
	table.insert(scope, function()
		VettingState.setOpenListener(nil)
	end)

	-- Cached per identity, the list diffs by table identity so fresh tables would
	-- rebuild every visible row
	local vetRowCache: {[string]: any} = {}
	local allVetRows: Fusion.Computed<{ any }> = scope:Computed(function(use): {any}
		local cmds = use(commands)
		if typeof(cmds) ~= "table" then return {} end
		local newSet = use(newIdentities)
		local rows: {any} = {}
		for _, command in cmds :: {any} do
			if typeof(command) ~= "table" or not isVettable(command) then continue end
			local identity = (command :: any).identity or (command :: any).key
			if typeof(identity) ~= "string" then continue end
			local status = effectiveStatus(use, identity)
			local isNew = newSet[identity] == true
			-- Approved commands no role uses surface with an Unused marker
			local roles = (command :: any).roles
			local isUnused = status == "approved"
				and (typeof(roles) ~= "table" or #(roles :: {any}) == 0)
			local row = vetRowCache[identity]
			if not row
				or row.status ~= status
				or row.commandKey ~= (command :: any).key
				or (row.isNew == true) ~= isNew
				or (row.isUnused == true) ~= isUnused
			then
				row = {
					key = "vr_" .. identity,
					identity = identity,
					commandKey = (command :: any).key,
					name = (command :: any).name,
					prefix = (command :: any).prefix,
					status = status,
					isNew = isNew,
					isUnused = isUnused,
				}
				vetRowCache[identity] = row
			end
			table.insert(rows, row)
		end
		table.sort(rows, function(left, right)
			if (left.isNew == true) ~= (right.isNew == true) then
				return left.isNew == true
			end
			if (left.isUnused == true) ~= (right.isUnused == true) then
				return left.isUnused == true
			end
			return left.name < right.name
		end)
		return rows
	end)
	local searchText = scope:Value("")
	local vetItems: Fusion.Computed<{ any }> = scope:Computed(function(use): {any}
		local wantedStatus = VET_TAB_STATUS[use(vetTab)] or "pending"
		local search = use(searchText):lower()
		local visibleRows: {any} = {}
		for _, row in use(allVetRows) do
			if row.status ~= wantedStatus then continue end
			if search ~= "" and not row.name:lower():find(search, 1, true) then continue end
			table.insert(visibleRows, row)
		end
		return visibleRows
	end)

	local emptyText = scope:Computed(function(use): string?
		local cmds = use(commands)
		if typeof(cmds) ~= "table" or next(cmds) == nil then return nil end
		-- A fruitless search shouldn't claim the whole tab is empty
		if use(searchText) ~= "" then return nil end
		if #use(vetItems) > 0 then return nil end
		local tabIdx = use(vetTab)
		if tabIdx == 1 then
			return "No pending commands. New commands added to HD Admin will appear here."
		elseif tabIdx == 3 then
			return if use(vetPendingCount) > 0
				then "No disabled commands. All your commands (minus pending) are live and useable."
				else "No disabled commands. All your commands are live and useable."
		end
		return nil
	end)
	-- Pinned below the header so centring sits between the tabs and page bottom
	local emptyOverlay = scope:New "TextLabel" {
		Name = "EmptyState",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, -20, 1, 0),
		Visible = scope:Computed(function(use)
			return use(emptyText) ~= nil
		end),
		FontFace = scope:Computed(function(use)
			return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
		end),
		Text = scope:Computed(function(use)
			return use(emptyText) or ""
		end),
		TextColor3 = Theme.Color.NeutralContentDark,
		TextSize = Theme.TextSize.Body,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Center,
	}

	return scope:New "Frame" {
		Name = "VetCommands",
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
				items = allVetRows,
				visibleItems = vetItems,
				itemKey = function(item: any): string
					return item.key
				end,
				renderItem = function(itemScope, item: any)
					-- A real command row so pending commands can be tested before approving
					local identity: string = (item :: any).identity
					local status: string = (item :: any).status
					local vetCommandKey: string = (item :: any).commandKey
					local trailingButtons = {}
					if status ~= "approved" then
						table.insert(trailingButtons, {
							icon = if status == "disabled" then Icons.VetApproveDisabled else Icons.VetApprove,
							iconColor = if status == "pending" then Theme.Color.PrimaryContent else Theme.Color.BaseContent,
							backgroundColor = if status == "pending" then Theme.Color.Primary else Theme.Color.NeutralContent,
							onActivate = function()
								setDecision(identity, "approved")
							end,
						})
					end
					if status ~= "disabled" then
						table.insert(trailingButtons, {
							icon = if status == "approved" then Icons.VetDisableApproved else Icons.VetDisable,
							iconColor = Theme.Color.BaseContent,
							backgroundColor = Theme.Color.NeutralContent,
							onActivate = function()
								setDecision(identity, "disabled")
							end,
						})
					end
					return CommandButton(itemScope, {
						commandKey = vetCommandKey,
						commandName = (item :: any).name,
						commandPrefix = (item :: any).prefix,
						customPrefix = commandPrefix,
						nameTag = if (item :: any).isNew == true then "NEW"
							elseif (item :: any).isUnused == true then "Unused"
							else nil,
						nameTagColor = if (item :: any).isNew == true then nil else Theme.Color.NeutralContent,
						nameTagTextColor = if (item :: any).isNew == true then nil else Theme.Color.BaseContent,
						activeCommands = activeCommands,
						onCommandActivate = if props.onRunPageOpen
							then function() (props.onRunPageOpen :: (string, any?) -> ())(vetCommandKey, {showRoles = true}) end
							else nil,
						trailingButtons = trailingButtons,
					})
				end,
				padding = UDim.new(0, 8),
				layoutOrder = 1,
				paddingRight = 10,
				idle = props.idle,
				headerGap = UDim.new(0, 8),
				header = scope:New "Frame" {
					Name = "VetHeader",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					LayoutOrder = 0,
					Size = UDim2.fromScale(1, 0),
					[Children] = {
						scope:New "UIListLayout" {
							HorizontalFlex = Enum.UIFlexAlignment.Fill,
							VerticalFlex = Enum.UIFlexAlignment.None,
							Padding = UDim.new(0, 8),
							SortOrder = Enum.SortOrder.LayoutOrder,
						},
						InlineToggleRow(scope, {
							name = "AutoApproveRow",
							label = "Auto Approve New",
							isOn = localAutoApprove,
							onToggle = toggleAutoApprove,
							visible = canEditGameSettings,
							layoutOrder = 1,
						}),
						UnderscoreTabBar(scope, {
							tabs = VET_TABS,
							activeTab = vetTab,
							height = 38,
							layoutOrder = 2,
						}),
						SearchBar(scope, {
							searchText = searchText,
							placeholderText = "Search",
							layoutOrder = 3,
						}),
					},
				},
				overlay = emptyOverlay,
				pinBelowHeader = true,
			}),

			ConfirmBar(scope, {
				hasPendingChanges = hasVetChanges,
				confirmChanges = confirmVet,
				undoChanges = function()
					decisions:set({})
					autoApproveDirty:set(false)
					localAutoApprove:set(Fusion.peek(autoApproveFuse) ~= false)
				end,
				label = scope:Computed(function(use)
					if use(isConfirming) then return "Saving..." end
					local count = if use(autoApproveDirty) then 1 else 0
					for _ in use(decisions) do count += 1 end
					return `{count} change{if count == 1 then "" else "s"}`
				end),
				layoutOrder = 999,
			}),
		},
	}
end

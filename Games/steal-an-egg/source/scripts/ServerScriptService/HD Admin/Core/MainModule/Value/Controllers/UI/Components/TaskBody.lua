--!strict

--[[

	Everything is built from the ActiveTasks feed entry (or the PermTasks
	feed for saved entries), so the popup appears in full without needing a second
	fetch. It can also outlive its task, where the row's snapshot keeps the fields
	readable after the feed entry vanishes and status flips to 'Ended', so you can
	still read the details even if you accidentally end the task

--]]


-- LOCAL
local Players = game:GetService("Players")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Permissions = require(frontend.Util.Permissions)
local getTaskTitle = require(frontend.Util.getTaskTitle)
local Pressable = require(frontend.Components.Pressable)
local Remote = require(modules.Objects.Remote)
local Prompt = require(modules.Prompt)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	taskUID: string,
	snapshot: any?, -- used when the feed entry has already gone
	onOpenProfile: ((userId: number) -> ())?,
	layoutOrder: UsedAs<number>?,
}


-- HELPERS
local function formatRelativePast(timestamp: number, now: number): string
	if typeof(timestamp) ~= "number" or timestamp <= 0 then return "" end
	local diff = math.max(0, now - timestamp)
	if diff < 60 then return "just now" end
	local units = {
		{ name = "day",    seconds = 86400 },
		{ name = "hour",   seconds = 3600 },
		{ name = "minute", seconds = 60 },
	}
	for _, unit in units do
		if diff < unit.seconds then continue end
		local count = math.floor(diff / unit.seconds)
		local suffix = if count == 1 then unit.name else unit.name .. "s"
		return `{count} {suffix} ago`
	end
	return "just now"
end

local function formatAbsolute(timestamp: number): string
	if typeof(timestamp) ~= "number" or timestamp <= 0 then return "" end
	local date = os.date("*t", timestamp) :: any
	return string.format("%04d-%02d-%02d %02d:%02d",
		date.year, date.month, date.day, date.hour, date.min)
end

-- Args arrive as an array of strings, qualifiers / modifiers as dicts of
-- string arrays (like {name = {"ben"}, all = {}})
local function formatTokens(value: any): string
	if typeof(value) ~= "table" then return "" end
	local parts: {string} = {}
	if #(value :: {any}) > 0 then
		for _, entry in value :: {any} do
			table.insert(parts, tostring(entry))
		end
	else
		for key, inner in value :: {[any]: any} do
			if typeof(inner) == "table" and #(inner :: {any}) > 0 then
				local innerParts: {string} = {}
				for _, innerValue in inner :: {any} do
					table.insert(innerParts, tostring(innerValue))
				end
				table.insert(parts, `{tostring(key)} ({table.concat(innerParts, ", ")})`)
			else
				table.insert(parts, tostring(key))
			end
		end
	end
	return table.concat(parts, ", ")
end


-- COMPONENT
return function(scope: Scope, props: Props): Instance
	local taskUID = props.taskUID
	local onOpenProfile = props.onOpenProfile
	local destroyed = false
	table.insert(scope, function() destroyed = true end)

	local nowValue: Fusion.Value<number> = scope:Value(os.time())
	local activeTasksFuse: any = (scope :: any):Fuse("everyone", "ActiveTasks")
	local permTasksFuse: any = (scope :: any):Fuse("everyone", "PermTasks")
	local canEditTasks = Permissions.hasPermission(scope, "mayEditTasks")

	-- Perm entries open here too, their UID lives in PermTasks and cancel maps to removeEntry
	local snapshotIsSaved = typeof(props.snapshot) == "table" and (props.snapshot :: any).isSaved == true
	local savedEntry = scope:Computed(function(use): any
		local feed = use(permTasksFuse)
		if typeof(feed) ~= "table" then return nil end
		return (feed :: any)[taskUID]
	end)
	local liveFeedEntry = scope:Computed(function(use): any
		local feed = use(activeTasksFuse)
		if typeof(feed) ~= "table" then return nil end
		return (feed :: any)[taskUID]
	end)
	-- A replayed perm task shares its entry's UID, so the live view wins while it runs
	local isSavedMode = scope:Computed(function(use): boolean
		if use(liveFeedEntry) ~= nil then
			return false
		end
		return snapshotIsSaved or use(savedEntry) ~= nil
	end)

	local liveEntry = scope:Computed(function(use): any
		if use(isSavedMode) then
			return use(savedEntry)
		end
		return use(liveFeedEntry)
	end)
	local isAlive = scope:Computed(function(use): boolean
		return use(liveEntry) ~= nil
	end)

	-- Keeps the last seen entry so fields stay readable once the task ends
	local lastKnown: Fusion.Value<any?> = scope:Value(props.snapshot)
	local function captureEntry()
		if Fusion.peek(isSavedMode) then
			local permFeed = Fusion.peek(permTasksFuse)
			local entry = if typeof(permFeed) == "table" then (permFeed :: any)[taskUID] else nil
			if typeof(entry) == "table" then
				local commandKey = tostring((entry :: any).commandKey or "Task")
				lastKnown:set({
					commandName = commandKey:sub(1, 1):upper() .. commandKey:sub(2),
					callerUserId = (entry :: any).callerUserId,
					callerName = (entry :: any).callerName,
					callerDisplayName = (entry :: any).callerDisplayName,
					targetUserId = (entry :: any).targetUserId,
					targetName = (entry :: any).targetName,
					startedAt = (entry :: any).createdAt,
					args = (entry :: any).args,
					qualifiers = (entry :: any).qualifiers,
					modifiers = (entry :: any).modifiers,
					kind = (entry :: any).kind,
					isSaved = true,
				})
			end
			return
		end
		local feed = Fusion.peek(activeTasksFuse)
		local entry = if typeof(feed) == "table" then (feed :: any)[taskUID] else nil
		if typeof(entry) == "table" then
			lastKnown:set(entry)
		end
	end
	captureEntry()
	scope:Observer(activeTasksFuse):onChange(captureEntry)
	scope:Observer(permTasksFuse):onChange(captureEntry)

	task.spawn(function()
		while not destroyed do
			task.wait(1)
			if destroyed then return end
			if not Fusion.peek(isAlive) then continue end
			nowValue:set(os.time())
		end
	end)

	local statusLabel = scope:Computed(function(use): string
		if use(isSavedMode) then
			return if use(savedEntry) ~= nil then "Perm" else "Ended"
		end
		local entry = use(liveEntry)
		if entry == nil then return "Ended" end
		if (entry :: any).isPaused == true then return "Paused" end
		local known = use(lastKnown)
		local entryBacked = typeof(known) == "table" and typeof((known :: any).entryUID) == "string"
		return if entryBacked then "Perm" else ""
	end)

	local commandText = scope:Computed(function(use): string
		local known = use(lastKnown)
		if typeof(known) ~= "table" then return "Task" end
		local baseName = tostring((known :: any).commandName or (known :: any).commandKey or "Task")
		return getTaskTitle(baseName, (known :: any).modifiers)
	end)
	local callerUserId = scope:Computed(function(use): number?
		local known = use(lastKnown)
		if typeof(known) ~= "table" then return nil end
		local id = (known :: any).callerUserId
		return if typeof(id) == "number" then id else nil
	end)
	-- Skipped for self-run tasks, the caller button already points at the same person
	local targetProfileUserId = scope:Computed(function(use): number?
		local known = use(lastKnown)
		if typeof(known) ~= "table" then return nil end
		local id = (known :: any).targetUserId
		if typeof(id) ~= "number" then return nil end
		if (known :: any).callerUserId == id then return nil end
		return id
	end)
	local callerText = scope:Computed(function(use): string
		local known = use(lastKnown)
		if typeof(known) ~= "table" then return "Unknown" end
		local id = (known :: any).callerUserId
		if typeof(id) ~= "number" then return "Server" end
		local displayName = tostring((known :: any).callerDisplayName or "")
		local name = tostring((known :: any).callerName or "")
		if displayName == "" then return tostring(id) end
		if name == "" then return displayName end
		return `{displayName} (@{name})`
	end)
	local targetText = scope:Computed(function(use): string
		local known = use(lastKnown)
		if typeof(known) ~= "table" then return "" end
		local targetName = (known :: any).targetName
		return if typeof(targetName) == "string" then targetName else ""
	end)
	local hasTarget = scope:Computed(function(use): boolean
		local known = use(lastKnown)
		return typeof(known) == "table" and (known :: any).targetUserId ~= nil
	end)
	local startedText = scope:Computed(function(use): string
		local known = use(lastKnown)
		if typeof(known) ~= "table" then return "Unknown" end
		local startedAt = tonumber((known :: any).startedAt)
		if not startedAt then return "Unknown" end
		local now = use(nowValue)
		local relative = formatRelativePast(startedAt :: number, now)
		local absolute = formatAbsolute(startedAt :: number)
		if relative == "" then return absolute end
		return `{relative} ({absolute})`
	end)

	local reappliesText = scope:Computed(function(use): string
		if not use(isSavedMode) then return "" end
		local known = use(lastKnown)
		local kind = if typeof(known) == "table" then (known :: any).kind else nil
		if kind == "permPinned" then
			return "Whenever they join any server"
		elseif kind == "joinPlayers" then
			return "For every player who joins any server"
		elseif kind == "joinServer" then
			return "On every server startup"
		end
		return ""
	end)

	local argsText = scope:Computed(function(use): string
		local known = use(lastKnown)
		return if typeof(known) == "table" then formatTokens((known :: any).args) else ""
	end)
	local qualifiersText = scope:Computed(function(use): string
		local known = use(lastKnown)
		return if typeof(known) == "table" then formatTokens((known :: any).qualifiers) else ""
	end)
	local modifiersText = scope:Computed(function(use): string
		local known = use(lastKnown)
		return if typeof(known) == "table" then formatTokens((known :: any).modifiers) else ""
	end)

	local isPending: Fusion.Value<boolean> = scope:Value(false)
	local function cancelTask()
		if Fusion.peek(isPending) then return end
		isPending:set(true)
		local isSaved = Fusion.peek(isSavedMode)
		task.spawn(function()
			local remote = Remote.get("EditTask")
			local ok, err = remote:invokeServerAsync(taskUID, if isSaved then "removeEntry" else "cancel")
			if destroyed then return end
			isPending:set(false)
			if not ok then
				local fallback = if isSaved then "Failed to remove perm task" else "Failed to cancel task"
				Prompt.error(tostring(err or fallback))
			end
		end)
	end

	local canCancel = scope:Computed(function(use): boolean
		return use(canEditTasks) and use(isAlive)
	end)

	-- Cancelling an entry-backed task ends it on every server, so the button says so
	local isEntryBacked = scope:Computed(function(use): boolean
		local known = use(lastKnown)
		return typeof(known) == "table" and typeof((known :: any).entryUID) == "string"
	end)

	-- Only the original caller can pull the action card back up
	local localUserId = if Players.LocalPlayer then Players.LocalPlayer.UserId else 0
	local canRetrievePrompt = scope:Computed(function(use): boolean
		if use(isSavedMode) or not use(isAlive) then
			return false
		end
		local known = use(lastKnown)
		if typeof(known) ~= "table" then
			return false
		end
		return (known :: any).hasPrompt == true and (known :: any).callerUserId == localUserId
	end)
	local isRetrieving: Fusion.Value<boolean> = scope:Value(false)
	local function retrievePrompt()
		if Fusion.peek(isRetrieving) then return end
		isRetrieving:set(true)
		task.spawn(function()
			local remote = Remote.get("EditTask")
			local ok, err = remote:invokeServerAsync(taskUID, "retrievePrompt")
			if destroyed then return end
			isRetrieving:set(false)
			if not ok then
				Prompt.error(tostring(err or "Failed to open controls"))
			end
		end)
	end


	-- LOCAL FUNCTIONS
	local function fieldRow(layoutOrder: number, label: string, valueText: any, visible: any?): Instance
		return scope:New "Frame" {
			Name = "Field_" .. label,
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = layoutOrder,
			Size = UDim2.new(1, 0, 0, 0),
			Visible = visible,
			[Children] = {
				scope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					VerticalAlignment = Enum.VerticalAlignment.Top,
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				scope:New "TextLabel" {
					Name = "Label",
					LayoutOrder = 1,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
					end),
					Size = UDim2.new(0, 76, 0, 0),
					Text = label .. ":",
					TextColor3 = Theme.Color.NeutralContentDark,
					TextSize = Theme.TextSize.Label,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
				},
				scope:New "TextLabel" {
					Name = "Value",
					LayoutOrder = 2,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
					end),
					Size = UDim2.new(1, -84, 0, 0),
					Text = valueText,
					TextColor3 = Theme.Color.BaseContent,
					TextSize = Theme.TextSize.Label,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
				},
			},
		}
	end

	local function actionButton(layoutOrder: number, labelText: any, enabled: any, visible: any, isAccent: boolean, onActivate: () -> ()): Instance
		return Pressable(scope, {
			name = "ActionButton",
			layoutOrder = layoutOrder,
			size = UDim2.fromOffset(0, 0),
			automaticSize = Enum.AutomaticSize.Y,
			visible = visible,
			backgroundColor = scope:Computed(function(use)
				if not use(enabled) then return use(Theme.Color.NeutralContent) end
				return if isAccent then use(Theme.Color.Primary) else use(Theme.Color.NeutralContent)
			end),
			interactable = enabled,
			onActivate = onActivate,
			[Children] = {
				scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
				scope:New "UIPadding" {
					PaddingLeft = UDim.new(0, 18),
					PaddingRight = UDim.new(0, 18),
					PaddingTop = UDim.new(0, 6),
					PaddingBottom = UDim.new(0, 6),
				},
				scope:New "TextLabel" {
					Name = "Label",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
					end),
					Size = UDim2.new(1, 0, 0, 0),
					Text = labelText,
					TextColor3 = scope:Computed(function(use)
						if not use(enabled) then return use(Theme.Color.NeutralContentDark) end
						return if isAccent then use(Theme.Color.PrimaryContent) else use(Theme.Color.BaseContent)
					end),
					TextSize = Theme.TextSize.Body,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center,
				},
			},
		})
	end


	-- BODY
	return scope:New "Frame" {
		Name = "TaskBody",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Theme.Color.Neutral,
		LayoutOrder = props.layoutOrder or 0,
		Size = UDim2.new(1, 0, 0, 0),

		[Children] = {
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
				Transparency = 0.5,
			},
			scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			scope:New "UIPadding" {
				PaddingLeft = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 12),
				PaddingTop = UDim.new(0, 10),
				PaddingBottom = UDim.new(0, 10),
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			scope:New "Frame" {
				Name = "Title",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				Size = UDim2.new(1, 0, 0, 0),
				Visible = scope:Computed(function(use): boolean
					return use(statusLabel) ~= ""
				end),
				[Children] = {
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						SortOrder = Enum.SortOrder.LayoutOrder,
					},

					scope:New "Frame" {
						Name = "StatusPill",
						LayoutOrder = 1,
						AutomaticSize = Enum.AutomaticSize.X,
						BackgroundColor3 = Theme.Color.Primary,
						Size = UDim2.new(0, 0, 0, 22),
						[Children] = {
							scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
							scope:New "UIPadding" {
								PaddingLeft = UDim.new(0, 10),
								PaddingRight = UDim.new(0, 10),
							},
							scope:New "TextLabel" {
								Name = "Label",
								AutomaticSize = Enum.AutomaticSize.X,
								BackgroundTransparency = 1,
								FontFace = scope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
								end),
								Size = UDim2.new(0, 0, 1, 0),
								Text = statusLabel,
								TextColor3 = Theme.Color.PrimaryContent,
								TextSize = Theme.TextSize.Label,
							},
						},
					},
				},
			},

			fieldRow(2, "Name", commandText, nil),
			fieldRow(3, "Caller", callerText, nil),
			fieldRow(4, "Target", targetText, hasTarget),
			fieldRow(5, "Started", startedText, scope:Computed(function(use): boolean
				return not use(isSavedMode)
			end)),
			fieldRow(6, "Created", startedText, isSavedMode),
			fieldRow(7, "Reapplies", reappliesText, scope:Computed(function(use): boolean
				return use(reappliesText) ~= ""
			end)),
			fieldRow(8, "Args", argsText, scope:Computed(function(use): boolean
				return use(argsText) ~= ""
			end)),
			fieldRow(9, "Qualifiers", qualifiersText, scope:Computed(function(use): boolean
				return use(qualifiersText) ~= ""
			end)),
			fieldRow(10, "Modifiers", modifiersText, scope:Computed(function(use): boolean
				return use(modifiersText) ~= ""
			end)),
			fieldRow(11, "Task ID", taskUID, nil),

			scope:New "Frame" {
				Name = "ActionFooter",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 12,
				Size = UDim2.new(1, 0, 0, 0),
				[Children] = {
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						Padding = UDim.new(0, 4),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},

					actionButton(1,
						scope:Computed(function(use): string
							return if use(isRetrieving) then "Opening..." else "Edit Command"
						end),
						scope:Computed(function(use): boolean
							return use(canRetrievePrompt) and not use(isRetrieving)
						end),
						canRetrievePrompt,
						false,
						retrievePrompt),

					actionButton(2,
						scope:Computed(function(): string return "View Caller's Profile" end),
						scope:Computed(function(use): boolean
							return use(callerUserId) ~= nil
						end),
						scope:Computed(function(use): boolean
							return use(callerUserId) ~= nil and onOpenProfile ~= nil
						end),
						false,
						function()
							local id = Fusion.peek(callerUserId)
							if typeof(id) == "number" and onOpenProfile then
								onOpenProfile(id)
							end
						end),

					actionButton(3,
						scope:Computed(function(): string return "View Target's Profile" end),
						scope:Computed(function(use): boolean
							return use(targetProfileUserId) ~= nil
						end),
						scope:Computed(function(use): boolean
							return use(targetProfileUserId) ~= nil and onOpenProfile ~= nil
						end),
						false,
						function()
							local id = Fusion.peek(targetProfileUserId)
							if typeof(id) == "number" and onOpenProfile then
								onOpenProfile(id)
							end
						end),

					actionButton(4,
						scope:Computed(function(use): string
							if use(isSavedMode) then
								return if use(isPending) then "Removing..." else "Remove Perm Task"
							end
							if use(isPending) then return "Cancelling..." end
							return if use(isEntryBacked) then "Cancel Task (All Servers)" else "Cancel Task"
						end),
						scope:Computed(function(use): boolean
							return use(canCancel) and not use(isPending)
						end),
						canCancel,
						true,
						cancelTask),

					scope:New "TextLabel" {
						Name = "FooterNote",
						LayoutOrder = 5,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						FontFace = scope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
						end),
						Size = UDim2.new(1, 0, 0, 0),
						Text = scope:Computed(function(use): string
							return if use(isSavedMode) then "This perm task has ended" else "This task has ended"
						end),
						TextColor3 = Theme.Color.NeutralContentDark,
						TextSize = Theme.TextSize.Small,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Center,
						Visible = scope:Computed(function(use): boolean
							return not use(isAlive)
						end),
					},
				},
			},
		},
	}
end

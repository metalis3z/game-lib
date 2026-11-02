--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local SplitRow = require(frontend.Components.SplitRow)
local UserDetails = require(frontend.Components.UserDetails)
local ScrollList = require(frontend.Components.ScrollList)
local SearchBar = require(frontend.Components.SearchBar)
local LoadingSpinner = require(frontend.Components.LoadingSpinner)
local NoPermissionPlaceholder = require(frontend.Components.NoPermissionPlaceholder)
local Icons = require(frontend.Config.Icons)
local Permissions = require(frontend.Util.Permissions)
local getTaskTitle = require(frontend.Util.getTaskTitle)
local Remote = require(modules.Objects.Remote)
local Prompt = require(modules.Prompt)
local Children = Fusion.Children


-- CONFIG
local GHOST_LINGER = 1 -- seconds an ended row lingers before dropping out
local SHOW_PAUSE_RESUME = false -- pause/resume stay hidden while the feature is refined


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	onTaskActivate: ((taskUID: string, snapshot: any?) -> ())?, -- snapshot carries display fields so the popup still renders for just-ended tasks
}
type TaskItem = {
	UID: string,
	commandName: string,
	callerUserId: number | string,
	callerName: string,
	callerDisplayName: string,
	targetUserId: number?,
	targetName: string?,
	targetUserName: string?,
	startedAt: number,
	args: any?,
	qualifiers: any?,
	modifiers: any?,
	order: number,
	isSaved: boolean?,
	kind: string?,
	entryUID: string?, -- live task spawned from a perm entry
}


-- HELPERS
local function formatElapsed(seconds: number): string
	if seconds < 0 then seconds = 0 end
	if seconds < 60 then
		return `{seconds}s`
	end
	if seconds < 3600 then
		local minutes = math.floor(seconds / 60)
		return `{minutes}m {seconds % 60}s`
	end
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	return `{hours}h {minutes}m`
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local youReady = Permissions.youReady(scope)
	local canViewTasks = Permissions.canViewPage(scope, "Tasks")
	local onTaskActivate = props.onTaskActivate

	-- Inside the body builder so the subscription only starts past the permission gate
	local function buildBody(bodyScope: Fusion.Scope): Instance
		local activeTasksFuse: any = (bodyScope :: any):Fuse("everyone", "ActiveTasks")
		local permTasksFuse: any = (bodyScope :: any):Fuse("everyone", "PermTasks")
		local canEditTasks = Permissions.hasPermission(bodyScope, "mayEditTasks")
		local searchText: Fusion.Value<string> = bodyScope:Value("")
		local nowValue: Fusion.Value<number> = bodyScope:Value(os.time())

		local destroyed = false
		table.insert(bodyScope, function() destroyed = true end)

		-- A plain Value rebuilt at most once per second, not a Computed on the fuse,
		-- so fast-churning servers can't reshape the list under the user's cursor
		local displayedItems: Fusion.Value<{TaskItem}> = bodyScope:Value({} :: {TaskItem})
		local entryCache: {[string]: TaskItem} = {}
		local ghostEndedAt: {[string]: number} = {}
		local nextOrder = 1
		local listDirty = false

		local function rebuildList()
			listDirty = false
			local feed = Fusion.peek(activeTasksFuse)
			if typeof(feed) ~= "table" then return end
			local clock = os.clock()
			local liveUIDs: {[string]: true} = {}
			local liveEntryUIDs: {[string]: true} = {}
			local newcomers: {TaskItem} = {}
			for UID, entry in feed :: {[string]: any} do
				if typeof(UID) ~= "string" or typeof(entry) ~= "table" then continue end
				liveUIDs[UID] = true
				ghostEndedAt[UID] = nil
				if typeof((entry :: any).entryUID) == "string" then
					liveEntryUIDs[(entry :: any).entryUID] = true
				end
				if not entryCache[UID] then
					local item: TaskItem = {
						UID = UID,
						commandName = tostring((entry :: any).commandName or (entry :: any).commandKey or "Unknown"),
						callerUserId = (entry :: any).callerUserId,
						callerName = tostring((entry :: any).callerName or ""),
						callerDisplayName = tostring((entry :: any).callerDisplayName or ""),
						targetUserId = (entry :: any).targetUserId,
						targetName = (entry :: any).targetName,
						targetUserName = (entry :: any).targetUserName,
						startedAt = tonumber((entry :: any).startedAt) or os.time(),
						args = (entry :: any).args,
						qualifiers = (entry :: any).qualifiers,
						modifiers = (entry :: any).modifiers,
						order = 0,
						entryUID = (entry :: any).entryUID,
					}
					entryCache[UID] = item
					table.insert(newcomers, item)
				end
			end
			-- Perm entries share the list, cancelling maps onto removeEntry
			local permFeed = Fusion.peek(permTasksFuse)
			if typeof(permFeed) == "table" then
				for UID, entry in permFeed :: {[string]: any} do
					if typeof(UID) ~= "string" or typeof(entry) ~= "table" then continue end
					-- The dormant row only appears once the live task is gone
					if liveEntryUIDs[UID] then
						local cached = entryCache[UID]
						if cached and cached.isSaved then
							entryCache[UID] = nil
							ghostEndedAt[UID] = nil
						end
						continue
					end
					liveUIDs[UID] = true
					ghostEndedAt[UID] = nil
					-- A dead live row would hold the slot showing Ended, so it hands it back
					local cached = entryCache[UID]
					if cached and not cached.isSaved then
						entryCache[UID] = nil
					end
					if not entryCache[UID] then
						local commandKey = tostring((entry :: any).commandKey or "Unknown")
						local item: TaskItem = {
							UID = UID,
							commandName = commandKey:sub(1, 1):upper() .. commandKey:sub(2),
							callerUserId = (entry :: any).callerUserId,
							callerName = tostring((entry :: any).callerName or ""),
							callerDisplayName = tostring((entry :: any).callerDisplayName or ""),
							targetUserId = (entry :: any).targetUserId,
							targetName = (entry :: any).targetName,
							targetUserName = (entry :: any).targetUserName,
							startedAt = tonumber((entry :: any).createdAt) or os.time(),
							args = (entry :: any).args,
							qualifiers = (entry :: any).qualifiers,
							modifiers = (entry :: any).modifiers,
							order = 0,
							isSaved = true,
							kind = tostring((entry :: any).kind or ""),
						}
						entryCache[UID] = item
						table.insert(newcomers, item)
					end
				end
			end
			-- Existing rows never move, newcomers take the next slots
			table.sort(newcomers, function(itemA, itemB)
				if itemA.startedAt == itemB.startedAt then return itemA.UID < itemB.UID end
				return itemA.startedAt < itemB.startedAt
			end)
			for _, item in newcomers do
				item.order = nextOrder
				nextOrder += 1
			end
			-- Ended tasks hold their slot for GHOST_LINGER so rows can't jump mid-aim
			local out: {TaskItem} = {}
			for UID, item in entryCache do
				if liveUIDs[UID] then
					table.insert(out, item)
					continue
				end
				local endedAt = ghostEndedAt[UID]
				if not endedAt then
					endedAt = clock
					ghostEndedAt[UID] = endedAt
				end
				if clock - (endedAt :: number) <= GHOST_LINGER then
					table.insert(out, item)
				else
					entryCache[UID] = nil
					ghostEndedAt[UID] = nil
				end
			end
			-- Perm tasks pin to the top so standing orders stay in view
			table.sort(out, function(itemA, itemB)
				local itemAIsPerm = itemA.isSaved == true or typeof(itemA.entryUID) == "string"
				local itemBIsPerm = itemB.isSaved == true or typeof(itemB.entryUID) == "string"
				if itemAIsPerm ~= itemBIsPerm then
					return itemAIsPerm
				end
				return itemA.order < itemB.order
			end)
			displayedItems:set(out)
		end

		-- Feed changes only mark dirty and the tick applies them, except an empty
		-- list where waiting a second would feel laggy for no benefit
		local function markDirty()
			listDirty = true
			if #Fusion.peek(displayedItems) == 0 then
				task.defer(function()
					if not destroyed and listDirty then rebuildList() end
				end)
			end
		end
		bodyScope:Observer(activeTasksFuse):onBind(markDirty)
		bodyScope:Observer(permTasksFuse):onBind(markDirty)

		task.spawn(function()
			while not destroyed do
				task.wait(1)
				if destroyed then return end
				local feed = Fusion.peek(activeTasksFuse)
				local permFeed = Fusion.peek(permTasksFuse)
				local hasLive = (typeof(feed) == "table" and next(feed) ~= nil)
					or (typeof(permFeed) == "table" and next(permFeed) ~= nil)
				local hasRows = #Fusion.peek(displayedItems) > 0
				if not hasLive and not hasRows and not listDirty then continue end
				nowValue:set(os.time())
				rebuildList()
			end
		end)

		local isReady = bodyScope:Computed(function(use): boolean
			return typeof(use(activeTasksFuse)) == "table"
		end)

		local visibleItems = bodyScope:Computed(function(use): {TaskItem}
			local all = use(displayedItems)
			local search = (use(searchText) or ""):lower()
			if search == "" then return all end
			local out: {TaskItem} = {}
			for _, item in all do
				if getTaskTitle(item.commandName, item.modifiers):lower():find(search, 1, true)
					or item.callerName:lower():find(search, 1, true)
					or item.callerDisplayName:lower():find(search, 1, true)
					or (typeof(item.targetName) == "string" and (item.targetName :: string):lower():find(search, 1, true)) then
					table.insert(out, item)
				end
			end
			return out
		end)

		local function editTask(taskUID: string, action: string, onDone: ((ok: boolean) -> ())?)
			task.spawn(function()
				local remote = Remote.get("EditTask")
				local ok, err = remote:invokeServerAsync(taskUID, action)
				if destroyed then return end
				if not ok then
					Prompt.error(tostring(err or "Failed to edit task"))
				end
				if onDone then onDone(ok) end
			end)
		end

		local function renderTaskRow(rowScope: Fusion.Scope, item: TaskItem): Instance
			local isSaved = item.isSaved == true
			local liveEntry = rowScope:Computed(function(use): any
				local feed = use(if isSaved then permTasksFuse else activeTasksFuse)
				if typeof(feed) ~= "table" then return nil end
				return (feed :: any)[item.UID]
			end)
			local hasEnded = rowScope:Computed(function(use): boolean
				return use(liveEntry) == nil
			end)
			local isPaused = rowScope:Computed(function(use): boolean
				local entry = use(liveEntry)
				return typeof(entry) == "table" and (entry :: any).isPaused == true
			end)
			local statusLabel = rowScope:Computed(function(use): string
				if use(hasEnded) then return "Ended" end
				if use(isPaused) then return "Paused" end
				return if isSaved or item.entryUID ~= nil then "Perm" else ""
			end)
			local elapsedText = rowScope:Computed(function(use): string
				if isSaved or use(hasEnded) then return "" end
				return formatElapsed(use(nowValue) - item.startedAt)
			end)
			local actionsVisible = rowScope:Computed(function(use): boolean
				return use(canEditTasks) and not use(hasEnded)
			end)

			local hasTarget = typeof(item.targetUserId) == "number"

			local inFlight = false

			local statusPill = rowScope:New "Frame" {
				Name = "StatusPill",
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundColor3 = Theme.Color.Primary,
				Size = UDim2.new(0, 0, 0, 22),
				Visible = rowScope:Computed(function(use): boolean
					return use(statusLabel) ~= ""
				end),
				[Children] = {
					rowScope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
					rowScope:New "UIPadding" {
						PaddingLeft = UDim.new(0, 10),
						PaddingRight = UDim.new(0, 10),
					},
					rowScope:New "TextLabel" {
						Name = "Label",
						AutomaticSize = Enum.AutomaticSize.X,
						BackgroundTransparency = 1,
						FontFace = rowScope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
						end),
						Size = UDim2.new(0, 0, 1, 0),
						Text = statusLabel,
						TextColor3 = Theme.Color.PrimaryContent,
						TextSize = Theme.TextSize.Label,
					},
				},
			}

			return SplitRow(rowScope, {
				name = "TaskRow_" .. item.UID,
				height = 46,
				layoutOrder = item.order,

				left = {
					name = "TaskRowSlot_" .. item.UID,
					fills = true,
					onActivate = function()
						if onTaskActivate then onTaskActivate(item.UID, item) end
					end,
					[Children] = {
						rowScope:New "Frame" {
							Name = "ContentGroup",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 12, 0.5, 0),
							Size = UDim2.new(1, -24, 1, 0),
							[Children] = {
								rowScope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									VerticalAlignment = Enum.VerticalAlignment.Center,
									Padding = UDim.new(0, 8),
									SortOrder = Enum.SortOrder.LayoutOrder,
								},
								(function()
									local details = UserDetails(rowScope, {
										userId = if hasTarget then item.targetUserId :: number else nil,
										iconImage = if hasTarget then nil else Icons.Server,
										iconImageInset = if hasTarget then nil else 5,
										-- The item keeps the raw name, only the row display bakes the modifiers in
										displayName = getTaskTitle(item.commandName, item.modifiers),
										username = if hasTarget then (item.targetUserName or item.targetName) else nil,
										layoutOrder = 1,
										iconSize = 32,
										singleLine = true,
									})
									local flex = rowScope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill }
									flex.Parent = details
									return details
								end)(),
								rowScope:New "TextLabel" {
									Name = "Elapsed",
									AutomaticSize = Enum.AutomaticSize.X,
									BackgroundTransparency = 1,
									LayoutOrder = 2,
									FontFace = rowScope:Computed(function(use)
										return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
									end),
									Size = UDim2.new(0, 0, 1, 0),
									Text = elapsedText,
									TextColor3 = Theme.Color.NeutralContentDark,
									TextSize = Theme.TextSize.Label,
								},
								-- Collapses with the pill so the timer sits flush right
								rowScope:New "Frame" {
									Name = "IndicatorSlot",
									AutomaticSize = Enum.AutomaticSize.XY,
									BackgroundTransparency = 1,
									LayoutOrder = 3,
									Visible = rowScope:Computed(function(use): boolean
										return use(statusLabel) ~= ""
									end),
									[Children] = { statusPill },
								},
							},
						},
					},
				},

				center = if not SHOW_PAUSE_RESUME then nil else ({
					name = "PauseSlot_" .. item.UID,
					width = 40,
					visible = actionsVisible,
					onActivate = function()
						if inFlight then return end
						inFlight = true
						local action = if Fusion.peek(isPaused) then "resume" else "pause"
						editTask(item.UID, action, function()
							inFlight = false
						end)
					end,
					[Children] = {
						rowScope:New "ImageLabel" {
							Name = "PlayIcon",
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundTransparency = 1,
							Position = UDim2.fromScale(0.5, 0.5),
							Size = UDim2.fromOffset(16, 16),
							Image = Icons.RunCommand,
							ImageColor3 = Theme.Color.BaseContent,
							Visible = isPaused,
						},
						-- Drawn pause bars, there's no PauseFill asset yet
						rowScope:New "Frame" {
							Name = "PauseIcon",
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundTransparency = 1,
							Position = UDim2.fromScale(0.5, 0.5),
							Size = UDim2.fromOffset(12, 14),
							Visible = rowScope:Computed(function(use): boolean
								return not use(isPaused)
							end),
							[Children] = {
								rowScope:New "Frame" {
									Name = "BarLeft",
									BackgroundColor3 = Theme.Color.BaseContent,
									BorderSizePixel = 0,
									Size = UDim2.new(0, 4, 1, 0),
									[Children] = {
										rowScope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
									},
								},
								rowScope:New "Frame" {
									Name = "BarRight",
									AnchorPoint = Vector2.new(1, 0),
									BackgroundColor3 = Theme.Color.BaseContent,
									BorderSizePixel = 0,
									Position = UDim2.fromScale(1, 0),
									Size = UDim2.new(0, 4, 1, 0),
									[Children] = {
										rowScope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
									},
								},
							},
						},
					},
				} :: any),

				right = {
					name = "CancelSlot_" .. item.UID,
					width = 40,
					visible = actionsVisible,
					onActivate = function()
						if inFlight then return end
						inFlight = true
						editTask(item.UID, if isSaved then "removeEntry" else "cancel", function()
							inFlight = false
						end)
					end,
					[Children] = {
						rowScope:New "ImageLabel" {
							Name = "CancelIcon",
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundTransparency = 1,
							Position = UDim2.fromScale(0.5, 0.5),
							Size = UDim2.fromOffset(14, 14),
							Image = Icons.StopFill,
							ImageColor3 = Theme.Color.BaseContent,
						},
					},
				},
			})
		end

		local emptyText = bodyScope:Computed(function(use): string
			if not use(isReady) then return "" end
			if #use(visibleItems) > 0 then return "" end
			local search = use(searchText)
			if typeof(search) == "string" and search ~= "" then
				return "No tasks match your search"
			end
			return "No tasks are currently running"
		end)

		return ScrollList(bodyScope, {
			isReady = isReady,
			items = displayedItems,
			visibleItems = visibleItems,
			useStream = false,
			renderItem = function(itemScope: Fusion.Scope, item: any): Instance
				return renderTaskRow(itemScope, item :: TaskItem)
			end,
			padding = UDim.new(0, 6),
			headerGap = UDim.new(0, 8),
			layoutOrder = 1,
			header = bodyScope:New "Frame" {
				Name = "HeaderArea",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 0,
				Size = UDim2.fromScale(1, 0),
				[Children] = {
					bodyScope:New "UIListLayout" {
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						Padding = UDim.new(0, 8),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					SearchBar(bodyScope, {
						searchText = searchText,
						placeholderText = "Search",
						layoutOrder = 1,
					}),
					bodyScope:New "TextLabel" {
						Name = "EmptyLabel",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						LayoutOrder = 2,
						FontFace = bodyScope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
						end),
						Size = UDim2.fromScale(1, 0),
						Text = emptyText,
						TextColor3 = Theme.Color.NeutralContentDark,
						TextSize = Theme.TextSize.Label,
						TextXAlignment = Enum.TextXAlignment.Center,
						Visible = bodyScope:Computed(function(use): boolean
							return use(emptyText) ~= ""
						end),
					},
				},
			},
		})
	end

	return scope:New "Frame" {
		Name = "TasksPage",
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

			-- The fuse only spins up for clients who can view this page
			scope:Computed(function(use, innerScope)
				if not use(youReady) then
					return LoadingSpinner(innerScope, { layoutOrder = 1 })
				end
				if not use(canViewTasks) then
					return innerScope:New "Frame" {
						Name = "Denied",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 160),
						[Children] = {
							NoPermissionPlaceholder(innerScope, {}),
						},
					}
				end
				return buildBody(innerScope)
			end),
		},
	}
end

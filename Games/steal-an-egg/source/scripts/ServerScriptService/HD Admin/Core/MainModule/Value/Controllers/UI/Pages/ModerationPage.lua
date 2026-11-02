--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local SplitRow = require(frontend.Components.SplitRow)
local UserDetails = require(frontend.Components.UserDetails)
local Checkbox = require(frontend.Components.Checkbox)
local Pressable = require(frontend.Components.Pressable)
local TabBar = require(frontend.Components.TabBar)
local TabbedScroller = require(frontend.Components.TabbedScroller)
local PlaceholderPage = require(frontend.Pages.PlaceholderPage)
local SearchBar = require(frontend.Components.SearchBar)
local LoadingGate = require(frontend.Components.LoadingGate)
local SearchRowToggle = require(frontend.Components.SearchRowToggle)
local Icons = require(frontend.Config.Icons)
local Permissions = require(frontend.Util.Permissions)
local NoPermissionPlaceholder = require(frontend.Components.NoPermissionPlaceholder)
local Remote = require(modules.Objects.Remote)
local Prompt = require(modules.Prompt)
local clientUser = require(modules.References.clientUser)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	tabUserIds: { UsedAs<{ number }> }?, -- override hook for tests; production reads from everyone.* feeds
	onUserActivate: UsedAs<(userId: number) -> ()>?, -- row activate (typically PanelGui's openProfile)
	onRunPageOpen: ((commandKey: string, opts: {autoOpenUserArg: boolean?}?) -> ())?, -- the SearchRow "+" launching ;ban
}


-- LOCAL FUNCTIONS
local TAB_DEFS: { TabBar.Tab } = {
	{ label = "Bans", icon = Icons.ProhibitedFill },
	{ label = "Warns", icon = Icons.WarningFill },
}

-- Priority order for the pill, loader is immutable from the UI
local INDICATOR_LABELS = {
	loader = "Loader",
	perm   = "Perm",
	expire = "Time",
	server = "Server",
}


-- COMPONENT
return function(scope: Scope, props: Props)
	-- A user can appear in both feeds, so dedupe by userId
	local serverBansFuse: any = (scope :: any):Fuse("everyone", "ServerBans")
	local permanentBansFuse: any = (scope :: any):Fuse("everyone", "PermanentBans")

	-- Warm the command info on mount so the first "+" press opens the picker instantly
	if props.onRunPageOpen then
		task.spawn(function()
			clientUser.everyone:fetchAsync("CommandInfo", "ban")
		end)
	end

	local bansUserIds = scope:Computed(function(use): { number }
		local server = use(serverBansFuse)
		local permanent = use(permanentBansFuse)
		local seen: { [number]: true } = {}
		local ids: { number } = {}
		for _, feed in { server, permanent } do
			if typeof(feed) ~= "table" then continue end
			for userIdStr, _ in feed :: { [string]: any } do
				local userId = tonumber(userIdStr)
				if userId and not seen[userId] then
					seen[userId] = true
					table.insert(ids, userId)
				end
			end
		end
		table.sort(ids)
		return ids
	end)

	local bansSearchText: Fusion.Value<string> = scope:Value("")

	local function lookupNames(userId: number): (string, string)
		local key = tostring(userId)
		for _, feed in { Fusion.peek(serverBansFuse), Fusion.peek(permanentBansFuse) } do
			if typeof(feed) ~= "table" then continue end
			local record = (feed :: any)[key]
			if typeof(record) ~= "table" then continue end
			local info = (record :: any).UserInfo
			if typeof(info) == "table" then
				local userName = tostring((info :: any).userName or "")
				local displayName = tostring((info :: any).userDisplayName or "")
				return userName, displayName
			end
		end
		return "", ""
	end

	local visibleBansUserIds = scope:Computed(function(use): { number }
		local all = use(bansUserIds)
		local search = (use(bansSearchText) or ""):lower()
		if search == "" then return all end
		-- Force a dependency on the feeds so CSC name changes re-filter
		use(serverBansFuse)
		use(permanentBansFuse)
		local out: { number } = {}
		for _, userId in all do
			local userName, displayName = lookupNames(userId)
			if userName:lower():find(search, 1, true)
				or displayName:lower():find(search, 1, true)
				or tostring(userId):find(search, 1, true) then
				table.insert(out, userId)
			end
		end
		return out
	end)

	local bansEmptyText = scope:Computed(function(use): string
		if typeof(use(serverBansFuse)) ~= "table" or typeof(use(permanentBansFuse)) ~= "table" then return "" end
		if #use(visibleBansUserIds) > 0 then return "" end
		if (use(bansSearchText) or "") ~= "" then
			return "No users match your search"
		end
		return "No users are currently banned"
	end)

	-- Warns has no backend yet, the tab renders the coming-soon placeholder
	local fallbackWarnUserIds: Fusion.Value<{ number }> = scope:Value({} :: { number })
	local tabUserIds = props.tabUserIds
		or ({ visibleBansUserIds, fallbackWarnUserIds } :: { any })
	local onUserActivate = props.onUserActivate
	local activeTab: Fusion.Value<number> = scope:Value(1)

	-- Expired entries are skipped so stale stacked records don't keep the pill lit
	local function resolveIndicatorKey(userId: number, server: any, permanent: any): string?
		local now = os.time()
		local hasLoader, hasPerm, hasExpire, hasServer = false, false, false, false
		for _, feed in { server, permanent } do
			if typeof(feed) ~= "table" then continue end
			local record = (feed :: any)[tostring(userId)]
			if typeof(record) ~= "table" then continue end
			local bans = (record :: any).Bans
			if typeof(bans) ~= "table" then continue end
			for _, entry in bans :: any do
				if typeof(entry) ~= "table" then continue end
				local entryType = (entry :: any).type or "perm"
				if entryType == "expire" then
					local exp = (entry :: any).expiresAt
					if typeof(exp) ~= "number" or exp <= now then continue end
				end
				if (entry :: any).source == "loader" then hasLoader = true end
				if (entry :: any).source == "admin" then
					if entryType == "perm" then hasPerm = true end
					if entryType == "expire" then hasExpire = true end
					if entryType == "server" then hasServer = true end
				end
			end
		end
		if hasLoader then return "loader" end
		if hasPerm then return "perm" end
		if hasExpire then return "expire" end
		if hasServer then return "server" end
		return nil
	end

	-- Cleared on tab switch and on a successful bulk action
	local selection: Fusion.Value<{ number }> = scope:Value({} :: { number })

	local function toggleSelection(userId: number, checked: boolean)
		local current = table.clone(Fusion.peek(selection))
		if checked then
			if not table.find(current, userId) then table.insert(current, userId) end
		else
			local idx = table.find(current, userId)
			if idx then table.remove(current, idx) end
		end
		selection:set(current)
	end

	-- Loader bans are immutable from the UI, so their checkbox disables
	local function isLoaderOnly(userId: number, server: any, permanent: any): boolean
		local hasAdmin, hasAny = false, false
		for _, feed in { server, permanent } do
			if typeof(feed) ~= "table" then continue end
			local record = (feed :: any)[tostring(userId)]
			if typeof(record) ~= "table" then continue end
			local bans = (record :: any).Bans
			if typeof(bans) ~= "table" then continue end
			for _, entry in bans :: any do
				if typeof(entry) ~= "table" then continue end
				hasAny = true
				if (entry :: any).source == "admin" then hasAdmin = true end
			end
		end
		return hasAny and not hasAdmin
	end


	local function renderBanRow(rowScope: Fusion.Scope, userId: number, layoutOrder: Fusion.UsedAs<number>): Instance
		local displayName = rowScope:Computed(function(use): string?
			for _, feed in { use(serverBansFuse), use(permanentBansFuse) } do
				if typeof(feed) ~= "table" then continue end
				local record = (feed :: any)[tostring(userId)]
				if typeof(record) == "table" then
					local info = (record :: any).UserInfo
					if typeof(info) == "table" then
						return tostring((info :: any).userDisplayName or "") :: any
					end
				end
			end
			return nil
		end)
		local userName = rowScope:Computed(function(use): string?
			for _, feed in { use(serverBansFuse), use(permanentBansFuse) } do
				if typeof(feed) ~= "table" then continue end
				local record = (feed :: any)[tostring(userId)]
				if typeof(record) == "table" then
					local info = (record :: any).UserInfo
					if typeof(info) == "table" then
						return tostring((info :: any).userName or "") :: any
					end
				end
			end
			return nil
		end)

		local indicatorKey = rowScope:Computed(function(use): string?
			return resolveIndicatorKey(userId, use(serverBansFuse), use(permanentBansFuse))
		end)
		local indicatorLabel = rowScope:Computed(function(use): string
			local key = use(indicatorKey)
			if not key then return "" end
			return (INDICATOR_LABELS :: any)[key] or ""
		end)

		local indicatorPill = rowScope:New "Frame" {
			Name = "TypeIndicator",
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = Theme.Color.Primary,
			Size = UDim2.new(0, 0, 0, 22),
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
					Text = indicatorLabel,
					-- PrimaryContent pairs with Primary, white-on-purple is wrong on light themes
					TextColor3 = Theme.Color.PrimaryContent,
					TextSize = Theme.TextSize.Label,
				},
			},
		}

		local isChecked = rowScope:Computed(function(use): boolean
			return table.find(use(selection), userId) ~= nil
		end)
		local loaderOnly = rowScope:Computed(function(use): boolean
			return isLoaderOnly(userId, use(serverBansFuse), use(permanentBansFuse))
		end)
		local checkboxInteractable = rowScope:Computed(function(use): boolean
			return not use(loaderOnly)
		end)

		-- No CanvasGroup, it clipped the stroke at small sizes and costs a 2D render target
		local checkboxVisual = rowScope:New "Frame" {
			Name = "CheckboxWrap",
			AnchorPoint = Vector2.new(0.5, 0.5),
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.53, 0.5),
			Size = UDim2.fromOffset(0, 0),
			[Children] = {
				Checkbox(rowScope, {
					checked = isChecked,
					disabled = loaderOnly,
				}),
			},
		}

		return SplitRow(rowScope, {
			name = "BanRow_" .. tostring(userId),
			height = 46,
			layoutOrder = layoutOrder,

			left = { -- 36px fits the 18px checkbox; default square sizing made this column twice as wide
				name = "CheckboxSlot_" .. tostring(userId),
				width = 36,
				interactable = checkboxInteractable,
				onActivate = function()
					if not Fusion.peek(checkboxInteractable) then return end
					toggleSelection(userId, not Fusion.peek(isChecked))
				end,
				[Children] = { checkboxVisual },
			},

			center = { -- fills the rest; activates open-profile
				name = "BanRowSlot_" .. tostring(userId),
				fills = true,
				onActivate = function()
					local callback = onUserActivate
					if callback then
						local handler = if typeof(callback) == "table" then Fusion.peek(callback) else callback
						if handler then handler(userId) end
					end
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
									userId = userId,
									displayName = displayName,
									username = userName,
									layoutOrder = 1,
									iconSize = 32,
									singleLine = true,
								})
								local flex = rowScope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill }
								flex.Parent = details
								return details
							end)(),
							rowScope:New "Frame" {
								Name = "IndicatorSlot",
								AutomaticSize = Enum.AutomaticSize.XY,
								BackgroundTransparency = 1,
								LayoutOrder = 2,
								[Children] = { indicatorPill },
							},
						},
					},
				},
			},
		})
	end

	local function buildTabContent(innerScope: Fusion.Scope, tabIdx: number): any
		local userIds: any = tabUserIds[tabIdx] or innerScope:Value({} :: { number })
		-- ForValues gives no index, so rows read their position from this map and
		-- sorted order survives cross-server arrivals without rebuilding rows
		local orderByUserId = innerScope:Computed(function(use): {[number]: number}
			local map: {[number]: number} = {}
			for index, userId in use(userIds) :: {number} do
				map[userId] = index
			end
			return map
		end)
		return innerScope:New "Frame" {
			Name = "UserList_" .. tabIdx,
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0),
			[Children] = {
				innerScope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = UDim.new(0, 6),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				innerScope:ForValues(userIds, function(_, rowScope, userId: number)
					local rowOrder = rowScope:Computed(function(use): number
						return (use(orderByUserId) :: {[number]: number})[userId] or 0
					end)
					return renderBanRow(rowScope, userId, rowOrder)
				end),
			},
		}
	end


	-- IDLE -> ARMED -> PENDING, same shape as the BanBanner's confirmation flow
	local destroyed = false
	table.insert(scope, function() destroyed = true end)

	scope:Observer(activeTab):onChange(function()
		selection:set({})
	end)

	-- The selection minus loader-only entries, what the bulk action would actually clear
	local actionableSelection = scope:Computed(function(use): { number }
		local sel = use(selection)
		local server = use(serverBansFuse)
		local permanent = use(permanentBansFuse)
		local out: { number } = {}
		for _, uid in sel do
			if not isLoaderOnly(uid, server, permanent) then
				table.insert(out, uid)
			end
		end
		return out
	end)
	local hasActionableSelection = scope:Computed(function(use): boolean
		return #use(actionableSelection) > 0
	end)
	local selectionCount = scope:Computed(function(use): number
		return #use(selection)
	end)

	local isArmed: Fusion.Value<boolean> = scope:Value(false)
	local isPending: Fusion.Value<boolean> = scope:Value(false)
	local armToken = 0
	local function disarm()
		armToken += 1
		isArmed:set(false)
	end
	local function arm()
		armToken += 1
		local thisToken = armToken
		isArmed:set(true)
		task.delay(2, function()
			if destroyed then return end
			if armToken ~= thisToken then return end
			isArmed:set(false)
		end)
	end
	-- A selection change while armed would target a set the user never agreed to
	scope:Observer(selection):onChange(function()
		if Fusion.peek(isArmed) then disarm() end
	end)

	local function runBulkUnban()
		if Fusion.peek(isPending) then return end
		local actionable = Fusion.peek(actionableSelection)
		if #actionable == 0 then return end
		if not Fusion.peek(isArmed) then
			arm()
			return
		end
		disarm()
		isPending:set(true)
		task.spawn(function()
			local remote = Remote.get("UnbanUser")
			if not remote then
				if destroyed then return end
				isPending:set(false)
				Prompt.error("Unban remote not available")
				return
			end
			local successes, failures = 0, {} :: { string }
			for _, userId in actionable do
				if destroyed then return end
				-- nil banId wipes every stacked entry so one click fully clears them
				local ok, err = remote:invokeServerAsync(userId, nil)
				if ok then
					successes += 1
				else
					table.insert(failures, `{userId} ({tostring(err)})`)
				end
			end
			if destroyed then return end
			isPending:set(false)
			if successes > 0 then
				Prompt.success(`Unbanned {successes} {if successes == 1 then "user" else "users"}`)
			end
			if #failures > 0 then
				Prompt.error(`Failed: {table.concat(failures, ", ")}`)
			end
			selection:set({})
		end)
	end

	local bulkLabel = scope:Computed(function(use): string
		if use(isPending) then
			return `Unbanning ({#use(actionableSelection)})...`
		end
		if use(isArmed) then return "Confirm?" end
		return `Unban ({use(selectionCount)})`
	end)

	-- Present only while something is selected, vacating the footer gives the
	-- scroll area its full height back
	local popupHeight = scope:Computed(function(use): number
		return if use(selectionCount) > 0 then 50 else 0
	end)

	local bulkActionSlot = scope:New "Frame" {
		Name = "BulkActionSlot",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Visible = scope:Computed(function(use)
			return use(selectionCount) > 0
		end),
		[Children] = {
			scope:New "UIPadding" {
				PaddingTop = UDim.new(0, 8),
			},
			Pressable(scope, {
				name = "BulkUnbanButton",
				size = UDim2.new(1, 0, 0, 0),
				automaticSize = Enum.AutomaticSize.Y,
				backgroundColor = scope:Computed(function(use): Color3
					return if use(hasActionableSelection)
						then use(Theme.Color.Primary)
						else use(Theme.Color.NeutralContent)
				end),
				interactable = scope:Computed(function(use): boolean
					return use(hasActionableSelection) and not use(isPending)
				end),
				onActivate = runBulkUnban,
				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
					scope:New "UIPadding" {
						PaddingTop = UDim.new(0, 10),
						PaddingBottom = UDim.new(0, 10),
						PaddingLeft = UDim.new(0, 18),
						PaddingRight = UDim.new(0, 18),
					},
					scope:New "TextLabel" {
						Name = "Label",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						FontFace = scope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
						end),
						Size = UDim2.new(1, 0, 0, 0),
						Text = bulkLabel,
						TextColor3 = scope:Computed(function(use): Color3
							return if use(hasActionableSelection)
								then use(Theme.Color.PrimaryContent)
								else use(Theme.Color.NeutralContentDark)
						end),
						TextSize = Theme.TextSize.Body,
						TextXAlignment = Enum.TextXAlignment.Center,
						TextYAlignment = Enum.TextYAlignment.Center,
					},
				},
			}),
		},
	}


	-- Denied tabs swap to a placeholder body but the tab bar stays visible
	local canViewByTab = {
		[1] = Permissions.canViewPage(scope, "Bans"),
		[2] = Permissions.canViewPage(scope, "Warns"),
	}

	return scope:New "Frame" {
		Name = "ModerationPage",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),

		[Children] = {
			TabbedScroller(scope, {
				tabs = TAB_DEFS,
				activeTabRef = activeTab,
				buildTabContent = function(innerScope: Fusion.Scope, tabIdx: number): any
					local canView = canViewByTab[tabIdx]
					local body
					if tabIdx == 2 then
						body = PlaceholderPage(innerScope, { pageName = "Warns", centered = true })
					else
						local list = buildTabContent(innerScope, tabIdx)
						body = innerScope:New "Frame" {
							Name = "BansWithSearch",
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 0),
							[Children] = {
								innerScope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Vertical,
									HorizontalFlex = Enum.UIFlexAlignment.Fill,
									SortOrder = Enum.SortOrder.LayoutOrder,
									Padding = UDim.new(0, 8),
								},
								SearchBar(innerScope, {
									searchText = bansSearchText,
									placeholderText = "Search",
									layoutOrder = 0,
									leadingSlot = SearchRowToggle(innerScope, {
										name = "BanToggle",
										icon = Icons.AddFill,
										iconSize = UDim2.fromOffset(14, 14),
										onActivate = function()
											if props.onRunPageOpen then
												(props.onRunPageOpen :: (string, any?) -> ())("ban", {autoOpenUserArg = true})
											end
										end,
									}),
									leadingSlotVisible = innerScope:Computed(function(): boolean
										return props.onRunPageOpen ~= nil
									end),
								}),
								innerScope:New "TextLabel" {
									Name = "EmptyLabel",
									AutomaticSize = Enum.AutomaticSize.Y,
									BackgroundTransparency = 1,
									LayoutOrder = 1,
									FontFace = innerScope:Computed(function(use)
										return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
									end),
									Size = UDim2.fromScale(1, 0),
									Text = bansEmptyText,
									TextColor3 = Theme.Color.NeutralContentDark,
									TextSize = Theme.TextSize.Label,
									TextXAlignment = Enum.TextXAlignment.Center,
									Visible = innerScope:Computed(function(use): boolean
										return use(bansEmptyText) ~= ""
									end),
								},
								innerScope:New "Frame" {
									Name = "ListWrap",
									AutomaticSize = Enum.AutomaticSize.Y,
									BackgroundTransparency = 1,
									LayoutOrder = 2,
									Size = UDim2.fromScale(1, 0),
									[Children] = {
										LoadingGate(innerScope, {
											isReady = innerScope:Computed(function(use)
												return typeof(use(serverBansFuse)) == "table" and typeof(use(permanentBansFuse)) == "table"
											end),
											[Children] = { list },
										}),
									},
								},
							},
						}
					end
					return innerScope:New "Frame" {
						Name = "TabGate_" .. tabIdx,
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						AutomaticSize = Enum.AutomaticSize.Y,
						[Children] = {
							innerScope:New "Frame" {
								Name = "Body",
								BackgroundTransparency = 1,
								Size = UDim2.fromScale(1, 1),
								AutomaticSize = Enum.AutomaticSize.Y,
								Visible = canView,
								[Children] = { body },
							},
							innerScope:New "Frame" {
								Name = "Denied",
								BackgroundTransparency = 1,
								Size = UDim2.new(1, 0, 0, 160),
								Visible = innerScope:Computed(function(use): boolean
									return not use(canView)
								end),
								[Children] = {
									NoPermissionPlaceholder(innerScope, {}),
								},
							},
						},
					}
				end,
				footerSlot = bulkActionSlot,
				footerHeight = popupHeight,
			}),
		},
	}
end

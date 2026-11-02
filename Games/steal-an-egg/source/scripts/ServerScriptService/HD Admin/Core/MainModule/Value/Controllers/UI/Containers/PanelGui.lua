--!strict
-- CONFIG
local MIN_CONTENT_HEIGHT = 120


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Viewport = require(frontend.Config.Viewport)
local Children = Fusion.Children
local Out = Fusion.Out
local TitleBar = require(script.Parent.TitleBar)
local PanelState = require(frontend.Config.PanelState)
local Pages = require(frontend.Config.Pages)
local PlaceholderPage = require(frontend.Pages.PlaceholderPage)
local ProfileBody = require(frontend.Components.ProfileBody)
local TaskBody = require(frontend.Components.TaskBody)
local EmotesPage = require(frontend.Pages.EmotesPage)
local CommandsPopupPage = require(frontend.Pages.CommandsPopupPage)
local BoosterPage = require(frontend.Pages.BoosterPage)
local OutfitsPage = require(frontend.Pages.OutfitsPage)
local Navigate = require(frontend.Util.Navigate)
local Panels = require(frontend.Config.Panels)
local LayerOrder = require(frontend.Config.LayerOrder)
local Platform = require(frontend.Util.Platform)
local PreviewBanner = require(frontend.Components.PreviewBanner)
local UpdateBanner = require(frontend.Components.UpdateBanner)
local UpdateLogPopup = require(frontend.Components.UpdateLogPopup)
local LoadingSpinner = require(frontend.Components.LoadingSpinner)
local Permissions = require(frontend.Util.Permissions)
local HintBubble = require(frontend.Util.HintBubble)


-- LOCAL FUNCTIONS
local PAGES: {[string]: ((Scope: any, props: any) -> any)?} = {}
local function getPage(id: string): ((Scope: any, props: any) -> any)?
	if PAGES[id] == nil then
		local mod = frontend.Pages:FindFirstChild(id .. "Page")
		if mod then
			local ok, result = pcall(require, mod :: ModuleScript)
			PAGES[id] = if ok and typeof(result) == "function" then result else false :: any
			if not ok then
				warn(`[PanelGui] Failed to load page '{id}': {result}`)
			end
		else
			PAGES[id] = false :: any
		end
	end
	return if PAGES[id] then PAGES[id] else nil
end


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	position: UsedAs<UDim2>?,
	visible: UsedAs<boolean>?,
	initialPage: string?,
	onClose: (() -> ())?,
	mode: ("fixed" | "fitContent")?, -- fitContent = popup that auto-sizes to the page; default fixed (full nav, drag-resize, expander)
	profilePanel: Panels.ProfilePanel?, -- fitContent only
	dragOffset: Fusion.Value<Vector2>?, -- lifted so callers can read/reset the drag; made internally when omitted
}


-- COMPONENT
return function(scope: Scope, props: Props)
	-- Popup variant with no nav history or drag-resize, spawned per entry from Panels
	if props.mode == "fitContent" then
		local panel = props.profilePanel
		local isOpen = scope:Computed(function(use)
			local visible = props.visible
			if typeof(visible) == "table" then return use(visible :: any) end
			return if visible == nil then true else visible
		end)

		-- Lifted from the Panel descriptor so Panels can peek it when cascading the next open
		local dragOffset: Fusion.Value<Vector2> = props.dragOffset or scope:Value(Vector2.zero)
		local panelPos = scope:Computed(function(use)
			local raw = props.position
			local base = if typeof(raw) == "table" then use(raw :: any) else (raw or UDim2.fromScale(0.5, 0.5))
			local off = use(dragOffset)
			return base + UDim2.fromOffset(off.X, off.Y)
		end)

		-- AddRolePopup renders in here. Active=false so clicks reach the badges underneath
		local popupOverlay = scope:New "Frame" {
			Name = "PopupOverlay",
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 100,
		}
		local panelKind: string = if panel then ((panel :: any).kind or "profile") else "profile"
		local isPreview = panelKind == "preview"
		local isTask = panelKind == "task"
		local isEmotes = panelKind == "emotes"
		local isCommands = panelKind == "commands"
		local isBooster = panelKind == "booster"
		local isOutfits = panelKind == "outfits"
		local isFixedHeightKind = isPreview or isEmotes or isCommands or isBooster or isOutfits
		local panelBody: any
		local titleValue: any
		local canGoBack: any = false
		local onBack: (() -> ())? = nil

		if isPreview then
			local commandKey = if panel then ((panel :: any).previewCommandKey or "") else ""
			local commandKeyValue: Fusion.Value<string> = scope:Value(commandKey)

			local panelState = PanelState.new(scope)
			panelState.page:set("Run")
			panelState.pageHistory:set({ "Run" })

			local visitedPages: Fusion.Value<{string}> = scope:Value({ "Run" })
			local function navigateTo(pageId: string)
				local visited = Fusion.peek(visitedPages)
				if not table.find(visited, pageId) then
					local newVisited = table.clone(visited)
					table.insert(newVisited, pageId)
					visitedPages:set(newVisited)
				end
				panelState:toPage(pageId)
			end

			-- RunPage's picker writes this before navigating, ItemSelector reads it
			local itemSelectorConfig: Fusion.Value<any?> = scope:Value(nil :: any?)
			local sharedCustomUsers: Fusion.Value<{ [string]: any }> = scope:Value({})

			local pagePropsMap: {[string]: any} = {
				Run = {
					commandKey = commandKeyValue,
					initialArgTokens = if panel then (panel :: any).previewArgTokens else nil,
					initialModifierTokens = if panel then (panel :: any).previewModifierTokens else nil,
					sharedCustomUsers = sharedCustomUsers,
					onItemSelectorOpen = function(config: any)
						itemSelectorConfig:set(config)
						navigateTo("ItemSelector")
					end,
				},
				ItemSelector = {
					config = itemSelectorConfig,
					onConfirmBack = function() panelState:goBack() end,
				},
			}

			-- Mirrors the main buildPageSlide minus the youReady gating
			local function buildPageSlide(_, innerScope, pageId)
				local positionTarget = innerScope:Computed(function(use)
					local activePage = use(panelState.page)
					local prev = use(panelState.prevPage)
					local dir = use(panelState.navDirection)
					local history = use(panelState.pageHistory)
					if activePage == pageId then
						return UDim2.fromScale(0, 0)
					elseif prev == pageId then
						return UDim2.fromScale(-dir, 0)
					else
						local activeIdx = table.find(history, activePage) or 0
						local myIdx = table.find(history, pageId) or (#history + 1)
						return if myIdx < activeIdx
							then UDim2.fromScale(-1, 0)
							else UDim2.fromScale(1, 0)
					end
				end)
				local springSpeed = innerScope:Computed(function(use)
					return if (use(panelState.page) == pageId or use(panelState.prevPage) == pageId)
						then 120
						else 9999
				end)
				local springPosition = innerScope:Spring(positionTarget, springSpeed, 2.25)
				local isVisible = innerScope:Computed(function(use)
					return use(panelState.page) == pageId or use(panelState.prevPage) == pageId
				end)
				local PageComponent = getPage(pageId)
				local pageProps = pagePropsMap[pageId] or {}
				local pageContent = if PageComponent ~= nil
					then PageComponent(innerScope, pageProps)
					else PlaceholderPage(innerScope, { pageName = pageId })
				return innerScope:New "CanvasGroup" {
					Name = "PageSlide_" .. pageId,
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					GroupTransparency = 0,
					Position = springPosition,
					Size = UDim2.fromScale(1, 1),
					Visible = isVisible,
					[Children] = {
						innerScope:New "UIListLayout" {
							FillDirection = Enum.FillDirection.Vertical,
							HorizontalFlex = Enum.UIFlexAlignment.Fill,
							VerticalFlex = Enum.UIFlexAlignment.Fill,
							SortOrder = Enum.SortOrder.LayoutOrder,
						},
						innerScope:New "Frame" {
							Name = "PageWrap",
							BackgroundTransparency = 1,
							LayoutOrder = 1,
							Size = UDim2.fromScale(1, 1),
							[Children] = {
								innerScope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Vertical,
									HorizontalFlex = Enum.UIFlexAlignment.Fill,
									VerticalFlex = Enum.UIFlexAlignment.Fill,
									SortOrder = Enum.SortOrder.LayoutOrder,
								},
								pageContent,
							},
						},
					},
				}
			end

			panelBody = scope:New "Frame" {
				Name = "PreviewPageStack",
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				[Children] = {
					scope:ForValues(visitedPages, buildPageSlide),
				},
			}

			titleValue = scope:Computed(function(use)
				local current = use(panelState.page)
				if current == "ItemSelector" then
					local cfg = use(itemSelectorConfig) :: any
					if typeof(cfg) == "table" and typeof(cfg.title) == "string" and cfg.title ~= "" then
						return cfg.title
					end
					return "Select"
				end
				if typeof(commandKey) == "string" and commandKey ~= "" then
					return commandKey:sub(1, 1):upper() .. commandKey:sub(2)
				end
				return "Preview"
			end)

			canGoBack = panelState.canGoBack
			onBack = function() panelState:goBack() end
		elseif isTask then
			panelBody = TaskBody(scope, {
				taskUID = if panel then ((panel :: any).taskUID or "") else "",
				snapshot = if panel then (panel :: any).taskSnapshot else nil,
				onOpenProfile = function(userId: number)
					Panels.openProfile(userId)
				end,
			})
			titleValue = "Task"
		elseif isEmotes then
			panelBody = EmotesPage(scope, {})
			titleValue = "Emotes"
		elseif isCommands then
			panelBody = CommandsPopupPage(scope, { display = if panel then (panel :: any).commandDisplay else nil })
			titleValue = "/commands"
		elseif isBooster then
			panelBody = BoosterPage(scope, {})
			titleValue = "Chat Commands"
		elseif isOutfits then
			panelBody = OutfitsPage(scope, {})
			titleValue = "Cosmetics"
		else
			panelBody = ProfileBody(scope, {
				userId = if panel then panel.userId else nil,
				giverIdentity = if panel then panel.giverIdentity else nil,
				inline = true,
				popupParent = popupOverlay,
			})
			titleValue = "Profile"
		end

		local layerId = if panel then panel.id else "Popup"
		local popupRoot = scope:New "Frame" {
			Name = "PanelGui",
			Active = true,
			AnchorPoint = Vector2.new(0.5, 0),
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundTransparency = 1,
			Position = panelPos,
			ZIndex = LayerOrder.register(scope, layerId),
			Visible = isOpen,

			[Children] = {
				scope:New "UIScale" {
					Scale = Viewport.Scale,
				},

				-- A TextButton always sinks input, so stray clicks can't leak to the main PanelGui
				scope:New "TextButton" {
					Name = "InputBlocker",
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
					Size = UDim2.fromScale(1, 1),
					Text = "",
					TextColor3 = Color3.new(),
					TextSize = 1,
					ZIndex = 0,
				},

				scope:New "CanvasGroup" {
					Name = "Group",
					Active = true,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Theme.Color.Base,
					GroupTransparency = scope:Spring(
						scope:Computed(function(use)
							return if use(isOpen) then 0 else 1
						end),
						60,
						1.5
					),
					Size = UDim2.fromOffset(320, 0),

					[Children] = {
						scope:New "UICorner" {
							CornerRadius = UDim.new(0, 12),
						},
						scope:New "UIPadding" {},
						scope:New "UIStroke" {
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
							Color = Theme.Color.NeutralStroke,
							Transparency = 0.5,
						},
						scope:New "UIListLayout" {
							HorizontalFlex = Enum.UIFlexAlignment.Fill,
							SortOrder = Enum.SortOrder.LayoutOrder,
						},

						TitleBar(scope, {
							title = titleValue,
							showLogo = false,
							canGoBack = canGoBack,
							onBack = onBack,
							onClose = props.onClose,
							onDrag = function(delta: Vector2)
								dragOffset:set(Fusion.peek(dragOffset) + delta)
							end,
						}),

						-- A single SF with AutomaticSize.Y + AutomaticCanvasSize.Y broke
						-- TextWrapped, and canvas height stays manual so popupOverlay
						-- never feeds it
						(function()
							if isFixedHeightKind then
								return scope:New "Frame" {
									Name = "Content",
									Active = true,
									BackgroundTransparency = 1,
									ClipsDescendants = true,
									LayoutOrder = 2,
									Size = scope:Computed(function(use)
										return UDim2.new(1, 0, 0, use(Viewport.MaxContentHeight))
									end),
									[Children] = {
										scope:New "Frame" {
											Name = "PaddingFrame",
											AnchorPoint = Vector2.new(0.5, 0),
											BackgroundTransparency = 1,
											ClipsDescendants = true,
											Position = UDim2.new(0.5, 0, 0, 14),
											Size = UDim2.new(1, -28, 1, -34),
											[Children] = { panelBody },
										},
									},
								}
							end
							local PADDING = 10 -- UIPadding on the Scroller
							-- ScrollBarInset.Always already carves out the strip, the padding gives it back
							local scrollbarStrip = if Platform.isMobile then 2 else 6
							local paddingRight = math.max(0, PADDING - scrollbarStrip)
							local innerContentSize: Fusion.Value<Vector2> = scope:Value(Vector2.zero)
							local canvasHeightLocal = scope:Computed(function(use): number
								local scale = use(Viewport.Scale)
								if scale <= 0 then scale = 1 end
								return use(innerContentSize).Y / scale + PADDING * 2
							end)
							local outerHeight = scope:Computed(function(use)
								return math.min(use(canvasHeightLocal), use(Viewport.MaxContentHeight))
							end)
							return scope:New "Frame" {
								Name = "Content",
								Active = true,
								BackgroundTransparency = 1,
								ClipsDescendants = true,
								LayoutOrder = 2,
								Size = scope:Computed(function(use)
									return UDim2.new(1, 0, 0, use(outerHeight))
								end),
								[Children] = {
									scope:New "ScrollingFrame" {
										Name = "Scroller",
										-- Manual CanvasSize, AutomaticCanvasSize only ever grows
										AutomaticCanvasSize = Enum.AutomaticSize.None,
										CanvasSize = scope:Computed(function(use)
											return UDim2.fromOffset(0, use(canvasHeightLocal))
										end),
										BackgroundTransparency = 1,
										BorderSizePixel = 0,
										ScrollBarImageColor3 = Theme.Color.NeutralContentDark,
										ScrollBarImageTransparency = if Platform.isMobile then 1 else 0,
										ScrollBarThickness = if Platform.isMobile then 2 else 6,
										ScrollingDirection = Enum.ScrollingDirection.Y,
										Selectable = false,
										Size = UDim2.fromScale(1, 1),
										VerticalScrollBarInset = Enum.ScrollBarInset.Always,
										[Children] = {
											scope:New "UIPadding" {
												PaddingTop = UDim.new(0, PADDING),
												PaddingBottom = UDim.new(0, PADDING),
												PaddingLeft = UDim.new(0, PADDING),
												PaddingRight = UDim.new(0, paddingRight),
											},
											-- UIPadding on a ScrollingFrame doesn't shrink the
											-- scale-1 reference, so subtract both paddings
											scope:New "Frame" {
												Name = "Inner",
												AutomaticSize = Enum.AutomaticSize.Y,
												BackgroundTransparency = 1,
												Size = UDim2.new(1, -(PADDING + paddingRight), 0, 0),
												[Children] = {
													scope:New "UIListLayout" {
														FillDirection = Enum.FillDirection.Vertical,
														HorizontalFlex = Enum.UIFlexAlignment.Fill,
														SortOrder = Enum.SortOrder.LayoutOrder,
														[Out("AbsoluteContentSize")] = innerContentSize,
													},
													panelBody,
												},
											},
											popupOverlay,
										},
									},
								},
							}
						end)(),
					},
				},
			},
		}
		LayerOrder.attach(layerId, popupRoot)
		return popupRoot
	end

	-- The gameOverride forcefully applies the GameStore value to every client when
	-- the admin disables CanChangeYouSettingsX, the saved override stays in perm
	Theme.bindSetting("Color", "Primary",
		{"YouSettings", "Display", "PrimaryColor"},
		{
			gamePath = {"GameSettings", "PlayerSettings", "Display", "PrimaryColor"},
			gameLockPath = {"GameSettings", "SystemSettings", "CanChangeYouSettingsPrimaryColor"},
		})
	Theme.bindSetting("Font", "Heading",
		{"YouSettings", "Display", "Font"},
		{
			gamePath = {"GameSettings", "PlayerSettings", "Display", "Font"},
			gameLockPath = {"GameSettings", "SystemSettings", "CanChangeYouSettingsFont"},
		})
	Theme.bindSetting("Font", "Body",
		{"YouSettings", "Display", "Font"},
		{
			gamePath = {"GameSettings", "PlayerSettings", "Display", "Font"},
			gameLockPath = {"GameSettings", "SystemSettings", "CanChangeYouSettingsFont"},
		})
	-- ContentScale and MenuHeight stay user-controlled with no game lock
	Theme.bindSetting("Layout", "ContentScale", {"YouSettings", "Display", "ContentScale"})
	Theme.bindSetting("Layout", "MenuHeight", {"YouSettings", "Display", "MenuHeight"})
	Theme.bindThemeName(
		{"YouSettings", "Display", "Theme"},
		{"GameSettings", "PlayerSettings", "Display", "Theme"},
		{"GameSettings", "SystemSettings", "CanChangeYouSettingsTheme"}
	)

	local panelState = PanelState.new(scope)

	local initialPages = if props.initialPage and props.initialPage ~= "Menu" then { "Menu", props.initialPage } else { "Menu" }
	local visitedPages: Fusion.Value<{ string }> = scope:Value(initialPages)

	if props.initialPage and props.initialPage ~= "Menu" then
		task.defer(function()
			if not Fusion.peek(panelState.page) == props.initialPage then
				panelState:toPage(props.initialPage)
			end
		end)
	end

	local function navigateTo(pageId: string)
		local visited = Fusion.peek(visitedPages)
		if not table.find(visited, pageId) then
			local newVisited = table.clone(visited)
			table.insert(newVisited, pageId)
			visitedPages:set(newVisited)
		end
		panelState:toPage(pageId)
	end

	-- Icon permission Commands roots the panel at the Commands page, the menu is unreachable
	local iconMode = Permissions.iconMode(scope)
	local panelRootPage = scope:Computed(function(use)
		return if use(iconMode) == "Commands" then "Commands" else "Menu"
	end)
	local function applyRootPage()
		local pageId = Fusion.peek(panelRootPage)
		local visited = Fusion.peek(visitedPages)
		if not table.find(visited, pageId) then
			local newVisited = table.clone(visited)
			table.insert(newVisited, pageId)
			visitedPages:set(newVisited)
		end
		panelState.prevPage:set(nil)
		panelState.pageHistory:set({ pageId })
		panelState.page:set(pageId)
	end
	if Fusion.peek(panelRootPage) ~= "Menu" then
		applyRootPage()
	end
	scope:Observer(panelRootPage):onChange(applyRootPage)

	-- Profile opens as a standalone popup PanelGui via Panels, not a page push
	local function openProfile(userId: number)
		Panels.openProfile(userId)
	end

	local function openGiverProfile(giver: any)
		Panels.openGiverProfile(giver)
	end

	local targetRoleKey: Fusion.Value<string> = scope:Value("")

	local function openRoleSettings(roleKey: string)
		targetRoleKey:set(roleKey)
		navigateTo("RoleSettings")
	end

	local function openRoleCreate()
		navigateTo("RoleCreate")
	end

	local runCommandKey: Fusion.Value<string> = scope:Value("")
	local runUnlockRole: Fusion.Value<string?> = scope:Value(nil)
	-- Set per open so command-list runs leave it false
	local runAutoOpenUserArg: Fusion.Value<boolean> = scope:Value(false)

	local runShowRoles: Fusion.Value<boolean> = scope:Value(false)

	local function openRunPage(commandKey: string, opts: {autoOpenUserArg: boolean?, unlockRole: string?, showRoles: boolean?}?)
		-- Hardcoded entries like the Bans page "+" may point at an excluded command
		local getCommand = require(modules.CommandUtil.getCommand)
		if not getCommand(commandKey) then
			local Prompt = require(modules.Prompt)
			Prompt.error(`This requires the <b>{commandKey}</b> command to be loaded in <b><i>Config &gt; Commands</i></b>`)
			return
		end
		runCommandKey:set(commandKey)
		runUnlockRole:set(if opts and typeof((opts :: any).unlockRole) == "string" then (opts :: any).unlockRole else nil)
		runShowRoles:set(opts ~= nil and (opts :: any).showRoles == true)
		navigateTo("Run")
		-- Set AFTER navigating so the picker opens on top of Run and a re-press on
		-- an already-built Run page still fires the observer
		runAutoOpenUserArg:set(opts ~= nil and opts.autoOpenUserArg == true)
	end

	local itemSelectorConfig: Fusion.Value<any?> = scope:Value(nil)
	local sharedCustomUsers: Fusion.Value<{ [string]: any }> = scope:Value({})

	local function openItemSelectorPage(config: any)
		itemSelectorConfig:set(config)
		navigateTo("ItemSelector")
	end

	local configureGroupRolesGroupId: Fusion.Value<number?> = scope:Value(nil :: number?)
	local configureGroupRolesOnConfirm: Fusion.Value<((item: any, replacesKey: string?) -> ())?> = scope:Value(nil)
	-- Read on open to pre-tick the saved roles instead of defaulting to All Roles
	local configureGroupRolesEntry: Fusion.Value<any?> = scope:Value(nil :: any?)

	local function openConfigureGroupRoles(groupId: number, currentEntry: any?)
		configureGroupRolesGroupId:set(groupId)
		configureGroupRolesEntry:set(currentEntry)
		local cfg = Fusion.peek(itemSelectorConfig) :: any
		if cfg and cfg.onAddItem then
			configureGroupRolesOnConfirm:set(cfg.onAddItem :: any)
		end
		navigateTo("ConfigureGroupRoles")
	end

	local viewCommandsFilterTag: Fusion.Value<string> = scope:Value("")
	local viewCommandsFilterRole: Fusion.Value<string> = scope:Value("")

	local commandsActiveRoleFilter: Fusion.Value<string?> = scope:Value(nil)

	local function openViewCommandsForTag(tag: string)
		viewCommandsFilterRole:set("")
		viewCommandsFilterTag:set(tag)
		navigateTo("CommandsFiltered")
	end

	local function openViewCommandsForRole(roleKey: string)
		commandsActiveRoleFilter:set(roleKey)
		navigateTo("Commands")
	end

	-- Back off the Commands page clears the role filter, forward navigation keeps
	-- it so returning lands on the same filtered view
	scope:Observer(panelState.page):onChange(function()
		local current = Fusion.peek(panelState.page)
		local dir = Fusion.peek(panelState.navDirection)
		if current ~= "Commands" and dir < 0 then
			commandsActiveRoleFilter:set(nil)
		end
	end)

	-- Shared with the title bar's beta badge so it can reopen the welcome popup
	local menuWelcomeVisible: Fusion.Value<boolean> = scope:Value(false)

	local pagePropsMap = {
		Menu = { onPageActivate = navigateTo },
		About = {
			onBooster = function() navigateTo("Booster") end,
		},
		Commands = {
			isActive = scope:Computed(function(use)
				return use(panelState.page) == "Commands"
			end),
			onRunPageOpen = openRunPage,
			activeRoleFilter = commandsActiveRoleFilter,
		},
		CommandsFiltered = {
			isActive = scope:Computed(function(use)
				return use(panelState.page) == "CommandsFiltered"
			end),
			filterTag = viewCommandsFilterTag,
			filterRole = viewCommandsFilterRole,
			readonly = true,
		},
		VetCommands = {
			isActive = scope:Computed(function(use)
				return use(panelState.page) == "VetCommands"
			end),
			onRunPageOpen = openRunPage,
		},
		Run = { commandKey = runCommandKey, unlockRole = runUnlockRole, showRoles = runShowRoles, activeCommands = scope:Value({}), onItemSelectorOpen = openItemSelectorPage, sharedCustomUsers = sharedCustomUsers, autoOpenUserArg = runAutoOpenUserArg },
		Settings = { onItemSelectorOpen = openItemSelectorPage },
		ItemSelector = {
			config = itemSelectorConfig,
			onConfirmBack = function() panelState:goBack() end,
			onOpenConfigureGroupRoles = openConfigureGroupRoles,
			onOpenViewCommandsForTag = openViewCommandsForTag,
		},
		ConfigureGroupRoles = {
			groupId = configureGroupRolesGroupId,
			currentEntry = configureGroupRolesEntry,
			onConfirm = configureGroupRolesOnConfirm,
			onBack = function() panelState:goBack() end,
		},
		Moderation = { onUserActivate = openProfile, onRunPageOpen = openRunPage },
		Tasks = {
			onTaskActivate = function(taskUID: string, snapshot: any?)
				Panels.openTask(taskUID, snapshot)
			end,
		},
		Roles = {
			onMemberActivate = openProfile,
			onRoleActivate = openRoleSettings,
			onRoleCreate = openRoleCreate,
			onRunPageOpen = openRunPage,
			onGiverActivate = openGiverProfile,
		},
		RoleSettings = {
			targetRoleKey = targetRoleKey,
			onItemSelectorOpen = openItemSelectorPage,
			onOpenViewCommandsForRole = openViewCommandsForRole,
			onDeleted = function()
				-- Mirror the back button, clearing the key undoes pending changes on next open
				targetRoleKey:set("")
				panelState:goBack()
			end,
		},
		RoleCreate = {
			onItemSelectorOpen = openItemSelectorPage,
			onCancel = function()
				panelState:goBack()
			end,
			onCreated = function(_newRoleKey: string)
				panelState:goBack()
			end,
		},
		Users = { onUserActivate = openProfile },
	}

	local runPageCommandInfo = scope:Computed(function(use)
		local key = use(runCommandKey)
		if key == "" then return nil end
		return Fusion.peek(scope:Fuse("everyone", "CommandInfo", key))
	end)

	local roleInfoFuse = scope:Fuse("everyone", "RoleInfo")
	local lastRoleTitle: string = "Role" -- remembers the last resolved name so deletions don't flash the raw key

	local pageTitle = scope:Computed(function(use)
		local id = use(panelState.page)
		if id == "Run" then
			local info = use(runPageCommandInfo)
			if type(info) == "table" then
				local prefix: string = (info :: any).prefix or ";"
				local name: string = (info :: any).name or use(runCommandKey)
				return prefix .. name
			end
			local key = use(runCommandKey)
			return if key ~= "" then ";" .. key else "Run"
		end
		if id == "ItemSelector" then
			local cfg = use(itemSelectorConfig) :: any
			return if type(cfg) == "table" and cfg.title then "Select " .. cfg.title else "Select"
		end
		if id == "CommandsFiltered" then
			local tag = use(viewCommandsFilterTag)
			if typeof(tag) == "string" and tag ~= "" then
				return `'{tag}' Commands`
			end
			return "Commands"
		end
		if id == "RoleSettings" then
			local key = use(targetRoleKey)
			if key ~= "" then
				local roleInfo = use(roleInfoFuse)
				if typeof(roleInfo) == "table" and roleInfo[key] and roleInfo[key].name then
					lastRoleTitle = roleInfo[key].name
					return lastRoleTitle
				end
				-- Keep the last known name so the title doesn't flash the raw key during deletion
				return lastRoleTitle
			end
			return "Role"
		end
		local entry = (Pages :: any)[id]
		return if entry then (entry.Name or entry.Id or id) else id
	end)

	local showLogo = scope:Computed(function(use)
		local page = use(panelState.page)
		return page == "Menu" or page == "About"
	end)

	local showBetaBadge = scope:Computed(function(use)
		return use(panelState.page) == "Menu"
	end)

	local showUpdateBanner = scope:Computed(function(use)
		local page = use(panelState.page)
		return page == "Menu" or page == "About"
	end)

	local isOpen = scope:Computed(function(use)
		local visible = props.visible
		if typeof(visible) == "table" then return use(visible :: any) end
		return if visible == nil then true else visible
	end)

	scope:Observer(isOpen):onChange(function()
		-- Opening counts as reaching for the panel, so it comes back in front of notices
		if Fusion.peek(isOpen) then
			LayerOrder.raise("MainPanel")
		end
	end)

	-- Fuse isn't available on ForValues' inner scopes, so buildPageSlide captures this
	local menuYouReady = Permissions.youReady(scope)

	local function buildPageSlide(_, innerScope, pageId)
		local positionTarget = innerScope:Computed(function(use)
			local activePage = use(panelState.page)
			local prev = use(panelState.prevPage)
			local dir = use(panelState.navDirection)
			local history = use(panelState.pageHistory)
			if activePage == pageId then
				return UDim2.fromScale(0, 0)
			elseif prev == pageId then
				return UDim2.fromScale(-dir, 0)
			else
				local activeIdx = table.find(history, activePage) or 0
				local myIdx = table.find(history, pageId) or (#history + 1)
				return if myIdx < activeIdx
					then UDim2.fromScale(-1, 0)
					else UDim2.fromScale(1, 0)
			end
		end)
		local springSpeed = innerScope:Computed(function(use)
			return if (use(panelState.page) == pageId or use(panelState.prevPage) == pageId)
				then 120
				else 9999
		end)
		local springPosition = innerScope:Spring(positionTarget, springSpeed, 2.25)

		local isVisible = innerScope:Computed(function(use)
			return use(panelState.page) == pageId or use(panelState.prevPage) == pageId
		end)

		-- Idle lets StreamList deconstruct offscreen content
		local pageIdle = innerScope:Computed(function(use)
			if not use(isOpen) then return true end
			local currentPage = use(panelState.page)
			local prevPage = use(panelState.prevPage)
			if currentPage == pageId or prevPage == pageId then return false end
			local history = use(panelState.pageHistory)
			return table.find(history, pageId) == nil
		end)

		local PageComponent = getPage(pageId)
		local pageProps = (pagePropsMap :: any)[pageId] or {}
		pageProps.idle = pageIdle
		pageProps.panelClosed = innerScope:Computed(function(use)
			return not use(isOpen)
		end)
		local pageContent = if PageComponent ~= nil
			then PageComponent(innerScope, pageProps)
			else PlaceholderPage(innerScope, { pageName = pageId })

		-- Every page but Menu spins while youReady is false, otherwise users see
		-- misleading no-permission placeholders during cold load
		local gateLoading = pageId ~= "Menu"

		-- Per page so a FullBleed page can skip it and draw up to the panel edges
		local pageEntry = (Pages :: any)[pageId]
		local fullBleed = pageEntry ~= nil and pageEntry.FullBleed == true
		local pageWrapChildren: {any} = {
			-- Mirrors the outer flex layout so auto-height pages get a determinate parent height
			innerScope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				VerticalFlex = Enum.UIFlexAlignment.Fill,
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
			pageContent,
		}
		if not fullBleed then
			table.insert(pageWrapChildren, innerScope:New "UIPadding" {
				PaddingBottom = UDim.new(0, 20),
				PaddingLeft = UDim.new(0, 14),
				PaddingRight = UDim.new(0, 14),
				PaddingTop = UDim.new(0, 14),
			})
		end
		local pageWrap = innerScope:New "Frame" {
			Name = "PageWrap",
			BackgroundTransparency = 1,
			LayoutOrder = 1,
			Size = UDim2.fromScale(1, 1),
			Visible = if gateLoading then menuYouReady else nil,
			[Children] = pageWrapChildren,
		}
		local loadingOverlay = if gateLoading then innerScope:New "Frame" {
			Name = "PageLoading",
			BackgroundTransparency = 1,
			LayoutOrder = 1,
			Size = UDim2.fromScale(1, 1),
			Visible = innerScope:Computed(function(use): boolean
				return not use(menuYouReady)
			end),
			[Children] = {
				LoadingSpinner(innerScope, {}),
			},
		} else nil

		local slideEdgePadding = if fullBleed then nil else innerScope:New "UIPadding" {
			PaddingTop = UDim.new(0, 2),
			PaddingBottom = UDim.new(0, 2),
			PaddingLeft = UDim.new(0, 2),
			PaddingRight = UDim.new(0, 2),
		}

		-- CanvasGroup composites flat so the GPU just moves it during spring
		return innerScope:New "CanvasGroup" {
			Name = "PageSlide_" .. pageId,
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			GroupTransparency = 0,
			Position = springPosition,
			Size = UDim2.fromScale(1, 1),
			Visible = isVisible,

			[Children] = {
				slideEdgePadding,
				innerScope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					VerticalFlex = Enum.UIFlexAlignment.Fill,
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				pageWrap,
				loadingOverlay,
			},
		}
	end

	local dragOffset: Fusion.Value<Vector2> = props.dragOffset or scope:Value(Vector2.zero)

	local PANEL_WIDTH = 320
	local TITLEBAR_HEIGHT = 38

	local function clampDragOffset(offset: Vector2, base: UDim2, vp: Vector2, scale: number): Vector2
		local baseX = base.X.Scale * vp.X + base.X.Offset
		local baseY = base.Y.Scale * vp.Y + base.Y.Offset
		local panelScreenWidth = PANEL_WIDTH * scale
		local titlebarScreenHeight = TITLEBAR_HEIGHT * scale

		local minY = -baseY
		local maxY = vp.Y - baseY - titlebarScreenHeight
		local clampedY = math.clamp(offset.Y, minY, maxY)

		-- Keep at least 20% of panel width visible horizontally
		local minVisiblePx = 0.20 * panelScreenWidth
		local minX = minVisiblePx - panelScreenWidth / 2 - baseX
		local maxX = vp.X - minVisiblePx + panelScreenWidth / 2 - baseX
		local clampedX = math.clamp(offset.X, minX, maxX)

		return Vector2.new(clampedX, clampedY)
	end

	scope:Observer(Viewport.ViewportSize):onChange(function()
		dragOffset:set(Vector2.zero)
	end)

	-- nil = Viewport.MaxContentHeight, set to a number after user drags
	local userContentHeight: Fusion.Value<number?> = scope:Value(nil)
	local resolvedContentHeight = scope:Computed(function(use)
		local override = use(userContentHeight)
		return if override ~= nil then override else use(Viewport.MaxContentHeight)
	end)
	pagePropsMap.Menu.contentHeight = resolvedContentHeight

	-- Written every DragContinue frame, no spring
	local rawDragHeight: Fusion.Value<number> = scope:Value(Fusion.peek(Viewport.MaxContentHeight))
	local expIsDragging: Fusion.Value<boolean> = scope:Value(false)

	-- A MenuHeight change clears the drag override, skipped mid-drag so the gesture survives
	local menuHeightSetting = (scope :: any):Fuse("perm", {"YouSettings", "Display", "MenuHeight"})
	scope:Observer(menuHeightSetting):onChange(function()
		if Fusion.peek(expIsDragging) then return end
		userContentHeight:set(nil)
	end)

	-- 9999 during drag for a seamless handoff
	local contentHeightSpring = scope:Spring(
		scope:Computed(function(use)
			return if use(isOpen) then use(resolvedContentHeight) else 0
		end),
		scope:Computed(function(use)
			return if use(expIsDragging) then 9999 else 120
		end),
		1.5
	)

	-- Each visible banner would grow the menu by its height, so Content shrinks by
	-- exactly that amount and the overall height stays constant
	local BANNER_HEIGHT = 36
	local previewBannerVisibleFuse: any = (scope :: any):Fuse("temp", "PreviewingRoles")
	local updateBannerVisible: Fusion.Value<boolean> = scope:Value(false)
	local bannerOffset = scope:Computed(function(use): number
		local total = 0
		local list = use(previewBannerVisibleFuse)
		if typeof(list) == "table" and #(list :: {any}) > 0 then
			total += BANNER_HEIGHT
		end
		if use(updateBannerVisible) then
			total += BANNER_HEIGHT
		end
		return total
	end)

	local displayedContentHeight = scope:Computed(function(use)
		local height = if use(expIsDragging) then use(rawDragHeight) else use(contentHeightSpring)
		height -= use(bannerOffset)
		return math.max(height, 0)
	end)

	local panelPos = scope:Computed(function(use)
		local base = if typeof(props.position) == "table" then use(props.position :: any) else (props.position or UDim2.fromScale(0.95, 0.5))
		local offset = use(dragOffset)
		return base + UDim2.fromOffset(offset.X, offset.Y)
	end)

	-- Plain Lua drag state (not reactive)
	local expDragStartY = 0
	local expDragStartHeight = 0
	local expDragMoved = false

	local panelRoot = scope:New "Frame" {
		Name = "PanelGui",
		-- Active across the entire panel wrapper so any click within the
		-- panel's bounding box gets sunk here, before the hit-test descends
		-- into transparent inner layers that could otherwise leak input
		-- through to other ScreenGuis or the 3D world
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0),
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
		Position = panelPos,
		ZIndex = LayerOrder.register(scope, "MainPanel"),
		Visible = isOpen,

		[Children] = {
			scope:New "UIScale" {
				Scale = Viewport.Scale,
			},

			-- InputBlocker: invisible TextButton at the back of the panel
			-- TextButton always sinks input, so any click inside the panel
			-- bounds that misses a foreground interactive lands here instead
			-- of leaking to whatever's beneath in the same ScreenGui
			scope:New "TextButton" {
				Name = "InputBlocker",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Size = UDim2.fromScale(1, 1),
				Text = "",
				TextColor3 = Color3.new(),
				TextSize = 1,
				ZIndex = 0,
			},

			scope:New "CanvasGroup" {
				Name = "Group",
				Active = true,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Theme.Color.Base,
				-- Fade in on open, close is instant via the Visible snap
				GroupTransparency = scope:Spring(
					scope:Computed(function(use)
						return if use(isOpen) then 0 else 1
					end),
					60,
					1.5
				),
				Size = UDim2.fromOffset(320, 0),

				[Children] = {
					scope:New "UICorner" {
						CornerRadius = UDim.new(0, 12),
					},
					scope:New "UIPadding" {},
					scope:New "UIStroke" {
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Color = Theme.Color.NeutralStroke,
						Transparency = 0.5,
					},
					scope:New "UIListLayout" {
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						SortOrder = Enum.SortOrder.LayoutOrder,
					},

					-- Zero-height so the list layout skips it, the bubble child renders on top
					(function()
						local hintHost = scope:New "Frame" {
							Name = "HintOverlay",
							BackgroundTransparency = 1,
							LayoutOrder = 999,
							Size = UDim2.new(1, 0, 0, 0),
							ZIndex = 60,
						}
						HintBubble.registerHost(hintHost :: GuiObject)
						return hintHost
					end)(),

					TitleBar(scope, {
						title = pageTitle,
						showLogo = showLogo,
						showBeta = showBetaBadge,
						onBeta = function()
							menuWelcomeVisible:set(not Fusion.peek(menuWelcomeVisible))
						end,
						canGoBack = panelState.canGoBack,
						onBack = function()
							local currentPage = Fusion.peek(panelState.page)
							if currentPage == "RoleSettings" and Fusion.peek(targetRoleKey) ~= "" then
								targetRoleKey:set("")
							end
							panelState:goBack()
						end,
						onClose = props.onClose,
						onDrag = function(delta: Vector2)
							local cur = Fusion.peek(dragOffset)
							local base = Fusion.peek(Viewport.MenuDefaultPosition)
							local vp = Fusion.peek(Viewport.ViewportSize)
							local scale = Fusion.peek(Viewport.Scale)
							dragOffset:set(clampDragOffset(cur + delta, base, vp, scale))
						end,
					}),

					PreviewBanner(scope, {
						layoutOrder = 1,
					}),

					UpdateBanner(scope, {
						layoutOrder = 2,
						pageVisible = showUpdateBanner,
						visibleValue = updateBannerVisible,
						-- The popup overlays whichever page you're on, no need to hop to Menu first
						onView = function()
							menuWelcomeVisible:set(true)
						end,
					}),

					scope:New "Frame" {
						Name = "Content",
						BackgroundTransparency = 1,
						ClipsDescendants = true,
						LayoutOrder = 3,
						Size = scope:Computed(function(use)
							return UDim2.fromOffset(0, use(displayedContentHeight))
						end),
						[Children] = {
							scope:New "Frame" {
								Name = "PaddingFrame",
								AnchorPoint = Vector2.new(0.5, 0),
								BackgroundTransparency = 1,
								ClipsDescendants = true,
								Position = UDim2.new(0.5, 0, 0, 0),
								Size = UDim2.new(1, 0, 1, 0),

								[Children] = {
									scope:ForValues(visitedPages, buildPageSlide),
								},
							},

							-- Same inset as PageWrap so the popup card keeps its border and margins
							scope:New "Frame" {
								Name = "UpdateLogOverlay",
								BackgroundTransparency = 1,
								Size = UDim2.fromScale(1, 1),
								ZIndex = 10,
								[Children] = {
									scope:New "UIPadding" {
										PaddingBottom = UDim.new(0, 20),
										PaddingLeft = UDim.new(0, 14),
										PaddingRight = UDim.new(0, 14),
										PaddingTop = UDim.new(0, 14),
									},
									UpdateLogPopup(scope, {
										visible = menuWelcomeVisible,
									}),
								},
							},

							scope:New "TextButton" {
								Name = "Expander",
								AnchorPoint = Vector2.new(0.5, 1),
								AutoButtonColor = false,
								BackgroundTransparency = 1,
								FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
								Position = UDim2.fromScale(0.5, 1),
								Size = UDim2.new(1, 0, 0, 20),
								Text = "",
								TextColor3 = Color3.new(),
								TextSize = 14,

								[Children] = {
									scope:New "UIDragDetector" {
										Name = "UIDragDetector",
										DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
										ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomScale,

										[Fusion.OnEvent "DragStart"] = function(cursorPosition: Vector2)
											expDragStartY = cursorPosition.Y
											expDragStartHeight = Fusion.peek(resolvedContentHeight)
											rawDragHeight:set(expDragStartHeight)
											expDragMoved = false
											expIsDragging:set(true)
										end,

										[Fusion.OnEvent "DragContinue"] = function(cursorPosition: Vector2)
											local delta = cursorPosition.Y - expDragStartY
											local base = Fusion.peek(Viewport.MenuDefaultPosition)
											local vp = Fusion.peek(Viewport.ViewportSize)
											local scale = Fusion.peek(Viewport.Scale)
											local offset = Fusion.peek(dragOffset)
											local panelTopY = base.Y.Scale * vp.Y + base.Y.Offset + offset.Y
											local spaceBelow = (vp.Y - panelTopY - TITLEBAR_HEIGHT * scale - Viewport.MinScreenEdgeGap) / scale
											local maxHeight = math.min(Fusion.peek(Viewport.DragMaxHeight), math.floor(spaceBelow))
											local newHeight = math.round(math.clamp(expDragStartHeight + delta, MIN_CONTENT_HEIGHT, maxHeight))
											rawDragHeight:set(newHeight)
											userContentHeight:set(newHeight)
											expDragMoved = true
										end,

										[Fusion.OnEvent "DragEnd"] = function()
											expIsDragging:set(false)
											if not expDragMoved then
												userContentHeight:set(nil)
											end
										end,
									},

									scope:New "Frame" {
										Name = "Bar1",
										AnchorPoint = Vector2.new(0.5, 0.5),
										BackgroundColor3 = Color3.fromRGB(61, 61, 63),
										BackgroundTransparency = 0.5,
										Position = UDim2.new(0.5, 0, 0.51, -2),
										Size = UDim2.new(0.3, 0, 0, 4),
										[Children] = {
											scope:New "UICorner" {},
										},
									},
								},
							},
						},
					},
				},
			},
		},
	}

	LayerOrder.attach("MainPanel", panelRoot)

	Navigate.register({
		navigateTo = navigateTo,
		goBack = function() panelState:goBack() end,
		currentPage = function() return Fusion.peek(panelState.page) end,
		pageHistory = function() return Fusion.peek(panelState.pageHistory) end,
		panelRoot = function(): Instance? return panelRoot end,
	})

	return panelRoot
end

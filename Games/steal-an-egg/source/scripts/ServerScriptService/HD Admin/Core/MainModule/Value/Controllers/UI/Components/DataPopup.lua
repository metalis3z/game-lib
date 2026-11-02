--!strict

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local Pressable = require(frontend.Components.Pressable)
local Popup = require(frontend.Components.Popup)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	visible: Fusion.Value<boolean>,
	copyText: UsedAs<string>,
	onLoad: (pastedText: string) -> (boolean, string),
	onClose: (() -> ())?,
	hideLoad: UsedAs<boolean>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local activeTab: Fusion.Value<string> = scope:Value("Copy")
	local loadInput: Fusion.Value<string> = scope:Value("")
	local statusMessage: Fusion.Value<string> = scope:Value("")
	local statusIsError: Fusion.Value<boolean> = scope:Value(false)
	local statusDismissId: number = 0

	scope:Observer(statusMessage):onChange(function()
		local msg = Fusion.peek(statusMessage)
		if typeof(msg) ~= "string" or msg == "" then return end
		statusDismissId += 1
		local myId = statusDismissId
		task.delay(4, function()
			if statusDismissId == myId then
				statusMessage:set("")
			end
		end)
	end)

	scope:Observer(props.visible):onChange(function()
		if Fusion.peek(props.visible) then
			activeTab:set("Copy")
			loadInput:set("")
			statusMessage:set("")
			statusIsError:set(false)
		end
	end)

	if props.hideLoad ~= nil then
		scope:Observer(props.hideLoad :: any):onChange(function()
			if Fusion.peek(props.hideLoad :: any) == true and Fusion.peek(activeTab) == "Load" then
				activeTab:set("Copy")
			end
		end)
	end

	local copyTextBox: TextBox = scope:New "TextBox" {
		Name = "CopyBox",
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
		ClearTextOnFocus = false,
		FontFace = scope:Computed(function(use)
			return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
		end),
		MultiLine = true,
		Size = UDim2.fromScale(1, 0),
		Text = props.copyText,
		TextColor3 = Theme.Color.BaseContent,
		TextEditable = false,
		TextSize = Theme.TextSize.Body,
		TextWrapped = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		[Children] = {
			scope:New "UIPadding" {
				PaddingTop = UDim.new(0, 8),
				PaddingBottom = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
			},
		},
	} :: TextBox

	local copyScroller = scope:New "ScrollingFrame" {
		Name = "CopyScroller",
		LayoutOrder = 2,
		AutomaticCanvasSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = Theme.Color.Base,
		CanvasSize = UDim2.new(),
		ClipsDescendants = true,
		ScrollBarImageColor3 = Theme.Color.NeutralContentDark,
		ScrollBarThickness = 6,
		ScrollingDirection = Enum.ScrollingDirection.XY,
		Selectable = false,
		Size = UDim2.fromScale(1, 1),
		Visible = scope:Computed(function(use) return use(activeTab) == "Copy" end),
		[Children] = {
			scope:New "UICorner" {
				CornerRadius = scope:Computed(function(use)
					return UDim.new(0, use(Theme.Layout.CornerRadius) :: number)
				end),
			},
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
			},
			scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
			copyTextBox,
		},
	}

	scope:Observer(activeTab):onChange(function()
		if Fusion.peek(activeTab) == "Copy" and Fusion.peek(props.visible) then
			task.defer(function()
				if Fusion.peek(props.visible) and Fusion.peek(activeTab) == "Copy" then
					copyTextBox:CaptureFocus()
				end
			end)
		end
	end)
	scope:Observer(props.visible):onChange(function()
		if Fusion.peek(props.visible) and Fusion.peek(activeTab) == "Copy" then
			task.defer(function()
				if Fusion.peek(props.visible) and Fusion.peek(activeTab) == "Copy" then
					copyTextBox:CaptureFocus()
				end
			end)
		end
	end)

	local loadTextBox = scope:New "TextBox" {
		Name = "LoadBox",
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
		ClearTextOnFocus = false,
		FontFace = scope:Computed(function(use)
			return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
		end),
		MultiLine = true,
		PlaceholderText = "Paste role data here...",
		PlaceholderColor3 = Theme.Color.NeutralContentDark,
		Size = UDim2.new(1, 0, 1, -50),
		Text = "",
		TextColor3 = Theme.Color.BaseContent,
		TextSize = Theme.TextSize.Body,
		TextWrapped = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		[Children] = {
			scope:New "UIPadding" {
				PaddingTop = UDim.new(0, 8),
				PaddingBottom = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
			},
		},
		[Fusion.Out "Text"] = loadInput,
	}

	local loadScroller = scope:New "ScrollingFrame" {
		Name = "LoadScroller",
		LayoutOrder = 2,
		AutomaticCanvasSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = Theme.Color.Base,
		CanvasSize = UDim2.new(),
		ClipsDescendants = true,
		ScrollBarImageColor3 = Theme.Color.NeutralContentDark,
		ScrollBarThickness = 6,
		ScrollingDirection = Enum.ScrollingDirection.XY,
		Selectable = false,
		Size = UDim2.fromScale(1, 1),
		Visible = scope:Computed(function(use) return use(activeTab) == "Load" end),
		[Children] = {
			scope:New "UICorner" {
				CornerRadius = scope:Computed(function(use)
					return UDim.new(0, use(Theme.Layout.CornerRadius) :: number)
				end),
			},
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
			},
			scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
			loadTextBox,
		},
	}

	local function makeTabButton(label: string, visible: UsedAs<boolean>?): Instance
		local isActive = scope:Computed(function(use) return use(activeTab) == label end)
		return Pressable(scope, {
			name = label .. "Tab",
			size = UDim2.fromOffset(96, 28),
			visible = visible,
			backgroundColor = scope:Computed(function(use)
				return if use(isActive) then use(Theme.Color.Primary) else use(Theme.Color.Neutral)
			end),
			onActivate = function()
				activeTab:set(label)
			end,
			[Children] = {
				scope:New "UICorner" {
					CornerRadius = scope:Computed(function(use)
						return UDim.new(0, use(Theme.Layout.CornerRadius) :: number)
					end),
				},
				scope:New "UIStroke" {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = Theme.Color.NeutralContent,
				},
				scope:New "TextLabel" {
					Name = "Label",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
					end),
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromScale(1, 1),
					Text = label,
					TextColor3 = scope:Computed(function(use)
						return if use(isActive) then use(Theme.Color.PrimaryContent) else use(Theme.Color.BaseContent)
					end),
					TextSize = Theme.TextSize.Body,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center,
				},
			},
		})
	end

	local tabStrip = scope:New "Frame" {
		Name = "Tabs",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 1,
		Size = UDim2.fromScale(1, 0),
		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				Padding = UDim.new(0, 6),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
			makeTabButton("Copy"),
			makeTabButton("Load", if props.hideLoad ~= nil
				then scope:Computed(function(use)
					return not (use(props.hideLoad :: any) == true)
				end)
				else nil
			),
		},
	}

	local loadButton = Pressable(scope, {
		name = "LoadButton",
		size = UDim2.new(1, 0, 0, 32),
		backgroundColor = Theme.Color.Primary,
		onActivate = function()
			local text = Fusion.peek(loadInput)
			local ok, message = props.onLoad(text)
			statusMessage:set(message)
			statusIsError:set(not ok)
			if ok then
				if props.onClose then
					props.onClose()
				else
					props.visible:set(false)
				end
			end
		end,
		[Children] = {
			scope:New "UICorner" {
				CornerRadius = scope:Computed(function(use)
					return UDim.new(0, use(Theme.Layout.CornerRadius) :: number)
				end),
			},
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
			},
			scope:New "TextLabel" {
				Name = "Label",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
				end),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromScale(1, 1),
				Text = "Load Data",
				TextColor3 = Theme.Color.PrimaryContent,
				TextSize = Theme.TextSize.Body,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
			},
		},
	})

	local loadControls = scope:New "Frame" {
		Name = "LoadControls",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 3,
		Size = UDim2.fromScale(1, 0),
		Visible = scope:Computed(function(use) return use(activeTab) == "Load" end),
		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
			loadButton,
			scope:New "TextLabel" {
				Name = "Status",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
				end),
				LayoutOrder = 2,
				Size = UDim2.fromScale(1, 0),
				Text = statusMessage,
				TextColor3 = scope:Computed(function(use)
					return if use(statusIsError) then use(Theme.Color.Error) else use(Theme.Color.NeutralContentDark)
				end),
				TextSize = Theme.TextSize.Body,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				Visible = scope:Computed(function(use)
					local msg = use(statusMessage)
					return typeof(msg) == "string" and msg ~= ""
				end),
			},
		},
	}

	return Popup(scope, {
		visible = props.visible,
		title = "Role Data",
		dismissible = true,
		backdropDismiss = true,
		onClose = props.onClose,
		cardSize = scope:Computed(function(use)
			local pad = use(Theme.Layout.Padding) :: number
			return UDim2.new(1, -pad * 2, 1, -32)
		end),
		content = {
			tabStrip,
			copyScroller,
			loadScroller,
		},
		-- In actions so it stays pinned below the body when the scrollers flex-fill
		actions = { loadControls },
	})
end

--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local Out = Fusion.Out
local Pressable = require(frontend.Components.Pressable)
local Platform = require(frontend.Util.Platform)
local Icons = require(frontend.Config.Icons)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	text: UsedAs<string>,
	visible: Fusion.Value<boolean>,
	title: UsedAs<string>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local rootSize: Fusion.Value<Vector2> = scope:Value(Vector2.zero)

	local textBox = scope:New "TextBox" {
		Name = "CommandText",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		ClearTextOnFocus = false,
		FontFace = scope:Computed(function(use)
			return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
		end),
		MultiLine = true,
		Size = UDim2.fromScale(1, 0),
		Text = props.text,
		TextColor3 = Theme.Color.BaseContent,
		TextEditable = false,
		TextSize = Theme.TextSize.Body,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,

		[Children] = {
			scope:New "UIPadding" {
				PaddingTop = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
				PaddingBottom = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
				PaddingLeft = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
				PaddingRight = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
			},
		},
	} :: TextBox

	-- Long text used to push the card off screen with no way to reach the rest, so the box caps to the popup and scrolls
	local textScroller = scope:New "ScrollingFrame" {
		Name = "TextScroller",
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Theme.Color.Base,
		BorderSizePixel = 0,
		BottomImage = "rbxassetid://16547643439",
		CanvasSize = UDim2.new(),
		LayoutOrder = 2,
		MidImage = "rbxassetid://16547330984",
		ScrollBarImageColor3 = Theme.Color.NeutralContentDark,
		ScrollBarImageTransparency = if Platform.isMobile then 1 else 0,
		ScrollBarThickness = if Platform.isMobile then 2 else 8,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Selectable = false,
		Size = UDim2.fromScale(1, 0),
		TopImage = "rbxassetid://16547667444",
		VerticalScrollBarInset = Enum.ScrollBarInset.Always,
		ZIndex = 11,

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
			scope:New "UISizeConstraint" {
				-- The 140 covers the header, card paddings and a screen-edge margin
				MaxSize = scope:Computed(function(use)
					local rootHeight = (use(rootSize) :: Vector2).Y
					return Vector2.new(math.huge, math.max(120, rootHeight - 140))
				end),
			},
			textBox,
		},
	}

	scope:Observer(props.visible):onChange(function()
		if Fusion.peek(props.visible) :: boolean then
			task.defer(function()
				if Fusion.peek(props.visible) :: boolean then
					textBox:CaptureFocus()
				end
			end)
		end
	end)

	return scope:New "Frame" {
		Name = "CopyPopup",
		BackgroundColor3 = Theme.Color.NeutralDark,
		BackgroundTransparency = 0.05,
		Position = UDim2.fromScale(0, 0),
		Size = UDim2.new(1, 1, 1, 0),
		Visible = props.visible,
		ZIndex = 10,
		[Out("AbsoluteSize")] = rootSize,

		[Children] = {
			scope:New "UICorner" {
				CornerRadius = UDim.new(0, 6),
			},
			Pressable(scope, {
				name = "Backdrop",
				size = UDim2.fromScale(1, 1),
				zIndex = 10,
				onActivate = function()
					props.visible:set(false)
					textBox:ReleaseFocus()
				end,
			}),

			scope:New "TextButton" {
				Name = "Card",
				AnchorPoint = Vector2.new(0.5, 0.5),
				AutomaticSize = Enum.AutomaticSize.Y,
				AutoButtonColor = false,
				BackgroundColor3 = Theme.Color.Neutral,
				Position = UDim2.fromScale(0.5, 0.5),
				Size = scope:Computed(function(use)
					return UDim2.new(1, -(use(Theme.Layout.Padding) :: number) * 2, 0, 0)
				end),
				Text = "",
				ZIndex = 11,

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
					scope:New "UIPadding" {
						PaddingTop = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
						PaddingBottom = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
						PaddingLeft = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
						PaddingRight = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
					},
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalFlex = Enum.UIFlexAlignment.Fill,
						SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding) :: number) end),
					},

					scope:New "Frame" {
						Name = "Header",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						LayoutOrder = 1,
						Size = UDim2.fromScale(1, 0),
						ZIndex = 11,

						[Children] = {
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								HorizontalFlex = Enum.UIFlexAlignment.Fill,
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Center,
							},
							scope:New "TextLabel" {
								Name = "Title",
								AutomaticSize = Enum.AutomaticSize.XY,
								BackgroundTransparency = 1,
								FontFace = scope:Computed(function(use)
									return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
								end),
								LayoutOrder = 1,
								Text = props.title or "Copy command",
								TextColor3 = Theme.Color.BaseContent,
								TextSize = Theme.TextSize.Subtitle,
								TextXAlignment = Enum.TextXAlignment.Left,
								ZIndex = 11,
								[Children] = {
									scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
								},
							},
							Pressable(scope, {
								name = "CloseButton",
								layoutOrder = 2,
								size = scope:Computed(function(use)
									local textSize = use(Theme.TextSize.Subtitle) :: number
									return UDim2.fromOffset(textSize, textSize)
								end),
								zIndex = 11,
								iconImage = Icons.Close,
								iconColor = Theme.Color.NeutralContentDark,
								iconSize = Theme.TextSize.Subtitle,
								onActivate = function()
									props.visible:set(false)
									textBox:ReleaseFocus()
								end,
								[Children] = {
									scope:New "UIAspectRatioConstraint" { AspectRatio = 1 },
								},
							}),
						},
					},

					textScroller,
				},
			},
		},
	}
end

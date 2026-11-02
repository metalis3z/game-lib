--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Icons = require(frontend.Config.Icons)
local Children = Fusion.Children
local Pressable = require(frontend.Components.Pressable)
 

-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	title: UsedAs<string>?,
	showLogo: UsedAs<boolean>?,
	showBeta: UsedAs<boolean>?, -- corner "v2 BETA" chip in the left slot
	onBeta: (() -> ())?,
	canGoBack: UsedAs<boolean>?,
	onBack: (() -> ())?,
	onClose: (() -> ())?,
	onDrag: ((delta: Vector2) -> ())?,
	leftAction: Instance?,
	rightAction: Instance?,
}


-- LOCAL FUNCTIONS
local function fireCallback(callback: any)
	local handler = if typeof(callback) == "table" then Fusion.peek(callback) else callback
	if handler then
		handler()
	end
end

local function iconButton(scope: Scope, image: string, imageTransparency: any, onActivate: any, iconSize: number?, interactable: any?, anchorPoint: Vector2?, position: UDim2?): Instance
	local size = iconSize or 20
	local imgTransparency = if imageTransparency ~= nil then imageTransparency else 0
	return Pressable(scope, {
		anchorPoint = anchorPoint,
		position = position,
		size = UDim2.fromOffset(36, 36),
		iconImage = image,
		iconColor = Theme.Color.PrimaryContent,
		iconSize = size,
		iconTransparency = imgTransparency,
		interactable = interactable,
		onActivate = function() fireCallback(onActivate) end,

		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			scope:New "UIPadding" {
				PaddingTop = UDim.new(0, 4),
				PaddingBottom = UDim.new(0, 4),
				PaddingLeft = UDim.new(0, 4),
				PaddingRight = UDim.new(0, 4),
			},
		},
	})
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local lastDragPos = Vector2.zero

	return scope:New "Frame" {
		Name = "TitleBar",
		AutomaticSize = Enum.AutomaticSize.None,
		Size = UDim2.new(1, 0, 0, 45),
		BackgroundColor3 = Color3.new(1, 1, 1),
		BorderSizePixel = 0,
		LayoutOrder = 1,

		[Children] = {
			scope:New "UIPadding" {
				PaddingTop = UDim.new(0, 8),
				PaddingBottom = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 8),
			},
			scope:New "UIGradient" {
				Color = scope:Computed(function(use)
					local primary = use(Theme.Color.Primary)
					local hue, saturation, value = Color3.toHSV(primary)
					local lighter = Color3.fromHSV(hue, saturation * 0.92, math.min(value * 1.06, 1))
					return ColorSequence.new({
						ColorSequenceKeypoint.new(0, primary),
						ColorSequenceKeypoint.new(1, lighter),
					})
				end),
				Rotation = -90,
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
				Padding = UDim.new(0, 16),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			},
			scope:New "UIDragDetector" {
				DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
				ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomScale,

				[Fusion.OnEvent "DragStart"] = function(cursorPosition: Vector2)
					lastDragPos = cursorPosition
				end,

				[Fusion.OnEvent "DragContinue"] = function(cursorPosition: Vector2)
					if props.onDrag then
						props.onDrag(cursorPosition - lastDragPos)
					end
					lastDragPos = cursorPosition
				end,
			},

			-- Keeps the 36px footprint so the title stays centred
			scope:New "Frame" {
				Name = "LeftSlot",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 36, 1, 0),

				[Children] = {
					-- Invisible when disabled but still takes space so the title stays put
					iconButton(scope, Icons.ArrowLeft,
						scope:Computed(function(use)
							local canGoBack = props.canGoBack
							local value = if typeof(canGoBack) == "table" then use(canGoBack) else canGoBack
							return if value then 0 else 1
						end),
						props.onBack,
						23,
						scope:Computed(function(use)
							local canGoBack = props.canGoBack
							local value = if typeof(canGoBack) == "table" then use(canGoBack) else canGoBack
							return value == true
						end),
						Vector2.new(0, 0.5),
						UDim2.new(0, 0, 0.5, 0)
					),
					props.leftAction,

					-- A CanvasGroup because plain frames can't clip rotated children, so
					-- the diagonal ribbon gets cut to this corner box
					(function()
						local hovered = scope:Value(false)
						local pressed = scope:Value(false)
						local ribbonColor = scope:Computed(function(use)
							local darker = (use(Theme.Color.Primary) :: Color3):Lerp(Color3.new(0, 0, 0), 0.25)
							return Pressable.applyHighlight(use, darker, pressed, hovered)
						end)
						return scope:New "CanvasGroup" {
							Name = "BetaBadge",
							BackgroundTransparency = 1,
							Position = UDim2.fromOffset(-8, -8),
							Size = UDim2.fromOffset(64, 45),
							Visible = if props.showBeta ~= nil then props.showBeta else false,
							ZIndex = 3,

							[Children] = {
								scope:New "Frame" {
									Name = "Ribbon",
									AnchorPoint = Vector2.new(0.5, 0.5),
									BackgroundColor3 = ribbonColor,
									BackgroundTransparency = 0.15,
									BorderSizePixel = 0,
									Position = UDim2.fromOffset(24, 22),
									Rotation = -45,
									Size = UDim2.fromOffset(110, 21),

									[Children] = {
										scope:New "TextLabel" {
											Name = "Label",
											BackgroundTransparency = 1,
											FontFace = scope:Computed(function(use)
												return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
											end),
											Size = UDim2.fromScale(1, 1),
											Text = "v2 BETA",
											TextColor3 = Theme.Color.PrimaryContent,
											TextSize = Theme.TextSize.Small,
											TextXAlignment = Enum.TextXAlignment.Center,
											TextYAlignment = Enum.TextYAlignment.Center,
										},
									},
								},

								Pressable(scope, {
									name = "RibbonHit",
									size = UDim2.fromScale(1, 1),
									onActivate = function() fireCallback(props.onBeta) end,
									onHoverChanged = function(isHovered) hovered:set(isHovered) end,
									onPressChanged = function(isPressed) pressed:set(isPressed) end,
								}),
							},
						}
					end)(),
				},
			},

			scope:New "Frame" {
				Name = "Title",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				[Children] = {
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						Padding = UDim.new(0, 9),
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center,
					},
					scope:New "ImageLabel" {
						Name = "Logo",
						BackgroundTransparency = 1,
						Image = Icons.LogoGlyph,
						ImageColor3 = Theme.Color.PrimaryContent,
						Size = UDim2.fromOffset(24, 24),
						Visible = if props.showLogo ~= nil then props.showLogo else false,
						[Children] = {
							scope:New "UICorner" { CornerRadius = UDim.new(0, 3) },
						},
					},
					scope:New "TextLabel" {
						Name = "Text",
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
					end),
					RichText = true,
					Text = props.title or "HD Admin",
					TextColor3 = Theme.Color.PrimaryContent,
					TextSize = Theme.TextSize.Title,
						TextXAlignment = Enum.TextXAlignment.Left,
					},
				},
			},

			scope:New "Frame" {
				Name = "RightSlot",
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 36, 1, 0),

				[Children] = {
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 6),
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center,
					},
					props.rightAction,
					(function()
						local close = iconButton(scope, Icons.Close, nil, props.onClose);
						(close :: any).LayoutOrder = 10
						return close
					end)(),
				},
			},
		},
	}
end


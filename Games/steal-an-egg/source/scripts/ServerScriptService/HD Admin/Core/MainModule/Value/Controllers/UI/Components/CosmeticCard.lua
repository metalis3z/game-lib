--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Pressable = require(frontend.Components.Pressable)
local FavouriteButton = require(frontend.Components.FavouriteButton)
local UnlockButton = require(frontend.Components.UnlockButton)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	accessoryId: number,
	name: UsedAs<string>,
	robuxPrice: UsedAs<number>,
	isFavourited: UsedAs<boolean>,
	onFavourite: (() -> ())?, -- yields on the Roblox favourite prompt
	onBuy: (() -> ())?,
	layoutOrder: UsedAs<number>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local thumbUrl = "rbxthumb://type=Asset&id=" .. tostring(props.accessoryId) .. "&w=150&h=150"
	local hovered = scope:Value(false)
	local pressed = scope:Value(false)
	local favLoading = scope:Value(false) -- spinner on the star while the Roblox prompt is open
	local bodyColor = scope:Computed(function(use)
		return Pressable.applyHighlight(use, use(Theme.Color.Neutral) :: Color3, pressed, hovered)
	end)

	return scope:New "Frame" {
		Name = "CosmeticCard",
		BackgroundColor3 = bodyColor,
		LayoutOrder = props.layoutOrder,
		Size = UDim2.new(0, 0, 0, 136),

		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(0, 9) },
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
			},

			Pressable(scope, {
				name = "Body",
				size = UDim2.new(1, 0, 0, 108),
				automaticSize = Enum.AutomaticSize.None,
				onActivate = function()
					if props.onBuy then props.onBuy() end
				end,
				onHoverChanged = function(isHovered) hovered:set(isHovered) end,
				onPressChanged = function(isPressed) pressed:set(isPressed) end,
				[Children] = {
					scope:New "ImageLabel" {
						Name = "Thumb",
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundTransparency = 1,
						Image = thumbUrl,
						Position = UDim2.new(0.5, 0, 0, 8),
						ScaleType = Enum.ScaleType.Fit,
						Size = UDim2.fromOffset(70, 70),
					},
					scope:New "TextLabel" {
						Name = "Name",
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundTransparency = 1,
						FontFace = scope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
						end),
						Position = UDim2.new(0.5, 0, 0, 84),
						Size = UDim2.new(1, -16, 0, 18),
						Text = props.name,
						TextColor3 = Theme.Color.BaseContent,
						TextSize = Theme.TextSize.Body,
						TextTruncate = Enum.TextTruncate.AtEnd,
						TextXAlignment = Enum.TextXAlignment.Center,
					},
					FavouriteButton(scope, {
						isFavourited = props.isFavourited,
						loading = favLoading,
						onToggle = function()
							if Fusion.peek(favLoading) then return end
							favLoading:set(true)
							task.spawn(function()
								if props.onFavourite then props.onFavourite() end
								favLoading:set(false)
							end)
						end,
						buttonSize = 26,
						iconSize = 16,
						anchorPoint = Vector2.new(1, 0),
						position = UDim2.new(1, -6, 0, 6),
					}),
				},
			}),

			scope:New "Frame" {
				Name = "UnlockHolder",
				AnchorPoint = Vector2.new(0.5, 1),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.5, 1),
				Size = UDim2.new(1, 0, 0, 28),
				[Children] = {
					UnlockButton(scope, {
						onUnlock = props.onBuy,
						robuxPrice = props.robuxPrice,
						flatTop = true,
						style = "Neutral",
					}),
				},
			},
		},
	}
end

--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Pressable = require(frontend.Components.Pressable)
local Icons = require(frontend.Config.Icons)
local FavouriteButton = require(frontend.Components.FavouriteButton)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	commandName: string,
	icon: string?,
	isFavourited: UsedAs<boolean>?,
	onFavourite: (() -> ())?, -- when set, a favourite star shows in the corner
	onRun: (() -> ())?,
	layoutOrder: number?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local hovered = scope:Value(false)
	local pressed = scope:Value(false)
	local favLoading = scope:Value(false) -- spinner on the star while the Roblox prompt is open
	local bodyColor = scope:Computed(function(use)
		return Pressable.applyHighlight(use, use(Theme.Color.Neutral), pressed, hovered)
	end)

	-- The generic fallback icon reads better a bit smaller than a real emote/bundle thumbnail
	local thumbSize = if props.icon then 64 else 38
	local bodyChildren: {any} = {
		scope:New "ImageLabel" {
			Name = "Thumb",
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundTransparency = 1,
			Image = props.icon or Icons.Pages.Commands,
			Position = UDim2.new(0.5, 0, 0, 8 + (64 - thumbSize) / 2),
			ScaleType = Enum.ScaleType.Fit,
			Size = UDim2.fromOffset(thumbSize, thumbSize),
		},
		scope:New "TextLabel" {
			Name = "Name",
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundTransparency = 1,
			FontFace = scope:Computed(function(use)
				return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
			end),
			Position = UDim2.new(0.5, 0, 0, 80),
			Size = UDim2.new(1, -12, 0, 18),
			Text = props.commandName,
			TextColor3 = Theme.Color.BaseContent,
			TextSize = Theme.TextSize.Body,
			TextTruncate = Enum.TextTruncate.AtEnd,
			TextXAlignment = Enum.TextXAlignment.Center,
		},
	}
	if props.onFavourite then
		table.insert(bodyChildren, FavouriteButton(scope, {
			isFavourited = props.isFavourited or false,
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
		}))
	end

	return scope:New "Frame" {
		Name = "CommandCard",
		BackgroundColor3 = bodyColor,
		LayoutOrder = props.layoutOrder,
		Size = UDim2.new(0, 0, 0, 108),

		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(0, 9) },
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
			},

			Pressable(scope, {
				name = "Body",
				size = UDim2.fromScale(1, 1),
				automaticSize = Enum.AutomaticSize.None,
				onActivate = function()
					if props.onRun then props.onRun() end
				end,
				onHoverChanged = function(isHovered) hovered:set(isHovered) end,
				onPressChanged = function(isPressed) pressed:set(isPressed) end,
				[Children] = bodyChildren,
			}),
		},
	}
end

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
	emoteName: UsedAs<string>,
	emoteId: number,
	isFavourited: UsedAs<boolean>,
	isActive: UsedAs<boolean>?, -- the emote is currently playing on you
	onRun: (() -> ())?,
	onFavourite: (() -> ())?,
	onUnlock: (() -> ())?,
	layoutOrder: UsedAs<number>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local thumbUrl = "rbxthumb://type=Asset&id=" .. tostring(props.emoteId) .. "&w=150&h=150"
	local isActive: any = props.isActive
	local hovered = scope:Value(false)
	local pressed = scope:Value(false)
	local favLoading = scope:Value(false) -- spinner on the star while the Roblox prompt is open
	local bodyColor = scope:Computed(function(use)
		local base = use(Theme.Color.Neutral)
		if isActive and use(isActive) then
			base = base:Lerp(use(Theme.Color.Primary), 0.35)
		end
		return Pressable.applyHighlight(use, base, pressed, hovered)
	end)
	local strokeColor = scope:Computed(function(use)
		if isActive and use(isActive) then
			return use(Theme.Color.Primary)
		end
		return use(Theme.Color.NeutralStroke)
	end)

	return scope:New "Frame" {
		Name = "EmoteCard",
		BackgroundColor3 = bodyColor,
		LayoutOrder = props.layoutOrder,
		Size = UDim2.new(0, 0, 0, if props.onUnlock then 136 else 108),

		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(0, 9) },
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = strokeColor,
			},

			Pressable(scope, {
				name = "Body",
				size = UDim2.new(1, 0, 0, 108),
				automaticSize = Enum.AutomaticSize.None,
				onActivate = function()
					if props.onRun then props.onRun() end
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
						Text = props.emoteName,
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

			if props.onUnlock then scope:New "Frame" {
				Name = "UnlockHolder",
				AnchorPoint = Vector2.new(0.5, 1),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.5, 1),
				Size = UDim2.new(1, 0, 0, 28),
				[Children] = {
					UnlockButton(scope, {
						onUnlock = props.onUnlock,
						flatTop = true,
					}),
				},
			} else nil,
		},
	}
end

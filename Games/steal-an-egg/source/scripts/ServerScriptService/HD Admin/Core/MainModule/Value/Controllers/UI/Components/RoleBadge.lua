--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Navigate = require(frontend.Util.Navigate)
local Pressable = require(frontend.Components.Pressable)
local Platform = require(frontend.Util.Platform)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	id: UsedAs<string>?,
	name: UsedAs<string>?,
	color: UsedAs<Color3>?,
	userId: UsedAs<number>?, -- shows remove button when set
	onRemove: UsedAs<(roleId: string, userId: number) -> ()>?,
	large: boolean?, -- bumps padding, dot, and text size for the profile page
	isPermanent: UsedAs<boolean>?, -- adds a cloud icon to the LEFT of the colour dot
	isGiver: UsedAs<boolean>?, -- unlocked-padlock icon, shown alongside the cloud when both are true
	backgroundColor: UsedAs<Color3>?,
	layoutOrder: UsedAs<number>?,
	pillHeight: number?,
	textSize: number?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local id = props.id or scope:Value("Guest")
	local name = props.name or scope:Value("Guest")
	local color = props.color or Theme.Color.Primary
	local userId = props.userId
	local onRemove = props.onRemove
	local large = props.large == true

	local padH = if large then 11 else 8
	local dotSize = if large then 10 else 8
	local gap = if large then 6 else 4
	local textSize = props.textSize or (if large then 17 else Theme.TextSize.Label)
	-- Fixed height so badges match with or without the remove button
	local pillHeight = props.pillHeight or (if large then 29 else 22)

	return scope:New "Frame" {
		Name = "RoleBadge",
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = props.backgroundColor or Theme.Color.Neutral,
		LayoutOrder = props.layoutOrder or 0,
		Size = UDim2.fromOffset(0, pillHeight),

		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
			scope:New "UIPadding" {
				PaddingLeft = UDim.new(0, padH),
				PaddingRight = UDim.new(0, padH),
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, gap),
			},

			scope:New "ImageLabel" {
				Name = "PermIcon",
				LayoutOrder = 0,
				BackgroundTransparency = 1,
				Image = "rbxassetid://132613467203568",
				ImageColor3 = Theme.Color.BaseContent,
				Size = UDim2.fromOffset(dotSize + 4, dotSize + 4),
				Visible = if props.isPermanent ~= nil then props.isPermanent else false,
			},

			scope:New "ImageLabel" {
				Name = "GiverIcon",
				LayoutOrder = 0,
				BackgroundTransparency = 1,
				Image = "rbxassetid://88899389634128",
				ImageColor3 = Theme.Color.BaseContent,
				Size = UDim2.fromOffset(dotSize + 4, dotSize + 4),
				Visible = if props.isGiver ~= nil then props.isGiver else false,
			},

			scope:New "Frame" {
				Name = "Dot",
				LayoutOrder = 1,
				Size = UDim2.fromOffset(dotSize, dotSize),
				BackgroundColor3 = color,
				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
				},
			},

			scope:New "TextLabel" {
				Name = "Name",
				LayoutOrder = 2,
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
				end),
				Text = name,
				TextColor3 = Theme.Color.BaseContent,
				TextSize = textSize,
				TextWrapped = false,
			},

			scope:Computed(function(use, innerScope)
				local uid = userId and use(userId) or nil
				if uid == nil then return nil end
				local function fireRemove()
					local callback = onRemove
					if callback then
						local handler = if typeof(callback) == "table" then Fusion.peek(callback) else callback
						if handler then handler(Fusion.peek(id), uid) end
					end
				end
				local removeSize = if large then 22 else 18
				local iconSizePx = if large then 12 else 10
				local hovered: Fusion.Value<boolean> = innerScope:Value(false)
				local pressed: Fusion.Value<boolean> = innerScope:Value(false)
				local haloTransparencyTarget = innerScope:Computed(function(use2)
					if use2(pressed) then return 0.65 end
					if use2(hovered) then return 0.82 end
					return 1
				end)
				local haloTransparency: any = if Platform.isMobile
					then haloTransparencyTarget
					else (innerScope :: any):Spring(haloTransparencyTarget, 70, 1)
				local pressable = Pressable(innerScope, {
					name = "Remove",
					layoutOrder = 3,
					size = UDim2.fromOffset(removeSize, removeSize),
					backgroundColor = nil :: any,
					iconImage = "rbxassetid://80218226919142",
					iconColor = Theme.Color.NeutralContentDark,
					iconSize = iconSizePx,
					onActivate = fireRemove,
					onHoverChanged = function(isHovered: boolean) hovered:set(isHovered) end,
					onPressChanged = function(isPressed: boolean) pressed:set(isPressed) end,
					[Children] = {
						innerScope:New "Frame" {
							Name = "Halo",
							BackgroundColor3 = Theme.Color.NeutralContent,
							BackgroundTransparency = haloTransparency,
							BorderSizePixel = 0,
							Size = UDim2.fromScale(1, 1),
							ZIndex = 0,
							[Children] = {
								innerScope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
							},
						},
					},
				})
				return Navigate.makeActivatable(pressable, fireRemove)
			end),
		},
	}
end

--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	userId: UsedAs<number>?, -- ignored when iconImage is set
	displayName: UsedAs<string>?, -- falls back to userId
	username: UsedAs<string>?, -- omitted when empty or when subtitle is set
	subtitle: UsedAs<string>?, -- replaces username, rendered dim with no @ prefix
	iconImage: UsedAs<string>?, -- overrides the avatar thumb URL
	iconImageInset: number?, -- shrinks the drawn glyph, the circle keeps iconSize
	layoutOrder: UsedAs<number>?,
	iconSize: number?, -- default 24
	singleLine: boolean?, -- one line with truncation, default wraps
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local userId = props.userId or scope:Value(1)
	local displayNameProp = props.displayName
	local usernameProp = props.username
	local subtitleProp = props.subtitle
	local iconImageProp = props.iconImage
	local iconImageInset = props.iconImageInset or 0
	local iconSize = props.iconSize or 24
	local singleLine = props.singleLine == true

	local avatarImage = scope:Computed(function(use)
		if iconImageProp ~= nil then
			local image = if typeof(iconImageProp) == "table" then use(iconImageProp :: any) else iconImageProp
			if typeof(image) == "string" then return image end
		end
		return `rbxthumb://type=AvatarHeadShot&id={use(userId)}&w=48&h=48`
	end)

	-- Matches the CheckItem "player" rendering
	local displayText = scope:Computed(function(use)
		local id = use(userId)
		local header: string? = if displayNameProp ~= nil
			then (if typeof(displayNameProp) == "table" then use(displayNameProp :: any) else displayNameProp)
			else nil
		if typeof(header) ~= "string" or #header == 0 then
			header = tostring(id)
		end
		local subtitle: string? = if subtitleProp ~= nil
			then (if typeof(subtitleProp) == "table" then use(subtitleProp :: any) else subtitleProp)
			else nil
		if typeof(subtitle) == "string" and #subtitle > 0 then
			local dim: Color3 = use(Theme.Color.NeutralContentDark)
			local hex = string.format("#%02X%02X%02X",
				math.round(dim.R * 255), math.round(dim.G * 255), math.round(dim.B * 255))
			return string.format("<b>%s</b> <font color=\"%s\">(%s)</font>", header, hex, subtitle)
		end
		local body: string? = if usernameProp ~= nil
			then (if typeof(usernameProp) == "table" then use(usernameProp :: any) else usernameProp)
			else nil
		if typeof(body) == "string" and #body > 0 then
			local dim: Color3 = use(Theme.Color.NeutralContentDark)
			local hex = string.format("#%02X%02X%02X",
				math.round(dim.R * 255), math.round(dim.G * 255), math.round(dim.B * 255))
			return string.format("<b>%s</b> <font color=\"%s\">(@%s)</font>", header, hex, body)
		end
		return string.format("<b>%s</b>", header)
	end)

	return scope:New "Frame" {
		Name = "UserDetails",
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
		LayoutOrder = props.layoutOrder,

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 6),
			},
			scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },

			scope:New "Frame" {
				Name = "IconHolder",
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				Size = UDim2.fromOffset(iconSize, 0),
				[Children] = {
					scope:New "ImageLabel" {
						Name = "Icon",
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.fromRGB(61, 61, 63),
						Image = if iconImageInset > 0 then "" else (avatarImage :: any), -- the centred Glyph child draws it instead
						Position = UDim2.fromScale(0, 0.5),
						ScaleType = Enum.ScaleType.Fit,
						Size = UDim2.fromOffset(iconSize - 2, iconSize - 2),
						[Children] = (function(): {any}
							local iconChildren: {any} = {
								scope:New "UICorner" { CornerRadius = UDim.new(0.5, 0) },
							}
							if iconImageInset > 0 then
								local glyphSize = math.max(0, iconSize - 2 - iconImageInset * 2)
								table.insert(iconChildren, scope:New "ImageLabel" {
									Name = "Glyph",
									AnchorPoint = Vector2.new(0.5, 0.5),
									BackgroundTransparency = 1,
									Image = avatarImage,
									Position = UDim2.fromScale(0.5, 0.5),
									ScaleType = Enum.ScaleType.Fit,
									Size = UDim2.fromOffset(glyphSize, glyphSize),
								})
							end
							return iconChildren
						end)(),
					},
				},
			},

			scope:New "TextLabel" {
				Name = "ContentArea",
				LayoutOrder = 2,
				AutomaticSize = if singleLine then Enum.AutomaticSize.None else Enum.AutomaticSize.Y, -- singleLine truncates, otherwise wraps
				BackgroundTransparency = 1,
				Size = if singleLine then UDim2.new(1, 0, 1, 0) else UDim2.fromOffset(0, 0),
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
				end),
				RichText = true,
				Text = displayText,
				TextColor3 = Theme.Color.BaseContent,
				TextSize = Theme.TextSize.Subtitle,
				TextTruncate = Enum.TextTruncate.SplitWord,
				TextWrapped = not singleLine,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = if singleLine then Enum.TextYAlignment.Center else Enum.TextYAlignment.Top,
				[Children] = {
					scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
				},
			},
		},
	}
end

-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/FavoriteMode.rbxm by _tools/rbxm2lua.luau
-- UI builder: local gui = require(this)(); gui.Parent = game.Players.LocalPlayer.PlayerGui (or StarterGui)

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("ImageButton", nil, "FavoriteMode", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Position = UDim2.fromScale(0.9, 1.02), Selectable = false, Size = UDim2.fromScale(0.2, 0.1), ZIndex = 50 }, { ["_lemonadeUniqueId"] = "2RR1sSTT2RR1" })
		I[2] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Interactable = false, Position = UDim2.fromScale(0.5697614, 0.4999996), Size = UDim2.fromScale(0.752061, 0.6484563), Text = "Favorite: OFF", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 52 }, { ["_lemonadeUniqueId"] = "MpNLZVMaMpNL" })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 1.3462963 }, { ["_lemonadeUniqueId"] = "xAR5YSz9xAR5", ["oldp_Thickness"] = 2 })
		I[4] = new("ImageLabel", I[1], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(244, 249, 243), ImageContent = Content.fromUri("rbxassetid://96735047582734"), ImageTransparency = 0.85, Position = UDim2.fromScale(0.4915327, 0.4806248), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.2130487, 1.5039177), SliceCenter = Rect.new(256, 256, 256, 256), SliceScale = 0.2692593, ZIndex = 9 }, { ["_lemonadeUniqueId"] = "L1yVhwjdL1yV", ["oldp_SliceScale"] = 0.4 })
		I[5] = new("ImageLabel", I[1], "FavIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://115988933043114"), Position = UDim2.fromScale(0.1048459, 0.5093954), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1309738, 0.5765888), ZIndex = 55 }, { ["_lemonadeUniqueId"] = "RhJwupYmRhJw" })
			I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "F6sUOFwmF6sU" })
		I[7] = new("ImageLabel", I[1], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://73214197551985"), Interactable = false, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = true, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(64, 64, 64, 64), SliceScale = 0.1346296, ZIndex = 50 }, { ["_lemonadeUniqueId"] = "8Xeg8YHR8Xeg" })
			I[8] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(249, 68, 219)), ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 0, 175)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "6uZ76mZT6uZ7" })
			I[9] = new("ImageLabel", I[7], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131176354845909"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1.0000001, 0.9999999), TileSize = UDim2.fromScale(0.5, 1.25), ZIndex = 51 }, { ["_lemonadeUniqueId"] = "XouSX8kYXouS" })
		I[10] = new("UIScale", I[1], "ButtonUIScale", nil, { ["_lemonadeUniqueId"] = "20XXjqaC20XX" })
		I[11] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 4 }, { ["_lemonadeUniqueId"] = "Bz2Li0mKBz2L" })
	return I[1]
end

return build

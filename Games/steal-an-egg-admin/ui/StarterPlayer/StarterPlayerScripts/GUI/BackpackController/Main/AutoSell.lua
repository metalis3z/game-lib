-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/AutoSell.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "AutoSell", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Position = UDim2.fromScale(0.8969465, -0.085), Selectable = false, Size = UDim2.fromScale(0.2061069, 0.1374066), ZIndex = 13 }, { ["_lemonadeUniqueId"] = "YHsLh9EcYHsL" })
		I[2] = new("ImageButton", I[1], "TextButton", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://73214197551985"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(64, 64, 64, 64), SliceScale = 0.2, ZIndex = 10 }, { ["_lemonadeUniqueId"] = "p91yud44p91y" })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(242, 249, 235)), ColorSequenceKeypoint.new(1, Color3.fromRGB(172, 175, 172)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "uczB5k0QuczB" })
		I[4] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Interactable = false, Position = UDim2.fromScale(0.4999998, 0.4999998), Size = UDim2.fromScale(0.8518064, 0.6484563), Text = "Auto Sell", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 12 }, { ["_lemonadeUniqueId"] = "PWmeeCxZPWme" })
			I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "DyTWD4iADyTW" })
		I[6] = new("UIScale", I[1], "UIScale", nil, { ["_lemonadeUniqueId"] = "mKJbPeummKJb" })
		I[7] = new("ImageLabel", I[1], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(244, 249, 243), ImageContent = Content.fromUri("rbxassetid://96735047582734"), ImageTransparency = 0.85, Position = UDim2.fromScale(0.4915327, 0.4806248), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.2130487, 1.5039177), SliceCenter = Rect.new(256, 256, 256, 256), SliceScale = 0.4, ZIndex = 9 }, { ["_lemonadeUniqueId"] = "TvV2HilrTvV2" })
	return I[1]
end

return build

-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/RoundChoices.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "RoundChoices", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 43, 43), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1000, Position = UDim2.fromScale(0.5, -0.5), Selectable = true, Size = UDim2.fromScale(1.4, 0.5), Visible = false, ZIndex = -2 }, { ["_lemonadeUniqueId"] = "43K0JXsw43K0" })
		I[2] = new("ImageButton", I[1], "DropAsset", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 43, 43), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = -2 }, { ["_lemonadeUniqueId"] = "4I1eHkE04I1e" })
			I[3] = new("TextLabel", I[2], "Label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.7), Text = "Drop", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "7AUqXsVv7AUq" })
				I[4] = new("UIGradient", I[3], "UIGradient", nil, { ["_lemonadeUniqueId"] = "P79kgToKP79k" })
				I[5] = new("UIStroke", I[3], "UIStroke", { Thickness = 1.202963 }, { ["_lemonadeUniqueId"] = "leqIguVbleqI", ["oldp_Thickness"] = 1.6 })
			I[6] = new("UIScale", I[2], "ButtonUIScale", nil, { ["_lemonadeUniqueId"] = "v2ziGufvv2zi" })
			I[7] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 93, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 34, 86)) }), Enabled = false, Rotation = 90 }, { ["_lemonadeUniqueId"] = "Tpce8O7RTpce" })
			I[8] = new("UISizeConstraint", I[2], "UISizeConstraint", { MaxSize = Vector2.new(math.huge, 100) }, { ["_lemonadeUniqueId"] = "Ajn3reVJAjn3" })
			I[9] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(88, 0, 0), Thickness = 1.8796296 }, { ["_lemonadeUniqueId"] = "fgeNll7JfgeN", ["oldp_Thickness"] = 2.5 })
			I[10] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.5 }, { ["_lemonadeUniqueId"] = "bgfgVfCkbgfg" })
			I[11] = new("ImageLabel", I[2], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131176354845909"), ImageTransparency = 0.72, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1.0000001, 0.9999999), TileSize = UDim2.fromScale(0.8, 2), Visible = false, ZIndex = -1 }, { ["_lemonadeUniqueId"] = "GxnoLPA4Gxno" })
			I[12] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) }, { ["_lemonadeUniqueId"] = "yLu6skfvyLu6" })
		I[13] = new("ImageButton", I[1], "EscapeAndKeep", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(1.6125184, 0.4887811), Size = UDim2.fromScale(0.967259, 0.7787313), Visible = false, ZIndex = -2 }, { ["_lemonadeUniqueId"] = "bha3XFWwbha3" })
			I[14] = new("TextLabel", I[13], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "Escape", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "IxOwK27tIxOw" })
				I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(0, 144, 29), Thickness = 1.202963 }, { ["_lemonadeUniqueId"] = "z0aFFlRDz0aF", ["oldp_Thickness"] = 1.6 })
			I[16] = new("UIGradient", I[13], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 157, 5)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "eqes4TJHeqes" })
			I[17] = new("ImageLabel", I[13], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131176354845909"), ImageTransparency = 0.72, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1.0000001, 0.9999999), TileSize = UDim2.fromScale(0.8, 2), Visible = false, ZIndex = -1 }, { ["_lemonadeUniqueId"] = "EFMd6bpfEFMd" })
			I[18] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(148, 148, 148), Thickness = 1.8796296 }, { ["_lemonadeUniqueId"] = "OUkAleKiOUkA", ["oldp_Thickness"] = 2.5 })
				I[19] = new("UIGradient", I[18], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 157, 5)) }) }, { ["_lemonadeUniqueId"] = "SY6kDt0gSY6k" })
			I[20] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) }, { ["_lemonadeUniqueId"] = "DZvXoN37DZvX" })
			I[21] = new("UISizeConstraint", I[13], "UISizeConstraint", { MaxSize = Vector2.new(math.huge, 100) }, { ["_lemonadeUniqueId"] = "OjQhNQQqOjQh" })
		I[22] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 2.5 }, { ["_lemonadeUniqueId"] = "mohA1OttmohA" })
	return I[1]
end

return build

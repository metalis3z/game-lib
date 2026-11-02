-- Generated from ui/ReplicatedStorage/ReplicatedGui/TradePrompts.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TradePrompts", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "DWXy0ijFDWXy" }, { "ScreenGui" })
		I[2] = new("ImageLabel", I[1], "Prompt", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(38, 0, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9944771, 0.985081), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.1698942, 0.1375656), SliceCenter = Rect.new(485, 14, 485, 75), Visible = false }, { ["_lemonadeUniqueId"] = "YdBpHvPFYdBp" })
			I[3] = new("TextLabel", I[2], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5008216, 0.1523008), Size = UDim2.fromScale(0.9183587, 0.2144083), Text = "Trade Request", TextColor3 = Color3.fromRGB(223, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "BTyVkrwEBTyV" })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "YNWYzOFXYNWY" }, { "ScreenStroke", "UIStroke" })
			I[5] = new("TextLabel", I[2], "Username", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.507, 0.45), Size = UDim2.fromScale(0.9297194, 0.3222941), Text = "Onlytwentycharacters wants to trade with you", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "FqPZxV2KFqPZ" })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "G6Vb4onNG6Vb" }, { "ScreenStroke", "UIStroke" })
			I[7] = new("ImageButton", I[2], "Yes", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(81, 158, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.04, 0.933), Size = UDim2.fromScale(0.4394761, 0.2736073) }, { ["_lemonadeUniqueId"] = "ZuiY5nBHZuiY" })
				I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 1.4013889 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "KcOikckQKcOi" }, { "ScreenStroke", "UIStroke" })
				I[9] = new("TextLabel", I[7], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "Accept", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "uni9sOQguni9" })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 1.4013889 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "LhUkK2p5LhUk" }, { "ScreenStroke", "UIStroke" })
			I[11] = new("ImageButton", I[2], "No", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(233, 66, 66), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.96, 0.933), Size = UDim2.fromScale(0.4394762, 0.2736073) }, { ["_lemonadeUniqueId"] = "jPF1Udr1jPF1" })
				I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 1.4013889 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "3JSBL64I3JSB" }, { "ScreenStroke", "UIStroke" })
				I[13] = new("TextLabel", I[11], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "Decline", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "dDgbmZlLdDgb" })
					I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 1.4013889 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "AlVkmEtVAlVk" }, { "ScreenStroke", "UIStroke" })
			I[15] = new("UIStroke", I[2], "UIStroke", { Thickness = 2 }, { ["OriginalThickness"] = 1, ["_lemonadeUniqueId"] = "ZUnf4xuYZUnf" }, { "ScreenStroke", "UIStroke" })
			I[16] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.5 }, { ["_lemonadeUniqueId"] = "YK6PlOD7YK6P" })
			I[17] = new("UICorner", I[2], "UICorner")
	return I[1]
end

return build

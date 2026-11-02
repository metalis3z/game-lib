-- Generated from ui/StarterGui/Inventory.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Inventory", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Background", { BackgroundColor3 = Color3.fromRGB(47, 47, 47), BackgroundTransparency = 0.5, Position = UDim2.fromScale(0.3275041, 0.2111111), Size = UDim2.fromScale(0.3983361, 0.5271605), Visible = false })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("Frame", I[2], "Front", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, Position = UDim2.fromScale(0.025, 0.025), Size = UDim2.fromScale(0.95, 0.95) })
				I[5] = new("UICorner", I[4], "UICorner")
				I[6] = new("TextLabel", I[4], "Title", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0131359, 0.0232943), Size = UDim2.fromScale(0.9737284, 0.1344703), Text = "WARNING: DONT PUT MONEY INSIDE OR IT WILL GET STUCK!", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 19, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[7] = new("UICorner", I[6], "UICorner")
					I[8] = new("UITextSizeConstraint", I[6], "UITextSizeConstraint", { MaxTextSize = 19 })
				I[9] = new("TextButton", I[4], "Close", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9478106, -0.068551), RichText = true, Size = UDim2.fromScale(0.1350293, 0.1263158), Text = "X", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
					I[10] = new("UICorner", I[9], "UICorner")
				I[11] = new("ScrollingFrame", I[4], "InvFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(0.5, 0.35), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.475, 0.6) })
				I[12] = new("ScrollingFrame", I[4], "BackpackFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(0.0249999, 0.3499999), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.419036, 0.6) })
				I[13] = new("TextLabel", I[4], "BackpackTitle", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0568555, 0.1975349), Size = UDim2.fromScale(0.3100901, 0.1), Text = "BACKPACK:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 24, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[14] = new("UICorner", I[13], "UICorner")
					I[15] = new("UITextSizeConstraint", I[13], "UITextSizeConstraint", { MaxTextSize = 24 })
				I[16] = new("TextLabel", I[4], "InvTitle", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5965954, 0.1975348), Size = UDim2.fromScale(0.4538645, 0.1), Text = "ITEMS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 24, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[17] = new("UICorner", I[16], "UICorner")
					I[18] = new("UITextSizeConstraint", I[16], "UITextSizeConstraint", { MaxTextSize = 24 })
				I[19] = new("TextButton", I[4], "Item", { BackgroundColor3 = Color3.fromRGB(45, 45, 45), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0), Size = UDim2.fromScale(0.25, 0.125), Text = "Item", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextStrokeTransparency = 0 })
					I[20] = new("UICorner", I[19], "UICorner")
				I[21] = new("Sound", I[4], "Sound", { Volume = 3 })
			I[22] = new("UIStroke", I[2], "UIStroke", { Thickness = 1.6, Transparency = 0.25 })
			I[23] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.1213117 })
		I[24] = new("ObjectValue", I[1], "SafeModel")
	return I[1]
end

return build

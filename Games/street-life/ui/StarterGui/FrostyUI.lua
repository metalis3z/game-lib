-- Generated from ui/StarterGui/FrostyUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "FrostyUI", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0886288, 0.6737589), Size = UDim2.fromScale(0.1491639, 0.249409) })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
			I[5] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0493274, 0), Size = UDim2.fromScale(0.8968609, 0.1706161), Text = "CUSTOMER:", TextColor3 = Color3.fromRGB(0, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[6] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0493274, 0.492891), Size = UDim2.fromScale(0.8968609, 0.1706161), Text = "YOU:", TextColor3 = Color3.fromRGB(0, 170, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[7] = new("Frame", I[2], "Line", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9999999, 0.0171339) })
			I[8] = new("Frame", I[2], "Customer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4977578, 0.3222747), Size = UDim2.fromScale(0.8968609, 0.2398835), Visible = false })
				I[9] = new("UICorner", I[8], "UICorner")
			I[10] = new("Frame", I[2], "You", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4977578, 0.8151658), Size = UDim2.fromScale(0.8968609, 0.2398835), Visible = false })
				I[11] = new("UICorner", I[10], "UICorner")
			I[12] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0493274, -0.1990521), Size = UDim2.fromScale(0.8968609, 0.1706161), Text = "FROSTY  FLIPS", TextColor3 = Color3.fromRGB(255, 0, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[13] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0493274, 1.0284361), Size = UDim2.fromScale(0.8968609, 0.1658768), Text = "Get your customer the right frost color!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
		I[14] = new("Sound", I[1], "Sound", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 1 })
	return I[1]
end

return build

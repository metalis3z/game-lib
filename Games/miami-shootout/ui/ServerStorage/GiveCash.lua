-- Generated from ui/ServerStorage/GiveCash.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GiveCash", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextButton", I[1], "OpenClose", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.65, FontFace = Font.new("rbxasset://fonts/families/DenkOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0220859, 0.4209594), Size = UDim2.fromScale(0.0436474, 0.0630731), Text = "PayCash", TextColor3 = Color3.fromRGB(238, 238, 238), TextScaled = true, TextSize = 25, TextWrapped = true })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("UITextSizeConstraint", I[2], "UITextSizeConstraint", { MaxTextSize = 11 })
		I[5] = new("Frame", I[1], "MoneyFrame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, Position = UDim2.fromScale(0.3877737, 0.2239859), Size = UDim2.fromScale(0.2244526, 0.5485009), Visible = false })
			I[6] = new("UICorner", I[5], "UICorner")
			I[7] = new("TextLabel", I[5], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Fondamento.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1318328), Text = "Slide Bread", TextColor3 = Color3.fromRGB(255, 218, 10), TextScaled = true, TextSize = 41, TextWrapped = true })
				I[8] = new("UITextSizeConstraint", I[7], "UITextSizeConstraint", { MaxTextSize = 41 })
			I[9] = new("TextBox", I[5], "Username", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.35, FontFace = Font.new("rbxasset://fonts/families/Fondamento.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(255, 255, 255), PlaceholderText = "Player Username", Position = UDim2.fromScale(0.0460098, 0.2266881), Size = UDim2.fromScale(0.9065039, 0.088746), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 27, TextWrapped = true })
				I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 27 })
			I[12] = new("TextBox", I[5], "Amount", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.35, FontFace = Font.new("rbxasset://fonts/families/Fondamento.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(255, 255, 255), PlaceholderText = "Amount", Position = UDim2.fromScale(0.0460098, 0.4363343), Size = UDim2.fromScale(0.9065037, 0.088746), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[14] = new("UITextSizeConstraint", I[12], "UITextSizeConstraint", { MaxTextSize = 39 })
			I[15] = new("TextButton", I[5], "Submit", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.35, FontFace = Font.new("rbxasset://fonts/families/Fondamento.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1970179, 0.8411576), Size = UDim2.fromScale(0.5944614, 0.0909968), Text = "Give", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 36, TextWrapped = true })
				I[16] = new("UICorner", I[15], "UICorner")
				I[17] = new("Sound", I[15], "Error")
				I[18] = new("Sound", I[15], "ching")
				I[19] = new("UITextSizeConstraint", I[15], "UITextSizeConstraint", { MaxTextSize = 36 })
			I[20] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.8, Transparency = 0.25 })
			I[21] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 0.5870408 })
			I[22] = new("TextLabel", I[5], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1188587, 0.1125402), Size = UDim2.fromScale(0.7507801, 0.0845659), Text = "TYPE THERE USERNAME EXATLY HOW IT IS.", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 41, TextWrapped = true })
				I[23] = new("UITextSizeConstraint", I[22], "UITextSizeConstraint", { MaxTextSize = 41 })
		I[24] = new("TextLabel", I[1], "Info", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.8677249), Size = UDim2.fromScale(1, 0.1322751), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 33, TextWrapped = true })
			I[25] = new("Sound", I[24], "ching")
	return I[1]
end

return build

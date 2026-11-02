-- Generated from ui/ServerScriptService/Gang Handler/Zone.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Zone", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(42, 53, 53), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.875, 0.5), Size = UDim2.fromScale(0.2365309, 0.248139) })
			I[3] = new("TextLabel", I[2], "Top", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 65, 66), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.1399666), Size = UDim2.fromScale(0.9666666, 0.2183947), Text = " Zone: North", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[4] = new("UICorner", I[3], "UICorner")
				I[5] = new("UITextSizeConstraint", I[3], "UITextSizeConstraint", { MaxTextSize = 35 })
				I[6] = new("UIStroke", I[3], "UIStroke")
			I[7] = new("UICorner", I[2], "UICorner")
			I[8] = new("TextLabel", I[2], "Bottom", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 65, 66), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.6217848), Size = UDim2.fromScale(0.9666666, 0.6638494), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
				I[9] = new("UITextSizeConstraint", I[8], "UITextSizeConstraint", { MaxTextSize = 20 })
				I[10] = new("UICorner", I[8], "UICorner")
				I[11] = new("TextLabel", I[8], "Actual", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 65, 66), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4996433, 0.3727738), RichText = true, Size = UDim2.fromScale(0.9673806, 0.6725127), Text = "This zone is controlled by OGZ and by controlling zones you can claim rewards", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
					I[12] = new("UITextSizeConstraint", I[11], "UITextSizeConstraint", { MaxTextSize = 22 })
					I[13] = new("UICorner", I[11], "UICorner")
			I[14] = new("TextButton", I[2], "Claim", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(33, 150, 243), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4999999, 0.8408182), Size = UDim2.fromScale(0.9080462, 0.1605377), Text = "TAKE OVER ZONE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0, 3), BottomRightRadius = UDim.new(0, 3), TopLeftRadius = UDim.new(0, 3), TopRightRadius = UDim.new(0, 3) })
				I[16] = new("UITextSizeConstraint", I[14], "UITextSizeConstraint", { MaxTextSize = 30 })
			I[17] = new("ObjectValue", I[2], "Object")
			I[18] = new("TextButton", I[2], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(243, 243, 243), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9410441, 0.1070819), Size = UDim2.fromScale(0.0845784, 0.1541638), Text = "X", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[19] = new("UICorner", I[18], "UICorner")
				I[20] = new("UIStroke", I[18], "UIStroke", { Thickness = 2 })
	return I[1]
end

return build

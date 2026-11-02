-- Generated from ui/StarterGui/BankRobbery.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BankRobbery", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8904732, 0.6511166), Size = UDim2.fromScale(0.2013828, 0.0558313), Text = "90 SECONDS LEFT", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 2 })
		I[4] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.8904731, 0.8362283), Size = UDim2.fromScale(0.2013828, 0.2979032), Visible = false })
			I[5] = new("UICorner", I[4], "UICorner")
			I[6] = new("TextLabel", I[4], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1874141), Text = "Bank Robbery", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 2 })
			I[8] = new("TextButton", I[4], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 170, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.85), Size = UDim2.fromScale(0.7434019, 0.1913498), Text = "Get Extra Space", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[9] = new("UICorner", I[8], "UICorner")
				I[10] = new("UIStroke", I[8], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[11] = new("UIStroke", I[8], "UIStroke", { Thickness = 2 })
			I[12] = new("UIStroke", I[4], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
			I[13] = new("Frame", I[4], "Filler", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4999999, 0.6136132), Size = UDim2.fromScale(0.7420387, 0.1687957) })
				I[14] = new("UICorner", I[13], "UICorner")
				I[15] = new("UIStroke", I[13], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[16] = new("Frame", I[13], "Inside", { BackgroundColor3 = Color3.fromRGB(0, 85, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0, 1.0000001), Visible = false })
					I[17] = new("UICorner", I[16], "UICorner")
					I[18] = new("UIStroke", I[16], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[19] = new("TextLabel", I[13], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.0000015), Size = UDim2.fromScale(1, 0.9999977), Text = "0/5", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 2 })
					I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 2 })
			I[21] = new("TextLabel", I[4], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0193091, 0.2373912), Size = UDim2.fromScale(0.9613817, 0.2082379), Text = "Collect as much loot as you can!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 2 })
				I[23] = new("UITextSizeConstraint", I[21], "UITextSizeConstraint", { MaxTextSize = 35 })
	return I[1]
end

return build

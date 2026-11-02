-- Generated from ui/ServerScriptService/Environment/GameManager/CashWheelCore/CashWheel.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CashWheel", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ObjectValue", I[1], "ActualTable")
		I[3] = new("Frame", I[1], "Backing", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.3351762, 0.2630923) })
			I[4] = new("TextLabel", I[3], "Winnings", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.2), Text = "", TextColor3 = Color3.fromRGB(0, 255, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
			I[5] = new("Frame", I[3], "Cooldown", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
				I[6] = new("TextLabel", I[5], "Hint", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.283241), Size = UDim2.fromScale(1.0000001, 0.4474523), Text = "You can only spin the cash wheel once every 4 hours (or every 1 hour if you're a gold club member).", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
				I[7] = new("TextLabel", I[5], "TimeLeft", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.7512436), RichText = true, Size = UDim2.fromScale(1.0000001, 0.3653466), Text = "You have <b><font color=\"rgb(255,125,0)\">12,345</font></b> minutes before you can spin the wheel again.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
			I[8] = new("Frame", I[3], "Barrier", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
				I[9] = new("TextLabel", I[8], "Hint", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0000001, 0.5003446), Size = UDim2.fromScale(1.0000001, 0.9993101), Text = "Waiting for round to finish...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
			I[10] = new("ImageButton", I[3], "Camera", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13085201731"), Position = UDim2.fromScale(-0.171, 0.224), Size = UDim2.fromScale(0.0973492, 0.2369668) })
				I[11] = new("TextLabel", I[10], "Keybind", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "C", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[12] = new("TextLabel", I[3], "CameraTip", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.04, 0), Size = UDim2.fromScale(0.2652858, 0.1601942), Text = "Camera:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[13] = new("TextLabel", I[3], "CameraTip2", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.009, 0.602), Size = UDim2.fromScale(0.3222673, 0.3983727), Text = "Switch between wheel and character cameras.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
	return I[1]
end

return build

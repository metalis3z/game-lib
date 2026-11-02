-- Generated from ui/Lighting/Assets/GUI/SendMoneyConfirm.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SendMoneyConfirm", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("StringValue", I[1], "SendingName")
		I[3] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(98, 98, 98), BackgroundTransparency = 0.45, Position = UDim2.fromScale(0.3493254, 0.3478803), Size = UDim2.fromScale(0.3013493, 0.3029925) })
			I[4] = new("UICorner", I[3], "UICorner")
			I[5] = new("TextLabel", I[3], "topText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2512438, 0), Size = UDim2.fromScale(0.4975125, 0.2057613), Text = "CONFIRM", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 50 })
			I[7] = new("TextLabel", I[3], "mainText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0522388, 0.3127572), Size = UDim2.fromScale(0.8955225, 0.3703704), Text = "Are you sure you want to send XYZ $1000?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("UITextSizeConstraint", I[7], "UITextSizeConstraint", { MaxTextSize = 90 })
			I[9] = new("TextButton", I[3], "Yes", { BackgroundColor3 = Color3.fromRGB(0, 170, 0), FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0273632, 0.7242798), Size = UDim2.fromScale(0.4577115, 0.1893004), Text = "YES", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[10] = new("UICorner", I[9], "UICorner")
				I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 46 })
			I[12] = new("TextButton", I[3], "No", { BackgroundColor3 = Color3.fromRGB(170, 0, 0), FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Modal = true, Position = UDim2.fromScale(0.5174129, 0.728395), Size = UDim2.fromScale(0.4577115, 0.1893004), Text = "NO", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[13] = new("UICorner", I[12], "UICorner")
				I[14] = new("UITextSizeConstraint", I[12], "UITextSizeConstraint", { MaxTextSize = 46 })
		I[15] = new("NumberValue", I[1], "Amount")
		I[16] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.6633416 })
	return I[1]
end

return build

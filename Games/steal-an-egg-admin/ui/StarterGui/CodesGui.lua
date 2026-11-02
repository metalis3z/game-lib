-- Generated from ui/StarterGui/CodesGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CodesGui", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "f9VsDqymf9Vs" })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3850299, 0.3352273), Size = UDim2.fromOffset(384, 394), Visible = false }, { ["_lemonadeUniqueId"] = "BqZ2e0JFBqZ2" })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) }, { ["_lemonadeUniqueId"] = "iRTmjDN5iRTm" })
			I[4] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "q12qfX6aq12q" })
			I[5] = new("UIStroke", I[2], "UIStroke", nil, { ["_lemonadeUniqueId"] = "H3BQIAlRH3BQ" })
			I[6] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(166, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 206, 255)) }) }, { ["_lemonadeUniqueId"] = "chkMbFpTchkM" })
			I[7] = new("TextLabel", I[2], "txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5234376, 0.0980511), Size = UDim2.fromScale(0.4354167, 0.2044356), Text = "Codes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 10, TextWrapped = true }, { ["_lemonadeUniqueId"] = "S8NLbeltS8NL" })
				I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 3 }, { ["_lemonadeUniqueId"] = "KF9oCNgUKF9o" })
			I[9] = new("TextBox", I[2], "codesbar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2630208, 0.3359375), Size = UDim2.fromOffset(200, 59), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 30 }, { ["_lemonadeUniqueId"] = "e7qlfcAUe7ql" })
				I[10] = new("UICorner", I[9], "UICorner", nil, { ["_lemonadeUniqueId"] = "JL0dKefVJL0d" })
			I[11] = new("TextButton", I[2], "redeemBTN", { BackgroundColor3 = Color3.fromRGB(34, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2630208, 0.53125), Size = UDim2.fromOffset(200, 50), Text = "Redeem", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 50, TextStrokeColor3 = Color3.fromRGB(255, 255, 255) }, { ["_lemonadeUniqueId"] = "gzGcrHkKgzGc" })
				I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 30)) }) }, { ["_lemonadeUniqueId"] = "wBpRTnJlwBpR" })
				I[13] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) }, { ["_lemonadeUniqueId"] = "U3u6ImjZU3u6" })
			I[14] = new("TextLabel", I[2], "xd", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5221354, 0.8091621), Size = UDim2.fromScale(0.7921877, 0.2672824), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 10, TextWrapped = true }, { ["_lemonadeUniqueId"] = "TeXBvXfRTeXB" })
				I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 3 }, { ["_lemonadeUniqueId"] = "MIWn8ukiMIWn" })
			I[16] = new("TextLabel", I[2], "secretcode", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.521354, 0.2535647), Size = UDim2.fromScale(0.6395835, 0.1066406), Text = "(secret code: WELCOME)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 10, TextWrapped = true }, { ["_lemonadeUniqueId"] = "Kf6lQZJLKf6l" })
				I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 3 }, { ["_lemonadeUniqueId"] = "s5BC4PfVs5BC" })
			I[18] = new("TextButton", I[2], "CloseBTN", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9348958, -0.0208333), Size = UDim2.fromOffset(38, 40), Text = "X", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 50 }, { ["_lemonadeUniqueId"] = "vbH7I9AWvbH7" })
				I[19] = new("UICorner", I[18], "UICorner", nil, { ["_lemonadeUniqueId"] = "doS3aoDHdoS3" })
				I[20] = new("UIGradient", I[18], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }) }, { ["_lemonadeUniqueId"] = "gPyVJkpjgPyV" })
	return I[1]
end

return build

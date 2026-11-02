-- Generated from ui/StarterGui/TutorialInstructions.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TutorialInstructions", { DisplayOrder = 900, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "rtJgsFbvrtJg" })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.12), Size = UDim2.fromScale(0.8000001, 0.0697718) }, { ["_lemonadeUniqueId"] = "Sh5oktseSh5o" })
			I[3] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Get to 200 Speed", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "uwkElxntuwkE" })
				I[4] = new("UIStroke", I[3], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 }, { ["_lemonadeUniqueId"] = "7Uwt3hlb7Uwt" })
				I[5] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(64, 245, 233)), ColorSequenceKeypoint.new(0.4550173, Color3.fromRGB(64, 236, 235)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 144, 255)) }), Enabled = false, Rotation = 90 }, { ["_lemonadeUniqueId"] = "wRm2Wwz5wRm2" })
			I[6] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 22.1153908 }, { ["_lemonadeUniqueId"] = "HBAywdM6HBAy" })
			I[7] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = -1 }, { ["_lemonadeUniqueId"] = "L8HrbNUIL8Hr" })
				I[8] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 1), NumberSequenceKeypoint.new(0.298, 0.95), NumberSequenceKeypoint.new(0.5012469, 0.7), NumberSequenceKeypoint.new(0.7, 0.95), NumberSequenceKeypoint.new(0.85, 1), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "RwXDTqy2RwXD" })
			I[9] = new("CanvasGroup", I[2], "Progression", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1.4), Size = UDim2.fromScale(0.3755763, 0.8099741), Visible = false, ZIndex = -1 }, { ["_lemonadeUniqueId"] = "8wpVLFOU8wpV" })
				I[10] = new("UICorner", I[9], "UICorner", nil, { ["_lemonadeUniqueId"] = "OPfNuwU8OPfN" })
				I[11] = new("UIStroke", I[9], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 }, { ["_lemonadeUniqueId"] = "pPRN5M77pPRN" })
				I[12] = new("Frame", I[9], "Fill", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(26, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.3144889, 1) }, { ["_lemonadeUniqueId"] = "dP1zN8hndP1z" })
				I[13] = new("TextLabel", I[9], "ReadyLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.9), Text = "READY!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["_lemonadeUniqueId"] = "ir2O676Uir2O" })
					I[14] = new("UIGradient", I[13], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(114, 255, 123)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 64)) }), Rotation = 100 }, { ["_lemonadeUniqueId"] = "PImt4R5lPImt" })
					I[15] = new("UIStroke", I[13], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 }, { ["_lemonadeUniqueId"] = "0zh2WF9v0zh2" })
					I[16] = new("TextLabel", I[13], "ReadyLabelWhite", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "READY!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true }, { ["_lemonadeUniqueId"] = "2jdjbm7t2jdj" })
				I[17] = new("TextLabel", I[9], "Progress", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "READY!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true }, { ["_lemonadeUniqueId"] = "TGi0BAX3TGi0" })
	return I[1]
end

return build

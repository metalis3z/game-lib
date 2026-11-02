-- Generated from ui/StarterGui/SecretGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SecretGui", { Enabled = false, ResetOnSpawn = false })
		I[2] = new("TextButton", I[1], "TextButton", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(149, 149, 149), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), FontFace = Font.new("rbxasset://fonts/families/RomanAntique.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0121043, 0.5034783), Size = UDim2.fromScale(0.0479867, 0.0809615), Text = "?", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 54, TextStrokeTransparency = 0 })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.0107924 })
		I[4] = new("ScrollingFrame", I[1], "Frame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(149, 149, 149), CanvasSize = UDim2.fromScale(0, 1), Position = UDim2.fromScale(0.5, 0.498), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.477, 0.497), Visible = false })
			I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 1.6370608 })
			I[6] = new("TextButton", I[4], "ShadowHour", { AnchorPoint = Vector2.new(0.5, 0.8), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(209, 209, 209), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2019296, 0.3588742), Size = UDim2.fromScale(0.3213442, 0.1334172), Text = "TRIGGER: SHADOW HOUR", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true })
				I[7] = new("RemoteEvent", I[6], "RemoteEvent")
				I[8] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectRatio = 3.9429691 })
			I[9] = new("TextButton", I[4], "NightmareHour", { AnchorPoint = Vector2.new(0.5, 0.8), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(209, 209, 209), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2019296, 0.2596111), Size = UDim2.fromScale(0.3213442, 0.1334172), Text = "TRIGGER: NIGHTMARE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextStrokeColor3 = Color3.fromRGB(179, 179, 179), TextWrapped = true })
				I[10] = new("RemoteEvent", I[9], "RemoteEvent")
				I[11] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", { AspectRatio = 3.9429691 })
			I[12] = new("TextButton", I[4], "HealRakeInstant", { AnchorPoint = Vector2.new(0.5, 0.8), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(209, 209, 209), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5786633, 0.1656861), Size = UDim2.fromScale(0.3213442, 0.1334172), Text = "ACTION: HEAL RAKE INSTANTLY", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextWrapped = true })
				I[13] = new("RemoteEvent", I[12], "RemoteEvent")
				I[14] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint", { AspectRatio = 3.9429691 })
			I[15] = new("TextButton", I[4], "RestorePower", { AnchorPoint = Vector2.new(0.5, 0.8), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(209, 209, 209), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5786633, 0.3574759), Size = UDim2.fromScale(0.3213442, 0.1334172), Text = "ON|OFF POWER", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextWrapped = true })
				I[16] = new("RemoteEvent", I[15], "RemoteEvent")
				I[17] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint", { AspectRatio = 3.9429691 })
			I[18] = new("TextButton", I[4], "VrModeButton", { AnchorPoint = Vector2.new(0.5, 0.8), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(209, 209, 209), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.5786099, 1.43475), Size = UDim2.fromScale(0.2611361, 0.1846143), Text = "CloVR", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextWrapped = true })
				I[19] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint", { AspectRatio = 2.5103459 })
			I[20] = new("TextButton", I[4], "BloodHour", { AnchorPoint = Vector2.new(0.5, 0.8), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(209, 209, 209), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2019296, 0.1656862), Size = UDim2.fromScale(0.3213442, 0.1334172), Text = "TRIGGER: BLOOD HOUR", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextWrapped = true })
				I[21] = new("RemoteEvent", I[20], "RemoteEvent")
				I[22] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint", { AspectRatio = 3.9429691 })
			I[23] = new("TextButton", I[4], "KillRakeInstant", { AnchorPoint = Vector2.new(0.5, 0.8), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(209, 209, 209), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5786633, 0.2582128), Size = UDim2.fromScale(0.3213442, 0.1334172), Text = "ACTION: KILL RAKE INSTANTLY", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextWrapped = true })
				I[24] = new("RemoteEvent", I[23], "RemoteEvent")
				I[25] = new("UIAspectRatioConstraint", I[23], "UIAspectRatioConstraint", { AspectRatio = 3.9429691 })
			I[26] = new("TextButton", I[4], "MikeHour", { AnchorPoint = Vector2.new(0.5, 0.8), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(209, 209, 209), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2041527, 0.4521738), Size = UDim2.fromScale(0.3213442, 0.1334172), Text = "TRIGGER: MIKE HOUR", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextStrokeColor3 = Color3.fromRGB(255, 0, 0), TextWrapped = true })
				I[27] = new("RemoteEvent", I[26], "RemoteEvent")
				I[28] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint", { AspectRatio = 3.9429691 })
			I[29] = new("TextButton", I[4], "SeerHour", { AnchorPoint = Vector2.new(0.5, 0.8), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(209, 209, 209), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5786633, 0.4583282), Size = UDim2.fromScale(0.3213442, 0.1334172), Text = "TRIGGER: SEER HOUR", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextStrokeColor3 = Color3.fromRGB(85, 0, 255), TextWrapped = true })
				I[30] = new("RemoteEvent", I[29], "RemoteEvent")
				I[31] = new("UIAspectRatioConstraint", I[29], "UIAspectRatioConstraint", { AspectRatio = 3.9429691 })
		I[32] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.2), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(149, 149, 149), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4996156, 0.2619612), Size = UDim2.fromScale(0.465458, 0.0589484), Text = "Developer's Gui", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(36, 0, 0), TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
			I[33] = new("UIAspectRatioConstraint", I[32], "UIAspectRatioConstraint", { AspectRatio = 11.5538321 })
	return I[1]
end

return build

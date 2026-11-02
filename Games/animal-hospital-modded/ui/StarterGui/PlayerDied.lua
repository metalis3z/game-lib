-- Generated from ui/StarterGui/PlayerDied.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "PlayerDied", { DisplayOrder = 2, ResetOnSpawn = false, SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
			I[4] = new("Frame", I[2], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1000, Position = UDim2.fromScale(0.509009, 0.325), Size = UDim2.fromScale(0.7, 0.2) })
				I[5] = new("TextLabel", I[4], "title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4983914, 0.3014813), Size = UDim2.fromScale(1.4286761, 0.3571691), Text = "YOU DIED", TextColor3 = Color3.fromRGB(255, 26, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[6] = new("UIStroke", I[5], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
				I[7] = new("TextLabel", I[4], "desc", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.497547, 0.6722937), Size = UDim2.fromScale(1.1687247, 0.2231315), Text = "Your sanity got depleted and went mad", TextColor3 = Color3.fromRGB(253, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[8] = new("UIStroke", I[7], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
			I[9] = new("TextButton", I[2], "reviveall", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(219, 74, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.7775228), RichText = true, Size = UDim2.fromScale(0.3547297, 0.0878378), Text = "", TextColor3 = Color3.fromRGB(255, 198, 55), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 1000 })
				I[10] = new("TextLabel", I[9], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(0.9, 0.9), Text = "Revive Everyone", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1001 })
					I[11] = new("UIStroke", I[10], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
				I[12] = new("UIStroke", I[9], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[13] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(249, 253, 255)), ColorSequenceKeypoint.new(0.5766667, Color3.fromRGB(251, 252, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 19)) }), Offset = Vector2.new(0, 0.1), Rotation = 90 })
			I[14] = new("TextButton", I[2], "playagain", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(45, 210, 11), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.651464), RichText = true, Size = UDim2.fromScale(0.3468468, 0.0867117), Text = "", TextColor3 = Color3.fromRGB(255, 198, 55), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 1000 })
				I[15] = new("TextLabel", I[14], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4499978), Size = UDim2.fromScale(0.9, 0.8999996), Text = "Play Again (0/1)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1001 })
					I[16] = new("UIStroke", I[15], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
				I[17] = new("UIStroke", I[14], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[18] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(249, 253, 255)), ColorSequenceKeypoint.new(0.5766667, Color3.fromRGB(251, 252, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 19)) }), Offset = Vector2.new(0, 0.1), Rotation = 90 })
			I[19] = new("TextButton", I[2], "selfrevive", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(219, 74, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.778), RichText = true, Size = UDim2.fromScale(0.3547297, 0.0878378), Text = "", TextColor3 = Color3.fromRGB(255, 198, 55), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 100 })
				I[20] = new("TextLabel", I[19], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(0.9, 0.9), Text = "Self Revive", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1001 })
					I[21] = new("UIStroke", I[20], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
				I[22] = new("UIStroke", I[19], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[23] = new("UIGradient", I[19], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(249, 253, 255)), ColorSequenceKeypoint.new(0.5766667, Color3.fromRGB(251, 252, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 19)) }), Offset = Vector2.new(0, 0.1), Rotation = 90 })
			I[24] = new("TextLabel", I[2], "counter", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5174549), Size = UDim2.fromScale(0.4106585, 0.0778899), Text = "Returning in 30", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
				I[25] = new("UIStroke", I[24], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
			I[26] = new("TextButton", I[2], "modal", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 232, 93), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Interactable = false, LayoutOrder = 99, Modal = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
		I[27] = new("Frame", I[1], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.33, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = -5555 })
	return I[1]
end

return build

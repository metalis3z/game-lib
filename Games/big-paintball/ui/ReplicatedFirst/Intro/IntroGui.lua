-- Generated from ui/ReplicatedFirst/Intro/IntroGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "IntroGui", { DisplayOrder = 999, ResetOnSpawn = false })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.5, 1.5) })
			I[3] = new("ImageLabel", I[2], "Logo", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://10567478228"), Position = UDim2.fromScale(0.4997277, 0.4994726), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(0.1377778, 45, 0.1870042, 45) })
			I[4] = new("TextLabel", I[2], "Desc", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.81), Size = UDim2.new(0.4, 0, 0.015, 5), Text = "Loading Assets", TextColor3 = Color3.fromRGB(253, 158, 66), TextScaled = true, TextSize = 18, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, Visible = false })
			I[5] = new("Frame", I[2], "Dots", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0.8, -5), Size = UDim2.new(0.11, 35, 0.015, 5) })
				I[6] = new("Frame", I[5], "2", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(231, 231, 231), BorderSizePixel = 0, Position = UDim2.fromScale(0.33, 0), Size = UDim2.fromScale(1, 1) })
					I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
					I[8] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
				I[9] = new("Frame", I[5], "3", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(231, 231, 231), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 1) })
					I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
					I[11] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint")
				I[12] = new("Frame", I[5], "4", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(231, 231, 231), BorderSizePixel = 0, Position = UDim2.fromScale(0.66, 0), Size = UDim2.fromScale(1, 1) })
					I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
					I[14] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint")
				I[15] = new("Frame", I[5], "5", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(231, 231, 231), BorderSizePixel = 0, Position = UDim2.fromScale(0.83, 0), Size = UDim2.fromScale(1, 1) })
					I[16] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
					I[17] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint")
				I[18] = new("Frame", I[5], "1", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(231, 231, 231), BorderSizePixel = 0, Position = UDim2.fromScale(0.16, 0), Size = UDim2.fromScale(1, 1) })
					I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
					I[20] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint")
			I[21] = new("Frame", I[2], "Notice", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(253, 158, 66), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.2, 75, 0.2, 75), Visible = false })
				I[22] = new("UIAspectRatioConstraint", I[21], "UIAspectRatioConstraint", { AspectRatio = 1.5 })
				I[23] = new("Frame", I[21], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -6, 1, -6) })
					I[24] = new("TextLabel", I[23], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.15), Text = "Banned", TextColor3 = Color3.fromRGB(253, 158, 66), TextScaled = true, TextSize = 18, TextWrapped = true })
					I[25] = new("TextLabel", I[23], "Desc", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.15), Size = UDim2.fromScale(1, 0.675), Text = "You've been banned from playing on this account. If you believe this was an accident, appeal on our Discord.", TextColor3 = Color3.fromRGB(253, 158, 66), TextScaled = true, TextSize = 18, TextWrapped = true })
						I[26] = new("UITextSizeConstraint", I[25], "UITextSizeConstraint", { MaxTextSize = 40 })
					I[27] = new("TextLabel", I[23], "TimeLeft", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.98), Size = UDim2.fromScale(0.8, 0.1), Text = "Time Left: Forever", TextColor3 = Color3.fromRGB(253, 253, 253), TextScaled = true, TextSize = 18, TextWrapped = true, Visible = false, ZIndex = 2 })
						I[28] = new("Frame", I[27], "Frame", { BackgroundColor3 = Color3.fromRGB(253, 158, 66), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
							I[29] = new("UICorner", I[28], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[30] = new("TextButton", I[23], "Button", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(253, 158, 66), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.975), Size = UDim2.fromScale(0.5, 0.15), Text = "Ok", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true })
						I[31] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
					I[32] = new("UICorner", I[23], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
				I[33] = new("UICorner", I[21], "UICorner", { BottomLeftRadius = UDim.new(0.1, 3), BottomRightRadius = UDim.new(0.1, 3), TopLeftRadius = UDim.new(0.1, 3), TopRightRadius = UDim.new(0.1, 3) })
			I[34] = new("Frame", I[2], "Fade", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 10 })
				I[35] = new("UIGradient", I[34], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.7887486, 0), NumberSequenceKeypoint.new(0.8863375, 0.21875), NumberSequenceKeypoint.new(0.9540758, 0.50625), NumberSequenceKeypoint.new(1, 1) }) })
			I[36] = new("TextButton", I[2], "Skip", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(253, 169, 33), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.825), Size = UDim2.new(0.095, 15, 0.035, 15), Text = "Skip", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, Visible = false })
				I[37] = new("UICorner", I[36], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
	return I[1]
end

return build

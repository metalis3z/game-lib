-- Generated from ui/ReplicatedFirst/Loading/Loading.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Loading", { DisplayOrder = 2, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Sound", I[1], "Music", { Looped = true, Volume = 0.8 })
			I[3] = new("EqualizerSoundEffect", I[2], "Equalizer", { HighGain = -10, LowGain = 10 })
		I[4] = new("Sound", I[1], "Click", { Volume = 0.6 })
		I[5] = new("Frame", I[1], "Loading", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(47, 47, 47), ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2500 })
			I[6] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(52, 52, 52)), ColorSequenceKeypoint.new(0.750416, Color3.fromRGB(76, 76, 76)), ColorSequenceKeypoint.new(1, Color3.fromRGB(97, 97, 97)) }), Enabled = false, Rotation = 45 })
			I[7] = new("Frame", I[5], "Dots", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.025, 0.025), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[8] = new("UIListLayout", I[7], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.75, 0), VerticalAlignment = Enum.VerticalAlignment.Center })
				I[9] = new("Frame", I[7], "0", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[10] = new("ImageLabel", I[9], "Dot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7179506030"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2500 })
				I[11] = new("Frame", I[7], "1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[12] = new("ImageLabel", I[11], "Dot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7179506030"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2500 })
				I[13] = new("Frame", I[7], "2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[14] = new("ImageLabel", I[13], "Dot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7179506030"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2500 })
				I[15] = new("Frame", I[7], "3", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[16] = new("ImageLabel", I[15], "Dot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7179506030"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2500 })
				I[17] = new("Frame", I[7], "4", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[18] = new("ImageLabel", I[17], "Dot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7179506030"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2500 })
			I[19] = new("ImageLabel", I[5], "Prog", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=7988748257"), Position = UDim2.fromScale(0.5, 0.96), Size = UDim2.fromScale(0.8, 0.005), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 2501 })
				I[20] = new("UIGradient", I[19], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(96, 200, 255)), ColorSequenceKeypoint.new(0.0183028, Color3.fromRGB(47, 47, 47)), ColorSequenceKeypoint.new(1, Color3.fromRGB(47, 47, 47)) }) })
				I[21] = new("TextLabel", I[19], "Status", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.35), Size = UDim2.fromScale(0.8, 3), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.9, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2505 })
			I[22] = new("ImageLabel", I[5], "Logo", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=8106837785"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.28, 0.095), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2506 })
		I[23] = new("Frame", I[1], "Menu", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.fromScale(-1.5, 0.5), Size = UDim2.fromScale(1, 1.1), ZIndex = 100 })
			I[24] = new("Frame", I[23], "Main", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.48), Size = UDim2.fromScale(0.16, 0.2), ZIndex = 101 })
				I[25] = new("ImageButton", I[24], "Jobs", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 160, 52), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5381546552"), Position = UDim2.fromScale(0.5, 0.44), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.85, 0.26), SliceCenter = Rect.new(250, 250, 250, 250), ZIndex = 50 })
					I[26] = new("TextLabel", I[25], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.2), Size = UDim2.fromScale(0.7, 0.6), Text = "Jobs", TextColor3 = Color3.fromRGB(4, 83, 31), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 51 })
					I[27] = new("ImageLabel", I[25], "Grad", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 170, 0), ImageContent = Content.fromUri("rbxassetid://4859963910"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0, 0.7), ZIndex = 49 })
					I[28] = new("ImageLabel", I[25], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(141, 199, 146), ImageContent = Content.fromUri("rbxassetid://2743800562"), Position = UDim2.fromScale(0.04, 0.15), Size = UDim2.fromScale(0.16, 0.7), ZIndex = 51 })
				I[29] = new("ImageButton", I[24], "Play", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(37, 171, 246), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5381546552"), Position = UDim2.fromScale(0.5, 0.15), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.94, 0.29), SliceCenter = Rect.new(250, 250, 250, 250), ZIndex = 50 })
					I[30] = new("TextLabel", I[29], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.2), Size = UDim2.fromScale(0.7, 0.6), Text = "Play", TextColor3 = Color3.fromRGB(20, 92, 133), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 51 })
					I[31] = new("ImageLabel", I[29], "Grad", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 170, 0), ImageContent = Content.fromUri("rbxassetid://4859963910"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0, 0.7), ZIndex = 49 })
					I[32] = new("ImageLabel", I[29], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(201, 241, 255), ImageContent = Content.fromUri("rbxassetid://2743802061"), Position = UDim2.fromScale(0.03, 0.06), Size = UDim2.fromScale(0.17, 0.8), ZIndex = 51 })
				I[33] = new("ImageButton", I[24], "Shop", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(235, 187, 12), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5381546552"), Position = UDim2.fromScale(0.5, 0.71), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.85, 0.26), SliceCenter = Rect.new(250, 250, 250, 250), ZIndex = 50 })
					I[34] = new("TextLabel", I[33], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.2), Size = UDim2.fromScale(0.7, 0.6), Text = "Shop", TextColor3 = Color3.fromRGB(128, 102, 7), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 51 })
					I[35] = new("ImageLabel", I[33], "Grad", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 170, 0), ImageContent = Content.fromUri("rbxassetid://4859963910"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0, 0.7), ZIndex = 49 })
					I[36] = new("ImageLabel", I[33], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(235, 234, 181), ImageContent = Content.fromUri("rbxassetid://2743800920"), Position = UDim2.fromScale(0.03, 0.1), Size = UDim2.fromScale(0.17, 0.8), ZIndex = 51 })
				I[37] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint", { AspectRatio = 1.48 })
				I[38] = new("UISizeConstraint", I[24], "UISizeConstraint", { MinSize = Vector2.new(170, 170) })
			I[39] = new("ImageLabel", I[23], "Logo", { AnchorPoint = Vector2.new(0.5, 0.7), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://5985209834"), Position = UDim2.fromScale(0.5, 0.445), ZIndex = 101 })
				I[40] = new("UIAspectRatioConstraint", I[39], "UIAspectRatioConstraint")
			I[41] = new("ImageLabel", I[23], "Left", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(80, 80, 80), ImageContent = Content.fromUri("rbxassetid://4506864681"), ImageTransparency = 0.1, Position = UDim2.fromScale(-0.15, 0.5), Size = UDim2.fromScale(0.15, 0.2), ZIndex = 48 })
				I[42] = new("UIAspectRatioConstraint", I[41], "UIAspectRatioConstraint", { AspectRatio = 1.38 })
			I[43] = new("ImageLabel", I[23], "Right", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(80, 80, 80), ImageContent = Content.fromUri("rbxassetid://4500760613"), ImageTransparency = 0.1, Position = UDim2.fromScale(1.15, 0.5), Size = UDim2.fromScale(0.15, 0.2), ZIndex = 48 })
				I[44] = new("UIAspectRatioConstraint", I[43], "UIAspectRatioConstraint", { AspectRatio = 1.38 })
	return I[1]
end

return build

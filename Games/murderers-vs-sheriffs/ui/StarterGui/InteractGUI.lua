-- Generated from ui/StarterGui/InteractGUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "InteractGUI", { Active = true, AlwaysOnTop = true, MaxDistance = 25, ResetOnSpawn = false, Size = UDim2.fromScale(1.2, 1.3), StudsOffsetWorldSpace = Vector3.new(0, 2.2, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Gamepad", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[3] = new("Frame", I[2], "Use", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
				I[4] = new("Frame", I[3], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.fromScale(1, 0.9), Style = Enum.FrameStyle.RobloxRound })
					I[5] = new("ImageLabel", I[4], "ButtonIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=15026912593"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 12, 1, 12), SizeConstraint = Enum.SizeConstraint.RelativeXX })
						I[6] = new("ImageLabel", I[5], "ButtonIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Settings/Help/YButtonDark@2x.png"), Size = UDim2.fromScale(1, 1), Visible = false })
							I[7] = new("ImageLabel", I[6], "ButtonIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Settings/Help/YButtonDark@2x.png"), Size = UDim2.fromScale(1, 1) })
				I[8] = new("TextLabel", I[3], "UseText", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(2, 0.4), Text = "Activate", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 80, TextStrokeTransparency = 0, TextWrapped = true })
			I[9] = new("Frame", I[2], "Cooldown", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
				I[10] = new("Frame", I[9], "Frame", { BackgroundColor3 = Color3.fromRGB(84, 84, 84), BackgroundTransparency = 0.2, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
					I[11] = new("ImageLabel", I[10], "ButtonIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(143, 143, 143), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=15026912593"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[12] = new("Frame", I[2], "KnifeUse", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
				I[13] = new("Frame", I[12], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.fromScale(1, 0.9), Style = Enum.FrameStyle.RobloxRound })
					I[14] = new("ImageLabel", I[13], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4681024341"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.6, 1.6), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[15] = new("Frame", I[2], "KnifeCooldown", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
				I[16] = new("Frame", I[15], "Frame", { BackgroundColor3 = Color3.fromRGB(84, 84, 84), BackgroundTransparency = 0.2, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
					I[17] = new("ImageLabel", I[16], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4662789116"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY })
		I[18] = new("Frame", I[1], "Mobile", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(2, 2) })
			I[19] = new("Frame", I[18], "Use", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
				I[20] = new("Frame", I[19], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.fromScale(1, 1), Style = Enum.FrameStyle.RobloxRound })
					I[21] = new("ImageLabel", I[20], "KnifeIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4605890398"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.2, 1.2), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 2 })
			I[22] = new("Frame", I[18], "Cooldown", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Visible = false })
				I[23] = new("Frame", I[22], "Frame", { BackgroundColor3 = Color3.fromRGB(84, 84, 84), BackgroundTransparency = 0.2, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
					I[24] = new("ImageLabel", I[23], "KnifeIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(94, 94, 94), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4605890398"), ImageTransparency = 0.1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 2 })
			I[25] = new("Frame", I[18], "KnifeUse", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
				I[26] = new("Frame", I[25], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.fromScale(1, 0.9), Style = Enum.FrameStyle.RobloxRound })
					I[27] = new("ImageLabel", I[26], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4681024341"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.2, 1.2), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[28] = new("Frame", I[18], "KnifeCooldown", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
				I[29] = new("Frame", I[28], "Frame", { BackgroundColor3 = Color3.fromRGB(84, 84, 84), BackgroundTransparency = 0.2, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
					I[30] = new("ImageLabel", I[29], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4662789116"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[31] = new("Frame", I[18], "KeyRequired", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
				I[32] = new("Frame", I[31], "Frame", { BackgroundColor3 = Color3.fromRGB(84, 84, 84), BackgroundTransparency = 0.2, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
					I[33] = new("ImageLabel", I[32], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5792429175"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[34] = new("TextLabel", I[31], "UseText", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(2, 0.4), Text = "Need Key!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 80, TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
		I[35] = new("Frame", I[1], "Keyboard", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[36] = new("Frame", I[35], "Use", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
				I[37] = new("Frame", I[36], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.fromScale(1, 0.9), Style = Enum.FrameStyle.RobloxRound })
					I[38] = new("TextLabel", I[37], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.5, 1.5), Text = "F", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 80, TextStrokeTransparency = 0, TextWrapped = true })
				I[39] = new("TextLabel", I[36], "UseText", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(2, 0.4), Text = "Activate", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 80, TextStrokeTransparency = 0, TextWrapped = true })
			I[40] = new("Frame", I[35], "Cooldown", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
				I[41] = new("Frame", I[40], "Frame", { BackgroundColor3 = Color3.fromRGB(84, 84, 84), BackgroundTransparency = 0.2, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
					I[42] = new("TextLabel", I[41], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "F", TextColor3 = Color3.fromRGB(53, 53, 53), TextScaled = true, TextSize = 80, TextWrapped = true })
			I[43] = new("Frame", I[35], "KnifeUse", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
				I[44] = new("Frame", I[43], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.fromScale(1, 0.9), Style = Enum.FrameStyle.RobloxRound })
					I[45] = new("ImageLabel", I[44], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4681024341"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.6, 1.6), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[46] = new("Frame", I[35], "KnifeCooldown", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
				I[47] = new("Frame", I[46], "Frame", { BackgroundColor3 = Color3.fromRGB(84, 84, 84), BackgroundTransparency = 0.2, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
					I[48] = new("ImageLabel", I[47], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4662789116"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[49] = new("Frame", I[35], "KeyRequired", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
				I[50] = new("Frame", I[49], "Frame", { BackgroundColor3 = Color3.fromRGB(84, 84, 84), BackgroundTransparency = 0.2, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
					I[51] = new("ImageLabel", I[50], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5792429175"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[52] = new("TextLabel", I[49], "UseText", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(2, 0.4), Text = "Need Key!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 80, TextStrokeTransparency = 0, TextWrapped = true })
	return I[1]
end

return build

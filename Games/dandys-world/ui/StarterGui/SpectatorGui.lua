-- Generated from ui/StarterGui/SpectatorGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SpectatorGui", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Sound", I[1], "PlaceSound", { PlaybackSpeed = 0.7, RollOffMaxDistance = 200, RollOffMode = Enum.RollOffMode.Linear })
		I[3] = new("Sound", I[1], "CloseSound", { PlaybackSpeed = 0.7, RollOffMaxDistance = 200, RollOffMode = Enum.RollOffMode.Linear })
		I[4] = new("Sound", I[1], "ElectricTick", { RollOffMaxDistance = 200, RollOffMode = Enum.RollOffMode.Linear })
		I[5] = new("Sound", I[1], "Tick", { PlaybackSpeed = 2, RollOffMode = Enum.RollOffMode.InverseTapered })
		I[6] = new("Sound", I[1], "MoneyCollected", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0.4 })
		I[7] = new("Sound", I[1], "MoneyPopup", { RollOffMode = Enum.RollOffMode.InverseTapered })
		I[8] = new("Sound", I[1], "CountSound", { PlaybackSpeed = 0.75, RollOffMode = Enum.RollOffMode.InverseTapered, TimePosition = 0.85, Volume = 0.1 })
		I[9] = new("Sound", I[1], "Click", { RollOffMode = Enum.RollOffMode.InverseTapered })
		I[10] = new("Frame", I[1], "SpectateFrame", { BackgroundColor3 = Color3.fromRGB(121, 121, 121), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4061353, 0.8401733), Size = UDim2.fromScale(0.1872575, 0.081792), ZIndex = 2 })
			I[11] = new("Frame", I[10], "Frame", { BackgroundColor3 = Color3.fromRGB(121, 121, 121), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 140, 140)), ColorSequenceKeypoint.new(1, Color3.fromRGB(81, 81, 81)) }), Rotation = 90 })
				I[13] = new("UICorner", I[11], "UICorner")
			I[14] = new("Frame", I[10], "FrameBG", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0235734, -0.0848055), Size = UDim2.fromScale(1.0462711, 1.169611) })
				I[15] = new("UICorner", I[14], "UICorner")
			I[16] = new("ParticleEmitter", I[10], "ParticleEmitter", { Acceleration = Vector3.new(0, -100, 0), Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Drag = 2, Enabled = false, Lifetime = NumberRange.new(1, 1), LightInfluence = 1, Rate = 50, RotSpeed = NumberRange.new(-350, 350), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.1033898, 2.4041815, 0.9059234), NumberSequenceKeypoint.new(0.3525424, 0.662021), NumberSequenceKeypoint.new(0.5661017, 0.9756094), NumberSequenceKeypoint.new(1, 0.2787453) }), Speed = NumberRange.new(6, 6), SpreadAngle = Vector2.new(50, 50), TextureContent = Content.fromUri("rbxassetid://16514122597"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.135741, 0), NumberSequenceKeypoint.new(0.732254, 0.4), NumberSequenceKeypoint.new(1, 1) }), ZOffset = 2 })
			I[17] = new("TextLabel", I[10], "PlayerName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0510087, 0), Size = UDim2.fromScale(0.8985987, 0.9999999), Text = "No One", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 6 })
				I[18] = new("UIGradient", I[17], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.0967185, Color3.fromRGB(235, 235, 235)), ColorSequenceKeypoint.new(0.4162349, Color3.fromRGB(241, 241, 241)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 53, 53)) }), Rotation = 90 })
			I[19] = new("TextLabel", I[10], "Spectating", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0510087, -0.6572407), Size = UDim2.fromScale(0.8985987, 0.5094004), Text = "Spectating...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 6 })
		I[20] = new("ImageButton", I[1], "RightButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5974079, 0.8401733), Size = UDim2.fromScale(0.0509988, 0.0812139), ZIndex = 5 })
			I[21] = new("Frame", I[20], "Frame", { BackgroundColor3 = Color3.fromRGB(121, 121, 121), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[22] = new("UIGradient", I[21], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 140, 140)), ColorSequenceKeypoint.new(1, Color3.fromRGB(81, 81, 81)) }), Rotation = 90 })
				I[23] = new("UICorner", I[21], "UICorner")
			I[24] = new("Frame", I[20], "FrameBG", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0883463, -0.0858431), Size = UDim2.fromScale(1.1710838, 1.1839409) })
				I[25] = new("UICorner", I[24], "UICorner")
			I[26] = new("ImageLabel", I[20], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17517362792"), Size = UDim2.fromScale(1, 1), ZIndex = 5 })
		I[27] = new("ImageButton", I[1], "LeftButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.3507151, 0.8401733), Size = UDim2.fromScale(0.0509988, 0.0812139), ZIndex = 5 })
			I[28] = new("Frame", I[27], "Frame", { BackgroundColor3 = Color3.fromRGB(121, 121, 121), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[29] = new("UIGradient", I[28], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 140, 140)), ColorSequenceKeypoint.new(1, Color3.fromRGB(81, 81, 81)) }), Rotation = 90 })
				I[30] = new("UICorner", I[28], "UICorner")
			I[31] = new("Frame", I[27], "FrameBG", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0883463, -0.0858431), Size = UDim2.fromScale(1.1710838, 1.1839409) })
				I[32] = new("UICorner", I[31], "UICorner")
			I[33] = new("ImageLabel", I[27], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17517379062"), Size = UDim2.fromScale(1, 1), ZIndex = 5 })
		I[34] = new("ImageButton", I[1], "LeaveLobby", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.7687811, 0.8799881), Size = UDim2.fromScale(0.154727, 0.0812139), ZIndex = 5 })
			I[35] = new("Frame", I[34], "Frame", { BackgroundColor3 = Color3.fromRGB(121, 121, 121), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[36] = new("UIGradient", I[35], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 140, 140)), ColorSequenceKeypoint.new(1, Color3.fromRGB(81, 81, 81)) }), Rotation = 90 })
				I[37] = new("UICorner", I[35], "UICorner")
			I[38] = new("Frame", I[34], "FrameBG", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0329658, -0.0858432), Size = UDim2.fromScale(1.060323, 1.1839409) })
				I[39] = new("UICorner", I[38], "UICorner")
			I[40] = new("TextLabel", I[34], "PlayerName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0029148, 0.1792601), Size = UDim2.fromScale(1.0000001, 0.6499206), Text = "RETURN TO LOBBY", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 6 })
				I[41] = new("UIGradient", I[40], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.0967185, Color3.fromRGB(235, 235, 235)), ColorSequenceKeypoint.new(0.4162349, Color3.fromRGB(241, 241, 241)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 53, 53)) }), Rotation = 90 })
		I[42] = new("BindableEvent", I[1], "ActivateSpectate")
		I[43] = new("Frame", I[1], "InfoFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[44] = new("Frame", I[43], "GeneratorFrame", { BackgroundColor3 = Color3.fromRGB(56, 56, 56), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.2462355, 0.0580925), Size = UDim2.fromScale(0.5074402, 0.052371) })
				I[45] = new("UIGradient", I[44], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135)) }), Rotation = 180 })
				I[46] = new("UICorner", I[44], "UICorner")
				I[47] = new("Frame", I[44], "CurrentAmount", { BackgroundColor3 = Color3.fromRGB(121, 121, 121), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0, 1), ZIndex = 2 })
					I[48] = new("UIGradient", I[47], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135)) }), Rotation = 180 })
					I[49] = new("UICorner", I[47], "UICorner")
				I[50] = new("TextLabel", I[44], "Message", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Intermission", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
					I[51] = new("UIGradient", I[50], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.0967185, Color3.fromRGB(235, 235, 235)), ColorSequenceKeypoint.new(0.4162349, Color3.fromRGB(241, 241, 241)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 53, 53)) }), Rotation = 90 })
			I[52] = new("Frame", I[43], "GeneratorFrameBG", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.2415423, 0.051133), Size = UDim2.fromScale(0.5168069, 0.0658728), ZIndex = 0 })
				I[53] = new("UICorner", I[52], "UICorner")
			I[54] = new("TextLabel", I[43], "FloorNumber", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(0.2462355, 0.0112717), Size = UDim2.fromScale(0.5074402, 0.0406695), Text = "FLOOR 0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[55] = new("UICorner", I[54], "UICorner")
				I[56] = new("UIGradient", I[54], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.0967185, Color3.fromRGB(235, 235, 235)), ColorSequenceKeypoint.new(0.4162349, Color3.fromRGB(241, 241, 241)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 53, 53)) }), Rotation = 90 })
			I[57] = new("TextLabel", I[43], "Message", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(0.2415423, 0.116185), Size = UDim2.fromScale(0.5168069, 0.0406695), Text = "Game is loading. Be patient!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[58] = new("UICorner", I[57], "UICorner")
	return I[1]
end

return build

-- Generated from ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Domain/YutaDomain_Template.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "YutaDomain_Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 0.4) })
		I[2] = new("ImageLabel", I[1], "BlurryBackground", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=80547425846415"), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(5, 2.5), ZIndex = -1 })
		I[3] = new("ViewportFrame", I[1], "ViewportFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
			I[4] = new("WorldModel", I[3], "WorldModel")
				I[5] = new("Part", I[4], "Background", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(33, 5, 0), CanCollide = false, CanQuery = false, CanTouch = false, Size = Vector3.new(0.001, 20.5510006, 29.3339996), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
					I[6] = new("Decal", I[5], "Decal", { Face = Enum.NormalId.Left, TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=122666137765463") })
				I[7] = new("Model", I[4], "NPC")
					I[8] = new("BodyColors", I[7], "Body Colors", { HeadColor3 = Color3.fromRGB(245, 205, 48), LeftArmColor3 = Color3.fromRGB(245, 205, 48), LeftLegColor3 = Color3.fromRGB(164, 189, 71), RightArmColor3 = Color3.fromRGB(245, 205, 48), RightLegColor3 = Color3.fromRGB(164, 189, 71), TorsoColor3 = Color3.fromRGB(13, 105, 172) })
					I[9] = new("Part", I[7], "HumanoidRootPart", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.5000019, 3, -1.0000005, 0.0000015, 0, 1.0000019, 0, 1, 0, -1.0000038, 0, -0.0000015), CanCollide = false, CanQuery = false, CanTouch = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
						I[10] = new("ParticleEmitter", I[9], "ParticleEmitter3", { Brightness = 25, Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(53, 116, 237)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 116, 237)) }), Enabled = false, Lifetime = NumberRange.new(0.5, 0.5), LightEmission = -1, LockedToPart = true, Orientation = Enum.ParticleOrientation.VelocityPerpendicular, Rate = 1, RotSpeed = NumberRange.new(1000, 1000), Rotation = NumberRange.new(100, 100), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 10), NumberSequenceKeypoint.new(1, 10) }), Speed = NumberRange.new(0.1, 0.1), TextureContent = Content.fromUri("rbxassetid://7216852306"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2899516, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 1) }) }, { ["EmitCount"] = 1 })
						I[11] = new("Motor6D", I[9], "RootJoint", { C0 = CFrame.new(0, 0, -0.0000019, -1, 0, 0, 0, 0, 1, 0, 0.9999999, 0), C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
						I[12] = new("Attachment", I[9], "RootAttachment")
					I[13] = new("Humanoid", I[7], "Humanoid", { DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Subject })
						I[14] = new("HumanoidDescription", I[13], "HumanoidDescription", { BodyTypeScale = 0.35, Pants = 382538503, ProportionScale = 0, Shirt = 144076358 })
							I[15] = new("BodyPartDescription", I[14], "BodyPartDescription", { BodyPart = Enum.BodyPart.Torso, Color = Color3.fromRGB(204, 142, 105) })
							I[16] = new("BodyPartDescription", I[14], "BodyPartDescription", { BodyPart = Enum.BodyPart.RightLeg, Color = Color3.fromRGB(204, 142, 105) })
							I[17] = new("BodyPartDescription", I[14], "BodyPartDescription", { BodyPart = Enum.BodyPart.RightArm, Color = Color3.fromRGB(204, 142, 105) })
							I[18] = new("BodyPartDescription", I[14], "BodyPartDescription", { BodyPart = Enum.BodyPart.LeftLeg, Color = Color3.fromRGB(204, 142, 105) })
							I[19] = new("BodyPartDescription", I[14], "BodyPartDescription", { BodyPart = Enum.BodyPart.LeftArm, Color = Color3.fromRGB(204, 142, 105) })
							I[20] = new("BodyPartDescription", I[14], "BodyPartDescription", { Color = Color3.fromRGB(204, 142, 105) })
							I[21] = new("AccessoryDescription", I[14], "AccessoryDescription", { AccessoryType = Enum.AccessoryType.Hair, AssetId = 376548738 })
							I[22] = new("AccessoryDescription", I[14], "AccessoryDescription", { AccessoryType = Enum.AccessoryType.Face, AssetId = 376526673 })
						I[23] = new("Animator", I[13], "Animator")
					I[24] = new("Part", I[7], "Right Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.5, 1, -1.5000024, 0.0000015, 0, 1.0000018, 0, 1, 0, -1.0000038, 0, -0.0000015), CanCollide = false, Color = Color3.fromRGB(164, 189, 71), Size = Vector3.new(1, 2, 1) })
						I[25] = new("Attachment", I[24], "RightFootAttachment", { CFrame = CFrame.new(0, -1, 0) })
					I[26] = new("Part", I[7], "Left Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(29.5, 1, -0.4999986, 0.0000015, 0, 1.0000018, 0, 1, 0, -1.0000038, 0, -0.0000015), CanCollide = false, Color = Color3.fromRGB(164, 189, 71), Size = Vector3.new(1, 2, 1) })
						I[27] = new("Attachment", I[26], "LeftFootAttachment", { CFrame = CFrame.new(0, -1, 0) })
					I[28] = new("Part", I[7], "Right Arm", { CFrame = CFrame.new(29.5000019, 3, -2.5000062, 0.0000015, 0, 1.0000018, 0, 1, 0, -1.0000038, 0, -0.0000015), CanCollide = false, Color = Color3.fromRGB(245, 205, 48), Size = Vector3.new(1, 2, 1) })
						I[29] = new("Attachment", I[28], "RightGripAttachment", { CFrame = CFrame.new(0, -1, 0) })
						I[30] = new("Attachment", I[28], "RightShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
					I[31] = new("Part", I[7], "Left Arm", { CFrame = CFrame.new(29.4999981, 3, 0.5000052, 0.0000015, 0, 1.0000018, 0, 1, 0, -1.0000038, 0, -0.0000015), CanCollide = false, Color = Color3.fromRGB(245, 205, 48), Size = Vector3.new(1, 2, 1) })
						I[32] = new("Attachment", I[31], "LeftGripAttachment", { CFrame = CFrame.new(0, -1, 0) })
						I[33] = new("Attachment", I[31], "LeftShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
					I[34] = new("Part", I[7], "Torso", { CFrame = CFrame.new(29.5, 3, -1.0000005, 0.0000015, 0, 1.0000018, 0, 1, 0, -1.0000038, 0, -0.0000015), Color = Color3.fromRGB(13, 105, 172), LeftSurface = Enum.SurfaceType.Weld, RightSurface = Enum.SurfaceType.Weld, Size = Vector3.new(2, 2, 1) })
						I[35] = new("Motor6D", I[34], "Neck", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
						I[36] = new("Motor6D", I[34], "Left Hip", { C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
						I[37] = new("Motor6D", I[34], "Right Hip", { C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
						I[38] = new("Motor6D", I[34], "Left Shoulder", { C0 = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
						I[39] = new("Motor6D", I[34], "Right Shoulder", { C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
						I[40] = new("Attachment", I[34], "WaistBackAttachment", { CFrame = CFrame.new(0, -1, 0.5) })
						I[41] = new("Attachment", I[34], "WaistCenterAttachment", { CFrame = CFrame.new(0, -1, 0) })
						I[42] = new("Attachment", I[34], "WaistFrontAttachment", { CFrame = CFrame.new(0, -1, -0.5) })
						I[43] = new("Attachment", I[34], "RightCollarAttachment", { CFrame = CFrame.new(1, 1, 0) })
						I[44] = new("Attachment", I[34], "LeftCollarAttachment", { CFrame = CFrame.new(-1, 1, 0) })
						I[45] = new("Attachment", I[34], "BodyBackAttachment", { CFrame = CFrame.new(0, 0, 0.5) })
						I[46] = new("Attachment", I[34], "BodyFrontAttachment", { CFrame = CFrame.new(0, 0, -0.5) })
						I[47] = new("Attachment", I[34], "NeckAttachment", { CFrame = CFrame.new(0, 1, 0) })
						I[48] = new("Decal", I[34], "roblox")
					I[49] = new("Part", I[7], "Head", { CFrame = CFrame.new(29.5, 4.5, -1.0000005, 0.0000015, 0, 1.0000018, 0, 1, 0, -1.0000038, 0, -0.0000015), Color = Color3.fromRGB(245, 205, 48), PivotOffset = CFrame.new(0, -4.5, 0), Size = Vector3.new(2, 1, 1), TopSurface = Enum.SurfaceType.Smooth })
						I[50] = new("Attachment", I[49], "FaceCenterAttachment")
						I[51] = new("Attachment", I[49], "FaceFrontAttachment", { CFrame = CFrame.new(0, 0, -0.6) })
						I[52] = new("Attachment", I[49], "HatAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
						I[53] = new("Attachment", I[49], "HairAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
						I[54] = new("Decal", I[49], "face", { TextureContent = Content.fromUri("rbxasset://textures/face.png") })
						I[55] = new("SpecialMesh", I[49], "Mesh", { Scale = Vector3.new(1.25, 1.25, 1.25) })
		I[56] = new("Frame", I[1], "BorderTop", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.03) })
			I[57] = new("TextLabel", I[56], "DOMAIN", { AnchorPoint = Vector2.new(0.8, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Rotation = 10, Size = UDim2.new(0.5, 0, 0, 100), Text = "DOMAIN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[58] = new("UIStroke", I[57], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
			I[59] = new("ImageLabel", I[56], "LINE2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=93968050354762"), Position = UDim2.fromScale(1.35, 0.5), Rotation = -90, Size = UDim2.fromScale(5, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
			I[60] = new("ImageLabel", I[56], "LINE", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=93968050354762"), Position = UDim2.fromScale(0.45, 0.5), Rotation = -90, Size = UDim2.fromScale(5, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
			I[61] = new("ImageLabel", I[56], "BACKGROUND2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=73084134899292"), Position = UDim2.fromScale(1.35, 0.5), Rotation = -90, Size = UDim2.fromScale(10, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 0 })
			I[62] = new("ImageLabel", I[56], "BACKGROUND", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=73084134899292"), Position = UDim2.fromScale(0.45, 0.5), Rotation = -90, Size = UDim2.fromScale(10, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 0 })
			I[63] = new("UIStroke", I[56], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
		I[64] = new("Frame", I[1], "BorderBottom", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.03) })
			I[65] = new("TextLabel", I[64], "EXPANSION", { AnchorPoint = Vector2.new(0.2, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Rotation = 10, Size = UDim2.new(0.5, 0, 0, 100), Text = "EXPANSION", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[66] = new("UIStroke", I[65], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
			I[67] = new("ImageLabel", I[64], "LINE2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=93968050354762"), Position = UDim2.fromScale(1.35, 0.5), Rotation = -90, Size = UDim2.fromScale(5, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
			I[68] = new("ImageLabel", I[64], "LINE", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=93968050354762"), Position = UDim2.fromScale(0.45, 0.5), Rotation = -90, Size = UDim2.fromScale(5, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
			I[69] = new("ImageLabel", I[64], "BACKGROUND2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=73084134899292"), Position = UDim2.fromScale(1.35, 0.5), Rotation = -90, Size = UDim2.fromScale(10, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 0 })
			I[70] = new("ImageLabel", I[64], "BACKGROUND", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=73084134899292"), Position = UDim2.fromScale(0.45, 0.5), Rotation = -90, Size = UDim2.fromScale(10, 160), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 0 })
			I[71] = new("UIStroke", I[64], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
	I[7].PrimaryPart = I[9]
	I[11].Part0 = I[9]
	I[11].Part1 = I[34]
	I[35].Part0 = I[34]
	I[35].Part1 = I[49]
	I[36].Part0 = I[34]
	I[36].Part1 = I[26]
	I[37].Part0 = I[34]
	I[37].Part1 = I[24]
	I[38].Part0 = I[34]
	I[38].Part1 = I[31]
	I[39].Part0 = I[34]
	I[39].Part1 = I[28]
	return I[1]
end

return build

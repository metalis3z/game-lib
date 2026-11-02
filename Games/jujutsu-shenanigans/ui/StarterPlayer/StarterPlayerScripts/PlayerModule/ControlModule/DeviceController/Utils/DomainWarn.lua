-- Generated from ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/DomainWarn.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DomainWarn", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "FlashText", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 3, Position = UDim2.fromScale(0.5, 0.5), Rotation = -7, Size = UDim2.fromScale(1.5, 0), ZIndex = 3 })
			I[3] = new("TextLabel", I[2], "Text2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6, 1), Rotation = 7, Size = UDim2.fromScale(0.3, 0.3), SizeConstraint = Enum.SizeConstraint.RelativeXX, Text = "EXPANSION", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
				I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 5 })
			I[5] = new("TextLabel", I[2], "Text1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4, 0), Rotation = 7, Size = UDim2.fromScale(0.3, 0.3), SizeConstraint = Enum.SizeConstraint.RelativeXX, Text = "DOMAIN", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
				I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 5 })
		I[7] = new("Frame", I[1], "PanelBack", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = -7, Size = UDim2.fromScale(1.5, 0.03) })
		I[8] = new("CanvasGroup", I[1], "Panel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 3, Position = UDim2.fromScale(0.5, 0.5), Rotation = -7, Size = UDim2.fromScale(1.5, 0), ZIndex = 2 })
			I[9] = new("ViewportFrame", I[8], "Viewport", { Ambient = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Rotation = 7, Size = UDim2.fromScale(1, 0.2), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 2 })
				I[10] = new("WorldModel", I[9], "Display")
					I[11] = new("Humanoid", I[10], "Humanoid", { DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None, HealthDisplayDistance = 0, HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff, NameDisplayDistance = 0 })
						I[12] = new("Animator", I[11], "Animator")
					I[13] = new("Part", I[10], "Left Arm", { CFrame = CFrame.new(-56.5847168, 3, -48.360611, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
						I[14] = new("Attachment", I[13], "LeftGripAttachment", { CFrame = CFrame.new(0, -1, 0) })
						I[15] = new("Attachment", I[13], "LeftShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
						I[16] = new("Part", I[13], "FingersL", { CFrame = CFrame.new(-56.5847168, 3, -48.360611, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, EnableFluidForces = false, Locked = true, Massless = true, Size = Vector3.new(1, 2, 1), Transparency = 1 })
							I[17] = new("Motor6D", I[16], "Fingers")
							I[18] = new("Motor6D", I[16], "Thumb", { C0 = CFrame.new(0.3750048, -0.9954627, -0.3794327, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.1999999, 0) })
							I[19] = new("Motor6D", I[16], "Ring", { C0 = CFrame.new(-0.3754196, -0.9258037, 0.1016769, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.3999999, 0) })
							I[20] = new("Motor6D", I[16], "Pinky", { C0 = CFrame.new(-0.3754196, -0.9258034, 0.3301773, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
							I[21] = new("Motor6D", I[16], "Middle", { C0 = CFrame.new(-0.3754196, -0.9258034, -0.1321793, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
							I[22] = new("Motor6D", I[16], "Index", { C0 = CFrame.new(-0.3754196, -0.9258034, -0.348114, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
							I[23] = new("Part", I[16], "Ring", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.6863937, 1.6741965, -48.7360306, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[24] = new("Part", I[16], "Index", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.2366028, 1.6741965, -48.7360306, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[25] = new("Part", I[16], "Thumb", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.2052841, 1.8045374, -47.9856071, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.5493469, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[26] = new("Part", I[16], "Middle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.4525375, 1.6741965, -48.7360306, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[27] = new("Part", I[16], "Pinky", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.9148941, 1.6741965, -48.7360306, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
					I[28] = new("Part", I[10], "HumanoidRootPart", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.5847168, 3, -46.860611, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
						I[29] = new("Motor6D", I[28], "RootJoint", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
						I[30] = new("Attachment", I[28], "RootAttachment")
					I[31] = new("Part", I[10], "Head", { CFrame = CFrame.new(-56.5847168, 4.5, -46.860611, 0, 0, -1, 0, 1, 0, 1, 0, 0), EnableFluidForces = false, Size = Vector3.new(2, 1, 1), TopSurface = Enum.SurfaceType.Smooth })
						I[32] = new("Decal", I[31], "face", { TextureContent = Content.fromUri("rbxassetid://6821165844") })
						I[33] = new("Attachment", I[31], "FaceCenterAttachment")
						I[34] = new("Attachment", I[31], "FaceFrontAttachment", { CFrame = CFrame.new(0, 0, -0.6) })
						I[35] = new("Attachment", I[31], "HatAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
						I[36] = new("Attachment", I[31], "HairAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
						I[37] = new("SpecialMesh", I[31], "Mesh", { Scale = Vector3.new(1.25, 1.25, 1.25) })
					I[38] = new("Part", I[10], "Torso", { CFrame = CFrame.new(-56.5847168, 3, -46.860611, 0, 0, -1, 0, 1, 0, 1, 0, 0), Color = Color3.fromRGB(99, 95, 98), EnableFluidForces = false, LeftSurface = Enum.SurfaceType.Weld, RightSurface = Enum.SurfaceType.Weld, Size = Vector3.new(2, 2, 1) })
						I[39] = new("Weld", I[38], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.8500004, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
						I[40] = new("Weld", I[38], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, -0.3000011, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
						I[41] = new("Weld", I[38], "Weld", { C0 = CFrame.new(1, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, -0.3000011, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
						I[42] = new("Motor6D", I[38], "Neck", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
						I[43] = new("Motor6D", I[38], "Left Hip", { C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
						I[44] = new("Motor6D", I[38], "Right Hip", { C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
						I[45] = new("Motor6D", I[38], "Left Shoulder", { C0 = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
						I[46] = new("Motor6D", I[38], "Right Shoulder", { C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
						I[47] = new("Attachment", I[38], "WaistBackAttachment", { CFrame = CFrame.new(0, -1, 0.5) })
						I[48] = new("Attachment", I[38], "WaistCenterAttachment", { CFrame = CFrame.new(0, -1, 0) })
						I[49] = new("Attachment", I[38], "WaistFrontAttachment", { CFrame = CFrame.new(0, -1, -0.5) })
						I[50] = new("Attachment", I[38], "RightCollarAttachment", { CFrame = CFrame.new(1, 1, 0) })
						I[51] = new("Attachment", I[38], "LeftCollarAttachment", { CFrame = CFrame.new(-1, 1, 0) })
						I[52] = new("Attachment", I[38], "BodyBackAttachment", { CFrame = CFrame.new(0, 0, 0.5) })
						I[53] = new("Attachment", I[38], "BodyFrontAttachment", { CFrame = CFrame.new(0, 0, -0.5) })
						I[54] = new("Attachment", I[38], "NeckAttachment", { CFrame = CFrame.new(0, 1, 0) })
					I[55] = new("Part", I[10], "Right Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.5847168, 1, -46.360611, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
						I[56] = new("Snap", I[55], "Snap", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0.5, -1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0) })
						I[57] = new("Attachment", I[55], "RightFootAttachment", { CFrame = CFrame.new(0, -1, 0) })
					I[58] = new("Part", I[10], "Right Arm", { CFrame = CFrame.new(-56.5847168, 3, -45.360611, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
						I[59] = new("Attachment", I[58], "RightGripAttachment", { CFrame = CFrame.new(0, -1, 0) })
						I[60] = new("Attachment", I[58], "RightShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
						I[61] = new("Part", I[58], "FingersR", { CFrame = CFrame.new(-56.5847168, 3, -45.360611, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, EnableFluidForces = false, Locked = true, Massless = true, Size = Vector3.new(1, 2, 1), Transparency = 1 })
							I[62] = new("Motor6D", I[61], "Fingers")
							I[63] = new("Motor6D", I[61], "Thumb", { C0 = CFrame.new(-0.3723125, -0.9954627, -0.3794327, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.1999999, 0) })
							I[64] = new("Motor6D", I[61], "Pinky", { C0 = CFrame.new(0.3789158, -0.9258034, 0.3301773, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
							I[65] = new("Motor6D", I[61], "Ring", { C0 = CFrame.new(0.3789158, -0.9258034, 0.1016769, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
							I[66] = new("Motor6D", I[61], "Index", { C0 = CFrame.new(0.3789158, -0.9258034, -0.348114, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
							I[67] = new("Motor6D", I[61], "Middle", { C0 = CFrame.new(0.3789158, -0.9258034, -0.1321793, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
							I[68] = new("Part", I[61], "Pinky", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.9148941, 1.6741965, -44.9816971, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[69] = new("Part", I[61], "Ring", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.6863937, 1.6741965, -44.9816971, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[70] = new("Part", I[61], "Index", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.2366028, 1.6741965, -44.9816971, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[71] = new("Part", I[61], "Thumb", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.2052841, 1.8045374, -45.7329254, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.5493469, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[72] = new("Part", I[61], "Middle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.4525375, 1.6741965, -44.9816971, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
					I[73] = new("Part", I[10], "Left Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.5847168, 1, -47.360611, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
						I[74] = new("Snap", I[73], "Snap", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(-0.5, -1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0) })
						I[75] = new("Attachment", I[73], "LeftFootAttachment", { CFrame = CFrame.new(0, -1, 0) })
			I[76] = new("ImageLabel", I[8], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://4480871448"), Position = UDim2.fromScale(0.5, 0.5), ResampleMode = Enum.ResamplerMode.Pixelated, Rotation = 7, Size = UDim2.fromScale(0.8, 0.8), SizeConstraint = Enum.SizeConstraint.RelativeXX })
	I[10].PrimaryPart = I[28]
	I[17].Part0 = I[13]
	I[17].Part1 = I[16]
	I[18].Part0 = I[16]
	I[18].Part1 = I[25]
	I[19].Part0 = I[16]
	I[19].Part1 = I[23]
	I[20].Part0 = I[16]
	I[20].Part1 = I[27]
	I[21].Part0 = I[16]
	I[21].Part1 = I[26]
	I[22].Part0 = I[16]
	I[22].Part1 = I[24]
	I[29].Part0 = I[28]
	I[29].Part1 = I[38]
	I[39].Part0 = I[38]
	I[40].Part0 = I[38]
	I[41].Part0 = I[38]
	I[42].Part0 = I[38]
	I[42].Part1 = I[31]
	I[43].Part0 = I[38]
	I[43].Part1 = I[73]
	I[44].Part0 = I[38]
	I[44].Part1 = I[55]
	I[45].Part0 = I[38]
	I[45].Part1 = I[13]
	I[46].Part0 = I[38]
	I[46].Part1 = I[58]
	I[56].Part0 = I[55]
	I[62].Part0 = I[58]
	I[62].Part1 = I[61]
	I[63].Part0 = I[61]
	I[63].Part1 = I[71]
	I[64].Part0 = I[61]
	I[64].Part1 = I[68]
	I[65].Part0 = I[61]
	I[65].Part1 = I[69]
	I[66].Part0 = I[61]
	I[66].Part1 = I[70]
	I[67].Part0 = I[61]
	I[67].Part1 = I[72]
	I[74].Part0 = I[73]
	return I[1]
end

return build

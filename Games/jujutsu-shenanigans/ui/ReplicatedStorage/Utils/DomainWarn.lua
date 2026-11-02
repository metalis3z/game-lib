-- Generated from ui/ReplicatedStorage/Utils/DomainWarn.rbxm by _tools/rbxm2lua.luau
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
					I[13] = new("Part", I[10], "Head", { CFrame = CFrame.new(-56.5847168, 4.5, -46.860611, 0, 0, -1, 0, 1, 0, 1, 0, 0), EnableFluidForces = false, Size = Vector3.new(2, 1, 1), TopSurface = Enum.SurfaceType.Smooth })
						I[14] = new("Decal", I[13], "face", { TextureContent = Content.fromUri("rbxassetid://6821165844") })
						I[15] = new("Attachment", I[13], "FaceCenterAttachment")
						I[16] = new("Attachment", I[13], "FaceFrontAttachment", { CFrame = CFrame.new(0, 0, -0.6) })
						I[17] = new("Attachment", I[13], "HatAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
						I[18] = new("Attachment", I[13], "HairAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
						I[19] = new("SpecialMesh", I[13], "Mesh", { Scale = Vector3.new(1.25, 1.25, 1.25) })
					I[20] = new("Part", I[10], "HumanoidRootPart", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.5847168, 3, -46.860611, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
						I[21] = new("Motor6D", I[20], "RootJoint", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
						I[22] = new("Attachment", I[20], "RootAttachment")
					I[23] = new("Part", I[10], "Left Arm", { CFrame = CFrame.new(-56.5847168, 3, -48.360611, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
						I[24] = new("Attachment", I[23], "LeftGripAttachment", { CFrame = CFrame.new(0, -1, 0) })
						I[25] = new("Attachment", I[23], "LeftShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
						I[26] = new("Part", I[23], "FingersL", { CFrame = CFrame.new(-56.5847168, 3, -48.360611, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, EnableFluidForces = false, Locked = true, Massless = true, Size = Vector3.new(1, 2, 1), Transparency = 1 })
							I[27] = new("Motor6D", I[26], "Fingers")
							I[28] = new("Motor6D", I[26], "Thumb", { C0 = CFrame.new(0.3750048, -0.9954627, -0.3794327, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.1999999, 0) })
							I[29] = new("Motor6D", I[26], "Ring", { C0 = CFrame.new(-0.3754196, -0.9258037, 0.1016769, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.3999999, 0) })
							I[30] = new("Motor6D", I[26], "Pinky", { C0 = CFrame.new(-0.3754196, -0.9258034, 0.3301773, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
							I[31] = new("Motor6D", I[26], "Middle", { C0 = CFrame.new(-0.3754196, -0.9258034, -0.1321793, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
							I[32] = new("Motor6D", I[26], "Index", { C0 = CFrame.new(-0.3754196, -0.9258034, -0.348114, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
							I[33] = new("Part", I[26], "Middle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.4525375, 1.6741965, -48.7360306, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[34] = new("Part", I[26], "Thumb", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.2052841, 1.8045374, -47.9856071, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.5493469, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[35] = new("Part", I[26], "Index", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.2366028, 1.6741965, -48.7360306, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[36] = new("Part", I[26], "Ring", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.6863937, 1.6741965, -48.7360306, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[37] = new("Part", I[26], "Pinky", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.9148941, 1.6741965, -48.7360306, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
					I[38] = new("Part", I[10], "Left Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.5847168, 1, -47.360611, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
						I[39] = new("Snap", I[38], "Snap", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(-0.5, -1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0) })
						I[40] = new("Attachment", I[38], "LeftFootAttachment", { CFrame = CFrame.new(0, -1, 0) })
					I[41] = new("Part", I[10], "Right Arm", { CFrame = CFrame.new(-56.5847168, 3, -45.360611, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
						I[42] = new("Attachment", I[41], "RightGripAttachment", { CFrame = CFrame.new(0, -1, 0) })
						I[43] = new("Attachment", I[41], "RightShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
						I[44] = new("Part", I[41], "FingersR", { CFrame = CFrame.new(-56.5847168, 3, -45.360611, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, EnableFluidForces = false, Locked = true, Massless = true, Size = Vector3.new(1, 2, 1), Transparency = 1 })
							I[45] = new("Motor6D", I[44], "Fingers")
							I[46] = new("Motor6D", I[44], "Thumb", { C0 = CFrame.new(-0.3723125, -0.9954627, -0.3794327, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.1999999, 0) })
							I[47] = new("Motor6D", I[44], "Pinky", { C0 = CFrame.new(0.3789158, -0.9258034, 0.3301773, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
							I[48] = new("Motor6D", I[44], "Ring", { C0 = CFrame.new(0.3789158, -0.9258034, 0.1016769, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
							I[49] = new("Motor6D", I[44], "Index", { C0 = CFrame.new(0.3789158, -0.9258034, -0.348114, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
							I[50] = new("Motor6D", I[44], "Middle", { C0 = CFrame.new(0.3789158, -0.9258034, -0.1321793, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0, 0.4000001, 0) })
							I[51] = new("Part", I[44], "Middle", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.4525375, 1.6741965, -44.9816971, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[52] = new("Part", I[44], "Thumb", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.2052841, 1.8045374, -45.7329254, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.5493469, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[53] = new("Part", I[44], "Index", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.2366028, 1.6741965, -44.9816971, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[54] = new("Part", I[44], "Ring", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.6863937, 1.6741965, -44.9816971, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
							I[55] = new("Part", I[44], "Pinky", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.9148941, 1.6741965, -44.9816971, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Massless = true, Size = Vector3.new(0.2, 0.81, 0.2), TopSurface = Enum.SurfaceType.Smooth })
					I[56] = new("Part", I[10], "Right Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-56.5847168, 1, -46.360611, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1) })
						I[57] = new("Snap", I[56], "Snap", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0.5, -1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0) })
						I[58] = new("Attachment", I[56], "RightFootAttachment", { CFrame = CFrame.new(0, -1, 0) })
					I[59] = new("Part", I[10], "Torso", { CFrame = CFrame.new(-56.5847168, 3, -46.860611, 0, 0, -1, 0, 1, 0, 1, 0, 0), Color = Color3.fromRGB(99, 95, 98), EnableFluidForces = false, LeftSurface = Enum.SurfaceType.Weld, RightSurface = Enum.SurfaceType.Weld, Size = Vector3.new(2, 2, 1) })
						I[60] = new("Weld", I[59], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.8500004, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
						I[61] = new("Weld", I[59], "Weld", { C0 = CFrame.new(-1, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, -0.3000011, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
						I[62] = new("Weld", I[59], "Weld", { C0 = CFrame.new(1, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, -0.3000011, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
						I[63] = new("Motor6D", I[59], "Neck", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
						I[64] = new("Motor6D", I[59], "Left Hip", { C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
						I[65] = new("Motor6D", I[59], "Right Hip", { C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
						I[66] = new("Motor6D", I[59], "Left Shoulder", { C0 = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
						I[67] = new("Motor6D", I[59], "Right Shoulder", { C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
						I[68] = new("Attachment", I[59], "WaistBackAttachment", { CFrame = CFrame.new(0, -1, 0.5) })
						I[69] = new("Attachment", I[59], "WaistCenterAttachment", { CFrame = CFrame.new(0, -1, 0) })
						I[70] = new("Attachment", I[59], "WaistFrontAttachment", { CFrame = CFrame.new(0, -1, -0.5) })
						I[71] = new("Attachment", I[59], "RightCollarAttachment", { CFrame = CFrame.new(1, 1, 0) })
						I[72] = new("Attachment", I[59], "LeftCollarAttachment", { CFrame = CFrame.new(-1, 1, 0) })
						I[73] = new("Attachment", I[59], "BodyBackAttachment", { CFrame = CFrame.new(0, 0, 0.5) })
						I[74] = new("Attachment", I[59], "BodyFrontAttachment", { CFrame = CFrame.new(0, 0, -0.5) })
						I[75] = new("Attachment", I[59], "NeckAttachment", { CFrame = CFrame.new(0, 1, 0) })
			I[76] = new("ImageLabel", I[8], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://4480871448"), Position = UDim2.fromScale(0.5, 0.5), ResampleMode = Enum.ResamplerMode.Pixelated, Rotation = 7, Size = UDim2.fromScale(0.8, 0.8), SizeConstraint = Enum.SizeConstraint.RelativeXX })
	I[10].PrimaryPart = I[20]
	I[21].Part0 = I[20]
	I[21].Part1 = I[59]
	I[27].Part0 = I[23]
	I[27].Part1 = I[26]
	I[28].Part0 = I[26]
	I[28].Part1 = I[34]
	I[29].Part0 = I[26]
	I[29].Part1 = I[36]
	I[30].Part0 = I[26]
	I[30].Part1 = I[37]
	I[31].Part0 = I[26]
	I[31].Part1 = I[33]
	I[32].Part0 = I[26]
	I[32].Part1 = I[35]
	I[39].Part0 = I[38]
	I[45].Part0 = I[41]
	I[45].Part1 = I[44]
	I[46].Part0 = I[44]
	I[46].Part1 = I[52]
	I[47].Part0 = I[44]
	I[47].Part1 = I[55]
	I[48].Part0 = I[44]
	I[48].Part1 = I[54]
	I[49].Part0 = I[44]
	I[49].Part1 = I[53]
	I[50].Part0 = I[44]
	I[50].Part1 = I[51]
	I[57].Part0 = I[56]
	I[60].Part0 = I[59]
	I[61].Part0 = I[59]
	I[62].Part0 = I[59]
	I[63].Part0 = I[59]
	I[63].Part1 = I[13]
	I[64].Part0 = I[59]
	I[64].Part1 = I[38]
	I[65].Part0 = I[59]
	I[65].Part1 = I[56]
	I[66].Part0 = I[59]
	I[66].Part1 = I[23]
	I[67].Part0 = I[59]
	I[67].Part1 = I[41]
	return I[1]
end

return build

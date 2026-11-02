-- Generated from ui/ReplicatedStorage/Systems/Player/UI/Menus/Shop/Tabs/Emotes/EmoteViewport.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ViewportFrame", nil, "EmoteViewport", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.025), Size = UDim2.fromScale(0.9, 0.675), ZIndex = 0 })
		I[2] = new("WorldModel", I[1], "WorldModel")
			I[3] = new("Model", I[2], "Rig")
				I[4] = new("Humanoid", I[3], "Humanoid")
					I[5] = new("Animator", I[4], "Animator")
				I[6] = new("BodyColors", I[3], "Body Colors", { HeadColor3 = Color3.fromRGB(163, 162, 165), LeftArmColor3 = Color3.fromRGB(163, 162, 165), LeftLegColor3 = Color3.fromRGB(27, 42, 53), RightArmColor3 = Color3.fromRGB(163, 162, 165), RightLegColor3 = Color3.fromRGB(27, 42, 53), TorsoColor3 = Color3.fromRGB(91, 93, 105) })
				I[7] = new("Part", I[3], "Head", { CFrame = CFrame.new(0, 4.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), Size = Vector3.new(2, 1, 1), TopSurface = Enum.SurfaceType.Smooth })
					I[8] = new("SpecialMesh", I[7], "Mesh", { Scale = Vector3.new(1.25, 1.25, 1.25) })
					I[9] = new("Attachment", I[7], "HatAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
					I[10] = new("Attachment", I[7], "HairAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
					I[11] = new("Attachment", I[7], "FaceFrontAttachment", { CFrame = CFrame.new(0, 0, -0.6) })
					I[12] = new("Attachment", I[7], "FaceCenterAttachment")
					I[13] = new("Decal", I[7], "Decal", { TextureContent = Content.fromUri("rbxassetid://126681349608292") })
				I[14] = new("Part", I[3], "HumanoidRootPart", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(0, 3, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
					I[15] = new("Motor6D", I[14], "RootJoint", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
				I[16] = new("Part", I[3], "Left Arm", { CFrame = CFrame.new(0, 3, 1.5, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, Size = Vector3.new(1, 2, 1) })
					I[17] = new("Attachment", I[16], "LeftShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
				I[18] = new("Part", I[3], "Left Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(0, 1, 0.5, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Size = Vector3.new(1, 2, 1) })
				I[19] = new("Part", I[3], "Right Arm", { CFrame = CFrame.new(0, 3, -1.5, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, Size = Vector3.new(1, 2, 1) })
					I[20] = new("Attachment", I[19], "RightShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
				I[21] = new("Part", I[3], "Right Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(0, 1, -0.5, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Size = Vector3.new(1, 2, 1) })
				I[22] = new("Part", I[3], "Torso", { CFrame = CFrame.new(0, 3, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), Color = Color3.fromRGB(91, 93, 105), LeftSurface = Enum.SurfaceType.Weld, RightSurface = Enum.SurfaceType.Weld, Size = Vector3.new(2, 2, 1) })
					I[23] = new("Decal", I[22], "roblox")
					I[24] = new("Motor6D", I[22], "Right Shoulder", { C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
					I[25] = new("Motor6D", I[22], "Right Hip", { C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
					I[26] = new("Motor6D", I[22], "Neck", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
					I[27] = new("Motor6D", I[22], "Left Shoulder", { C0 = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
					I[28] = new("Motor6D", I[22], "Left Hip", { C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
					I[29] = new("Attachment", I[22], "WaistFrontAttachment", { CFrame = CFrame.new(0, -1, -0.5) })
					I[30] = new("Attachment", I[22], "WaistCenterAttachment", { CFrame = CFrame.new(0, -1, 0) })
					I[31] = new("Attachment", I[22], "WaistBackAttachment", { CFrame = CFrame.new(0, -1, 0.5) })
					I[32] = new("Attachment", I[22], "RightCollarAttachment", { CFrame = CFrame.new(1, 1, 0) })
					I[33] = new("Attachment", I[22], "NeckAttachment", { CFrame = CFrame.new(0, 1, 0) })
					I[34] = new("Attachment", I[22], "LeftCollarAttachment", { CFrame = CFrame.new(-1, 1, 0) })
					I[35] = new("Attachment", I[22], "BodyFrontAttachment", { CFrame = CFrame.new(0, 0, -0.5) })
					I[36] = new("Attachment", I[22], "BodyBackAttachment", { CFrame = CFrame.new(0, 0, 0.5) })
	I[3].PrimaryPart = I[14]
	I[15].Part0 = I[14]
	I[15].Part1 = I[22]
	I[24].Part0 = I[22]
	I[24].Part1 = I[19]
	I[25].Part0 = I[22]
	I[25].Part1 = I[21]
	I[26].Part0 = I[22]
	I[26].Part1 = I[7]
	I[27].Part0 = I[22]
	I[27].Part1 = I[16]
	I[28].Part0 = I[22]
	I[28].Part1 = I[18]
	return I[1]
end

return build

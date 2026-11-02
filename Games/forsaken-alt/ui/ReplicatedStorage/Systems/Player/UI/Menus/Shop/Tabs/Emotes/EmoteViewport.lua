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
				I[4] = new("BodyColors", I[3], "Body Colors", { HeadColor3 = Color3.fromRGB(163, 162, 165), LeftArmColor3 = Color3.fromRGB(163, 162, 165), LeftLegColor3 = Color3.fromRGB(27, 42, 53), RightArmColor3 = Color3.fromRGB(163, 162, 165), RightLegColor3 = Color3.fromRGB(27, 42, 53), TorsoColor3 = Color3.fromRGB(91, 93, 105) })
				I[5] = new("Humanoid", I[3], "Humanoid")
					I[6] = new("Animator", I[5], "Animator")
				I[7] = new("Part", I[3], "Right Arm", { CFrame = CFrame.new(0, 3, -1.5, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, Size = Vector3.new(1, 2, 1) })
					I[8] = new("Attachment", I[7], "RightShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
				I[9] = new("Part", I[3], "Left Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(0, 1, 0.5, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Size = Vector3.new(1, 2, 1) })
				I[10] = new("Part", I[3], "Left Arm", { CFrame = CFrame.new(0, 3, 1.5, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, Size = Vector3.new(1, 2, 1) })
					I[11] = new("Attachment", I[10], "LeftShoulderAttachment", { CFrame = CFrame.new(0, 1, 0) })
				I[12] = new("Part", I[3], "HumanoidRootPart", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(0, 3, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
					I[13] = new("Motor6D", I[12], "RootJoint", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
				I[14] = new("Part", I[3], "Head", { CFrame = CFrame.new(0, 4.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), Size = Vector3.new(2, 1, 1), TopSurface = Enum.SurfaceType.Smooth })
					I[15] = new("Decal", I[14], "Decal", { TextureContent = Content.fromUri("rbxassetid://126681349608292") })
					I[16] = new("Attachment", I[14], "FaceCenterAttachment")
					I[17] = new("Attachment", I[14], "FaceFrontAttachment", { CFrame = CFrame.new(0, 0, -0.6) })
					I[18] = new("Attachment", I[14], "HairAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
					I[19] = new("Attachment", I[14], "HatAttachment", { CFrame = CFrame.new(0, 0.6, 0) })
					I[20] = new("SpecialMesh", I[14], "Mesh", { Scale = Vector3.new(1.25, 1.25, 1.25) })
				I[21] = new("Part", I[3], "Torso", { CFrame = CFrame.new(0, 3, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), Color = Color3.fromRGB(91, 93, 105), LeftSurface = Enum.SurfaceType.Weld, RightSurface = Enum.SurfaceType.Weld, Size = Vector3.new(2, 2, 1) })
					I[22] = new("Attachment", I[21], "BodyBackAttachment", { CFrame = CFrame.new(0, 0, 0.5) })
					I[23] = new("Attachment", I[21], "BodyFrontAttachment", { CFrame = CFrame.new(0, 0, -0.5) })
					I[24] = new("Attachment", I[21], "LeftCollarAttachment", { CFrame = CFrame.new(-1, 1, 0) })
					I[25] = new("Attachment", I[21], "NeckAttachment", { CFrame = CFrame.new(0, 1, 0) })
					I[26] = new("Attachment", I[21], "RightCollarAttachment", { CFrame = CFrame.new(1, 1, 0) })
					I[27] = new("Attachment", I[21], "WaistBackAttachment", { CFrame = CFrame.new(0, -1, 0.5) })
					I[28] = new("Attachment", I[21], "WaistCenterAttachment", { CFrame = CFrame.new(0, -1, 0) })
					I[29] = new("Attachment", I[21], "WaistFrontAttachment", { CFrame = CFrame.new(0, -1, -0.5) })
					I[30] = new("Motor6D", I[21], "Left Hip", { C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
					I[31] = new("Motor6D", I[21], "Left Shoulder", { C0 = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
					I[32] = new("Motor6D", I[21], "Neck", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
					I[33] = new("Motor6D", I[21], "Right Hip", { C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
					I[34] = new("Motor6D", I[21], "Right Shoulder", { C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
					I[35] = new("Decal", I[21], "roblox")
				I[36] = new("Part", I[3], "Right Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(0, 1, -0.5, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Size = Vector3.new(1, 2, 1) })
	I[3].PrimaryPart = I[12]
	I[13].Part0 = I[12]
	I[13].Part1 = I[21]
	I[30].Part0 = I[21]
	I[30].Part1 = I[9]
	I[31].Part0 = I[21]
	I[31].Part1 = I[10]
	I[32].Part0 = I[21]
	I[32].Part1 = I[14]
	I[33].Part0 = I[21]
	I[33].Part1 = I[36]
	I[34].Part0 = I[21]
	I[34].Part1 = I[7]
	return I[1]
end

return build

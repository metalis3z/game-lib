-- Generated from map/lighting.rbxm by _tools/rbxm2lua.luau
-- Lighting pack: for _, o in require(this)() do o.Parent = game.Lighting end (Lighting properties are in Environment.lua)

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
	I[1] = new("Sky", nil, "Sky", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset/?id=153767241"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset/?id=153767216"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset/?id=153767266"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset/?id=153767200"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset/?id=153767231"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset/?id=153767288"), StarCount = 1334 })
	I[2] = new("Model", nil, "Dummies")
		I[3] = new("Model", I[2], "Dummy")
			I[4] = new("Humanoid", I[3], "Humanoid")
			I[5] = new("CharacterMesh", I[3], "CharacterMesh", { BodyPart = Enum.BodyPart.LeftArm, MeshContent = Content.fromUri("rbxassetid://27111419") })
			I[6] = new("CharacterMesh", I[3], "CharacterMesh", { BodyPart = Enum.BodyPart.RightArm, MeshContent = Content.fromUri("rbxassetid://27111864") })
			I[7] = new("CharacterMesh", I[3], "CharacterMesh", { BodyPart = Enum.BodyPart.LeftLeg, MeshContent = Content.fromUri("rbxassetid://27111857") })
			I[8] = new("CharacterMesh", I[3], "CharacterMesh", { BodyPart = Enum.BodyPart.RightLeg, MeshContent = Content.fromUri("rbxassetid://27111882") })
			I[9] = new("CharacterMesh", I[3], "CharacterMesh", { BodyPart = Enum.BodyPart.Torso, MeshContent = Content.fromUri("rbxassetid://27111894") })
			I[10] = new("Part", I[3], "HumanoidRootPart", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-10, 4.0000043, 1.2000054), EnableFluidForces = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
				I[11] = new("Motor6D", I[10], "Root Hip", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
			I[12] = new("Part", I[3], "Torso", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-10, 4.0000043, 1.2000054), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
				I[13] = new("Motor6D", I[12], "Left Hip", { C0 = CFrame.new(-1, -1, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), C1 = CFrame.new(-0.5, 1, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[14] = new("Motor6D", I[12], "Right Hip", { C0 = CFrame.new(1, -1, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), C1 = CFrame.new(0.5, 1, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[15] = new("Motor6D", I[12], "Left Shoulder", { C0 = CFrame.new(-1, 0.5, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), C1 = CFrame.new(0.5, 0.5, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[16] = new("Motor6D", I[12], "Right Shoulder", { C0 = CFrame.new(1, 0.5, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), C1 = CFrame.new(-0.5, 0.5, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[17] = new("Motor6D", I[12], "Neck", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
			I[18] = new("Part", I[3], "Left Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-10.5, 2.0000043, 1.2000054), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[19] = new("Part", I[3], "Right Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-9.5, 2.0000043, 1.2000054), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[20] = new("Part", I[3], "Left Arm", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-11.5, 4.0000043, 1.2000054), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[21] = new("Part", I[3], "Right Arm", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-8.5, 4.0000043, 1.2000054), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[22] = new("Part", I[3], "Head", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-10, 5.5000043, 1.2000054), EnableFluidForces = false, Size = Vector3.new(2, 1, 1), TopSurface = Enum.SurfaceType.Smooth })
				I[23] = new("Decal", I[22], "Face", { TextureContent = Content.fromUri("rbxasset://textures/face.png") })
				I[24] = new("SpecialMesh", I[22], "Mesh", { Scale = Vector3.new(1.25, 1.25, 1.25) })
		I[25] = new("Model", I[2], "Dummy")
			I[26] = new("Humanoid", I[25], "Humanoid")
			I[27] = new("CharacterMesh", I[25], "CharacterMesh", { BodyPart = Enum.BodyPart.LeftArm, MeshContent = Content.fromUri("rbxassetid://27111419") })
			I[28] = new("CharacterMesh", I[25], "CharacterMesh", { BodyPart = Enum.BodyPart.RightArm, MeshContent = Content.fromUri("rbxassetid://27111864") })
			I[29] = new("CharacterMesh", I[25], "CharacterMesh", { BodyPart = Enum.BodyPart.LeftLeg, MeshContent = Content.fromUri("rbxassetid://27111857") })
			I[30] = new("CharacterMesh", I[25], "CharacterMesh", { BodyPart = Enum.BodyPart.RightLeg, MeshContent = Content.fromUri("rbxassetid://27111882") })
			I[31] = new("CharacterMesh", I[25], "CharacterMesh", { BodyPart = Enum.BodyPart.Torso, MeshContent = Content.fromUri("rbxassetid://27111894") })
			I[32] = new("Part", I[25], "HumanoidRootPart", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-10, 4.0000043, -4.7999949), EnableFluidForces = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
				I[33] = new("Motor6D", I[32], "Root Hip", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
			I[34] = new("Part", I[25], "Torso", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-10, 4.0000043, -4.7999949), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
				I[35] = new("Motor6D", I[34], "Left Hip", { C0 = CFrame.new(-1, -1, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), C1 = CFrame.new(-0.5, 1, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[36] = new("Motor6D", I[34], "Right Hip", { C0 = CFrame.new(1, -1, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), C1 = CFrame.new(0.5, 1, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[37] = new("Motor6D", I[34], "Left Shoulder", { C0 = CFrame.new(-1, 0.5, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), C1 = CFrame.new(0.5, 0.5, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[38] = new("Motor6D", I[34], "Right Shoulder", { C0 = CFrame.new(1, 0.5, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), C1 = CFrame.new(-0.5, 0.5, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[39] = new("Motor6D", I[34], "Neck", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
			I[40] = new("Part", I[25], "Left Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-10.5, 2.0000043, -4.7999949), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[41] = new("Part", I[25], "Right Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-9.5, 2.0000043, -4.7999949), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[42] = new("Part", I[25], "Left Arm", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-11.5, 4.0000043, -4.7999949), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[43] = new("Part", I[25], "Right Arm", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-8.5, 4.0000043, -4.7999949), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[44] = new("Part", I[25], "Head", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-10, 5.5000043, -4.7999949), EnableFluidForces = false, Size = Vector3.new(2, 1, 1), TopSurface = Enum.SurfaceType.Smooth })
				I[45] = new("Decal", I[44], "Face", { TextureContent = Content.fromUri("rbxasset://textures/face.png") })
				I[46] = new("SpecialMesh", I[44], "Mesh", { Scale = Vector3.new(1.25, 1.25, 1.25) })
		I[47] = new("Model", I[2], "Dummy")
			I[48] = new("Humanoid", I[47], "Humanoid")
			I[49] = new("CharacterMesh", I[47], "CharacterMesh", { BodyPart = Enum.BodyPart.LeftArm, MeshContent = Content.fromUri("rbxassetid://27111419") })
			I[50] = new("CharacterMesh", I[47], "CharacterMesh", { BodyPart = Enum.BodyPart.RightArm, MeshContent = Content.fromUri("rbxassetid://27111864") })
			I[51] = new("CharacterMesh", I[47], "CharacterMesh", { BodyPart = Enum.BodyPart.LeftLeg, MeshContent = Content.fromUri("rbxassetid://27111857") })
			I[52] = new("CharacterMesh", I[47], "CharacterMesh", { BodyPart = Enum.BodyPart.RightLeg, MeshContent = Content.fromUri("rbxassetid://27111882") })
			I[53] = new("CharacterMesh", I[47], "CharacterMesh", { BodyPart = Enum.BodyPart.Torso, MeshContent = Content.fromUri("rbxassetid://27111894") })
			I[54] = new("Part", I[47], "HumanoidRootPart", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(8, 4.0000043, -4.7999949), EnableFluidForces = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
				I[55] = new("Motor6D", I[54], "Root Hip", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
			I[56] = new("Part", I[47], "Torso", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(8, 4.0000043, -4.7999949), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
				I[57] = new("Motor6D", I[56], "Left Hip", { C0 = CFrame.new(-1, -1, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), C1 = CFrame.new(-0.5, 1, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[58] = new("Motor6D", I[56], "Right Hip", { C0 = CFrame.new(1, -1, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), C1 = CFrame.new(0.5, 1, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[59] = new("Motor6D", I[56], "Left Shoulder", { C0 = CFrame.new(-1, 0.5, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), C1 = CFrame.new(0.5, 0.5, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[60] = new("Motor6D", I[56], "Right Shoulder", { C0 = CFrame.new(1, 0.5, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), C1 = CFrame.new(-0.5, 0.5, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[61] = new("Motor6D", I[56], "Neck", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
			I[62] = new("Part", I[47], "Left Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(7.5, 2.0000043, -4.7999949), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[63] = new("Part", I[47], "Right Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(8.5, 2.0000043, -4.7999949), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[64] = new("Part", I[47], "Left Arm", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(6.5, 4.0000043, -4.7999949), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[65] = new("Part", I[47], "Right Arm", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(9.5, 4.0000043, -4.7999949), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[66] = new("Part", I[47], "Head", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(8, 5.5000043, -4.7999949), EnableFluidForces = false, Size = Vector3.new(2, 1, 1), TopSurface = Enum.SurfaceType.Smooth })
				I[67] = new("Decal", I[66], "Face", { TextureContent = Content.fromUri("rbxasset://textures/face.png") })
				I[68] = new("SpecialMesh", I[66], "Mesh", { Scale = Vector3.new(1.25, 1.25, 1.25) })
		I[69] = new("Model", I[2], "Dummy")
			I[70] = new("Humanoid", I[69], "Humanoid")
			I[71] = new("CharacterMesh", I[69], "CharacterMesh", { BodyPart = Enum.BodyPart.LeftArm, MeshContent = Content.fromUri("rbxassetid://27111419") })
			I[72] = new("CharacterMesh", I[69], "CharacterMesh", { BodyPart = Enum.BodyPart.RightArm, MeshContent = Content.fromUri("rbxassetid://27111864") })
			I[73] = new("CharacterMesh", I[69], "CharacterMesh", { BodyPart = Enum.BodyPart.LeftLeg, MeshContent = Content.fromUri("rbxassetid://27111857") })
			I[74] = new("CharacterMesh", I[69], "CharacterMesh", { BodyPart = Enum.BodyPart.RightLeg, MeshContent = Content.fromUri("rbxassetid://27111882") })
			I[75] = new("CharacterMesh", I[69], "CharacterMesh", { BodyPart = Enum.BodyPart.Torso, MeshContent = Content.fromUri("rbxassetid://27111894") })
			I[76] = new("Part", I[69], "HumanoidRootPart", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(8, 4.0000043, 2.2000039), EnableFluidForces = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
				I[77] = new("Motor6D", I[76], "Root Hip", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
			I[78] = new("Part", I[69], "Torso", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(8, 4.0000043, 2.2000039), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
				I[79] = new("Motor6D", I[78], "Left Hip", { C0 = CFrame.new(-1, -1, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), C1 = CFrame.new(-0.5, 1, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[80] = new("Motor6D", I[78], "Right Hip", { C0 = CFrame.new(1, -1, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), C1 = CFrame.new(0.5, 1, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[81] = new("Motor6D", I[78], "Left Shoulder", { C0 = CFrame.new(-1, 0.5, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), C1 = CFrame.new(0.5, 0.5, 0, -0.0000001, 0, -1.0000001, 0, 1, 0, 1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[82] = new("Motor6D", I[78], "Right Shoulder", { C0 = CFrame.new(1, 0.5, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), C1 = CFrame.new(-0.5, 0.5, 0, -0.0000001, 0, 1.0000001, 0, 1, 0, -1.0000001, 0, -0.0000001), MaxVelocity = 0.1 })
				I[83] = new("Motor6D", I[78], "Neck", { C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
			I[84] = new("Part", I[69], "Left Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(7.5, 2.0000043, 2.2000039), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[85] = new("Part", I[69], "Right Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(8.5, 2.0000043, 2.2000039), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[86] = new("Part", I[69], "Left Arm", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(6.5, 4.0000043, 2.2000039), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[87] = new("Part", I[69], "Right Arm", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(9.5, 4.0000043, 2.2000039), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1, 2, 1), TopSurface = Enum.SurfaceType.Smooth })
			I[88] = new("Part", I[69], "Head", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(8, 5.5000043, 2.2000039), EnableFluidForces = false, Size = Vector3.new(2, 1, 1), TopSurface = Enum.SurfaceType.Smooth })
				I[89] = new("Decal", I[88], "Face", { TextureContent = Content.fromUri("rbxasset://textures/face.png") })
				I[90] = new("SpecialMesh", I[88], "Mesh", { Scale = Vector3.new(1.25, 1.25, 1.25) })
	I[11].Part0 = I[10]
	I[11].Part1 = I[12]
	I[13].Part0 = I[12]
	I[13].Part1 = I[18]
	I[14].Part0 = I[12]
	I[14].Part1 = I[19]
	I[15].Part0 = I[12]
	I[15].Part1 = I[20]
	I[16].Part0 = I[12]
	I[16].Part1 = I[21]
	I[17].Part0 = I[12]
	I[17].Part1 = I[22]
	I[33].Part0 = I[32]
	I[33].Part1 = I[34]
	I[35].Part0 = I[34]
	I[35].Part1 = I[40]
	I[36].Part0 = I[34]
	I[36].Part1 = I[41]
	I[37].Part0 = I[34]
	I[37].Part1 = I[42]
	I[38].Part0 = I[34]
	I[38].Part1 = I[43]
	I[39].Part0 = I[34]
	I[39].Part1 = I[44]
	I[55].Part0 = I[54]
	I[55].Part1 = I[56]
	I[57].Part0 = I[56]
	I[57].Part1 = I[62]
	I[58].Part0 = I[56]
	I[58].Part1 = I[63]
	I[59].Part0 = I[56]
	I[59].Part1 = I[64]
	I[60].Part0 = I[56]
	I[60].Part1 = I[65]
	I[61].Part0 = I[56]
	I[61].Part1 = I[66]
	I[77].Part0 = I[76]
	I[77].Part1 = I[78]
	I[79].Part0 = I[78]
	I[79].Part1 = I[84]
	I[80].Part0 = I[78]
	I[80].Part1 = I[85]
	I[81].Part0 = I[78]
	I[81].Part1 = I[86]
	I[82].Part0 = I[78]
	I[82].Part1 = I[87]
	I[83].Part0 = I[78]
	I[83].Part1 = I[88]
	return { I[1], I[2] }
end

return build

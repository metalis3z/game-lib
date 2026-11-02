-- Generated from ui/ReplicatedStorage/Assets/Skins/Killers/c00lkidd/GourdC00l/Behavior/ScreenGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ScreenGui", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("SurfaceGui", I[1], "SurfaceGui", { AlwaysOnTop = true, ClipsDescendants = true, Face = Enum.NormalId.Left, LightInfluence = 1, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
			I[3] = new("ViewportFrame", I[2], "ViewportFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
				I[4] = new("WorldModel", I[3], "WorldModel")
					I[5] = new("Model", I[4], "Rig")
						I[6] = new("Humanoid", I[5], "Humanoid", { HealthDisplayDistance = 0, HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff, JumpHeight = 8.0733461, JumpPower = 56.0649033, NameDisplayDistance = 0, WalkSpeed = 17.9407692 })
							I[7] = new("Animator", I[6], "Animator")
						I[8] = new("Model", I[5], "PHONE")
							I[9] = new("MeshPart", I[8], "Phone Hang", { CFrame = CFrame.new(38.4120712, 2.9473832, -194.3557129, 0.7857771, -0.5588307, 0.2650712, 0.595211, 0.7997337, -0.0784218, -0.1681618, 0.2193954, 0.9610345), PivotOffset = CFrame.new(0.2805614, 0.1854992, -0.0053892, -0.5952277, 0.1681703, 0.7857625, -0.7997204, -0.219418, -0.5588408, 0.07843, -0.9610279, 0.2650928), Size = Vector3.new(1.6741447, 2.1087711, 0.8471559), TextureContent = Content.fromUri("rbxassetid://91045404281958") })
							I[10] = new("MeshPart", I[8], "Phone Down", { CFrame = CFrame.new(37.9423409, 2.4328442, -194.1296082, -1, 0, 0, 0, 1, 0, 0, 0, -1), PivotOffset = CFrame.new(0.0015106, -0.3324282, 0.2564201), Size = Vector3.new(2.4519958, 0.7965999, 0.6393051), TextureContent = Content.fromUri("rbxassetid://131602644616098") })
							I[11] = new("MeshPart", I[8], "Phone Base", { CFrame = CFrame.new(37.944355, 1.8799191, -194.4723663, -1, 0, 0, 0, 1, 0, 0, 0, -1), PivotOffset = CFrame.new(0.0034943, 0.2204968, -0.0863304), Size = Vector3.new(1.3479919, 1.25741, 1.4113998), TextureContent = Content.fromUri("rbxassetid://131602644616098") })
								I[12] = new("Motor6D", I[11], "Phone Down", { C0 = CFrame.new(0.0020142, 0.7529252, -0.3427505), C1 = CFrame.new(0, 0.2, 0) })
								I[13] = new("Motor6D", I[11], "Phone Hang", { C0 = CFrame.new(-0.7677002, 1.3674676, -0.1166534, -0.7857771, 0.5588307, -0.2650712, 0.595211, 0.7997337, -0.0784218, 0.1681618, -0.2193954, -0.9610345), C1 = CFrame.new(0.414287, 0.0722813, 0.055986) })
						I[14] = new("Model", I[5], "PumpkinCoolkidd-Assembly")
							I[15] = new("MeshPart", I[14], "LeftLeg", { CFrame = CFrame.new(38.5989151, -0.1319023, -192.5510864), PivotOffset = CFrame.new(0.0005779, -0.6000177, 0.214288, 1, 0, 0, 0, 0, -1, 0, 1, 0), Size = Vector3.new(1.2106984, 2.2398379, 1.741942), TextureContent = Content.fromUri("rbxassetid://76724451434055") })
								I[16] = new("WeldConstraint", I[15], "WeldConstraint")
							I[17] = new("MeshPart", I[14], "LeftArm", { CFrame = CFrame.new(37.4693909, 1.9546236, -192.3339539), Size = Vector3.new(1.2713351, 2.411303, 1.2499671), TextureContent = Content.fromUri("rbxassetid://99719595537408") })
								I[18] = new("WeldConstraint", I[17], "WeldConstraint")
							I[19] = new("MeshPart", I[14], "RightLeg", { CFrame = CFrame.new(39.6828384, -0.1319023, -192.5510864), PivotOffset = CFrame.new(-0.000578, -0.6000177, 0.214288, 1, 0, 0, 0, 0, -1, 0, 1, 0), Size = Vector3.new(1.2106984, 2.2398381, 1.7419423), TextureContent = Content.fromUri("rbxassetid://89671264295878") })
								I[20] = new("WeldConstraint", I[19], "WeldConstraint")
							I[21] = new("MeshPart", I[14], "RightArm", { CFrame = CFrame.new(40.8123627, 1.9546236, -192.3339539), PivotOffset = CFrame.new(-0.0064822, -0.4158246, -0.0132496, 1, 0, 0, 0, 0, -1, 0, 1, 0), Size = Vector3.new(1.2713352, 2.411303, 1.2499671), TextureContent = Content.fromUri("rbxassetid://99719595537408") })
								I[22] = new("WeldConstraint", I[21], "WeldConstraint")
							I[23] = new("MeshPart", I[14], "Torso", { CFrame = CFrame.new(39.1408768, 2.0588696, -192.2857208), PivotOffset = CFrame.new(0, -0.0000024, -0.0000619, 1, 0, 0, 0, 0, -1, 0, 1, 0), Size = Vector3.new(2.2919929, 2.2216039, 1.2452737), TextureContent = Content.fromUri("rbxassetid://97377503942915") })
								I[24] = new("WeldConstraint", I[23], "WeldConstraint")
							I[25] = new("MeshPart", I[14], "PumpkinHead", { CFrame = CFrame.new(39.1408768, 3.9672847, -192.2974548), PivotOffset = CFrame.new(0.0000187, 0.0187616, -0.2580894, 1, 0, 0, 0, -0.0000001, -1.0000001, 0, 1.0000001, -0.0000001), Size = Vector3.new(1.8233873, 1.6647851, 1.8940332), TextureContent = Content.fromUri("rbxassetid://124361655555537") })
						I[26] = new("Part", I[5], "HumanoidRootPart", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(39.1409988, 2.0999985, -192.2859955), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(2.2425961, 2.2425961, 1.1212981), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
							I[27] = new("Motor6D", I[26], "Phone Base", { C0 = CFrame.new(-1.1966438, -0.2200794, -2.1863708, -1, 0, 0, 0, 1, 0, 0, 0, -1) })
							I[28] = new("Motor6D", I[26], "BasicSlash2", { C0 = CFrame.new(-0.1870651, -0.7998397, -1.3729572, 0.9554999, -0.2949913, 0, -0.2949913, -0.9554999, 0, 0, 0, -1) })
							I[29] = new("Motor6D", I[26], "RootJoint", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
							I[30] = new("Attachment", I[26], "RootAttachment")
							I[31] = new("Motor6D", I[26], "NORMAL", { C0 = CFrame.new(-5.4410019, 1.9000007, -3.9140015) })
							I[32] = new("Motor6D", I[26], "PURPLE", { C0 = CFrame.new(-6.7410011, 1.9000007, -3.9140015) })
							I[33] = new("Motor6D", I[26], "POP UP", { C0 = CFrame.new(8.7373161, 2.963953, -4.1782379) })
							I[34] = new("Motor6D", I[26], "TEXTTT2", { C0 = CFrame.new(10.6589966, 6.1999998, -6.4640045) })
							I[35] = new("Motor6D", I[26], "TEXTTT", { C0 = CFrame.new(10.6589966, -0.5000005, -6.4640045) })
						I[36] = new("Part", I[5], "Right Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(39.7016487, -0.1425977, -192.2859955), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1.1212981, 2.2425961, 1.1212981), Transparency = 1 })
							I[37] = new("Attachment", I[36], "RightFootAttachment", { CFrame = CFrame.new(0, -1.1212981, 0) })
						I[38] = new("Part", I[5], "Left Leg", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(38.580349, -0.1425977, -192.2859955), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1.1212981, 2.2425961, 1.1212981), Transparency = 1 })
							I[39] = new("Attachment", I[38], "LeftFootAttachment", { CFrame = CFrame.new(0, -1.1212981, 0) })
						I[40] = new("Part", I[5], "Right Arm", { CFrame = CFrame.new(40.8229446, 2.0999985, -192.2859955), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1.1212981, 2.2425961, 1.1212981), Transparency = 1 })
							I[41] = new("Attachment", I[40], "RightGripAttachment", { CFrame = CFrame.new(0, -1.1212981, 0) })
							I[42] = new("Attachment", I[40], "RightShoulderAttachment", { CFrame = CFrame.new(0, 1.1212981, 0) })
						I[43] = new("Part", I[5], "Left Arm", { CFrame = CFrame.new(37.459053, 2.0999985, -192.2859955), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(1.1212981, 2.2425961, 1.1212981), Transparency = 1 })
							I[44] = new("Motor6D", I[43], "firebrand", { C0 = CFrame.new(-0.3634033, -0.6787689, -5.9518623, 0.0000811, -0.0000811, -1, 1, -0.0000811, 0.0000811, -0.0000811, -1, 0.0000811) })
							I[45] = new("Motor6D", I[43], "firebrand", { C0 = CFrame.new(-0.4847641, -0.8218207, -5.8694725, 0, 1, 0, 1, 0, 0, 0, 0, -1), C1 = CFrame.new(-0.0000008, -0.3513288, -0.0263171, 1, 0, 0, 0, -0.0000001, 1.0000001, 0, -1.0000001, -0.0000001) })
							I[46] = new("Attachment", I[43], "LeftGripAttachment", { CFrame = CFrame.new(0, -1.1212981, 0) })
							I[47] = new("Attachment", I[43], "LeftShoulderAttachment", { CFrame = CFrame.new(0, 1.1212981, 0) })
						I[48] = new("Part", I[5], "Torso", { CFrame = CFrame.new(39.1409988, 2.0999985, -192.2859955), Color = Color3.fromRGB(99, 95, 98), EnableFluidForces = false, LeftSurface = Enum.SurfaceType.Weld, RightSurface = Enum.SurfaceType.Weld, Size = Vector3.new(2.2425961, 2.2425961, 1.1212981), Transparency = 1 })
							I[49] = new("Motor6D", I[48], "Neck", { C0 = CFrame.new(0, 1.1212981, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), C1 = CFrame.new(0, -0.560649, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), MaxVelocity = 0.1 })
							I[50] = new("Motor6D", I[48], "Left Hip", { C0 = CFrame.new(-1.1212981, -1.1212981, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(-0.560649, 1.1212981, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
							I[51] = new("Motor6D", I[48], "Right Hip", { C0 = CFrame.new(1.1212981, -1.1212981, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.560649, 1.1212981, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
							I[52] = new("Motor6D", I[48], "Left Shoulder", { C0 = CFrame.new(-1.1212981, 0.560649, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFrame.new(0.560649, 0.560649, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), MaxVelocity = 0.1 })
							I[53] = new("Motor6D", I[48], "Right Shoulder", { C0 = CFrame.new(1.1212981, 0.560649, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.560649, 0.560649, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), MaxVelocity = 0.1 })
							I[54] = new("Attachment", I[48], "WaistBackAttachment", { CFrame = CFrame.new(0, -1.1212981, 0.560649) })
							I[55] = new("Attachment", I[48], "WaistCenterAttachment", { CFrame = CFrame.new(0, -1.1212981, 0) })
							I[56] = new("Attachment", I[48], "WaistFrontAttachment", { CFrame = CFrame.new(0, -1.1212981, -0.560649) })
							I[57] = new("Attachment", I[48], "RightCollarAttachment", { CFrame = CFrame.new(1.1212981, 1.1212981, 0) })
							I[58] = new("Attachment", I[48], "LeftCollarAttachment", { CFrame = CFrame.new(-1.1212981, 1.1212981, 0) })
							I[59] = new("Attachment", I[48], "BodyBackAttachment", { CFrame = CFrame.new(0, 0, 0.560649) })
							I[60] = new("Attachment", I[48], "BodyFrontAttachment", { CFrame = CFrame.new(0, 0, -0.560649) })
							I[61] = new("Attachment", I[48], "NeckAttachment", { CFrame = CFrame.new(0, 1.1212981, 0) })
						I[62] = new("Part", I[5], "Head", { CFrame = CFrame.new(39.1409988, 3.7819457, -192.2859955), EnableFluidForces = false, Size = Vector3.new(2.2425961, 1.1212981, 1.1212981), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
							I[63] = new("Attachment", I[62], "FaceCenterAttachment")
							I[64] = new("Attachment", I[62], "FaceFrontAttachment", { CFrame = CFrame.new(0, 0, -0.6727788) })
							I[65] = new("Attachment", I[62], "HatAttachment", { CFrame = CFrame.new(0, 0.6727788, 0) })
							I[66] = new("Attachment", I[62], "HairAttachment", { CFrame = CFrame.new(0, 0.6727788, 0) })
							I[67] = new("SpecialMesh", I[62], "Mesh", { Scale = Vector3.new(1.25, 1.25, 1.25) })
							I[68] = new("Weld", I[62], "PumpkinHead", { C0 = CFrame.new(-0.0001221, 0.185339, -0.0114594) })
						I[69] = new("MeshPart", I[5], "firebrand", { CFrame = CFrame.new(36.9479713, 1.2781785, -198.5067902, 0, -0.0000001, -1.0000001, 1, 0, 0, 0, -1.0000001, 0.0000001), PivotOffset = CFrame.new(0.0159453, -2.7263324, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0), Size = Vector3.new(1.3776116, 6.1355839, 0.3374901), TextureContent = Content.fromUri("rbxassetid://89389045128867"), Transparency = 1 })
							I[70] = new("Sound", I[69], "Lunge", { RollOffMaxDistance = 9177.1796875, RollOffMinDistance = 9.1771793, Volume = 0.6 })
							I[71] = new("MeshPart", I[69], "Sword-Decor", { CFrame = CFrame.new(37.0956497, 1.4212296, -198.237854, 0.0000811, -0.0000811, -1, 1, -0.0000811, 0.0000811, -0.0000811, -1, 0.0000811), PivotOffset = CFrame.new(-0.1271134, -2.4573925, 0.147671, -1, 0, 0, 0, 0, -1, 0, -1, 0), Size = Vector3.new(0.8694044, 5.0352325, 0.7425824), TextureContent = Content.fromUri("rbxassetid://89389045128867"), Transparency = 1 })
						I[72] = new("Part", I[5], "PURPLE", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(32.3999977, 3.999999, -196.1999969), Size = Vector3.new(1.2, 1.2, 1.2), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
							I[73] = new("Decal", I[72], "Decal", { TextureContent = Content.fromUri("rbxassetid://119453937873671") })
						I[74] = new("Part", I[5], "NORMAL", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(33.6999969, 3.999999, -196.1999969), Size = Vector3.new(1.2, 1.2, 1.2), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
							I[75] = new("Decal", I[74], "Decal", { TextureContent = Content.fromUri("rbxassetid://88138827233063") })
						I[76] = new("MeshPart", I[5], "POP UP", { CFrame = CFrame.new(47.878315, 5.0639515, -196.4642334), PivotOffset = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0, -1, 0, 1, 0), Size = Vector3.new(12.1566563, 10.127903, 4.8714924), TextureContent = Content.fromUri("rbxassetid://129025149977807") })
							I[77] = new("Weld", I[76], "VOID", { C0 = CFrame.new(1.9266396, -0.3098445, -0.5551147) })
						I[78] = new("MeshPart", I[5], "VOID", { CFrame = CFrame.new(49.8049545, 4.754107, -197.0193481), Color = Color3.fromRGB(148, 147, 150), Material = Enum.Material.Neon, PivotOffset = CFrame.new(-1.9266416, 0.3098454, 0.5551356, 1, 0, 0, 0, 0, -1, 0, 1, 0), Size = Vector3.new(8.1132879, 7.9883895, 3.7612205) })
						I[79] = new("Part", I[5], "TEXTTT", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(49.7999954, 1.599998, -198.75), Size = Vector3.new(7.9179478, 1.7833332, 0.5461538), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
							I[80] = new("Model", I[79], "ThreeDTextObject")
								I[81] = new("MeshPart", I[80], "uni0054", { CFrame = CFrame.new(53.4255562, 1.3874555, -198.8230743), CanCollide = false, Color = Color3.fromRGB(255, 175, 135), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.6082385, 0.7196256, 0.1) })
								I[82] = new("MeshPart", I[80], "uni0052", { CFrame = CFrame.new(52.7438812, 1.3874555, -198.8230743), CanCollide = false, Color = Color3.fromRGB(255, 175, 135), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.5843434, 0.7196256, 0.1) })
								I[83] = new("MeshPart", I[80], "uni0041", { CFrame = CFrame.new(52.0537682, 1.3874555, -198.8230743), CanCollide = false, Color = Color3.fromRGB(255, 175, 135), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.7171659, 0.7196256, 0.1) })
								I[84] = new("MeshPart", I[80], "uni004E", { CFrame = CFrame.new(51.311306, 1.3874555, -198.8230743), CanCollide = false, Color = Color3.fromRGB(255, 175, 135), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.6124545, 0.7196256, 0.1) })
								I[85] = new("MeshPart", I[80], "uni0053", { CFrame = CFrame.new(50.6238747, 1.3878145, -198.8230743), CanCollide = false, Color = Color3.fromRGB(255, 175, 135), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.5860147, 0.738562, 0.1) })
								I[86] = new("MeshPart", I[80], "uni004D", { CFrame = CFrame.new(49.8402557, 1.3874555, -198.8230743), CanCollide = false, Color = Color3.fromRGB(255, 175, 135), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.8046594, 0.7196256, 0.1) })
								I[87] = new("MeshPart", I[80], "uni0049", { CFrame = CFrame.new(49.2420311, 1.3874555, -198.8230743), CanCollide = false, Color = Color3.fromRGB(255, 175, 135), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.1739327, 0.7196256, 0.1) })
								I[88] = new("MeshPart", I[80], "uni0053", { CFrame = CFrame.new(48.7738609, 1.3878145, -198.8230743), CanCollide = false, Color = Color3.fromRGB(255, 175, 135), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.5860147, 0.738562, 0.1) })
								I[89] = new("MeshPart", I[80], "uni0053", { CFrame = CFrame.new(48.1202965, 1.3878145, -198.8230743), CanCollide = false, Color = Color3.fromRGB(255, 175, 135), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.5860147, 0.738562, 0.1) })
								I[90] = new("MeshPart", I[80], "uni0049", { CFrame = CFrame.new(47.6520386, 1.3874555, -198.8230743), CanCollide = false, Color = Color3.fromRGB(255, 175, 135), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.1739327, 0.7196256, 0.1) })
								I[91] = new("MeshPart", I[80], "uni004F", { CFrame = CFrame.new(47.1203995, 1.3874526, -198.8230743), CanCollide = false, Color = Color3.fromRGB(255, 175, 135), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.68688, 0.7392627, 0.1) })
								I[92] = new("MeshPart", I[80], "uni004E", { CFrame = CFrame.new(46.369503, 1.3874555, -198.8230743), CanCollide = false, Color = Color3.fromRGB(255, 175, 135), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.6124545, 0.7196256, 0.1) })
							I[93] = new("Weld", I[79], "uni0041", { C0 = CFrame.new(2.2537727, -0.2125425, -0.0730743) })
							I[94] = new("Weld", I[79], "uni0049", { C0 = CFrame.new(-0.5579643, -0.2125425, -0.0730743) })
							I[95] = new("Weld", I[79], "uni0049", { C0 = CFrame.new(-2.1479568, -0.2125425, -0.0730743) })
							I[96] = new("Weld", I[79], "uni004D", { C0 = CFrame.new(0.0402603, -0.2125425, -0.0730743) })
							I[97] = new("Weld", I[79], "uni004E", { C0 = CFrame.new(1.5113106, -0.2125425, -0.0730743) })
							I[98] = new("Weld", I[79], "uni004E", { C0 = CFrame.new(-3.4304924, -0.2125425, -0.0730743) })
							I[99] = new("Weld", I[79], "uni004F", { C0 = CFrame.new(-2.6795959, -0.2125454, -0.0730743) })
							I[100] = new("Weld", I[79], "uni0052", { C0 = CFrame.new(2.9438858, -0.2125425, -0.0730743) })
							I[101] = new("Weld", I[79], "uni0053", { C0 = CFrame.new(0.8238792, -0.2121835, -0.0730743) })
							I[102] = new("Weld", I[79], "uni0053", { C0 = CFrame.new(-1.0261345, -0.2121835, -0.0730743) })
							I[103] = new("Weld", I[79], "uni0053", { C0 = CFrame.new(-1.6796989, -0.2121835, -0.0730743) })
							I[104] = new("Weld", I[79], "uni0054", { C0 = CFrame.new(3.6255608, -0.2125425, -0.0730743) })
						I[105] = new("Part", I[5], "TEXTTT2", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(49.7999954, 8.2999983, -198.75), Size = Vector3.new(7.9179478, 1.7833332, 0.5461538), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
							I[106] = new("Model", I[105], "ThreeDTextObject")
								I[107] = new("MeshPart", I[106], "uni0049", { CFrame = CFrame.new(53.4529114, 8.0608578, -198.8295288), CanCollide = false, Color = Color3.fromRGB(255, 160, 96), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.257678, 1.066112, 0.1) })
								I[108] = new("MeshPart", I[106], "uni004E", { CFrame = CFrame.new(52.7090263, 8.0608578, -198.8295288), CanCollide = false, Color = Color3.fromRGB(255, 160, 96), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.90734, 1.066112, 0.1) })
								I[109] = new("MeshPart", I[106], "uni0043", { CFrame = CFrame.new(51.6158371, 8.0607338, -198.8295288), CanCollide = false, Color = Color3.fromRGB(255, 160, 96), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.979156, 1.094974, 0.1) })
								I[110] = new("MeshPart", I[106], "uni004F", { CFrame = CFrame.new(50.4820595, 8.060854, -198.8295288), CanCollide = false, Color = Color3.fromRGB(255, 160, 96), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(1.0176001, 1.095204, 0.1) })
								I[111] = new("MeshPart", I[106], "uni004D", { CFrame = CFrame.new(49.2272491, 8.0608578, -198.8295288), CanCollide = false, Color = Color3.fromRGB(255, 160, 96), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(1.192088, 1.066112, 0.1) })
								I[112] = new("MeshPart", I[106], "uni0049", { CFrame = CFrame.new(48.340992, 8.0608578, -198.8295288), CanCollide = false, Color = Color3.fromRGB(255, 160, 96), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.257678, 1.066112, 0.1) })
								I[113] = new("MeshPart", I[106], "uni004E", { CFrame = CFrame.new(47.5971069, 8.0608578, -198.8295288), CanCollide = false, Color = Color3.fromRGB(255, 160, 96), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.90734, 1.066112, 0.1) })
								I[114] = new("MeshPart", I[106], "uni0047", { CFrame = CFrame.new(46.5017891, 8.0610113, -198.8295288), CanCollide = false, Color = Color3.fromRGB(255, 160, 96), Material = Enum.Material.SmoothPlastic, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.98323, 1.09523, 0.1) })
							I[115] = new("Weld", I[105], "uni0043", { C0 = CFrame.new(1.8158417, -0.2392645, -0.0795288) })
							I[116] = new("Weld", I[105], "uni0049", { C0 = CFrame.new(3.652916, -0.2391405, -0.0795288) })
							I[117] = new("Weld", I[105], "uni0047", { C0 = CFrame.new(-3.2982063, -0.238987, -0.0795288) })
							I[118] = new("Weld", I[105], "uni0049", { C0 = CFrame.new(-1.4590034, -0.2391405, -0.0795288) })
							I[119] = new("Weld", I[105], "uni004D", { C0 = CFrame.new(-0.5727463, -0.2391405, -0.0795288) })
							I[120] = new("Weld", I[105], "uni004E", { C0 = CFrame.new(2.9090309, -0.2391405, -0.0795288) })
							I[121] = new("Weld", I[105], "uni004E", { C0 = CFrame.new(-2.2028885, -0.2391405, -0.0795288) })
							I[122] = new("Weld", I[105], "uni004F", { C0 = CFrame.new(0.6820641, -0.2391443, -0.0795288) })
	I[5].PrimaryPart = I[26]
	I[12].Part0 = I[11]
	I[12].Part1 = I[10]
	I[13].Part0 = I[11]
	I[13].Part1 = I[9]
	I[14].PrimaryPart = I[23]
	I[16].Part0 = I[38]
	I[16].Part1 = I[15]
	I[18].Part0 = I[43]
	I[18].Part1 = I[17]
	I[20].Part0 = I[36]
	I[20].Part1 = I[19]
	I[22].Part0 = I[40]
	I[22].Part1 = I[21]
	I[24].Part0 = I[48]
	I[24].Part1 = I[23]
	I[27].Part0 = I[26]
	I[27].Part1 = I[11]
	I[28].Part0 = I[26]
	I[29].Part0 = I[26]
	I[29].Part1 = I[48]
	I[31].Part0 = I[26]
	I[31].Part1 = I[74]
	I[32].Part0 = I[26]
	I[32].Part1 = I[72]
	I[33].Part0 = I[26]
	I[33].Part1 = I[76]
	I[34].Part0 = I[26]
	I[34].Part1 = I[105]
	I[35].Part0 = I[26]
	I[35].Part1 = I[79]
	I[44].Part0 = I[43]
	I[44].Part1 = I[71]
	I[45].Part0 = I[43]
	I[45].Part1 = I[69]
	I[49].Part0 = I[48]
	I[49].Part1 = I[62]
	I[50].Part0 = I[48]
	I[50].Part1 = I[38]
	I[51].Part0 = I[48]
	I[51].Part1 = I[36]
	I[52].Part0 = I[48]
	I[52].Part1 = I[43]
	I[53].Part0 = I[48]
	I[53].Part1 = I[40]
	I[68].Part0 = I[62]
	I[68].Part1 = I[25]
	I[77].Part0 = I[76]
	I[77].Part1 = I[78]
	I[93].Part0 = I[79]
	I[93].Part1 = I[83]
	I[94].Part0 = I[79]
	I[94].Part1 = I[87]
	I[95].Part0 = I[79]
	I[95].Part1 = I[90]
	I[96].Part0 = I[79]
	I[96].Part1 = I[86]
	I[97].Part0 = I[79]
	I[97].Part1 = I[84]
	I[98].Part0 = I[79]
	I[98].Part1 = I[92]
	I[99].Part0 = I[79]
	I[99].Part1 = I[91]
	I[100].Part0 = I[79]
	I[100].Part1 = I[82]
	I[101].Part0 = I[79]
	I[101].Part1 = I[85]
	I[102].Part0 = I[79]
	I[102].Part1 = I[88]
	I[103].Part0 = I[79]
	I[103].Part1 = I[89]
	I[104].Part0 = I[79]
	I[104].Part1 = I[81]
	I[115].Part0 = I[105]
	I[115].Part1 = I[109]
	I[116].Part0 = I[105]
	I[116].Part1 = I[107]
	I[117].Part0 = I[105]
	I[117].Part1 = I[114]
	I[118].Part0 = I[105]
	I[118].Part1 = I[112]
	I[119].Part0 = I[105]
	I[119].Part1 = I[111]
	I[120].Part0 = I[105]
	I[120].Part1 = I[108]
	I[121].Part0 = I[105]
	I[121].Part1 = I[113]
	I[122].Part0 = I[105]
	I[122].Part1 = I[110]
	return I[1]
end

return build

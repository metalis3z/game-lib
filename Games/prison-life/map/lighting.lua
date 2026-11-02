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
	I[1] = new("Sky", nil, "Sky", { SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset/?id=150553096"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset/?id=150553062"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset/?id=150553119"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset/?id=150553049"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset/?id=150553079"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset/?id=150553131"), StarCount = 1334 })
	I[2] = new("Model", nil, "MP5 ($3k)")
		I[3] = new("Humanoid", I[2], "Humanoid", { MaxHealth = 0 })
		I[4] = new("ClickDetector", I[2], "ClickDetector")
		I[5] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8653564, 132.4488983, -865.5280151, 0.0000312, 0.0000305, 0.9999953, 0.0000305, 0.9999955, -0.0000305, -1, 0.0000305, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[6] = new("ManualWeld", I[5], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-1.4100037, -0.1135101, 0.1402588, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[7] = new("BlockMesh", I[5], "Mesh", { Scale = Vector3.new(0.75, 1, 0.75) })
		I[8] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8652954, 132.6839447, -865.6481934, 0.9999953, 0.0000305, -0.0000311, -0.0000305, 0.9999955, -0.0000305, 0.0000312, 0.0000305, 1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[9] = new("ManualWeld", I[8], "Weld", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, -0.0000001, 0, -1), C1 = CFrame.new(-1.289917, 0.1135101, 0.0794067, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[10] = new("SpecialMesh", I[8], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.35, 0.15, 0.45) })
		I[11] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8653564, 132.4739075, -865.3030396, 0.0000305, -0.0000312, 0.9999953, 0.9999955, -0.0000305, -0.0000305, 0.0000305, 1, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[12] = new("ManualWeld", I[11], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, -1, -1, 0, 0), C1 = CFrame.new(-1.6350098, -0.0893555, 0.1337891, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[13] = new("CylinderMesh", I[11], "Mesh", { Scale = Vector3.new(0.75, 0.5, 0.75) })
		I[14] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8653564, 132.6439209, -865.6781006, 0.0000312, 0.0000305, 0.9999953, 0.0000305, 0.9999955, -0.0000305, -1, 0.0000305, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[15] = new("ManualWeld", I[14], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-1.2599792, 0.0748596, 0.0897827, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[16] = new("BlockMesh", I[14], "Mesh", { Scale = Vector3.new(0.75, 0.25, 0.45) })
		I[17] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9053345, 132.6889343, -865.7080688, 0.9999953, 0.0000305, -0.0000312, -0.0000305, 0.9999955, -0.0000305, 0.0000312, 0.0000305, 1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[18] = new("ManualWeld", I[17], "Weld", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1), C1 = CFrame.new(-1.230011, 0.1286774, 0.1167603, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[19] = new("SpecialMesh", I[17], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.05, 0.2, 0.45) })
		I[20] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8251953, 132.6839752, -865.6156006, 0.0000312, 0.0000305, 0.9999953, 0.0000305, 0.9999955, -0.0000305, -1, 0.0000305, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[21] = new("ManualWeld", I[20], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-1.3224792, 0.1031494, 0.0407104, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[22] = new("BlockMesh", I[20], "Mesh", { Scale = Vector3.new(0.125, 0.15, 0.05) })
		I[23] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8653564, 132.5238953, -865.328064, -0.9999953, 0.0000305, 0.0000312, 0.0000305, 0.9999955, 0.0000305, -0.0000312, 0.0000305, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[24] = new("ManualWeld", I[23], "Weld", { C1 = CFrame.new(-1.6099548, -0.0410614, 0.1208496, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[25] = new("SpecialMesh", I[23], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.75, 0.25, 0.25) })
		I[26] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8653564, 132.4989166, -865.3030396, 0.0000305, -0.0000312, 0.9999953, 0.9999955, -0.0000305, -0.0000305, 0.0000305, 1, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.25), TopSurface = Enum.SurfaceType.Smooth })
			I[27] = new("ManualWeld", I[26], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, -1, -1, 0, 0), C1 = CFrame.new(-1.6350098, -0.0652008, 0.1273193, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[28] = new("SpecialMesh", I[26], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=1033714"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(0.105, 0.15, 0.105) })
		I[29] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8252563, 132.6964874, -865.6456299, -0.0000312, -0.9999953, -0.0000305, -0.0000305, 0.0000305, -0.9999955, 1, -0.0000312, -0.0000305), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[30] = new("ManualWeld", I[29], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, -1, 1, 0, 0, 0, -1, 0), C1 = CFrame.new(-1.292511, 0.1152344, 0.0374756, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[31] = new("BlockMesh", I[29], "Mesh", { Scale = Vector3.new(0.175, 0.05, 0.275) })
		I[32] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8251343, 132.6989746, -865.6281738, -0.0000312, -0.9999953, -0.0000305, -0.0000305, 0.0000305, -0.9999955, 1, -0.0000312, -0.0000305), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[33] = new("ManualWeld", I[32], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, -1, 1, 0, 0, 0, -1, 0), C1 = CFrame.new(-1.309967, 0.11763, 0.0368042, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[34] = new("CylinderMesh", I[32], "Mesh", { Scale = Vector3.new(0.25, 0.05, 0.3) })
		I[35] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9052124, 132.6989441, -865.6281128, -0.0000312, -0.9999953, -0.0000305, -0.0000305, 0.0000305, -0.9999955, 1, -0.0000312, -0.0000305), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[36] = new("ManualWeld", I[35], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, -1, 1, 0, 0, 0, -1, 0), C1 = CFrame.new(-1.309967, 0.1383362, 0.1141357, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[37] = new("CylinderMesh", I[35], "Mesh", { Scale = Vector3.new(0.25, 0.05, 0.3) })
		I[38] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8652344, 132.0834503, -865.9224854, 0.0000214, 0.0000381, -0.9999953, 0.9659135, 0.2588474, 0.0000305, 0.2588485, -0.9659179, -0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[39] = new("ManualWeld", I[38], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0.9659258, -0.258819, 0, 0.258819, 0.9659258, 1, 0, 0), C1 = CFrame.new(-1.0155945, -0.4665375, 0.2348022, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[40] = new("BlockMesh", I[38], "Mesh", { Offset = Vector3.new(-0.0125, 0, 0), Scale = Vector3.new(0.375, 0.125, 0.125) })
		I[41] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8252563, 132.6889648, -865.7081299, 0.9999953, 0.0000305, -0.0000312, -0.0000305, 0.9999955, -0.0000305, 0.0000312, 0.0000305, 1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[42] = new("ManualWeld", I[41], "Weld", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1), C1 = CFrame.new(-1.230011, 0.1079712, 0.0394287, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[43] = new("SpecialMesh", I[41], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.05, 0.2, 0.45) })
		I[44] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9052124, 132.6839447, -865.6156006, 0.0000312, 0.0000305, 0.9999953, 0.0000305, 0.9999955, -0.0000305, -1, 0.0000305, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[45] = new("ManualWeld", I[44], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-1.3224792, 0.1238556, 0.118042, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[46] = new("BlockMesh", I[44], "Mesh", { Scale = Vector3.new(0.125, 0.15, 0.05) })
		I[47] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8653564, 132.3489532, -866.3131104, 0.0000381, 0.0000214, 0.9999953, 0.2588474, 0.9659135, -0.0000305, -0.9659179, 0.2588485, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[48] = new("ManualWeld", I[47], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0.258819, 0.9659258, 0, 0.9659258, -0.258819, -1, 0, 0), C1 = CFrame.new(-0.625, -0.210083, 0.1661377, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[49] = new("BlockMesh", I[47], "Mesh", { Scale = Vector3.new(1, 1.4, 0.875) })
		I[50] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8653564, 132.6939697, -867.3031006, 0.0000312, 0.0000305, 0.9999953, 0.0000305, 0.9999955, -0.0000305, -1, 0.0000305, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[51] = new("ManualWeld", I[50], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.3649902, 0.1231384, 0.0768433, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[52] = new("BlockMesh", I[50], "Mesh", { Scale = Vector3.new(0.125, 0.25, 0.05) })
		I[53] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9052734, 132.6964569, -865.6455688, -0.0000312, -0.9999953, -0.0000305, -0.0000305, 0.0000305, -0.9999955, 1, -0.0000312, -0.0000305), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[54] = new("ManualWeld", I[53], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, -1, 1, 0, 0, 0, -1, 0), C1 = CFrame.new(-1.292511, 0.1359406, 0.1148071, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[55] = new("BlockMesh", I[53], "Mesh", { Scale = Vector3.new(0.175, 0.05, 0.275) })
		I[56] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8653564, 132.6490021, -867.3031006, 0.0000312, 0.0000305, 0.9999953, 0.0000305, 0.9999955, -0.0000305, -1, 0.0000305, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[57] = new("ManualWeld", I[56], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.3649902, 0.0796967, 0.0884399, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[58] = new("BlockMesh", I[56], "Mesh", { Scale = Vector3.new(0.375, 0.2, 0.1875) })
		I[59] = new("Part", I[2], "Part", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8652344, 132.5489349, -865.328064, 0.0000305, -0.0000312, 0.9999953, 0.9999955, -0.0000305, -0.0000305, 0.0000305, 1, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[60] = new("ManualWeld", I[59], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, -1, -1, 0, 0), C1 = CFrame.new(-1.6099548, -0.0168915, 0.1143188, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[61] = new("SpecialMesh", I[59], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=1033714"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(0.1, 0.07, 0.055) })
		I[62] = new("Part", I[2], "Main", { Anchored = true, CFrame = CFrame.new(495.8644409, 132.4986877, -867.6047363, -0.9999953, 0.0000312, -0.0000305, 0.0000305, 0.0000305, -0.9999955, -0.0000312, -1, -0.0000305), CanCollide = false, Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), Transparency = 1 })
			I[63] = new("ManualWeld", I[62], "Weld", { C0 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0), C1 = CFrame.new(0.6667175, -0.0657349, 0.1264648, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[64] = new("PointLight", I[62], "FlashFX[Light]", { Brightness = 10, Color = Color3.fromRGB(255, 255, 127), Enabled = false, Range = 6, Shadows = true })
			I[65] = new("ParticleEmitter", I[62], "FlashFX[Flash]", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127)) }), Enabled = false, Lifetime = NumberRange.new(0.05, 0.075), LightEmission = 1, Rate = 1000, Rotation = NumberRange.new(0, 90), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 0.2) }), Speed = NumberRange.new(50, 50), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=3419963"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.75, 0.125), NumberSequenceKeypoint.new(1, 1) }) })
			I[66] = new("ParticleEmitter", I[62], "1FlashFX[Smoke]", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 70, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 70, 70)) }), Enabled = false, Lifetime = NumberRange.new(1.25, 1.5), LightEmission = 0.1, Rate = 100, RotSpeed = NumberRange.new(10, 10), Rotation = NumberRange.new(0, 360), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9999996), NumberSequenceKeypoint.new(1, 3) }), Speed = NumberRange.new(5, 7), SpreadAngle = Vector2.new(15, 15), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=244514423"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 1) }) })
			I[67] = new("BlockMesh", I[62], "Mesh", { Scale = Vector3.new(0.53125, 0.15625, 0.53125) })
		I[68] = new("Part", I[2], "Mag", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8652954, 132.1239319, -866.3731079, 0.0000381, 0.0000214, 0.9999953, 0.2588474, 0.9659135, -0.0000305, -0.9659179, 0.2588485, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.35, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[69] = new("ManualWeld", I[68], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0.258819, 0.9659258, 0, 0.9659258, -0.258819, -1, 0, 0), C1 = CFrame.new(-0.5650024, -0.4274445, 0.2243652, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[70] = new("BlockMesh", I[68], "Mesh", { Scale = Vector3.new(0.875, 1, 0.625) })
		I[71] = new("Part", I[2], "Mag", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8652954, 131.8700714, -866.4510498, 0.00004, 0.0000174, 0.9999953, 0.3552161, 0.9347794, -0.0000305, -0.9347837, 0.3552178, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[72] = new("ManualWeld", I[71], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0.3551892, 0.9347945, 0, 0.9347945, -0.3551892, -1, 0, 0), C1 = CFrame.new(-0.4870605, -0.6726685, 0.2900391, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[73] = new("BlockMesh", I[71], "Mesh", { Scale = Vector3.new(0.875, 1, 0.625) })
		I[74] = new("Part", I[2], "Mag", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8652954, 131.6812592, -866.5430908, 0.0000423, 0.0000108, 0.9999953, 0.5000242, 0.8660061, -0.0000305, -0.8660101, 0.5000265, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.25, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[75] = new("ManualWeld", I[74], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0.5, 0.8660254, 0, 0.8660254, -0.5, -1, 0, 0), C1 = CFrame.new(-0.3950195, -0.8550415, 0.3389282, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[76] = new("BlockMesh", I[74], "Mesh", { Scale = Vector3.new(0.875, 1, 0.625) })
		I[77] = new("Part", I[2], "Head", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8602905, 131.8939056, -865.8232422, 0.9999955, 0.0000305, -0.0000312, -0.0000305, 0.9999958, -0.0000305, 0.0000312, 0.0000305, 1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
		I[78] = new("Part", I[2], "FlashlightModel", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.7303467, 132.4540253, -867.0871582, 0.0000305, 0.0000312, -0.9999953, 0.9999955, 0.0000305, 0.0000305, 0.0000305, -1, -0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.29, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[79] = new("ManualWeld", I[78], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0), C1 = CFrame.new(0.1490479, -0.1435852, 0.0084839, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[80] = new("SpecialMesh", I[78], "Mesh", { Scale = Vector3.new(0.6, 1, 0.6) })
		I[81] = new("Part", I[2], "Flashlight", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.7302856, 132.4540405, -867.2940674, 0.9999953, 0.0000305, -0.0000312, -0.0000305, 0.9999955, -0.0000305, 0.0000312, 0.0000305, 1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
			I[82] = new("ManualWeld", I[81], "Weld", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1), C1 = CFrame.new(0.3560486, -0.1435852, 0.0084839, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[83] = new("SpotLight", I[81], "Light", { Brightness = 100, Enabled = false, Range = 60, Shadows = true })
		I[84] = new("Part", I[2], "Chamber", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8701782, 132.5240021, -866.3432007, -0.9999953, 0.0000305, 0.0000312, 0.0000305, 0.9999955, 0.0000305, -0.0000312, 0.0000305, -1), Color = Color3.fromRGB(17, 17, 17), Shape = Enum.PartType.Ball, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
			I[85] = new("ManualWeld", I[84], "Weld", { C1 = CFrame.new(-0.5949097, -0.0397339, 0.1255493, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[86] = new("Part", I[2], "AimPart", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.8652954, 132.7189026, -865.2531128, 0.9999953, 0.0000305, -0.0000312, -0.0000305, 0.9999955, -0.0000305, 0.0000312, 0.0000305, 1), Color = Color3.fromRGB(248, 248, 248), FrontSurface = Enum.SurfaceType.Hinge, Material = Enum.Material.Metal, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Motor, Transparency = 1 })
			I[87] = new("ManualWeld", I[86], "Weld", { C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1), C1 = CFrame.new(-1.684967, 0.1472931, 0.0703735, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
			I[88] = new("BlockMesh", I[86], "Mesh", { Scale = Vector3.new(0.25, 0.25, 0.25) })
			I[89] = new("NumberValue", I[86], "FOV", { Value = 60 })
		I[90] = new("UnionOperation", I[2], "Head", { Anchored = true, CFrame = CFrame.new(495.8652344, 132.5989532, -866.3530273, -0.9999953, 0.0000305, 0.0000312, 0.0000305, 0.9999955, 0.0000305, -0.0000312, 0.0000305, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.1125004, 0.1125002, 2) })
			I[91] = new("ManualWeld", I[90], "Weld", { C1 = CFrame.new(-0.585022, 0.0313873, 0.1013794, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[92] = new("UnionOperation", I[2], "Union", { Anchored = true, CFrame = CFrame.new(495.8652954, 132.4114838, -866.4281006, -0.9999953, 0.0000305, 0.0000312, 0.0000305, 0.9999955, 0.0000305, -0.0000312, 0.0000305, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.175, 0.1250004, 0.15) })
			I[93] = new("ManualWeld", I[92], "Weld", { C1 = CFrame.new(-0.5100098, -0.149704, 0.1499023, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[94] = new("UnionOperation", I[2], "Union", { Anchored = true, CFrame = CFrame.new(495.8653564, 132.4989777, -867.4030762, -0.9999953, 0.0000305, 0.0000312, 0.0000305, 0.9999955, 0.0000305, -0.0000312, 0.0000305, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.1125004, 0.1125002, 0.3000004) })
			I[95] = new("ManualWeld", I[94], "Weld", { C1 = CFrame.new(0.4649658, -0.0652008, 0.1273193, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[96] = new("UnionOperation", I[2], "Union", { Anchored = true, CFrame = CFrame.new(495.8652954, 132.0983276, -865.1335449, -0.9999953, 0.0000305, 0.0000312, 0.0000305, 0.9999955, 0.0000305, -0.0000312, 0.0000305, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.1500004, 0.2395027, 0.1395821) })
			I[97] = new("ManualWeld", I[96], "Weld", { C1 = CFrame.new(-1.8045044, -0.4521332, 0.230957, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[98] = new("UnionOperation", I[2], "Union", { Anchored = true, CFrame = CFrame.new(495.8653564, 132.4739532, -866.8780518, -0.9999953, 0.0000305, 0.0000312, 0.0000305, 0.9999955, 0.0000305, -0.0000312, 0.0000305, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.2000002, 0.2500007, 0.7500004) })
			I[99] = new("ManualWeld", I[98], "Weld", { C1 = CFrame.new(-0.0600281, -0.0893555, 0.1337891, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[100] = new("UnionOperation", I[2], "Union", { Anchored = true, CFrame = CFrame.new(495.8653564, 132.0731659, -865.6635742, -0.9999953, 0.0000305, 0.0000312, 0.0000305, 0.9999955, 0.0000305, -0.0000312, 0.0000305, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.1500004, 0.5476778, 0.3450104) })
			I[101] = new("ManualWeld", I[100], "Weld", { C1 = CFrame.new(-1.2745056, -0.4764557, 0.2374878, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[102] = new("UnionOperation", I[2], "Union", { Anchored = true, CFrame = CFrame.new(495.8653564, 132.7189636, -867.3005371, -0.9999953, 0.0000305, 0.0000312, 0.0000305, 0.9999955, 0.0000305, -0.0000312, 0.0000305, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.1125002, 0.1125001, 0.0700001) })
			I[103] = new("ManualWeld", I[102], "Weld", { C1 = CFrame.new(0.3624878, 0.1472931, 0.0703735, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[104] = new("UnionOperation", I[2], "Union", { Anchored = true, CFrame = CFrame.new(495.8653564, 132.4989319, -865.9281006, -0.9999953, 0.0000305, 0.0000312, 0.0000305, 0.9999955, 0.0000305, -0.0000312, 0.0000305, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.2200001, 0.2200002, 1.15) })
			I[105] = new("ManualWeld", I[104], "Weld", { C1 = CFrame.new(-1.0099792, -0.0652008, 0.1273193, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[106] = new("UnionOperation", I[2], "Union", { Anchored = true, CFrame = CFrame.new(495.8653564, 132.3739471, -865.7780762, -0.9999955, 0.0000305, 0.0000312, 0.0000305, 0.9999958, 0.0000305, -0.0000312, 0.0000305, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.1500004, 0.350004, 0.9500008) })
			I[107] = new("ManualWeld", I[106], "Weld", { C1 = CFrame.new(-1.1600037, -0.1859283, 0.159668, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[108] = new("UnionOperation", I[2], "Union", { Anchored = true, CFrame = CFrame.new(495.8652344, 132.1221619, -865.9645996, -0.9999953, 0.0000305, 0.0000312, 0.0000305, 0.9999955, 0.0000305, -0.0000312, 0.0000305, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.0500004, 0.2466579, 0.4069023) })
			I[109] = new("ManualWeld", I[108], "Weld", { C1 = CFrame.new(-0.9734802, -0.4291382, 0.2247925, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[110] = new("UnionOperation", I[2], "Union", { Anchored = true, CFrame = CFrame.new(495.8652954, 132.697937, -865.6610107, -0.9999953, 0.0000305, 0.0000312, 0.0000305, 0.9999955, 0.0000305, -0.0000312, 0.0000305, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.0600002, 0.073485, 0.0717564) })
			I[111] = new("ManualWeld", I[110], "Weld", { C1 = CFrame.new(-1.2771301, 0.1270294, 0.0758057, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[112] = new("UnionOperation", I[2], "Union", { Anchored = true, CFrame = CFrame.new(495.8653564, 132.3989258, -865.1780396, -0.9999953, 0.0000305, 0.0000312, 0.0000305, 0.9999955, 0.0000305, -0.0000312, 0.0000305, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.1500004, 0.4000043, 0.1500008) })
			I[113] = new("ManualWeld", I[112], "Weld", { C1 = CFrame.new(-1.7600098, -0.1617889, 0.1531982, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[114] = new("UnionOperation", I[2], "Union", { Anchored = true, CFrame = CFrame.new(495.8653564, 132.1289062, -865.9354248, -0.9999953, 0.0000305, 0.0000312, 0.0000305, 0.9999955, 0.0000305, -0.0000312, 0.0000305, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.0250002, 0.1500001, 0.0625) })
			I[115] = new("ManualWeld", I[114], "Weld", { C1 = CFrame.new(-1.0026855, -0.4226227, 0.2230835, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[116] = new("UnionOperation", I[2], "BoltBack", { Anchored = true, CFrame = CFrame.new(495.7592163, 132.594223, -866.5581055, 0.0000312, 0.2588473, 0.9659131, 0.0000305, 0.9659134, -0.2588473, -1, 0.0000376, 0.0000222), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.0375, 0.075, 0.1625073), Transparency = 1, UsePartColor = true })
			I[117] = new("ManualWeld", I[116], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0), C1 = CFrame.new(-0.3800049, -0.0006409, 0.0001831, 0, 0, 1, -0.258819, 0.9659257, 0, -0.9659257, -0.258819, 0) })
		I[118] = new("UnionOperation", I[2], "Bolt", { Anchored = true, CFrame = CFrame.new(495.7592773, 132.5949097, -866.9381104, 0.0000312, 0.2588474, 0.9659134, 0.0000305, 0.9659137, -0.2588474, -1, 0.0000376, 0.0000222), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.0375, 0.075, 0.1625073), UsePartColor = true })
	I[119] = new("Model", nil, "FAL (2000$)")
		I[120] = new("ClickDetector", I[119], "ClickDetector")
		I[121] = new("Humanoid", I[119], "Humanoid", { MaxHealth = 0 })
		I[122] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.0779724, 131.6965485, -873.9346313, -0.0000312, -0.0000305, 1, -0.0000305, -1, -0.0000305, 1, -0.0000305, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(1.3363638, 0.2, 0.2) })
			I[123] = new("SpecialMesh", I[122], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(1, 0.0909091, 0.1363636) })
		I[124] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.2052307, 131.9056702, -874.5119019, 0.0000305, 0.0000312, -1, 1, 0.0000305, 0.0000305, 0.0000305, -1, -0.0000312), CanCollide = false, Color = Color3.fromRGB(248, 248, 248), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[125] = new("SpecialMesh", I[124], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.0454545, 0.1363636, 0.0909087) })
		I[126] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.1961975, 131.9056396, -874.0436401, -0.0000305, -0.0000312, -1, -1, -0.0000305, 0.0000305, -0.0000305, 1, -0.0000312), CanCollide = false, Color = Color3.fromRGB(248, 248, 248), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[127] = new("SpecialMesh", I[126], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.0454545, 0.1818182, 0.1818178) })
		I[128] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.9868469, 131.7967072, -873.2697144, 0.0000295, 0.9067399, -0.4216913, -1, 0.0002575, 0.0004852, 0.0005485, 0.4216913, 0.9067399), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2636363) })
			I[129] = new("SpecialMesh", I[128], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.8181819, 0.1818182, 1) })
		I[130] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9415588, 131.7601776, -873.152771, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[131] = new("SpecialMesh", I[130], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.0909091, 0.1363636, 0.1363633) })
		I[132] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.0733337, 131.796524, -873.1664429, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[133] = new("SpecialMesh", I[132], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.8181818, 0.5454546, 0.9999997) })
		I[134] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.4416199, 131.796524, -873.2846069, 0.0000305, 1, 0.0000312, 1, -0.0000305, 0.0000305, 0.0000305, 0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[135] = new("SpecialMesh", I[134], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.8181819, 0.4090909, 0.3636362) })
		I[136] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.0506287, 131.796524, -873.1300659, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[137] = new("SpecialMesh", I[136], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.4545454, 0.7727273, 0.0909087) })
		I[138] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.118927, 131.9056549, -874.0435791, 0.0000305, -0.0000312, 1, 1, -0.0000305, -0.0000305, 0.0000305, 1, 0.0000312), CanCollide = false, Color = Color3.fromRGB(248, 248, 248), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[139] = new("SpecialMesh", I[138], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.0454545, 0.1818182, 0.1818178) })
		I[140] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.750824, 131.7967377, -873.2039795, 0.0000295, -0.9067399, 0.4216913, -1, -0.0002575, -0.0004852, 0.0005485, -0.4216913, -0.9067399), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.4090909, 0.2) })
			I[141] = new("SpecialMesh", I[140], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.8181819, 1, 0.2727273) })
		I[142] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.4369812, 131.7965393, -873.5163574, 0.0000305, 1, 0.0000312, 1, -0.0000305, 0.0000305, 0.0000305, 0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.7909091) })
			I[143] = new("SpecialMesh", I[142], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.8181819, 0.4545455, 1) })
		I[144] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.0779724, 131.8965454, -873.9346313, 0.0000312, 0.0000305, 1, 0.0000305, 1, -0.0000305, -1, 0.0000305, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(1.3363638, 0.2, 0.2) })
			I[145] = new("SpecialMesh", I[144], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(1, 0.0909091, 0.1363636) })
		I[146] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9417419, 131.7602844, -875.7800293, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[147] = new("SpecialMesh", I[146], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.0909091, 0.1363636, 0.1363633) })
		I[148] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9417419, 131.8330231, -875.7800293, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[149] = new("SpecialMesh", I[148], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.0909091, 0.1363636, 0.1363633) })
		I[150] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9417419, 131.7602997, -875.8709717, 0.0000305, -1, -0.0000312, 1, 0.0000305, -0.0000305, 0.0000305, -0.0000312, 1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[151] = new("SpecialMesh", I[150], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.0909091, 0.1363636, 0.1363633) })
		I[152] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9415588, 131.7601776, -873.2528687, 0.0000305, -1, -0.0000312, 1, 0.0000305, -0.0000305, 0.0000305, -0.0000312, 1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[153] = new("SpecialMesh", I[152], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.0909091, 0.1363636, 0.1363633) })
		I[154] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.3233948, 131.7965851, -874.5709839, -0.0000305, 1, -0.0000312, -1, -0.0000305, -0.0000305, -0.0000305, 0.0000312, 1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[155] = new("SpecialMesh", I[154], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.9090909, 0.5, 0.3181818) })
		I[156] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.1983948, 131.7965851, -874.6709595, -0.0000305, 0.0000312, 1, -1, 0.0000305, -0.0000305, -0.0000305, -1, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[157] = new("CylinderMesh", I[156], "Mesh", { Scale = Vector3.new(1, 0.6818191, 0.9999995) })
		I[158] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.5279236, 131.7965393, -874.2526855, -0.0000305, 1, -0.0000312, -1, -0.0000305, -0.0000305, -0.0000305, 0.0000312, 1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.5727272) })
			I[159] = new("SpecialMesh", I[158], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.8181819, 0.5454546, 1) })
		I[160] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.1338806, 131.7966461, -875.8253784, 0.0000305, 1, 0.0000312, 1, -0.0000305, 0.0000305, 0.0000305, 0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.3636363, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[161] = new("SpecialMesh", I[160], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.4545456, 1, 0.5909082) })
		I[162] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.0780334, 131.7965851, -874.5800171, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2181818, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[163] = new("SpecialMesh", I[162], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(1, 0.1363635, 0.2272723) })
		I[164] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9415588, 131.832901, -873.2028198, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[165] = new("SpecialMesh", I[164], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.0909092, 0.1363636, 0.3636357) })
		I[166] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.6486511, 131.796524, -873.6729736, -0.0000305, 0.0000312, 1, -1, 0.0000305, -0.0000305, -0.0000305, -1, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2090909, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[167] = new("SpecialMesh", I[166], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.3636363, 1, 0.1363636) })
		I[168] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.2041931, 131.6233063, -874.5201416, -0.0000115, -0.7078789, 0.7063341, -1, -0.0003898, -0.000407, 0.0005635, -0.7063342, -0.7078789), CanCollide = false, Color = Color3.fromRGB(99, 95, 98), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[169] = new("SpecialMesh", I[168], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.6363636, 0.3636363, 0.363636) })
		I[170] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.118866, 131.9056702, -874.2800293, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(248, 248, 248), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.4363635), TopSurface = Enum.SurfaceType.Smooth })
			I[171] = new("SpecialMesh", I[170], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.0454545, 0.1818181, 1) })
		I[172] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9416199, 131.832901, -873.15271, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[173] = new("SpecialMesh", I[172], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.0909091, 0.1363636, 0.1363633) })
		I[174] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.2303162, 131.7966461, -875.9004517, -0.0000305, 0.0000312, 1, -1, 0.0000305, -0.0000305, -0.0000305, -1, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.3954545, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[175] = new("CylinderMesh", I[174], "Mesh", { Scale = Vector3.new(0.4545455, 1, 0.4545449) })
		I[176] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.0415955, 131.7510986, -873.9346313, -0.0000312, -0.0000305, 1, -0.0000305, -1, -0.0000305, 1, -0.0000305, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(1.3363638, 0.2, 0.2) })
			I[177] = new("SpecialMesh", I[176], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(1, 0.4545455, 0.2272727) })
		I[178] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.7395935, 131.7966461, -873.3846436, 0.0000295, -0.9067399, 0.4216913, -1, -0.0002575, -0.0004852, 0.0005485, -0.4216913, -0.9067399), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.5090909, 0.2636364), TopSurface = Enum.SurfaceType.Smooth })
			I[179] = new("SpecialMesh", I[178], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.8181819, 1, 1) })
		I[180] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.0461731, 131.7966003, -874.9436035, -0.0000305, 0.0000312, 1, -1, 0.0000305, -0.0000305, -0.0000305, -1, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.6818182, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[181] = new("CylinderMesh", I[180], "Mesh", { Scale = Vector3.new(0.3181818, 1, 0.3409091) })
		I[182] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9417419, 131.8330231, -875.8254395, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[183] = new("SpecialMesh", I[182], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.0909092, 0.1363636, 0.3181812) })
		I[184] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.1575623, 131.9056702, -874.2618408, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(248, 248, 248), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.4727271), TopSurface = Enum.SurfaceType.Smooth })
			I[185] = new("SpecialMesh", I[184], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.0454545, 0.2045454, 1) })
		I[186] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.2007141, 131.7965698, -874.2618408, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2181818, 0.2181818, 0.6818181), TopSurface = Enum.SurfaceType.Smooth })
			I[187] = new("SpecialMesh", I[186], "Mesh", { MeshType = Enum.MeshType.Brick })
		I[188] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.6734924, 131.7965546, -874.2709351, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(99, 95, 98), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.8, 0.4818182), TopSurface = Enum.SurfaceType.Smooth })
			I[189] = new("SpecialMesh", I[188], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.5454546, 1, 1) })
		I[190] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9417419, 131.7602997, -875.8254395, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[191] = new("SpecialMesh", I[190], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.0909092, 0.1363636, 0.3181812) })
		I[192] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.1575012, 131.9056702, -874.5118408, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(248, 248, 248), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[193] = new("SpecialMesh", I[192], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.0454545, 0.3863636, 0.1363631) })
		I[194] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.4961243, 131.7973785, -872.1825562, -0.0000175, -0.5008881, -0.8655115, 1, -0.0005453, 0.0002961, -0.0006205, -0.8655116, 0.500888), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.6545457, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[195] = new("CylinderMesh", I[194], "Mesh", { Scale = Vector3.new(0.4545455, 1, 0.4545449) })
		I[196] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.0506287, 131.796524, -873.2028198, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[197] = new("SpecialMesh", I[196], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.4545455, 0.9545454, 0.636363) })
		I[198] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.3097839, 131.7965546, -873.90271, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 1.2727273), TopSurface = Enum.SurfaceType.Smooth })
			I[199] = new("SpecialMesh", I[198], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.8181819, 0.6363637, 1) })
		I[200] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.0734558, 131.7965546, -873.9346313, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 1.3363636), TopSurface = Enum.SurfaceType.Smooth })
			I[201] = new("SpecialMesh", I[200], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.9090909, 0.0909091, 1) })
		I[202] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.2052307, 131.6874847, -874.1983032, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.6818181), TopSurface = Enum.SurfaceType.Smooth })
			I[203] = new("SpecialMesh", I[202], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.0454545, 0.2272727, 1) })
		I[204] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9415588, 131.7601776, -873.2028198, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[205] = new("SpecialMesh", I[204], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.0909092, 0.1363636, 0.3636357) })
		I[206] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.1176453, 131.8270264, -874.6520386, -0.8660402, -0.4999736, -0.0011048, -0.4999726, 0.8660402, -0.0005944, 0.0012547, 0.0000378, -0.999999), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[207] = new("SpecialMesh", I[206], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.6818182, 0.090909, 0.4999995) })
		I[208] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.2303162, 131.7966461, -876.2800293, -0.0000305, 0.0000312, 1, -1, 0.0000305, -0.0000305, -0.0000305, -1, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.4909091, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[209] = new("CylinderMesh", I[208], "Mesh", { Scale = Vector3.new(1, 1, 0.7272722) })
		I[210] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.2597961, 131.796524, -873.0890503, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2636364, 0.3636363), TopSurface = Enum.SurfaceType.Smooth })
			I[211] = new("SpecialMesh", I[210], "Mesh", { MeshType = Enum.MeshType.Brick })
		I[212] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.4234314, 131.7965698, -874.2527466, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.5727273), TopSurface = Enum.SurfaceType.Smooth })
			I[213] = new("SpecialMesh", I[212], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.8181819, 0.5000001, 1) })
		I[214] = new("Part", I[119], "Muzzle", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.2229919, 131.7954712, -876.5209351, -0.0000312, -1, -0.0000305, -0.0000305, 0.0000305, -1, 1, -0.0000312, -0.0000305), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2035715, 0.2785714), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
		I[215] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.1983948, 131.7965851, -874.6891479, -0.0000305, 0.0000312, 1, -1, 0.0000305, -0.0000305, -0.0000305, -1, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2363636, 0.2, 0.2363635), TopSurface = Enum.SurfaceType.Smooth })
			I[216] = new("CylinderMesh", I[215], "Mesh", { Scale = Vector3.new(1, 0.1363645, 1) })
		I[217] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.617218, 131.7964325, -873.8029785, -0.0000115, -0.7078789, 0.7063341, -1, -0.0003898, -0.000407, 0.0005635, -0.7063342, -0.7078789), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[218] = new("SpecialMesh", I[217], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.3636363, 0.5, 0.1363636) })
		I[219] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.5188904, 131.7965393, -873.8391113, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[220] = new("SpecialMesh", I[219], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.3636363, 0.7272727, 0.090909) })
		I[221] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.3370056, 131.7965088, -872.675354, 0.0000305, 0.0000312, -1, 1, 0.0000305, 0.0000305, 0.0000305, -1, -0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.4636366, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[222] = new("CylinderMesh", I[221], "Mesh", { Scale = Vector3.new(0.4545455, 1, 0.4545449) })
		I[223] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.2551575, 131.7965088, -872.5300293, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[224] = new("SpecialMesh", I[223], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.3863636, 0.9090909, 0.5) })
		I[225] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.4233704, 131.796463, -871.8572388, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.5909091, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[226] = new("SpecialMesh", I[225], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.6818182, 1, 0.7272727) })
		I[227] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.0325012, 131.85112, -874.5800171, 0.0000312, 0.0000305, 1, 0.0000305, 1, -0.0000305, -1, 0.0000305, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[228] = new("SpecialMesh", I[227], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.2272727, 0.5454546, 0.3181818) })
		I[229] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.4825134, 131.7965393, -873.4663086, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2909091), TopSurface = Enum.SurfaceType.Smooth })
			I[230] = new("SpecialMesh", I[229], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.8181819, 0.8181819, 1) })
		I[231] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.3870544, 131.7965393, -873.5891113, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.6454546), TopSurface = Enum.SurfaceType.Smooth })
			I[232] = new("SpecialMesh", I[231], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.8181819, 0.1363636, 1) })
		I[233] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.1160583, 131.7710266, -874.6565552, 0.8660097, -0.5000255, -0.0010738, -0.5000264, -0.8660098, -0.0006204, -0.0006192, 0.001074, -0.999999), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[234] = new("SpecialMesh", I[233], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.6363637, 0.1363635, 0.545454) })
		I[235] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9416199, 131.8329163, -873.2527466, 0.0000305, -1, -0.0000312, 1, 0.0000305, -0.0000305, 0.0000305, -0.0000312, 1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[236] = new("SpecialMesh", I[235], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.0909091, 0.1363636, 0.1363633) })
		I[237] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.1097717, 131.9056702, -874.5118408, 0.0000305, -1, -0.0000312, 1, 0.0000305, -0.0000305, 0.0000305, -0.0000312, 1), CanCollide = false, Color = Color3.fromRGB(248, 248, 248), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[238] = new("SpecialMesh", I[237], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.0454545, 0.0909091, 0.1363633) })
		I[239] = new("Part", I[119], "Head", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.1230774, 131.7964935, -875.1709595, 0.0000305, -1, -0.0000312, 1, 0.0000305, -0.0000305, 0.0000305, -0.0000312, 1), Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.364, 0.315, 1.064), TopSurface = Enum.SurfaceType.Smooth })
			I[240] = new("Weld", I[239], "Weld", { C0 = CFrame.new(0, -0.7, 1.55) })
		I[241] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.1689148, 131.7965546, -873.9345703, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2181818, 0.2, 1.3363636), TopSurface = Enum.SurfaceType.Smooth })
			I[242] = new("SpecialMesh", I[241], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(1, 0.7727272, 1) })
		I[243] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.2779236, 131.7965698, -873.8709717, 0.0000305, 1, 0.0000312, 1, -0.0000305, 0.0000305, 0.0000305, 0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2181818, 0.2, 0.2) })
			I[244] = new("SpecialMesh", I[243], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(1, 0.3181818, 0.4999997) })
		I[245] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.0325012, 131.7420349, -874.5800171, -0.0000312, -0.0000305, 1, -0.0000305, -1, -0.0000305, 1, -0.0000305, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[246] = new("SpecialMesh", I[245], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.2272734, 0.5454546, 0.3181818) })
		I[247] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.1824036, 131.7964935, -872.3845215, 0.0000305, 0.0000312, -1, 1, 0.0000305, 0.0000305, 0.0000305, -1, -0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 1.0454547, 0.2), TopSurface = Enum.SurfaceType.Smooth })
			I[248] = new("CylinderMesh", I[247], "Mesh", { Scale = Vector3.new(0.4545455, 1, 0.4545449) })
		I[249] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.9417419, 131.8330231, -875.8709717, 0.0000305, -1, -0.0000312, 1, 0.0000305, -0.0000305, 0.0000305, -0.0000312, 1), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2) })
			I[250] = new("SpecialMesh", I[249], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(0.0909091, 0.1363636, 0.1363633) })
		I[251] = new("Part", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.1961365, 131.9056549, -874.2800903, -0.0000305, -1, 0.0000312, -1, 0.0000305, 0.0000305, -0.0000305, -0.0000312, -1), CanCollide = false, Color = Color3.fromRGB(248, 248, 248), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.4363635), TopSurface = Enum.SurfaceType.Smooth })
			I[252] = new("SpecialMesh", I[251], "Mesh", { MeshType = Enum.MeshType.Brick, Scale = Vector3.new(0.0454545, 0.1818182, 1) })
		I[253] = new("Part", I[119], "Handle", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.8230286, 131.7964478, -873.6210327, 0.0000305, -1, -0.0000312, 1, 0.0000305, -0.0000305, 0.0000305, -0.0000312, 1), Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2, 0.2, 0.2), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
			I[254] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.109188, -0.890837, -0.61777, 0, 0, 1, 1, 0, 0, 0, 1, 0) })
			I[255] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.959017, -0.054461, 0.790504, -1, 0, 0, 0, 0, -1, 0, -1, 0) })
			I[256] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.313557, -0.099917, 0.745048, -1, 0, 0, 0, 0, -1, 0, -1, 0) })
			I[257] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.313564, -0.100086, 0.745048, 1, 0, 0, 0, 0, 1, 0, -1, 0) })
			I[258] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000094, 0.499576, 0.949944, 0, 0, -1, 0, -1, 0, -1, 0, 0) })
			I[259] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000082, -0.772333, 0.490982, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[260] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.036445, -0.881418, 0.46825, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[261] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.036252, -0.881374, -2.159019, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[262] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.036448, -0.88142, -0.36825, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
			I[263] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000106, -2.279469, 0.592773, 0, 0, -1, 1, 0, 0, 0, -1, 0) })
			I[264] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000074, 0.110332, 0.408537, -0.000579, -0.00006, -1, 0.421663, 0.906753, -0.000298, 0.906753, -0.421663, -0.0005) })
			I[265] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000079, -0.340504, 0.154617, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[266] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.594234, -0.379079, -1.031759, -0.001297, 0.866025, -0.499999, -0.000027, 0.5, 0.866025, 0.999999, 0.001136, -0.000625) })
			I[267] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.000089, 0.545041, -0.249937, 0, 0, 1, 0, -1, 0, 1, 0, 0) })
			I[268] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.000081, 0.385956, 0.10462, 0, 0, 1, 0, -1, 0, 1, 0, 0) })
			I[269] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.313559, -0.04537, 0.781413, -1, 0, 0, 0, 0, -1, 0, -1, 0) })
			I[270] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.000078, 0.381416, 0.336435, 0, 0, 1, 0, -1, 0, 1, 0, 0) })
			I[271] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.109182, 0.422649, 0.704142, 0, 0, 1, -1, 0, 0, 0, -1, 0) })
			I[272] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.036476, -0.881378, 2.249943, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
			I[273] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.036284, -0.881418, 0.468248, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[274] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.036477, -0.881374, -2.159023, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[275] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.109188, -0.713214, 0.890846, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
			I[276] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.036253, -0.881379, 2.249939, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
			I[277] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.31356, -0.045538, 0.781413, 1, 0, 0, 0, 0, 1, 0, -1, 0) })
			I[278] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.036285, -0.881423, -0.368248, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
			I[279] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000092, -0.622309, -0.640844, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[280] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000098, -0.745032, -0.959023, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[281] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000078, -0.051941, 0.174334, 0, 0, -1, 1, 0, 0, 0, -1, 0) })
			I[282] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.109189, -0.704127, -0.659025, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[283] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000074, -0.567796, 1.090975, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[284] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000077, 0.023973, 0.249445, -0.000579, -0.00006, -1, 0.421663, 0.906753, -0.000298, 0.906753, -0.421663, -0.0005) })
			I[285] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.108999, -0.617763, -0.577209, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[286] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.109188, -0.665489, -0.890848, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[287] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000083, -0.30413, -0.218113, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[288] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000087, -0.149575, -0.649937, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[289] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.036446, -0.881419, 0.418249, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[290] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000097, -1.068104, 0.624594, 0, 0, -1, 1, 0, 0, 0, -1, 0) })
			I[291] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000095, -1.049919, 0.624591, 0, 0, -1, 1, 0, 0, 0, -1, 0) })
			I[292] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.036282, -0.88142, 0.418251, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[293] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.172633, -1.073172, -0.199522, -0.000594, -0.000019, -1, 0.706312, 0.707901, -0.000433, 0.707901, -0.706312, -0.000407) })
			I[294] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000084, -0.274282, 0.016611, -0.000594, -0.000019, -1, 0.706312, 0.707901, -0.000433, 0.707901, -0.706312, -0.000407) })
			I[295] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.000066, 1.081175, -1.0034339, 0.000651, 0.000048, 1, 0.865496, 0.500915, -0.000587, -0.500915, 0.865496, 0.000285) })
			I[296] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000088, -0.399581, -0.631752, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[297] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000088, -0.513225, -0.281752, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[298] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.036478, -0.881375, -2.204483, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[299] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000083, -0.772326, 0.418257, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[300] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.036251, -0.881375, -2.204479, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[301] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000088, -0.749587, -0.313572, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[302] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000086, -0.654134, -0.313566, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[303] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000082, -0.435958, 0.031889, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[304] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.109185, -0.626852, -0.659021, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[305] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000081, -0.563236, 0.531885, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[306] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.00011, 0.689184, -2.2044809, 0, 0, 1, 0, -1, 0, 1, 0, 0) })
			I[307] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000102, -1.322647, 0.776869, 0, 0, -1, 1, 0, 0, 0, -1, 0) })
			I[308] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.00007, 1.236441, -0.640501, 0, 0, 1, 1, 0, 0, 0, 1, 0) })
			I[309] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.109187, -0.665491, -0.64085, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[310] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.598872, -0.374383, -1.036306, 0.000631, -0.866025, -0.5, -0.001116, 0.499999, -0.866025, 0.999999, 0.001105, -0.000651) })
			I[311] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.00011, -2.659018, 0.592773, 0, 0, -1, 1, 0, 0, 0, -1, 0) })
			I[312] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000065, -0.39962, 1.7636991, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[313] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.000078, 0.945532, -0.485953, 0, 0, 1, 1, 0, 0, 0, 1, 0) })
			I[314] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000086, 0.295034, 0.631748, 0, 0, -1, 0, -1, 0, -1, 0, 0) })
			I[315] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.109179, 0.422647, -0.626867, 0, 0, -1, -1, 0, 0, 0, 1, 0) })
			I[316] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) })
			I[317] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(2.899977, -0.600107, -0.001067, -1, 0, 0, 0, 1, 0, 0, 0, -1) })
			I[318] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000073, -0.296703, -0.249443, -0.000579, -0.00006, -1, -0.421663, -0.906753, 0.000298, -0.906753, 0.421663, 0.0005) })
			I[319] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(0.000083, -0.749599, 0.454618, 0, 0, -1, 0, 1, 0, 1, 0, 0) })
			I[320] = new("Weld", I[253], "Weld", { C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), C1 = CFrame.new(-0.959017, -0.054635, 0.790502, 1, 0, 0, 0, 0, 1, 0, -1, 0) })
		I[321] = new("WedgePart", I[119], "Smooth Block Model", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(496.0415955, 131.8419952, -873.9346313, 0.0000312, 0.0000305, 1, 0.0000305, 1, -0.0000305, -1, 0.0000305, 0.0000312), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(1.3363638, 0.2, 0.2) })
			I[322] = new("SpecialMesh", I[321], "Mesh", { MeshType = Enum.MeshType.Wedge, Scale = Vector3.new(1, 0.4545455, 0.2272727) })
	I[323] = new("Model", nil, "RocketLauncher (3000$)")
		I[324] = new("Part", I[323], "Head", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(495.5951538, 131.9428253, -860.0430908, 0.0000312, -1, 0.0000305, 0.0000305, 0.0000305, 1, -1, -0.0000312, 0.0000305), CanCollide = false, Size = Vector3.new(4.9200063, 0.7400005, 0.8399998), TopSurface = Enum.SurfaceType.Smooth })
			I[325] = new("SpecialMesh", I[324], "Mesh", { MeshContent = Content.fromUri("rbxasset://fonts/rocketlauncher.mesh"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(0.75, 0.75, 0.75), TextureContent = Content.fromUri("rbxasset://textures/rocketlaunchertex.png") })
			I[326] = new("ClickDetector", I[324], "ClickDetector")
		I[327] = new("Humanoid", I[323], "Humanoid", { MaxHealth = 0 })
	I[328] = new("Model", nil, "MiniGuns")
		I[329] = new("Part", I[328], "Handle", { Anchored = true, CFrame = CFrame.new(481.9657593, 135.7766266, -886.8167725, 0.9999983, 0.0000302, 0.0000304, -0.0000304, 0.0000308, 0.9999994, 0.0000302, -0.9999982, 0.0000308), Color = Color3.fromRGB(27, 42, 53), Size = Vector3.new(0.4, 3.4000001, 0.8) })
			I[330] = new("SpecialMesh", I[329], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset?id=71947307"), MeshType = Enum.MeshType.FileMesh, TextureContent = Content.fromUri("http://www.roblox.com/asset?id=71947249") })
		I[331] = new("ClickDetector", I[328], "ClickDetector")
	I[332] = new("Model", nil, "Spas12")
		I[333] = new("UnionOperation", I[332], "Union", { Anchored = true, CFrame = CFrame.new(482.168396, 134.1087494, -885.4421997, 0.9999983, -0.0000304, 0.00003, -0.0000304, -0.9999994, 0.0000308, 0.0000303, -0.0000308, -0.9999979), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.2711002, 0.3614624, 1.3215979) })
		I[334] = new("UnionOperation", I[332], "Union", { Anchored = true, CFrame = CFrame.new(482.134491, 134.0862579, -886.9389648, 0.9999983, 0.0000304, -0.00003, -0.0000304, 0.9999994, -0.0000308, 0.0000303, 0.0000308, 0.9999979), CanCollide = false, Color = Color3.fromRGB(17, 17, 17), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.271097, 0.4744177, 1.6717556) })
		I[335] = new("UnionOperation", I[332], "Union", { Anchored = true, CFrame = CFrame.new(482.1348267, 134.210495, -885.0187988, 0.00003, 0.9999983, -0.0000304, 0.0000308, -0.0000304, -0.9999994, -0.9999979, 0.0000303, -0.0000308), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.1581399, 0.2710967, 0.1581398) })
		I[336] = new("UnionOperation", I[332], "Union", { Anchored = true, CFrame = CFrame.new(482.1347046, 133.6287689, -885.0300293, 0.0000304, 0.9999983, 0.00003, 0.9999994, -0.0000304, 0.0000308, 0.0000308, 0.0000303, -0.9999979), CanCollide = false, Color = Color3.fromRGB(163, 162, 165), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.5986725, 0.1863789, 0.4292367) })
		I[337] = new("UnionOperation", I[332], "Union", { Anchored = true, CFrame = CFrame.new(482.1346436, 134.3294525, -885.9631348, -0.9999983, -0.0000304, -0.00003, 0.0000304, -0.9999994, -0.0000308, -0.0000303, -0.0000308, 0.9999979), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.2259143, 0.3961591, 1.8890165) })
		I[338] = new("UnionOperation", I[332], "Union", { Anchored = true, CFrame = CFrame.new(482.1004639, 133.8513489, -885.538269, 0.00003, -0.9999983, 0.0000304, 0.0000308, 0.0000304, 0.9999994, -0.9999979, -0.0000303, 0.0000308), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.2260095, 0.0564789, 0.1553164) })
		I[339] = new("UnionOperation", I[332], "Union", { Anchored = true, CFrame = CFrame.new(482.1004333, 133.8264008, -885.3378906, 0.00003, 0.0000304, 0.9999983, 0.0000308, 0.9999994, -0.0000304, -0.9999979, 0.0000308, 0.0000303), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.3106327, 0.2240803, 0.0338882) })
		I[340] = new("UnionOperation", I[332], "Union", { Anchored = true, CFrame = CFrame.new(482.1347656, 134.1596527, -887.3850708, -0.0000304, 0.00003, 0.9999983, -0.9999994, 0.0000308, -0.0000304, -0.0000308, -0.9999979, 0.0000303), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.4405326, 2.5641246, 0.2033226) })
		I[341] = new("UnionOperation", I[332], "Union", { Anchored = true, CFrame = CFrame.new(482.1400452, 134.3850098, -886.4901733, -0.9999983, -0.00003, 0.0000304, 0.0000304, -0.0000308, 0.9999994, -0.0000303, 0.9999979, 0.0000308), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Material = Enum.Material.Metal, RenderFidelity = Enum.RenderFidelity.Precise, Size = Vector3.new(0.1016619, 0.1694364, 0.1016614) })
		I[342] = new("Part", I[332], "Chamber", { Anchored = true, CFrame = CFrame.new(482.1141968, 134.1826172, -885.8117676, 0.0730128, -0.1073062, -0.9915397, -0.0000298, 0.9941941, -0.1075957, 0.9973291, 0.0078854, 0.0725854), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Size = Vector3.new(0.2377555, 0.2377555, 0.4636158), Transparency = 1 })
			I[343] = new("SpecialMesh", I[342], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=94248124"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(0.5943887, 0.5943888, 0.5943889), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=94219470") })
		I[344] = new("Part", I[332], "Flame", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(482.1402283, 134.2091064, -888.7097778, -0.9999983, 0.0000309, -0.0000304, 0.0000304, 0.0000308, -0.9999994, -0.0000312, -0.999998, -0.0000308), CanCollide = false, Color = Color3.fromRGB(218, 133, 65), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2377555, 0.2377555, 0.2377556), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
			I[345] = new("PointLight", I[344], "FlashFX[Light]", { Brightness = 10, Color = Color3.fromRGB(255, 255, 127), Enabled = false, Range = 6, Shadows = true })
			I[346] = new("ParticleEmitter", I[344], "1FlashFX[Smoke]", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 70, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 70, 70)) }), Enabled = false, Lifetime = NumberRange.new(1.25, 1.5), LightEmission = 0.1, Rate = 100, RotSpeed = NumberRange.new(10, 10), Rotation = NumberRange.new(0, 360), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9999996), NumberSequenceKeypoint.new(1, 3) }), Speed = NumberRange.new(5, 7), SpreadAngle = Vector2.new(15, 15), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=244514423"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.90625), NumberSequenceKeypoint.new(1, 1) }) })
			I[347] = new("ParticleEmitter", I[344], "FlashFX[Flash]", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 70, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 70, 70)) }), Enabled = false, Lifetime = NumberRange.new(1.25, 1.5), LightEmission = 0.1, Rate = 100, RotSpeed = NumberRange.new(10, 10), Rotation = NumberRange.new(0, 360), Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9999996), NumberSequenceKeypoint.new(1, 3) }), Speed = NumberRange.new(5, 7), SpreadAngle = Vector2.new(15, 15), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=244514423"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.90625), NumberSequenceKeypoint.new(1, 1) }) })
			I[348] = new("BlockMesh", I[344], "Mesh", { Scale = Vector3.new(0.8171614, 0.8171611, 0.8171613) })
		I[349] = new("Part", I[332], "Handle", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(482.1402893, 133.5400238, -885.4298096, 0.9999983, 0.0000304, -0.0000309, -0.0000304, 0.9999994, -0.0000308, 0.0000312, 0.0000308, 0.999998), CanCollide = false, Color = Color3.fromRGB(99, 95, 98), Material = Enum.Material.SmoothPlastic, Size = Vector3.new(0.2377555, 0.2377555, 0.2377556), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
			I[350] = new("BlockMesh", I[349], "Mesh", { Scale = Vector3.new(0.8171614, 0.8171611, 0.8171613) })
			I[351] = new("PointLight", I[349], "PointLight", { Color = Color3.fromRGB(255, 179, 0), Enabled = false, Range = 6 })
		I[352] = new("Part", I[332], "Mag", { Anchored = true, CFrame = CFrame.new(482.1141968, 133.8378296, -885.8119507, 0.9999983, 0.0000304, -0.00003, -0.0000304, 0.9999994, -0.0000308, 0.0000303, 0.0000308, 0.9999979), CanCollide = false, Color = Color3.fromRGB(27, 42, 53), Size = Vector3.new(0.2377555, 0.2377555, 0.4636158) })
			I[353] = new("SpecialMesh", I[352], "Mesh", { MeshContent = Content.fromUri("http://www.roblox.com/asset/?id=94248124"), MeshType = Enum.MeshType.FileMesh, Scale = Vector3.new(0, 0, 0), TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=94219470") })
		I[354] = new("Part", I[332], "SightMark", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(482.1398621, 134.5392303, -884.6592407, 0.9999983, 0.0000304, -0.00003, -0.0000304, 0.9999994, -0.0000308, 0.0000303, 0.0000308, 0.9999979), CanCollide = false, Color = Color3.fromRGB(255, 0, 0), Material = Enum.Material.SmoothPlastic, Reflectance = 0.3, Size = Vector3.new(0.2377555, 0.2377555, 0.2377556), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
			I[355] = new("BlockMesh", I[354], "Mesh", { Scale = Vector3.new(0.7697749, 0.7697746, 0.7697741) })
		I[356] = new("ClickDetector", I[332], "ClickDetector")
	I[357] = new("ColorGradingEffect", nil, "ColorGrading", { TonemapperPreset = Enum.TonemapperPreset.Retro })
	I[358] = new("BloomEffect", nil, "Bloom", { Intensity = 0 })
	I[6].Part0 = I[5]
	I[6].Part1 = I[118]
	I[9].Part0 = I[8]
	I[9].Part1 = I[118]
	I[12].Part0 = I[11]
	I[12].Part1 = I[118]
	I[15].Part0 = I[14]
	I[15].Part1 = I[118]
	I[18].Part0 = I[17]
	I[18].Part1 = I[118]
	I[21].Part0 = I[20]
	I[21].Part1 = I[118]
	I[24].Part0 = I[23]
	I[24].Part1 = I[118]
	I[27].Part0 = I[26]
	I[27].Part1 = I[118]
	I[30].Part0 = I[29]
	I[30].Part1 = I[118]
	I[33].Part0 = I[32]
	I[33].Part1 = I[118]
	I[36].Part0 = I[35]
	I[36].Part1 = I[118]
	I[39].Part0 = I[38]
	I[39].Part1 = I[118]
	I[42].Part0 = I[41]
	I[42].Part1 = I[118]
	I[45].Part0 = I[44]
	I[45].Part1 = I[118]
	I[48].Part0 = I[47]
	I[48].Part1 = I[118]
	I[51].Part0 = I[50]
	I[51].Part1 = I[118]
	I[54].Part0 = I[53]
	I[54].Part1 = I[118]
	I[57].Part0 = I[56]
	I[57].Part1 = I[118]
	I[60].Part0 = I[59]
	I[60].Part1 = I[118]
	I[63].Part0 = I[62]
	I[63].Part1 = I[118]
	I[69].Part0 = I[68]
	I[69].Part1 = I[118]
	I[72].Part0 = I[71]
	I[72].Part1 = I[118]
	I[75].Part0 = I[74]
	I[75].Part1 = I[118]
	I[79].Part0 = I[78]
	I[79].Part1 = I[118]
	I[82].Part0 = I[81]
	I[82].Part1 = I[118]
	I[85].Part0 = I[84]
	I[85].Part1 = I[118]
	I[87].Part0 = I[86]
	I[87].Part1 = I[118]
	I[91].Part0 = I[90]
	I[91].Part1 = I[118]
	I[93].Part0 = I[92]
	I[93].Part1 = I[118]
	I[95].Part0 = I[94]
	I[95].Part1 = I[118]
	I[97].Part0 = I[96]
	I[97].Part1 = I[118]
	I[99].Part0 = I[98]
	I[99].Part1 = I[118]
	I[101].Part0 = I[100]
	I[101].Part1 = I[118]
	I[103].Part0 = I[102]
	I[103].Part1 = I[118]
	I[105].Part0 = I[104]
	I[105].Part1 = I[118]
	I[107].Part0 = I[106]
	I[107].Part1 = I[118]
	I[109].Part0 = I[108]
	I[109].Part1 = I[118]
	I[111].Part0 = I[110]
	I[111].Part1 = I[118]
	I[113].Part0 = I[112]
	I[113].Part1 = I[118]
	I[115].Part0 = I[114]
	I[115].Part1 = I[118]
	I[117].Part0 = I[116]
	I[117].Part1 = I[118]
	I[240].Part0 = I[239]
	I[240].Part1 = I[253]
	I[254].Part0 = I[253]
	I[254].Part1 = I[124]
	I[255].Part0 = I[253]
	I[255].Part1 = I[245]
	I[256].Part0 = I[253]
	I[256].Part1 = I[122]
	I[257].Part0 = I[253]
	I[257].Part1 = I[144]
	I[258].Part0 = I[253]
	I[258].Part1 = I[154]
	I[259].Part0 = I[253]
	I[259].Part1 = I[136]
	I[260].Part0 = I[253]
	I[260].Part1 = I[172]
	I[261].Part0 = I[253]
	I[261].Part1 = I[146]
	I[262].Part0 = I[253]
	I[262].Part1 = I[235]
	I[263].Part0 = I[253]
	I[263].Part1 = I[174]
	I[264].Part0 = I[253]
	I[264].Part1 = I[140]
	I[265].Part0 = I[253]
	I[265].Part1 = I[229]
	I[266].Part0 = I[253]
	I[266].Part1 = I[206]
	I[267].Part0 = I[253]
	I[267].Part1 = I[243]
	I[268].Part0 = I[253]
	I[268].Part1 = I[142]
	I[269].Part0 = I[253]
	I[269].Part1 = I[176]
	I[270].Part0 = I[253]
	I[270].Part1 = I[134]
	I[271].Part0 = I[253]
	I[271].Part1 = I[138]
	I[272].Part0 = I[253]
	I[272].Part1 = I[249]
	I[273].Part0 = I[253]
	I[273].Part1 = I[130]
	I[274].Part0 = I[253]
	I[274].Part1 = I[148]
	I[275].Part0 = I[253]
	I[275].Part1 = I[237]
	I[276].Part0 = I[253]
	I[276].Part1 = I[150]
	I[277].Part0 = I[253]
	I[277].Part1 = I[321]
	I[278].Part0 = I[253]
	I[278].Part1 = I[152]
	I[279].Part0 = I[253]
	I[279].Part1 = I[186]
	I[280].Part0 = I[253]
	I[280].Part1 = I[162]
	I[281].Part0 = I[253]
	I[281].Part1 = I[166]
	I[282].Part0 = I[253]
	I[282].Part1 = I[170]
	I[283].Part0 = I[253]
	I[283].Part1 = I[223]
	I[284].Part0 = I[253]
	I[284].Part1 = I[178]
	I[285].Part0 = I[253]
	I[285].Part1 = I[202]
	I[286].Part0 = I[253]
	I[286].Part1 = I[192]
	I[287].Part0 = I[253]
	I[287].Part1 = I[219]
	I[288].Part0 = I[253]
	I[288].Part1 = I[188]
	I[289].Part0 = I[253]
	I[289].Part1 = I[164]
	I[290].Part0 = I[253]
	I[290].Part1 = I[215]
	I[291].Part0 = I[253]
	I[291].Part1 = I[156]
	I[292].Part0 = I[253]
	I[292].Part1 = I[204]
	I[293].Part0 = I[253]
	I[293].Part1 = I[168]
	I[294].Part0 = I[253]
	I[294].Part1 = I[217]
	I[295].Part0 = I[253]
	I[295].Part1 = I[194]
	I[296].Part0 = I[253]
	I[296].Part1 = I[212]
	I[297].Part0 = I[253]
	I[297].Part1 = I[198]
	I[298].Part0 = I[253]
	I[298].Part1 = I[182]
	I[299].Part0 = I[253]
	I[299].Part1 = I[196]
	I[300].Part0 = I[253]
	I[300].Part1 = I[190]
	I[301].Part0 = I[253]
	I[301].Part1 = I[200]
	I[302].Part0 = I[253]
	I[302].Part1 = I[241]
	I[303].Part0 = I[253]
	I[303].Part1 = I[231]
	I[304].Part0 = I[253]
	I[304].Part1 = I[251]
	I[305].Part0 = I[253]
	I[305].Part1 = I[210]
	I[306].Part0 = I[253]
	I[306].Part1 = I[160]
	I[307].Part0 = I[253]
	I[307].Part1 = I[180]
	I[308].Part0 = I[253]
	I[308].Part1 = I[247]
	I[309].Part0 = I[253]
	I[309].Part1 = I[184]
	I[310].Part0 = I[253]
	I[310].Part1 = I[233]
	I[311].Part0 = I[253]
	I[311].Part1 = I[208]
	I[312].Part0 = I[253]
	I[312].Part1 = I[225]
	I[313].Part0 = I[253]
	I[313].Part1 = I[221]
	I[314].Part0 = I[253]
	I[314].Part1 = I[158]
	I[315].Part0 = I[253]
	I[315].Part1 = I[126]
	I[316].Part0 = I[253]
	I[316].Part1 = I[253]
	I[317].Part0 = I[253]
	I[317].Part1 = I[214]
	I[318].Part0 = I[253]
	I[318].Part1 = I[128]
	I[319].Part0 = I[253]
	I[319].Part1 = I[132]
	I[320].Part0 = I[253]
	I[320].Part1 = I[227]
	return { I[1], I[2], I[119], I[323], I[328], I[332], I[357], I[358] }
end

return build

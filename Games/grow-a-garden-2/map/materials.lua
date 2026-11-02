-- Generated from map/materials.rbxm by _tools/rbxm2lua.luau
-- Material pack: parent the returned MaterialVariants to game.MaterialService

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
	I[1] = new("MaterialVariant", nil, "Weld 2x2 Plastic", { ColorMapContent = Content.fromUri("rbxassetid://93972722451997"), CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0), NormalMapContent = Content.fromUri("rbxassetid://102954553386109"), StudsPerTile = 2 })
	I[2] = new("MaterialVariant", nil, "Studs 2x2 Plastic Metal", { MetalnessMapContent = Content.fromUri("rbxassetid://79189537355801"), NormalMapContent = Content.fromUri("rbxassetid://17041450908"), RoughnessMapContent = Content.fromUri("rbxassetid://79189537355801"), StudsPerTile = 2 })
	I[3] = new("MaterialVariant", nil, "Studs 2x2 Plastic", { ColorMapContent = Content.fromUri("rbxassetid://17041454952"), NormalMapContent = Content.fromUri("rbxassetid://17041450908"), StudsPerTile = 2 })
	I[4] = new("MaterialVariant", nil, "Studs", { ColorMapContent = Content.fromUri("rbxassetid://6348166067"), StudsPerTile = 1 })
	I[5] = new("MaterialVariant", nil, "Stud Large", { ColorMapContent = Content.fromUri("rbxassetid://136280233530155"), NormalMapContent = Content.fromUri("rbxassetid://74719311227401"), StudsPerTile = 2 })
	I[6] = new("MaterialVariant", nil, "Stripes", { ColorMapContent = Content.fromUri("rbxassetid://72340092745092"), NormalMapContent = Content.fromUri("rbxassetid://128763504635081"), StudsPerTile = 2 })
	I[7] = new("MaterialVariant", nil, "SilverStudTexture", { ColorMapContent = Content.fromUri("rbxassetid://85723048896597"), MetalnessMapContent = Content.fromUri("rbxassetid://126937735421534"), RoughnessMapContent = Content.fromUri("rbxassetid://136550402130268"), StudsPerTile = 4 })
	I[8] = new("MaterialVariant", nil, "Really Reflective Metal", { BaseMaterial = Enum.Material.Metal, ColorMapContent = Content.fromUri("rbxassetid://8348649983"), MetalnessMapContent = Content.fromUri("rbxassetid://8348649671"), RoughnessMapContent = Content.fromUri("rbxassetid://8348649275") })
	I[9] = new("MaterialVariant", nil, "GoldStudTexture", { ColorMapContent = Content.fromUri("rbxassetid://132709865760953"), MetalnessMapContent = Content.fromUri("rbxassetid://126937735421534"), RoughnessMapContent = Content.fromUri("rbxassetid://136550402130268"), StudsPerTile = 4 })
	I[10] = new("MaterialVariant", nil, "Diamond", { ColorMapContent = Content.fromUri("rbxassetid://71051798499374"), MetalnessMapContent = Content.fromUri("rbxassetid://122323780355289"), RoughnessMapContent = Content.fromUri("rbxassetid://140500998924828"), StudsPerTile = 4 })
	I[11] = new("MaterialVariant", nil, "Circular Invert", { ColorMapContent = Content.fromUri("rbxassetid://102489649598290"), NormalMapContent = Content.fromUri("rbxassetid://87332381185050"), StudsPerTile = 2 })
	I[12] = new("MaterialVariant", nil, "Circular", { ColorMapContent = Content.fromUri("rbxassetid://110445392163179"), NormalMapContent = Content.fromUri("rbxassetid://87332381185050"), StudsPerTile = 2 })
	I[13] = new("MaterialVariant", nil, "Chocolate", { ColorMapContent = Content.fromUri("rbxassetid://88332812310067"), MetalnessMapContent = Content.fromUri("rbxassetid://122323780355289"), StudsPerTile = 4 })
	I[14] = new("Folder", nil, "ConsistentTexture")
		I[15] = new("MaterialVariant", I[14], "2022 Weld", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://10509843977"), NormalMapContent = Content.fromUri("rbxassetid://10509844001"), StudsPerTile = 2 })
		I[16] = new("MaterialVariant", I[14], "2022 Universal", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://10509840768"), NormalMapContent = Content.fromUri("rbxassetid://10509840812"), StudsPerTile = 2 })
		I[17] = new("MaterialVariant", I[14], "2022 Stud", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://10509831729"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 1 })
		I[18] = new("MaterialVariant", I[14], "2022 Inlet", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://10509827175"), EmissiveStrength = 44, NormalMapContent = Content.fromUri("rbxassetid://10509827228"), StudsPerTile = 1 })
		I[19] = new("MaterialVariant", I[14], "2022 Diamond Stud", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://10510052678"), NormalMapContent = Content.fromUri("rbxassetid://10510033893"), StudsPerTile = 1 })
	I[20] = new("MaterialVariant", nil, "2022 0.5 Stud", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://10509831729"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.5 })
	I[21] = new("MaterialVariant", nil, "StarInlet", { ColorMapContent = Content.fromUri("rbxassetid://10509831729"), EmissiveMaskContent = Content.fromUri("rbxassetid://75602717037119"), EmissiveStrength = 3, EmissiveTint = Color3.fromRGB(255, 238, 0), MetalnessMapContent = Content.fromUri("rbxassetid://8348649671"), NormalMapContent = Content.fromUri("rbxassetid://109372795352924"), RoughnessMapContent = Content.fromUri("rbxassetid://6954988400"), StudsPerTile = 1 })
	I[22] = new("Folder", nil, "ToolMaterials")
		I[23] = new("MaterialVariant", I[22], "GlowWeldTemplate", { ColorMapContent = Content.fromUri("rbxassetid://10509843977"), EmissiveMaskContent = Content.fromUri("rbxassetid://132155326"), EmissiveStrength = 0, NormalMapContent = Content.fromUri("rbxassetid://10509844001"), StudsPerTile = 2 })
		I[24] = new("MaterialVariant", I[22], "WeldGlow_Player_Vine", { ColorMapContent = Content.fromUri("rbxassetid://10509843977"), EmissiveMaskContent = Content.fromUri("rbxassetid://132155326"), EmissiveStrength = 0, NormalMapContent = Content.fromUri("rbxassetid://10509844001"), StudsPerTile = 2 })
	I[25] = new("MaterialVariant", nil, "2022 Stud Space", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://95398642214095"), EmissiveMaskContent = Content.fromUri("rbxassetid://112143904163782"), EmissiveStrength = 30, MetalnessMapContent = Content.fromUri("rbxassetid://136100742405149"), NormalMapContent = Content.fromUri("rbxassetid://115918917572719"), RoughnessMapContent = Content.fromUri("rbxassetid://122163109458323") })
	I[26] = new("MaterialVariant", nil, "2022 Stud Space (Lighter)", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://117758600332368"), EmissiveMaskContent = Content.fromUri("rbxassetid://112143904163782"), EmissiveStrength = 20, MetalnessMapContent = Content.fromUri("rbxassetid://136100742405149"), NormalMapContent = Content.fromUri("rbxassetid://115918917572719"), RoughnessMapContent = Content.fromUri("rbxassetid://122163109458323") })
	I[27] = new("MaterialVariant", nil, "2022 Stud+Neon", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://10509831729"), EmissiveMaskContent = Content.fromUri("rbxassetid://108157291715045"), EmissiveStrength = 2.25, NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 1 })
	I[28] = new("MaterialVariant", nil, "2022 Stud+Neon (Lighter)", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://10509831729"), EmissiveMaskContent = Content.fromUri("rbxassetid://108157291715045"), EmissiveStrength = 1.5, NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 1 })
	I[29] = new("MaterialVariant", nil, "2022 Stud LavaCracks", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://102954478598589"), EmissiveMaskContent = Content.fromUri("rbxassetid://94197179485784"), EmissiveStrength = 15, EmissiveTint = Color3.fromRGB(255, 31, 1), MetalnessMapContent = Content.fromUri("rbxassetid://136100742405149"), NormalMapContent = Content.fromUri("rbxassetid://115918917572719"), RoughnessMapContent = Content.fromUri("rbxassetid://122163109458323"), StudsPerTile = 8 })
	I[30] = new("Folder", nil, "EggMaterials")
		I[31] = new("MaterialVariant", I[30], "2022 Weld Egg", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://10509843977"), NormalMapContent = Content.fromUri("rbxassetid://10509844001"), StudsPerTile = 2 })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[20], I[21], I[22], I[25], I[26], I[27], I[28], I[29], I[30] }
end

return build

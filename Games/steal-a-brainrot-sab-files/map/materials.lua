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
	I[1] = new("Folder", nil, "Clover")
		I[2] = new("MaterialVariant", I[1], "Clover Strawberry Stud Dark", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://124229047189037"), EmissiveMaskContent = Content.fromUri("rbxassetid://126075034728036"), EmissiveStrength = 10, NormalMapContent = Content.fromUri("rbxassetid://113466116771893"), StudsPerTile = 1.5 })
		I[3] = new("MaterialVariant", I[1], "Clover Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://135208504351838"), EmissiveMaskContent = Content.fromUri("rbxassetid://126075034728036"), EmissiveStrength = 10, NormalMapContent = Content.fromUri("rbxassetid://113466116771893"), StudsPerTile = 1.5 })
		I[4] = new("MaterialVariant", I[1], "Clover Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://133993206184627"), EmissiveMaskContent = Content.fromUri("rbxassetid://126075034728036"), EmissiveStrength = 10, EmissiveTint = Color3.fromRGB(149, 149, 149), NormalMapContent = Content.fromUri("rbxassetid://106140277689536"), StudsPerTile = 1.5 })
		I[5] = new("MaterialVariant", I[1], "Clover Stud2", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://114253201388191"), EmissiveMaskContent = Content.fromUri("rbxassetid://126075034728036"), EmissiveStrength = 10, EmissiveTint = Color3.fromRGB(149, 149, 149), NormalMapContent = Content.fromUri("rbxassetid://106140277689536"), StudsPerTile = 1.5 })
	I[6] = new("Folder", nil, "Cyber")
		I[7] = new("MaterialVariant", I[6], "Tech Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://92036789311618"), EmissiveMaskContent = Content.fromUri("rbxassetid://116124939797605"), EmissiveStrength = 500, EmissiveTint = Color3.fromRGB(83, 201, 255), NormalMapContent = Content.fromUri("rbxassetid://98079401021643"), StudsPerTile = 1.992 })
		I[8] = new("MaterialVariant", I[6], "2022 Stud Tech", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://76272216757124"), EmissiveMaskContent = Content.fromUri("rbxassetid://119930564750769"), EmissiveStrength = 50, EmissiveTint = Color3.fromRGB(83, 201, 255), NormalMapContent = Content.fromUri("rbxassetid://114867751007089"), StudsPerTile = 3.4000001 })
	I[9] = new("MaterialVariant", nil, "2022 Small Stud", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://10509831729"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.5 })
	I[10] = new("MaterialVariant", nil, "2022 Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://10509831729"), CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 1 })
	I[11] = new("MaterialVariant", nil, "2022 Weld", { ColorMapContent = Content.fromUri("rbxassetid://10509843977"), NormalMapContent = Content.fromUri("rbxassetid://10509844001"), StudsPerTile = 2 })
	I[12] = new("MaterialVariant", nil, "Chocolate Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://121755649537101"), NormalMapContent = Content.fromUri("rbxassetid://89895840517099"), StudsPerTile = 0.498 })
	I[13] = new("MaterialVariant", nil, "Cursed Base Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://108731297568181"), EmissiveMaskContent = Content.fromUri("rbxassetid://70778895190452"), EmissiveStrength = 10, NormalMapContent = Content.fromUri("rbxassetid://113984237183896"), StudsPerTile = 4 })
	I[14] = new("MaterialVariant", nil, "Cursed Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://116943672632887"), EmissiveMaskContent = Content.fromUri("rbxassetid://70778895190452"), EmissiveStrength = 10, NormalMapContent = Content.fromUri("rbxassetid://87204365839409"), StudsPerTile = 1.5 })
	I[15] = new("MaterialVariant", nil, "Custom Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://10509831729"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.498 })
		I[16] = new("Texture", I[15], "ColorMap", { TextureContent = Content.fromUri("rbxassetid://130690925951267") })
	I[17] = new("MaterialVariant", nil, "Custom Stud Small", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://10509831729"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.2 })
	I[18] = new("MaterialVariant", nil, "Divine Base Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://110953440402844"), EmissiveMaskContent = Content.fromUri("rbxassetid://97321640440101"), EmissiveStrength = 10, EmissiveTint = Color3.fromRGB(255, 238, 0), NormalMapContent = Content.fromUri("rbxassetid://87204365839409"), StudsPerTile = 4 })
	I[19] = new("MaterialVariant", nil, "Divine Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://101708113552886"), EmissiveMaskContent = Content.fromUri("rbxassetid://115833962418206"), EmissiveStrength = 10, NormalMapContent = Content.fromUri("rbxassetid://87204365839409"), StudsPerTile = 1.5 })
	I[20] = new("MaterialVariant", nil, "Divine Stud bkp", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://106233665283948"), EmissiveMaskContent = Content.fromUri("rbxassetid://115833962418206"), EmissiveStrength = 10, NormalMapContent = Content.fromUri("rbxassetid://87204365839409"), StudsPerTile = 1.5 })
	I[21] = new("MaterialVariant", nil, "Galaxy Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://134532344152111"), NormalMapContent = Content.fromUri("rbxassetid://124442674121229"), StudsPerTile = 0.498 })
	I[22] = new("MaterialVariant", nil, "Galaxy Stud Big", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://134532344152111"), NormalMapContent = Content.fromUri("rbxassetid://124442674121229"), StudsPerTile = 1 })
	I[23] = new("MaterialVariant", nil, "Radioactive Strawberry Stud Dark", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://119846431607653"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	I[24] = new("MaterialVariant", nil, "Radioactive Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://122000920603683"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	I[25] = new("MaterialVariant", nil, "Radioactive Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://102777229794875"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.498 })
	I[26] = new("MaterialVariant", nil, "Radioactive Stud 3", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://136815014637186"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 1 })
	I[27] = new("MaterialVariant", nil, "Radioactive Stud 4", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://102777229794875"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 1 })
	I[28] = new("MaterialVariant", nil, "Radioactive Stud2", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://136815014637186"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.498 })
	I[29] = new("Folder", nil, "Strawberry")
		I[30] = new("MaterialVariant", I[29], "Strawberry Stud Dark", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://131945494679769"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[31] = new("MaterialVariant", I[29], "Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://110134906787555"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[32] = new("MaterialVariant", I[29], "Strawberry Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://110134906787555"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 1 })
		I[33] = new("MaterialVariant", I[29], "Gold Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://120227109344755"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[34] = new("MaterialVariant", I[29], "Diamond Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://79759724456957"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[35] = new("MaterialVariant", I[29], "Bloodrot Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://101011087393800"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[36] = new("MaterialVariant", I[29], "Candy Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://111520824940445"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[37] = new("MaterialVariant", I[29], "Lava Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://74655630940824"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[38] = new("MaterialVariant", I[29], "Galaxy Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://130864141383306"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[39] = new("MaterialVariant", I[29], "Strawberry Stud1", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://110134906787555"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[40] = new("MaterialVariant", I[29], "YinYang Strawberry Stud Dark", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://85140203782852"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[41] = new("MaterialVariant", I[29], "YinYang Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://113182343427826"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[42] = new("MaterialVariant", I[29], "Cursed Strawberry Stud Dark", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://86934292500465"), EmissiveMaskContent = Content.fromUri("rbxassetid://70778895190452"), EmissiveStrength = 10, NormalMapContent = Content.fromUri("rbxassetid://87204365839409"), StudsPerTile = 1.5 })
		I[43] = new("MaterialVariant", I[29], "Cursed Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://92908574591735"), EmissiveMaskContent = Content.fromUri("rbxassetid://70778895190452"), EmissiveStrength = 10, NormalMapContent = Content.fromUri("rbxassetid://87204365839409"), StudsPerTile = 1.5 })
		I[44] = new("MaterialVariant", I[29], "Chocolate Strawberry Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://133493309893320"), NormalMapContent = Content.fromUri("rbxassetid://113466116771893"), StudsPerTile = 0.498 })
		I[45] = new("MaterialVariant", I[29], "Divine Strawberry Stud Dark", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://112741924598541"), EmissiveMaskContent = Content.fromUri("rbxassetid://112741924598541"), EmissiveStrength = 9.1000004, EmissiveTint = Color3.fromRGB(255, 238, 0), NormalMapContent = Content.fromUri("rbxassetid://87204365839409"), StudsPerTile = 1.5 })
		I[46] = new("MaterialVariant", I[29], "Divine Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://96736495139709"), EmissiveMaskContent = Content.fromUri("rbxassetid://112741924598541"), EmissiveStrength = 10, EmissiveTint = Color3.fromRGB(255, 238, 0), NormalMapContent = Content.fromUri("rbxassetid://101800277584788"), StudsPerTile = 1.5 })
		I[47] = new("MaterialVariant", I[29], "Cyber Strawberry Stud Dark", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://132283943366276"), EmissiveMaskContent = Content.fromUri("rbxassetid://100735389419482"), EmissiveStrength = 40, EmissiveTint = Color3.fromRGB(83, 201, 255), NormalMapContent = Content.fromUri("rbxassetid://98079401021643"), StudsPerTile = 1.992 })
		I[48] = new("MaterialVariant", I[29], "Cyber Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://132283943366276"), EmissiveMaskContent = Content.fromUri("rbxassetid://100735389419482"), EmissiveStrength = 500, EmissiveTint = Color3.fromRGB(13, 32, 40), NormalMapContent = Content.fromUri("rbxassetid://98079401021643"), StudsPerTile = 1.992 })
	I[49] = new("MaterialVariant", nil, "GoldStudTexture", { ColorMapContent = Content.fromUri("rbxassetid://132709865760953"), MetalnessMapContent = Content.fromUri("rbxassetid://126937735421534"), RoughnessMapContent = Content.fromUri("rbxassetid://136550402130268"), StudsPerTile = 4 })
	I[50] = new("MaterialVariant", nil, "Studs", { ColorMapContent = Content.fromUri("rbxassetid://6348166067"), StudsPerTile = 1 })
	I[51] = new("MaterialVariant", nil, "BackroomsWallpaper", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://75523384018126"), NormalMapContent = Content.fromUri("rbxassetid://130380537995973"), StudsPerTile = 6 })
	I[52] = new("MaterialVariant", nil, "BackroomsCeiling", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://86138171157953"), NormalMapContent = Content.fromUri("rbxassetid://116047527491091"), StudsPerTile = 5 })
	I[53] = new("Folder", nil, "Diamond")
		I[54] = new("MaterialVariant", I[53], "Diamond Stud2", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://100436741415479"), StudsPerTile = 0.5 })
		I[55] = new("MaterialVariant", I[53], "Diamond Stud Big", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://100436741415479"), EmissiveMaskContent = Content.fromUri("rbxassetid://70461666380062"), EmissiveStrength = 15, StudsPerTile = 2 })
		I[56] = new("MaterialVariant", I[53], "Diamond Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://100436741415479"), EmissiveMaskContent = Content.fromUri("rbxassetid://70461666380062"), EmissiveStrength = 10, StudsPerTile = 0.5 })
		I[57] = new("MaterialVariant", I[53], "Diamond Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://79759724456957"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	return { I[1], I[6], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[49], I[50], I[51], I[52], I[53] }
end

return build

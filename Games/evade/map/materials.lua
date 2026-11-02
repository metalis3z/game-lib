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
	I[1] = new("Folder", nil, "Folder")
		I[2] = new("MaterialVariant", I[1], "Strawberry Stud Dark", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://131945494679769"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[3] = new("MaterialVariant", I[1], "Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://110134906787555"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[4] = new("MaterialVariant", I[1], "Strawberry Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://110134906787555"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 1 })
		I[5] = new("MaterialVariant", I[1], "Gold Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://120227109344755"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[6] = new("MaterialVariant", I[1], "Diamond Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://79759724456957"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[7] = new("MaterialVariant", I[1], "Bloodrot Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://101011087393800"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[8] = new("MaterialVariant", I[1], "Candy Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://111520824940445"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[9] = new("MaterialVariant", I[1], "Lava Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://74655630940824"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[10] = new("MaterialVariant", I[1], "Galaxy Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://130864141383306"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
		I[11] = new("MaterialVariant", I[1], "Strawberry Stud1", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://110134906787555"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	I[12] = new("MaterialVariant", nil, "2022 Small Stud", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://10509831729"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.5 })
	I[13] = new("MaterialVariant", nil, "2022 Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://10509831729"), CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 1 })
	I[14] = new("MaterialVariant", nil, "2022 Weld", { ColorMapContent = Content.fromUri("rbxassetid://10509843977"), NormalMapContent = Content.fromUri("rbxassetid://10509844001"), StudsPerTile = 2 })
	I[15] = new("MaterialVariant", nil, "Bloodrot Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://101011087393800"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	I[16] = new("MaterialVariant", nil, "Candy Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://111520824940445"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	I[17] = new("MaterialVariant", nil, "Custom Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://10509831729"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.498 })
	I[18] = new("MaterialVariant", nil, "Custom Stud Small", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://10509831729"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.2 })
	I[19] = new("MaterialVariant", nil, "Diamond Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://79759724456957"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	I[20] = new("MaterialVariant", nil, "Galaxy Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://130864141383306"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	I[21] = new("MaterialVariant", nil, "Galaxy Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://134532344152111"), NormalMapContent = Content.fromUri("rbxassetid://124442674121229"), StudsPerTile = 0.498 })
	I[22] = new("MaterialVariant", nil, "Galaxy Stud Big", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://134532344152111"), NormalMapContent = Content.fromUri("rbxassetid://124442674121229"), StudsPerTile = 1 })
	I[23] = new("MaterialVariant", nil, "Gold Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://120227109344755"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	I[24] = new("MaterialVariant", nil, "Lava Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://74655630940824"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	I[25] = new("MaterialVariant", nil, "Radioactive Strawberry Stud Dark", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://119846431607653"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	I[26] = new("MaterialVariant", nil, "Radioactive Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://122000920603683"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	I[27] = new("MaterialVariant", nil, "Radioactive Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://102777229794875"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.498 })
	I[28] = new("MaterialVariant", nil, "Radioactive Stud 3", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://136815014637186"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 1 })
	I[29] = new("MaterialVariant", nil, "Radioactive Stud 4", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://102777229794875"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 1 })
	I[30] = new("MaterialVariant", nil, "Radioactive Stud2", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://136815014637186"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.498 })
	I[31] = new("MaterialVariant", nil, "Strawberry Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://110134906787555"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 1 })
	I[32] = new("MaterialVariant", nil, "Strawberry Stud Dark", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://131945494679769"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	I[33] = new("MaterialVariant", nil, "Strawberry Stud Light", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://110134906787555"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	I[34] = new("MaterialVariant", nil, "Strawberry Stud1", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://110134906787555"), NormalMapContent = Content.fromUri("rbxassetid://139606391095689"), StudsPerTile = 0.498 })
	return { I[1], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], I[33], I[34] }
end

return build

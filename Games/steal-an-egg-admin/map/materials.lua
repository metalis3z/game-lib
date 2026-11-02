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
	I[1] = new("MaterialVariant", nil, "Custom Stud 100%", { BaseMaterial = Enum.Material.SmoothPlastic, CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0), MetalnessMapContent = Content.fromUri("rbxassetid://11454131582"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), RoughnessMapContent = Content.fromUri("rbxassetid://11454603161"), StudsPerTile = 0.5 })
	I[2] = new("MaterialVariant", nil, "MetalFineGold", { BaseMaterial = Enum.Material.Metal, MetalnessMapContent = Content.fromUri("rbxassetid://11454131582"), NormalMapContent = Content.fromUri("rbxassetid://11454131529"), RoughnessMapContent = Content.fromUri("rbxassetid://11454603161") })
	I[3] = new("MaterialVariant", nil, "Studs", { ColorMapContent = Content.fromUri("rbxassetid://99768478998077"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 1 }, { ["OldId"] = "rbxassetid://10509831729" })
	I[4] = new("MaterialVariant", nil, "PinkSpaceVoid", { BaseMaterial = Enum.Material.Brick, ColorMapContent = Content.fromUri("rbxassetid://106100563180989"), MetalnessMapContent = Content.fromUri("rbxassetid://105992800327859"), NormalMapContent = Content.fromUri("rbxassetid://97060849368384"), RoughnessMapContent = Content.fromUri("rbxassetid://106054512711280"), StudsPerTile = 3.9000001 }, { ["OldId"] = "rbxassetid://97797596319706" })
	I[5] = new("MaterialVariant", nil, "Lava 1", { BaseMaterial = Enum.Material.CrackedLava, ColorMapContent = Content.fromUri("rbxassetid://95300517140470"), MetalnessMapContent = Content.fromUri("rbxassetid://15333149951"), NormalMapContent = Content.fromUri("rbxassetid://15333150117"), RoughnessMapContent = Content.fromUri("rbxassetid://15333150083") }, { ["OldId"] = "rbxassetid://15333150234" })
	I[6] = new("MaterialVariant", nil, "Inlet", { ColorMapContent = Content.fromUri("rbxassetid://95901672942321"), NormalMapContent = Content.fromUri("rbxassetid://10509827228"), StudsPerTile = 1 }, { ["OldId"] = "rbxassetid://10509827175" })
	I[7] = new("MaterialVariant", nil, "Custom Stud Small", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://99768478998077"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.2 }, { ["OldId"] = "rbxassetid://10509831729" })
	I[8] = new("MaterialVariant", nil, "Custom Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://99768478998077"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.498 }, { ["OldId"] = "rbxassetid://10509831729" })
	I[9] = new("MaterialVariant", nil, "2022 Weld", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://131339104408297"), NormalMapContent = Content.fromUri("rbxassetid://10509844001"), StudsPerTile = 0.5 }, { ["OldId"] = "rbxassetid://10509843977" })
	I[10] = new("MaterialVariant", nil, "2022 Universal", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://100072532530970"), NormalMapContent = Content.fromUri("rbxassetid://10509840812"), StudsPerTile = 2 }, { ["OldId"] = "rbxassetid://10509840768" })
	I[11] = new("MaterialVariant", nil, "2022 Stud S", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://99768478998077"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.5 }, { ["OldId"] = "rbxassetid://10509831729" })
	I[12] = new("MaterialVariant", nil, "2022 Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://99768478998077"), CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.85 }, { ["OldId"] = "rbxassetid://10509831729" })
	I[13] = new("MaterialVariant", nil, "2008 Weld", { ColorMapContent = Content.fromUri("rbxassetid://97758302531589"), NormalMapContent = Content.fromUri("rbxassetid://10509703576"), StudsPerTile = 2 }, { ["OldId"] = "rbxassetid://10509703570" })
	I[14] = new("MaterialVariant", nil, "2", { ColorMapContent = Content.fromUri("rbxassetid://119924016158966") }, { ["OldId"] = "rbxassetid://89333620948681" })
	I[15] = new("MaterialVariant", nil, "stud4", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://99768478998077"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 2 }, { ["OldId"] = "rbxassetid://10509831729" })
	I[16] = new("MaterialVariant", nil, "stud3", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://99768478998077"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.25 }, { ["OldId"] = "rbxassetid://10509831729" })
	I[17] = new("MaterialVariant", nil, "stud2", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://99768478998077"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 4 }, { ["OldId"] = "rbxassetid://10509831729" })
	I[18] = new("MaterialVariant", nil, "small stud", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://99768478998077"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.5 }, { ["OldId"] = "rbxassetid://10509831729" })
	I[19] = new("MaterialVariant", nil, "egg Stud", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://99768478998077"), CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.85 }, { ["OldId"] = "rbxassetid://10509831729" })
	I[20] = new("MaterialVariant", nil, "Weld 2x2 Smooth", { ColorMapContent = Content.fromUri("rbxassetid://131025312607479"), NormalMapContent = Content.fromUri("rbxassetid://128370512195399"), RoughnessMapContent = Content.fromUri("rbxassetid://16274306842"), StudsPerTile = 2 }, { ["OldId"] = "rbxassetid://93972722451997" })
	I[21] = new("MaterialVariant", nil, "Weld 2x2 Smooth", { ColorMapContent = Content.fromUri("rbxassetid://131025312607479"), CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0), NormalMapContent = Content.fromUri("rbxassetid://128370512195399"), StudsPerTile = 1 }, { ["OldId"] = "rbxassetid://93972722451997" })
	I[22] = new("MaterialVariant", nil, "Weld 2x2 Plastic", { ColorMapContent = Content.fromUri("rbxassetid://131025312607479"), CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0), NormalMapContent = Content.fromUri("rbxassetid://102954553386109"), StudsPerTile = 2 }, { ["OldId"] = "rbxassetid://93972722451997" })
	I[23] = new("MaterialVariant", nil, "Water", { ColorMapContent = Content.fromUri("rbxassetid://101721577166403"), NormalMapContent = Content.fromUri("rbxassetid://45726883") }, { ["OldId"] = "rbxassetid://9825462807" })
	I[24] = new("MaterialVariant", nil, "Universal bIG Smooth", { ColorMapContent = Content.fromUri("rbxassetid://82712398573276"), NormalMapContent = Content.fromUri("rbxassetid://17041681701"), StudsPerTile = 2 }, { ["OldId"] = "rbxassetid://17041681086" })
	I[25] = new("MaterialVariant", nil, "Universal 2x2 Smooth", { ColorMapContent = Content.fromUri("rbxassetid://82712398573276"), NormalMapContent = Content.fromUri("rbxassetid://17041681701"), StudsPerTile = 1 }, { ["OldId"] = "rbxassetid://17041681086" })
	I[26] = new("MaterialVariant", nil, "StudsWithTile", { ColorMapContent = Content.fromUri("rbxassetid://99927396049338"), NormalMapContent = Content.fromUri("rbxassetid://76228360307047"), StudsPerTile = 2 }, { ["OldId"] = "rbxassetid://136463303788033" })
	I[27] = new("MaterialVariant", nil, "StudsWeak", { ColorMapContent = Content.fromUri("rbxassetid://97396013583836"), CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0), StudsPerTile = 1 }, { ["OldId"] = "rbxassetid://6348166067" })
	I[28] = new("MaterialVariant", nil, "Studs1", { ColorMapContent = Content.fromUri("rbxassetid://126476405295361"), NormalMapContent = Content.fromUri("rbxassetid://17041673076"), StudsPerTile = 2 }, { ["OldId"] = "rbxassetid://17041671432" })
	I[29] = new("MaterialVariant", nil, "Studs 4x4 Plastic", { ColorMapContent = Content.fromUri("rbxassetid://140408321969963"), NormalMapContent = Content.fromUri("rbxassetid://17041634582"), RoughnessMapContent = Content.fromUri("rbxassetid://16274306842"), StudsPerTile = 4 }, { ["OldId"] = "rbxassetid://17041606681" })
	I[30] = new("MaterialVariant", nil, "Studs 2x2 Smooth", { ColorMapContent = Content.fromUri("rbxassetid://126476405295361"), NormalMapContent = Content.fromUri("rbxassetid://17041673076"), RoughnessMapContent = Content.fromUri("rbxassetid://16274306842"), StudsPerTile = 2 }, { ["OldId"] = "rbxassetid://17041671432" })
	I[31] = new("MaterialVariant", nil, "Studs 2x2 Plastic", { ColorMapContent = Content.fromUri("rbxassetid://123436782763996"), NormalMapContent = Content.fromUri("rbxassetid://17041450908"), RoughnessMapContent = Content.fromUri("rbxassetid://16274306842"), StudsPerTile = 2 }, { ["OldId"] = "rbxassetid://17041454952" })
	I[32] = new("MaterialVariant", nil, "Studs", { ColorMapContent = Content.fromUri("rbxassetid://99768478998077"), CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.5 }, { ["OldId"] = "rbxassetid://10509831729" })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32] }
end

return build

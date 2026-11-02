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
	I[1] = new("Sky", nil, "Sky", { MoonAngularSize = 40, MoonTextureContent = Content.fromUri("rbxassetid://113988199073809"), SunAngularSize = 40, SunTextureContent = Content.fromUri("rbxassetid://113988199073809") })
	I[2] = new("Folder", nil, "2021 Mats")
		I[3] = new("MaterialVariant", I[2], "21_Granite", { BaseMaterial = Enum.Material.Granite, ColorMapContent = Content.fromUri("rbxassetid://7547164400"), CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0), NormalMapContent = Content.fromUri("rbxassetid://7546654648"), RoughnessMapContent = Content.fromUri("rbxassetid://7547164660") })
		I[4] = new("MaterialVariant", I[2], "21_Basalt", { BaseMaterial = Enum.Material.Basalt, ColorMapContent = Content.fromUri("rbxassetid://9920482056"), NormalMapContent = Content.fromUri("rbxassetid://9438412214"), RoughnessMapContent = Content.fromUri("rbxassetid://9438412457") })
		I[5] = new("MaterialVariant", I[2], "21_CorrodedMetal", { BaseMaterial = Enum.Material.CorrodedMetal, ColorMapContent = Content.fromUri("rbxassetid://7547183598"), MaterialPattern = Enum.MaterialPattern.Organic, MetalnessMapContent = Content.fromUri("rbxassetid://7547184321"), NormalMapContent = Content.fromUri("rbxassetid://7547181182"), RoughnessMapContent = Content.fromUri("rbxassetid://7547184588") })
		I[6] = new("MaterialVariant", I[2], "21_DiamondPlate", { BaseMaterial = Enum.Material.DiamondPlate, ColorMapContent = Content.fromUri("rbxassetid://7546654401"), MetalnessMapContent = Content.fromUri("rbxassetid://9438583347"), NormalMapContent = Content.fromUri("rbxassetid://7546654536"), RoughnessMapContent = Content.fromUri("rbxassetid://7547162137"), StudsPerTile = 8 })
		I[7] = new("MaterialVariant", I[2], "21_Asphalt", { BaseMaterial = Enum.Material.Asphalt, ColorMapContent = Content.fromUri("rbxassetid://9930003046"), NormalMapContent = Content.fromUri("rbxassetid://9429449876"), RoughnessMapContent = Content.fromUri("rbxassetid://9429450346") })
		I[8] = new("MaterialVariant", I[2], "21_Grass", { BaseMaterial = Enum.Material.Grass, ColorMapContent = Content.fromUri("rbxassetid://7547167347"), NormalMapContent = Content.fromUri("rbxassetid://7547168653"), RoughnessMapContent = Content.fromUri("rbxassetid://7547169207") })
		I[9] = new("MaterialVariant", I[2], "21_Metal", { BaseMaterial = Enum.Material.Metal, ColorMapContent = Content.fromUri("rbxassetid://7547178395"), MetalnessMapContent = Content.fromUri("rbxassetid://7547288112"), NormalMapContent = Content.fromUri("rbxassetid://7547287997"), RoughnessMapContent = Content.fromUri("rbxassetid://7547179082") })
		I[10] = new("MaterialVariant", I[2], "21_Brick", { BaseMaterial = Enum.Material.Brick, ColorMapContent = Content.fromUri("rbxassetid://7546648254"), NormalMapContent = Content.fromUri("rbxassetid://7546649654"), RoughnessMapContent = Content.fromUri("rbxassetid://7546650017") })
		I[11] = new("MaterialVariant", I[2], "21_Salt", { BaseMaterial = Enum.Material.Salt, ColorMapContent = Content.fromUri("rbxassetid://9920590225"), NormalMapContent = Content.fromUri("rbxassetid://9439565809") })
		I[12] = new("MaterialVariant", I[2], "21_Mud", { BaseMaterial = Enum.Material.Mud, ColorMapContent = Content.fromUri("rbxassetid://9920578473"), NormalMapContent = Content.fromUri("rbxassetid://9439509827"), RoughnessMapContent = Content.fromUri("rbxassetid://9439510012") })
		I[13] = new("MaterialVariant", I[2], "21_Cobblestone", { BaseMaterial = Enum.Material.Cobblestone, ColorMapContent = Content.fromUri("rbxassetid://7546651802"), NormalMapContent = Content.fromUri("rbxassetid://7546652689"), RoughnessMapContent = Content.fromUri("rbxassetid://7546652892") })
		I[14] = new("MaterialVariant", I[2], "21_Rock", { BaseMaterial = Enum.Material.Rock, ColorMapContent = Content.fromUri("rbxassetid://9920587470"), NormalMapContent = Content.fromUri("rbxassetid://9439538417"), RoughnessMapContent = Content.fromUri("rbxassetid://9439545859") })
		I[15] = new("MaterialVariant", I[2], "21_Wood", { BaseMaterial = Enum.Material.Wood, ColorMapContent = Content.fromUri("rbxassetid://7547190453"), MetalnessMapContent = Content.fromUri("rbxassetid://7547190619"), NormalMapContent = Content.fromUri("rbxassetid://7547190548"), RoughnessMapContent = Content.fromUri("rbxassetid://7547303147") })
		I[16] = new("MaterialVariant", I[2], "21_Sandstone", { BaseMaterial = Enum.Material.Sandstone, ColorMapContent = Content.fromUri("rbxassetid://9920596120"), NormalMapContent = Content.fromUri("rbxassetid://9439596530"), RoughnessMapContent = Content.fromUri("rbxassetid://9439596711") })
		I[17] = new("MaterialVariant", I[2], "21_Slate", { BaseMaterial = Enum.Material.Slate, ColorMapContent = Content.fromUri("rbxassetid://7547297050"), NormalMapContent = Content.fromUri("rbxassetid://7547297808"), RoughnessMapContent = Content.fromUri("rbxassetid://7547298051") })
		I[18] = new("MaterialVariant", I[2], "21_Concrete", { BaseMaterial = Enum.Material.Concrete, ColorMapContent = Content.fromUri("rbxassetid://7546653328"), NormalMapContent = Content.fromUri("rbxassetid://7546653707"), RoughnessMapContent = Content.fromUri("rbxassetid://7546653868") })
		I[19] = new("MaterialVariant", I[2], "21_Limestone", { BaseMaterial = Enum.Material.Limestone, ColorMapContent = Content.fromUri("rbxassetid://9920561437"), NormalMapContent = Content.fromUri("rbxassetid://9439415191"), RoughnessMapContent = Content.fromUri("rbxassetid://9439415495") })
		I[20] = new("MaterialVariant", I[2], "21_Foil", { BaseMaterial = Enum.Material.Foil, ColorMapContent = Content.fromUri("rbxassetid://7546644642"), MetalnessMapContent = Content.fromUri("rbxassetid://7546644642"), NormalMapContent = Content.fromUri("rbxassetid://7546644903"), RoughnessMapContent = Content.fromUri("rbxassetid://7546644963") })
		I[21] = new("MaterialVariant", I[2], "21_Pebble", { BaseMaterial = Enum.Material.Pebble, ColorMapContent = Content.fromUri("rbxassetid://7547291174"), NormalMapContent = Content.fromUri("rbxassetid://7546645052"), RoughnessMapContent = Content.fromUri("rbxassetid://7547291306") })
		I[22] = new("MaterialVariant", I[2], "21_Sand", { BaseMaterial = Enum.Material.Sand, ColorMapContent = Content.fromUri("rbxassetid://7547294684"), NormalMapContent = Content.fromUri("rbxassetid://7547294810"), RoughnessMapContent = Content.fromUri("rbxassetid://7547295087") })
		I[23] = new("MaterialVariant", I[2], "21_Pavement", { BaseMaterial = Enum.Material.Pavement, ColorMapContent = Content.fromUri("rbxassetid://9920579943"), NormalMapContent = Content.fromUri("rbxassetid://9439519281"), RoughnessMapContent = Content.fromUri("rbxassetid://9439519532") })
		I[24] = new("MaterialVariant", I[2], "21_WoodPlanks", { BaseMaterial = Enum.Material.WoodPlanks, ColorMapContent = Content.fromUri("rbxassetid://7547301709"), MetalnessMapContent = Content.fromUri("rbxassetid://7547188891"), NormalMapContent = Content.fromUri("rbxassetid://7547188159"), RoughnessMapContent = Content.fromUri("rbxassetid://7547332869") })
		I[25] = new("MaterialVariant", I[2], "21_Marble", { BaseMaterial = Enum.Material.Marble, ColorMapContent = Content.fromUri("rbxassetid://7547174345"), NormalMapContent = Content.fromUri("rbxassetid://7547176060"), RoughnessMapContent = Content.fromUri("rbxassetid://7547177213") })
		I[26] = new("MaterialVariant", I[2], "21_CrackedLava", { BaseMaterial = Enum.Material.CrackedLava, ColorMapContent = Content.fromUri("rbxassetid://9920484943"), NormalMapContent = Content.fromUri("rbxassetid://9438508790"), RoughnessMapContent = Content.fromUri("rbxassetid://9438509046") })
		I[27] = new("MaterialVariant", I[2], "21_Glacier", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://9920518732"), NormalMapContent = Content.fromUri("rbxassetid://9438812958"), RoughnessMapContent = Content.fromUri("rbxassetid://9438851286") })
		I[28] = new("MaterialVariant", I[2], "21_Fabric", { BaseMaterial = Enum.Material.Fabric, ColorMapContent = Content.fromUri("rbxassetid://7547100606"), NormalMapContent = Content.fromUri("rbxassetid://7547100915"), RoughnessMapContent = Content.fromUri("rbxassetid://7547101072") })
		I[29] = new("MaterialVariant", I[2], "21_Snow", { BaseMaterial = Enum.Material.Snow, ColorMapContent = Content.fromUri("rbxassetid://9920620284"), NormalMapContent = Content.fromUri("rbxassetid://9439632006"), RoughnessMapContent = Content.fromUri("rbxassetid://9439632145") })
		I[30] = new("MaterialVariant", I[2], "21_LeafyGrass", { BaseMaterial = Enum.Material.LeafyGrass, ColorMapContent = Content.fromUri("rbxassetid://9920557906"), MetalnessMapContent = Content.fromUri("rbxassetid://9439080950"), NormalMapContent = Content.fromUri("rbxassetid://9439080781") })
		I[31] = new("MaterialVariant", I[2], "21_Ice", { BaseMaterial = Enum.Material.Ice, ColorMapContent = Content.fromUri("rbxassetid://7546644642"), NormalMapContent = Content.fromUri("rbxassetid://7547171198"), RoughnessMapContent = Content.fromUri("rbxassetid://7547171276") })
		I[32] = new("MaterialVariant", I[2], "21_Ground", { BaseMaterial = Enum.Material.Ground, ColorMapContent = Content.fromUri("rbxassetid://9920554482"), NormalMapContent = Content.fromUri("rbxassetid://9439043558"), RoughnessMapContent = Content.fromUri("rbxassetid://9439043765") })
	return { I[1], I[2] }
end

return build

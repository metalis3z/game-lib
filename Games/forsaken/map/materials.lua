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
	I[2] = new("Folder", nil, "2022 Mats")
		I[3] = new("MaterialVariant", I[2], "22_Granite", { BaseMaterial = Enum.Material.Granite, ColorMapContent = Content.fromUri("rbxassetid://9920550238"), NormalMapContent = Content.fromUri("rbxassetid://9438882935"), RoughnessMapContent = Content.fromUri("rbxassetid://9438883109") })
		I[4] = new("MaterialVariant", I[2], "22_Basalt", { BaseMaterial = Enum.Material.Basalt, ColorMapContent = Content.fromUri("rbxassetid://9920482056"), NormalMapContent = Content.fromUri("rbxassetid://9438412214"), RoughnessMapContent = Content.fromUri("rbxassetid://9438412457") })
		I[5] = new("MaterialVariant", I[2], "22_CorrodedMetal", { BaseMaterial = Enum.Material.CorrodedMetal, ColorMapContent = Content.fromUri("rbxassetid://9920589327"), MetalnessMapContent = Content.fromUri("rbxassetid://9439548749"), NormalMapContent = Content.fromUri("rbxassetid://9439548484"), RoughnessMapContent = Content.fromUri("rbxassetid://9439556441") })
		I[6] = new("MaterialVariant", I[2], "22_DiamondPlate", { BaseMaterial = Enum.Material.DiamondPlate, ColorMapContent = Content.fromUri("rbxassetid://10237720195"), MetalnessMapContent = Content.fromUri("rbxassetid://9438583347"), NormalMapContent = Content.fromUri("rbxassetid://9438583222"), RoughnessMapContent = Content.fromUri("rbxassetid://9438583558") })
		I[7] = new("MaterialVariant", I[2], "22_Asphalt", { BaseMaterial = Enum.Material.Asphalt, ColorMapContent = Content.fromUri("rbxassetid://9930003046"), NormalMapContent = Content.fromUri("rbxassetid://9429449876"), RoughnessMapContent = Content.fromUri("rbxassetid://9429450346") })
		I[8] = new("MaterialVariant", I[2], "22_Grass", { BaseMaterial = Enum.Material.Grass, ColorMapContent = Content.fromUri("rbxassetid://9920551868"), NormalMapContent = Content.fromUri("rbxassetid://9438955773"), RoughnessMapContent = Content.fromUri("rbxassetid://9438955997") })
		I[9] = new("MaterialVariant", I[2], "22_Metal", { BaseMaterial = Enum.Material.Metal, ColorMapContent = Content.fromUri("rbxassetid://9920574687"), MetalnessMapContent = Content.fromUri("rbxassetid://9873318201"), NormalMapContent = Content.fromUri("rbxassetid://9873295432"), RoughnessMapContent = Content.fromUri("rbxassetid://9873318890") })
		I[10] = new("MaterialVariant", I[2], "22_Brick", { BaseMaterial = Enum.Material.Brick, ColorMapContent = Content.fromUri("rbxassetid://9920482813"), NormalMapContent = Content.fromUri("rbxassetid://9438453152"), RoughnessMapContent = Content.fromUri("rbxassetid://9438453413") })
		I[11] = new("MaterialVariant", I[2], "22_Salt", { BaseMaterial = Enum.Material.Salt, ColorMapContent = Content.fromUri("rbxassetid://9920590225"), NormalMapContent = Content.fromUri("rbxassetid://9439565809") })
		I[12] = new("MaterialVariant", I[2], "22_Mud", { BaseMaterial = Enum.Material.Mud, ColorMapContent = Content.fromUri("rbxassetid://9920578473"), NormalMapContent = Content.fromUri("rbxassetid://9439509827"), RoughnessMapContent = Content.fromUri("rbxassetid://9439510012") })
		I[13] = new("MaterialVariant", I[2], "22_Cobblestone", { BaseMaterial = Enum.Material.Cobblestone, ColorMapContent = Content.fromUri("rbxassetid://9919718991"), NormalMapContent = Content.fromUri("rbxassetid://9438457162"), RoughnessMapContent = Content.fromUri("rbxassetid://9438457470") })
		I[14] = new("MaterialVariant", I[2], "22_Rock", { BaseMaterial = Enum.Material.Rock, ColorMapContent = Content.fromUri("rbxassetid://9920587470"), NormalMapContent = Content.fromUri("rbxassetid://9439538417"), RoughnessMapContent = Content.fromUri("rbxassetid://9439545859") })
		I[15] = new("MaterialVariant", I[2], "22_Wood", { BaseMaterial = Enum.Material.Wood, ColorMapContent = Content.fromUri("rbxassetid://9920625290"), NormalMapContent = Content.fromUri("rbxassetid://9439641376"), RoughnessMapContent = Content.fromUri("rbxassetid://9439648605") })
		I[16] = new("MaterialVariant", I[2], "22_Sandstone", { BaseMaterial = Enum.Material.Sandstone, ColorMapContent = Content.fromUri("rbxassetid://9920596120"), NormalMapContent = Content.fromUri("rbxassetid://9439596530"), RoughnessMapContent = Content.fromUri("rbxassetid://9439596711") })
		I[17] = new("MaterialVariant", I[2], "22_Slate", { BaseMaterial = Enum.Material.Slate, ColorMapContent = Content.fromUri("rbxassetid://9920599782"), NormalMapContent = Content.fromUri("rbxassetid://9439612514") })
		I[18] = new("MaterialVariant", I[2], "22_Concrete", { BaseMaterial = Enum.Material.Concrete, ColorMapContent = Content.fromUri("rbxassetid://9920484153"), NormalMapContent = Content.fromUri("rbxassetid://9466554006"), RoughnessMapContent = Content.fromUri("rbxassetid://9466554186") })
		I[19] = new("MaterialVariant", I[2], "22_Limestone", { BaseMaterial = Enum.Material.Limestone, ColorMapContent = Content.fromUri("rbxassetid://9920561437"), NormalMapContent = Content.fromUri("rbxassetid://9439415191"), RoughnessMapContent = Content.fromUri("rbxassetid://9439415495") })
		I[20] = new("MaterialVariant", I[2], "22_Foil", { BaseMaterial = Enum.Material.Foil, ColorMapContent = Content.fromUri("rbxassetid://9466552117"), MetalnessMapContent = Content.fromUri("rbxassetid://9424786272"), NormalMapContent = Content.fromUri("rbxassetid://9424786192"), RoughnessMapContent = Content.fromUri("rbxassetid://9424786620") })
		I[21] = new("MaterialVariant", I[2], "22_Pebble", { BaseMaterial = Enum.Material.Pebble, ColorMapContent = Content.fromUri("rbxassetid://9920581082"), NormalMapContent = Content.fromUri("rbxassetid://9439528644"), RoughnessMapContent = Content.fromUri("rbxassetid://9439537267") })
		I[22] = new("MaterialVariant", I[2], "22_Sand", { BaseMaterial = Enum.Material.Sand, ColorMapContent = Content.fromUri("rbxassetid://9920591683"), NormalMapContent = Content.fromUri("rbxassetid://9439577084") })
		I[23] = new("MaterialVariant", I[2], "22_Pavement", { BaseMaterial = Enum.Material.Pavement, ColorMapContent = Content.fromUri("rbxassetid://9920579943"), NormalMapContent = Content.fromUri("rbxassetid://9439519281"), RoughnessMapContent = Content.fromUri("rbxassetid://9439519532") })
		I[24] = new("MaterialVariant", I[2], "22_WoodPlanks", { BaseMaterial = Enum.Material.WoodPlanks, ColorMapContent = Content.fromUri("rbxassetid://9920626778"), NormalMapContent = Content.fromUri("rbxassetid://9439650689"), RoughnessMapContent = Content.fromUri("rbxassetid://9439658127") })
		I[25] = new("MaterialVariant", I[2], "22_Marble", { BaseMaterial = Enum.Material.Marble, ColorMapContent = Content.fromUri("rbxassetid://9439430596"), NormalMapContent = Content.fromUri("rbxassetid://9439431240"), RoughnessMapContent = Content.fromUri("rbxassetid://9439431383") })
		I[26] = new("MaterialVariant", I[2], "22_CrackedLava", { BaseMaterial = Enum.Material.CrackedLava, ColorMapContent = Content.fromUri("rbxassetid://9920484943"), NormalMapContent = Content.fromUri("rbxassetid://9438508790"), RoughnessMapContent = Content.fromUri("rbxassetid://9438509046") })
		I[27] = new("MaterialVariant", I[2], "22_Glacier", { BaseMaterial = Enum.Material.Glacier, ColorMapContent = Content.fromUri("rbxassetid://9920518732"), NormalMapContent = Content.fromUri("rbxassetid://9438812958"), RoughnessMapContent = Content.fromUri("rbxassetid://9438851286") })
		I[28] = new("MaterialVariant", I[2], "22_Fabric", { BaseMaterial = Enum.Material.Fabric, ColorMapContent = Content.fromUri("rbxassetid://9920517696"), NormalMapContent = Content.fromUri("rbxassetid://9873280412"), RoughnessMapContent = Content.fromUri("rbxassetid://9873282563") })
		I[29] = new("MaterialVariant", I[2], "22_Snow", { BaseMaterial = Enum.Material.Snow, ColorMapContent = Content.fromUri("rbxassetid://9920620284"), NormalMapContent = Content.fromUri("rbxassetid://9439632006"), RoughnessMapContent = Content.fromUri("rbxassetid://9439632145") })
		I[30] = new("MaterialVariant", I[2], "22_LeafyGrass", { BaseMaterial = Enum.Material.LeafyGrass, ColorMapContent = Content.fromUri("rbxassetid://9920557906"), MetalnessMapContent = Content.fromUri("rbxassetid://9439080950"), NormalMapContent = Content.fromUri("rbxassetid://9439080781") })
		I[31] = new("MaterialVariant", I[2], "22_Ice", { BaseMaterial = Enum.Material.Ice, ColorMapContent = Content.fromUri("rbxassetid://9920555943"), NormalMapContent = Content.fromUri("rbxassetid://9467301039") })
		I[32] = new("MaterialVariant", I[2], "22_Ground", { BaseMaterial = Enum.Material.Ground, ColorMapContent = Content.fromUri("rbxassetid://9920554482"), NormalMapContent = Content.fromUri("rbxassetid://9439043558"), RoughnessMapContent = Content.fromUri("rbxassetid://9439043765") })
	I[33] = new("Folder", nil, "AssistantMaterials")
		I[34] = new("Folder", I[33], "Material: randomized abstract texture")
			I[35] = new("MaterialVariant", I[34], "RandomTexture", { BaseMaterial = Enum.Material.Foil, ColorMapContent = Content.fromUri("rbxassetid://82068541895297"), MetalnessMapContent = Content.fromUri("rbxassetid://83140139990378"), NormalMapContent = Content.fromUri("rbxassetid://93316086650819"), RoughnessMapContent = Content.fromUri("rbxassetid://95723569441304") })
			I[36] = new("MaterialVariant", I[34], "RandomTexture1", { BaseMaterial = Enum.Material.Foil, ColorMapContent = Content.fromUri("rbxassetid://122080473488811"), MetalnessMapContent = Content.fromUri("rbxassetid://134403480019739"), NormalMapContent = Content.fromUri("rbxassetid://101664939526330"), RoughnessMapContent = Content.fromUri("rbxassetid://128777234090827") })
			I[37] = new("MaterialVariant", I[34], "RandomTexture2", { BaseMaterial = Enum.Material.Foil, ColorMapContent = Content.fromUri("rbxassetid://75053515279729"), MetalnessMapContent = Content.fromUri("rbxassetid://129453432730288"), NormalMapContent = Content.fromUri("rbxassetid://112179616710298"), RoughnessMapContent = Content.fromUri("rbxassetid://107607795135286") })
			I[38] = new("MaterialVariant", I[34], "RandomTexture3", { BaseMaterial = Enum.Material.Foil, ColorMapContent = Content.fromUri("rbxassetid://70643345680909"), MetalnessMapContent = Content.fromUri("rbxassetid://117760914034716"), NormalMapContent = Content.fromUri("rbxassetid://115333935269236"), RoughnessMapContent = Content.fromUri("rbxassetid://114343761382153") })
		I[39] = new("Folder", I[33], "Material: random abstract texture with a mix of colors and patterns")
			I[40] = new("MaterialVariant", I[39], "RandomAbstractTexture", { BaseMaterial = Enum.Material.Foil, ColorMapContent = Content.fromUri("rbxassetid://130655981049975"), MetalnessMapContent = Content.fromUri("rbxassetid://91426945271744"), NormalMapContent = Content.fromUri("rbxassetid://132340926731738"), RoughnessMapContent = Content.fromUri("rbxassetid://82774081768679") })
			I[41] = new("MaterialVariant", I[39], "RandomAbstractTexture1", { BaseMaterial = Enum.Material.Foil, ColorMapContent = Content.fromUri("rbxassetid://122717979605076"), MetalnessMapContent = Content.fromUri("rbxassetid://122102540981175"), NormalMapContent = Content.fromUri("rbxassetid://80382066947750"), RoughnessMapContent = Content.fromUri("rbxassetid://75454927210180") })
			I[42] = new("MaterialVariant", I[39], "RandomAbstractTexture2", { BaseMaterial = Enum.Material.Foil, ColorMapContent = Content.fromUri("rbxassetid://71157785338465"), MetalnessMapContent = Content.fromUri("rbxassetid://123100173936464"), NormalMapContent = Content.fromUri("rbxassetid://77832682715347"), RoughnessMapContent = Content.fromUri("rbxassetid://138338971166805") })
			I[43] = new("MaterialVariant", I[39], "RandomAbstractTexture3", { BaseMaterial = Enum.Material.Foil, ColorMapContent = Content.fromUri("rbxassetid://92859350394609"), MetalnessMapContent = Content.fromUri("rbxassetid://110485275265673"), NormalMapContent = Content.fromUri("rbxassetid://97104795232697"), RoughnessMapContent = Content.fromUri("rbxassetid://120360820188058") })
	I[44] = new("MaterialVariant", nil, "AbyssMarble", { BaseMaterial = Enum.Material.Marble, ColorMapContent = Content.fromUri("rbxassetid://114909533404737"), MaterialPattern = Enum.MaterialPattern.Organic, MetalnessMapContent = Content.fromUri("rbxassetid://121875575945097"), NormalMapContent = Content.fromUri("rbxassetid://104595627899392"), RoughnessMapContent = Content.fromUri("rbxassetid://128275243266461"), StudsPerTile = 1.5 })
	I[45] = new("MaterialVariant", nil, "Glue", { ColorMapContent = Content.fromUri("rbxassetid://10509635556"), CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0), NormalMapContent = Content.fromUri("rbxassetid://10509645465"), StudsPerTile = 1 })
	I[46] = new("MaterialVariant", nil, "Test", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://13762441585") })
	I[47] = new("MaterialVariant", nil, "Weld", { ColorMapContent = Content.fromUri("rbxassetid://10509843977"), NormalMapContent = Content.fromUri("rbxassetid://10509844001"), StudsPerTile = 2 })
	return { I[1], I[2], I[33], I[44], I[45], I[46], I[47] }
end

return build

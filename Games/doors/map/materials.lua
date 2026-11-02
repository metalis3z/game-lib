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
	I[1] = new("MaterialVariant", nil, "Carpet", { BaseMaterial = Enum.Material.Fabric, ColorMapContent = Content.fromUri("rbxassetid://9460312287"), MetalnessMapContent = Content.fromUri("rbxassetid://9460332760"), NormalMapContent = Content.fromUri("rbxassetid://9460343555"), RoughnessMapContent = Content.fromUri("rbxassetid://9460316716"), StudsPerTile = 15 })
	I[2] = new("MaterialVariant", nil, "Cashmere", { BaseMaterial = Enum.Material.Fabric, ColorMapContent = Content.fromUri("rbxassetid://10056583353"), MetalnessMapContent = Content.fromUri("rbxassetid://10056583353"), NormalMapContent = Content.fromUri("rbxassetid://10056584729"), RoughnessMapContent = Content.fromUri("rbxassetid://10056585965"), StudsPerTile = 25 })
	I[3] = new("MaterialVariant", nil, "CleanTiles", { BaseMaterial = Enum.Material.Concrete, ColorMapContent = Content.fromUri("rbxassetid://9783501106"), MetalnessMapContent = Content.fromUri("rbxassetid://9783449004"), NormalMapContent = Content.fromUri("rbxassetid://9783451456"), RoughnessMapContent = Content.fromUri("rbxassetid://9783453173"), StudsPerTile = 14.5 })
	I[4] = new("MaterialVariant", nil, "Cork", { BaseMaterial = Enum.Material.Wood, ColorMapContent = Content.fromUri("rbxassetid://12984582694"), NormalMapContent = Content.fromUri("rbxassetid://12984582690"), RoughnessMapContent = Content.fromUri("rbxassetid://12984582678") })
	I[5] = new("MaterialVariant", nil, "Dryrot", { BaseMaterial = Enum.Material.Wood, ColorMapContent = Content.fromUri("rbxassetid://12984567343"), NormalMapContent = Content.fromUri("rbxassetid://12984567336"), RoughnessMapContent = Content.fromUri("rbxassetid://12984567322") })
	I[6] = new("MaterialVariant", nil, "Flat", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://9352098867"), MetalnessMapContent = Content.fromUri("rbxassetid://9352098867"), NormalMapContent = Content.fromUri("rbxassetid://9352098867"), RoughnessMapContent = Content.fromUri("rbxassetid://9352098867") })
	I[7] = new("MaterialVariant", nil, "GoodDiamondPlate", { BaseMaterial = Enum.Material.DiamondPlate, ColorMapContent = Content.fromUri("rbxassetid://10288302898"), MetalnessMapContent = Content.fromUri("rbxassetid://10288303959"), NormalMapContent = Content.fromUri("rbxassetid://10288305119"), RoughnessMapContent = Content.fromUri("rbxassetid://10288317021"), StudsPerTile = 3 })
	I[8] = new("MaterialVariant", nil, "Leaves", { BaseMaterial = Enum.Material.Grass, ColorMapContent = Content.fromUri("rbxassetid://9754038853"), MaterialPattern = Enum.MaterialPattern.Organic, MetalnessMapContent = Content.fromUri("rbxassetid://9754004086"), NormalMapContent = Content.fromUri("rbxassetid://9754006519"), RoughnessMapContent = Content.fromUri("rbxassetid://9754007952"), StudsPerTile = 8 })
	I[9] = new("MaterialVariant", nil, "MarbleSlab", { BaseMaterial = Enum.Material.Marble, ColorMapContent = Content.fromUri("rbxassetid://10024366317"), MaterialPattern = Enum.MaterialPattern.Organic, MetalnessMapContent = Content.fromUri("rbxassetid://10024338113"), NormalMapContent = Content.fromUri("rbxassetid://10024340132"), RoughnessMapContent = Content.fromUri("rbxassetid://10024341545"), StudsPerTile = 9 })
	I[10] = new("MaterialVariant", nil, "PatchyGrass", { BaseMaterial = Enum.Material.Grass, ColorMapContent = Content.fromUri("rbxassetid://9754118634"), MaterialPattern = Enum.MaterialPattern.Organic, MetalnessMapContent = Content.fromUri("rbxassetid://9754108911"), NormalMapContent = Content.fromUri("rbxassetid://9754110707"), RoughnessMapContent = Content.fromUri("rbxassetid://9754111969"), StudsPerTile = 12 })
	I[11] = new("MaterialVariant", nil, "PavementHerringbone", { BaseMaterial = Enum.Material.Pavement, ColorMapContent = Content.fromUri("rbxassetid://10027838746"), MetalnessMapContent = Content.fromUri("rbxassetid://10024577827"), NormalMapContent = Content.fromUri("rbxassetid://10024560387"), RoughnessMapContent = Content.fromUri("rbxassetid://10024561777"), StudsPerTile = 13 })
	I[12] = new("MaterialVariant", nil, "Plaster", { BaseMaterial = Enum.Material.Wood, ColorMapContent = Content.fromUri("rbxassetid://9754248498"), MaterialPattern = Enum.MaterialPattern.Organic, MetalnessMapContent = Content.fromUri("rbxassetid://9754227125"), NormalMapContent = Content.fromUri("rbxassetid://9754228978"), RoughnessMapContent = Content.fromUri("rbxassetid://9754230309"), StudsPerTile = 14 })
	I[13] = new("MaterialVariant", nil, "Plywood", { BaseMaterial = Enum.Material.Wood, ColorMapContent = Content.fromUri("rbxassetid://9756442030"), MetalnessMapContent = Content.fromUri("rbxassetid://9756432724"), NormalMapContent = Content.fromUri("rbxassetid://9756434483"), RoughnessMapContent = Content.fromUri("rbxassetid://9756436417"), StudsPerTile = 15 })
	I[14] = new("MaterialVariant", nil, "Plywood", { BaseMaterial = Enum.Material.Rock, ColorMapContent = Content.fromUri("rbxassetid://14201767111"), MetalnessMapContent = Content.fromUri("rbxassetid://14201767111"), NormalMapContent = Content.fromUri("rbxassetid://14201767111"), RoughnessMapContent = Content.fromUri("rbxassetid://14201767111"), StudsPerTile = 15 })
	I[15] = new("MaterialVariant", nil, "Plywood", { BaseMaterial = Enum.Material.Pebble, ColorMapContent = Content.fromUri("rbxassetid://9756442030"), MetalnessMapContent = Content.fromUri("rbxassetid://9756432724"), NormalMapContent = Content.fromUri("rbxassetid://9756434483"), RoughnessMapContent = Content.fromUri("rbxassetid://9756436417"), StudsPerTile = 15 })
	I[16] = new("MaterialVariant", nil, "PlywoodALT", { BaseMaterial = Enum.Material.Wood, ColorMapContent = Content.fromUri("rbxassetid://10262314187"), MaterialPattern = Enum.MaterialPattern.Organic, MetalnessMapContent = Content.fromUri("rbxassetid://10262316981"), NormalMapContent = Content.fromUri("rbxassetid://10262320775"), RoughnessMapContent = Content.fromUri("rbxassetid://10262326114"), StudsPerTile = 11 })
	I[17] = new("MaterialVariant", nil, "RustyMetal", { BaseMaterial = Enum.Material.Metal, ColorMapContent = Content.fromUri("rbxassetid://10287960205"), MaterialPattern = Enum.MaterialPattern.Organic, MetalnessMapContent = Content.fromUri("rbxassetid://10287962171"), NormalMapContent = Content.fromUri("rbxassetid://10287965525"), RoughnessMapContent = Content.fromUri("rbxassetid://10287969104"), StudsPerTile = 6.369 })
	I[18] = new("MaterialVariant", nil, "ShipHull", { BaseMaterial = Enum.Material.DiamondPlate, ColorMapContent = Content.fromUri("rbxassetid://9773599485"), MetalnessMapContent = Content.fromUri("rbxassetid://9782834858"), NormalMapContent = Content.fromUri("rbxassetid://9773602159"), RoughnessMapContent = Content.fromUri("rbxassetid://9782870857"), StudsPerTile = 1 })
	I[19] = new("MaterialVariant", nil, "Splinters", { BaseMaterial = Enum.Material.WoodPlanks, ColorMapContent = Content.fromUri("rbxassetid://12984548885"), NormalMapContent = Content.fromUri("rbxassetid://12984548864"), RoughnessMapContent = Content.fromUri("rbxassetid://12984548842") })
	I[20] = new("MaterialVariant", nil, "StoneBricks", { BaseMaterial = Enum.Material.Brick, ColorMapContent = Content.fromUri("rbxassetid://10823591803"), MetalnessMapContent = Content.fromUri("rbxassetid://10823578285"), NormalMapContent = Content.fromUri("rbxassetid://10823574288"), RoughnessMapContent = Content.fromUri("rbxassetid://10823576515"), StudsPerTile = 15 })
	I[21] = new("MaterialVariant", nil, "Wool", { BaseMaterial = Enum.Material.Fabric, ColorMapContent = Content.fromUri("rbxassetid://10640196019"), MetalnessMapContent = Content.fromUri("rbxassetid://10640196019"), NormalMapContent = Content.fromUri("rbxassetid://10640197159"), RoughnessMapContent = Content.fromUri("rbxassetid://10640198693") })
	I[22] = new("MaterialVariant", nil, "PlywoodCrux", { BaseMaterial = Enum.Material.Wood, ColorMapContent = Content.fromUri("rbxassetid://17142352675"), MetalnessMapContent = Content.fromUri("rbxassetid://9756432724"), NormalMapContent = Content.fromUri("rbxassetid://17142317849"), RoughnessMapContent = Content.fromUri("rbxassetid://17142335360"), StudsPerTile = 15 })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[21], I[22] }
end

return build

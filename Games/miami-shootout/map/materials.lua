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
	I[1] = new("MaterialVariant", nil, "MaterialVariant")
	I[2] = new("MaterialVariant", nil, "MaterialVariant", { BaseMaterial = Enum.Material.Concrete })
	I[3] = new("MaterialVariant", nil, "MaterialVariant", { BaseMaterial = Enum.Material.Brick })
	I[4] = new("MaterialVariant", nil, "MaterialVariant1", { BaseMaterial = Enum.Material.Brick, StudsPerTile = 4 })
	I[5] = new("MaterialVariant", nil, "MaterialVariant", { BaseMaterial = Enum.Material.Wood, ColorMapContent = Content.fromUri("rbxassetid://12773504575"), StudsPerTile = 7 })
	I[6] = new("MaterialVariant", nil, "MaterialVariant2")
	I[7] = new("MaterialVariant", nil, "MaterialVariant2", { BaseMaterial = Enum.Material.Brick })
	I[8] = new("MaterialVariant", nil, "MaterialVariant3", { BaseMaterial = Enum.Material.Brick, ColorMapContent = Content.fromUri("rbxassetid://12780547373"), StudsPerTile = 1 })
	I[9] = new("MaterialVariant", nil, "MaterialVariant4", { BaseMaterial = Enum.Material.Brick, ColorMapContent = Content.fromUri("rbxassetid://12780751188"), StudsPerTile = 14 })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9] }
end

return build

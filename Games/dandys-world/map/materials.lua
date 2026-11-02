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
	I[1] = new("MaterialVariant", nil, "GarageDoorTexture 3", { BaseMaterial = Enum.Material.SmoothPlastic, ColorMapContent = Content.fromUri("rbxassetid://17733526653"), CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0), MetalnessMapContent = Content.fromUri("rbxassetid://17733526548"), NormalMapContent = Content.fromUri("rbxassetid://17733526647"), RoughnessMapContent = Content.fromUri("rbxassetid://17733526596"), StudsPerTile = 16.3999996 })
	I[2] = new("MaterialVariant", nil, "GrassyTexture 2", { BaseMaterial = Enum.Material.Grass, ColorMapContent = Content.fromUri("rbxassetid://16541082572"), MaterialPattern = Enum.MaterialPattern.Organic, MetalnessMapContent = Content.fromUri("rbxassetid://16541082523"), NormalMapContent = Content.fromUri("rbxassetid://16541082586"), RoughnessMapContent = Content.fromUri("rbxassetid://16541082555"), StudsPerTile = 20 })
	return { I[1], I[2] }
end

return build

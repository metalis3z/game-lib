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
	I[1] = new("MaterialVariant", nil, "Glue", { ColorMapContent = Content.fromUri("rbxassetid://10509635556"), CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0), NormalMapContent = Content.fromUri("rbxassetid://10509645465"), StudsPerTile = 1 })
	I[2] = new("MaterialVariant", nil, "Inlet", { ColorMapContent = Content.fromUri("rbxassetid://10509827175"), NormalMapContent = Content.fromUri("rbxassetid://10509827228"), StudsPerTile = 1 })
	I[3] = new("MaterialVariant", nil, "Studs", { ColorMapContent = Content.fromUri("rbxassetid://10509831729"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 1 })
	I[4] = new("MaterialVariant", nil, "StudsSmall", { ColorMapContent = Content.fromUri("rbxassetid://10509831729"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 0.5 })
	I[5] = new("MaterialVariant", nil, "Universal", { ColorMapContent = Content.fromUri("rbxassetid://10509840768"), NormalMapContent = Content.fromUri("rbxassetid://10509840812"), StudsPerTile = 2 })
	I[6] = new("MaterialVariant", nil, "Weld", { ColorMapContent = Content.fromUri("rbxassetid://10509843977"), NormalMapContent = Content.fromUri("rbxassetid://10509844001"), StudsPerTile = 2 })
	return { I[1], I[2], I[3], I[4], I[5], I[6] }
end

return build

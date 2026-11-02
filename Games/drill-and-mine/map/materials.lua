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
	I[1] = new("MaterialVariant", nil, "2022 Stud", { BaseMaterial = Enum.Material.Glacier, NormalMapContent = Content.fromUri("rbxassetid://10509831753"), RoughnessMapContent = Content.fromUri("rbxassetid://132155326"), StudsPerTile = 1 })
	I[2] = new("MaterialVariant", nil, "SmallerStud", { BaseMaterial = Enum.Material.Glacier, NormalMapContent = Content.fromUri("rbxassetid://10509831753"), RoughnessMapContent = Content.fromUri("rbxassetid://132155326"), StudsPerTile = 0.25 })
	I[3] = new("MaterialVariant", nil, "Studs", { ColorMapContent = Content.fromUri("rbxassetid://10509831729"), StudsPerTile = 1 })
	I[4] = new("MaterialVariant", nil, "Weld", { ColorMapContent = Content.fromUri("rbxassetid://10509843977"), StudsPerTile = 2 })
	I[5] = new("MaterialVariant", nil, "Inlet", { ColorMapContent = Content.fromUri("rbxassetid://10509827175"), NormalMapContent = Content.fromUri("rbxassetid://10509827228"), StudsPerTile = 1 })
	I[6] = new("MaterialVariant", nil, "Universal", { ColorMapContent = Content.fromUri("rbxassetid://10509840768"), NormalMapContent = Content.fromUri("rbxassetid://10509840812"), StudsPerTile = 2 })
	I[7] = new("MaterialVariant", nil, "Studs_2", { ColorMapContent = Content.fromUri("rbxassetid://10509831729"), NormalMapContent = Content.fromUri("rbxassetid://10509831753"), StudsPerTile = 1 })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7] }
end

return build

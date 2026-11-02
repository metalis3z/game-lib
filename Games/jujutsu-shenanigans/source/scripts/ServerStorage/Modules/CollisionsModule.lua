local module = {}

local function HasProperty(_Instance: Part?, Property: string)
	return pcall(function()
		_Instance[Property] = _Instance[Property]
	end)
end

function module:SetCollisionGroup(Character: Model, Group: string)
	for _,Part: Part in Character:GetChildren() do
		if HasProperty(Part, 'CollisionGroup') then
			Part.CollisionGroup = Group
		end
	end
end

return module

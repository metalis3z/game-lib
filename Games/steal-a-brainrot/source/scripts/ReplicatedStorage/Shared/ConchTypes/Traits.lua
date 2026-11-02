local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Conch = require(ReplicatedStorage.Packages.Conch)
local Traits = require(ReplicatedStorage.Datas.Traits)

return Conch.register_type("Traits", {
	convert = function(value)
		if typeof(value) == "table" then
			local result = table.clone(value)

			for i, trait in ipairs(result) do
				trait = tostring(trait)
				if not Traits[trait] then
					error(("Trait '%s' not found"):format(trait))
				end
				result[i] = trait
			end

			return result
		else
			local trait = tostring(value)
			if not Traits[trait] then
				error(("Trait '%s' not found"):format(trait))
			end
			return { trait }
		end
	end,

	analysis = {
		kind = "argument",
		name = "traits",
		type = "{ Trait }",
		optional = false
	}
})
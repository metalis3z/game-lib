-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GetPriceValueForPet = require(script.Parent.GetPriceValueForPet)
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Directory.PetRegistry)

return function(p1) --[[ Line: 12 | Upvalues: Asserts (copy), GetPriceValueForPet (copy) ]]
	Asserts.Tool(p1)

	local v1 = p1:GetAttribute("PetType")
	local v2 = p1:GetAttribute("BaseWeight")
	local v3 = p1:GetAttribute("Scale")
	local v4 = p1:GetAttribute("Age")
	local v5 = p1:GetAttribute("Level")
	local v6 = p1:GetAttribute("PET_UUID")

	if v1 and (v2 and v3) then
		return GetPriceValueForPet({
			UUID = v6 or "",
			PetType = v1,
			PetData = {
				LevelProgress = 0,
				Age = v4 or 0,
				Level = v5 or 1,
				Name = p1.Name,
				BaseWeight = v2,
				Weight = v3
			}
		})
	end

	return 0
end
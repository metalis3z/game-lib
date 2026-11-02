-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PetRegistry = require(ReplicatedStorage.Directory.PetRegistry)

return function(p1) --[[ Line: 10 | Upvalues: PetRegistry (copy) ]]
	if typeof(p1) ~= "table" then
		return 0
	end

	if typeof(p1.PetData) ~= "table" then
		return 0
	end

	local v1 = PetRegistry.PetList[p1.PetType]

	if not v1 then
		return 0
	end

	local PetData2 = p1.PetData
	local v3 = typeof(PetData2.Level) == "number" and PetData2.Level or 1
	local v4 = typeof(PetData2.Age) == "number" and PetData2.Age or 0
	local v5 = typeof(PetData2.Weight) == "number" and PetData2.Weight or (PetData2.BaseWeight or 1)

	return math.floor((v1.SellPrice or 0) * (1 + (v3 - 1) * 0.1) * (1 + v4 * 0.05) * (math.max(0, v5 - (typeof(PetData2.BaseWeight) == "number" and PetData2.BaseWeight or v5)) * 0.05 + 1))
end
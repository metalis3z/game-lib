-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingSlice, time of decompilation: Sun May  3 10:12:23 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local v3 = Vide.source(nil)
local v4 = Vide.source({})
local v5 = Vide.source(nil)
local v6 = Vide.source(nil)

return {
	activeRecipeId = v3,
	selectedIngredientUniqueIds = v4,
	pickerIngredientIndex = v5,
	activeMachineId = v6,
	clearSelection = function() --[[ clearSelection ]] -- line: 10
		-- upvalues: v3 (copy), v4 (copy), v5 (copy)
		v3(nil)
		v4({})
		v5(nil)
	end
}

-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingMenuUtils, time of decompilation: Sun May  3 10:12:28 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)
require(ReplicatedStorage.Source.Features.Crafting.Recipes)

return {
	getFirstMissingIngredientIndex = function(p1, t1: {[any]: any}) --[[ getFirstMissingIngredientIndex ]] -- line: 11
		for i = 1, #p1.inputs do
			if type(t1[i]) ~= "string" or t1[i] == "" then
				return i
			end
		end

		return nil
	end,
	getSelectedSlimeData = function(t2: {[any]: any}, t3: {[any]: any}, n1: number) --[[ getSelectedSlimeData ]] -- line: 24
		-- upvalues: InventoryServiceUtils (copy)
		local v9 = t3[n1]

		if type(v9) ~= "string" or v9 == "" then
			return nil
		end

		local v10 = t2[v9]

		if v10 == nil then
			return nil
		end

		return InventoryServiceUtils.getSlimeData(v9, v10)
	end,
	shouldShowSelectedLevel = function(t4: {[any]: any}, t5: {[any]: any}, n2: number) --[[ shouldShowSelectedLevel ]] -- line: 42
		local v14 = t5[n2]

		if type(v14) ~= "string" or v14 == "" then
			return false
		end

		return type(t4[v14]) == "table"
	end
}

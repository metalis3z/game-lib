-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: IndexDataMigration, time of decompilation: Sun May  3 10:12:32 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

return {
	apply = function(_, p2) --[[ apply ]] -- line: 17
		-- upvalues: IndexServiceUtils (copy), InventoryServiceUtils (copy)
		local v7 = IndexServiceUtils.reconcileIndexData(p2.index)

		if v7.migratedV1 then
			p2.index = v7

			return
		end

		local v8 = IndexServiceUtils.createDefaultIndexData()

		v8.categories.basic.unlocked.goopy = true
		v8.categories.basic.unlocked.sunset = true
		v8.categories.basic.unlocked.fin = true

		for v9, v10 in p2.stats and p2.stats.slimeCounts or {} do
			if type(v9) == "string" and type(v10) == "number" and v10 > 0 then
				v8.categories.basic.counts[v9] = math.max(math.floor(v10 + 0.5), 0)
				v8.categories.basic.unlocked[v9] = true
			end
		end

		for v11, v12 in p2.inventory or {} do
			local v13 = type(v12) ~= "number" and 1 or math.max(math.floor(v12 + 0.5), 0)

			if not (v13 <= 0) then
				local v14 = InventoryServiceUtils.getSlimeData(v11, v12)

				IndexServiceUtils.markUnlocked(v8, "basic", v14.id)

				for _, v16 in IndexServiceUtils.getTrackedCategoryIds(v14.mutations) do
					if v16 ~= "basic" then
						IndexServiceUtils.addCount(v8, v16, v14.id, v13)
					end
				end
			end
		end

		v8.migratedV1 = true
		p2.index = v8
	end
}

-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: getSlimeDataFromUniqueIdSource, time of decompilation: Sun May  3 10:11:17 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local client = require(ReplicatedStorage.Packages.DataService).client
local Vide = require(ReplicatedStorage.Packages.Vide)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

return function(p1) -- line: 9
	-- upvalues: Vide (copy), client (copy), InventoryServiceUtils (copy)
	local v6 = Vide.source(nil)
	local v7 = Vide.source(nil)

	Vide.effect(function() -- line: 13
		-- upvalues: Vide (copy), p1 (copy), v6 (copy), client (copy)
		local v8 = Vide.read(p1)

		if not v8 then
			v6(nil)

			return
		end

		v6(client:get({
			"inventory",
			v8
		}))

		local connection = client:getChangedSignal({
			"inventory",
			v8
		}):Connect(function(p2) -- line: 21
			-- upvalues: v6 (copy)
			v6(p2)
		end)

		Vide.cleanup(function() -- line: 25
			-- upvalues: connection (copy)
			connection:Disconnect()
		end)
	end)
	Vide.effect(function() -- line: 30
		-- upvalues: v6 (copy), Vide (copy), p1 (copy), v7 (copy), InventoryServiceUtils (copy)
		local v10 = v6()
		local v11 = Vide.read(p1)

		if not v10 or not v11 then
			v7(nil)

			return
		end

		v7(InventoryServiceUtils.getSlimeData(v11, v10))
	end)

	return v7
end

-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetGenerationUtil = require(ReplicatedStorage.Library.Util.AssetGenerationUtil)
local AssetItemSerialization = require(ReplicatedStorage.Library.Util.AssetItemSerialization)

return {
	GetTotalForProfile = function(p1, p2) --[[ GetTotalForProfile | Line: 17 | Upvalues: AssetItemSerialization (copy), AssetGenerationUtil (copy) ]]
		local Inventory = p2.Inventory
		local EquippedAssets = p2.EquippedAssets

		if typeof(Inventory) ~= "table" or typeof(EquippedAssets) ~= "table" then
			return 0
		end

		local v1 = if typeof(p2.Rebirth) == "number" then p2.Rebirth else 0
		local v2 = if typeof(p2.Gamepasses) == "table" then p2.Gamepasses else nil
		local v3 = if typeof(p2.Products) == "table" then p2.Products else nil
		local sum = 0

		for i, v in ipairs(EquippedAssets) do
			local v4 = Inventory[v]

			if typeof(v4) == "table" then
				sum = sum + math.max(AssetGenerationUtil.GetRate(AssetItemSerialization.Deserialize(v4), v1, v2, v3), 0)
			end
		end

		return sum
	end
}
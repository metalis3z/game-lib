-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Interface = require(script.Parent.Parent.Types.Interface)

return function(p1) --[[ Line: 11 | Upvalues: Interface (copy) ]]
	local v1, v2 = Interface.IndexBatConfigOptions(p1)

	assert(v1, v2)

	return {
		MoneyCost = 0,
		ShopDropWeight = 0,
		MinShopStockQuantity = 1,
		MaxShopStockQuantity = 1,
		ToolController = "None",
		Persistent = true,
		SinglePurchase = true,
		DisplayInShop = false,
		Icon = p1.Icon,
		DisplayName = p1.DisplayName,
		ToolModel = p1.DisplayName,
		Description = ("Complete the %* area index to equip this bat!"):format(p1.DisplayName),
		Rarity = p1.Rarity,
		IndexBatTier = p1.IndexBatTier,
		BatControllerData = {
			Duration = p1.Duration,
			Force = p1.Force,
			RangeBonus = (p1.IndexBatTier - 1) * 1.875
		}
	}
end
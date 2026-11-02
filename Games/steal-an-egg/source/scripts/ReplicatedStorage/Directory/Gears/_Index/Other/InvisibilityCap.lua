-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.Parent.BaseConfigs.Default)

return setmetatable({
	Icon = "rbxassetid://76418798820782",
	MoneyCost = 300000,
	ShopDropWeight = 100,
	MinShopStockQuantity = 1,
	MaxShopStockQuantity = 1,
	ToolController = "None",
	Description = "Become invisible!",
	Rarity = "Transcendent",
	SinglePurchase = true,
	Persistent = false,
	DisplayName = script.Name
}, {
	__index = Default
})
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent.Types.Interface)
require(script.Parent.Parent.Parent.Types.ToolConfigs)

local Default = require(script.Parent.Parent.Parent.BaseConfigs.Default)
local t = {
	Icon = "rbxassetid://78673347",
	MoneyCost = 50000000,
	ShopDropWeight = 60,
	MinShopStockQuantity = 1,
	MaxShopStockQuantity = 1,
	ToolController = "None",
	Description = "Switch positions with the closest player in range!",
	Rarity = "Uncommon",
	Persistent = false,
	SinglePurchase = true,
	DisplayInShop = false,
	DisplayName = script.Name
}
local t2 = {
	MAX_RANGE = 35,
	COOLDOWN = 9,
	HIGHLIGHT_OUTLINE_TRANSPARENCY = 0.5,
	HIGHLIGHT_FILL_TRANSPARENCY = 0.7,
	SWAP_SFX_ID = "rbxassetid://0",
	SWAP_VFX_PATH = nil,
	SHOW_RANGE_INDICATOR = false,
	HIGHLIGHT_COLOR = Color3.new(255/255, 0/255, 0/255)
}
local v2 = setmetatable(table.clone(t), {
	__index = Default
})

for v3, v4 in t2 do
	v2[v3] = v4
end

return v2
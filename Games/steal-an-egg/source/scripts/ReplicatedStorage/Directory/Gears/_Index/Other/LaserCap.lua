-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent.Types.Interface)
require(script.Parent.Parent.Parent.Types.ToolConfigs)

local Default = require(script.Parent.Parent.Parent.BaseConfigs.Default)
local t = {
	Icon = "rbxassetid://132491110746864",
	MoneyCost = 20000000,
	ShopDropWeight = 60,
	MinShopStockQuantity = 1,
	MaxShopStockQuantity = 1,
	ToolController = "None",
	Description = "Shoot a powerful laser beam that slaps and ragdolls your target",
	Rarity = "Uncommon",
	Persistent = false,
	SinglePurchase = true,
	DisplayInShop = false,
	DisplayName = script.Name
}
local t2 = {
	COOLDOWN = 1,
	MAX_RANGE = 200,
	SLAP_FORCE = 8,
	SLAP_DURATION = 1.5,
	RAGDOLL_DURATION = 1.5,
	MOB_DAMAGE = 25,
	BEAM_WIDTH = 0.2,
	HIT_VFX_SIZE = 3,
	FIRE_SFX_ID = "rbxassetid://0",
	HIT_SFX_ID = "rbxassetid://0",
	BEAM_VFX_PATH = nil,
	HIT_VFX_PATH = nil,
	SHOW_DEBUG_RAY = false,
	BEAM_COLOR = Color3.new(255/255, 0/255, 0/255)
}
local v2 = setmetatable(table.clone(t), {
	__index = Default
})

for v3, v4 in t2 do
	v2[v3] = v4
end

return v2
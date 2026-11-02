-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    COOLDOWN = 14,
    DETECTION_INTERVAL = 0.1,
    Description = "Place invisible traps that stun enemies",
    DisplayInShop = false,
    DisplayName = "SubspaceMine",
    FADE_DURATION = 3,
    HIGHLIGHT_FADE_TIME = 0.5,
    IMPACT_VFX_ID = "rbxassetid://0",
    IMPULSE_FORCE = Vector3.new(0, 20, 0),
    IMPULSE_STRENGTH = 20,
    Icon = "http://www.roblox.com/asset/?id=11987521",
    MAX_ACTIVE_TRAPS = 1,
    MAX_PLACE_DISTANCE = 10,
    MOB_DAMAGE = 30,
    MaxShopStockQuantity = 1,
    MinShopStockQuantity = 1,
    MoneyCost = 500000000,
    Persistent = false,
    RAGDOLL_DURATION = 4.5,
    Rarity = "Rare",
    ShopDropWeight = 45,
    SinglePurchase = true,
    TRAP_COOLDOWN_SECONDS = 14,
    TRIGGER_RADIUS = 8,
    TRIGGER_SFX_ID = "rbxassetid://0",
    ToolController = "None",
    _id = "SubspaceMine",
    HIGHLIGHT_COLOR = Color3.new(0.501960813999176, 0, 0.501960813999176),
    TRAP_MODEL_PATH = game:GetService("ReplicatedStorage").Assets.ToolEffects.SubspaceTrap
})

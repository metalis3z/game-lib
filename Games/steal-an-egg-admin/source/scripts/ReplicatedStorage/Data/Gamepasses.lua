-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local MonetizationConfig = require(script.Parent.MonetizationConfig)
local v1 = {}
for v2, v3 in { "Lucky", "X2Growth", "X2Money", "SkipHatch", "OPTreadmill" } do
    v1[v3] = require(script.Configs[v3])
end
for v4, v5 in { "AdminPermanent", "BeOwner", "AdminPlus", "HDAdmin", "NoCooldowns" } do
    v1[v5] = table.freeze({
        Icon = "rbxassetid://0",
        _id = v5,
        ProductId = MonetizationConfig.GamepassIds[v5],
        DisplayName = v5,
        Desc = v5
    })
end
local v6 = {}
for v7, v8 in v1 do
    local v9 = not v6[v8.ProductId]
    local v10 = "Duplicate gamepass ID: " .. v7
    assert(v9, v10)
    v6[v8.ProductId] = v8
end
return table.freeze({
    Directory = table.freeze(v1),
    ByProductId = table.freeze(v6)
})

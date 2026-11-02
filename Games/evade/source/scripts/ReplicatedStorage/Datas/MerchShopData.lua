-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.FFlags)
local v_u_3 = require(v1.Shared.Updates)
local v5 = {
    ["CodeLength"] = 12,
    ["CurrentShopItem"] = "Festive 67",
    ["IsEnabled"] = function()
        -- upvalues: (copy) v_u_2, (copy) v_u_3
        local v4 = v_u_2:GetInstant("MerchShopEnabled", true)
        if v4 then
            v4 = v_u_3.Methods.IsEnabled("Update-12/13/2025")
        end
        return v4
    end
}
local v7 = {
    ["Festive 67"] = {
        ["CommerceProductId"] = "COM-7003089990728810945",
        ["DevProductId"] = 3477983793,
        ["RewardType"] = "Brainrot",
        ["RewardId"] = "Festive 67",
        ["StockKey"] = "Festive 67",
        ["InitialStock"] = 50000,
        ["IsEnabled"] = function()
            -- upvalues: (copy) v_u_2, (copy) v_u_3
            local v6 = v_u_2:GetInstant("MerchShopEnabled", true)
            if v6 then
                v6 = v_u_3.Methods.IsEnabled("Update-12/13/2025")
            end
            if v6 then
                v6 = not v_u_2:Get("MechShopSoldOut", false)
            end
            return v6
        end
    }
}
v5.Items = v7
v5.TestProductInfo = {
    ["Description"] = "Test description",
    ["DisplayPrice"] = "$29.98",
    ["IconImageAssetId"] = 0,
    ["IsPurchasable"] = true
}
for v8, v9 in v5.Items do
    v9.Name = v8
end
v5.CurrentItem = v5.Items[v5.CurrentShopItem]
return v5
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Common = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Common
return table.freeze({
    _id = "Common",
    DisplayName = "Common",
    RarityNumber = 1,
    DefaultRarityValue = "1 in 2",
    Announce = false,
    ItemTemplate = Common.ItemTemplate,
    RarityGradient = Common.RarityGradient,
    Color = Color3.fromRGB(151, 151, 151),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 2"
    end
})

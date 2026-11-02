-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Basic = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Basic
return table.freeze({
    _id = "Basic",
    DisplayName = "Common",
    RarityNumber = 1,
    DefaultRarityValue = "1 in 2",
    Announce = false,
    ItemTemplate = Basic.ItemTemplate,
    RarityGradient = Basic.RarityGradient,
    Color = Color3.fromRGB(151, 151, 151),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 2"
    end
})

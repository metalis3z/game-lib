-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Uncommon = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Uncommon
return table.freeze({
    _id = "Uncommon",
    DisplayName = "Uncommon",
    RarityNumber = 2,
    DefaultRarityValue = "1 in 2",
    Announce = false,
    ItemTemplate = Uncommon.ItemTemplate,
    RarityGradient = Uncommon.RarityGradient,
    Color = Color3.fromRGB(0, 255, 0),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 2"
    end
})

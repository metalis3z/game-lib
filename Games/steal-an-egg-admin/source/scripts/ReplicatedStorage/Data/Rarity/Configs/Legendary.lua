-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Legendary = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Legendary
return table.freeze({
    _id = "Legendary",
    DisplayName = "Legendary",
    RarityNumber = 5,
    DefaultRarityValue = "1 in 25",
    Announce = false,
    ItemTemplate = Legendary.ItemTemplate,
    RarityGradient = Legendary.RarityGradient,
    Color = Color3.fromRGB(255, 133, 34),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 25"
    end
})

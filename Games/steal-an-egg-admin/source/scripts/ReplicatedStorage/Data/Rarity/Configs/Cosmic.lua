-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Cosmic = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Cosmic
return table.freeze({
    _id = "Cosmic",
    DisplayName = "Cosmic",
    RarityNumber = 7,
    DefaultRarityValue = "1 in 200",
    Announce = true,
    ItemTemplate = Cosmic.ItemTemplate,
    RarityGradient = Cosmic.RarityGradient,
    Color = Color3.fromRGB(65, 0, 170),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 200"
    end
})

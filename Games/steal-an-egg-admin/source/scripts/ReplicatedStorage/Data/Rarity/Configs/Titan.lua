-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Titan = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Titan
return table.freeze({
    _id = "Titan",
    DisplayName = "Titan",
    RarityNumber = 11,
    DefaultRarityValue = "1 in 10,000,000,000",
    Announce = true,
    ItemTemplate = Titan.ItemTemplate,
    RarityGradient = Titan.RarityGradient,
    Color = Color3.fromRGB(255, 64, 64),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 10,000,000,000"
    end
})

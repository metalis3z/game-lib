-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Exclusive = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Exclusive
return table.freeze({
    _id = "Exclusive",
    DisplayName = "Exclusive",
    RarityNumber = 7,
    DefaultRarityValue = "1 in 10,000",
    Announce = true,
    ItemTemplate = Exclusive.ItemTemplate,
    RarityGradient = Exclusive.RarityGradient,
    Color = Color3.fromRGB(173, 79, 255),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 10,000"
    end
})

-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Celestial = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Celestial
return table.freeze({
    _id = "Celestial",
    DisplayName = "Celestial",
    RarityNumber = 2,
    DefaultRarityValue = "1 in 200",
    Announce = false,
    ItemTemplate = Celestial.ItemTemplate,
    RarityGradient = Celestial.RarityGradient,
    Color = Color3.fromRGB(0, 221, 66),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 200"
    end
})

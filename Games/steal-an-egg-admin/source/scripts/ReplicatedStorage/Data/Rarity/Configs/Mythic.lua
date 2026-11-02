-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Mythic = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Mythic
return table.freeze({
    _id = "Mythic",
    DisplayName = "Mythic",
    RarityNumber = 6,
    DefaultRarityValue = "1 in 100",
    Announce = false,
    ItemTemplate = Mythic.ItemTemplate,
    RarityGradient = Mythic.RarityGradient,
    Color = Color3.fromRGB(255, 43, 100),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 100"
    end
})

-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Rare = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Rare
return table.freeze({
    _id = "Rare",
    DisplayName = "Rare",
    RarityNumber = 3,
    DefaultRarityValue = "1 in 4",
    Announce = false,
    ItemTemplate = Rare.ItemTemplate,
    RarityGradient = Rare.RarityGradient,
    Color = Color3.fromRGB(25, 144, 255),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 4"
    end
})

-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local SuperRare = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.SuperRare
return table.freeze({
    _id = "SuperRare",
    DisplayName = "SuperRare",
    RarityNumber = 2,
    DefaultRarityValue = "1 in 40",
    Announce = false,
    ItemTemplate = SuperRare.ItemTemplate,
    RarityGradient = SuperRare.RarityGradient,
    Color = Color3.fromRGB(25, 216, 250),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 40"
    end
})

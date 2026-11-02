-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Epic = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Epic
return table.freeze({
    _id = "Epic",
    DisplayName = "Epic",
    RarityNumber = 4,
    DefaultRarityValue = "1 in 10",
    Announce = false,
    ItemTemplate = Epic.ItemTemplate,
    RarityGradient = Epic.RarityGradient,
    Color = Color3.fromRGB(196, 2, 255),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 10"
    end
})

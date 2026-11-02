-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Limited = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Limited
return table.freeze({
    _id = "Limited",
    DisplayName = "Limited",
    RarityNumber = 9,
    DefaultRarityValue = "1 in 10,000",
    Announce = true,
    ItemTemplate = Limited.ItemTemplate,
    RarityGradient = Limited.RarityGradient,
    Color = Color3.fromRGB(173, 79, 255),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 10,000"
    end
})

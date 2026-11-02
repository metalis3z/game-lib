-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Eternal = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Eternal
return table.freeze({
    _id = "Eternal",
    DisplayName = "Eternal",
    RarityNumber = 9,
    DefaultRarityValue = "1 in 100,000,000",
    Announce = false,
    ItemTemplate = Eternal.ItemTemplate,
    RarityGradient = Eternal.RarityGradient,
    Color = Color3.fromRGB(255, 30, 240),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 100,000,000"
    end
})

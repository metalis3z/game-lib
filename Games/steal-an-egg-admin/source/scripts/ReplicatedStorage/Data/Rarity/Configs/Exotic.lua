-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Exotic = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Exotic
return table.freeze({
    _id = "Exotic",
    DisplayName = "Exotic",
    RarityNumber = 8,
    DefaultRarityValue = "1 in 60,000",
    Announce = true,
    ItemTemplate = Exotic.ItemTemplate,
    RarityGradient = Exotic.RarityGradient,
    Color = Color3.fromRGB(255, 29, 251),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 60,000"
    end
})

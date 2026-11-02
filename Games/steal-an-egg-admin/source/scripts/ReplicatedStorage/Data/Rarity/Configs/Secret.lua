-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Secret = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Secret
return table.freeze({
    _id = "Secret",
    DisplayName = "Secret",
    RarityNumber = 8,
    DefaultRarityValue = "1 in 100,000",
    Announce = true,
    ItemTemplate = Secret.ItemTemplate,
    RarityGradient = Secret.RarityGradient,
    Color = Color3.fromRGB(46, 46, 46),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 100,000"
    end
})

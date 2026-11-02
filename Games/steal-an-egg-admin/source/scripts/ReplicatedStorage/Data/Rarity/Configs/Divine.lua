-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Divine = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Divine
return table.freeze({
    _id = "Divine",
    DisplayName = "Divine",
    RarityNumber = 10,
    DefaultRarityValue = "1 in 1,000,000,000",
    Announce = true,
    ItemTemplate = Divine.ItemTemplate,
    RarityGradient = Divine.RarityGradient,
    Color = Color3.fromRGB(251, 255, 0),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 1,000,000,000"
    end
})

-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local BrainrotGod = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.BrainrotGod
return table.freeze({
    _id = "BrainrotGod",
    DisplayName = "Squishy God",
    RarityNumber = 6,
    DefaultRarityValue = "1 in 100,000,000",
    Announce = false,
    ItemTemplate = BrainrotGod.ItemTemplate,
    RarityGradient = BrainrotGod.RarityGradient,
    Color = Color3.fromRGB(172, 0, 198),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 100,000,000"
    end
})

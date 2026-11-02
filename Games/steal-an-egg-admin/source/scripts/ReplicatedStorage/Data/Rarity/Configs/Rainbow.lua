-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Rainbow = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Rainbow
return table.freeze({
    _id = "Rainbow",
    DisplayName = "Rainbow",
    RarityNumber = 6,
    DefaultRarityValue = "1 in 100,000,000",
    Announce = false,
    ItemTemplate = Rainbow.ItemTemplate,
    RarityGradient = Rainbow.RarityGradient,
    Color = Color3.fromRGB(240, 35, 172),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 100,000,000"
    end
})

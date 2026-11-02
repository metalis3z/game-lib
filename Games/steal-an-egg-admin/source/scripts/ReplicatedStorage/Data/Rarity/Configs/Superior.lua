-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Superior = game:GetService("ReplicatedStorage").Assets.UI.RarityGradients.Superior
return table.freeze({
    _id = "Superior",
    DisplayName = "Superior",
    RarityNumber = 10,
    DefaultRarityValue = "1 in 100,000",
    Announce = true,
    ItemTemplate = Superior.ItemTemplate,
    RarityGradient = Superior.RarityGradient,
    Color = Color3.fromRGB(195, 255, 255),
    Message = function(v1) -- Message | line 16
        return (v1 and ("%*: "):format(v1) or "") .. "1 in 100,000"
    end
})

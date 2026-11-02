-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
return {
    AnnounceData = t.interface({
        color = t.optional(t.Color3),
        font = t.optional(t.EnumItem),
        fontSize = t.optional(t.EnumItem),
        message = t.string,
        metadata = t.optional(t.string),
        omitColor = t.optional(t.boolean)
    })
}

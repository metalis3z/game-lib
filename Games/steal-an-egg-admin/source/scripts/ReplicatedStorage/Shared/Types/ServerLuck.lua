-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
return {
    State = t.strictInterface({
        Multiplier = t.number,
        ExpiresAt = t.optional(t.number),
        BoostedByDisplayName = t.optional(t.string)
    })
}

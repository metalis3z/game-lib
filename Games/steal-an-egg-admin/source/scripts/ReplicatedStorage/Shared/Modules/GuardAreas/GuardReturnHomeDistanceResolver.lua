-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    ["Abyss Ocean"] = 15,
    Cosmic = 15
}

v1.Prehistoric = 15

local v2 = {}

function v2.Resolve(v3) -- line 13 | captures: t, v1
    t.strict(t.string)(v3)
    return v1[v3] or 3
end

return v2

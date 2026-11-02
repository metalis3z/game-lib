-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local Shared = game:GetService("ReplicatedStorage"):WaitForChild("Shared")
local v1 = require(Shared:WaitForChild("Save"))
local v2 = {}

function v2.ReadOwned(v3) -- line 11 | captures: Players, v1
    local v4 = v3 or Players.LocalPlayer
    local v5 = v1.Get(v4)
    return v5 ~= nil and v5.Products or {}
end

function v2.HasProduct(v6, v7) -- line 29 | captures: Players, v1
    local v8 = v7 or Players.LocalPlayer
    local v9 = v1.Get(v8)
    if v9 == nil then
        return false
    end
    return v9.Products[tostring(v6)]
end

return v2

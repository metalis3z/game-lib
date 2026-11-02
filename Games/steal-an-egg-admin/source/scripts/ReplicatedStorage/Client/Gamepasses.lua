-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gamepasses = require(ReplicatedStorage.Data.Gamepasses)
local t = require(ReplicatedStorage.Packages.t)
local Shared = ReplicatedStorage:WaitForChild("Shared")
local v1 = require(Shared:WaitForChild("Save"))
local Directory = Gamepasses.Directory
local v2 = {}
for v3, v4 in pairs(Directory) do
    local ProductId = v4.ProductId
    if ProductId and not v2[ProductId] then
        v2[ProductId] = v4
    end
end
local v5 = {}

local function passIdOf(v6) -- line 22 | captures: t, Directory
    local v7
    if type(v6) == "number" then
        v7 = v6
    elseif type(v6) == "string" then
        local v8 = Directory[v6]
        local v9 = ("no gamepass config is registered under %*"):format(v6)
        assert(v8, v9)
        v7 = v8.ProductId
    else
        local v10 = Directory[v6._id] == v6
        local v11 = ("gamepass config %* is not the one registered under its own _id"):format(v6)
        assert(v10, v11)
        v7 = v6.ProductId
    end
    t.strict(t.integer)(v7)
    return v7
end

function v5.Owns(v12, v13) -- line 39 | captures: v1, v2, passIdOf
    local v14 = v2[passIdOf(v12)]
    local v15 = ("product id %* maps to no gamepass config"):format(v12)
    assert(v14, v15)
    local v16 = v1.Get(v13)
    if v16 == nil then
        return false
    end
    return v16.Gamepasses[v14._id] == true
end

function v5.ConfigForProductId(v17) -- line 46 | captures: t, v2
    t.strict(t.integer)(v17)
    return v2[v17]
end

function v5.OwnedFlags(v18) -- line 51 | captures: Players, v1
    local v19 = v18 or Players.LocalPlayer
    local v20 = v1.Get(v19)
    if v20 then
        return v20.Gamepasses
    end
    return {}
end

return v5

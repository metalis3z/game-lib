-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
require(ReplicatedStorage.Shared.Types.AssetItem)
local v1 = {}
local v2 = {
    Male = "rbxassetid://88627876961976",
    Female = "rbxassetid://98782480225988"
}

function v1.BadgeImage(v3) -- line 11 | captures: v2
    return v2[v3] or "rbxassetid://98782480225988"
end

local function IsTag(v4) -- line 14
    if v4 == "Male" then
        return true
    end
    return v4 == "Female"
end

v1.IsTag = IsTag

local function Draw(v5) -- line 18
    if (v5 or Random.new()):NextInteger(1, 2) == 1 then
        return "Male"
    end
    return "Female"
end

v1.Draw = Draw

function v1.Settle(v6, v7, v8) -- line 29 | captures: Assets, v1
    if v1.IsTag(v7) then
        return v7
    end
    local GenderLocked = Assets.Directory[v6].GenderLocked
    if v1.IsTag(GenderLocked) then
        return GenderLocked
    end
    return (v1.Draw(v8))
end

return v1

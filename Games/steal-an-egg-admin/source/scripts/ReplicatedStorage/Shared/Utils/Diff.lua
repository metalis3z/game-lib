-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Collections = require(ReplicatedStorage.Shared.Utils.Collections)
return function(v1, v2, v3) -- line 8 | captures: Collections
    local v4
    if type(v1) == "table" and type(v2) == "table" then
        v4 = v3 or {}
    else
        return {}, {}
    end
    local SkipKeys = v4.SkipKeys
    local v5 = if v4.DeepEqualsUnsafe then Collections.MatchesFast else Collections.Matches
    local v6 = {}
    for v7, v8 in v2 do
        if SkipKeys then
            if SkipKeys[v7] then
            end
        else
            local v9 = v1[v7]
            if v9 ~= v8 and (typeof(v8) ~= typeof(v9) or type(v8) ~= "table" or not v5(v8, v9)) then
                v6[v7] = v8
            end
        end
    end
    local v10 = {}
    for v11 in v1 do
        if SkipKeys then
            if SkipKeys[v11] then
            end
        elseif v2[v11] == nil then
            v10[v11] = true
        end
    end
    return v6, v10
end

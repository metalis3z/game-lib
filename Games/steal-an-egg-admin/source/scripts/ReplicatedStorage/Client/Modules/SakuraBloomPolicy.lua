-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local v1 = {}

function v1.HasBloomUnlocked(v2, v3) -- line 9 | captures: GameFlags
    local v4, v5
    if GameFlags.GreatBloomEnabled:Get() and v2 then
        if v3 == nil then
            v5 = true
        else
            v4 = v3.Sakura.Unlocked == true
            v5 = false
        end
    else
        v5 = true
    end
    if not v5 then
        return v4
    end
    return false
end

function v1.CanShowBloom(v6, v7, v8) -- line 17 | captures: v1
    return v6 and v1.HasBloomUnlocked(v7, v8)
end

return table.freeze(v1)

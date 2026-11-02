-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local EmitOnce = require(game.ReplicatedStorage.UserGenerated.VFX.EmitOnce)
local v1

function v1(v2) -- line 8 | captures: v1, EmitOnce
    local function v3(v4, ...)
        return (math.max(v4, ...))
    end

    local function v5(v6, ...)
        return (math.max(v6, ...))
    end

    local v7
    if v2:IsA("ParticleEmitter") then
        v7 = v3(0, EmitOnce(v2))
    else
        v7 = 0
    end
    for v8, v9 in ipairs(v2:GetChildren()) do
        v7 = v5(v7, v1(v9))
    end
    return v7
end

return v1

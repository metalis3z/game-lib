-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = require(ReplicatedStorage.Packages.Signal).new()
local v2 = false
local v3 = {
    Completed = v1,
    Begin = function() -- Begin | line 11 | captures: v2
        local v4 = not v2
        assert(v4, "nested base upgrade transitions are not supported")
        v2 = true
    end
}

function v3.Complete() -- line 15 | captures: v2, v1
    local v5 = v2
    assert(v5, "no base upgrade transition is in flight to finish")
    v2 = false
    v1:Fire()
end

function v3.IsPlaying() -- line 20 | captures: v2
    return v2
end

return v3

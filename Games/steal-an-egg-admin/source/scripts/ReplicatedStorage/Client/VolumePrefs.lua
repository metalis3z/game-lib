-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Packages.Signal)
local v1 = {
    Music = 1,
    SFX = 1
}
local v2 = { Changed = Signal.new() }

function v2.Get(v3) -- line 11 | captures: v1
    return v1[v3]
end

function v2.Set(v4, v5) -- line 15 | captures: v1, v2
    local v6 = v1[v4] ~= nil
    local v7 = ("no volume category called %*"):format(v4)
    assert(v6, v7)
    local v8 = math.clamp(v5, 0, 1)
    if v1[v4] ~= v8 then
        v1[v4] = v8
        v2.Changed:Fire(v4, v8)
    end
end

return table.freeze(v2)

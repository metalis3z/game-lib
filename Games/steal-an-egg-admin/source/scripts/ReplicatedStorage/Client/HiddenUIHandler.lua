-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local v1 = { Changed = Signal.new() }
local v2 = {
    GUI.HUD(),
    GUI.Backpack(),
    GUI.OfflineMoneyInPlot()
}
local v3 = 0
local v4

local function isHidden() -- line 14 | captures: v3
    return v3 > 0
end

local function update() -- line 18 | captures: v3, v4, Tabs, v2
    v4 = nil
    local v5 = not (v3 > 0)
    for v6, v7 in v2 do
        v7.Enabled = v5
    end
    if not v5 then
        Tabs.Dismiss()
    end
end

local function scheduleUpdate() -- line 32 | captures: v4, update
    if v4 then
        task.cancel(v4)
    end
    v4 = task.defer(update)
end

function v1.IsHidden() -- line 38 | captures: v3
    return v3 > 0
end

function v1.Acquire() -- line 42 | captures: v3, v4, v1, update
    v3 += 1
    if v4 then
        task.cancel(v4)
    end
    v4 = task.defer(update)
    v1.Changed:Fire(true)
    local v8 = false
    return function() -- line 50 | captures: v8, v3, v4, v1, update
        if v8 then
            return
        end
        v8 = true
        v3 -= 1
        local v9 = v3 >= 0
        assert(v9, "hidden UI holder count became negative")
        if v4 then
            task.cancel(v4)
        end
        v4 = task.defer(update)
        local v10 = v3 > 0
        v1.Changed:Fire(v10)
    end
end

return table.freeze(v1)

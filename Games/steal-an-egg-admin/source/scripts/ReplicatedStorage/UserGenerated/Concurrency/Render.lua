-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Logging = require(ReplicatedStorage.UserGenerated.Logging)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local freeze = table.freeze
local v1 = {}
local freeze_2 = table.freeze
local v2 = {
    Disconnect = function(v3) -- Disconnect | line 11
        v3.Connection:Disconnect()
        v3:OnDisconnected()
    end,
    OnDisconnected = function(v4) -- OnDisconnected | line 15
        if v4.Vars.Disconnected then
            return
        end
        v4.Vars.Disconnected = true
        for v5, v6 in ipairs(v4.Callbacks) do
            task.spawn(v6)
        end
        table.clear(v4.Callbacks)
    end
}

function v2.Then(v7, v8) -- line 25 | captures: Asserts
    Asserts.Function(v8)
    if v7.Vars.Disconnected then
        task.spawn(v8)
    else
        local Callbacks = v7.Callbacks
        table.insert(Callbacks, v8)
    end
end

v1.__index = freeze_2(v2)

local v9 = freeze(v1)

function new(v10, v11) -- line 34 | captures: RunService, Logging, Asserts, v9
    Asserts.FiniteNonNegative(v10)
    Asserts.Function(v11)
    local v12 = {
        Callbacks = {}
    }
    v12.Vars = { Disconnected = false }
    local v13 = setmetatable(v12, v9)
    local v14 = 0
    local v15
    v15 = RunService.RenderStepped:Connect(function(v16) -- line 43 | captures: v14, v15, v10, v11, v13, Logging
        v14 += v16
        local v17
        if v10 <= v14 then
            v14 = v10
            v15:Disconnect()
            v17 = true
        else
            v17 = false
        end
        local v18 = if v14 < v10 then v14 / v10 else 1
        local v19, v20 = pcall(v11, v18, v14, v14 - v14)
        if v19 then
            if v20 ~= nil then
                v15:Disconnect()
                v17 = true
            end
        else
            Logging.Warn("RenderError", v20)
            v15:Disconnect()
            v17 = true
        end
        if v17 then
            v13:OnDisconnected()
        end
    end)
    v13.Connection = v15
    table.freeze(v13)
    return v13
end

return new

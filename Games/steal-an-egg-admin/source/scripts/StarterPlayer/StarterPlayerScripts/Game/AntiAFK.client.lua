-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local AfkProtection = require(ReplicatedStorage.Shared.Types.AfkProtection)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ANALYTICS_IDLE_THRESHOLD_SECONDS = AfkProtection.ANALYTICS_IDLE_THRESHOLD_SECONDS
local TELEPORT_IDLE_THRESHOLD_SECONDS = AfkProtection.TELEPORT_IDLE_THRESHOLD_SECONDS
local CLIENT_FALLBACK_IDLE_THRESHOLD_SECONDS = AfkProtection.CLIENT_FALLBACK_IDLE_THRESHOLD_SECONDS
local IDLE_POLL_INTERVAL_SECONDS = AfkProtection.IDLE_POLL_INTERVAL_SECONDS
local TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS = AfkProtection.TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS
local TELEPORT_DATA_KEY = AfkProtection.TELEPORT_DATA_KEY
local LocalPlayer = Players.LocalPlayer
local v1 = os.clock()
local v2 = 0
local v3 = false
local v4 = 0
local v5 = false

local function resolveIdleSeconds() -- line 25 | captures: v1, v2
    local v6 = os.clock() - v1
    local v7 = v2
    return (math.max(v6, v7))
end

local function reportIdleState(v8) -- line 29 | captures: v3, Remotes
    if v3 == v8 then
        return
    end
    v3 = v8
    Remotes.Telemetry.SubmitIdleState:FireServer(v8)
    Remotes.IdleRescue.SubmitIdleFlag:FireServer(v8)
end

local function markActive() -- line 37 | captures: v1, v2, v3, v4, v5, Remotes
    v1 = os.clock()
    v2 = 0
    v4 = 0
    v5 = false
    if v3 == false then
        return
    end
    v3 = false
    Remotes.Telemetry.SubmitIdleState:FireServer(false)
    Remotes.IdleRescue.SubmitIdleFlag:FireServer(false)
end

local function requestTeleport() -- line 49 | captures: v4, Remotes, TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS
    local v9 = os.clock()
    if not (v9 < v4) then
        v4 = v9 + TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS
        Remotes.IdleRescue.AskRescueHop:FireServer()
    end
end

local function fallbackTeleport() -- line 57 | captures: v5, TeleportService, Constants, Remotes, TELEPORT_DATA_KEY, LocalPlayer
    if v5 or Constants.IS_STUDIO or Constants.IS_PRIVATE_SERVER then
        return
    end
    v5 = true
    pcall(function() -- line 62 | captures: Remotes
        Remotes.Telemetry.AskIdleHopFlush:InvokeServer()
    end)
    local v10 = {}
    v10[TELEPORT_DATA_KEY] = true
    TeleportService:Teleport(game.PlaceId, LocalPlayer, v10)
end

local function step() -- line 69 | captures: v1, v2, v3, v4, Remotes, ANALYTICS_IDLE_THRESHOLD_SECONDS, TELEPORT_IDLE_THRESHOLD_SECONDS, CLIENT_FALLBACK_IDLE_THRESHOLD_SECONDS, TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS, fallbackTeleport
    local v11 = os.clock() - v1
    local v12 = v2
    local v13 = math.max(v11, v12)
    if v13 < ANALYTICS_IDLE_THRESHOLD_SECONDS then
        return
    end
    if v3 ~= true then
        v3 = true
        Remotes.Telemetry.SubmitIdleState:FireServer(true)
        Remotes.IdleRescue.SubmitIdleFlag:FireServer(true)
    end
    if TELEPORT_IDLE_THRESHOLD_SECONDS <= v13 then
        local v14 = os.clock()
        if v4 <= v14 then
            v4 = v14 + TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS
            Remotes.IdleRescue.AskRescueHop:FireServer()
        end
    end
    if CLIENT_FALLBACK_IDLE_THRESHOLD_SECONDS <= v13 then
        fallbackTeleport()
    end
end

LocalPlayer.Idled:Connect(function(v15) -- line 91 | captures: v2
    v2 = v15
end)
UserInputService.InputBegan:Connect(function() -- line 94 | captures: v1, v2, v3, v4, v5, Remotes
    v1 = os.clock()
    v2 = 0
    v4 = 0
    v5 = false
    if v3 == false then
        return
    end
    v3 = false
    Remotes.Telemetry.SubmitIdleState:FireServer(false)
    Remotes.IdleRescue.SubmitIdleFlag:FireServer(false)
end)
UserInputService.InputChanged:Connect(function(v16) -- line 106 | captures: v1, v2, v3, v4, v5, Remotes
    if not (v16.UserInputType == Enum.UserInputType.MouseMovement or v16.UserInputType == Enum.UserInputType.Touch or string.find(v16.UserInputType.Name, "Gamepad") ~= nil) then
        return
    end
    v1 = os.clock()
    v2 = 0
    v4 = 0
    v5 = false
    if v3 == false then
        return
    end
    v3 = false
    Remotes.Telemetry.SubmitIdleState:FireServer(false)
    Remotes.IdleRescue.SubmitIdleFlag:FireServer(false)
end)
task.spawn(function() -- line 134 | captures: v1, v2, v3, v4, Remotes, ANALYTICS_IDLE_THRESHOLD_SECONDS, TELEPORT_IDLE_THRESHOLD_SECONDS, CLIENT_FALLBACK_IDLE_THRESHOLD_SECONDS, IDLE_POLL_INTERVAL_SECONDS, TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS, fallbackTeleport
    while true do
        task.wait(IDLE_POLL_INTERVAL_SECONDS)
        local v17 = os.clock() - v1
        local v18 = v2
        local v19 = math.max(v17, v18)
        local v20
        if ANALYTICS_IDLE_THRESHOLD_SECONDS <= v19 then
            if v3 == true then
                v20 = true
            else
                v3 = true
                Remotes.Telemetry.SubmitIdleState:FireServer(true)
                Remotes.IdleRescue.SubmitIdleFlag:FireServer(true)
                if TELEPORT_IDLE_THRESHOLD_SECONDS <= v19 then
                    local v21 = os.clock()
                    if v4 <= v21 then
                        v4 = v21 + TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS
                        Remotes.IdleRescue.AskRescueHop:FireServer()
                    end
                end
                v20 = false
            end
        else
            v20 = true
        end
        if not v20 and CLIENT_FALLBACK_IDLE_THRESHOLD_SECONDS <= v19 then
            fallbackTeleport()
        end
    end
end)

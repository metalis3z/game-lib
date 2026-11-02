-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local v1
local v2 = {}
local v3

local function fadeSecondsFor(v4) -- line 15
    local function v5(...)
        return (tonumber(...))
    end

    local v6 = v4[1]
    return v6 ~= nil and v5(v6:GetAttribute("FadeSeconds")) or 1.2
end

local function show() -- line 22 | captures: v1, v2, v3, RunService, Workspace, Tween, PlayerGui
    local function v7(...)
        return (tonumber(...))
    end

    local function v8(...)
        return (tonumber(...))
    end

    local function v9(...)
        return (tonumber(...))
    end

    if v1 == nil then
        local v10 = PlayerGui:WaitForChild("RecoveryVignette", 10)
        if not (v10 ~= nil and v10:IsA("ScreenGui")) then
            warn("[RecoveryEvent] Missing StarterGui.RecoveryVignette; the vignette is skipped")
        elseif v1 == nil and Workspace:GetAttribute("Event_RecoveryEvent") then
            local v11 = v10:Clone()
            v11.Name = "RecoveryVignetteActive"
            v11.Enabled = true
            local v12 = {}
            local v13 = {}
            for v14, v15 in v11:GetChildren() do
                if v15:IsA("ImageLabel") then
                    table.insert(v12, v15)
                    local UIGradient = v15:FindFirstChildOfClass("UIGradient")
                    if UIGradient ~= nil then
                        table.insert(v13, UIGradient)
                    end
                end
            end
            if #v12 == 0 then
                warn("[RecoveryEvent] RecoveryVignette needs at least one ImageLabel; the vignette is skipped")
                v11:Destroy()
            else
                local v16 = v12[1]
                local v17 = v16 ~= nil and v7(v16:GetAttribute("FadeSeconds")) or 1.2
                local v18 = v8(v12[1]:GetAttribute("SpinDegreesPerSecond")) or 45
                for v19, v20 in v12 do
                    v20.ImageTransparency = 1
                end
                v1 = v11
                v2 = v12
                v11.Parent = PlayerGui
                for v21, v22 in v12 do
                    local v23 = v9(v22:GetAttribute("RestTransparency")) or 0.25
                    Tween(v22, { ImageTransparency = v23 }, { v17, "Sine", "Out" })
                end
                if #v13 > 0 then
                    local v24 = v13[1].Rotation
                    v3 = RunService.Heartbeat:Connect(function(v25) -- line 79 | captures: v24, v13, v18
                        v24 = (v24 + v18 * v25) % 360
                        for v26, v27 in v13 do
                            v27.Rotation = v24
                        end
                    end)
                end
            end
        end
    end
end

local function hide() -- line 90 | captures: v1, v2, v3, Tween
    local function v28(...)
        return (tonumber(...))
    end

    local v29 = v1
    local v30 = v2
    v1 = nil
    v2 = {}
    if v29 == nil then
        return
    end
    local v31 = v30[1]
    local v32 = v31 ~= nil and v28(v31:GetAttribute("FadeSeconds")) or 1.2
    if #v30 > 0 then
        Tween(v30, { ImageTransparency = 1 }, { v32, "Sine", "In" })
    end
    local v33 = v3
    v3 = nil
    task.delay(v32, function() -- line 110 | captures: v29, v33
        if v33 ~= nil then
            v33:Disconnect()
        end
        v29:Destroy()
    end)
end

local v34 = {}

function v34.StartEvent(v35, v36, v37) -- line 118 | captures: show
    show()
end

function v34.StopEvent(v38) -- line 121 | captures: hide
    hide()
end

Workspace:GetAttributeChangedSignal("Event_RecoveryEvent"):Connect(function() -- line 126 | captures: Workspace, show, hide
    if Workspace:GetAttribute("Event_RecoveryEvent") then
        show()
    else
        hide()
    end
end)

if Workspace:GetAttribute("Event_RecoveryEvent") then
    show()
else
    hide()
end
return v34

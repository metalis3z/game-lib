-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local SurfaceButtons = require(ReplicatedStorage.Client.UI.SurfaceButtons)
local v1 = Color3.fromRGB(255, 255, 255)
local v2 = { StepId = "ExpandPen" }

local function shouldPresent(v3) -- line 13
    return v3:CanAffordFirstBaseExpansion() and not v3:IsLocalPlayerInGameplay()
end

local function IsSatisfied(v4) -- line 20
    return v4:HasFinishedFirstBaseExpansion()
end

v2.IsSatisfied = IsSatisfied

function v2.Bind(v5, v6) -- line 23 | captures: RunService, v2
    local v7 = 0
    local v8 = false

    local function refresh() -- line 26 | captures: v8, v5, v6, v2
        if not v8 and v2.IsSatisfied(v5) then
            v8 = true
            v6()
        end
    end

    local v9 = v5.Changed:Connect(refresh)
    local v10 = RunService.Heartbeat:Connect(function(v11) -- line 34 | captures: v7, v8, v5, v6, v2
        v7 += v11
        if not (v7 < 0.1) then
            v7 = 0
            if not v8 and v2.IsSatisfied(v5) then
                v8 = true
                v6()
            end
        end
    end)
    task.defer(refresh)
    return function() -- line 47 | captures: v9, v10
        v9:Disconnect()
        v10:Disconnect()
    end
end

function v2.Present(v12, v13) -- line 52 | captures: RunService, SurfaceButtons, v1, v2
    local v14 = 0
    local v15 = false
    local v16 = false
    local v17

    local function clear() -- line 57 | captures: v15, v16, v17, v12
        if not v15 then
            return
        end
        v15 = false
        v16 = false
        v17 = nil
        v12:DropEverything()
    end

    local function refresh() -- line 66 | captures: v15, v16, v17, v12, v13, SurfaceButtons, v1, v2
        if v2.IsSatisfied(v13) then
            if v15 then
                v15 = false
                v16 = false
                v17 = nil
                v12:DropEverything()
            end
        elseif v13:CanAffordFirstBaseExpansion() and not v13:IsLocalPlayerInGameplay() then
            local v18 = v13:GetPlotUpgradeSignTarget()
            if v18 == nil then
                if v15 then
                    v15 = false
                    v16 = false
                    v17 = nil
                    v12:DropEverything()
                end
            elseif v15 then
                if v17 == v18 then
                    if not v16 then
                        local FirstUpgrade = SurfaceButtons.Find(v18, "FirstUpgrade")
                        if FirstUpgrade ~= nil then
                            v12:MarkTapTarget(FirstUpgrade, true)
                            v16 = true
                        end
                    end
                else
                    v15 = true
                    v17 = v18
                    v12:AnnounceTyped("Upgrade your Pen!", v1)
                    v12:PointBeamAt(v18.Position + Vector3.new(0, -1, 0))
                    local FirstUpgrade = SurfaceButtons.Find(v18, "FirstUpgrade")
                    if FirstUpgrade ~= nil then
                        v12:MarkTapTarget(FirstUpgrade, true)
                        v16 = true
                    end
                end
            else
                v15 = true
                v17 = v18
                v12:AnnounceTyped("Upgrade your Pen!", v1)
                v12:PointBeamAt(v18.Position + Vector3.new(0, -1, 0))
                local FirstUpgrade = SurfaceButtons.Find(v18, "FirstUpgrade")
                if FirstUpgrade ~= nil then
                    v12:MarkTapTarget(FirstUpgrade, true)
                    v16 = true
                end
            end
        elseif v15 then
            v15 = false
            v16 = false
            v17 = nil
            v12:DropEverything()
        end
    end

    local v19 = v13.Changed:Connect(refresh)
    local v20 = RunService.Heartbeat:Connect(function(v21) -- line 136 | captures: v14, refresh
        v14 += v21
        if v14 >= 0.1 then
            v14 = 0
            refresh()
        end
    end)
    refresh()
    return function() -- line 144 | captures: v15, v16, v17, v12, v19, v20
        v19:Disconnect()
        v20:Disconnect()
        if not v15 then
            return
        end
        v15 = false
        v16 = false
        v17 = nil
        v12:DropEverything()
    end
end

return v2

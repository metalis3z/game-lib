-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local v1 = Color3.fromRGB(255, 255, 255)
local v2 = {
    StepId = "StealEgg",
    IsSatisfied = function(v3) -- IsSatisfied | line 13
        return v3:HasStolenFirstEgg() and not v3:IsLocalPlayerInGameplay()
    end
}

function v2.Bind(v4, v5) -- line 21 | captures: RunService, v2
    local v6 = 0
    local v7 = false

    local function refresh() -- line 24 | captures: v7, v4, v5, v2
        if not v7 and v2.IsSatisfied(v4) then
            v7 = true
            v5()
        end
    end

    local v8 = v4.Changed:Connect(refresh)
    local v9 = RunService.Heartbeat:Connect(function(v10) -- line 32 | captures: v6, v7, v4, v5, v2
        v6 += v10
        if not (v6 < 0.1) then
            v6 = 0
            if not v7 and v2.IsSatisfied(v4) then
                v7 = true
                v5()
            end
        end
    end)
    task.defer(refresh)
    return function() -- line 45 | captures: v8, v9
        v8:Disconnect()
        v9:Disconnect()
    end
end

function v2.Present(v11, v12) -- line 50 | captures: RunService, v1, v2
    local function refreshPresentation() -- line 51 | captures: v11, v12, v1, v2
        if v2.IsSatisfied(v12) then
            v11:DropEverything()
        elseif v12:IsCarryingAreaEgg() or v12:HasStolenFirstEgg() then
            v11:DropAnnounce()
            v11:RetargetBeam(v12:GetGameplayExitTarget())
        else
            local v13 = v12:GetClosestAreaEggTarget()
            if v13 == nil then
                v11:DropBeam()
                v11:AnnounceTyped("Steal an Egg!", v1)
            else
                v11:AnnounceTyped("Steal an Egg!", v1)
                v11:RetargetBeam(v13)
            end
        end
    end

    local function refreshMovingExitTarget() -- line 70 | captures: v11, v12, v2
        if v2.IsSatisfied(v12) then
            v11:DropEverything()
        elseif v12:IsCarryingAreaEgg() or v12:HasStolenFirstEgg() then
            v11:DropAnnounce()
            v11:RetargetBeam(v12:GetGameplayExitTarget())
        end
    end

    local v14 = v12.Changed:Connect(refreshPresentation)
    local v15 = 0
    local v16 = RunService.Heartbeat:Connect(function(v17) -- line 88 | captures: v15, refreshMovingExitTarget
        v15 += v17
        if not (v15 < 0.1) then
            v15 = 0
            refreshMovingExitTarget()
        end
    end)
    refreshPresentation()
    return function() -- line 97 | captures: v11, v14, v16
        v14:Disconnect()
        v16:Disconnect()
        v11:DropEverything()
    end
end

return v2

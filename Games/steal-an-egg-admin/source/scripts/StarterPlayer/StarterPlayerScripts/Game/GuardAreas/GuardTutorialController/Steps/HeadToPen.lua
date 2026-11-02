-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local v1 = Color3.fromRGB(255, 255, 255)
local v2 = {
    StepId = "HeadToPen",
    IsSatisfied = function(v3) -- IsSatisfied | line 13
        return v3:HasReturnedToPen()
    end
}

function v2.Bind(v4, v5) -- line 17 | captures: RunService, v2
    local v6 = 0
    local v7 = false

    local function refresh() -- line 20 | captures: v7, v4, v5, v2
        if not v7 and v2.IsSatisfied(v4) then
            v7 = true
            v5()
        end
    end

    local v8 = v4.Changed:Connect(refresh)
    local v9 = RunService.Heartbeat:Connect(function(v10) -- line 28 | captures: v6, v7, v4, v5, v2
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
    return function() -- line 41 | captures: v8, v9
        v8:Disconnect()
        v9:Disconnect()
    end
end

function v2.Present(v11, v12) -- line 46 | captures: v1, v2
    local function refreshPresentation() -- line 47 | captures: v11, v12, v1, v2
        if v2.IsSatisfied(v12) then
            v11:DropEverything()
        else
            local v13 = v12:GetPlotSpawnTarget()
            v11:AnnounceTyped("Go to your Pen!", v1)
            if v13 == nil then
                v11:DropBeam()
            else
                v11:RetargetBeam(v13)
            end
        end
    end

    local v14 = v12.Changed:Connect(refreshPresentation)
    refreshPresentation()
    return function() -- line 62 | captures: v11, v14
        v14:Disconnect()
        v11:DropEverything()
    end
end

return v2

-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local StepUtils = require(script.Parent.Parent.StepUtils)
local v1 = Color3.fromRGB(255, 255, 255)
local v2 = {
    StepId = "HatchEgg",
    IsSatisfied = function(v3) -- IsSatisfied | line 14
        return v3:HasHatchedEgg()
    end
}

function v2.Bind(v4, v5) -- line 18 | captures: StepUtils, v2
    return StepUtils.BindOnAdapterChanged(v4, v2.IsSatisfied, v5)
end

function v2.Present(v6, v7) -- line 21 | captures: RunService, v1, v2
    local function refreshPresentation() -- line 22 | captures: v6, v7, v1, v2
        if v2.IsSatisfied(v7) or not v7:HasHatchableEgg() then
            v6:DropEverything()
        else
            v6:AnnounceTyped("Hatch the Egg!", v1)
            local v8 = v7:GetNearestHatchableEggTarget()
            if v8 == nil then
                v6:DropBeam()
            else
                v6:RetargetBeam(v8)
            end
        end
    end

    local v9 = v7.Changed:Connect(refreshPresentation)
    local v10 = 0
    local v11 = RunService.Heartbeat:Connect(function(v12) -- line 37 | captures: v10, refreshPresentation
        v10 += v12
        if not (v10 < 0.25) then
            v10 = 0
            refreshPresentation()
        end
    end)
    refreshPresentation()
    return function() -- line 46 | captures: v6, v9, v11
        v9:Disconnect()
        v11:Disconnect()
        v6:DropEverything()
    end
end

return v2

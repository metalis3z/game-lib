-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local External = require(script.Parent.External)
local v1 = {
    policies = { allowWebLinks = RunService:IsStudio() },
    doTaskImmediate = function(v2) -- doTaskImmediate | line 24
        task.spawn(v2)
    end,
    doTaskDeferred = function(v3) -- doTaskDeferred | line 33
        task.defer(v3)
    end,
    logErrorNonFatal = function(v4) -- logErrorNonFatal | line 42
        task.spawn(error, v4, 0)
    end,
    logWarn = warn
}

local function performUpdateStep() -- line 56 | captures: External
    External.performUpdateStep(os.clock())
end

local v5

function v1.startScheduler() -- line 64 | captures: v5, RunService, HttpService, performUpdateStep
    if v5 == nil then
        if RunService:IsClient() then
            local v6 = "FusionUpdateStep_" .. HttpService:GenerateGUID()
            RunService:BindToRenderStep(v6, Enum.RenderPriority.First.Value, performUpdateStep)

            function v5() -- line 77 | captures: v6, RunService
                RunService:UnbindFromRenderStep(v6)
            end
        else
            local v7 = RunService.Heartbeat:Connect(performUpdateStep)

            function v5() -- line 82 | captures: v7
                v7:Disconnect()
            end
        end
    end
end

function v1.stopScheduler() -- line 91 | captures: v5
    if v5 ~= nil then
        v5()
        v5 = nil
    end
end

return v1

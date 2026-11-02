-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Areas = require(ReplicatedStorage.Data.Areas)
local GuardChasePolicy = require(script.Parent.GuardChasePolicy)
local GuardEscape = require(ReplicatedStorage.Shared.Utils.GuardEscape)
local GuardEscapePrediction = require(script.Parent.GuardEscapePrediction)
local Guards = require(ReplicatedStorage.Data.Guards)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types.Interface)
local v1 = {}

function v1.BuildPathParameters(v2, v3, v4) -- line 15 | captures: Areas, GuardChasePolicy, GuardEscapePrediction, Guards, t
    t.strict(t.instanceIsA("Model"))(v2)
    t.strict(t.Vector3)(v3)
    t.strict(t.instanceIsA("BasePart"))(v4)
    local v5 = Guards.Directory[Areas.Directory[v2.Name].GuardId]
    local Bounds = v2:FindFirstChild("Bounds")
    local ClosestExitPoint = v2:FindFirstChild("ClosestExitPoint")
    local v6 = Bounds ~= nil
    local v7 = ("%*.Bounds is required"):format((v2:GetFullName()))
    assert(v6, v7)
    local v8 = ClosestExitPoint ~= nil
    local v9 = ("%*.ClosestExitPoint is required"):format((v2:GetFullName()))
    assert(v8, v9)
    local BasePart = Bounds:IsA("BasePart")
    local v10 = ("%*.Bounds must be a BasePart"):format((v2:GetFullName()))
    assert(BasePart, v10)
    local BasePart_2 = ClosestExitPoint:IsA("BasePart")
    local v11 = ("%*.ClosestExitPoint must be a BasePart"):format((v2:GetFullName()))
    assert(BasePart_2, v11)
    local v12 = -v4.CFrame.LookVector
    return {
        BaseGuardWalkSpeed = v5.WalkSpeed,
        ExitDirection = v12,
        ExitDistance = GuardEscapePrediction.ResolveExitDistance(Bounds.CFrame, Bounds.Size, ClosestExitPoint.Position, v12),
        FlatRadius = v5.FlatRadius,
        GuardStartPosition = v3,
        HitDistance = GuardChasePolicy.ResolveHitDistance(v5.HitDistance),
        PlayerStartPosition = ClosestExitPoint.Position
    }
end

function v1.ResolveSpeedPower(v13, v14, v15) -- line 45 | captures: GuardEscape, v1
    return GuardEscape.RequiredSpeedPower(v1.BuildPathParameters(v13, v14, v15))
end

return table.freeze(v1)

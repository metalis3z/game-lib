-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local GuardEscapePrediction = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardEscapePrediction)
local GuardEscapeRequirement = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardEscapeRequirement)
require(script.Parent.Parent.Parent.GUI.GuardAreas.RequiredSpeedSign)
local RequiredSpeedPower = require(ReplicatedStorage.Shared.Utils.GuardEscape).RequiredSpeedPower
local SpeedPowerProjection = require(ReplicatedStorage.Client.SpeedPowerProjection)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = {}

v1.__index = v1
v1.__class = "GuardEscapeSignController"

local SeparationLine = Workspace.__OBJECTS.Areas.SeparationLine
local BasePart = SeparationLine:IsA("BasePart")
assert(BasePart, "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")

function v1.new(v2, v3, v4) -- line 22 | captures: t, GuardEscapePrediction, GuardEscapeRequirement, RequiredSpeedPower, SpeedPowerProjection, TreadmillUtil, Trove, v1, SeparationLine
    t.strict(t.instanceIsA("Model"))(v2)
    t.strict(t.Vector3)(v3)
    t.strict(t.table)(v4)
    local v5 = {}
    local v6 = setmetatable(v5, v1)
    local v7 = GuardEscapeRequirement.BuildPathParameters(v2, v3, SeparationLine)
    v6._playerWalkSpeed = TreadmillUtil.SpeedPowerToWalkSpeed(SpeedPowerProjection.ReadProjected())
    v6._guardWalkSpeed = v7.BaseGuardWalkSpeed
    v6._flatRadius = v7.FlatRadius
    v6._guardHitDistance = v7.HitDistance
    v6._exitDistance = v7.ExitDistance
    v6._minimumEscapeWalkSpeed = GuardEscapePrediction.ResolvePlayerWalkSpeedRequirement(v7, 1)
    v6._requiredSpeedSign = v4
    v6._trove = Trove.new()
    v6._requiredSpeedSign:SetSpeedPowerRequirement(RequiredSpeedPower(v7))
    v6._trove:Add(SpeedPowerProjection.Changed:Connect(function(v8) -- line 40 | captures: v6, TreadmillUtil
        v6._playerWalkSpeed = TreadmillUtil.SpeedPowerToWalkSpeed(v8)
        v6:_render()
    end))
    v6:_render()
    return v6
end

function v1._render(v9) -- line 47 | captures: GuardEscapePrediction
    local v10 = GuardEscapePrediction.ResolveSlowdownTolerance(v9._minimumEscapeWalkSpeed, v9._playerWalkSpeed)
    v9._requiredSpeedSign:SetSlowdownTolerance(v10)
end

local function Destroy(v11) -- line 51
    v11._trove:Destroy()
end

v1.Destroy = Destroy
return v1

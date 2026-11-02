-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.numberMinExclusive((-1/0)), t.numberMaxExclusive((1/0)))
local ModelBounds = require(ReplicatedStorage.Shared.Utils.Spatial).ModelBounds
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggRenderer = require(script.Parent.EggRenderer)
local EggScaling = require(ReplicatedStorage.Shared.Util.EggScaling)
require(ReplicatedStorage.Shared.Types.Eggs)
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local v2 = Log.new()
local v3 = {}

function v3.GetGrowthAlpha(v4, v5) -- line 22 | captures: Workspace, EggRecords
    local v6 = Workspace:GetServerTimeNow()
    return EggRecords.GrowthAlpha(v4, v6, v4.GrowthSpeedMultiplier, v5)
end

function v3.GetDirectGrowthTweenRemainingSeconds(v7, v8) -- line 26 | captures: EggRecords
    local Placement = v7.Placement
    if not (Placement ~= nil and Placement.ReadyAt == nil) then
        return 0
    end
    if EggRecords.GrowthDuration(v7) >= 10 then
        return 0
    end
    return EggRecords.WallSecondsRemaining(v7, v8, v7.GrowthSpeedMultiplier)
end

function v3.GetStartScale(v9) -- line 37 | captures: EggRenderer, EggScaling
    local v10 = EggRenderer.GetAuthoredScale(v9)
    return EggScaling.PlacedStart(v10, v9.AssetScale, v9.AssetCategory)
end

function v3.GetTargetScale(v11) -- line 41 | captures: EggRenderer, EggScaling
    local v12 = EggRenderer.GetAuthoredScale(v11)
    return EggScaling.PlacedTarget(v12, v11.AssetScale, v11.AssetCategory)
end

function v3.GetVisualScale(v13, v14, v15) -- line 46 | captures: v3
    return v14 + v3.GetGrowthAlpha(v13, nil) * (v15 - v14)
end

function v3.IsReady(v16, v17) -- line 50 | captures: v3
    return v3.GetGrowthAlpha(v16, v17) >= 1
end

function v3.GetRemainingGrowthSeconds(v18, v19) -- line 55 | captures: Workspace, EggRecords
    local v20 = Workspace:GetServerTimeNow()
    return EggRecords.GrowthSecondsRemaining(v18, v20, v18.GrowthSpeedMultiplier, v19)
end

function v3.GetSkipReason(v21) -- line 59 | captures: Players, Workspace, t, ModelBounds, Player
    t.strict(t.instanceIsA("Model"))(v21)
    local v22 = Player.Optional.HumanoidRootPart(Players.LocalPlayer)
    if v22 == nil then
        return "local player root is unavailable"
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return "current camera is unavailable"
    end
    local v23 = ModelBounds(v21)
    local Magnitude = (v22.Position - v23.Position).Magnitude
    if Magnitude > 300 then
        return (("distance %* studs exceeds %*"):format(math.round(Magnitude), 300))
    end
    local v24, v25 = CurrentCamera:WorldToViewportPoint(v23.Position)
    _ = v24
    if v25 then
        return nil
    end
    return "visible bounds center is off-screen"
end

function v3.GetGrowthScaleDeltaSkipReason(v26, v27) -- line 83 | captures: t, v1
    t.strict(v1)(v26)
    t.strict(v1)(v27)
    local v28 = v27 - v26
    local v29 = math.abs(v28)
    if v29 <= 0.15 then
        local v30 = v29 * 1000
        return (("scale delta %* does not exceed %* presentation threshold"):format(math.round(v30) / 1000, 0.15))
    end
    local v31 = math.abs(v26)
    local v32 = v29 / math.max(v31, 0.001)
    if v32 > 0.03 then
        return nil
    end
    local v33 = v32 * 10000
    return (("relative scale delta %*%% does not exceed %*%% presentation threshold"):format(math.round(v33) / 100, 3))
end

function v3.GetNaturalGrowthSkipReason(v34, v35) -- line 102 | captures: t, v1, v3
    t.strict(t.instanceIsA("Model"))(v34)
    t.strict(v1)(v35)
    local v36 = v34:GetScale()
    local v37 = v3.GetGrowthScaleDeltaSkipReason(v36, v35)
    if v37 == nil then
        return v3.GetSkipReason(v34)
    end
    return v37
end

function v3.LogSkipped(v38, v39, v40) -- line 114 | captures: t, v2
    t.strict(t.string)(v38)
    t.strict(t.string)(v39)
    t.strict(t.string)(v40)
    v2:AtInfo():Log((("Skipped placed egg %* for %*: %*"):format(v39, v38, v40)))
end

return v3

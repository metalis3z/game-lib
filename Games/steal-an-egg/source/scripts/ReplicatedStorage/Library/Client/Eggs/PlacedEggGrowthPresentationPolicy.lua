-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)
local EggItemUtil = require(ReplicatedStorage.Library.Util.EggItemUtil)
local EggRenderer = require(script.Parent.EggRenderer)
local EggScaleUtil = require(ReplicatedStorage.Library.Util.EggScaleUtil)

require(ReplicatedStorage.Library.Types.Eggs)

local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Player = require(ReplicatedStorage.Library.Player)
local v1 = Log.new()
local t = {
	GetGrowthAlpha = function(p1, p2) --[[ GetGrowthAlpha | Line: 37 | Upvalues: EggItemUtil (copy), Workspace (copy) ]]
		return EggItemUtil.GetGrowthAlpha(p1, Workspace:GetServerTimeNow(), p1.GrowthSpeedMultiplier, p2)
	end,
	GetDirectGrowthTweenRemainingSeconds = function(p1, p2) --[[ GetDirectGrowthTweenRemainingSeconds | Line: 49 | Upvalues: EggItemUtil (copy) ]]
		local Placement = p1.Placement

		if Placement == nil or Placement.ReadyAt ~= nil then
			return 0
		end

		if EggItemUtil.GetGrowthDuration(p1) >= 10 then
			return 0
		end

		return EggItemUtil.GetRemainingGrowthWallSeconds(p1, p2, p1.GrowthSpeedMultiplier)
	end,
	GetStartScale = function(p1) --[[ GetStartScale | Line: 65 | Upvalues: EggScaleUtil (copy), EggRenderer (copy) ]]
		return EggScaleUtil.GetPlacedStartScale(EggRenderer.GetAuthoredScale(p1), p1.AssetScale)
	end,
	GetTargetScale = function(p1) --[[ GetTargetScale | Line: 69 | Upvalues: EggScaleUtil (copy), EggRenderer (copy) ]]
		return EggScaleUtil.GetPlacedTargetScale(EggRenderer.GetAuthoredScale(p1), p1.AssetScale)
	end
}

function t.GetVisualScale(p1, p2, p3) --[[ GetVisualScale | Line: 73 | Upvalues: t (copy) ]]
	return p2 + t.GetGrowthAlpha(p1, nil) * (p3 - p2)
end
function t.IsReady(p1, p2) --[[ IsReady | Line: 81 | Upvalues: t (copy) ]]
	return t.GetGrowthAlpha(p1, p2) >= 1
end
function t.GetRemainingGrowthSeconds(p1, p2) --[[ GetRemainingGrowthSeconds | Line: 88 | Upvalues: EggItemUtil (copy), Workspace (copy) ]]
	return EggItemUtil.GetRemainingGrowthSeconds(p1, Workspace:GetServerTimeNow(), p1.GrowthSpeedMultiplier, p2)
end
function t.GetSkipReason(p1) --[[ GetSkipReason | Line: 100 | Upvalues: Asserts (copy), Player (copy), Players (copy), Workspace (copy), BBFromModelVisibleOnly (copy) ]]
	Asserts.Model(p1)

	local v1 = Player.Optional.HumanoidRootPart(Players.LocalPlayer)

	if v1 == nil then
		return "local player root is unavailable"
	end

	local CurrentCamera = Workspace.CurrentCamera

	if CurrentCamera == nil then
		return "current camera is unavailable"
	end

	local v2 = BBFromModelVisibleOnly(p1)
	local Magnitude = (v1.Position - v2.Position).Magnitude

	if Magnitude > 300 then
		return ("distance %* studs exceeds %*"):format(math.round(Magnitude), 300)
	end

	local _, v3 = CurrentCamera:WorldToViewportPoint(v2.Position)

	if v3 then
		return nil
	end

	return "visible bounds center is off-screen"
end
function t.GetGrowthScaleDeltaSkipReason(p1, p2) --[[ GetGrowthScaleDeltaSkipReason | Line: 127 | Upvalues: Asserts (copy) ]]
	Asserts.finite(p1)
	Asserts.finite(p2)

	local v1 = math.abs(p2 - p1)

	if v1 <= 0.15 then
		return ("scale delta %* does not exceed %* presentation threshold"):format(math.round(v1 * 1000) / 1000, 0.15)
	end

	local v3 = v1 / math.max(math.abs(p1), 0.001)

	if v3 <= 0.03 then
		return ("relative scale delta %*%% does not exceed %*%% presentation threshold"):format(math.round(v3 * 10000) / 100, 3)
	end

	return nil
end
function t.GetNaturalGrowthSkipReason(p1, p2) --[[ GetNaturalGrowthSkipReason | Line: 149 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Model(p1)
	Asserts.finite(p2)

	local v1 = t.GetGrowthScaleDeltaSkipReason(p1:GetScale(), p2)

	if v1 == nil then
		return t.GetSkipReason(p1)
	end

	return v1
end
function t.LogSkipped(p1, p2, p3) --[[ LogSkipped | Line: 162 | Upvalues: Asserts (copy), v1 (copy) ]]
	Asserts.string(p1)
	Asserts.string(p2)
	Asserts.string(p3)
	v1:AtInfo():Log((("Skipped placed egg %* for %*: %*"):format(p2, p1, p3)))
end

return t
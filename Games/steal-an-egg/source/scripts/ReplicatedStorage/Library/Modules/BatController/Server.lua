-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local AntiCheatService = require(ServerScriptService.Controllers.AntiCheatService)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Config = require(script.Parent.Config)

require(script.Parent.Types.Interface)

local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local GameplayToolGuard = require(ServerScriptService.Library.Tools.Internal.GameplayToolGuard)
local Interface = require(ReplicatedStorage.Directory.Gears.Types.Interface)
local GetPlayerFromTool = require(ReplicatedStorage.Library.Functions.GetPlayerFromTool)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Network = require(ServerScriptService.Library.Network)
local Player = require(ReplicatedStorage.Library.Player)
local Ragdoll = require(ReplicatedStorage.Library.Modules.Ragdoll)
local SentryHitResolver = require(script.Parent.SentryHitResolver)
local SlapShared = require(ServerScriptService.Library.Tools.Internal.SlapShared)

require(ReplicatedStorage.Library.Types.Tools)

local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local t = {}

t.__index = t
t.__class = "BatServerController"

local Bat = Network.NET_MAP.Bat
local v1 = Log.new()

function t.new(p1, p2) --[[ new | Line: 63 | Upvalues: Asserts (copy), Interface (copy), t (copy), Config (copy), Trove (copy) ]]
	Asserts.Tool(p1)

	local v1, v2 = Interface.BatControllerData(p2)

	assert(v1, v2)

	local Handle = p1.Handle

	assert(Handle:IsA("BasePart"), "Bat.Handle must be a BasePart")

	local v5 = setmetatable({}, t)

	v5._tool = p1
	v5._handle = Handle
	v5._range = Config.Range + p2.RangeBonus
	v5._slapProfile = table.freeze({
		BrainrotDamage = 0,
		MaxBrainrotTargets = 0,
		Duration = p2.Duration,
		Force = p2.Force
	})
	v5._cooldownLockedUntil = 0
	v5._nextDebugLogAt = 0
	v5._processing = false
	v5._idleTrack = nil
	v5._trove = Trove.new()
	v5:_init()

	return v5
end
function t._setCooldownAttributes(p1, p2) --[[ _setCooldownAttributes | Line: 95 ]]
	local _tool = p1._tool
	local v1 = workspace:GetServerTimeNow() + p2

	_tool:SetAttribute("CooldownDuration", p2)
	_tool:SetAttribute("CooldownEndTime", v1)
	_tool:SetAttribute("CooldownActive", true)
	task.delay(p2, function() --[[ Line: 102 | Upvalues: _tool (copy), v1 (copy), p1 (copy) ]]
		if not _tool.Parent or _tool:GetAttribute("CooldownEndTime") ~= v1 then
			return
		end

		_tool:SetAttribute("CooldownActive", false)
		_tool:SetAttribute("CooldownDuration", 0)
		_tool:SetAttribute("CooldownEndTime", 0)
		p1._cooldownLockedUntil = 0
	end)
end
function t._playIdle(p1, p2) --[[ _playIdle | Line: 112 | Upvalues: Player (copy) ]]
	if p1._idleTrack then
		return
	end

	local v1 = Player.Optional.Humanoid(p2)
	local v2 = if v1 then v1:FindFirstChildOfClass("Animator") else v1
	local _ = v2 and p1._tool:FindFirstChild("IdleAnim")
end
function t._stopIdle(p1) --[[ _stopIdle | Line: 127 ]]
	local _idleTrack = p1._idleTrack

	if _idleTrack then
		p1._idleTrack = nil
		_idleTrack:Stop()
		_idleTrack:Destroy()
	end
end
function t._playHitAnimation(p1, p2) --[[ _playHitAnimation | Line: 138 | Upvalues: Player (copy) ]]
	local v1 = Player.Optional.Humanoid(p2)
	local v2 = if v1 then v1:FindFirstChildOfClass("Animator") else v1
	local HitAnim = p1._tool:FindFirstChild("HitAnim")

	if v2 and HitAnim then
		local v3 = v2:LoadAnimation(HitAnim)

		v3.Priority = Enum.AnimationPriority.Action
		v3:Play()
	end
end
function t._applyPlayerHit(p1, p2, p3) --[[ _applyPlayerHit | Line: 151 | Upvalues: Player (copy), GameplayToolGuard (copy), SlapShared (copy), Ragdoll (copy) ]]
	local v1 = Player.Optional.Character(p2)
	local v2 = Player.Optional.HumanoidRootPart(p2)

	if not (v1 and (v2 and v2:IsA("BasePart"))) then
		return
	end

	if v1:GetAttribute("IsTrapped") ~= true then
		GameplayToolGuard.DropHeldEggFromPlayerHit(p2)

		local v3, v4 = SlapShared.ComputeImpulse(v2, p3, p1._slapProfile)

		p2:SetAttribute("RagdollEndTime", workspace:GetServerTimeNow() + v4)
		Ragdoll.TimedRagdollAsync(v1, v4, v3)
	end
end
function t._canLogDebugTrace(p1, p2) --[[ _canLogDebugTrace | Line: 167 | Upvalues: Constants (copy) ]]
	if Constants.IS_STUDIO and not (p2 < p1._nextDebugLogAt) then
		p1._nextDebugLogAt = p2 + 0.1

		return true
	end

	return false
end
function t._logDecisionTrace(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10) --[[ _logDecisionTrace | Line: 176 | Upvalues: Player (copy), Config (copy), v1 (copy) ]]
	if not p1:_canLogDebugTrace(p4) then
		return
	end

	local v12 = if p7 and p7.Target then p7.Target else p6
	local v2 = if v12 then Player.Optional.HumanoidRootPart(v12) else nil
	local v3 = if v2 and v2:IsA("BasePart") then v2 else nil
	local v4 = Player.Optional.Humanoid(p2)
	local v5 = if p5 then p5.AssemblyLinearVelocity else Vector3.new(0, 0, 0)
	local v6 = if v3 then v3.AssemblyLinearVelocity else Vector3.new(0, 0, 0)
	local v8 = if p7 then p7.CurrentDistance elseif p5 and v3 then (v3.Position - p5.Position).Magnitude else -1
	local v9 = v1:AtInfo()
	local t = {
		Stage = "SERVER_DECISION",
		TraceId = p3,
		Decision = p8,
		Explanation = p9,
		Action = p10
	}

	t.Accepted = if p10 == "HIT_ACTION_DISPATCHED" then true else false
	t.ServerTime = p4
	t.AttackerName = p2.Name
	t.AttackerUserId = p2.UserId
	t.TargetName = if v12 then v12.Name else "None"
	t.TargetUserId = if v12 then v12.UserId else 0
	t.MaximumRange = p1._range + Config.HitTolerance
	t.ServerCurrentDistance = v8
	t.ServerHistoricalDistance = if p7 then p7.HistoricalDistance else -1
	t.TargetViewAgeSeconds = if p7 then p7.TargetViewAge else -1
	t.HistoricalTimestamp = if p7 then p7.HistoricalTimestamp else -1
	t.HistoricalSampleIntervalSeconds = if p7 then p7.HistoricalSampleInterval else -1
	t.NetworkPingSeconds = p2:GetNetworkPing()
	t.CooldownRemainingSeconds = math.max(0, p1._cooldownLockedUntil - p4)
	t.CooldownToApplySeconds = if p10 == "HIT_ACTION_DISPATCHED" or p10 == "MISS_COOLDOWN_APPLIED" then 0.7 else 0
	t.AttackerServerPosition = if p5 then p5.Position else Vector3.new(0, 0, 0)
	t.TargetCurrentServerPosition = if p7 then p7.TargetServerPosition elseif v3 then v3.Position else Vector3.new(0, 0, 0)
	t.TargetHistoricalServerPosition = if p7 then p7.TargetHistoricalServerPosition else Vector3.new(0, 0, 0)
	t.AttackerWalkSpeed = if v4 then v4.WalkSpeed else -1
	t.AttackerHorizontalSpeed = Vector3.new(v5.X, 0, v5.Z).Magnitude
	t.TargetHorizontalSpeed = Vector3.new(v6.X, 0, v6.Z).Magnitude
	t.TargetServerStationary = if v3 == nil then false else Vector3.new(v6.X, 0, v6.Z).Magnitude <= 1
	v9:Log("Bat hit validation trace", t)
end
function t._resolveValidTarget(p1, p2, p3, p4, p5) --[[ _resolveValidTarget | Line: 241 | Upvalues: Players (copy), Player (copy), Ragdoll (copy), Config (copy), AntiCheatService (copy) ]]
	local t = {
		Delta = nil,
		Decision = "CLIENT_NO_TARGET",
		Explanation = "The client did not nominate a player inside its rendered selection range.",
		CurrentDistance = -1,
		HistoricalDistance = -1,
		TargetViewAge = -1,
		HistoricalTimestamp = -1,
		HistoricalSampleInterval = -1,
		TargetServerPosition = Vector3.new(0, 0, 0),
		TargetHistoricalServerPosition = Vector3.new(0, 0, 0),
		Target = p3
	}

	if p3 == nil then
		return t
	end

	if p3 == p2 then
		t.Decision = "SELF_TARGET_REJECTED"
		t.Explanation = "The nominated target was the attacker."

		return t
	end

	if p3.Parent ~= Players then
		t.Decision = "TARGET_NOT_IN_SERVER"
		t.Explanation = "The nominated player was no longer in this server."

		return t
	end

	local v1 = Player.Optional.Character(p3)
	local v2 = Player.Optional.HumanoidRootPart(p3)
	local v3 = Player.Optional.Humanoid(p3)

	if not (v1 and (v2 and (v2:IsA("BasePart") and v3))) then
		t.Decision = "TARGET_CHARACTER_UNAVAILABLE"
		t.Explanation = "The server could not resolve the nominated target\'s live character, root, or Humanoid."

		return t
	end

	t.TargetServerPosition = v2.Position

	if v3.Health <= 0 then
		t.Decision = "TARGET_DEAD"
		t.Explanation = "The nominated target was dead when the server handled the swing."

		return t
	end

	if Ragdoll.IsRagdolled(v1) then
		t.Decision = "TARGET_ALREADY_RAGDOLLED"
		t.Explanation = "The nominated target was already ragdolled and is not eligible for another Bat hit."

		return t
	end

	local v4 = v2.Position - p4.Position
	local v5 = p1._range + Config.HitTolerance

	t.CurrentDistance = v4.Magnitude

	if t.CurrentDistance <= v5 then
		t.Target = p3
		t.Delta = v4
		t.Decision = "CURRENT_RANGE_ACCEPTED"
		t.Explanation = "The server currently sees the target inside MaximumRange; history compensation was not needed."

		return t
	end

	local v7 = math.clamp(p2:GetNetworkPing() + Config.TargetViewSamplePadding, Config.TargetViewSamplePadding, Config.MaximumTargetViewAge)
	local v8 = p5 - v7

	t.TargetViewAge = v7
	t.HistoricalTimestamp = v8

	local v9 = AntiCheatService.GetHistoricalPosition(p3, v8)

	if v9 == nil then
		t.Decision = "HISTORY_UNAVAILABLE"
		t.Explanation = "Current distance exceeded MaximumRange and the server could not reconstruct the target at HistoricalTimestamp."

		return t
	end

	t.HistoricalSampleInterval = v9.SampleInterval
	t.TargetHistoricalServerPosition = v9.Position
	t.HistoricalDistance = (v9.Position - p4.Position).Magnitude

	if v5 < t.HistoricalDistance then
		t.Decision = "CURRENT_AND_HISTORY_OUT_OF_RANGE"
		t.Explanation = "Both ServerCurrentDistance and ServerHistoricalDistance exceeded MaximumRange."
	else
		t.Target = p3
		t.Delta = v4
		t.Decision = "HISTORICAL_RANGE_ACCEPTED"
		t.Explanation = "Current distance exceeded MaximumRange, but server-owned history proves the target was inside range in the estimated client view."
	end

	return t
end
function t._beginActivation(p1, p2) --[[ _beginActivation | Line: 341 | Upvalues: Player (copy), Ragdoll (copy), GameplayToolGuard (copy) ]]
	local v1 = Player.Optional.Character(p2)

	if not v1 then
		return nil, "ATTACKER_CHARACTER_UNAVAILABLE", "The server could not resolve the attacker\'s character."
	end

	if Ragdoll.IsRagdolled(v1) then
		return nil, "ATTACKER_RAGDOLLED", "The server rejected the swing because the attacker was ragdolled."
	end

	if not GameplayToolGuard.CanActivate(p2) then
		return nil, "GAMEPLAY_GUARD_REJECTED", "The gameplay tool guard rejected the swing before target validation."
	end

	p1:_playHitAnimation(p2)

	local v2 = Player.Optional.HumanoidRootPart(p2)

	if v2 and v2:IsA("BasePart") then
		return v2, "ACTIVATION_ACCEPTED", "The swing passed attacker and gameplay activation guards."
	end

	return nil, "ATTACKER_ROOT_UNAVAILABLE", "The server could not resolve the attacker\'s HumanoidRootPart."
end
function t._finishMiss(p1) --[[ _finishMiss | Line: 361 ]]
	local Slash = p1._handle:FindFirstChild("Slash")

	if not Slash then
		return 0.7
	end

	Slash:Play()

	return 0.7
end
function t._applyHits(p1, p2, p3) --[[ _applyHits | Line: 369 | Upvalues: SentryHitResolver (copy) ]]
	if #p3 == 0 then
		return p1:_finishMiss()
	end

	local Hit = p1._handle:FindFirstChild("Hit")

	if Hit then
		Hit:Play()
	end

	SentryHitResolver(p2.Position, p1._range)

	for i, v in ipairs(p3) do
		p1:_applyPlayerHit(v.target, v.delta)
	end

	return 0.7
end
function t._activate(p1, p2, p3, p4, p5) --[[ _activate | Line: 389 ]]
	local v1, v2, v3 = p1:_beginActivation(p2)

	if not v1 then
		p1:_logDecisionTrace(p2, p5, p4, nil, p3, nil, v2, v3, "NO_ACTION")

		return nil
	end

	local v4 = p1:_resolveValidTarget(p2, p3, v1, p4)
	local Target = v4.Target
	local Delta = v4.Delta

	if Target and Delta then
		local v5 = p1:_applyHits(v1, {
			{
				target = Target,
				delta = Delta
			}
		})

		p1:_logDecisionTrace(p2, p5, p4, v1, p3, v4, v4.Decision, v4.Explanation, "HIT_ACTION_DISPATCHED")

		return v5
	end

	local v6 = p1:_finishMiss()

	p1:_logDecisionTrace(p2, p5, p4, v1, p3, v4, v4.Decision, v4.Explanation, "MISS_COOLDOWN_APPLIED")

	return v6
end
function t._canProcessRequest(p1, p2) --[[ _canProcessRequest | Line: 446 | Upvalues: Player (copy), GetPlayerFromTool (copy), Ragdoll (copy) ]]
	local v1 = Player.Optional.Character(p2)

	if not v1 then
		return false, "REQUEST_CHARACTER_UNAVAILABLE", "The request arrived without a live attacker character."
	end

	if p1._tool.Parent ~= v1 or GetPlayerFromTool(p1._tool) ~= p2 then
		return false, "REQUEST_TOOL_NOT_EQUIPPED", "The server rejected the request because this Bat was not equipped and owned by the attacker."
	end

	if Ragdoll.IsRagdolled(v1) then
		return false, "REQUEST_ATTACKER_RAGDOLLED", "The server rejected the request because the attacker was ragdolled."
	end

	if p1._processing then
		return false, "REQUEST_ALREADY_PROCESSING", "The previous Bat request is still being processed."
	end

	if workspace:GetServerTimeNow() < p1._cooldownLockedUntil then
		return false, "REQUEST_COOLDOWN_ACTIVE", "The request arrived before the server Bat cooldown ended."
	end

	return true, "REQUEST_ACCEPTED", "The request passed equip, ownership, ragdoll, processing, and cooldown guards."
end
function t._runActivation(p1, p2, p3) --[[ _runActivation | Line: 470 ]]
	local v1, v2, v3 = p1:_canProcessRequest(p2)

	if not v1 then
		return false, v2, v3
	end

	p1._processing = true

	local v4 = p3(p1, p2)

	p1._processing = false

	if not v4 then
		return true, "REQUEST_PROCESSED", "The server completed the Bat activation callback."
	end

	p1._cooldownLockedUntil = workspace:GetServerTimeNow() + v4
	p1:_setCooldownAttributes(v4)

	return true, "REQUEST_PROCESSED", "The server completed the Bat activation callback."
end
function t._handleActivation(p1, p2, p3, p4) --[[ _handleActivation | Line: 490 | Upvalues: Asserts (copy), Player (copy) ]]
	Asserts.Player(p2)
	Asserts.optional.Player(p3)
	Asserts.string(p4)

	local v1 = workspace:GetServerTimeNow()
	local v2, v3, v4 = p1:_runActivation(p2, function(p1, p2) --[[ Line: 502 | Upvalues: p3 (copy), v1 (copy), p4 (copy) ]]
		return p1:_activate(p2, p3, v1, p4)
	end)

	if v2 then
		return
	end

	p1:_logDecisionTrace(p2, p4, v1, Player.Optional.HumanoidRootPart(p2), p3, nil, v3, v4, "NO_ACTION")
end
function t.Destroy(p1) --[[ Destroy | Line: 525 | Upvalues: v1 (copy) ]]
	p1:_stopIdle()
	p1._trove:Destroy()
	v1:AtDebug():Log("Bat server controller destroyed")
end
function t._init(p1) --[[ _init | Line: 535 | Upvalues: Network (copy), Bat (copy), GetPlayerFromTool (copy) ]]
	local _tool = p1._tool

	_tool:SetAttribute("CooldownEndTime", 0)
	_tool:SetAttribute("CooldownDuration", 0)
	_tool:SetAttribute("CooldownActive", false)
	p1._trove:Connect(Network.Fired(Bat.ACTIVATE), function(p12, p2, p3) --[[ Line: 541 | Upvalues: p1 (copy) ]]
		p1:_handleActivation(p12, p2, p3)
	end)
	p1._trove:Connect(_tool.Equipped, function() --[[ Line: 544 | Upvalues: GetPlayerFromTool (ref), _tool (copy), p1 (copy) ]]
		local v1 = GetPlayerFromTool(_tool)

		if not v1 then
			return
		end

		p1:_playIdle(v1)
	end)
	p1._trove:Connect(_tool.Unequipped, function() --[[ Line: 550 | Upvalues: p1 (copy) ]]
		p1:_stopIdle()
	end)
	p1._trove:Connect(_tool.Destroying, function() --[[ Line: 553 | Upvalues: p1 (copy) ]]
		p1:Destroy()
	end)
end

return t
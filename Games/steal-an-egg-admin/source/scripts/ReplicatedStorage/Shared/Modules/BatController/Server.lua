-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local AntiCheatService = require(ServerScriptService.Controllers.AntiCheatService)
local Config = require(script.Parent.Config)
require(script.Parent.Types.Interface)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GameplayToolGuard = require(ServerScriptService.Library.Tools.Internal.GameplayToolGuard)
require(ReplicatedStorage.Data.Gears)
local FromTool = require(ReplicatedStorage.Shared.Utils.PlayerUtils).FromTool
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local Ragdoll = require(ReplicatedStorage.Shared.Modules.Ragdoll)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local SentryHitResolver = require(script.Parent.SentryHitResolver)
local SlapShared = require(ServerScriptService.Library.Tools.Internal.SlapShared)
require(ReplicatedStorage.Shared.Types.Tools)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

v1.__index = v1
v1.__class = "BatServerController"

local v2 = Log.new()

function v1.new(v3, v4) -- line 29 | captures: Config, Trove, t, v1
    t.strict(t.instanceIsA("Tool"))(v3)
    local v5 = typeof(v4) == "table"
    assert(v5, "Bat controller data must be a table")
    local Duration = v4.Duration
    local v6 = typeof(Duration) == "number"
    assert(v6, "Bat controller duration must be a number")
    local Force = v4.Force
    local v7 = typeof(Force) == "number"
    assert(v7, "Bat controller force must be a number")
    local RangeBonus = v4.RangeBonus
    local v8 = typeof(RangeBonus) == "number"
    assert(v8, "Bat controller range bonus must be a number")
    local Handle = v3.Handle
    local BasePart = Handle:IsA("BasePart")
    assert(BasePart, "Bat.Handle must be a BasePart")
    local v9 = {}
    local v10 = setmetatable(v9, v1)
    v10._tool = v3
    v10._handle = Handle
    v10._range = Config.Range + v4.RangeBonus
    v10._slapProfile = table.freeze({
        BrainrotDamage = 0,
        MaxBrainrotTargets = 0,
        Duration = v4.Duration,
        Force = v4.Force
    })
    v10._cooldownLockedUntil = 0
    v10._nextDebugLogAt = 0
    v10._processing = false
    v10._idleTrack = nil
    v10._trove = Trove.new()
    v10:_init()
    return v10
end

local function _setCooldownAttributes(v11, v12) -- line 56
    local _tool = v11._tool
    local v13 = workspace:GetServerTimeNow() + v12
    _tool:SetAttribute("CooldownDuration", v12)
    _tool:SetAttribute("CooldownEndTime", v13)
    _tool:SetAttribute("CooldownActive", true)
    task.delay(v12, function() -- line 62 | captures: v11, _tool, v13
        if not (_tool.Parent and _tool:GetAttribute("CooldownEndTime") == v13) then
            return
        end
        _tool:SetAttribute("CooldownActive", false)
        _tool:SetAttribute("CooldownDuration", 0)
        _tool:SetAttribute("CooldownEndTime", 0)
        v11._cooldownLockedUntil = 0
    end)
end

v1._setCooldownAttributes = _setCooldownAttributes

function v1._playIdle(v14, v15) -- line 74 | captures: Player
    if v14._idleTrack then
        return
    end
    local v16 = Player.Optional.Humanoid(v15)
    local v17 = v16 and v16:FindFirstChildOfClass("Animator")
    local IdleAnim = v14._tool:FindFirstChild("IdleAnim")
    if not (v17 and IdleAnim) then
        return
    end
    local v18 = v17:LoadAnimation(IdleAnim)
    v18.Priority = Enum.AnimationPriority.Idle
    v18.Looped = true
    v18:Play()
    v14._idleTrack = v18
end

local function _stopIdle(v19) -- line 96
    local _idleTrack = v19._idleTrack
    if not _idleTrack then
        return
    end
    v19._idleTrack = nil
    _idleTrack:Stop()
    _idleTrack:Destroy()
end

v1._stopIdle = _stopIdle

function v1._playHitAnimation(v20, v21) -- line 105 | captures: Player
    local v22 = Player.Optional.Humanoid(v21)
    local v23 = v22 and v22:FindFirstChildOfClass("Animator")
    local HitAnim = v20._tool:FindFirstChild("HitAnim")
    if not (v23 and HitAnim) then
        return
    end
    local v24 = v23:LoadAnimation(HitAnim)
    v24.Priority = Enum.AnimationPriority.Action
    v24:Play()
end

function v1._applyPlayerHit(v25, v26, v27) -- line 119 | captures: GameplayToolGuard, Player, Ragdoll, SlapShared
    local v28 = Player.Optional.Character(v26)
    local v29 = Player.Optional.HumanoidRootPart(v26)
    if not (v28 and v29 and v29:IsA("BasePart") and v28:GetAttribute("IsTrapped") ~= true and GameplayToolGuard.IsPlayerInGameplayArea(v26)) then
        return
    end
    GameplayToolGuard.DropHeldEggFromPlayerHit(v26)
    local v30, v31 = SlapShared.ComputeImpulse(v29, v27, v25._slapProfile)
    v26:SetAttribute("RagdollEndTime", workspace:GetServerTimeNow() + v31)
    Ragdoll.TimedRagdollAsync(v28, v31, v30)
end

function v1._canLogDebugTrace(v32, v33) -- line 131 | captures: Constants
    if not Constants.IS_STUDIO or v33 < v32._nextDebugLogAt then
        return false
    end
    v32._nextDebugLogAt = v33 + 0.1
    return true
end

function v1._logDecisionTrace(v34, v35, v36, v37, v38, v39, v40, v41, v42, v43) -- line 138 | captures: Config, Player, v2
    if not v34:_canLogDebugTrace(v37) then
        return
    end
    local v44
    if v40 then
        if v40.Target then
            v44 = v40.Target
        end
    else
        v44 = v39
    end
    local v45
    if v44 then
        v45 = Player.Optional.HumanoidRootPart(v44)
    end
    if not (v45 and v45:IsA("BasePart")) then
        v45 = nil
    end
    local v46 = Player.Optional.Humanoid(v35)
    local v47
    if v38 then
        v47 = v38.AssemblyLinearVelocity
    else
        v47 = Vector3.new(0, 0, 0)
    end
    local v48
    if v45 then
        v48 = v45.AssemblyLinearVelocity
    else
        v48 = Vector3.new(0, 0, 0)
    end
    local v49 = (v34._range + Config.HitTolerance) * Config.GetHitboxScalar()
    local v50
    if v40 then
        v50 = v40.CurrentDistance
    elseif v38 then
        if v45 then
            v50 = (v45.Position - v38.Position).Magnitude
        end
    else
        v50 = -1
    end
    local v51 = v2:AtInfo()
    local v52 = {
        Stage = "SERVER_DECISION",
        TraceId = v36,
        Decision = v41,
        Explanation = v42,
        Action = v43
    }
    local v53 = v43 == "HIT_ACTION_DISPATCHED"
    v52.Accepted = v53
    v52.ServerTime = v37
    v52.AttackerName = v35.Name
    v52.AttackerUserId = v35.UserId
    if v44 then
        v52.TargetName = v44.Name
        v52.TargetUserId = v44.UserId
    else
        v52.TargetName = "None"
        v52.TargetUserId = 0
    end
    v52.MaximumRange = v49
    v52.ServerCurrentDistance = v50
    if v40 then
        v52.ServerHistoricalDistance = v40.HistoricalDistance
        v52.TargetViewAgeSeconds = v40.TargetViewAge
        v52.HistoricalTimestamp = v40.HistoricalTimestamp
        v52.HistoricalSampleIntervalSeconds = v40.HistoricalSampleInterval
    else
        v52.ServerHistoricalDistance = -1
        v52.TargetViewAgeSeconds = -1
        v52.HistoricalTimestamp = -1
        v52.HistoricalSampleIntervalSeconds = -1
    end
    v52.NetworkPingSeconds = v35:GetNetworkPing()
    local v54 = v34._cooldownLockedUntil - v37
    v52.CooldownRemainingSeconds = math.max(0, v54)
    if v43 == "HIT_ACTION_DISPATCHED" then
        v53 = 0.7
    elseif v43 ~= "MISS_COOLDOWN_APPLIED" then
        v53 = 0
    end
    v52.CooldownToApplySeconds = v53
    if v38 then
        v52.AttackerServerPosition = v38.Position
    else
        v52.AttackerServerPosition = Vector3.new(0, 0, 0)
    end
    if v40 then
        v52.TargetCurrentServerPosition = v40.TargetServerPosition
        v52.TargetHistoricalServerPosition = v40.TargetHistoricalServerPosition
    else
        if v45 then
            v52.TargetCurrentServerPosition = v45.Position
        else
            v52.TargetCurrentServerPosition = Vector3.new(0, 0, 0)
        end
        v52.TargetHistoricalServerPosition = Vector3.new(0, 0, 0)
    end
    if v46 then
        v52.AttackerWalkSpeed = v46.WalkSpeed
    else
        v52.AttackerWalkSpeed = -1
    end
    local X = v47.X
    local Z = v47.Z
    v52.AttackerHorizontalSpeed = Vector3.new(X, 0, Z).Magnitude
    local X_2 = v48.X
    local Z_2 = v48.Z
    v52.TargetHorizontalSpeed = Vector3.new(X_2, 0, Z_2).Magnitude
    if v45 == nil then
        v52.TargetServerStationary = false
    else
        local X = v48.X
        local Z = v48.Z
        v52.TargetServerStationary = Vector3.new(X, 0, Z).Magnitude <= 1
    end
    v51:Log("Bat hit validation trace", v52)
end

function v1._resolveValidTarget(v55, v56, v57, v58, v59) -- line 268 | captures: Players, AntiCheatService, Config, GameplayToolGuard, Player, Ragdoll
    local v60 = {
        Decision = "CLIENT_NO_TARGET",
        Explanation = "The client did not nominate a player inside its rendered selection range.",
        CurrentDistance = -1,
        HistoricalDistance = -1,
        TargetViewAge = -1,
        HistoricalTimestamp = -1,
        HistoricalSampleInterval = -1,
        TargetServerPosition = Vector3.new(0, 0, 0),
        TargetHistoricalServerPosition = Vector3.new(0, 0, 0),
        Target = v57
    }
    if v57 ~= nil then
        if v57 == v56 then
            v60.Decision = "SELF_TARGET_REJECTED"
            v60.Explanation = "The nominated target was the attacker."
        elseif v57.Parent == Players then
            local v61 = Player.Optional.Character(v57)
            local v62 = Player.Optional.HumanoidRootPart(v57)
            local v63 = Player.Optional.Humanoid(v57)
            if v61 and v62 and v62:IsA("BasePart") and v63 then
                v60.TargetServerPosition = v62.Position
                if v63.Health <= 0 then
                    v60.Decision = "TARGET_DEAD"
                    v60.Explanation = "The nominated target was dead when the server handled the swing."
                elseif Ragdoll.IsRagdolled(v61) then
                    v60.Decision = "TARGET_ALREADY_RAGDOLLED"
                    v60.Explanation = "The nominated target was already ragdolled and is not eligible for another Bat hit."
                elseif GameplayToolGuard.IsPlayerInGameplayArea(v57) then
                    local v64 = v62.Position - v58.Position
                    local v65 = (v55._range + Config.HitTolerance) * Config.GetHitboxScalar()
                    v60.CurrentDistance = v64.Magnitude
                    if v60.CurrentDistance <= v65 then
                        v60.Target = v57
                        v60.Delta = v64
                        v60.Decision = "CURRENT_RANGE_ACCEPTED"
                        v60.Explanation = "The server currently sees the target inside MaximumRange; history compensation was not needed."
                    else
                        local v66 = v56:GetNetworkPing() + Config.TargetViewSamplePadding
                        local TargetViewSamplePadding = Config.TargetViewSamplePadding
                        local MaximumTargetViewAge = Config.MaximumTargetViewAge
                        local v67 = math.clamp(v66, TargetViewSamplePadding, MaximumTargetViewAge)
                        local v68 = v59 - v67
                        v60.TargetViewAge = v67
                        v60.HistoricalTimestamp = v68
                        local v69 = AntiCheatService.GetHistoricalPosition(v57, v68)
                        if v69 == nil then
                            v60.Decision = "HISTORY_UNAVAILABLE"
                            v60.Explanation = "Current distance exceeded MaximumRange and the server could not reconstruct the target at HistoricalTimestamp."
                        else
                            v60.HistoricalSampleInterval = v69.SampleInterval
                            v60.TargetHistoricalServerPosition = v69.Position
                            v60.HistoricalDistance = (v69.Position - v58.Position).Magnitude
                            if v65 < v60.HistoricalDistance then
                                v60.Decision = "CURRENT_AND_HISTORY_OUT_OF_RANGE"
                                v60.Explanation = "Both ServerCurrentDistance and ServerHistoricalDistance exceeded MaximumRange."
                            else
                                v60.Target = v57
                                v60.Delta = v64
                                v60.Decision = "HISTORICAL_RANGE_ACCEPTED"
                                v60.Explanation = "Current distance exceeded MaximumRange, but server-owned history proves the target was inside range in the estimated client view."
                            end
                        end
                    end
                else
                    v60.Decision = "TARGET_IN_SAFE_ZONE"
                    v60.Explanation = "The nominated target was in the safe zone and is not eligible for a Bat hit."
                end
                return v60
            end
            v60.Decision = "TARGET_CHARACTER_UNAVAILABLE"
            v60.Explanation = "The server could not resolve the nominated target's live character, root, or Humanoid."
        else
            v60.Decision = "TARGET_NOT_IN_SERVER"
            v60.Explanation = "The nominated player was no longer in this server."
        end
    end
    return v60
end

function v1._beginActivation(v70, v71) -- line 354 | captures: GameplayToolGuard, Player, Ragdoll
    local v72 = Player.Optional.Character(v71)
    if v72 then
        if Ragdoll.IsRagdolled(v72) then
            return nil, "ATTACKER_RAGDOLLED", "The server rejected the swing because the attacker was ragdolled."
        end
        if GameplayToolGuard.CanActivate(v71) then
            v70:_playHitAnimation(v71)
            local v73 = Player.Optional.HumanoidRootPart(v71)
            if not (v73 and v73:IsA("BasePart")) then
                return nil, "ATTACKER_ROOT_UNAVAILABLE", "The server could not resolve the attacker's HumanoidRootPart."
            end
            return v73, "ACTIVATION_ACCEPTED", "The swing passed attacker and gameplay activation guards."
        end
        return nil, "GAMEPLAY_GUARD_REJECTED", "The gameplay tool guard rejected the swing before target validation."
    end
    return nil, "ATTACKER_CHARACTER_UNAVAILABLE", "The server could not resolve the attacker's character."
end

local function _finishMiss(v74) -- line 372
    local Slash = v74._handle:FindFirstChild("Slash")
    if Slash then
        Slash:Play()
    end
    return 0.7
end

v1._finishMiss = _finishMiss

function v1._applyHits(v75, v76, v77) -- line 379 | captures: SentryHitResolver
    if #v77 == 0 then
        return v75:_finishMiss()
    end
    local Hit = v75._handle:FindFirstChild("Hit")
    if Hit then
        Hit:Play()
    end
    SentryHitResolver(v76.Position, v75._range)
    for v78, v79 in ipairs(v77) do
        v75:_applyPlayerHit(v79.target, v79.delta)
    end
    return 0.7
end

local function _activate(v80, v81, v82, v83, v84) -- line 393
    local v85, v86, v87 = v80:_beginActivation(v81)
    if v85 then
        local v88 = v80:_resolveValidTarget(v81, v82, v85, v83)
        local Target = v88.Target
        local Delta = v88.Delta
        if not Target or not Delta then
            local v89 = v80:_finishMiss()
            v80:_logDecisionTrace(v81, v84, v83, v85, v82, v88, v88.Decision, v88.Explanation, "MISS_COOLDOWN_APPLIED")
            return v89
        end
        local v90 = v80:_applyHits(v85, {
            {
                target = Target,
                delta = Delta
            }
        })
        v80:_logDecisionTrace(v81, v84, v83, v85, v82, v88, v88.Decision, v88.Explanation, "HIT_ACTION_DISPATCHED")
        return v90
    end
    v80:_logDecisionTrace(v81, v84, v83, nil, v82, nil, v86, v87, "NO_ACTION")
    return nil
end

v1._activate = _activate

function v1._canProcessRequest(v91, v92) -- line 414 | captures: FromTool, Player, Ragdoll
    local v93 = Player.Optional.Character(v92)
    if v93 then
        if not (v91._tool.Parent == v93 and FromTool(v91._tool) == v92) then
            return false, "REQUEST_TOOL_NOT_EQUIPPED", "The server rejected the request because this Bat was not equipped and owned by the attacker."
        end
        if Ragdoll.IsRagdolled(v93) then
            return false, "REQUEST_ATTACKER_RAGDOLLED", "The server rejected the request because the attacker was ragdolled."
        end
        if v91._processing then
            return false, "REQUEST_ALREADY_PROCESSING", "The previous Bat request is still being processed."
        end
        if workspace:GetServerTimeNow() < v91._cooldownLockedUntil then
            return false, "REQUEST_COOLDOWN_ACTIVE", "The request arrived before the server Bat cooldown ended."
        end
        return true, "REQUEST_ACCEPTED", "The request passed equip, ownership, ragdoll, processing, and cooldown guards."
    end
    return false, "REQUEST_CHARACTER_UNAVAILABLE", "The request arrived without a live attacker character."
end

local function _runActivation(v94, v95, v96) -- line 434
    local v97, v98, v99 = v94:_canProcessRequest(v95)
    if v97 then
        v94._processing = true
        local v100 = v96(v94, v95)
        v94._processing = false
        if v100 then
            v94._cooldownLockedUntil = workspace:GetServerTimeNow() + v100
            v94:_setCooldownAttributes(v100)
        end
        return true, "REQUEST_PROCESSED", "The server completed the Bat activation callback."
    end
    return false, v98, v99
end

v1._runActivation = _runActivation

function v1._handleActivation(v101, v102, v103, v104) -- line 449 | captures: Player, t
    t.strict(t.instanceIsA("Player"))(v102)
    t.strict(t.optional(t.instanceIsA("Player")))(v103)
    t.strict(t.string)(v104)
    local v105 = workspace:GetServerTimeNow()
    local v106, v107, v108 = v101:_runActivation(v102, function(v109, v110) -- line 458 | captures: v103, v104, v105
        return v109:_activate(v110, v103, v105, v104)
    end)
    if not v106 then
        v101:_logDecisionTrace(v102, v104, v105, Player.Optional.HumanoidRootPart(v102), v103, nil, v107, v108, "NO_ACTION")
    end
end

function v1.Destroy(v111) -- line 466 | captures: v2
    v111:_stopIdle()
    v111._trove:Destroy()
    v2:AtDebug():Log("Bat server controller destroyed")
end

function v1._init(v112) -- line 471 | captures: FromTool, Remotes
    local _tool = v112._tool
    _tool:SetAttribute("CooldownEndTime", 0)
    _tool:SetAttribute("CooldownDuration", 0)
    _tool:SetAttribute("CooldownActive", false)
    _tool:SetAttribute("IsBat", true)
    v112._trove:Connect(Remotes.BatSwing.Trigger.OnServerEvent, function(v113, v114, v115) -- line 477 | captures: v112
        v112:_handleActivation(v113, v114, v115)
    end)
    v112._trove:Connect(_tool.Equipped, function() -- line 480 | captures: v112, _tool, FromTool
        local v116 = FromTool(_tool)
        if v116 then
            v112:_playIdle(v116)
        end
    end)
    v112._trove:Connect(_tool.Unequipped, function() -- line 486 | captures: v112
        v112:_stopIdle()
    end)
    v112._trove:Connect(_tool.Destroying, function() -- line 489 | captures: v112
        v112:Destroy()
    end)
end

return v1

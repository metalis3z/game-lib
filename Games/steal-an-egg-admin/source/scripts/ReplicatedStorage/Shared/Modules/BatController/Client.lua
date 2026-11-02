-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(script.Parent.Config)
require(script.Parent.Types.Interface)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Cooldown = require(ReplicatedStorage.Shared.Utils.Cooldown)
require(ReplicatedStorage.Data.Gears)
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local Ragdoll = require(ReplicatedStorage.Shared.Modules.Ragdoll)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local OnRender = require(ReplicatedStorage.Shared.Utils.FrameStepper).OnRender
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

v1.__index = v1
v1.__class = "BatClientController"

local v2 = Config.MaximumTargetViewAge + 0.1
local v3 = Color3.fromRGB(255, 0, 0)
local v4 = Color3.fromRGB(107, 0, 0)
local v5 = Log.new()
local LocalPlayer = Players.LocalPlayer

function v1.new(v6, v8) -- line 30 | captures: Config, Cooldown, Trove, t, v1
    t.strict(t.instanceIsA("Tool"))(v6)
    local v9 = typeof(v8) == "table"
    assert(v9, "Bat controller data must be a table")
    local Duration = v8.Duration
    local v10 = typeof(Duration) == "number"
    assert(v10, "Bat controller duration must be a number")
    local Force = v8.Force
    local v11 = typeof(Force) == "number"
    assert(v11, "Bat controller force must be a number")
    local RangeBonus = v8.RangeBonus
    local v12 = typeof(RangeBonus) == "number"
    assert(v12, "Bat controller range bonus must be a number")
    local v13 = {}
    local v14 = setmetatable(v13, v1)
    v14._tool = v6
    v14._highlightAttackerHistory = {}
    v14._targetRange = Config.Range + Config.HitTolerance + v8.RangeBonus
    v14._targetStates = {}
    v14._isEquipped = false
    v14._traceSequence = 0
    v14._tryActivate = Cooldown(0.6)
    v14._trove = Trove.new()
    v14:_init()
    return v14
end

local function _cancelTween(v15, v16) -- line 53
    local Tween = v16.Tween
    if Tween then
        v16.Tween = nil
        Tween:Cancel()
    end
end

v1._cancelTween = _cancelTween

local function _destroyHighlight(v17, v18) -- line 60
    v17:_cancelTween(v18)
    local Highlight = v18.Highlight
    if Highlight then
        Highlight:Destroy()
    end
    v18.Highlight = nil
    v18.Character = nil
    v18.Visible = false
end

v1._destroyHighlight = _destroyHighlight

function v1._showHighlight(v19, v20, v21) -- line 70 | captures: Tween, v3, v4
    if v20.Character ~= v21 then
        v19:_destroyHighlight(v20)
    end
    if v20.Visible then
        return
    end
    v20.TransitionVersion += 1
    v19:_cancelTween(v20)
    local Highlight = v20.Highlight
    if not Highlight then
        Highlight = Instance.new("Highlight")
        Highlight.Name = "BatTargetHighlight"
        Highlight.Adornee = v21
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
        Highlight.FillColor = v3
        Highlight.OutlineColor = v4
        Highlight.FillTransparency = 1
        Highlight.OutlineTransparency = 1
        Highlight.Parent = v21
        v20.Highlight = Highlight
    end
    v20.Character = v21
    v20.Visible = true
    local v22 = assert(Highlight, "Bat target Highlight must exist before fade-in")
    v20.Tween = Tween(v22, {
        FillTransparency = 0.5,
        OutlineTransparency = 0.15
    }, {
        0.18,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    })
end

local function _hideHighlight(v23, v24) -- line 98
    if v24.Highlight then
        v23:_destroyHighlight(v24)
    end
end

v1._hideHighlight = _hideHighlight

function v1._trackPlayer(v25, v26) -- line 104 | captures: LocalPlayer
    if not (v26 == LocalPlayer or v25._targetStates[v26]) then
        v25._targetStates[v26] = {
            TransitionVersion = 0,
            Visible = false
        }
    end
end

local function _untrackPlayer(v27, v28) -- line 110
    local v29 = v27._targetStates[v28]
    if v29 then
        v27:_destroyHighlight(v29)
        v27._targetStates[v28] = nil
    end
end

v1._untrackPlayer = _untrackPlayer

function v1._isTargetEligible(v30, v31, v32, v33) -- line 118 | captures: Player, Ragdoll, ToolGameplayGuard
    local v34 = Player.Optional.Character(v31)
    local v35 = Player.Optional.HumanoidRootPart(v31)
    local v36 = Player.Optional.Humanoid(v31)
    local Magnitude, v37, v38
    if v34 and v35 and v35:IsA("BasePart") and v36 then
        if v36.Health <= 0 or Ragdoll.IsRagdolled(v34) then
            v38 = true
        elseif ToolGameplayGuard.IsInsideArena(v31) then
            Magnitude = (v35.Position - v32.Position).Magnitude
            v37 = Magnitude <= v33
            v38 = false
        else
            v38 = true
        end
    else
        v38 = true
    end
    if not v38 then
        return v37, Magnitude
    end
    return false, (1/0)
end

function v1._recordHighlightAttackerSample(v39, v40, v41) -- line 129 | captures: v2
    local _highlightAttackerHistory = v39._highlightAttackerHistory
    _highlightAttackerHistory[#_highlightAttackerHistory + 1] = {
        Position = v41,
        Timestamp = v40
    }
    while #_highlightAttackerHistory > 2 do
        local Timestamp = _highlightAttackerHistory[2].Timestamp
        if v40 - v2 <= Timestamp then
            break
        end
        table.remove(_highlightAttackerHistory, 1)
    end
end

local function _getHighlightAttackerPositionAt(v42, v43) -- line 139
    local _highlightAttackerHistory = v42._highlightAttackerHistory
    local v44 = _highlightAttackerHistory[1]
    local v45 = _highlightAttackerHistory[#_highlightAttackerHistory]
    if v44 and v45 and not (v43 < v44.Timestamp) and not (v45.Timestamp < v43) then
        local v46 = #_highlightAttackerHistory
        for v47 = 2, v46 do
            local v48 = _highlightAttackerHistory[v47]
            if v43 <= v48.Timestamp then
                local v49 = _highlightAttackerHistory[v47 - 1]
                local v50 = v48.Timestamp - v49.Timestamp
                if v50 <= 0 then
                    return v48.Position
                end
                local v51 = (v43 - v49.Timestamp) / v50
                local v52 = math.clamp(v51, 0, 1)
                return v49.Position:Lerp(v48.Position, v52)
            end
        end
        return nil
    end
    return nil
end

v1._getHighlightAttackerPositionAt = _getHighlightAttackerPositionAt

function v1._predictServerAcceptsHighlightTarget(v53, v54, v55, v56) -- line 163 | captures: Config, Player, LocalPlayer
    local v57 = v53._targetRange * Config.GetHitboxScalar()
    if v53:_isTargetEligible(v54, v55, v57) then
        local v58 = Player.Optional.HumanoidRootPart(v54)
        if v58 and v58:IsA("BasePart") then
            local v59 = LocalPlayer:GetNetworkPing()
            local v60 = 0.14 + v59
            local MaximumTargetViewAge = Config.MaximumTargetViewAge
            local v61 = v53:_getHighlightAttackerPositionAt(v56 - math.clamp(v60, 0.14, MaximumTargetViewAge))
            if v61 then
                local v62 = v59 + Config.TargetViewSamplePadding
                local TargetViewSamplePadding = Config.TargetViewSamplePadding
                local MaximumTargetViewAge = Config.MaximumTargetViewAge
                local v63 = math.clamp(v62, TargetViewSamplePadding, MaximumTargetViewAge)
                local Position = v58.Position
                local v64 = Position + v58.AssemblyLinearVelocity * v63
                if v57 < (Position - v61).Magnitude then
                    return (v64 - v61).Magnitude <= v57
                end
                return true
            end
        end
    end
    return false
end

function v1._updateHighlights(v65) -- line 183 | captures: Player, Ragdoll, LocalPlayer
    local v66 = Player.Optional.Character(LocalPlayer)
    local v67 = Player.Optional.HumanoidRootPart(LocalPlayer)
    local _isEquipped = v65._isEquipped
    if _isEquipped then
        if v66 == nil or v67 == nil then
            _isEquipped = false
        else
            _isEquipped = v67:IsA("BasePart") and not Ragdoll.IsRagdolled(v66)
        end
    end
    local v68
    if _isEquipped then
        local v69 = workspace:GetServerTimeNow()
        v65:_recordHighlightAttackerSample(v69, v67.Position)
        v68 = v65:_selectClosestTarget()
        if not (v68 and v65:_predictServerAcceptsHighlightTarget(v68, v67, v69)) then
            v68 = nil
        end
    else
        table.clear(v65._highlightAttackerHistory)
    end
    for v70, v71 in v65._targetStates do
        local v72
        if v70 == v68 then
            v72 = Player.Optional.Character(v70)
        end
        if v72 then
            v7:_showHighlight(v71, v72)
        else
            v7:_hideHighlight(v71)
        end
    end
end

function v1._selectClosestTarget(v73) -- line 227 | captures: Config, Player, Ragdoll, LocalPlayer
    local v74 = Player.Optional.Character(LocalPlayer)
    local v75 = Player.Optional.HumanoidRootPart(LocalPlayer)
    if v74 and v75 and v75:IsA("BasePart") and not Ragdoll.IsRagdolled(v74) then
        local v76
        local v77 = (1/0)
        for v78 in v73._targetStates do
            local v79, v80 = v73:_isTargetEligible(v78, v75, v73._targetRange * Config.GetHitboxScalar())
            if v79 and v80 < v77 then
                v76 = v78
                v77 = v80
            end
        end
        return v76
    end
    return nil
end

function v1._logActivationTrace(v81, v82, v83, v84) -- line 248 | captures: Config, Constants, Player, v5, LocalPlayer
    if not Constants.IS_STUDIO then
        return
    end
    local v85 = Player.Optional.Humanoid(LocalPlayer)
    local v86
    if v83 then
        v86 = Player.Optional.HumanoidRootPart(v83)
    end
    if not (v86 and v86:IsA("BasePart")) then
        v86 = nil
    end
    local v87
    if v86 then
        v87 = v86.AssemblyLinearVelocity
    else
        v87 = Vector3.new(0, 0, 0)
    end
    local AssemblyLinearVelocity = v84.AssemblyLinearVelocity
    local v88 = if v86 then (v86.Position - v84.Position).Magnitude else -1
    local v89
    if v83 == nil then
        v89 = "CLIENT_NO_TARGET: your PC did not nominate an eligible player inside ClientSelectionRange at the swing moment."
    elseif v86 == nil then
        v89 = "CLIENT_TARGET_ROOT_MISSING: the nominated player's rendered root disappeared before the swing was sent."
    else
        v89 = "CLIENT_TARGET_NOMINATED: this is the player and distance your PC rendered at the swing moment."
    end
    local v90 = v5:AtInfo()
    local v91 = {
        Stage = "CLIENT_SWING",
        TraceId = v82,
        Interpretation = v89,
        ClientServerTime = workspace:GetServerTimeNow(),
        AttackerName = LocalPlayer.Name,
        AttackerUserId = LocalPlayer.UserId
    }
    if v83 then
        v91.TargetName = v83.Name
        v91.TargetUserId = v83.UserId
    else
        v91.TargetName = "None"
        v91.TargetUserId = 0
    end
    v91.TargetNominated = v83 ~= nil
    v91.ClientSelectionRange = v81._targetRange * Config.GetHitboxScalar()
    v91.ClientVisibleDistance = v88
    v91.AttackerPosition = v84.Position
    if v86 then
        v91.TargetPosition = v86.Position
    else
        v91.TargetPosition = Vector3.new(0, 0, 0)
    end
    if v85 then
        v91.AttackerWalkSpeed = v85.WalkSpeed
    else
        v91.AttackerWalkSpeed = -1
    end
    local X = AssemblyLinearVelocity.X
    local Z = AssemblyLinearVelocity.Z
    v91.AttackerHorizontalSpeed = Vector3.new(X, 0, Z).Magnitude
    local X_2 = v87.X
    local Z_2 = v87.Z
    v91.TargetHorizontalSpeed = Vector3.new(X_2, 0, Z_2).Magnitude
    if v86 == nil then
        v91.TargetAppearsStationary = false
    else
        local X = v87.X
        local Z = v87.Z
        v91.TargetAppearsStationary = Vector3.new(X, 0, Z).Magnitude <= 1
    end
    v90:Log("Bat hit validation trace", v91)
end

function v1._logLocalRejection(v92, v93, v94, v95) -- line 326 | captures: Constants, Player, v5, LocalPlayer
    if not Constants.IS_STUDIO then
        return
    end
    local v96 = Player.Optional.HumanoidRootPart(LocalPlayer)
    local v97 = Player.Optional.Humanoid(LocalPlayer)
    local v98
    if v96 then
        if v96:IsA("BasePart") then
            v98 = v96.AssemblyLinearVelocity
        end
    else
        v98 = Vector3.new(0, 0, 0)
    end
    local v99 = v5:AtInfo()
    local v100 = {
        Stage = "CLIENT_LOCAL_REJECTED",
        ClientCooldownSeconds = 0.6,
        TraceId = v93,
        Decision = v94,
        Explanation = v95,
        ClientServerTime = workspace:GetServerTimeNow(),
        AttackerName = LocalPlayer.Name,
        AttackerUserId = LocalPlayer.UserId
    }
    if v96 and v96:IsA("BasePart") then
        v100.AttackerPosition = v96.Position
    else
        v100.AttackerPosition = Vector3.new(0, 0, 0)
    end
    if v97 then
        v100.AttackerWalkSpeed = v97.WalkSpeed
    else
        v100.AttackerWalkSpeed = -1
    end
    local X = v98.X
    local Z = v98.Z
    v100.AttackerHorizontalSpeed = Vector3.new(X, 0, Z).Magnitude
    v99:Log("Bat hit validation trace", v100)
end

function v1._onActivated(v101) -- line 366 | captures: Player, Ragdoll, Remotes, ToolGameplayGuard, LocalPlayer
    v101._traceSequence += 1
    local UserId = LocalPlayer.UserId
    local _traceSequence = v101._traceSequence
    local v102 = workspace:GetServerTimeNow() * 1000
    local v103 = ("%*:%*:%*"):format(UserId, _traceSequence, (math.floor(v102)))
    if v101._isEquipped then
        if ToolGameplayGuard.AllowsLocalUse(v101._tool) then
            if not v101._tryActivate(function() -- line 378 | captures: v101, v103, Player, Ragdoll, Remotes, LocalPlayer
                    local v104 = Player.Optional.Character(LocalPlayer)
                    local v105 = Player.Optional.HumanoidRootPart(LocalPlayer)
                    if v104 and v105 and v105:IsA("BasePart") then
                        if Ragdoll.IsRagdolled(v104) then
                            v101:_logLocalRejection(v103, "CLIENT_CHARACTER_STATE_REJECTED", "The client had no usable character/root or was ragdolled when the debounced swing executed.")
                        else
                            local v106 = v101:_selectClosestTarget()
                            v101:_logActivationTrace(v103, v106, v105)
                            Remotes.BatSwing.Trigger:FireServer(v106, v103)
                        end
                    else
                        v101:_logLocalRejection(v103, "CLIENT_CHARACTER_STATE_REJECTED", "The client had no usable character/root or was ragdolled when the debounced swing executed.")
                    end
                end) then
                v101:_logLocalRejection(v103, "CLIENT_COOLDOWN_ACTIVE", "The client Bat cooldown rejected this click, so no server request was sent.")
            end
        else
            v101:_logLocalRejection(v103, "CLIENT_GAMEPLAY_GUARD_REJECTED", "The local gameplay-area guard rejected the swing before any server request was sent.")
        end
    else
        v101:_logLocalRejection(v103, "CLIENT_TOOL_NOT_EQUIPPED", "The Bat Activated signal fired while this client controller did not consider the tool equipped.")
    end
end

local function _onEquipped(v107) -- line 404
    v107._isEquipped = true
end

v1._onEquipped = _onEquipped

function v1.Destroy(v108) -- line 407 | captures: v5
    v108._trove:Destroy()
    for v109 in v108._targetStates do
        v108:_untrackPlayer(v109)
    end
    v5:AtDebug():Log("Bat client controller destroyed")
end

function v1._init(v110) -- line 417 | captures: Players, Constants, Player, OnRender, LocalPlayer
    for v111, v112 in ipairs(Players:GetPlayers()) do
        local defer = task.defer
        local v113 = v112
        defer(function() -- line 419 | captures: v110, v113
            v110:_trackPlayer(v113)
        end)
    end
    v110._trove:Connect(Players.PlayerAdded, function(v114) -- line 423 | captures: v110
        v110:_trackPlayer(v114)
    end)
    v110._trove:Connect(Players.PlayerRemoving, function(v115) -- line 426 | captures: v110
        v110:_untrackPlayer(v115)
    end)
    v110._trove:Connect(v110._tool.Equipped, function() -- line 429 | captures: v110
        v110:_onEquipped()
    end)
    v110._trove:Connect(v110._tool.Unequipped, function() -- line 432 | captures: v110
        v110._isEquipped = false
        v110:_updateHighlights()
    end)
    v110._trove:Connect(v110._tool.Activated, function() -- line 436 | captures: v110
        v110:_onActivated()
    end)
    if Constants.IS_MOBILE then
        local v116 = OnRender(function() -- line 440 | captures: v110
            v110:_updateHighlights()
            return false
        end)
        v110._trove:Add(function() -- line 444 | captures: v116
            v116:Destroy()
        end)
    end
    v110._trove:Connect(v110._tool.Destroying, function() -- line 448 | captures: v110
        v110:Destroy()
    end)
    local v117 = Player.Optional.Character(LocalPlayer)
    if v117 and v110._tool.Parent == v117 then
        v110:_onEquipped()
    end
end

return v1

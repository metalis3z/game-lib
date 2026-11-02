-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Config = require(script.Parent.Config)

require(script.Parent.Types.Interface)

local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Debounce = require(ReplicatedStorage.Library.Functions.Debounce)
local Interface = require(ReplicatedStorage.Directory.Gears.Types.Interface)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Player = require(ReplicatedStorage.Library.Player)
local Ragdoll = require(ReplicatedStorage.Library.Modules.Ragdoll)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local ToolGameplayGuard = require(ReplicatedStorage.Library.Client.ToolGameplayGuard)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local t = {}

t.__index = t
t.__class = "BatClientController"

local v1 = Config.MaximumTargetViewAge + 0.1
local v2 = Color3.fromRGB(255, 0, 0)
local v3 = Color3.fromRGB(107, 0, 0)
local Bat = Constants.NETWORK_MAP.Bat
local v4 = Log.new()
local LocalPlayer = Players.LocalPlayer

function t.new(p1, p2) --[[ new | Line: 62 | Upvalues: Asserts (copy), Interface (copy), t (copy), Config (copy), Debounce (copy), Trove (copy) ]]
	Asserts.Tool(p1)

	local v1, v2 = Interface.BatControllerData(p2)

	assert(v1, v2)

	local v4 = setmetatable({}, t)

	v4._tool = p1
	v4._highlightAttackerHistory = {}
	v4._targetRange = Config.Range + Config.HitTolerance + p2.RangeBonus
	v4._targetStates = {}
	v4._isEquipped = false
	v4._traceSequence = 0
	v4._tryActivate = Debounce()
	v4._trove = Trove.new()
	v4:_init()

	return v4
end
function t._cancelTween(p1, p2) --[[ _cancelTween | Line: 84 ]]
	local Tween = p2.Tween

	if not Tween then
		return
	end

	p2.Tween = nil
	Tween:Cancel()
end
function t._destroyHighlight(p1, p2) --[[ _destroyHighlight | Line: 92 ]]
	p1:_cancelTween(p2)

	local Highlight = p2.Highlight

	if not Highlight then
		p2.Highlight = nil
		p2.Character = nil
		p2.Visible = false

		return
	end

	Highlight:Destroy()
	p2.Highlight = nil
	p2.Character = nil
	p2.Visible = false
end
function t._showHighlight(p1, p2, p3) --[[ _showHighlight | Line: 103 | Upvalues: v2 (copy), v3 (copy), Tween (copy) ]]
	if p2.Character ~= p3 then
		p1:_destroyHighlight(p2)
	end

	if p2.Visible then
		return
	end

	p2.TransitionVersion = p2.TransitionVersion + 1
	p1:_cancelTween(p2)

	local Highlight = p2.Highlight

	if not Highlight then
		local BatTargetHighlight = Instance.new("Highlight")

		BatTargetHighlight.Name = "BatTargetHighlight"
		BatTargetHighlight.Adornee = p3
		BatTargetHighlight.DepthMode = Enum.HighlightDepthMode.Occluded
		BatTargetHighlight.FillColor = v2
		BatTargetHighlight.OutlineColor = v3
		BatTargetHighlight.FillTransparency = 1
		BatTargetHighlight.OutlineTransparency = 1
		BatTargetHighlight.Parent = p3
		p2.Highlight = BatTargetHighlight
		Highlight = BatTargetHighlight
	end

	p2.Character = p3
	p2.Visible = true
	p2.Tween = Tween(assert(Highlight, "Bat target Highlight must exist before fade-in"), {
		FillTransparency = 0.5,
		OutlineTransparency = 0.15
	}, { 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })
end
function t._hideHighlight(p1, p2) --[[ _hideHighlight | Line: 141 ]]
	if p2.Highlight then
		p1:_destroyHighlight(p2)
	end
end
function t._trackPlayer(p1, p2) --[[ _trackPlayer | Line: 149 | Upvalues: LocalPlayer (copy) ]]
	if p2 ~= LocalPlayer and not p1._targetStates[p2] then
		p1._targetStates[p2] = {
			Character = nil,
			Highlight = nil,
			Tween = nil,
			TransitionVersion = 0,
			Visible = false
		}
	end
end
function t._untrackPlayer(p1, p2) --[[ _untrackPlayer | Line: 163 ]]
	local v1 = p1._targetStates[p2]

	if v1 then
		p1:_destroyHighlight(v1)
		p1._targetStates[p2] = nil
	end
end
function t._isTargetEligible(p1, p2, p3, p4) --[[ _isTargetEligible | Line: 173 | Upvalues: Player (copy), Ragdoll (copy) ]]
	local v1 = Player.Optional.Character(p2)
	local v2 = Player.Optional.HumanoidRootPart(p2)
	local v3 = Player.Optional.Humanoid(p2)

	if not v1 or (not v2 or (not v2:IsA("BasePart") or (not v3 or v3.Health <= 0))) then
		return false, (1 / 0)
	end

	if Ragdoll.IsRagdolled(v1) then
		return false, (1 / 0)
	end

	local Magnitude = (v2.Position - p3.Position).Magnitude

	return Magnitude <= p4, Magnitude
end
function t._recordHighlightAttackerSample(p1, p2, p3) --[[ _recordHighlightAttackerSample | Line: 193 | Upvalues: v1 (copy) ]]
	local _highlightAttackerHistory = p1._highlightAttackerHistory

	_highlightAttackerHistory[#_highlightAttackerHistory + 1] = {
		Position = p3,
		Timestamp = p2
	}

	while #_highlightAttackerHistory > 2 and _highlightAttackerHistory[2].Timestamp < p2 - v1 do
		table.remove(_highlightAttackerHistory, 1)
	end
end
function t._getHighlightAttackerPositionAt(p1, p2) --[[ _getHighlightAttackerPositionAt | Line: 210 ]]
	local _highlightAttackerHistory = p1._highlightAttackerHistory
	local v1 = _highlightAttackerHistory[1]
	local v2 = _highlightAttackerHistory[#_highlightAttackerHistory]

	if not v1 or (not v2 or (p2 < v1.Timestamp or v2.Timestamp < p2)) then
		return nil
	end

	for i = 2, #_highlightAttackerHistory do
		local v3 = _highlightAttackerHistory[i]

		if p2 <= v3.Timestamp then
			local v4 = _highlightAttackerHistory[i - 1]
			local v5 = v3.Timestamp - v4.Timestamp

			if v5 <= 0 then
				return v3.Position
			end

			return v4.Position:Lerp(v3.Position, (math.clamp((p2 - v4.Timestamp) / v5, 0, 1)))
		end
	end

	return nil
end
function t._predictServerAcceptsHighlightTarget(p1, p2, p3, p4) --[[ _predictServerAcceptsHighlightTarget | Line: 235 | Upvalues: Player (copy), LocalPlayer (copy), Config (copy) ]]
	if not p1:_isTargetEligible(p2, p3, p1._targetRange) then
		return false
	end

	local v1 = Player.Optional.HumanoidRootPart(p2)

	if not (v1 and v1:IsA("BasePart")) then
		return false
	end

	local v2 = LocalPlayer:GetNetworkPing()
	local v3 = p1:_getHighlightAttackerPositionAt(p4 - math.clamp(0.14 + v2, 0.14, Config.MaximumTargetViewAge))

	if not v3 then
		return false
	end

	local v5 = math.clamp(v2 + Config.TargetViewSamplePadding, Config.TargetViewSamplePadding, Config.MaximumTargetViewAge)
	local Position = v1.Position

	return if (Position - v3).Magnitude <= p1._targetRange then true else (Position + v1.AssemblyLinearVelocity * v5 - v3).Magnitude <= p1._targetRange
end
function t._updateHighlights(p1) --[[ _updateHighlights | Line: 276 | Upvalues: Player (copy), LocalPlayer (copy), Ragdoll (copy) ]]
	local v1 = Player.Optional.Character(LocalPlayer)
	local v2 = Player.Optional.HumanoidRootPart(LocalPlayer)
	local v4 = nil

	if p1._isEquipped and (if v1 == nil or v2 == nil then false else v2:IsA("BasePart") and not Ragdoll.IsRagdolled(v1)) then
		local v5 = workspace:GetServerTimeNow()

		p1:_recordHighlightAttackerSample(v5, v2.Position)

		local v6 = p1:_selectClosestTarget()

		if v6 and p1:_predictServerAcceptsHighlightTarget(v6, v2, v5) then
			v4 = v6
		end
	else
		table.clear(p1._highlightAttackerHistory)
	end

	for v7, v8 in p1._targetStates do
		local v9 = if v7 == v4 then Player.Optional.Character(v7) else nil

		if v9 then
			p1:_showHighlight(v8, v9)

			continue
		end

		p1:_hideHighlight(v8)
	end
end
function t._selectClosestTarget(p1) --[[ _selectClosestTarget | Line: 308 | Upvalues: Player (copy), LocalPlayer (copy), Ragdoll (copy) ]]
	local v1 = Player.Optional.Character(LocalPlayer)
	local v2 = Player.Optional.HumanoidRootPart(LocalPlayer)

	if not v1 or (not v2 or (not v2:IsA("BasePart") or Ragdoll.IsRagdolled(v1))) then
		return nil
	end

	local v3 = (1 / 0)
	local v4 = nil

	for v5 in p1._targetStates do
		local v6, v7 = p1:_isTargetEligible(v5, v2, p1._targetRange)

		if v6 and v7 < v3 then
			v3 = v7
			v4 = v5
		end
	end

	return v4
end
function t._logActivationTrace(p1, p2, p3, p4) --[[ _logActivationTrace | Line: 327 | Upvalues: Constants (copy), Player (copy), LocalPlayer (copy), v4 (copy) ]]
	if not Constants.IS_STUDIO then
		return
	end

	local v1 = Player.Optional.Humanoid(LocalPlayer)
	local v2 = if p3 then Player.Optional.HumanoidRootPart(p3) else nil
	local v3 = if v2 and v2:IsA("BasePart") then v2 else nil
	local v42 = if v3 then v3.AssemblyLinearVelocity else Vector3.new(0, 0, 0)
	local AssemblyLinearVelocity = p4.AssemblyLinearVelocity
	local v5 = if v3 then (v3.Position - p4.Position).Magnitude else -1
	local v7 = v4:AtInfo()
	local t = {
		Stage = "CLIENT_SWING",
		TraceId = p2,
		Interpretation = if p3 == nil then "CLIENT_NO_TARGET: your PC did not nominate an eligible player inside ClientSelectionRange at the swing moment." elseif v3 == nil then "CLIENT_TARGET_ROOT_MISSING: the nominated player\'s rendered root disappeared before the swing was sent." else "CLIENT_TARGET_NOMINATED: this is the player and distance your PC rendered at the swing moment.",
		ClientServerTime = workspace:GetServerTimeNow(),
		AttackerName = LocalPlayer.Name,
		AttackerUserId = LocalPlayer.UserId
	}

	t.TargetName = if p3 then p3.Name else "None"
	t.TargetUserId = if p3 then p3.UserId else 0
	t.TargetNominated = if p3 == nil then false else true
	t.ClientSelectionRange = p1._targetRange
	t.ClientVisibleDistance = v5
	t.AttackerPosition = p4.Position
	t.TargetPosition = if v3 then v3.Position else Vector3.new(0, 0, 0)
	t.AttackerWalkSpeed = if v1 then v1.WalkSpeed else -1
	t.AttackerHorizontalSpeed = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude
	t.TargetHorizontalSpeed = Vector3.new(v42.X, 0, v42.Z).Magnitude
	t.TargetAppearsStationary = if v3 == nil then false else Vector3.new(v42.X, 0, v42.Z).Magnitude <= 1
	v7:Log("Bat hit validation trace", t)
end
function t._logLocalRejection(p1, p2, p3, p4) --[[ _logLocalRejection | Line: 372 | Upvalues: Constants (copy), Player (copy), LocalPlayer (copy), v4 (copy) ]]
	if not Constants.IS_STUDIO then
		return
	end

	local v1 = Player.Optional.HumanoidRootPart(LocalPlayer)
	local v2 = Player.Optional.Humanoid(LocalPlayer)
	local v3 = if v1 and v1:IsA("BasePart") then v1.AssemblyLinearVelocity else Vector3.new(0, 0, 0)
	local v42 = v4:AtInfo()
	local t = {
		Stage = "CLIENT_LOCAL_REJECTED",
		ClientCooldownSeconds = 0.6,
		TraceId = p2,
		Decision = p3,
		Explanation = p4,
		ClientServerTime = workspace:GetServerTimeNow(),
		AttackerName = LocalPlayer.Name,
		AttackerUserId = LocalPlayer.UserId
	}

	t.AttackerPosition = if v1 and v1:IsA("BasePart") then v1.Position else Vector3.new(0, 0, 0)
	t.AttackerWalkSpeed = if v2 then v2.WalkSpeed else -1
	t.AttackerHorizontalSpeed = Vector3.new(v3.X, 0, v3.Z).Magnitude
	v42:Log("Bat hit validation trace", t)
end
function t._onActivated(p1) --[[ _onActivated | Line: 400 | Upvalues: LocalPlayer (copy), ToolGameplayGuard (copy), Player (copy), Ragdoll (copy), Network (copy), Bat (copy) ]]
	p1._traceSequence = p1._traceSequence + 1

	local UserId = LocalPlayer.UserId
	local v2 = ("%*:%*:%*"):format(UserId, p1._traceSequence, (math.floor(workspace:GetServerTimeNow() * 1000)))

	if not p1._isEquipped then
		p1:_logLocalRejection(v2, "CLIENT_TOOL_NOT_EQUIPPED", "The Bat Activated signal fired while this client controller did not consider the tool equipped.")

		return
	end

	if not ToolGameplayGuard.CanActivateLocal(p1._tool) then
		p1:_logLocalRejection(v2, "CLIENT_GAMEPLAY_GUARD_REJECTED", "The local gameplay-area guard rejected the swing before any server request was sent.")

		return
	end

	if p1._tryActivate(0.6, function() --[[ Line: 420 | Upvalues: Player (ref), LocalPlayer (ref), Ragdoll (ref), p1 (copy), v2 (copy), Network (ref), Bat (ref) ]]
		local v1 = Player.Optional.Character(LocalPlayer)
		local v22 = Player.Optional.HumanoidRootPart(LocalPlayer)

		if v1 and (v22 and (v22:IsA("BasePart") and not Ragdoll.IsRagdolled(v1))) then
			local v3 = p1:_selectClosestTarget()

			p1:_logActivationTrace(v2, v3, v22)
			Network.Fire(Bat.ACTIVATE, v3, v2)
		else
			p1:_logLocalRejection(v2, "CLIENT_CHARACTER_STATE_REJECTED", "The client had no usable character/root or was ragdolled when the debounced swing executed.")
		end
	end) then
		return
	end

	p1:_logLocalRejection(v2, "CLIENT_COOLDOWN_ACTIVE", "The client Bat cooldown rejected this click, so no server request was sent.")
end
function t._onEquipped(p1) --[[ _onEquipped | Line: 445 ]]
	p1._isEquipped = true
end
function t.Destroy(p1) --[[ Destroy | Line: 453 | Upvalues: v4 (copy) ]]
	p1._trove:Destroy()

	for v1 in p1._targetStates do
		p1:_untrackPlayer(v1)
	end

	v4:AtDebug():Log("Bat client controller destroyed")
end
function t._init(p1) --[[ _init | Line: 465 | Upvalues: Players (copy), Constants (copy), RenderStepped (copy), Player (copy), LocalPlayer (copy) ]]
	for i, v in ipairs(Players:GetPlayers()) do
		task.defer(function() --[[ Line: 467 | Upvalues: p1 (copy), v (copy) ]]
			p1:_trackPlayer(v)
		end)
	end

	p1._trove:Connect(Players.PlayerAdded, function(p12) --[[ Line: 472 | Upvalues: p1 (copy) ]]
		p1:_trackPlayer(p12)
	end)
	p1._trove:Connect(Players.PlayerRemoving, function(p12) --[[ Line: 475 | Upvalues: p1 (copy) ]]
		p1:_untrackPlayer(p12)
	end)
	p1._trove:Connect(p1._tool.Equipped, function() --[[ Line: 478 | Upvalues: p1 (copy) ]]
		p1:_onEquipped()
	end)
	p1._trove:Connect(p1._tool.Unequipped, function() --[[ Line: 481 | Upvalues: p1 (copy) ]]
		p1._isEquipped = false
		p1:_updateHighlights()
	end)
	p1._trove:Connect(p1._tool.Activated, function() --[[ Line: 485 | Upvalues: p1 (copy) ]]
		p1:_onActivated()
	end)

	if Constants.IS_MOBILE then
		local v1 = RenderStepped(function() --[[ Line: 489 | Upvalues: p1 (copy) ]]
			p1:_updateHighlights()

			return false
		end)

		p1._trove:Add(function() --[[ Line: 493 | Upvalues: v1 (copy) ]]
			v1:Destroy()
		end)
	end

	p1._trove:Connect(p1._tool.Destroying, function() --[[ Line: 497 | Upvalues: p1 (copy) ]]
		p1:Destroy()
	end)

	local v2 = Player.Optional.Character(LocalPlayer)

	if not v2 or p1._tool.Parent ~= v2 then
		return
	end

	p1:_onEquipped()
end

return t
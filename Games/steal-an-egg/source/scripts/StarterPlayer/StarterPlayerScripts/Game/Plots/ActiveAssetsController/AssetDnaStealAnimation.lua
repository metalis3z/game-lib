-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActiveAssets = require(ReplicatedStorage.Library.Types.ActiveAssets)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)
local Bezier = require(ReplicatedStorage.Library.Functions.Bezier)
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local EggRenderer = require(ReplicatedStorage.Library.Client.Eggs.EggRenderer)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Player = require(ReplicatedStorage.Library.Player)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local Transparency = require(ReplicatedStorage.Library.Functions.Transparency)
local AssetMovementBatch = require(script.Parent.AssetMovementBatch)
local EggCapturePresentation = require(ReplicatedStorage.Library.Client.Eggs.EggCapturePresentation)
local Config = require(script.Config)
local EggThrowLand = require(script.EggThrowLand)
local OrbAbsorption = require(script.OrbAbsorption)
local t = {}

t.__index = t
t.__class = "AssetDnaStealAnimation"

local ActiveAssets2 = Network.NET_MAP.ActiveAssets
local v1 = Log.new()
local __DEBRIS = workspace.__DEBRIS

assert(__DEBRIS:IsA("Folder"), "Workspace.__DEBRIS must be a Folder")
function t.new(p1, p2, p3, p4) --[[ new | Line: 61 | Upvalues: Asserts (copy), ActiveAssets (copy), t (copy) ]]
	Asserts.Model(p2)
	assert(ActiveAssets.DnaStealAnimationPayload(p3), "Invalid DNA steal animation payload")

	local v3 = setmetatable({}, t)

	v3._movementBatch = p1
	v3._sourceModel = p2
	v3._payload = p3
	v3._setFrozen = p4
	v3._destroyed = false
	v3._presentationFrozen = false
	v3._eggModel = nil
	v3._sourceHighlight = nil
	v3._eggHighlight = nil
	v3._sourceClone = nil
	v3._sourceShake = nil
	v3._sourceShakeFadeStartedAt = nil
	v3._eggCaptureActive = false
	task.spawn(function() --[[ Line: 83 | Upvalues: v3 (copy) ]]
		v3:_play()
	end)

	return v3
end

local function autoControlPoint(p1, p2) --[[ autoControlPoint | Line: 93 ]]
	local v1 = (p1 + p2) * 0.5

	return Vector3.new(v1.X, math.max(p1.Y, p2.Y) + ((p1 - p2) * Vector3.new(1, 0, 1)).Magnitude * 0.5, v1.Z)
end

function t._createHighlight(p1, p2, p3) --[[ _createHighlight | Line: 99 | Upvalues: Config (copy) ]]
	local Highlight = Instance.new("Highlight")

	Highlight.Name = p2
	Highlight.Adornee = p3
	Highlight.FillColor = Config.HighlightDark
	Highlight.FillTransparency = Config.HighlightFillTransparency
	Highlight.OutlineTransparency = 1
	Highlight.Parent = p3

	return Highlight
end

local function anchorClone(p1) --[[ anchorClone | Line: 110 ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			v2.Anchored = true
			v2.CanCollide = false
			v2.CanQuery = false
			v2.CanTouch = false

			continue
		end

		if v2:IsA("ProximityPrompt") or (v2:IsA("BillboardGui") or v2:IsA("SurfaceGui")) then
			v2:Destroy()

			continue
		end

		if v2:IsA("Sound") then
			v2:Stop()
		end
	end
end

local function getBodyCFrame() --[[ getBodyCFrame | Line: 125 | Upvalues: Player (copy), Players (copy) ]]
	return Player.PrimaryPart(Players.LocalPlayer):GetPivot()
end

local function getHighlightColor(p1) --[[ getHighlightColor | Line: 129 | Upvalues: Config (copy) ]]
	return Config.HighlightDark:Lerp(Config.HighlightNearWhite, (math.sin(p1 * math.pi * 2 * Config.HighlightPulseHz) + 1) * 0.5)
end

function t._isActive(p1) --[[ _isActive | Line: 134 ]]
	return not p1._destroyed and p1._sourceModel.Parent ~= nil
end
function t._setPresentationFrozen(p1, p2) --[[ _setPresentationFrozen | Line: 138 ]]
	if p1._presentationFrozen ~= p2 then
		p1._presentationFrozen = p2
		p1._setFrozen(p2)
	end
end
function t._shakeSource(p1) --[[ _shakeSource | Line: 146 | Upvalues: RenderStepped (copy), Config (copy), Easing (copy) ]]
	local v1 = p1:_createHighlight("DnaStealSourceHighlight", p1._sourceModel)

	p1._sourceHighlight = v1
	p1:_setPresentationFrozen(true)
	p1._sourceShake = RenderStepped(function(p12, p2) --[[ Line: 151 | Upvalues: p1 (copy), Config (ref), Easing (ref), v1 (copy) ]]
		if not p1:_isActive() then
			return true
		end

		local _sourceShakeFadeStartedAt = p1._sourceShakeFadeStartedAt
		local v12 = if _sourceShakeFadeStartedAt == nil then 1 else 1 - Easing(math.clamp((os.clock() - _sourceShakeFadeStartedAt) / Config.ShakeFadeSeconds, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		p1._movementBatch:SetPresentationOffset(p1._sourceModel, CFrame.new((Vector3.new(math.sin(p2 * math.pi * 2 * Config.PetShakeXHz) * Config.PetShakeStuds * v12, 0, math.cos(p2 * math.pi * 2 * Config.PetShakeZHz) * Config.PetShakeStuds * v12))))
		v1.FillColor = Config.HighlightDark:Lerp(Config.HighlightNearWhite, (math.sin(p2 * math.pi * 2 * Config.HighlightPulseHz) + 1) * 0.5)

		return nil
	end)
	task.wait(Config.PetShakeSeconds)
end
function t._prepareSourceClone(p1) --[[ _prepareSourceClone | Line: 173 | Upvalues: anchorClone (copy) ]]
	local v1 = p1._sourceModel:Clone()

	anchorClone(v1)
	p1._sourceClone = v1
end
function t._beginEggCapture(p1, p2) --[[ _beginEggCapture | Line: 179 | Upvalues: EggCapturePresentation (copy), Config (copy) ]]
	p1._eggHighlight = p1:_createHighlight("DnaStealEggHighlight", p2)
	EggCapturePresentation.BeginEgg(p2, Config.HighlightDark)
	p1._eggCaptureActive = true
end
function t._renderEgg(p1) --[[ _renderEgg | Line: 186 | Upvalues: EggRenderer (copy), Players (copy), __DEBRIS (copy), Asserts (copy), BBFromModelVisibleOnly (copy) ]]
	local _payload = p1._payload
	local Model = EggRenderer.RenderVisual({
		OwnerUserId = Players.LocalPlayer.UserId,
		UID = _payload.EggUID,
		ModelName = ("%*_%*"):format(Players.LocalPlayer.UserId, _payload.EggUID),
		Record = _payload.EggRecord
	}, __DEBRIS).Model
	local v1 = Model:GetScale()
	local v2 = EggRenderer.GetAuthoredScale(_payload.EggRecord)

	Model:ScaleTo(v2)

	local PrimaryPart = Model.PrimaryPart

	Asserts.BasePart(PrimaryPart)
	PrimaryPart.PivotOffset = CFrame.new(0, -PrimaryPart.Size.Y * 0.5, 0)

	local v3 = BBFromModelVisibleOnly(p1._sourceModel)

	Model:PivotTo(CFrame.new(v3.Position) * p1._sourceModel:GetPivot().Rotation)

	local v4 = BBFromModelVisibleOnly(Model)

	Model:PivotTo(Model:GetPivot() + (v3.Position - v4.Position))
	p1._eggModel = Model

	return Model, v2, v1
end
function t._landingCFrame(p1, p2) --[[ _landingCFrame | Line: 210 | Upvalues: BBFromModelVisibleOnly (copy), Player (copy), Players (copy), Config (copy), AssetMovementBatch (copy) ]]
	local Position = BBFromModelVisibleOnly(p1._sourceModel).Position
	local v1 = Player.PrimaryPart(Players.LocalPlayer):GetPivot()
	local Position2 = v1.Position
	local v4 = Vector3.new(Position2.X - Position.X, 0, Position2.Z - Position.Z)
	local v5

	if v4.Magnitude > 0.001 then
		v5 = v4.Unit
	else
		local v6 = v1.LookVector * Vector3.new(1, 0, 1)

		if v6.Magnitude <= 0.001 then
			v6 = v1.RightVector * Vector3.new(1, 0, 1)
		end

		assert(if v6.Magnitude > 0.001 then true else false, "Player body must provide a horizontal landing direction")
		v5 = v6.Unit
	end

	local v8 = Position + v5 * (v4.Magnitude + Config.LandingBeyondPlayerStuds)

	return AssetMovementBatch.ResolveGroundedCFrame(p2, (CFrame.lookAt(v8, v8 - v5)))
end
function t._absorb(p1, p2, p3, p4) --[[ _absorb | Line: 231 | Upvalues: EggCapturePresentation (copy), Config (copy), __DEBRIS (copy), RenderStepped (copy), Easing (copy), OrbAbsorption (copy) ]]
	local v1 = assert(p1._sourceClone, "Clean source clone must be prepared before animation presentation")

	EggCapturePresentation.ApplySourceClone(v1, Config.OrbColor)
	v1.Parent = __DEBRIS

	local v2 = assert(p1._eggHighlight, "Egg capture highlight must exist before the throw begins")

	assert(p1._eggCaptureActive, "Egg capture presentation must exist before absorption begins")

	local v3 = p2:GetPivot()
	local v4 = RenderStepped(function(p12, p22) --[[ Line: 244 | Upvalues: p1 (copy), p2 (copy), Config (ref), Easing (ref), v2 (copy), EggCapturePresentation (ref), p3 (copy), p4 (copy), v3 (copy) ]]
		if p1._destroyed or p2.Parent == nil then
			return true
		end

		local v1 = p22 * Config.AbsorptionSeconds
		local v32 = 1 - Easing(math.clamp((v1 - (Config.AbsorptionSeconds - Config.ShakeFadeSeconds)) / Config.ShakeFadeSeconds, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v6 = Config.HighlightDark:Lerp(Config.HighlightNearWhite, (math.sin(v1 * math.pi * 2 * Config.HighlightPulseHz) + 1) * 0.5)

		v2.FillColor = v6
		EggCapturePresentation.UpdateEgg(p2, v6)

		local v7 = math.rad(Config.EggShakePitchDegrees)
		local v9 = v7 * math.sin(v1 * math.pi * 2 * Config.EggShakePitchHz) * v32
		local v10 = math.rad(Config.EggShakeRollDegrees)
		local v12 = v10 * math.cos(v1 * math.pi * 2 * Config.EggShakeRollHz) * v32

		p2:ScaleTo((math.lerp(p3, p4, (Easing(p22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)))))
		p2:PivotTo(v3 * CFrame.Angles(v9, 0, v12))

		return nil
	end, Config.AbsorptionSeconds, true)

	OrbAbsorption.Play(v1, p2)
	p1._sourceClone = nil
	v4:Wait()

	if p1._destroyed or p2.Parent == nil then
		return
	end

	p2:ScaleTo(p4)
	p2:PivotTo(v3)
	EggCapturePresentation.FadeAndRestoreEgg(p2, Config.EggRestoreSeconds, p4, Config.EggRestorePopMultiplier, Config.EggRestorePopRatio)
	p1._eggCaptureActive = false
end
function t._claimEgg(p1, p2) --[[ _claimEgg | Line: 284 | Upvalues: Transparency (copy), RenderStepped (copy), Player (copy), Players (copy), Bezier (copy), Easing (copy), Config (copy) ]]
	p1._sourceShakeFadeStartedAt = os.clock()

	local v1 = p2:GetScale()
	local v2 = p2:GetPivot()
	local v3 = Transparency()

	RenderStepped(function(p12, p22) --[[ Line: 291 | Upvalues: p1 (copy), p2 (copy), Player (ref), Players (ref), Bezier (ref), v2 (copy), Easing (ref), Config (ref), v3 (copy), v1 (copy) ]]
		if p1._destroyed or p2.Parent == nil then
			return true
		end

		local Position = Player.PrimaryPart(Players.LocalPlayer):GetPivot().Position
		local Position3 = v2.Position
		local v22 = (Position3 + Position) * 0.5
		local v5 = CFrame.new(Bezier(v2.Position, Vector3.new(v22.X, math.max(Position3.Y, Position.Y) + ((Position3 - Position) * Vector3.new(1, 0, 1)).Magnitude * 0.5, v22.Z), Position)(p22)) * v2.Rotation
		local v6 = Vector3.new(Position.X, v5.Y, Position.Z)

		p2:PivotTo(if (v5.Position - v6).Magnitude < 0.001 then v5 else CFrame.lookAt(v5.Position, v6))

		local v9 = Easing(math.clamp((p22 - 0.6) / 0.4, 0, 1), Enum.EasingStyle.Exponential, Enum.EasingDirection.In)
		local _sourceHighlight = p1._sourceHighlight

		if _sourceHighlight ~= nil then
			_sourceHighlight.FillTransparency = math.lerp(Config.HighlightFillTransparency, 1, p22)
		end

		local _eggHighlight = p1._eggHighlight
		local v11, v122

		if _eggHighlight == nil then
			local v10

			v3(p2, 1, v9)
			v10 = p2
			v11 = Config.MinScale
			v122 = v1 * (1 - v9)
			p2:ScaleTo((math.max(v11, v122)))

			return nil
		end

		_eggHighlight.FillTransparency = math.lerp(Config.HighlightFillTransparency, 1, p22)
		v3(p2, 1, v9)
		v11 = Config.MinScale
		v122 = v1 * (1 - v9)
		p2:ScaleTo((math.max(v11, v122)))

		return nil
	end, Config.ClaimFlightSeconds, true):Wait()
end
function t._play(p1) --[[ _play | Line: 320 | Upvalues: Config (copy), EggThrowLand (copy), Network (copy), ActiveAssets2 (copy), v1 (copy) ]]
	task.wait(Config.InitialDelaySeconds)

	if p1:_isActive() then
		p1:_prepareSourceClone()
		p1:_shakeSource()

		if p1:_isActive() then
			local v12, v2, v3 = p1:_renderEgg()

			p1:_beginEggCapture(v12)

			local v4 = v12:GetPivot()

			EggThrowLand.Play(v12, v4, p1:_landingCFrame(v12), v2)

			if not p1._destroyed then
				p1:_absorb(v12, v2, v3)

				if not p1._destroyed and v12.Parent ~= nil then
					p1:_claimEgg(v12)

					if not p1._destroyed and v12:IsDescendantOf(game) then
						local _payload = p1._payload
						local v6, v7 = Network.Invoke(ActiveAssets2.REQUEST_DNA_STEAL_ANIMATION_COMPLETE, {
							OwnerUserId = _payload.OwnerUserId,
							UID = _payload.UID,
							EggUID = _payload.EggUID
						})

						if not v6 then
							v1:AtWarning():Log((("DNA steal animation completed for egg %*, but the server rejected completion: %*"):format(_payload.EggUID, v7 or "unknown error")))
						end
					end
				end
			end
		end
	end

	p1:Destroy()
end
function t.Destroy(p1) --[[ Destroy | Line: 374 | Upvalues: EggCapturePresentation (copy) ]]
	if p1._destroyed then
		return
	end

	p1._destroyed = true

	local _sourceShake = p1._sourceShake

	if _sourceShake ~= nil then
		_sourceShake:Disconnect()
		p1._sourceShake = nil
	end

	if p1._presentationFrozen and p1._sourceModel.Parent ~= nil then
		p1._movementBatch:SetPresentationOffset(p1._sourceModel, CFrame.identity)
		p1:_setPresentationFrozen(false)
	end

	local _sourceHighlight = p1._sourceHighlight

	if _sourceHighlight ~= nil then
		_sourceHighlight:Destroy()
	end

	local _eggHighlight = p1._eggHighlight

	if _eggHighlight ~= nil then
		_eggHighlight:Destroy()
	end

	local _sourceClone = p1._sourceClone

	if _sourceClone ~= nil then
		_sourceClone:Destroy()
	end

	local _eggModel = p1._eggModel

	if p1._eggCaptureActive and _eggModel ~= nil then
		EggCapturePresentation.RestoreEggImmediate(_eggModel)
		p1._eggCaptureActive = false
	end

	if _eggModel == nil then
		return
	end

	_eggModel:Destroy()
end

return t
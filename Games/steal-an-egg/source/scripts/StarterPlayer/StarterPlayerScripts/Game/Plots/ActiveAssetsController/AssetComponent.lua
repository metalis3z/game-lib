-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local AssetChatBubbleComponent = require(ReplicatedStorage.Library.Client.UI.AssetChatBubbleComponent)
local Assets = require(ReplicatedStorage.Directory.Assets)
local AssetModels = require(ReplicatedStorage.Library.Modules.AssetModels)
local AssetRuntime = require(ReplicatedStorage.Library.Types.AssetRuntime)
local ActiveAssets = require(ReplicatedStorage.Library.Types.ActiveAssets)
local Audio = require(ReplicatedStorage.Library.Audio)
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)
local ItemDisplay = require(ReplicatedStorage.Library.Modules.ItemDisplay)
local MusicController = require(ReplicatedStorage.Library.Client.MusicController)
local Player = require(ReplicatedStorage.Library.Player)
local ScaleParticle = require(ReplicatedStorage.Library.Functions.ScaleParticle)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

require(script.Parent.AssetBillboardController)

local AssetInteractionPrompt = require(script.Parent.AssetInteractionPrompt)
local AssetDnaStealAnimation = require(script.Parent.AssetDnaStealAnimation)
local Config = require(script.Parent.AssetDnaStealAnimation.Config)

require(script.Parent.AssetMovementBatch)

local AssetWanderSimulator = require(script.Parent.AssetWanderSimulator)

require(script.Parent.Types)

local t = {}

t.__index = t

local SmokeTrail = ReplicatedStorage.Assets.Particles.Pets.SmokeTrail

assert(SmokeTrail:IsA("Attachment"), "SmokeTrail pet particle template must be an Attachment")

local Love = ReplicatedStorage.Assets.Particles.Pets.Love

assert(Love:IsA("Attachment"), "Love pet particle template must be an Attachment")
function t.new(p1, p2, p3, p4, p5, p6, p7) --[[ new | Line: 127 | Upvalues: AssetRuntime (copy), Asserts (copy), t (copy), Trove (copy), ItemDisplay (copy), BBFromModelVisibleOnly (copy), AssetModels (copy), AssetWanderSimulator (copy), Assets (copy), Audio (copy), AssetChatBubbleComponent (copy), AssetInteractionPrompt (copy), Players (copy) ]]
	assert(AssetRuntime.SchemaValidation.RuntimeAssetRecord(p1), "Invalid runtime asset record")
	Asserts.Player(p2)
	Asserts.BasePart(p3)
	Asserts.Instance(p4)

	local v3 = setmetatable({}, t)

	v3._trove = Trove.new()
	v3._record = p1
	v3._owner = p2
	v3._billboards = p5
	v3._movementBatch = p6
	v3._dnaStealAnimation = nil
	v3._dnaStealFrozen = false
	v3._hiddenTransparencySnapshot = nil
	v3._model = ItemDisplay.CreateWanderingAssetModel(p1.OwnerUserId, p1.UID, p1.ItemData, p4)
	v3._trove:Connect(v3._model.DescendantAdded, function(p1) --[[ Line: 150 | Upvalues: v3 (copy) ]]
		local _hiddenTransparencySnapshot = v3._hiddenTransparencySnapshot

		if _hiddenTransparencySnapshot ~= nil and (p1:IsA("BasePart") and _hiddenTransparencySnapshot[p1] == nil) then
			_hiddenTransparencySnapshot[p1] = p1.Transparency
			p1.Transparency = 1
		end
	end)
	v3._rootPart = assert(v3._model.PrimaryPart, (("Asset model %* must have a PrimaryPart"):format(v3._model.Name)))

	local CENTER = v3._model:FindFirstChild("CENTER")
	local v6 = assert(CENTER, (("Asset model %* must contain CENTER"):format(v3._model.Name)))

	assert(v6:IsA("BasePart"), (("Asset model %*.CENTER must be a BasePart"):format(v3._model.Name)))
	v3._centerPart = v6

	local v9, v10 = BBFromModelVisibleOnly(v3._model)
	local v11 = v3._model:GetPivot():PointToObjectSpace(v9.Position).Y - v10.Y * 0.5
	local v12 = AssetModels.GetVisibleBoundsData(p1.ItemData.Category)
	local v13 = v12.Size / v12.TemplateScale
	local v15 = (math.max(v10.Y, 4.5) / 4.5) ^ 0.7

	v3._wanderSimulator = AssetWanderSimulator.new(p1.Seed, p2, p3, p1.ItemData, if p1.IsFirstPlacement == true then true else false, 2.5 + v10.Z * 0.5 * 0.8, v15 + math.max((math.max(v10.X, v10.Z) - 5.625) / 4.5, 0) ^ 0.65 * 1.15)

	local Model = v3._model:FindFirstChild("Model")
	local v23 = assert(assert(Model, (("Asset model %* must contain Model"):format(v3._model.Name))):FindFirstChildWhichIsA("AnimationController"), (("Asset model %*.Model must contain AnimationController"):format(v3._model.Name)))
	local v24 = v23:FindFirstChildWhichIsA("Animator") or Instance.new("Animator")

	v24.Parent = v23

	local v25 = Assets.Directory[p1.ItemData.Category]
	local Idle = v25.Animations.Idle
	local Walk = v25.Animations.Walk

	assert(if Idle == nil then false else true, (("Missing Idle animation for %*"):format(p1.ItemData.Category)))
	assert(if Walk == nil then false else true, (("Missing Walk animation for %*"):format(p1.ItemData.Category)))
	v3._idleTrack = v24:LoadAnimation(Idle)
	v3._walkTrack = v24:LoadAnimation(Walk)
	v3._walkAnimationReferenceSpeed = v25.WalkAnimationReferenceSpeed or 8
	v3._animationTransitionFadeDuration = v25.Animations.TransitionFadeDuration
	v3._walkAnimationAlwaysOn = if v3._animationTransitionFadeDuration == 0 then true else false
	v3._idleTrack.Looped = true
	v3._walkTrack.Looped = true
	v3._currentTrack = nil
	v3._idleTransitionRemaining = 0
	v3._wasJumping = false
	v3._greetingEffectsActive = false
	v3._greetingEffectScale = math.clamp((math.max(v10.X, v10.Y, v10.Z) / 6) ^ 0.5, 0.7, 6)
	v3._greetingSmokeAttachment = nil
	v3._greetingLoveAttachment = nil
	v3._greetingRunLoopSound = nil
	v3._greetingLoveLoopSound = nil

	local v33 = math.max(math.max(v10.X, v10.Y, v10.Z) / 6 - 1, 0) ^ 0.5
	local v34 = math.clamp(v33 + 1, 1, 3)
	local v35 = math.clamp(v33 + 1, 1, 2)

	v3._jumpSoundVolume = v34 * 0.75
	v3._jumpSoundMaxDistance = v35 * 50
	v3._jumpSounds = {}
	v3._walkSound = nil
	v3._walkSoundBasePlaybackSpeed = 1
	v3._walkSoundTargetVolume = 0
	v3._walkSoundFadeTween = nil
	v3._walkSoundWasMoving = false
	v3._simulationWasMoving = false
	v3._randomIdleSound = nil
	v3._randomIdleRandom = Random.new(p1.Seed)
	v3._soundsSuppressed = false

	local WalkSound = v25.WalkSound

	if WalkSound ~= nil then
		local AssetWalkSoundEmitter = Instance.new("Part")

		AssetWalkSoundEmitter.Name = "AssetWalkSoundEmitter"
		AssetWalkSoundEmitter.Anchored = false
		AssetWalkSoundEmitter.CanCollide = false
		AssetWalkSoundEmitter.CanQuery = false
		AssetWalkSoundEmitter.CanTouch = false
		AssetWalkSoundEmitter.Massless = true
		AssetWalkSoundEmitter.Transparency = 1
		AssetWalkSoundEmitter.Size = Vector3.new(0.05, 0.05, 0.05)
		AssetWalkSoundEmitter.CFrame = v3._rootPart.CFrame * CFrame.new(0, -v10.Y * 0.5, 0)
		AssetWalkSoundEmitter.Parent = v3._model

		local AssetWalkSoundEmitterWeld = Instance.new("WeldConstraint")

		AssetWalkSoundEmitterWeld.Name = "AssetWalkSoundEmitterWeld"
		AssetWalkSoundEmitterWeld.Part0 = AssetWalkSoundEmitter
		AssetWalkSoundEmitterWeld.Part1 = v3._rootPart
		AssetWalkSoundEmitterWeld.Parent = AssetWalkSoundEmitter

		local AssetWalkSound = Instance.new("Sound")

		AssetWalkSound.Name = "AssetWalkSound"
		Audio.PrepareSoundFromSoundFile(AssetWalkSound, WalkSound)
		AssetWalkSound.Looped = true

		local v37 = math.max(math.max(v10.X, v10.Y, v10.Z) / 6 - 1, 0) ^ 0.5
		local v38 = math.clamp(v37 + 1, 1, 5)
		local v39 = math.clamp(v37 + 1, 1, 3)

		v3._walkSoundBasePlaybackSpeed = AssetWalkSound.PlaybackSpeed
		v3._walkSoundTargetVolume = AssetWalkSound.Volume * v38
		AssetWalkSound.RollOffMaxDistance = math.min(AssetWalkSound.RollOffMaxDistance * v39, 120)
		AssetWalkSound.Volume = 0
		AssetWalkSound.Parent = AssetWalkSoundEmitter
		v3._walkSound = AssetWalkSound

		local RandomIdleSound = v25.RandomIdleSound

		if RandomIdleSound ~= nil then
			local AssetRandomIdleSound = Instance.new("Sound")

			AssetRandomIdleSound.Name = "AssetRandomIdleSound"
			Audio.PrepareSoundFromSoundFile(AssetRandomIdleSound, RandomIdleSound)
			AssetRandomIdleSound.Volume = AssetRandomIdleSound.Volume * v38
			AssetRandomIdleSound.RollOffMaxDistance = AssetRandomIdleSound.RollOffMaxDistance * v39
			AssetRandomIdleSound.Parent = AssetWalkSoundEmitter
			v3._randomIdleSound = AssetRandomIdleSound
		end

		v3._trove:Add(AssetWalkSoundEmitter)
	end

	v3._chatBubble = AssetChatBubbleComponent.new(v3._model, v3._centerPart, if v13.X > 6.0229997634887695 or v13.Y > 4.925000190734863 then true else v13.Z > 3.3399999141693115)
	v3._bubbleSuppressionActive = false
	v3._prompt = AssetInteractionPrompt.new(p1.OwnerUserId, p1.UID, p1.ItemData, v3._model)

	local v42 = if p7 then p7 else t._initialCFrame(p1, p3)

	v3._model:PivotTo(v42)
	v3._movementBatch:Add(v3._model, { v3._rootPart }, v42, v11, p3, p2 == Players.LocalPlayer, function(p1, p2) --[[ Line: 303 | Upvalues: v3 (copy) ]]
		v3:_step(p1, p2)
	end)

	if v3._walkAnimationAlwaysOn then
		v3:_play(v3._walkTrack)
	else
		v3:_play(v3._idleTrack)
	end

	return v3
end
function t._tryPlayRandomIdleSound(p1) --[[ _tryPlayRandomIdleSound | Line: 315 ]]
	local _randomIdleSound = p1._randomIdleSound

	if not p1._soundsSuppressed and (_randomIdleSound ~= nil and p1._randomIdleRandom:NextInteger(1, 13) == 1) then
		_randomIdleSound.TimePosition = 0
		_randomIdleSound:Play()
	end
end
function t._initialCFrame(p1, p2) --[[ _initialCFrame | Line: 329 ]]
	local v1 = Random.new(p1.Seed)
	local v2 = p2.Size * 0.5
	local Position = (p2.CFrame * CFrame.new(v1:NextNumber(-v2.X, v2.X), 0, v1:NextNumber(-v2.Z, v2.Z))).Position

	return CFrame.new(Position) * CFrame.Angles(0, v1:NextNumber(0, 6.283185307179586), 0)
end
function t._play(p1, p2) --[[ _play | Line: 338 ]]
	if p1._currentTrack == p2 then
		return
	end

	if p1._currentTrack ~= nil then
		p1._currentTrack:Stop(p1._animationTransitionFadeDuration or 0.35)
	end

	p1._currentTrack = p2
	p2:Play(p1._animationTransitionFadeDuration or 0.5)
end
function t._walkAnimationSpeed(p1, p2) --[[ _walkAnimationSpeed | Line: 349 ]]
	return math.clamp(p2 / p1._walkAnimationReferenceSpeed, 0.3, 5)
end
function t._playJumpSound(p1, p2) --[[ _playJumpSound | Line: 357 | Upvalues: Asserts (copy), Player (copy), Players (copy), Audio (copy) ]]
	Asserts.Vector3(p2)

	if p1._soundsSuppressed then
		return
	end

	local v1 = Player.Optional.PrimaryPart(Players.LocalPlayer)

	if v1 == nil or (v1.Position - p2).Magnitude > p1._jumpSoundMaxDistance then
		return
	end

	local v2 = Audio.Play("rbxassetid://99709497839588", p2, nil, p1._jumpSoundVolume, p1._jumpSoundMaxDistance)

	if v2 == nil then
		return
	end

	p1._jumpSounds[v2] = true
	v2.Destroying:Once(function() --[[ Line: 371 | Upvalues: p1 (copy), v2 (copy) ]]
		p1._jumpSounds[v2] = nil
	end)
end
function t._setAttachmentEmittersEnabled(p1, p2) --[[ _setAttachmentEmittersEnabled | Line: 377 | Upvalues: Asserts (copy) ]]
	Asserts.Instance(p1)
	Asserts.boolean(p2)

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = p2
		end
	end
end
function t._prepareGreetingAttachment(p1, p2, p3) --[[ _prepareGreetingAttachment | Line: 388 | Upvalues: Asserts (copy), ScaleParticle (copy) ]]
	Asserts.Instance(p1)
	Asserts.string(p2)
	Asserts.number(p3)

	local v1 = p1:Clone()

	v1.Name = p2

	for i, v in ipairs(v1:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			ScaleParticle(v, p3)
			v.Enabled = false
		end
	end

	return v1
end
function t._isLocalPlayerNear(p1, p2) --[[ _isLocalPlayerNear | Line: 405 | Upvalues: Asserts (copy), Player (copy), Players (copy) ]]
	Asserts.number(p2)

	local v1 = Player.Optional.PrimaryPart(Players.LocalPlayer)

	return if v1 == nil then false else (v1.Position - p1._rootPart.Position).Magnitude <= p2
end
function t._getGreetingSmokeAttachment(p1) --[[ _getGreetingSmokeAttachment | Line: 412 | Upvalues: t (copy), SmokeTrail (copy) ]]
	local _greetingSmokeAttachment = p1._greetingSmokeAttachment

	if _greetingSmokeAttachment == nil then
		local v1 = t._prepareGreetingAttachment(SmokeTrail, "AssetGreetingSmokeTrail", p1._greetingEffectScale)

		v1.Parent = p1._rootPart
		p1._greetingSmokeAttachment = v1

		return v1
	end

	return _greetingSmokeAttachment
end
function t._getGreetingLoveAttachment(p1) --[[ _getGreetingLoveAttachment | Line: 429 | Upvalues: t (copy), Love (copy) ]]
	local _greetingLoveAttachment = p1._greetingLoveAttachment

	if _greetingLoveAttachment == nil then
		local v1 = t._prepareGreetingAttachment(Love, "AssetGreetingLove", p1._greetingEffectScale)

		v1.Parent = p1._rootPart
		p1._greetingLoveAttachment = v1

		return v1
	end

	return _greetingLoveAttachment
end
function t._stopGreetingLoopSounds(p1) --[[ _stopGreetingLoopSounds | Line: 446 ]]
	local _greetingRunLoopSound = p1._greetingRunLoopSound

	if _greetingRunLoopSound ~= nil then
		p1._greetingRunLoopSound = nil
		_greetingRunLoopSound:Stop()
		_greetingRunLoopSound:Destroy()
	end

	local _greetingLoveLoopSound = p1._greetingLoveLoopSound

	if _greetingLoveLoopSound == nil then
		return
	end

	p1._greetingLoveLoopSound = nil
	_greetingLoveLoopSound:Stop()
	_greetingLoveLoopSound:Destroy()
end
function t._startGreetingLoopSounds(p1) --[[ _startGreetingLoopSounds | Line: 462 | Upvalues: Audio (copy) ]]
	if p1._soundsSuppressed or not p1:_isLocalPlayerNear(80) then
		return
	end

	if p1._greetingRunLoopSound == nil then
		p1._greetingRunLoopSound = Audio.Play("rbxassetid://95120998510832", p1._rootPart, nil, 0.75, 80, nil, true)
	end

	if p1._greetingLoveLoopSound ~= nil then
		return
	end

	p1._greetingLoveLoopSound = Audio.Play("rbxassetid://97690085331828", p1._rootPart, nil, 0.75, 80, nil, true)
end
function t._setGreetingEffectsActive(p1, p2) --[[ _setGreetingEffectsActive | Line: 491 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.boolean(p2)

	if p2 then
		if not p1._greetingEffectsActive then
			t._setAttachmentEmittersEnabled(p1:_getGreetingSmokeAttachment(), true)
			t._setAttachmentEmittersEnabled(p1:_getGreetingLoveAttachment(), true)
		end

		if p1:_isLocalPlayerNear(80) then
			p1:_startGreetingLoopSounds()
		else
			p1:_stopGreetingLoopSounds()
		end
	elseif p1._greetingEffectsActive then
		local _greetingSmokeAttachment = p1._greetingSmokeAttachment

		if _greetingSmokeAttachment ~= nil then
			t._setAttachmentEmittersEnabled(_greetingSmokeAttachment, false)
		end

		local _greetingLoveAttachment = p1._greetingLoveAttachment

		if _greetingLoveAttachment ~= nil then
			t._setAttachmentEmittersEnabled(_greetingLoveAttachment, false)
		end

		p1:_stopGreetingLoopSounds()
	end

	p1._greetingEffectsActive = p2
end
function t._destroyGreetingEffects(p1) --[[ _destroyGreetingEffects | Line: 519 ]]
	p1:_setGreetingEffectsActive(false)

	local _greetingSmokeAttachment = p1._greetingSmokeAttachment

	if _greetingSmokeAttachment ~= nil then
		p1._greetingSmokeAttachment = nil
		_greetingSmokeAttachment:Destroy()
	end

	local _greetingLoveAttachment = p1._greetingLoveAttachment

	if _greetingLoveAttachment == nil then
		return
	end

	p1._greetingLoveAttachment = nil
	_greetingLoveAttachment:Destroy()
end
function t._releaseBubbleSuppression(p1) --[[ _releaseBubbleSuppression | Line: 533 ]]
	if p1._bubbleSuppressionActive then
		p1._bubbleSuppressionActive = false
		p1._billboards:SetSuppressed(p1._model, false)
	end
end
function t._displayChatBubble(p1, p2) --[[ _displayChatBubble | Line: 542 ]]
	if not p1._bubbleSuppressionActive then
		p1._bubbleSuppressionActive = true
		p1._billboards:SetSuppressed(p1._model, true)
	end

	p1._chatBubble:Display(p2, function() --[[ Line: 547 | Upvalues: p1 (copy) ]]
		p1:_releaseBubbleSuppression()
	end)
end
function t._setWalkSoundMoving(p1, p2, p3) --[[ _setWalkSoundMoving | Line: 552 | Upvalues: Audio (copy) ]]
	if p1._soundsSuppressed then
		p2 = false
	end

	local _walkSound = p1._walkSound

	if _walkSound == nil then
		return
	end

	if p2 then
		_walkSound.PlaybackSpeed = p1._walkSoundBasePlaybackSpeed * math.clamp(p3 / 8, 0.3, 5)

		if not p1._walkSoundWasMoving then
			local _walkSoundFadeTween = p1._walkSoundFadeTween

			if _walkSoundFadeTween ~= nil then
				_walkSoundFadeTween:Cancel()
			end

			_walkSound.Volume = 0

			if _walkSound.IsLoaded and _walkSound.TimeLength > 2 then
				_walkSound.TimePosition = math.random() * (_walkSound.TimeLength - 1)
			end

			_walkSound:Play()
		end

		if not p1._walkSoundWasMoving then
			local v2 = Audio.Fade(_walkSound, p1._walkSoundTargetVolume, 0.1)

			p1._walkSoundFadeTween = v2
			v2:Play()
		end

		p1._walkSoundWasMoving = true
	else
		if not p1._walkSoundWasMoving then
			return
		end

		p1._walkSoundWasMoving = false

		local _walkSoundFadeTween = p1._walkSoundFadeTween
		local v3

		if _walkSoundFadeTween == nil then
			v3 = Audio.Fade(_walkSound, 0, 0.1)
			p1._walkSoundFadeTween = v3
			v3:Play()
			v3.Completed:Once(function() --[[ Line: 599 | Upvalues: p1 (copy), v3 (copy), _walkSound (copy) ]]
				if p1._walkSoundFadeTween ~= v3 then
					return
				end

				p1._walkSoundFadeTween = nil
				_walkSound:Stop()
			end)

			return
		end

		_walkSoundFadeTween:Cancel()
		v3 = Audio.Fade(_walkSound, 0, 0.1)
		p1._walkSoundFadeTween = v3
		v3:Play()
		v3.Completed:Once(function() --[[ Line: 599 | Upvalues: p1 (copy), v3 (copy), _walkSound (copy) ]]
			if p1._walkSoundFadeTween ~= v3 then
				return
			end

			p1._walkSoundFadeTween = nil
			_walkSound:Stop()
		end)
	end
end
function t._setSoundsSuppressed(p1, p2) --[[ _setSoundsSuppressed | Line: 607 | Upvalues: Asserts (copy) ]]
	Asserts.boolean(p2)

	if p1._soundsSuppressed == p2 then
		return
	end

	p1._soundsSuppressed = p2

	if not p2 then
		return
	end

	p1:_stopGreetingLoopSounds()

	for v1 in p1._jumpSounds do
		v1:Stop()
	end

	table.clear(p1._jumpSounds)

	local _randomIdleSound = p1._randomIdleSound

	if _randomIdleSound == nil then
		p1:_setWalkSoundMoving(false, 0)

		return
	end

	_randomIdleSound:Stop()
	p1:_setWalkSoundMoving(false, 0)
end
function t._step(p1, p2, p3) --[[ _step | Line: 630 | Upvalues: MusicController (copy) ]]
	p1:_setSoundsSuppressed(MusicController.IsNonDefaultTreadmillActive() or p3)

	local v1 = p1._movementBatch:GetSimulationCFrame(p1._model)
	local v2, v3, v4, v5, v6, v7 = p1._wanderSimulator:Step(p2, v1)
	local v8 = p1._simulationWasMoving and not v3

	p1._simulationWasMoving = v3

	if v7 ~= nil then
		p1:_displayChatBubble(v7)
	end

	p1:_setGreetingEffectsActive(if v6 then not p3 else v6)

	local v10 = not v4

	if v10 and not p1._wasJumping then
		p1:_playJumpSound(v1.Position)
	end

	p1._wasJumping = v10
	p1._movementBatch:SetGroundingEnabled(p1._model, v4)
	p1._movementBatch:SetTarget(p1._model, v2)

	if p1._dnaStealFrozen then
		p1:_setWalkSoundMoving(false, 0)

		local _currentTrack = p1._currentTrack

		if _currentTrack == nil then
			return
		end

		_currentTrack:AdjustSpeed(0)
	else
		if v8 then
			p1:_tryPlayRandomIdleSound()
		end

		p1:_setWalkSoundMoving(if v3 then not p3 else v3, v5)

		if p1._walkAnimationAlwaysOn then
			p1._idleTransitionRemaining = 0
			p1:_play(p1._walkTrack)
			p1._walkTrack:AdjustSpeed(if p3 then 0 else p1:_walkAnimationSpeed(v5))
		else
			if p3 then
				p1._idleTransitionRemaining = 0
				p1:_play(p1._idleTrack)
				p1._idleTrack:AdjustSpeed(1)

				return
			end

			if v3 then
				p1._idleTransitionRemaining = 0.28
				p1:_play(p1._walkTrack)
				p1._walkTrack:AdjustSpeed(p1:_walkAnimationSpeed(v5))

				return
			end

			if p1._currentTrack == p1._walkTrack and p1._idleTransitionRemaining > 0 then
				p1._idleTransitionRemaining = math.max(p1._idleTransitionRemaining - p2, 0)
				p1._walkTrack:AdjustSpeed(p1:_walkAnimationSpeed(v5))

				return
			end

			p1:_play(p1._idleTrack)
		end
	end
end
function t.GetOwnerUserId(p1) --[[ GetOwnerUserId | Line: 689 ]]
	return p1._record.OwnerUserId
end
function t.GetUid(p1) --[[ GetUid | Line: 693 ]]
	return p1._record.UID
end
function t.GetModel(p1) --[[ GetModel | Line: 697 ]]
	return p1._model
end
function t.GetRuntimeRecord(p1) --[[ GetRuntimeRecord | Line: 701 ]]
	return p1._record
end
function t.IsHidden(p1) --[[ IsHidden | Line: 705 ]]
	return p1._hiddenTransparencySnapshot ~= nil
end
function t.SetHidden(p1, p2) --[[ SetHidden | Line: 709 | Upvalues: Asserts (copy) ]]
	Asserts.boolean(p2)

	if p1:IsHidden() == p2 then
		return
	end

	if p2 then
		p1:_setGreetingEffectsActive(false)
		p1._chatBubble:SetSuppressed(true)
		p1:_releaseBubbleSuppression()
		p1._prompt:SetSuppressed(true)

		local t = {}

		p1._hiddenTransparencySnapshot = t

		for i, v in ipairs(p1._model:GetDescendants()) do
			if v:IsA("BasePart") then
				t[v] = v.Transparency
				v.Transparency = 1
			end
		end
	else
		local v1 = assert(p1._hiddenTransparencySnapshot, "Hidden asset must own a transparency snapshot")

		p1._hiddenTransparencySnapshot = nil

		for k, v in pairs(v1) do
			if k.Parent ~= nil then
				k.Transparency = v
			end
		end

		table.clear(v1)
		p1._prompt:SetSuppressed(false)
		p1._chatBubble:SetSuppressed(false)
	end
end
function t.ActivateDnaSteal(p1) --[[ ActivateDnaSteal | Line: 743 ]]
	p1._prompt:Activate()
end
function t.SetRuntimeRecord(p1, p2) --[[ SetRuntimeRecord | Line: 747 | Upvalues: AssetRuntime (copy) ]]
	assert(AssetRuntime.SchemaValidation.RuntimeAssetRecord(p2), "Invalid runtime asset record")
	p1._record = p2
	p1._wanderSimulator:SetItemData(p2.ItemData, p2.IsFirstPlacement == true)
end
function t.SetAssetArea(p1, p2) --[[ SetAssetArea | Line: 753 | Upvalues: Asserts (copy) ]]
	Asserts.BasePart(p2)
	p1._wanderSimulator:SetAssetArea(p2)
	p1._movementBatch:SetAssetArea(p1._model, p2)
end
function t.PlayDnaStealAnimation(p1, p2) --[[ PlayDnaStealAnimation | Line: 759 | Upvalues: ActiveAssets (copy), AssetDnaStealAnimation (copy), Config (copy) ]]
	assert(ActiveAssets.DnaStealAnimationPayload(p2), "Invalid DNA steal animation payload")

	local _dnaStealAnimation = p1._dnaStealAnimation
	local v2

	if _dnaStealAnimation == nil then
		v2 = nil
		v2 = AssetDnaStealAnimation.new(p1._movementBatch, p1._model, p2, function(p13) --[[ Line: 769 | Upvalues: p1 (copy), Config (ref), v2 (ref) ]]
			p1._dnaStealFrozen = p13

			if not p13 then
				local _currentTrack = p1._currentTrack

				if _currentTrack ~= nil then
					_currentTrack:AdjustSpeed(1)
				end
			end

			p1._movementBatch:SetPresentationFrozen(p1._model, p13, if p13 then nil else Config.CatchUpSeconds)

			if p13 or p1._dnaStealAnimation ~= v2 then
				return
			end

			p1._dnaStealAnimation = nil
		end)
		p1._dnaStealAnimation = v2

		return
	end

	_dnaStealAnimation:Destroy()
	v2 = nil
	v2 = AssetDnaStealAnimation.new(p1._movementBatch, p1._model, p2, function(p13) --[[ Line: 769 | Upvalues: p1 (copy), Config (ref), v2 (ref) ]]
		p1._dnaStealFrozen = p13

		if not p13 then
			local _currentTrack = p1._currentTrack

			if _currentTrack ~= nil then
				_currentTrack:AdjustSpeed(1)
			end
		end

		p1._movementBatch:SetPresentationFrozen(p1._model, p13, if p13 then nil else Config.CatchUpSeconds)

		if p13 or p1._dnaStealAnimation ~= v2 then
			return
		end

		p1._dnaStealAnimation = nil
	end)
	p1._dnaStealAnimation = v2
end
function t.Destroy(p1) --[[ Destroy | Line: 789 ]]
	local _dnaStealAnimation = p1._dnaStealAnimation

	if _dnaStealAnimation ~= nil then
		_dnaStealAnimation:Destroy()
		p1._dnaStealAnimation = nil
	end

	p1:_destroyGreetingEffects()
	p1._chatBubble:Destroy()
	p1._prompt:Destroy()
	p1._movementBatch:Remove(p1._model)
	p1._trove:Destroy()
	p1._model:Destroy()
end

return t
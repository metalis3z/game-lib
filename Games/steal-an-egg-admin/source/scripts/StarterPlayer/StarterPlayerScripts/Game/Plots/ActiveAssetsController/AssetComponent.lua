-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.AssetBillboardController)
local AssetChatBubble = require(ReplicatedStorage.Client.UI.AssetChatBubble)
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetModels = require(ReplicatedStorage.Shared.Modules.AssetModels)
require(script.Parent.AssetMovementBatch)
local AssetRuntime = require(ReplicatedStorage.Shared.Types.AssetRuntime)
local AssetWanderSimulator = require(script.Parent.AssetWanderSimulator)
local Audio = require(ReplicatedStorage.Shared.Audio)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.Spatial).ModelBounds
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Player = require(ReplicatedStorage.Shared.Player)
local Rescale = require(ReplicatedStorage.Shared.Utils.VFX).Rescale
local SfxRework = require(ReplicatedStorage.Data.SfxRework)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Parent.Types)
local v1 = {}

v1.__index = v1

local GreetingRun = SfxRework.Global("GreetingRun")
local GreetingLove = SfxRework.Global("GreetingLove")
local Jump = SfxRework.Global("Jump")
local SmokeTrail = ReplicatedStorage.Assets.Particles.Pets.SmokeTrail
local Attachment = SmokeTrail:IsA("Attachment")
assert(Attachment, "SmokeTrail pet particle template must be an Attachment")
local Love = ReplicatedStorage.Assets.Particles.Pets.Love
local Attachment_2 = Love:IsA("Attachment")
assert(Attachment_2, "Love pet particle template must be an Attachment")

function v1.new(v2, v3, v4, v5, v6, v7, v8) -- line 36 | captures: Players, t, AssetChatBubble, Assets, AssetModels, AssetRuntime, AssetWanderSimulator, Audio, ModelBounds, ItemDisplay, SfxRework, Trove, v1
    local v9 = AssetRuntime.SchemaValidation.RuntimeAssetRecord(v2)
    assert(v9, "Invalid runtime asset record")
    t.strict(t.instanceIsA("Player"))(v3)
    t.strict(t.instanceIsA("BasePart"))(v4)
    t.strict(t.Instance)(v5)
    local v10 = {}
    local v11 = setmetatable(v10, v1)
    v11._trove = Trove.new()
    v11._record = v2
    v11._owner = v3
    v11._billboards = v6
    v11._movementBatch = v7
    v11._hiddenTransparencySnapshot = nil
    v11._hiddenEffectSnapshot = nil
    v11._model = ItemDisplay.CreateWanderingAssetModel(v2.OwnerUserId, v2.UID, v2.ItemData, v5)
    v11._trove:Connect(v11._model.DescendantAdded, function(v12) -- line 55 | captures: v11
        local _hiddenTransparencySnapshot = v11._hiddenTransparencySnapshot
        if _hiddenTransparencySnapshot ~= nil and v12:IsA("BasePart") and _hiddenTransparencySnapshot[v12] == nil then
            _hiddenTransparencySnapshot[v12] = v12.Transparency
            v12.Transparency = 1
        end
        local _hiddenEffectSnapshot = v11._hiddenEffectSnapshot
        if _hiddenEffectSnapshot ~= nil then
            if v12:IsA("ParticleEmitter") then
                if _hiddenEffectSnapshot[v12] == nil then
                    _hiddenEffectSnapshot[v12] = v12.Enabled
                    v12.Enabled = false
                end
            elseif v12:IsA("Beam") and _hiddenEffectSnapshot[v12] == nil then
                _hiddenEffectSnapshot[v12] = v12.Enabled
                v12.Enabled = false
            end
        end
    end)
    local PrimaryPart = v11._model.PrimaryPart
    local v13 = ("Asset model %* must have a PrimaryPart"):format(v11._model.Name)
    v11._rootPart = assert(PrimaryPart, v13)
    local CENTER = v11._model:FindFirstChild("CENTER")
    local v14 = ("Asset model %* must contain CENTER"):format(v11._model.Name)
    local v15 = assert(CENTER, v14)
    local BasePart = v15:IsA("BasePart")
    local v16 = ("Asset model %*.CENTER must be a BasePart"):format(v11._model.Name)
    assert(BasePart, v16)
    v11._centerPart = v15
    local v17, v18 = ModelBounds(v11._model)
    local v19 = v11._model:GetPivot():PointToObjectSpace(v17.Position).Y - v18.Y * 0.5
    local v20 = AssetModels.GetVisibleBoundsData(v2.ItemData.Category)
    local v21 = v20.Size / v20.TemplateScale
    local X = v18.X
    local Z = v18.Z
    local v22 = (math.max(X, Z) - 5.625) / 4.5
    local v23 = v2.IsFirstPlacement == true
    local new = AssetWanderSimulator.new
    local Seed = v2.Seed
    local ItemData = v2.ItemData
    local v24 = 2.5 + v18.Z * 0.5 * 0.8
    local Y = v18.Y
    v11._wanderSimulator = new(Seed, v3, v4, ItemData, v23, v24, (math.max(Y, 4.5) / 4.5) ^ 0.7 + math.max(v22, 0) ^ 0.65 * 1.15)
    local Model = v11._model:FindFirstChild("Model")
    local v25 = ("Asset model %* must contain Model"):format(v11._model.Name)
    local AnimationController = assert(Model, v25):FindFirstChildWhichIsA("AnimationController")
    local v26 = ("Asset model %*.Model must contain AnimationController"):format(v11._model.Name)
    local v27 = assert(AnimationController, v26)
    local v28 = v27:FindFirstChildWhichIsA("Animator") or Instance.new("Animator")
    v28.Parent = v27
    local v29 = Assets.Directory[v2.ItemData.Category]
    local Idle = v29.Animations.Idle
    local Walk = v29.Animations.Walk
    local v30 = Idle ~= nil
    local v31 = ("Missing Idle animation for %*"):format(v2.ItemData.Category)
    assert(v30, v31)
    local v32 = Walk ~= nil
    local v33 = ("Missing Walk animation for %*"):format(v2.ItemData.Category)
    assert(v32, v33)
    v11._idleTrack = v28:LoadAnimation(Idle)
    v11._walkTrack = v28:LoadAnimation(Walk)
    v11._walkAnimationReferenceSpeed = v29.WalkAnimationReferenceSpeed or 8
    v11._animationTransitionFadeDuration = v29.Animations.TransitionFadeDuration
    v11._walkAnimationAlwaysOn = v11._animationTransitionFadeDuration == 0
    v11._idleTrack.Looped = true
    v11._walkTrack.Looped = true
    v11._currentTrack = nil
    v11._idleTransitionRemaining = 0
    v11._wasJumping = false
    v11._greetingEffectsActive = false
    local X_2 = v18.X
    local Y_2 = v18.Y
    local Z_2 = v18.Z
    local v34 = (math.max(X_2, Y_2, Z_2) / 6) ^ 0.5
    v11._greetingEffectScale = math.clamp(v34, 0.7, 6)
    v11._greetingSmokeAttachment = nil
    v11._greetingLoveAttachment = nil
    v11._greetingRunLoopSound = nil
    v11._greetingLoveLoopSound = nil
    local X_3 = v18.X
    local Y_3 = v18.Y
    local Z_3 = v18.Z
    local v35 = math.max(X_3, Y_3, Z_3) / 6 - 1
    local v36 = math.max(v35, 0) ^ 0.5
    local v37 = v36 + 1
    local v38 = math.clamp(v37, 1, 3)
    local v39 = v36 + 1
    local v40 = math.clamp(v39, 1, 2)
    v11._jumpSoundVolume = v38 * 0.75
    v11._jumpSoundMaxDistance = v40 * 50
    v11._jumpSounds = {}
    v11._walkSound = nil
    v11._walkSoundBasePlaybackSpeed = 1
    v11._walkSoundTargetVolume = 0
    v11._walkSoundFadeTween = nil
    v11._walkSoundWasMoving = false
    v11._simulationWasMoving = false
    v11._randomIdleSound = nil
    v11._randomIdleRandom = Random.new(v2.Seed)
    v11._soundsSuppressed = false
    local v41 = SfxRework.Resolve(v2.ItemData.Category, "Walk", v29.WalkSound)
    if v41 ~= nil then
        local Part = Instance.new("Part")
        Part.Name = "AssetWalkSoundEmitter"
        Part.Anchored = false
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.Massless = true
        Part.Transparency = 1
        Part.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
        Part.CFrame = v11._rootPart.CFrame * CFrame.new(0, -v18.Y * 0.5, 0)
        Part.Parent = v11._model
        local WeldConstraint = Instance.new("WeldConstraint")
        WeldConstraint.Name = "AssetWalkSoundEmitterWeld"
        WeldConstraint.Part0 = Part
        WeldConstraint.Part1 = v11._rootPart
        WeldConstraint.Parent = Part
        local Sound = Instance.new("Sound")
        Sound.Name = "AssetWalkSound"
        Audio.Configure(Sound, v41)
        Sound.Looped = true
        local X = v18.X
        local Y = v18.Y
        local Z = v18.Z
        local v42 = math.max(X, Y, Z) / 6 - 1
        local v43 = math.max(v42, 0) ^ 0.5
        local v44 = v43 + 1
        local v45 = math.clamp(v44, 1, 5)
        local v46 = v43 + 1
        local v47 = math.clamp(v46, 1, 3)
        v11._walkSoundBasePlaybackSpeed = Sound.PlaybackSpeed
        v11._walkSoundTargetVolume = Sound.Volume * v45
        local v48 = Sound.RollOffMaxDistance * v47
        Sound.RollOffMaxDistance = math.min(v48, 120)
        Sound.Volume = 0
        Sound.Parent = Part
        v11._walkSound = Sound
        local v49 = SfxRework.Resolve(v2.ItemData.Category, "Idle", v29.RandomIdleSound)
        if v49 ~= nil then
            local Sound = Instance.new("Sound")
            Sound.Name = "AssetRandomIdleSound"
            Audio.Configure(Sound, v49)
            Sound.Volume *= v45
            Sound.RollOffMaxDistance *= v47
            Sound.Parent = Part
            v11._randomIdleSound = Sound
        end
        v11._trove:Add(Part)
    end
    local v50 = if v21.X <= 6.0229997634887695 and v21.Y <= 4.925000190734863 then v21.Z > 3.3399999141693115 else true
    v11._chatBubble = AssetChatBubble.new(v11._model, v11._centerPart, v50)
    v11._bubbleSuppressionActive = false
    local v51 = v8 or v1._initialCFrame(v2, v4)
    v11._model:PivotTo(v51)
    local v52 = { v11._rootPart }
    local v53 = v3 == Players.LocalPlayer
    v11._movementBatch:Add(v11._model, v52, v51, v19, v4, v53, function(v54, v55) -- line 193 | captures: v11
        v11:_step(v54, v55)
    end)
    if v11._walkAnimationAlwaysOn then
        v11:_play(v11._walkTrack)
    else
        v11:_play(v11._idleTrack)
    end
    return v11
end

local function _tryPlayRandomIdleSound(v56) -- line 203
    local _randomIdleSound = v56._randomIdleSound
    if v56._soundsSuppressed or not (_randomIdleSound ~= nil) or not (v56._randomIdleRandom:NextInteger(1, 13) == 1) then
        return
    end
    _randomIdleSound.TimePosition = 0
    _randomIdleSound:Play()
end

v1._tryPlayRandomIdleSound = _tryPlayRandomIdleSound

local function _initialCFrame(v57, v58) -- line 211
    local v59 = Random.new(v57.Seed)
    local v60 = v58.Size * 0.5
    local v61 = v59:NextNumber(-v60.X, v60.X)
    local v62 = CFrame.new((v58.CFrame * CFrame.new(v61, 0, v59:NextNumber(-v60.Z, v60.Z))).Position)
    local v63 = v59:NextNumber(0, 6.283185307179586)
    return v62 * CFrame.Angles(0, v63, 0)
end

v1._initialCFrame = _initialCFrame

local function _play(v64, v65) -- line 219
    if v64._currentTrack == v65 then
        return
    end
    if v64._currentTrack ~= nil then
        v64._currentTrack:Stop(v64._animationTransitionFadeDuration or 0.35)
    end
    v64._currentTrack = v65
    v65:Play(v64._animationTransitionFadeDuration or 0.5)
end

v1._play = _play

local function _walkAnimationSpeed(v66, v67) -- line 229
    local v68 = v67 / v66._walkAnimationReferenceSpeed
    return (math.clamp(v68, 0.3, 5))
end

v1._walkAnimationSpeed = _walkAnimationSpeed

function v1._playJumpSound(v69, v70) -- line 233 | captures: Players, t, Audio, Player, Jump
    t.strict(t.Vector3)(v70)
    if not v69._soundsSuppressed then
        local v71 = Player.Optional.PrimaryPart(Players.LocalPlayer)
        if not (v71 == nil or v69._jumpSoundMaxDistance < (v71.Position - v70).Magnitude) then
            local v72 = Audio.Play(Jump, v70, {
                Volume = v69._jumpSoundVolume,
                MaxDistance = v69._jumpSoundMaxDistance
            })
            if v72 ~= nil then
                v69._jumpSounds[v72] = true
                v72.Destroying:Once(function() -- line 246 | captures: v69, v72
                    v69._jumpSounds[v72] = nil
                end)
            end
        end
    end
end

function v1._setAttachmentEmittersEnabled(v73, v74) -- line 251 | captures: t
    t.strict(t.Instance)(v73)
    t.strict(t.boolean)(v74)
    for v75, v76 in ipairs(v73:GetDescendants()) do
        if v76:IsA("ParticleEmitter") then
            v76.Enabled = v74
        end
    end
end

function v1._prepareGreetingAttachment(v77, v78, v79) -- line 262 | captures: t, Rescale
    t.strict(t.Instance)(v77)
    t.strict(t.string)(v78)
    t.strict(t.number)(v79)
    local v80 = v77:Clone()
    v80.Name = v78
    for v81, v82 in ipairs(v80:GetDescendants()) do
        if v82:IsA("ParticleEmitter") then
            Rescale(v82, v79)
            v82.Enabled = false
        end
    end
    return v80
end

function v1._isLocalPlayerNear(v83, v84) -- line 279 | captures: Players, t, Player
    t.strict(t.number)(v84)
    local v85 = Player.Optional.PrimaryPart(Players.LocalPlayer)
    if v85 == nil then
        return false
    end
    return (v85.Position - v83._rootPart.Position).Magnitude <= v84
end

function v1._getGreetingSmokeAttachment(v86) -- line 286 | captures: v1, SmokeTrail
    local _greetingSmokeAttachment = v86._greetingSmokeAttachment
    if _greetingSmokeAttachment == nil then
        local v87 = v1._prepareGreetingAttachment(SmokeTrail, "AssetGreetingSmokeTrail", v86._greetingEffectScale)
        v87.Parent = v86._rootPart
        v86._greetingSmokeAttachment = v87
        return v87
    end
    return _greetingSmokeAttachment
end

function v1._getGreetingLoveAttachment(v88) -- line 296 | captures: v1, Love
    local _greetingLoveAttachment = v88._greetingLoveAttachment
    if _greetingLoveAttachment == nil then
        local v89 = v1._prepareGreetingAttachment(Love, "AssetGreetingLove", v88._greetingEffectScale)
        v89.Parent = v88._rootPart
        v88._greetingLoveAttachment = v89
        return v89
    end
    return _greetingLoveAttachment
end

local function _stopGreetingLoopSounds(v90) -- line 306
    local _greetingRunLoopSound = v90._greetingRunLoopSound
    if _greetingRunLoopSound ~= nil then
        v90._greetingRunLoopSound = nil
        _greetingRunLoopSound:Stop()
        _greetingRunLoopSound:Destroy()
    end
    local _greetingLoveLoopSound = v90._greetingLoveLoopSound
    if _greetingLoveLoopSound == nil then
        return
    end
    v90._greetingLoveLoopSound = nil
    _greetingLoveLoopSound:Stop()
    _greetingLoveLoopSound:Destroy()
end

v1._stopGreetingLoopSounds = _stopGreetingLoopSounds

function v1._startGreetingLoopSounds(v91) -- line 320 | captures: Audio, GreetingRun, GreetingLove
    local v92
    if v91._soundsSuppressed then
        v92 = true
    elseif v91:_isLocalPlayerNear(80) then
        if v91._greetingRunLoopSound == nil then
            v91._greetingRunLoopSound = Audio.Play(GreetingRun, v91._rootPart, {
                Volume = 0.75,
                MaxDistance = 80,
                Looped = true
            })
        end
        v92 = false
    else
        v92 = true
    end
    if v92 then
        return
    end
    if v91._greetingLoveLoopSound == nil then
        v91._greetingLoveLoopSound = Audio.Play(GreetingLove, v91._rootPart, {
            Volume = 0.75,
            MaxDistance = 80,
            Looped = true
        })
    end
end

function v1._setGreetingEffectsActive(v93, v94) -- line 331 | captures: t, v1
    t.strict(t.boolean)(v94)
    if v94 then
        if not v93._greetingEffectsActive then
            local v95 = v93:_getGreetingSmokeAttachment()
            v1._setAttachmentEmittersEnabled(v95, true)
            local v96 = v93:_getGreetingLoveAttachment()
            v1._setAttachmentEmittersEnabled(v96, true)
        end
        if v93:_isLocalPlayerNear(80) then
            v93:_startGreetingLoopSounds()
        else
            v93:_stopGreetingLoopSounds()
        end
    elseif v93._greetingEffectsActive then
        local _greetingSmokeAttachment = v93._greetingSmokeAttachment
        if _greetingSmokeAttachment ~= nil then
            v1._setAttachmentEmittersEnabled(_greetingSmokeAttachment, false)
        end
        local _greetingLoveAttachment = v93._greetingLoveAttachment
        if _greetingLoveAttachment ~= nil then
            v1._setAttachmentEmittersEnabled(_greetingLoveAttachment, false)
        end
        v93:_stopGreetingLoopSounds()
    end
    v93._greetingEffectsActive = v94
end

local function _destroyGreetingEffects(v97) -- line 359
    v97:_setGreetingEffectsActive(false)
    local _greetingSmokeAttachment = v97._greetingSmokeAttachment
    if _greetingSmokeAttachment ~= nil then
        v97._greetingSmokeAttachment = nil
        _greetingSmokeAttachment:Destroy()
    end
    local _greetingLoveAttachment = v97._greetingLoveAttachment
    if _greetingLoveAttachment ~= nil then
        v97._greetingLoveAttachment = nil
        _greetingLoveAttachment:Destroy()
    end
end

v1._destroyGreetingEffects = _destroyGreetingEffects

local function _releaseBubbleSuppression(v98) -- line 372
    if v98._bubbleSuppressionActive then
        v98._bubbleSuppressionActive = false
        v98._billboards:SetSuppressed(v98._model, false)
    end
end

v1._releaseBubbleSuppression = _releaseBubbleSuppression

local function _displayChatBubble(v99, v100) -- line 379
    if not v99._bubbleSuppressionActive then
        v99._bubbleSuppressionActive = true
        v99._billboards:SetSuppressed(v99._model, true)
    end
    v99._chatBubble:Say(v100, function() -- line 384 | captures: v99
        v99:_releaseBubbleSuppression()
    end)
end

v1._displayChatBubble = _displayChatBubble

function v1._setWalkSoundMoving(v101, v102, v103) -- line 388 | captures: Audio
    local v104 = if v101._soundsSuppressed then false else v102
    local _walkSound = v101._walkSound
    if _walkSound ~= nil then
        if v104 then
            local v105 = v103 / 8
            local v106 = math.clamp(v105, 0.3, 5)
            _walkSound.PlaybackSpeed = v101._walkSoundBasePlaybackSpeed * v106
            if not v101._walkSoundWasMoving then
                local _walkSoundFadeTween = v101._walkSoundFadeTween
                if _walkSoundFadeTween ~= nil then
                    _walkSoundFadeTween:Cancel()
                end
                _walkSound.Volume = 0
                if _walkSound.IsLoaded and _walkSound.TimeLength > 2 then
                    _walkSound.TimePosition = math.random() * (_walkSound.TimeLength - 1)
                end
                _walkSound:Play()
            end
            if not v101._walkSoundWasMoving then
                local v107 = Audio.Fade(_walkSound, v101._walkSoundTargetVolume, 0.1)
                v101._walkSoundFadeTween = v107
                v107:Play()
            end
            v101._walkSoundWasMoving = true
        elseif v101._walkSoundWasMoving then
            v101._walkSoundWasMoving = false
            local _walkSoundFadeTween = v101._walkSoundFadeTween
            if _walkSoundFadeTween ~= nil then
                _walkSoundFadeTween:Cancel()
            end
            local v108 = Audio.Fade(_walkSound, 0, 0.1)
            v101._walkSoundFadeTween = v108
            v108:Play()
            v108.Completed:Once(function() -- line 411 | captures: v101, _walkSound, v108
                if v101._walkSoundFadeTween == v108 then
                    v101._walkSoundFadeTween = nil
                    _walkSound:Stop()
                end
            end)
        end
    end
end

function v1._setSoundsSuppressed(v109, v110) -- line 439 | captures: t
    t.strict(t.boolean)(v110)
    if v109._soundsSuppressed ~= v110 then
        v109._soundsSuppressed = v110
        if v110 then
            v109:_stopGreetingLoopSounds()
            for v111 in v109._jumpSounds do
                v111:Stop()
            end
            table.clear(v109._jumpSounds)
            local _randomIdleSound = v109._randomIdleSound
            if _randomIdleSound ~= nil then
                _randomIdleSound:Stop()
            end
            v109:_setWalkSoundMoving(false, 0)
        end
    end
end

function v1._step(v112, v113, v114) -- line 463 | captures: MusicDirector
    v112:_setSoundsSuppressed(MusicDirector.HasCustomTreadmill() or v114)
    local v115 = v112._movementBatch:GetSimulationCFrame(v112._model)
    local v116, v117, v118, v119, v120, v121 = v112._wanderSimulator:Step(v113, v115)
    local v122 = v112._simulationWasMoving and not v117
    v112._simulationWasMoving = v117
    if v121 ~= nil then
        v112:_displayChatBubble(v121)
    end
    v112:_setGreetingEffectsActive(v120 and not v114)
    local v123 = not v118
    if v123 and not v112._wasJumping then
        v112:_playJumpSound(v115.Position)
    end
    v112._wasJumping = v123
    v112._movementBatch:SetGroundingEnabled(v112._model, v118)
    v112._movementBatch:SetTarget(v112._model, v116)
    if v122 then
        v112:_tryPlayRandomIdleSound()
    end
    v112:_setWalkSoundMoving(v117 and not v114, v119)
    if v112._walkAnimationAlwaysOn then
        v112._idleTransitionRemaining = 0
        v112:_play(v112._walkTrack)
        local v124
        if v114 then
            v124 = 0
        else
            v124 = v112:_walkAnimationSpeed(v119)
        end
        v112._walkTrack:AdjustSpeed(v124)
    elseif v114 then
        v112._idleTransitionRemaining = 0
        v112:_play(v112._idleTrack)
        v112._idleTrack:AdjustSpeed(1)
    elseif v117 then
        v112._idleTransitionRemaining = 0.28
        v112:_play(v112._walkTrack)
        v112._walkTrack:AdjustSpeed(v112:_walkAnimationSpeed(v119))
    elseif v112._currentTrack ~= v112._walkTrack or v112._idleTransitionRemaining <= 0 then
        v112:_play(v112._idleTrack)
    else
        local v125 = v112._idleTransitionRemaining - v113
        v112._idleTransitionRemaining = math.max(v125, 0)
        v112._walkTrack:AdjustSpeed(v112:_walkAnimationSpeed(v119))
    end
end

local function GetOwnerUserId(v126) -- line 526
    return v126._record.OwnerUserId
end

v1.GetOwnerUserId = GetOwnerUserId

local function GetUid(v127) -- line 529
    return v127._record.UID
end

v1.GetUid = GetUid

local function GetModel(v128) -- line 532
    return v128._model
end

v1.GetModel = GetModel

local function GetRuntimeRecord(v129) -- line 535
    return v129._record
end

v1.GetRuntimeRecord = GetRuntimeRecord

local function IsHidden(v130) -- line 538
    return v130._hiddenTransparencySnapshot ~= nil
end

v1.IsHidden = IsHidden

function v1.SetHidden(v131, v132) -- line 542 | captures: t
    t.strict(t.boolean)(v132)
    if v131:IsHidden() ~= v132 then
        if v132 then
            v131:_setGreetingEffectsActive(false)
            v131._chatBubble:Mute(true)
            v131:_releaseBubbleSuppression()
            local v133 = {}
            local v134 = {}
            v131._hiddenTransparencySnapshot = v133
            v131._hiddenEffectSnapshot = v134
            for v135, v136 in ipairs(v131._model:GetDescendants()) do
                if v136:IsA("BasePart") then
                    v133[v136] = v136.Transparency
                    v136.Transparency = 1
                elseif v136:IsA("ParticleEmitter") then
                    v134[v136] = v136.Enabled
                    v136.Enabled = false
                elseif v136:IsA("Beam") or v136:IsA("Trail") then
                end
            end
        else
            local _hiddenTransparencySnapshot = v131._hiddenTransparencySnapshot
            local v137 = assert(_hiddenTransparencySnapshot, "Hidden asset must own a transparency snapshot")
            v131._hiddenTransparencySnapshot = nil
            for v138, v139 in pairs(v137) do
                if v138.Parent ~= nil then
                    v138.Transparency = v139
                end
            end
            table.clear(v137)
            local _hiddenEffectSnapshot = v131._hiddenEffectSnapshot
            v131._hiddenEffectSnapshot = nil
            if _hiddenEffectSnapshot ~= nil then
                for v140, v141 in pairs(_hiddenEffectSnapshot) do
                    if v140.Parent ~= nil then
                        v140.Enabled = v141
                    end
                end
                table.clear(_hiddenEffectSnapshot)
            end
            v131._chatBubble:Mute(false)
        end
    end
end

function v1.SetRuntimeRecord(v142, v143) -- line 588 | captures: AssetRuntime
    local v144 = AssetRuntime.SchemaValidation.RuntimeAssetRecord(v143)
    assert(v144, "Invalid runtime asset record")
    v142._record = v143
    local v145 = v143.IsFirstPlacement == true
    v142._wanderSimulator:SetItemData(v143.ItemData, v145)
end

function v1.SetAssetArea(v146, v147) -- line 595 | captures: t
    t.strict(t.instanceIsA("BasePart"))(v147)
    v146._wanderSimulator:SetAssetArea(v147)
    v146._movementBatch:SetAssetArea(v146._model, v147)
end

local function Destroy(v148) -- line 601
    v148:_destroyGreetingEffects()
    v148._chatBubble:Destroy()
    v148._movementBatch:Remove(v148._model)
    v148._trove:Destroy()
    v148._model:Destroy()
end

v1.Destroy = Destroy
return v1

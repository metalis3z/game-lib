-- PadUnboxing: brainrot unbox animation ported from the "Grow Your Lucky Block"
-- place (StarterPlayerScripts.BrainrotUnboxing) and adapted to this game.
--
-- Differences from the source:
--   * Plays ENTIRELY AT THE PAD: the roll + reveal happen above the placed
--     lucky block's slot and the winner settles straight onto that slot
--     (the source played in front of the player and handed off to a tool).
--   * Uses THIS game's brainrots (GameConfig.GetBrainrotTemplate) and the
--     ported Effects.Unboxing VFX. No BrainrotData/Config/IdlePlayer/Overhead
--     dependencies were copied -- just the base opening system.
--   * The winner is aligned to the slot's resting CFrame the whole time so the
--     real brainrot model (spawned by PodiumController via the normal pad
--     update once onComplete fires) swaps in seamlessly.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local ConfettiFX = require(ReplicatedStorage.Source.Modules.ConfettiFX)

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- The unbox VFX (the "Grow Your Lucky Block" Vfx.Unboxing part) is rebuilt in
-- code rather than shipped as a stored asset -- keeps it self-contained and
-- avoids copying an instance across places. Built once, then cloned per use.
local function NS(...)
	local a = { ... }
	local k = {}
	for i = 1, #a, 3 do k[#k + 1] = NumberSequenceKeypoint.new(a[i], a[i + 1], a[i + 2]) end
	return NumberSequence.new(k)
end

local VFX_EMITTERS = {
	{ Name = "GlowSpecs", Texture = "rbxassetid://14045123768", Rate = 12.8858, Lifetime = NumberRange.new(0.110371, 0.551856), Speed = NumberRange.new(28.9621, 43.4432),
		Color = ColorSequence.new(Color3.new(1, 0.98, 0.894616)), Size = NS(0,0,0, 0.178647,0.44397,0.221985, 0.738372,0.166489,0.166489, 1,0,0),
		Transparency = NS(0,0,0, 1,0,0), Rotation = NumberRange.new(-360, 360), RotSpeed = NumberRange.new(978.517, 2038.58),
		SpreadAngle = Vector2.new(25, 90), Acceleration = Vector3.new(0, 6.21299, 0), Drag = 4.832182, LightEmission = -2, LightInfluence = 0,
		Orientation = Enum.ParticleOrientation.FacingCamera, ZOffset = 1, EmissionDirection = Enum.NormalId.Front, Brightness = 75,
		Shape = Enum.ParticleEmitterShape.Box, ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume, ShapeInOut = Enum.ParticleEmitterShapeInOut.InAndOut, FlipbookLayout = Enum.ParticleFlipbookLayout.None },
	{ Name = "Pixel", Texture = "rbxassetid://16310643442", Rate = 5, Lifetime = NumberRange.new(0.590238, 0.590238), Speed = NumberRange.new(0.0217333, 0.0217333),
		Color = ColorSequence.new(Color3.new(1, 1, 1)), Size = NS(0,0,0, 0.260123,4.396,0, 1,6.2628,0),
		Transparency = NS(0,1,0, 0.0537353,0.79375,0.05, 0.399738,0.85625,0.0746379, 1,1,0), Rotation = NumberRange.new(-360, 360), RotSpeed = NumberRange.new(0, 0),
		SpreadAngle = Vector2.new(0, 0), Acceleration = Vector3.new(0, 0, 0), Drag = 0, LightEmission = 0, LightInfluence = 0,
		Orientation = Enum.ParticleOrientation.FacingCamera, ZOffset = 1, EmissionDirection = Enum.NormalId.Top, Brightness = 10,
		Shape = Enum.ParticleEmitterShape.Box, ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume, ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4 },
	{ Name = "Pixel Splash 2", Texture = "rbxassetid://11823051025", Rate = 6, Lifetime = NumberRange.new(0.426714, 0.71119), Speed = NumberRange.new(0.00169133, 0.00169133),
		Color = ColorSequence.new(Color3.new(1, 1, 1)), Size = NS(0,3.08871,0, 1,6.93151,1.19509),
		Transparency = NS(0,1,0, 0.0537353,0.79375,0.05, 0.399738,0.85625,0.0746379, 1,1,0), Rotation = NumberRange.new(-360, 360), RotSpeed = NumberRange.new(0, 0),
		SpreadAngle = Vector2.new(-360, 360), Acceleration = Vector3.new(0, 0, 0), Drag = 10.88103, LightEmission = 0, LightInfluence = 0,
		Orientation = Enum.ParticleOrientation.FacingCamera, ZOffset = 0.3, EmissionDirection = Enum.NormalId.Front, Brightness = 1,
		Shape = Enum.ParticleEmitterShape.Box, ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume, ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4 },
	{ Name = "Pixel Fog Overlay", Texture = "rbxassetid://102145598777345", Rate = 6, Lifetime = NumberRange.new(0.3, 0.4), Speed = NumberRange.new(0.00336426, 0.00336426),
		Color = ColorSequence.new(Color3.new(1, 1, 1)), Size = NS(0,6.14383,0, 1,13.7876,2.37718),
		Transparency = NS(0,0,0, 1,1,0), Rotation = NumberRange.new(-360, 360), RotSpeed = NumberRange.new(0, 0),
		SpreadAngle = Vector2.new(-360, 360), Acceleration = Vector3.new(0, 0, 0), Drag = 10.88103, LightEmission = 0, LightInfluence = 0,
		Orientation = Enum.ParticleOrientation.FacingCamera, ZOffset = 0.3, EmissionDirection = Enum.NormalId.Front, Brightness = 1,
		Shape = Enum.ParticleEmitterShape.Box, ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume, ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4 },
	{ Name = "Smoke", Texture = "rbxassetid://109140213506364", Rate = 3.867, Lifetime = NumberRange.new(0.430335, 0.430335), Speed = NumberRange.new(0.298512, 0.298512),
		Color = ColorSequence.new(Color3.new(1, 1, 1)), Size = NS(0,2.99118,0.683697, 1,5.8391,0),
		Transparency = NS(0,1,0, 0.0537353,0.79375,0.05, 0.399738,0.85625,0.0746379, 1,1,0), Rotation = NumberRange.new(-360, 360), RotSpeed = NumberRange.new(0, 0),
		SpreadAngle = Vector2.new(-360, 360), Acceleration = Vector3.new(0, 0, 0), Drag = 14.38597, LightEmission = 0, LightInfluence = 0,
		Orientation = Enum.ParticleOrientation.FacingCamera, ZOffset = 0.4, EmissionDirection = Enum.NormalId.Front, Brightness = 4,
		Shape = Enum.ParticleEmitterShape.Box, ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume, ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4 },
}

local vfxTemplateCache = nil
local function getVFXTemplate()
	if vfxTemplateCache and vfxTemplateCache.Parent ~= nil then return vfxTemplateCache end
	local part = Instance.new("Part")
	part.Name = "PadUnboxingVFX"
	part.Size = Vector3.new(1, 1, 1)
	part.Transparency = 1
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.CastShadow = false
	part.Locked = true
	local att = Instance.new("Attachment")
	att.Name = "Attachment"
	att.Parent = part
	for _, d in ipairs(VFX_EMITTERS) do
		local e = Instance.new("ParticleEmitter")
		for prop, val in pairs(d) do
			if prop ~= "Name" then e[prop] = val end
		end
		e.Name = d.Name
		e.Enabled = true
		-- Source shipped EmitCount=0 (silent bursts); a real value makes the
		-- reveal burst actually pop, matching burstVFX's intent.
		e:SetAttribute("EmitCount", 30)
		e.Parent = att
	end
	part.Parent = ReplicatedStorage
	vfxTemplateCache = part
	return part
end

local POP_SOUND_ID = "rbxassetid://129957374669035"
local RESULT_SOUND_ID = "rbxassetid://6506462579"
-- Plays once the moment a lucky block opens (start of the roll).
local OPEN_SOUND_ID = "rbxassetid://84872960927850"

-- The roll happens ON the pad (the model rests on the slot) -- never floating
-- in the air. Items are fit by HEIGHT so the reel reads uniformly; the winner
-- settles to the same height the real placed brainrot uses (mirrors
-- PodiumController.scaleBrainrotToPlaced) for a seamless swap.
-- Bumped 6.5 -> 9.0 (and ceiling 11 -> 14) so the silhouettes spinning across
-- the reel read at a comparable size to the final placed brainrot instead of
-- looking like dark tokens. PLACED_TARGET_HEIGHT stays the same so the
-- post-reveal settle still lands at the correct on-pad size.
local ROLL_TARGET_HEIGHT = 9.0
local ROLL_MAX_DIM_CEILING = 14
-- Mirrors PodiumController.PLACED_TARGET_HEIGHT so the unbox winner settles
-- at the exact size the real placed brainrot will have.
local PLACED_TARGET_HEIGHT = 9.5
local PLACED_MAX_DIM_CEILING = 14
local SPIN_SPEED_RAD_PER_SEC = math.rad(540)

local PadUnboxing = {}

----------------------------------------------
-- EASING
----------------------------------------------
local function easeOutQuint(t) local m = 1 - t; return 1 - m*m*m*m*m end
local function easeOutQuart(t) local m = 1 - t; return 1 - m*m*m*m end
local function easeOutCubic(t) local m = 1 - t; return 1 - m*m*m end
local function easeInQuad(t) return t * t end
local function easeInOutCubic(t)
	if t < 0.5 then return 4*t*t*t end
	local m = -2*t + 2
	return 1 - m*m*m*0.5
end
-- Overshoot-and-settle: gives each roll tick a smooth little bounce.
local function easeOutBack(t)
	local c1 = 1.70158
	local c3 = c1 + 1
	local m = t - 1
	return 1 + c3 * m * m * m + c1 * m * m
end

----------------------------------------------
-- HELPERS
----------------------------------------------
local function findLargestPart(model)
	local largest, vol = nil, 0
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			local v = d.Size.X * d.Size.Y * d.Size.Z
			if v > vol then vol = v; largest = d end
		end
	end
	return largest
end

local function getModelName(brainrotId)
	local cfg = GameConfig.Items and GameConfig.Items[brainrotId]
	return (cfg and cfg.ModelName) or brainrotId
end

-- Height-fit (same idea as PodiumController.scaleBrainrotToPlaced) so brainrots
-- read at a consistent size whatever axis is longest.
local function fitByHeight(model, targetH, ceiling)
	local _, size = model:GetBoundingBox()
	local f = targetH / math.max(size.Y, 0.01)
	local md = math.max(size.X, size.Y, size.Z, 0.01)
	if md * f > ceiling then f = ceiling / md end
	model:ScaleTo(model:GetScale() * f)
end

-- Plays the brainrot's idle so the reel isn't a row of frozen statues. The
-- rigs ship with their own `Idle` Animation child (GameConfig.animationId is
-- empty for every item) -- mirror PodiumController.playBrainrotAnimation's
-- resolve: the model's "Idle" Animation, else any Animation with an id.
local function playIdle(model)
	local resolvedId
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("Animation") and d.Name == "Idle" then
			resolvedId = d.AnimationId
			break
		end
	end
	if not resolvedId or resolvedId == "" then
		for _, d in ipairs(model:GetDescendants()) do
			if d:IsA("Animation") and d.AnimationId ~= "" then
				resolvedId = d.AnimationId
				break
			end
		end
	end
	if not resolvedId or resolvedId == "" then return end
	local ac = model:FindFirstChildWhichIsA("Humanoid", true)
		or model:FindFirstChildWhichIsA("AnimationController", true)
	if not ac then return end
	local animator = ac:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = ac
	end
	local anim = Instance.new("Animation")
	anim.AnimationId = resolvedId
	local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
	anim:Destroy()
	if ok and track then
		track.Looped = true
		pcall(function() track:Play() end)
	end
end

-- Clone a brainrot for the reel. Keeps the rig's AnimationController + bones so
-- its idle animation plays during the roll (Humanoid swapped for the lean
-- AnimationController, mirroring the placed-model path).
local function cloneBrainrot(brainrotId)
	local modelName = getModelName(brainrotId)
	local template = GameConfig.GetBrainrotTemplate and GameConfig.GetBrainrotTemplate(modelName, nil)
	if not template then return nil end

	local model = template:Clone()
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
			d.CastShadow = false
		elseif d:IsA("KeyframeSequence") or d:IsA("ProximityPrompt") or d:IsA("BillboardGui") then
			d:Destroy()
		elseif d:IsA("Humanoid") then
			local parent = d.Parent
			d:Destroy()
			local ac = Instance.new("AnimationController")
			ac.Parent = parent
		end
	end

	local primary = model.PrimaryPart or findLargestPart(model)
	if not primary then model:Destroy(); return nil end
	model.PrimaryPart = primary

	fitByHeight(model, ROLL_TARGET_HEIGHT, ROLL_MAX_DIM_CEILING)
	playIdle(model)
	return model
end

local SILHOUETTE_COLOR = Color3.new(0, 0, 0)

local function applySilhouette(model)
	local saved = {}
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			local entry = { obj = d, color = d.Color, material = d.Material, reflectance = d.Reflectance }
			if d:IsA("MeshPart") then
				entry.textureId = d.TextureID
				d.TextureID = ""
			end
			table.insert(saved, entry)
			d.Color = SILHOUETTE_COLOR
			d.Material = Enum.Material.SmoothPlastic
			d.Reflectance = 0
		elseif d:IsA("Decal") or d:IsA("Texture") then
			table.insert(saved, { obj = d, trans = d.Transparency })
			d.Transparency = 1
		elseif d:IsA("SurfaceAppearance") then
			table.insert(saved, { obj = d, parent = d.Parent })
			d.Parent = nil
		end
	end
	return saved
end

local function removeSilhouette(saved)
	if not saved then return end
	for _, s in ipairs(saved) do
		if s.obj then
			if s.parent then
				s.obj.Parent = s.parent
			elseif s.obj.Parent then
				if s.color then s.obj.Color = s.color end
				if s.material then s.obj.Material = s.material end
				if s.reflectance then s.obj.Reflectance = s.reflectance end
				if s.trans ~= nil then s.obj.Transparency = s.trans end
				if s.textureId then pcall(function() s.obj.TextureID = s.textureId end) end
			end
		end
	end
end

local function spawnVFX(position, fadeIn)
	local template = getVFXTemplate()
	if not template then return nil end
	local vfx = template:Clone()
	vfx.Position = position
	vfx.Parent = workspace
	local att = vfx:FindFirstChild("Attachment")
	if att then
		for _, e in ipairs(att:GetChildren()) do
			if e:IsA("ParticleEmitter") then
				e.ZOffset = 2
				if fadeIn then
					local origRate = e.Rate
					e.Rate = 0
					e.Enabled = true
					TweenService:Create(e, TweenInfo.new(0.3), { Rate = origRate }):Play()
				else
					e:Emit(e:GetAttribute("EmitCount") or 30)
				end
			end
		end
	end
	return vfx
end

local function burstVFX(vfx, scale)
	scale = scale or 1
	if not vfx or not vfx.Parent then return end
	local att = vfx:FindFirstChild("Attachment")
	if not att then return end
	for _, e in ipairs(att:GetChildren()) do
		if e:IsA("ParticleEmitter") then
			e:Emit(math.floor((e:GetAttribute("EmitCount") or 30) * scale))
		end
	end
end

local function fadeOutVFX(vfx, duration)
	if not vfx then return end
	duration = duration or 0.5
	local att = vfx:FindFirstChild("Attachment")
	if att then
		for _, e in ipairs(att:GetChildren()) do
			if e:IsA("ParticleEmitter") then
				TweenService:Create(e, TweenInfo.new(duration), { Rate = 0 }):Play()
			end
		end
	end
	Debris:AddItem(vfx, duration + 2)
end

local function syncVFXTo(vfx, worldPos)
	if vfx and vfx.Parent then vfx.Position = worldPos end
end

local function scaleOutAndDestroy(model, duration)
	if not model or not model.Parent then return end
	task.spawn(function()
		local s0 = model:GetScale()
		local start = os.clock()
		while os.clock() - start < duration do
			RunService.RenderStepped:Wait()
			if not model.Parent then return end
			local t = math.min((os.clock() - start) / duration, 1)
			local eased = easeInQuad(t)
			model:ScaleTo(math.max(s0 * (1 - eased), 0.001))
			for _, d in ipairs(model:GetDescendants()) do
				if d:IsA("BasePart") then d.Transparency = eased end
			end
		end
		if model.Parent then model:Destroy() end
	end)
end

local function tweenFOV(_targetFOV, _duration, _style, _dir)
	-- No-op. The pad unbox used to tween the camera FOV in/out (zoom-in for
	-- reveal, settle back at the end), but the user reported it as a
	-- disorienting screen zoom. Keep the function so call sites stay valid;
	-- just don't touch the camera.
end

local function cameraPunch(humanoid, magnitude, dur)
	if not humanoid then return end
	task.spawn(function()
		local start = os.clock()
		while os.clock() - start < dur do
			RunService.RenderStepped:Wait()
			if not humanoid.Parent then return end
			local t = (os.clock() - start) / dur
			local falloff = (1 - t) * (1 - t)
			humanoid.CameraOffset = Vector3.new(
				(math.random() - 0.5) * 2 * magnitude * falloff,
				(math.random() - 0.5) * 2 * magnitude * falloff,
				(math.random() - 0.5) * 2 * magnitude * falloff)
		end
		if humanoid.Parent then humanoid.CameraOffset = Vector3.new(0, 0, 0) end
	end)
end

local function screenFlash()
	-- No-op. Used to play a brief brightness+saturation pop on the reveal;
	-- removed per user request (the white flash read as harsh / disorienting).
	-- Confetti + the existing reveal VFX carry the celebration moment.
end

local function playSound(soundId, volume)
	local s = Instance.new("Sound")
	s.SoundId = soundId
	s.Volume = volume
	s.Parent = workspace.CurrentCamera
	s:Play()
	s.Ended:Once(function() s:Destroy() end)
	Debris:AddItem(s, 5)
end

-- Places `model` so its bbox BOTTOM rests on the pad (slotX/Z, padTopY) at
-- `rotation` -- the reel never floats. Scale-aware so the reveal scale-bounce
-- still keeps it grounded.
local function makeGroundPlacer(model, slotX, slotZ, padTopY)
	local measureScale = model:GetScale()
	local pivot = model:GetPivot()
	local bbCF, bbSize = model:GetBoundingBox()
	local pivotToBottom = pivot.Position.Y - (bbCF.Position.Y - bbSize.Y / 2)
	local horiz = Vector3.new(bbCF.Position.X - pivot.Position.X, 0, bbCF.Position.Z - pivot.Position.Z)
	local localHoriz = pivot.Rotation:Inverse():VectorToWorldSpace(horiz)
	return function(rotation, extraY)
		if not model.Parent then return end
		local s = model:GetScale() / measureScale
		local rotated = rotation:VectorToWorldSpace(localHoriz * s)
		model:PivotTo(CFrame.new(
			slotX - rotated.X,
			padTopY + pivotToBottom * s + (extraY or 0),
			slotZ - rotated.Z
		) * rotation)
	end
end

local function rollDurationFor(i, total)
	local p = (i - 1) / math.max(total - 1, 1)
	-- Slightly longer + gentler ramp than before for a smoother slow-down.
	return 0.065 + math.pow(p, 2.5) * 0.55
end

-- Build the roll order from the pool: shuffled picks with no immediate repeat,
-- the winner pinned last so the final settled model IS the winner.
local function buildSequence(possibleIds, winnerId, total)
	local pool = {}
	for _, id in ipairs(possibleIds or {}) do pool[#pool + 1] = id end
	if #pool == 0 then pool = { winnerId } end
	local seq = {}
	local last
	for i = 1, total - 1 do
		local pick = pool[math.random(1, #pool)]
		if #pool > 1 then
			local guard = 0
			while pick == last and guard < 6 do
				pick = pool[math.random(1, #pool)]; guard = guard + 1
			end
		end
		seq[i] = pick
		last = pick
	end
	seq[total] = winnerId
	return seq
end

----------------------------------------------
-- PUBLIC
----------------------------------------------
-- params = {
--   placePart   : BasePart      -- pad slot part
--   restCFrame  : CFrame        -- final winner pivot (PodiumController's visual.BaseCFrame)
--   winnerId    : string        -- rolled brainrot id
--   possibleIds : {string}      -- pool to roll through
--   onComplete  : function()    -- fired once the winner has settled (spawn the real model here)
-- }
-- Returns a handle with :Cancel().
function PadUnboxing.Play(params)
	local handle = { cancelled = false }
	local placePart = params.placePart
	local restCFrame = params.restCFrame
	local winnerId = params.winnerId
	if not placePart or not restCFrame or not winnerId then
		if params.onComplete then task.spawn(params.onComplete) end
		return handle
	end

	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")

	-- Everything is pinned to the pad surface -- the roll stays grounded.
	local padTopY = placePart.Position.Y + placePart.Size.Y / 2
	local slotX, slotZ = placePart.Position.X, placePart.Position.Z
	local restRot = restCFrame.Rotation
	-- VFX sits around the brainrot body (still grounded, not up in the air).
	local vfxPos = Vector3.new(slotX, padTopY + ROLL_TARGET_HEIGHT * 0.5, slotZ)

	local SEQ_LEN = 18
	local sequence = buildSequence(params.possibleIds, winnerId, SEQ_LEN)

	task.spawn(function()
		local currentModel, currentSilhouette, currentPlace, currentBaseScale
		-- The lucky block just opened -- play the open SFX as the roll begins.
		playSound(OPEN_SOUND_ID, 0.6)
		local vfx = spawnVFX(vfxPos, true)
		local originalFOV = camera.FieldOfView
		tweenFOV(originalFOV - 6, 0.45)
		task.wait(0.2)

		local function cleanupTransient()
			if currentModel and currentModel.Parent then currentModel:Destroy() end
			if vfx and vfx.Parent then fadeOutVFX(vfx, 0.3) end
			tweenFOV(originalFOV, 0.4)
		end

		-- PHASE: ROLL -- grounded; each tick scales in with a smooth back-bounce
		-- and the rolled brainrot plays its idle while it spins.
		for i, id in ipairs(sequence) do
			if handle.cancelled then cleanupTransient(); return end
			local duration = rollDurationFor(i, #sequence)
			local transDur = math.min(duration * 0.85, 0.18)

			if currentModel then
				scaleOutAndDestroy(currentModel, math.min(transDur * 0.9, 0.12))
			end

			playSound(POP_SOUND_ID, 0.4)
			currentModel = cloneBrainrot(id)
			if currentModel then
				currentSilhouette = applySilhouette(currentModel)
				currentBaseScale = currentModel:GetScale()
				currentPlace = makeGroundPlacer(currentModel, slotX, slotZ, padTopY)
				currentModel:ScaleTo(math.max(currentBaseScale * 0.05, 0.001))

				local spinSeed = math.random() * math.pi * 2
				local itemStart = os.clock()
				currentPlace(CFrame.Angles(0, spinSeed, 0) * restRot, 0)
				currentModel.Parent = workspace

				while os.clock() - itemStart < duration do
					RunService.RenderStepped:Wait()
					if handle.cancelled then cleanupTransient(); return end
					if not currentModel.Parent then break end
					local elapsed = os.clock() - itemStart
					local scaleT = math.min(elapsed / transDur, 1)
					local scaleMul = 0.05 + easeOutBack(scaleT) * (1 - 0.05)
					currentModel:ScaleTo(currentBaseScale * scaleMul)
					local spinAngle = spinSeed + elapsed * SPIN_SPEED_RAD_PER_SEC
					currentPlace(CFrame.Angles(0, spinAngle, 0) * restRot, 0)
				end
			end
			syncVFXTo(vfx, vfxPos)
		end

		if not (currentModel and currentModel.Parent) then
			cleanupTransient()
			if params.onComplete then params.onComplete() end
			return
		end

		-- PHASE: WIND-UP -- ease the spin to a stop facing the slot.
		local windupDur = 0.3
		local windupStart = os.clock()
		while os.clock() - windupStart < windupDur do
			RunService.RenderStepped:Wait()
			if handle.cancelled then cleanupTransient(); return end
			if not currentModel.Parent then break end
			local t = (os.clock() - windupStart) / windupDur
			currentModel:ScaleTo(currentBaseScale * (1 - math.sin(t * math.pi) * 0.06))
			currentPlace(restRot, 0)
			syncVFXTo(vfx, vfxPos)
		end

		-- PHASE: REVEAL
		removeSilhouette(currentSilhouette)
		currentSilhouette = nil
		screenFlash()
		playSound(RESULT_SOUND_ID, 0.6)
		-- Confetti celebration on the reveal (replaces the old firework SFX).
		pcall(ConfettiFX.Burst)
		local revealVfx = spawnVFX(vfxPos, false)
		burstVFX(vfx, 2.0)
		burstVFX(revealVfx, 1.8)
		cameraPunch(humanoid, 0.16, 0.3)
		tweenFOV(originalFOV - 13, 0.1, Enum.EasingStyle.Quad)
		task.delay(0.12, function() tweenFOV(originalFOV - 5, 0.5, Enum.EasingStyle.Quint) end)

		local revealDur = 1.1
		local revealStart = os.clock()
		while os.clock() - revealStart < revealDur do
			RunService.RenderStepped:Wait()
			if handle.cancelled then cleanupTransient(); return end
			if not currentModel.Parent then break end
			local t = (os.clock() - revealStart) / revealDur
			local scaleMul
			if t < 0.30 then
				scaleMul = 0.92 + easeOutCubic(t / 0.30) * 0.46
			elseif t < 0.44 then
				scaleMul = 1.38
			else
				scaleMul = 1.38 - easeOutQuart((t - 0.44) / 0.56) * 0.38
			end
			currentModel:ScaleTo(currentBaseScale * scaleMul)
			local sway = math.sin(t * math.pi * 1.5) * math.rad(4)
			currentPlace(CFrame.Angles(0, sway, 0) * restRot, 0)
			syncVFXTo(vfx, vfxPos)
			syncVFXTo(revealVfx, vfxPos)
		end
		if currentModel.Parent then currentModel:ScaleTo(currentBaseScale) end
		if vfx then fadeOutVFX(vfx, 0.4) end
		task.delay(1.0, function() if revealVfx then fadeOutVFX(revealVfx, 0.5) end end)
		task.wait(0.25)

		-- PHASE: SETTLE -- converge to the real model's resting transform +
		-- placed height so the handoff is invisible.
		tweenFOV(originalFOV, 0.55, Enum.EasingStyle.Quint)
		local placedScale
		do
			local _, sz = currentModel:GetBoundingBox()
			local f = PLACED_TARGET_HEIGHT / math.max(sz.Y, 0.01)
			local md = math.max(sz.X, sz.Y, sz.Z, 0.01)
			if md * f > PLACED_MAX_DIM_CEILING then f = PLACED_MAX_DIM_CEILING / md end
			placedScale = currentModel:GetScale() * f
		end
		local startPivot = currentModel:GetPivot()
		local startScale = currentModel:GetScale()
		local moveStart = os.clock()
		local moveDur = 0.5
		while os.clock() - moveStart < moveDur do
			RunService.RenderStepped:Wait()
			if handle.cancelled then cleanupTransient(); return end
			if not currentModel.Parent then break end
			local t = easeInOutCubic((os.clock() - moveStart) / moveDur)
			currentModel:ScaleTo(startScale + (placedScale - startScale) * t)
			currentModel:PivotTo(startPivot:Lerp(restCFrame, t))
		end
		if currentModel.Parent then
			currentModel:ScaleTo(placedScale)
			currentModel:PivotTo(restCFrame)
		end

		-- Hand off to the real brainrot model, then drop the cosmetic a frame
		-- later so the swap can't flicker.
		if params.onComplete then
			local ok, err = pcall(params.onComplete)
			if not ok then warn("[PadUnboxing] onComplete error: " .. tostring(err)) end
		end
		task.defer(function()
			if currentModel and currentModel.Parent then currentModel:Destroy() end
		end)
	end)

	return handle
end

return PadUnboxing

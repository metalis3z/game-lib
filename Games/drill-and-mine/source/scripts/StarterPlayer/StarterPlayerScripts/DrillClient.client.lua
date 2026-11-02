--[[
	DrillClient
	Listens to the DrillEvent RemoteEvent: on "start" plays the drilling
	animation (looped, Action priority) and vibrates the camera; on "stop"
	ends both. The server handles welding the drill model to the hand.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local CollectionService = game:GetService("CollectionService")

local DRILL_ANIM_ID = "rbxassetid://136292338607195"
local SHAKE_POS = 0.07      -- studs of positional jitter (subtle vibration)

local player = Players.LocalPlayer
local drillEvent = ReplicatedStorage:WaitForChild("DrillEvent")

local currentTrack = nil
local shakeActive = false
local rng = Random.new()

local function startShake()
	if shakeActive then return end
	shakeActive = true
	RunService:BindToRenderStep("DrillCameraShake", Enum.RenderPriority.Camera.Value + 1, function()
		local camera = workspace.CurrentCamera
		if not camera then return end
		-- position-only jitter: the camera never rotates or pans, it just vibrates
		local offset = CFrame.new(
			rng:NextNumber(-SHAKE_POS, SHAKE_POS),
			rng:NextNumber(-SHAKE_POS, SHAKE_POS),
			0
		)
		camera.CFrame = camera.CFrame * offset
	end)
end

local function stopShake()
	if not shakeActive then return end
	shakeActive = false
	RunService:UnbindFromRenderStep("DrillCameraShake")
end

local function startAnimation()
	if currentTrack then return end -- pose already held (drill <-> hold handoff)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
	if not animator then return end
	-- Upper body only: the pose anim has channels for the arms + torso and
	-- NONE for the legs, and the default Animate script stays ENABLED, so
	-- walk/idle/jump keep driving the feet while the Action-priority pose
	-- owns everything above the hips (feet visibly move while holding).
	local animation = Instance.new("Animation")
	animation.AnimationId = DRILL_ANIM_ID
	local ok, track = pcall(function()
		return animator:LoadAnimation(animation)
	end)
	if not ok or not track then
		warn("[DrillClient] Failed to load drill animation: " .. tostring(track))
		return
	end
	track.Priority = Enum.AnimationPriority.Action
	track.Looped = true
	track:Play(0.15)
	track:AdjustSpeed(0) -- stick on the single-keyframe hold pose
	currentTrack = track
end

local function stopAnimation()
	if currentTrack then
		currentTrack:Stop(0.2)
		currentTrack = nil
	end
	local character = player.Character
	local animate = character and character:FindFirstChild("Animate")
	if animate and animate.Disabled then
		-- re-enabling restarts the Animate LocalScript -> idle/walk come back
		animate.Disabled = false
	end
end

-- ===== Upper-body pose lock =====
-- The drill anim only ships real channels for the ARMS (its torso poses
-- are weight 0 and the head has no pose at all), so walk/idle kept
-- swaying the torso and bobbing the head straight through the hold pose.
-- While the pose is active we hard-pin the upper-body Motor6D Transforms
-- every Stepped (runs after animations are applied, before physics):
-- torso + head locked neutral, arms locked to the anim's exact keyframe.
-- The Root joint and the legs are untouched, so walking stays fully
-- alive below the hips. Local-only visual; other players still see the
-- replicated Action-priority arm pose.
local POSE_TRANSFORMS = {
	-- Root (pelvis) pinned too: the walk cycle's Root channel bobs/sways
	-- the pelvis, and the ENTIRE upper body rides it as a unit even with
	-- every joint above locked. Identity = statue-still body; the hip /
	-- knee / ankle joints hang off LowerTorso separately, so the legs
	-- still animate freely below it.
	Root = CFrame.identity,
	Waist = CFrame.identity,
	Neck = CFrame.identity,
	LeftShoulder = CFrame.new(0, -3.8147e-06, 0, 0.992546, -0.121869, 3.72529e-09, 0.0783393, 0.638022, -0.766022, 0.0933546, 0.760312, 0.642814),
	LeftElbow = CFrame.new(-0.012619, 0.00878906, -2.26498e-05, 0.999849, 0.0173955, 2.67289e-05, -0.0173956, 0.999848, -1.72859e-05, -2.70353e-05, 1.65421e-05, 1),
	LeftWrist = CFrame.new(-0.0258179, 0.00894928, -4.02927e-05, 0.999849, 0.0173955, 2.67289e-05, -0.0173956, 0.999848, -1.72859e-05, -2.70353e-05, 1.65421e-05, 1),
	RightShoulder = CFrame.new(0, -3.8147e-06, 0, 0.992546, 0.121869, -3.72529e-09, -0.0783393, 0.638022, -0.766022, -0.0933546, 0.760312, 0.642814),
	RightElbow = CFrame.identity,
	RightWrist = CFrame.identity,
}

local pinConn = nil
local pinnedJoints = nil

local function resolvePinnedJoints()
	local character = player.Character
	if not character then return nil end
	local joints = {}
	for _, d in ipairs(character:GetDescendants()) do
		if (d:IsA("Motor6D") or d:IsA("AnimationConstraint")) and POSE_TRANSFORMS[d.Name] then
			joints[#joints + 1] = { joint = d, transform = POSE_TRANSFORMS[d.Name] }
		end
	end
	if #joints == 0 then return nil end
	return joints
end

local function startPoseLock()
	if pinConn then return end
	pinnedJoints = resolvePinnedJoints()
	pinConn = RunService.Stepped:Connect(function()
		-- self-healing: joints may not have streamed in yet when the lock
		-- started (early spawn) -- keep trying until they resolve
		if not pinnedJoints then
			pinnedJoints = resolvePinnedJoints()
			if not pinnedJoints then return end
		end
		for _, e in ipairs(pinnedJoints) do
			if e.joint.Parent then
				e.joint.Transform = e.transform
			end
		end
	end)
end

local function stopPoseLock()
	if pinConn then
		pinConn:Disconnect()
		pinConn = nil
	end
	pinnedJoints = nil
end

-- Layer destruction FX: shockwave ring + dust + sparks + two debris tiers
-- (big chunks w/ trails, fast small shards) + decaying camera kick.
-- Runs locally so everything moves from its very first frame.
local BREAK_SOUND_ID = "rbxassetid://87977087262893"
local DRILL_LOOP_SOUND_ID = "rbxassetid://132041354023896"
local HP_TICK_SOUND_ID = "rbxassetid://72297116609623"
local BIG_CHUNKS = 7
local SMALL_CHUNKS = 14

-- Preload audio + the drill animation up front: assets otherwise download
-- on their first play, which reads as a delayed sound/anim in game.
task.spawn(function()
	local ContentProvider = game:GetService("ContentProvider")
	local toLoad = {}
	for _, id in { BREAK_SOUND_ID, DRILL_LOOP_SOUND_ID, HP_TICK_SOUND_ID } do
		local s = Instance.new("Sound")
		s.SoundId = id
		table.insert(toLoad, s)
	end
	local anim = Instance.new("Animation")
	anim.AnimationId = DRILL_ANIM_ID
	table.insert(toLoad, anim)
	pcall(function()
		ContentProvider:PreloadAsync(toLoad)
	end)
	for _, inst in toLoad do
		inst:Destroy()
	end
end)

-- ===== Drill bit spin =====
-- Spin parts carry the "DrillSpin" CollectionService tag, applied to the
-- exact template parts in workspace.Drills (tags survive the server's
-- Clone()); every part hangs off the drill root via Welds whose C0 is the
-- part's offset in root space, so spinning = rewriting those C0s every
-- render frame. Tagged parts are grouped into TIPS: a part's weld C0 gives
-- its position + spin axis (its local up) in root space, and parts whose
-- axis lines fall within TIP_CLUSTER_RADIUS of an existing tip's axis join
-- that tip. Groups are seeded largest-part-first, so each bit's big base
-- disc/shaft defines the tip's true axis before the small offset feature
-- parts get assigned to it. Each tip then rotates RIGIDLY around its own
-- axis -- twin/triple/quad drills spin every bit on its own shaft instead
-- of the whole head turning around the root's center like before.
-- Purely visual and client-side -- nothing replicates, and every client
-- spins every driller's bit, including other players'. EquippedDrill only
-- exists during a drilling session, so the spin starts/stops with the
-- session automatically; the BackDrill accessory is untouched.
local SPIN_SPEED = 25 -- rad/s (~4 revolutions per second)
local SPIN_TAG = "DrillSpin"
-- max lateral distance from a tip's axis line to still count as that tip:
-- big enough for offset feature parts (Plasma Core cage bars sit 0.33 off
-- the shaft), small enough that neighbouring tips stay separate (Triple's
-- shafts are ~0.5 apart, Quad's 0.72)
local TIP_CLUSTER_RADIUS = 0.4

local spinning = {} -- drill Model -> { angle, groups = {{pt, dir, members = {{weld, c0}}}}, rootChildCount, root }

local function getDrillRootClient(model)
	-- same largest-part rule the server uses to pick the weld root
	local best, bestVol
	for _, p in model:GetDescendants() do
		if p:IsA("BasePart") then
			local v = p.Size.X * p.Size.Y * p.Size.Z
			if not bestVol or v > bestVol then best, bestVol = p, v end
		end
	end
	return best
end

local function getSpinEntry(drill)
	local root = getDrillRootClient(drill)
	if not root then return nil end
	local n = #root:GetChildren()
	local entry = spinning[drill]
	-- rebuild if welds streamed in after our first scan (replication order)
	if entry and entry.rootChildCount == n then return entry end
	-- collect tagged spin welds, largest part first (see the tip-grouping
	-- note above: the big on-axis parts must seed the groups)
	local items = {}
	for _, w in root:GetChildren() do
		if w:IsA("Weld") and w.Part0 == root and w.Part1
			and CollectionService:HasTag(w.Part1, SPIN_TAG) then
			local sz = w.Part1.Size
			items[#items + 1] = { weld = w, c0 = w.C0, volume = sz.X * sz.Y * sz.Z }
		end
	end
	table.sort(items, function(a, b) return a.volume > b.volume end)
	local groups = {}
	for _, item in items do
		local dir = item.c0.UpVector
		local pos = item.c0.Position
		local best
		for _, g in groups do
			-- same tip = parallel axis (either way round) + close to its line
			if math.abs(g.dir:Dot(dir)) > 0.95 then
				local off = pos - g.pt
				local lateral = off - g.dir * off:Dot(g.dir)
				if lateral.Magnitude < TIP_CLUSTER_RADIUS then
					best = g
					break
				end
			end
		end
		if not best then
			best = { pt = pos, dir = dir, members = {} }
			groups[#groups + 1] = best
		end
		best.members[#best.members + 1] = item
	end
	entry = { angle = entry and entry.angle or 0, groups = groups, rootChildCount = n, root = root }
	spinning[drill] = entry
	return entry
end

-- ===== Drilling loop sound (client-owned, self-healing) =====
-- This used to be a server-side Sound played once per session. If the
-- client's voice ever died (e.g. the burst of new sounds on a level-up),
-- the server still saw IsPlaying = true and never re-played it -- and a
-- redundant server Play() doesn't replicate anyway (same quirk that killed
-- the tick sound once, see the tick section). Owning the loop client-side
-- and re-asserting Play() every frame means it cannot stay silent while
-- anyone is drilling.
local DRILL_LOOP_VOLUME = 0.3

local function updateLoopSound(root, shouldPlay)
	local s = root:FindFirstChild("ClientDrillLoop")
	if shouldPlay then
		if not s then
			s = Instance.new("Sound")
			s.Name = "ClientDrillLoop"
			s.SoundId = DRILL_LOOP_SOUND_ID
			s.Looped = true
			s.Volume = DRILL_LOOP_VOLUME
			s.RollOffMaxDistance = 120
			s.Parent = root
		end
		if not s.IsPlaying then
			s:Play()
		end
	elseif s and s.IsPlaying then
		s:Stop()
	end
end

RunService.RenderStepped:Connect(function(dt)
	for drill in pairs(spinning) do
		if not drill.Parent then spinning[drill] = nil end
	end
	for _, plr in ipairs(Players:GetPlayers()) do
		local character = plr.Character
		local drill = character and character:FindFirstChild("EquippedDrill")
		-- spin + loop sound only during real zone sessions (server sets the
		-- attribute); holding the inventory drill keeps the bit still
		if drill and drill:GetAttribute("Drilling") then
			local entry = getSpinEntry(drill)
			if entry and #entry.groups > 0 then
				entry.angle = (entry.angle + SPIN_SPEED * dt) % (math.pi * 2)
				for _, g in ipairs(entry.groups) do
					-- rotate the whole tip rigidly around its own axis line
					local spin = CFrame.new(g.pt) * CFrame.fromAxisAngle(g.dir, entry.angle) * CFrame.new(-g.pt)
					for _, m in ipairs(g.members) do
						m.weld.C0 = spin * m.c0
					end
				end
			end
			if entry and entry.root then
				updateLoopSound(entry.root, true)
			end
		elseif drill then
			-- drill still held after the session ended: silence the loop
			local entry = spinning[drill]
			if entry and entry.root then
				updateLoopSound(entry.root, false)
			end
		end
	end
end)

local function makeFxPart(cf)
	local p = Instance.new("Part")
	p.Anchored = true
	p.CanCollide = false
	p.CanQuery = false
	p.CanTouch = false
	p.Transparency = 1
	p.Size = Vector3.new(1, 1, 1)
	p.CFrame = cf
	return p
end

-- One persistent, preloaded break Sound reused for every explosion:
-- creating a fresh Sound per burst added a load/latency hiccup.
local breakSoundPart = nil
local breakSound = nil

local function playBreakSound(cf)
	if not breakSoundPart or not breakSoundPart.Parent then
		breakSoundPart = makeFxPart(cf)
		breakSoundPart.Name = "DrillBreakSoundPart"
		breakSoundPart.Parent = workspace
		breakSound = Instance.new("Sound")
		breakSound.SoundId = BREAK_SOUND_ID
		breakSound.Volume = 0.6
		breakSound.RollOffMaxDistance = 200
		breakSound.Parent = breakSoundPart
	end
	breakSoundPart.CFrame = cf
	breakSound.PlaybackSpeed = 0.97 + rng:NextNumber(0, 0.06)
	breakSound.TimePosition = 0
	breakSound:Play()
end

local function explosionCameraKick(center)
	local camera = workspace.CurrentCamera
	if not camera then return end
	local dist = (camera.CFrame.Position - center).Magnitude
	if dist > 150 then return end
	local strength = 0.9 * (1 - dist / 150)
	pcall(function() RunService:UnbindFromRenderStep("DrillExplosionKick") end)
	local elapsed = 0
	RunService:BindToRenderStep("DrillExplosionKick", Enum.RenderPriority.Camera.Value + 2, function(dt)
		elapsed += dt
		local decay = 1 - (elapsed / 0.45)
		if decay <= 0 then
			RunService:UnbindFromRenderStep("DrillExplosionKick")
			return
		end
		local cam = workspace.CurrentCamera
		if not cam then return end
		local amp = strength * decay * decay
		-- position-only, same rule as the drill shake: no panning, just vibration
		cam.CFrame = cam.CFrame * CFrame.new(
			rng:NextNumber(-amp, amp), rng:NextNumber(-amp, amp), 0)
	end)
end

local function spawnChunk(cf, size, color, material, center, sMin, sMax, speedScale, withTrail)
	local chunk = Instance.new("Part")
	local s = sMin + rng:NextNumber(0, sMax - sMin)
	chunk.Size = Vector3.new(s, s, s)
	-- scatter across the slab's surface with random rotation so it never
	-- reads as the wall reassembling itself
	chunk.CFrame = cf * CFrame.new(
		(rng:NextNumber() - 0.5) * size.X * 0.9,
		(rng:NextNumber() - 0.5) * size.Y * 0.9,
		0
	) * CFrame.Angles(rng:NextNumber(0, math.pi), rng:NextNumber(0, math.pi), rng:NextNumber(0, math.pi))
	chunk.Color = color
	chunk.Material = material
	chunk.Anchored = false
	-- chunks land on zone geometry instead of sinking through it; the
	-- DrillDebris group (registered in ServerScriptService.PlayerCollisions)
	-- never collides with characters or with other debris
	chunk.CanCollide = true
	chunk.CollisionGroup = "DrillDebris"
	chunk.CanQuery = false
	chunk.CanTouch = false
	if withTrail then
		local a0 = Instance.new("Attachment")
		a0.Position = Vector3.new(-s / 2, 0, 0)
		a0.Parent = chunk
		local a1 = Instance.new("Attachment")
		a1.Position = Vector3.new(s / 2, 0, 0)
		a1.Parent = chunk
		local trail = Instance.new("Trail")
		trail.Attachment0 = a0
		trail.Attachment1 = a1
		trail.Color = ColorSequence.new(color)
		trail.Transparency = NumberSequence.new(0.25, 1)
		trail.Lifetime = 0.3
		trail.MinLength = 0.05
		trail.FaceCamera = true
		trail.Parent = chunk
	end
	chunk.Parent = workspace
	-- burst radially from the center: tall launch + modest sideways drift so
	-- the break reads as a fountain -- pieces rocket clearly above the player
	-- (apex ~7-15 studs), hang, then rain back down under gravity
	local outward = chunk.Position - center
	local dir = Vector3.new(outward.X, 0, outward.Z)
	if dir.Magnitude < 0.5 then
		local ang = rng:NextNumber(0, math.pi * 2)
		dir = Vector3.new(math.cos(ang), 0, math.sin(ang))
	end
	chunk.AssemblyLinearVelocity = dir.Unit * (18 + rng:NextNumber(0, 18)) * speedScale
		+ Vector3.new(0, 52 + rng:NextNumber(0, 26), 0)
	chunk.AssemblyAngularVelocity = Vector3.new(
		rng:NextNumber(-0.5, 0.5), rng:NextNumber(-0.5, 0.5), rng:NextNumber(-0.5, 0.5)) * 24 * speedScale
	-- transparency-only fade: tweening Size on simulated parts forces
	-- per-frame geometry updates across the whole burst (frame hitch).
	-- Quad-In keeps the chunks opaque through the rise so the whole fall
	-- back down stays visible before they vanish.
	-- long enough to fall into the zone below, land, and settle before the
	-- Quad-In fade eats it
	TweenService:Create(chunk, TweenInfo.new(2.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Transparency = 1,
	}):Play()
	Debris:AddItem(chunk, 2.3)
end

local function explodeFX(cf, size, color, material)
	local center = cf.Position

	-- positional break sound: persistent preloaded instance -> plays instantly
	playBreakSound(cf)

	-- expanding neon shockwave ring at the surface
	local ring = Instance.new("Part")
	ring.Shape = Enum.PartType.Cylinder
	ring.Anchored = true
	ring.CanCollide = false
	ring.CanQuery = false
	ring.CanTouch = false
	ring.Material = Enum.Material.Neon
	ring.Color = color:Lerp(Color3.new(1, 1, 1), 0.35)
	ring.Transparency = 0.15
	ring.Size = Vector3.new(0.6, 4, 4)
	-- cylinder axis is X; stand it vertical, just above the slab surface
	ring.CFrame = CFrame.new(center + Vector3.new(0, 1.2, 0)) * CFrame.Angles(0, 0, math.rad(90))
	ring.Parent = workspace
	local maxDiameter = math.max(size.X, size.Y) * 1.6
	TweenService:Create(ring, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = Vector3.new(0.15, maxDiameter, maxDiameter),
		Transparency = 1,
	}):Play()
	Debris:AddItem(ring, 0.5)

	-- dust + sparks burst (world-up emission)
	local fxPart = makeFxPart(CFrame.new(center + Vector3.new(0, 1, 0)))
	fxPart.Parent = workspace
	local att = Instance.new("Attachment")
	att.Parent = fxPart

	local dust = Instance.new("ParticleEmitter")
	dust.Texture = "rbxasset://textures/particles/smoke_main.dds"
	dust.Color = ColorSequence.new(color:Lerp(Color3.new(1, 1, 1), 0.2), color)
	dust.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 2.5),
		NumberSequenceKeypoint.new(1, 7),
	})
	dust.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.35),
		NumberSequenceKeypoint.new(1, 1),
	})
	dust.Lifetime = NumberRange.new(0.4, 0.9)
	dust.Speed = NumberRange.new(14, 34)
	dust.SpreadAngle = Vector2.new(75, 75)
	dust.Rotation = NumberRange.new(-180, 180)
	dust.RotSpeed = NumberRange.new(-120, 120)
	dust.Acceleration = Vector3.new(0, -14, 0)
	dust.Drag = 4
	dust.LightEmission = 0.05
	dust.EmissionDirection = Enum.NormalId.Top
	dust.Enabled = false
	dust.Parent = att

	local sparks = Instance.new("ParticleEmitter")
	sparks.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	sparks.Color = ColorSequence.new(color:Lerp(Color3.new(1, 1, 1), 0.6))
	sparks.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1.2),
		NumberSequenceKeypoint.new(1, 0),
	})
	sparks.Lifetime = NumberRange.new(0.25, 0.55)
	sparks.Speed = NumberRange.new(45, 80)
	sparks.SpreadAngle = Vector2.new(85, 85)
	sparks.Acceleration = Vector3.new(0, -60, 0)
	sparks.Drag = 2
	sparks.LightEmission = 1
	sparks.EmissionDirection = Enum.NormalId.Top
	sparks.Enabled = false
	sparks.Parent = att

	dust:Emit(20)
	sparks:Emit(16)
	Debris:AddItem(fxPart, 2)

	-- debris: big chunks (with trails) burst this frame; the small shards
	-- spawn one frame later to split the instance-creation cost and avoid
	-- a single-frame hitch. 16ms offset is imperceptible.
	for _ = 1, BIG_CHUNKS do
		spawnChunk(cf, size, color, material, center, 3.0, 5.0, 0.85, true)
	end
	task.defer(function()
		for _ = 1, SMALL_CHUNKS do
			spawnChunk(cf, size, color, material, center, 1.4, 2.6, 1.35, false)
		end
	end)

	explosionCameraKick(center)
end

-- Layer hit sway + white flash: every damage tick the server fires "hit"
-- and the damaged layer flashes toward white and does one soft damped
-- swing -- a smooth sine sway along a random horizontal direction, NOT
-- per-frame random jitter -- then settles back to its exact original
-- position and color. Very slight on purpose; retriggering every tick
-- reads as a gentle continuous tremble while drilling.
local HIT_SHAKE_TIME = 0.28   -- seconds per hit vibration
local HIT_SHAKE_POS = 0.22    -- max studs of horizontal offset (clearly visible)
local HIT_SHAKE_DIP = 0.08    -- downward "hammered" dip per swing; anchored parts
                              -- never push characters, so this is visual-only
local HIT_SHAKE_CYCLES = 4    -- fast swings per hit: reads as a vibration
-- Training pads only: every hit also SQUASHES the whole ore mound -- an
-- instant severe scale-down that smoothly springs back to its exact
-- original size with a tiny overshoot pop (easeOutBack), in the same time
-- envelope as the sway so hit feedback still reads as ONE reaction.
local HIT_SQUASH_SCALE = 0.65 -- severe: mound is at 65% size on the hit frame
local HIT_SQUASH_BACK = 1.70158 -- easeOutBack c1: ~3.5% overshoot on recovery
local hitShakes = {}          -- [keyPart] = { origs = {[part]=CFrame}, token = n }

-- Training pads: the server registers the flat ZonePart (detection / flash /
-- sound anchor), but visually the ORE mound is what's being mined -- shaking
-- the slab underfoot read as the whole "button" vibrating. Redirect the sway
-- to the pad's Ore model; zone layers keep shaking the layer part itself.
local function resolveShakeTargets(part)
	local parent = part.Parent
	if part.Name == "ZonePart" and parent then
		local ore = parent:FindFirstChild("Ore")
		if ore then
			local parts = {}
			for _, d in ipairs(ore:GetDescendants()) do
				if d:IsA("BasePart") then
					parts[#parts + 1] = d
				end
			end
			if #parts > 0 then return parts, true end
		end
	end
	return { part }, false
end

local HIT_FLASH = 0.65 -- how white the layer / ore mound flashes at the hit moment
local WHITE = Color3.new(1, 1, 1)

local function shakeLayer(part)
	if not part or not part:IsA("BasePart") then return end
	local parts, redirected = resolveShakeTargets(part)
	local key = parts[1]
	local state = hitShakes[key]
	if not state then
		state = { origs = {}, token = 0 }
		for _, p in ipairs(parts) do
			state.origs[p] = { cf = p.CFrame, color = p.Color, size = p.Size }
		end
		if redirected then
			-- pads: the flat ZonePart slab used to get the (removed)
			-- server-side flash; keep that look with a flash-only entry --
			-- never moved/scaled, players stand on it and the ore mound
			-- owns the sway
			state.origs[part] = { color = part.Color, static = true }
		end
		hitShakes[key] = state
	end
	state.token += 1
	local myToken = state.token
	-- the white hit-flash is FULLY client-side: the server no longer
	-- tweens part.Color (that replicated a property delta to every client
	-- per flash step). Zone layers flash themselves; pads flash slab +
	-- ore mound.
	-- one random horizontal sway direction per hit (never vertical, so the
	-- slab can't bounce the players standing on it); all parts move rigidly
	-- together so the ore mound reads as one rock
	local ang = rng:NextNumber(0, math.pi * 2)
	local dir = Vector3.new(math.cos(ang), 0, math.sin(ang))
	-- squash anchor: the pad slab's top-center. Scaling the mound toward a
	-- point ON the drilled surface keeps every rock grounded while it
	-- shrinks instead of floating up toward the mound's own center.
	local anchor = redirected and (part.CFrame * Vector3.new(0, part.Size.Y / 2, 0)) or nil
	task.spawn(function()
		local t0 = os.clock()
		while true do
			local t = (os.clock() - t0) / HIT_SHAKE_TIME
			if t >= 1 then break end
			if state.token ~= myToken then return end
			if not key:IsDescendantOf(workspace) then
				hitShakes[key] = nil
				return
			end
			-- damped sine: continuous smooth motion that eases itself out.
			-- Horizontal jitter + a small downward dip so the vibration is
			-- also visible from straight above (standing on a training pad).
			local decay = (1 - t) * (1 - t)
			local s = math.sin(t * HIT_SHAKE_CYCLES * math.pi * 2)
			local offset = CFrame.new(dir * (s * HIT_SHAKE_POS * decay)
				+ Vector3.new(0, -math.abs(s) * HIT_SHAKE_DIP * decay, 0))
			-- easeOutBack from HIT_SQUASH_SCALE up to 1: severe squash on the
			-- very first frame, smooth recovery, pops a hair past full size
			-- near the end, settles at exactly 1
			local scale = 1
			if anchor then
				local u = t - 1
				local eased = 1 + (HIT_SQUASH_BACK + 1) * u * u * u + HIT_SQUASH_BACK * u * u
				scale = HIT_SQUASH_SCALE + (1 - HIT_SQUASH_SCALE) * eased
			end
			for p, orig in pairs(state.origs) do
				if p.Parent then
					if orig.static then
						-- flash-only entry (pad slab): color below, no motion
					elseif anchor then
						local scaledPos = anchor + (orig.cf.Position - anchor) * scale
						p.CFrame = (orig.cf.Rotation + scaledPos) * offset
						p.Size = orig.size * scale
					else
						p.CFrame = orig.cf * offset
					end
					-- starts near-white, fades back with the same decay as
					-- the sway so hit feedback reads as ONE reaction
					p.Color = orig.color:Lerp(WHITE, HIT_FLASH * decay)
				end
			end
			RunService.RenderStepped:Wait()
		end
		if state.token == myToken then
			for p, orig in pairs(state.origs) do
				if p.Parent and p:IsDescendantOf(workspace) then
					if not orig.static then
						p.CFrame = orig.cf
						if anchor then
							p.Size = orig.size
						end
					end
					p.Color = orig.color
				end
			end
			hitShakes[key] = nil
		end
	end)
end

-- ===== layer health bar + crack (client-side, PER-PLAYER) =====
-- The server used to TweenService-drain the on-surface ProgressFrame /
-- crack image every damage tick -- every step of those 0.12s tweens
-- replicated a property delta to every client. Now "hit" carries MY
-- hp/maxHP for that layer and this client animates its own SurfaceGui:
-- two players drilling the same stack each see only their own bar.
local BAR_GREEN = Color3.new(0.745098, 1, 0.0431373)
local BAR_ORANGE = Color3.fromRGB(255, 140, 0)
local BAR_RED = Color3.fromRGB(255, 45, 45)
local BAR_ORANGE_THRESHOLD = 0.5
local BAR_RED_THRESHOLD = 0.25
local BAR_TWEEN = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
-- beyond this the zone's SurfaceGuis are geo-culled (FxDistanceCuller's
-- 300-stud gate) -- snap values instead of spending tweens nobody sees
local BAR_ANIMATE_DISTANCE = 300

-- weak keys: destroyed layer parts drop their cached refs with them
local layerGuiRefs = setmetatable({}, { __mode = "k" })
-- [part] = maxHP for every bar this client has drained -- "resetLayers"
-- refills exactly these (weak keys, same reason)
local barTouched = setmetatable({}, { __mode = "k" })

local function getLayerGuiRefs(part)
	local refs = layerGuiRefs[part]
	if refs then return refs end
	refs = {}
	local progGui = part:FindFirstChild("FrontProgressSurfaceGui")
	local bgGui = part:FindFirstChild("FrontBackgroundSurfaceGui")
	if progGui then
		local bgFrame = progGui:FindFirstChild("BackgroundFrame")
		if bgFrame then
			refs.progressFrame = bgFrame:FindFirstChild("ProgressFrame")
			refs.hpLabel = bgFrame:FindFirstChild("TextLabel")
		end
	end
	refs.crackImage = bgGui and bgGui:FindFirstChild("ImageLabel")
	layerGuiRefs[part] = refs
	return refs
end

-- 2500000000000 -> "2.5T", same rule as the server's registration-time init
local HP_SUFFIXES = { "", "K", "M", "B", "T", "Qd", "Qn", "Sx", "Sp", "Oc", "No", "Dc", "Ud", "Dd", "Td" }
local function formatHP(n)
	n = math.floor(n + 0.5)
	if n < 1000 then return tostring(n) end
	local mag = math.floor(math.log10(n) / 3)
	if mag > #HP_SUFFIXES - 1 then mag = #HP_SUFFIXES - 1 end
	local scaled = n / 1000 ^ mag
	local s
	if scaled >= 10 then s = string.format("%.1f", scaled) else s = string.format("%.2f", scaled) end
	s = s:gsub("%.?0+$", "")
	return s .. HP_SUFFIXES[mag + 1]
end

local function updateLayerBar(part, hp, maxHP, snap)
	if not (part and part:IsA("BasePart") and part.Parent) then return end
	-- training pads drill forever: hp/maxHP arrive as math.huge -- no bar
	if not (hp and maxHP) or maxHP ~= maxHP or maxHP >= math.huge or maxHP <= 0 then return end
	local refs = getLayerGuiRefs(part)
	barTouched[part] = maxHP
	local frac = math.clamp(hp / maxHP, 0, 1)
	local color = BAR_GREEN
	if frac <= BAR_RED_THRESHOLD then
		color = BAR_RED
	elseif frac <= BAR_ORANGE_THRESHOLD then
		color = BAR_ORANGE
	end
	local camera = workspace.CurrentCamera
	local far = camera and (part.Position - camera.CFrame.Position).Magnitude > BAR_ANIMATE_DISTANCE
	if refs.progressFrame then
		if snap or far then
			refs.progressFrame.Size = UDim2.new(frac, 0, 1, 0)
			refs.progressFrame.BackgroundColor3 = color
		else
			TweenService:Create(refs.progressFrame, BAR_TWEEN, {
				Size = UDim2.new(frac, 0, 1, 0),
				BackgroundColor3 = color,
			}):Play()
		end
	end
	if refs.hpLabel then
		refs.hpLabel.Text = formatHP(math.max(hp, 0)) .. "/" .. formatHP(maxHP)
	end
	if refs.crackImage then
		-- crack fades in as the layer takes damage (Kick Door style)
		if snap or far then
			refs.crackImage.ImageTransparency = frac
		else
			TweenService:Create(refs.crackImage, BAR_TWEEN, { ImageTransparency = frac }):Play()
		end
	end
end

-- ===== per-player local layer destruction =====
-- The server never destroys zone layers anymore: at 0 HP it tells ONLY
-- the drilling player's client, which bursts the debris and hides its
-- LOCAL copy of the part. Our own character is simulated on this
-- client, so the local CanCollide=false drops only US through -- for
-- everyone else the layer stays visible and solid (they must drill
-- their own way down). "resetLayers" (fired when this player surfaces)
-- restores every part this client hid and refills every bar it drained.
local locallyDestroyed = {} -- [part] = { transparency, canCollide, guiKids, textures }

local function localDestroyLayer(part, color)
	if not (part and part:IsA("BasePart")) or locallyDestroyed[part] then return end
	-- debris first, computed from the still-intact local geometry
	explodeFX(part.CFrame, part.Size, color or part.Color, part.Material)
	local info = {
		transparency = part.Transparency,
		canCollide = part.CanCollide,
		guiKids = {},
		textures = {},
	}
	part.Transparency = 1
	part.CanCollide = false
	for _, child in ipairs(part:GetChildren()) do
		if child:IsA("SurfaceGui") then
			-- hide the bar/crack via child Visible: FxDistanceCuller owns
			-- SurfaceGui.Enabled and would re-enable it on un-cull
			for _, kid in ipairs(child:GetChildren()) do
				if kid:IsA("GuiObject") and kid.Visible then
					kid.Visible = false
					table.insert(info.guiKids, kid)
				end
			end
		elseif child:IsA("Decal") or child:IsA("Texture") then
			-- stud Textures don't inherit part transparency
			info.textures[child] = child.Transparency
			child.Transparency = 1
		end
	end
	locallyDestroyed[part] = info
end

local function restoreLocalLayers()
	for part, info in pairs(locallyDestroyed) do
		if part.Parent then
			part.Transparency = info.transparency
			part.CanCollide = info.canCollide
			for _, kid in ipairs(info.guiKids) do
				if kid.Parent then kid.Visible = true end
			end
			for tex, t in pairs(info.textures) do
				if tex.Parent then tex.Transparency = t end
			end
		end
	end
	table.clear(locallyDestroyed)
	-- refill every bar this client drained (snap -- the player is at the
	-- surface, far from every zone gui)
	for part, maxHP in pairs(barTouched) do
		if part.Parent then
			updateLayerBar(part, maxHP, maxHP, true)
		end
	end
	table.clear(barTouched)
end

-- ===== per-tick bit debris =====
-- Every damage tick ("hit"), a few tiny chunks of the drilled part spray
-- outward from each driller's bit tip -- local physics parts (moving from
-- their very first frame, same recipe as the explosion debris, miniature)
-- with a short trail so the motion reads smooth.
local TICK_DEBRIS_PER_DRILLER = 4
local TICK_DEBRIS_MAX_DIST = 120

local function drillTipInfo(character)
	local drill = character and character:FindFirstChild("EquippedDrill")
	if not drill then return nil end
	local root = getDrillRootClient(drill)
	if not root then return nil end
	local rootCF = root.CFrame
	-- the bit runs along root +Y (see the spin section): the tip is the
	-- farthest part extent along that axis
	local maxY = root.Size.Y / 2
	for _, p in ipairs(drill:GetDescendants()) do
		if p:IsA("BasePart") and p ~= root then
			local localY = rootCF:PointToObjectSpace(p.Position).Y + math.max(p.Size.X, p.Size.Y, p.Size.Z) / 2
			if localY > maxY then maxY = localY end
		end
	end
	return rootCF.Position + rootCF.UpVector * maxY, rootCF.UpVector
end

local function tickDebrisFX(part, drillerCharacters, color)
	if typeof(drillerCharacters) ~= "table" then return end
	if not (part and part:IsA("BasePart")) then return end
	if typeof(color) ~= "Color3" then color = part.Color end
	local camera = workspace.CurrentCamera
	for _, character in ipairs(drillerCharacters) do
		if typeof(character) == "Instance" and character:IsA("Model") then
			local tip, bitDir = drillTipInfo(character)
			if tip and (not camera or (camera.CFrame.Position - tip).Magnitude < TICK_DEBRIS_MAX_DIST) then
				-- radial frame around the bit axis: spray sideways off the tip,
				-- works for floor pads and vertical zone walls alike
				local perpU = bitDir:Cross(Vector3.yAxis)
				if perpU.Magnitude < 0.05 then perpU = bitDir:Cross(Vector3.xAxis) end
				perpU = perpU.Unit
				local perpV = bitDir:Cross(perpU).Unit
				for _ = 1, TICK_DEBRIS_PER_DRILLER do
					local s = 0.34 + rng:NextNumber(0, 0.26)
					local bit = Instance.new("Part")
					bit.Size = Vector3.new(s, s, s)
					bit.CFrame = CFrame.new(tip + Vector3.new(
						rng:NextNumber(-0.25, 0.25), rng:NextNumber(-0.25, 0.25), rng:NextNumber(-0.25, 0.25)))
						* CFrame.Angles(rng:NextNumber(0, math.pi), rng:NextNumber(0, math.pi), rng:NextNumber(0, math.pi))
					bit.Color = color
					bit.Material = part.Material
					bit.Anchored = false
					-- same collision rule as the explosion chunks: bounce on
					-- zone geometry, never on characters or other debris
					bit.CanCollide = true
					bit.CollisionGroup = "DrillDebris"
					bit.CanQuery = false
					bit.CanTouch = false
					local a0 = Instance.new("Attachment")
					a0.Position = Vector3.new(-s / 2, 0, 0)
					a0.Parent = bit
					local a1 = Instance.new("Attachment")
					a1.Position = Vector3.new(s / 2, 0, 0)
					a1.Parent = bit
					local trail = Instance.new("Trail")
					trail.Attachment0 = a0
					trail.Attachment1 = a1
					trail.Color = ColorSequence.new(color:Lerp(Color3.new(1, 1, 1), 0.25), color)
					trail.Transparency = NumberSequence.new(0.25, 1)
					trail.Lifetime = 0.18
					trail.MinLength = 0.03
					trail.FaceCamera = true
					trail.Parent = bit
					bit.Parent = workspace
					local ang = rng:NextNumber(0, math.pi * 2)
					local radial = perpU * math.cos(ang) + perpV * math.sin(ang)
					-- strong upward pop: tick chunks arc above the driller's head
					-- and fall back down instead of just dribbling off the tip
					bit.AssemblyLinearVelocity = radial * (7 + rng:NextNumber(0, 6))
						- bitDir * rng:NextNumber(1, 4)
						+ Vector3.new(0, 32 + rng:NextNumber(0, 16), 0)
					bit.AssemblyAngularVelocity = Vector3.new(
						rng:NextNumber(-12, 12), rng:NextNumber(-12, 12), rng:NextNumber(-12, 12))
					-- transparency-only fade, same rule as the explosion chunks;
					-- long enough to cover the full up-and-down arc
					TweenService:Create(bit, TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						Transparency = 1,
					}):Play()
					Debris:AddItem(bit, 0.95)
				end
			end
		end
	end
end

-- The hold pose plays while drilling on a zone OR while the hotbar drill
-- is held (server sends "hold"/"unhold"); the camera shake is
-- drilling-only.
local drillingActive = false
local holdActive = false

local function updatePose()
	if drillingActive or holdActive then
		startAnimation()
		startPoseLock()
	else
		stopAnimation()
		stopPoseLock()
	end
end

-- ===== per-hit tick sound (client-side) =====
-- The server used to Play() one Sound instance per layer every beat, but a
-- repeated server-side Play() on an already-Playing one-shot doesn't restart
-- on clients (no replicated property delta) -- the tick audio died after the
-- first few beats of a session. Playing it locally on the "hit" event is
-- always reliable and keeps the pitch variation.
local TICK_SOUND_VOLUME = 1.4

-- Pre-created, preloaded pool played round-robin. The old fresh-Sound-per-hit
-- version made the tick land audibly AFTER the white flash: a brand-new Sound
-- instance takes the audio engine a beat to become playable even when the
-- asset is cached. Pooled instances are loaded once and start instantly.
-- 8 instances of a 0.04s sound means any one is long finished before its
-- turn comes again, so the reused-single-instance restart quirk (which is
-- why per-hit instances existed) can't occur -- and we Stop() before Play()
-- anyway to clear any stuck state.
local TICK_POOL_SIZE = 8
local tickPool = {}
local tickPoolIndex = 0

local function makeTickSound()
	local s = Instance.new("Sound")
	s.Name = "ClientTickShot"
	s.SoundId = HP_TICK_SOUND_ID
	s.Volume = TICK_SOUND_VOLUME
	s.RollOffMaxDistance = 150
	return s
end

for i = 1, TICK_POOL_SIZE do
	tickPool[i] = makeTickSound()
end
task.spawn(function()
	pcall(function()
		game:GetService("ContentProvider"):PreloadAsync(tickPool)
	end)
end)

local function playTickSound(part)
	if not (part and part:IsA("BasePart")) then return end
	tickPoolIndex = tickPoolIndex % TICK_POOL_SIZE + 1
	local s = tickPool[tickPoolIndex]
	-- pool sounds live on the part they last played from, so a destroyed
	-- layer takes its current tenant with it -- rebuild that slot on demand
	if not pcall(function() s.Parent = part end) then
		s = makeTickSound()
		tickPool[tickPoolIndex] = s
		s.Parent = part
	end
	if s.IsPlaying then s:Stop() end
	s.PlaybackSpeed = 0.95 + rng:NextNumber(0, 0.1)
	s:Play()
end

drillEvent.OnClientEvent:Connect(function(action, ...)
	if action == "start" then
		drillingActive = true
		updatePose()
		-- camera shake while drilling removed (user request); the part's own
		-- hit vibration is the drilling feedback now
	elseif action == "stop" then
		drillingActive = false
		updatePose() -- keeps the pose while the hotbar drill is still held
		stopShake()
	elseif action == "hold" then
		holdActive = true
		updatePose()
	elseif action == "unhold" then
		holdActive = false
		updatePose()
	elseif action == "explode" then
		localDestroyLayer(...)
	elseif action == "resetLayers" then
		restoreLocalLayers()
	elseif action == "hit" then
		local part, drillerCharacters, color, hp, maxHP = ...
		-- sound first: audio has more startup latency than a Color write, so
		-- issuing Play() before the flash/sway keeps them in sync
		playTickSound(part)
		shakeLayer(part)
		updateLayerBar(part, hp, maxHP)
		tickDebrisFX(part, drillerCharacters, color)
	end
end)

-- reset state on respawn (the old character's track died with it; the
-- server also re-sends "unhold" on spawn)
player.CharacterAdded:Connect(function()
	drillingActive = false
	holdActive = false
	currentTrack = nil
	stopShake()
	stopPoseLock() -- old character's joints died with it; re-resolved on next hold
end)


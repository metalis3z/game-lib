-- FightFilm.Kit : moteur des cinématiques de combat (côté client).
--   * une horloge de film (ralenti, arrêt sur image à l'impact, avance rapide pour les tests)
--   * des acteurs animés articulation par articulation : avatars R15 et personnages R6 construits en blocs
--   * les pieds restent au sol : la hauteur du corps est recalculée à partir des angles des jambes
--   * marche / course : la cadence suit la distance réellement parcourue, les pieds ne glissent pas
--   * caméra, bandes noires, fondus, flash, sous-titres, sons
-- Angles en degrés {x, y, z}, mêmes conventions pour R15 et R6 :
--   épaules / hanches : x > 0 = membre vers l'avant ; épaule droite z > 0 = bras écarté (gauche : z < 0)
--   coudes : x > 0 = plie vers l'avant ; genoux : x < 0 = plie vers l'arrière
--   Waist : x < 0 = penche en avant, y > 0 = tourne vers la gauche ; Neck : x > 0 = lève la tête
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

local Kit = {}
local rad, sin, cos, clamp, max, min, abs = math.rad, math.sin, math.cos, math.clamp, math.max, math.min, math.abs
local TAU = math.pi * 2
local ABORT = "FILM_ABORT"

Kit.time = 0        -- temps du film (secondes)
Kit.scale = 1       -- 1 = vitesse normale, 0.3 = ralenti
Kit.running = false
Kit.ffTo = nil      -- tests : avance rapide jusqu'à ce temps, puis pause
Kit.paused = false
Kit.actors = {}
Kit.scene = nil
local stopUntil, stopScale = 0, 1
local tweens = {}
local camera, camFn, camT0, camBlend, camLast, shakeAmp, fovKick = nil, nil, 0, nil, nil, 0, 0
local gui, bars, fade, flash, subtitle
local connection

---------------------------------------------------------------- courbes
Kit.Ease = {
	linear = function(u) return u end,
	inQuad = function(u) return u * u end,
	outQuad = function(u) return 1 - (1 - u) ^ 2 end,
	inOut = function(u) return u * u * (3 - 2 * u) end,
	inCubic = function(u) return u ^ 3 end,
	outCubic = function(u) return 1 - (1 - u) ^ 3 end,
	outQuart = function(u) return 1 - (1 - u) ^ 4 end,
	inQuart = function(u) return u ^ 4 end,
	outBack = function(u) return 1 + 2.70158 * (u - 1) ^ 3 + 1.70158 * (u - 1) ^ 2 end, -- dépasse puis revient
	inBack = function(u) return 2.70158 * u ^ 3 - 1.70158 * u ^ 2 end,                  -- recule avant de partir
}
local function E(e) return type(e) == "function" and e or Kit.Ease[e or "inOut"] or Kit.Ease.inOut end

---------------------------------------------------------------- horloge et déroulement
local function alive() if not Kit.running then error(ABORT, 0) end end
function Kit.wait(d)
	local target = Kit.time + (d or 0)
	while Kit.time < target do alive() RunService.RenderStepped:Wait() end
	alive()
end
-- attend que le film atteigne le temps t (repères absolus : les phases ne dérivent pas)
function Kit.at(t)
	while Kit.time < t do alive() RunService.RenderStepped:Wait() end
	alive()
end
-- lance une piste en parallèle (un personnage, une série d'effets...)
function Kit.fork(fn, ...)
	local args = table.pack(...)
	task.spawn(function()
		local ok, err = pcall(fn, table.unpack(args, 1, args.n))
		if not ok and err ~= ABORT then warn("[FightFilm] " .. tostring(err)) end
	end)
end
function Kit.delay(d, fn, ...)
	local args = table.pack(...)
	Kit.fork(function() Kit.wait(d) fn(table.unpack(args, 1, args.n)) end)
end
-- arrêt sur image à l'impact : le film ralentit très fort pendant `seconds` (temps réel)
function Kit.hitstop(seconds, factor)
	stopUntil, stopScale = os.clock() + seconds, factor or 0.04
end
-- interpolation libre sur le temps du film : fn(u de 0 à 1)
function Kit.tween(dur, fn, ease, done)
	local t = {t0 = Kit.time, dur = max(dur, 1e-3), fn = fn, ease = E(ease), done = done}
	table.insert(tweens, t)
	return t
end
function Kit.fast() return Kit.ffTo ~= nil and Kit.time < Kit.ffTo end

---------------------------------------------------------------- sons
function Kit.snd(id, volume, speed, looped)
	if Kit.fast() and not looped then return nil end
	local s
	if typeof(id) == "Instance" then
		s = id:Clone()
	else
		s = Instance.new("Sound")
		s.SoundId = type(id) == "number" and ("rbxassetid://" .. id) or id
	end
	s.Volume, s.PlaybackSpeed, s.Looped = volume or 0.6, speed or 1, looped == true
	s.Parent = SoundService
	s:Play()
	if not looped then Debris:AddItem(s, 14) end
	return s
end
function Kit.fadeSound(s, volume, t)
	if s then TweenService:Create(s, TweenInfo.new(t or 1), {Volume = volume}):Play() end
end

---------------------------------------------------------------- personnages R6 en blocs
-- parts : Torso, Head, "Left Arm", "Right Arm", "Left Leg", "Right Leg" ; articulations aux noms du R15 pour partager les poses
function Kit.makeR6(o)
	o = o or {}
	local s = o.Scale or 1
	local model = Instance.new("Model")
	model.Name = o.Name or "R6"
	local function part(name, size, color)
		local p = Instance.new("Part")
		p.Name = name
		p.Size = size * s
		p.Color = color or Color3.fromRGB(120, 120, 130)
		p.Material = Enum.Material.Plastic
		pcall(function() p.MaterialVariant = "Studs" end)
		p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		p.Anchored, p.Massless = false, true
		p.CanCollide, p.CanQuery, p.CanTouch = false, false, false
		p.Parent = model
		return p
	end
	local function joint(name, a, b, c0, c1)
		local m = Instance.new("Motor6D")
		m.Name = name
		m.Part0, m.Part1 = a, b
		m.C0, m.C1 = CFrame.new(c0 * s), CFrame.new(c1 * s)
		m.Parent = b
		return m
	end
	local c = o.Colors or {}
	local hrp = part("HumanoidRootPart", Vector3.new(2, 2, 1))
	hrp.Transparency = 1
	hrp.Anchored = true
	local torso = part("Torso", Vector3.new(2, 2, 1), c.Torso)
	joint("Root", hrp, torso, Vector3.zero, Vector3.zero)
	if not o.NoHead then
		local head = part("Head", Vector3.new(1.3, 1.3, 1.3), c.Head)
		joint("Neck", torso, head, Vector3.new(0, 1, 0), Vector3.new(0, -0.65, 0))
	end
	local ra, la = part("Right Arm", Vector3.new(1, 2, 1), c.Arms or c.RightArm), part("Left Arm", Vector3.new(1, 2, 1), c.Arms or c.LeftArm)
	joint("RightShoulder", torso, ra, Vector3.new(1, 0.75, 0), Vector3.new(-0.5, 0.75, 0))
	joint("LeftShoulder", torso, la, Vector3.new(-1, 0.75, 0), Vector3.new(0.5, 0.75, 0))
	if not o.NoLegs then
		local rl, ll = part("Right Leg", Vector3.new(1, 2, 1), c.Legs or c.RightLeg), part("Left Leg", Vector3.new(1, 2, 1), c.Legs or c.LeftLeg)
		joint("RightHip", torso, rl, Vector3.new(0.5, -1, 0), Vector3.new(0, 1, 0))
		joint("LeftHip", torso, ll, Vector3.new(-0.5, -1, 0), Vector3.new(0, 1, 0))
	end
	model.PrimaryPart = hrp
	model:SetAttribute("Scale", s)
	return model
end

-- pièce de costume soudée à un membre (offset dans le repère du membre)
function Kit.deco(limb, size, offset, color, o)
	o = o or {}
	local p = Instance.new(o.Wedge and "WedgePart" or "Part")
	p.Name = o.Name or "Deco"
	p.Size = size
	p.Color = color
	p.Material = o.Neon and Enum.Material.Neon or (o.Material or Enum.Material.Plastic)
	if not o.Neon and not o.Smooth and not o.Wedge then pcall(function() p.MaterialVariant = "Studs" end) end
	p.Transparency = o.Transparency or 0
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	p.Anchored, p.Massless = false, true
	p.CanCollide, p.CanQuery, p.CanTouch = false, false, false
	p.CastShadow = not o.Neon
	local w = Instance.new("Weld")
	w.Part0, w.Part1 = limb, p
	w.C0 = typeof(offset) == "Vector3" and CFrame.new(offset) or offset
	w.Parent = p
	p.Parent = o.Parent or limb.Parent
	return p, w
end

---------------------------------------------------------------- acteurs
local Actor = {}
Actor.__index = Actor
local R15_JOINTS = {
	Root = "LowerTorso", Waist = "UpperTorso", Neck = "Head",
	LeftShoulder = "LeftUpperArm", LeftElbow = "LeftLowerArm", LeftWrist = "LeftHand",
	RightShoulder = "RightUpperArm", RightElbow = "RightLowerArm", RightWrist = "RightHand",
	LeftHip = "LeftUpperLeg", LeftKnee = "LeftLowerLeg", LeftAnkle = "LeftFoot",
	RightHip = "RightUpperLeg", RightKnee = "RightLowerLeg", RightAnkle = "RightFoot",
}
-- retard des articulations du bout des membres : c'est ce qui donne le fouetté des bras et des jambes
local LAG = {LeftElbow = 0.06, RightElbow = 0.06, LeftWrist = 0.1, RightWrist = 0.1, Grip = 0.1, Neck = 0.04, LeftKnee = 0.04, RightKnee = 0.04, LeftAnkle = 0.07, RightAnkle = 0.07}
-- couche physique (acteurs avec a.phys = {freq, damp, weight}) : chaque articulation suit sa pose avec un ressort amorti,
-- ce qui donne l'élan, le dépassement et le retour d'un vrai corps (bouts des membres plus souples que le tronc)
local PFREQ = {Root = 15, Waist = 15, Neck = 12, RightShoulder = 14, LeftShoulder = 14, RightElbow = 17, LeftElbow = 17, RightWrist = 15, LeftWrist = 15, Grip = 15,
	RightHip = 20, LeftHip = 20, RightKnee = 22, LeftKnee = 22, RightAnkle = 22, LeftAnkle = 22, Jaw = 18, Tail = 7, Tail2 = 5.5, WingR = 8, WingL = 8}
local PDAMP = {RightHip = 0.85, LeftHip = 0.85, RightKnee = 0.85, LeftKnee = 0.85, RightAnkle = 0.85, LeftAnkle = 0.85, Root = 0.72, Tail = 0.38, Tail2 = 0.32, WingR = 0.42, WingL = 0.42}

-- ordre de départ des articulations dans un coup (la force part du sol et remonte jusqu'au poing / au pied)
local CHAIN = {Root = 0, RightHip = 0, LeftHip = 0, Waist = 1, RightKnee = 1.5, LeftKnee = 1.5, Neck = 1.5, RightShoulder = 2, LeftShoulder = 2,
	RightAnkle = 2.5, LeftAnkle = 2.5, RightElbow = 3, LeftElbow = 3, RightWrist = 4, LeftWrist = 4, Grip = 4}
local function addJoint(a, name, apply)
	a.joints[name] = apply
	a.val[name] = {0, 0, 0}
end

function Kit.actor(rig, name)
	local hrp = rig:FindFirstChild("HumanoidRootPart")
	local a = setmetatable({
		name = name or rig.Name, rig = rig, hrp = hrp, joints = {}, val = {}, tw = {}, btw = {},
		pos = Vector3.zero, yaw = 0, pitch = 0, roll = 0, lift = 0, air = 0, sink = 0, lunge = 0,
		idle = 1, alive = true, flinch = 0, look = nil, lookW = 0, gaitW = 0, phase = 0, scale = rig:GetAttribute("Scale") or 1,
	}, Actor)
	local hum = rig:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.AutomaticScalingEnabled = false
		hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
		pcall(function() hum.EvaluateStateMachine = false end)
		hum.PlatformStand = true
		local animator = hum:FindFirstChildOfClass("Animator")
		if animator then animator:Destroy() end
	end
	for _, d in rig:GetDescendants() do
		if d:IsA("BasePart") then
			d.CanCollide, d.CanTouch, d.CanQuery = false, false, false
			d.Massless = true
			d.Anchored = false
		elseif d:IsA("Script") or d:IsA("LocalScript") then
			d:Destroy()
		end
	end
	hrp.Anchored = true
	if rig:FindFirstChild("UpperTorso") then
		a.kind = "R15"
		for jointName, partName in R15_JOINTS do
			local part = rig:FindFirstChild(partName)
			local motor = part and part:FindFirstChild(jointName)
			if motor and motor:IsA("Motor6D") then
				local base = motor.C0
				addJoint(a, jointName, function(cf) motor.C0 = base * cf end)
			elseif motor and motor:IsA("AnimationConstraint") then
				pcall(function() motor.IsKinematic = true end)
				motor.Enabled = true
				addJoint(a, jointName, function(cf) motor.Transform = cf end)
			end
		end
		-- longueurs des jambes, mesurées sur l'avatar au repos
		local function y(partName, attName, fallback)
			local p = rig:FindFirstChild(partName)
			local att = p and p:FindFirstChild(attName)
			return att and hrp.CFrame:PointToObjectSpace(att.WorldPosition).Y or fallback
		end
		local foot = rig:FindFirstChild("RightFoot")
		local hip, knee, ankle = y("RightUpperLeg", "RightHipRigAttachment", -1), y("RightLowerLeg", "RightKneeRigAttachment", -1.95), y("RightFoot", "RightAnkleRigAttachment", -2.5)
		local bottom = foot and (hrp.CFrame:PointToObjectSpace(foot.Position).Y - foot.Size.Y / 2) or -3
		a.hipY, a.L1, a.L2, a.footH = -hip, hip - knee, knee - ankle, ankle - bottom
	else
		a.kind = "R6"
		for _, d in rig:GetDescendants() do
			if d:IsA("Motor6D") then
				local motor, base = d, d.C0
				addJoint(a, d.Name, function(cf) motor.C0 = base * cf end)
			end
		end
		local s = a.scale
		a.hipY, a.L1, a.L2, a.footH = 1 * s, 2 * s, 0, 0
		a.noLegs = rig:FindFirstChild("Right Leg") == nil
	end
	a.stand = a.hipY + a.L1 + a.L2 + a.footH
	table.insert(Kit.actors, a)
	return a
end

-- articulation supplémentaire pilotée comme les autres (arme dans la main, cape...) : weld.C0 = base * rotation
function Actor:addWeldJoint(name, weld)
	local base = weld.C0
	addJoint(self, name, function(cf) weld.C0 = base * cf end)
	self.bases = self.bases or {}
	self.bases[name] = {weld = weld, set = function(b) base = b end, get = function() return base end}
end

-- va vers une pose en `dur` secondes. pose = {Articulation = {x, y, z}}. Les articulations absentes reviennent à zéro,
-- sauf avec o.only (pose partielle). o.lag = false coupe le retard des extrémités.
function Actor:to(pose, dur, ease, o)
	o = o or {}
	dur = max(dur or 0, 0)
	local e = E(ease)
	local now = Kit.time
	local function set(name, v)
		local cur = self.val[name]
		if not cur then return end
		local target = {v[1] or 0, v[2] or 0, v[3] or 0}
		if dur <= 0 then
			self.val[name], self.tw[name] = target, nil
			if self.springs then self.springs[name] = nil end -- pose posée d'un coup : pas d'élan parasite
		else
			local lag = (o.lag == false) and 0 or (LAG[name] or 0) * min(1, dur / 0.3)
			if o.chain then lag = (CHAIN[name] or 1) * o.chain end -- chaîne cinétique : hanches, puis buste, épaule, coude, poignet
			self.tw[name] = {from = {cur[1], cur[2], cur[3]}, to = target, t0 = now + lag, dur = dur, ease = e}
		end
	end
	if o.only then
		for name, v in pose do set(name, v) end
	else
		for name in self.joints do
			if not (o.keep and o.keep[name]) then set(name, pose[name] or {0, 0, 0}) end
		end
	end
end

-- paramètres du corps entier : pitch (bascule avant < 0), roll, lift, yaw, air (0 = pieds au sol, 1 = en l'air), sink
function Actor:body(values, dur, ease)
	for key, target in values do
		if dur and dur > 0 then
			self.btw[key] = {from = self[key], to = target, t0 = Kit.time, dur = dur, ease = E(ease)}
		else
			self[key], self.btw[key] = target, nil
		end
	end
end

-- déplacement des pieds vers `target`. o.arc = hauteur du saut (parabole), o.face = se tourne vers la destination
function Actor:move(target, dur, ease, o)
	o = o or {}
	self.btw.pos = {from = self.pos, to = target, t0 = Kit.time, dur = max(dur, 1e-3), ease = E(ease or "linear"), arc = o.arc}
	if o.face then self:face(target, min(dur, o.faceTime or 0.25)) end
end
function Kit.yawTo(from, to)
	local d = to - from
	return math.atan2(-d.X, -d.Z)
end
local function nearestAngle(target, current)
	return current + ((target - current + math.pi) % TAU - math.pi)
end
function Actor:face(point, dur, ease)
	local p = typeof(point) == "Vector3" and point or point.pos
	if (p - self.pos).Magnitude < 0.05 then return end
	self:body({yaw = nearestAngle(Kit.yawTo(self.pos, p), self.yaw)}, dur or 0.2, ease)
end
function Actor:place(pos, yawOrPoint)
	self.pos, self.btw.pos = pos, nil
	self.lastP, self.vel, self.prevVel, self.accS = nil, nil, nil, nil -- téléporté : pas d'inertie
	if typeof(yawOrPoint) == "Vector3" then self.yaw = Kit.yawTo(pos, yawOrPoint) elseif yawOrPoint then self.yaw = yawOrPoint end
	self.btw.yaw = nil
end
-- point devant l'acteur (dans son repère) : forward, right, up
function Actor:point(forward, right, up)
	local cf = CFrame.new(self.pos) * CFrame.Angles(0, self.yaw, 0)
	return (cf * CFrame.new(right or 0, up or 0, -(forward or 0))).Position
end
function Actor:part(name) return self.rig:FindFirstChild(name) end
-- centre du corps dans le monde (pour viser avec la caméra ou un effet)
function Actor:center(up) return self.hrp.Position + Vector3.new(0, up or 0, 0) end

-- allure : Kit.Gaits[name] = {stride = distance d'un cycle complet, fn = function(phase, actor) -> pose partielle}
Kit.Gaits = {}
function Actor:gait(name, blend, onStep)
	local g = name and (type(name) == "table" and name or Kit.Gaits[name]) or nil
	if g then
		self.gaitDef, self.onStep = g, onStep
		self.btw.gaitW = {from = self.gaitW, to = 1, t0 = Kit.time, dur = blend or 0.15, ease = E("inOut")}
	else
		self.btw.gaitW = {from = self.gaitW, to = 0, t0 = Kit.time, dur = blend or 0.15, ease = E("inOut")}
	end
end

-- secousse quand il encaisse un coup
function Actor:hit(amount)
	amount = amount or 1
	if not self.phys then self.flinch = max(self.flinch, amount) return end
	-- acteur physique : le coup pousse le buste et la tête en arrière (coup du lapin), les bras partent, puis le corps revient
	local p = amount / (self.phys.weight or 1) ^ 0.5
	local R = math.random
	local upper = self.kind == "R15" and "Waist" or "Root"
	self:kick(upper, {(200 + R() * 120) * p, (R() - 0.5) * 220 * p, (R() - 0.5) * 200 * p})
	self:kick("Neck", {(260 + R() * 120) * p, (R() - 0.5) * 240 * p, (R() - 0.5) * 220 * p})
	self:kick("RightShoulder", {-160 * p, 0, 140 * p})
	self:kick("LeftShoulder", {-160 * p, 0, -140 * p})
	self:kick("Jaw", {-260 * p, 0, 0})
	self:kick("Tail", {0, (R() - 0.5) * 300 * p, 0})
	self.bobV = (self.bobV or 0) - 2.5 * p * self.scale
	self.flinch = max(self.flinch, amount * 0.3)
end
-- impulsion sur une articulation (degrés / seconde) : elle part, dépasse et revient d'elle-même
function Actor:kick(name, v)
	if name == "Neck" and self.neckState then
		local s = self.neckState
		s[4] += v[1] or 0 s[5] += v[2] or 0 s[6] += v[3] or 0
		return
	end
	local s = self.springs and self.springs[name]
	if s then s[4] += v[1] or 0 s[5] += v[2] or 0 s[6] += v[3] or 0 end
end
-- la tête (et un peu le buste) suit une cible : acteur, Vector3 ou nil
function Actor:watch(target, weight) self.look = target self.lookTo = weight or (target and 1 or 0) end

function Actor:setVisible(alpha)
	self.alpha = alpha
	for _, d in self.rig:GetDescendants() do
		if d:IsA("BasePart") and d ~= self.hrp then
			if d:GetAttribute("T0") == nil then d:SetAttribute("T0", d.Transparency) end
			local t0 = d:GetAttribute("T0")
			d.Transparency = t0 >= 1 and 1 or (1 - (1 - t0) * alpha)
		elseif d:IsA("Decal") then
			d.Transparency = 1 - alpha
		end
	end
end
function Actor:fade(alpha, dur)
	local from = self.alpha or 1
	Kit.tween(dur or 0.3, function(u) self:setVisible(from + (alpha - from) * u) end)
end
function Actor:destroy()
	self.alive = false
	local i = table.find(Kit.actors, self)
	if i then table.remove(Kit.actors, i) end
	self.rig:Destroy()
end

local function sample(tw, now)
	local u = clamp((now - tw.t0) / tw.dur, 0, 1)
	return tw.ease(u), u
end

local function stepActor(a, dt, now)
	-- 1. interpolations des articulations
	for name, tw in a.tw do
		local e, u = sample(tw, now)
		local v = a.val[name]
		v[1] = tw.from[1] + (tw.to[1] - tw.from[1]) * e
		v[2] = tw.from[2] + (tw.to[2] - tw.from[2]) * e
		v[3] = tw.from[3] + (tw.to[3] - tw.from[3]) * e
		if u >= 1 then a.tw[name] = nil end
	end
	-- 2. corps
	local before = a.pos
	for key, tw in a.btw do
		local e, u = sample(tw, now)
		if key == "pos" then
			local p = tw.from:Lerp(tw.to, e)
			if tw.arc then p += Vector3.new(0, tw.arc * 4 * u * (1 - u), 0) end
			a.pos = p
		else
			a[key] = tw.from + (tw.to - tw.from) * e
		end
		if u >= 1 then a.btw[key] = nil end
	end
	local moved = Vector3.new(a.pos.X - before.X, 0, a.pos.Z - before.Z).Magnitude
	a.speed = dt > 0 and moved / dt or 0
	-- 3. pose finale = pose courante, mélangée à l'allure, plus les petits mouvements de vie
	local out = {}
	for name, v in a.val do out[name] = {v[1], v[2], v[3]} end
	local g = a.gaitDef
	if g and a.gaitW > 0.001 then
		local previous = a.phase
		a.phase += moved / (g.stride * a.scale) * TAU
		if g.idleRate then a.phase += dt * g.idleRate end -- allures qui bougent même sur place (flottement)
		local stepped = math.floor(a.phase / math.pi) ~= math.floor(previous / math.pi)
		if stepped and a.phys and a.air < 0.5 and moved > 0 then -- le pied frappe le sol : le corps s'enfonce un peu puis remonte
			a.bobV = (a.bobV or 0) - (1.2 + min(a.speed / a.scale, 30) * 0.09) * a.scale * (a.phys.weight or 1) ^ 0.5
		end
		if a.onStep and stepped then a.onStep(math.floor(a.phase / math.pi) % 2) end
		local w = a.gaitW
		local mask = a.gaitMask -- articulations que l'allure ne touche pas (le bras qui tient l'arme, par exemple)
		for name, v in g.fn(a.phase, a) do
			local o = out[name]
			local m = mask and mask[name]
			if o and m ~= true then
				local w = w * (1 - (type(m) == "number" and m or 0)) -- masque partiel : de 1 (pose seule) à 0 (allure seule)
				o[1] += ((v[1] or 0) - o[1]) * w
				o[2] += ((v[2] or 0) - o[2]) * w
				o[3] += ((v[3] or 0) - o[3]) * w
			end
		end
	end
	local t = now + (a.seed or 0)
	if a.idle > 0 then -- respiration, poids qui passe d'un pied à l'autre
		local i = a.idle
		local breath = sin(t * 2.1)
		if out.Waist then out.Waist[1] += breath * 1.3 * i out.Waist[3] += sin(t * 0.9) * 0.8 * i end
		if out.Root and a.kind == "R6" then out.Root[1] += breath * 1.0 * i out.Root[3] += sin(t * 0.9) * 0.8 * i end
		if out.Neck then out.Neck[1] += sin(t * 2.1 - 0.6) * 0.9 * i out.Neck[2] += sin(t * 0.7) * 1.5 * i end
		if out.RightShoulder then out.RightShoulder[3] += breath * 0.9 * i out.RightShoulder[1] += sin(t * 1.3) * 0.8 * i end
		if out.LeftShoulder then out.LeftShoulder[3] -= breath * 0.9 * i out.LeftShoulder[1] += sin(t * 1.3 + 1) * 0.8 * i end
	end
	if a.phys and a.idle > 0 then -- micro-mouvements irréguliers (bruit, pas des sinus) : le poids qui glisse, le regard qui vit
		local i, n, sd = a.idle, math.noise, a.seed or 0
		local up = out.Waist or out.Root
		if up then up[2] += n(t * 0.31, sd, 1) * 5 * i up[3] += n(t * 0.27, sd, 2) * 3 * i up[1] += n(t * 0.4, sd, 3) * 2 * i end
		if out.RightShoulder then out.RightShoulder[1] += n(t * 0.5, sd, 4) * 3 * i end
		if out.LeftShoulder then out.LeftShoulder[1] += n(t * 0.5, sd, 5) * 3 * i end
		if out.Neck then out.Neck[2] += n(t * 0.6, sd, 6) * 6 * i out.Neck[1] += n(t * 0.5, sd, 7) * 3 * i end
	end
	-- rebond de combattant en garde (a.bounceTo) : il fléchit les genoux en rythme, le buste ondule, les poings bougent ;
	-- souffle court quand il est épuisé (a.heaveTo) : le buste et les épaules se soulèvent vite
	if a.phys then
		a.bounceW = (a.bounceW or 0) + ((a.bounceTo or 0) - (a.bounceW or 0)) * min(1, dt * 4)
		a.heaveW = (a.heaveW or 0) + ((a.heaveTo or 0) - (a.heaveW or 0)) * min(1, dt * 2)
		local bw = a.bounceW
		if bw > 0.01 and a.air < 0.5 and (a.speed or 0) < 3 * a.scale then
			local ph = t * TAU * 1.6
			local dip = (1 - cos(ph)) * 0.5
			if out.RightKnee then out.RightKnee[1] -= 10 * dip * bw end
			if out.LeftKnee then out.LeftKnee[1] -= 10 * dip * bw end
			if out.RightHip then out.RightHip[1] += 5 * dip * bw end
			if out.LeftHip then out.LeftHip[1] += 5 * dip * bw end
			local sway = sin(ph * 0.5)
			local up = out.Waist or out.Root
			if up then up[3] += sway * 2.5 * bw up[2] += sway * 3 * bw up[1] -= dip * 2 * bw end
			if out.RightShoulder then out.RightShoulder[1] += sin(ph + 0.6) * 3 * bw end
			if out.LeftShoulder then out.LeftShoulder[1] += sin(ph + 2.2) * 3 * bw end
			if out.Neck then out.Neck[1] += dip * 2 * bw end
		end
		local hv = a.heaveW
		if hv > 0.01 then
			local br = sin(t * 3.4)
			local inh = br * 0.5 + 0.5
			if out.Waist then out.Waist[1] += br * 4 * hv end
			if out.RightShoulder then out.RightShoulder[3] += inh * 5 * hv end
			if out.LeftShoulder then out.LeftShoulder[3] -= inh * 5 * hv end
			if out.Neck then out.Neck[1] += br * 3 * hv end
		end
	end
	-- inertie : quand il démarre ou freine d'un coup, le haut du corps est en retard puis rattrape
	if a.phys then
		local flat = Vector3.new(a.pos.X, 0, a.pos.Z)
		if a.lastP and dt > 1e-4 then
			local vel = (flat - a.lastP) / dt
			if vel.Magnitude > 400 then vel = vel.Unit * 400 end
			a.vel = a.vel and a.vel:Lerp(vel, min(1, dt * 12)) or vel
			local acc = (a.vel - (a.prevVel or a.vel)) / dt
			a.prevVel = a.vel
			a.accS = (a.accS or Vector3.zero):Lerp(acc, min(1, dt * 8))
			local cf = CFrame.Angles(0, a.yaw, 0)
			local k = 0.012 / a.scale
			local fwd = clamp(a.accS:Dot(cf.LookVector) * k, -1, 1)
			local side = clamp(a.accS:Dot(cf.RightVector) * k, -1, 1)
			local up = out.Waist or out.Root
			if up then up[1] += fwd * 14 up[3] += side * 9 end
			if out.Neck then out.Neck[1] -= fwd * 6 end
		end
		a.lastP = flat
	end
	if a.flinch > 0.01 then -- encaisse un coup : tout le haut du corps vibre puis se calme
		local f = a.flinch
		local j = sin(now * 70) * f
		local upper = out.Waist or out.Root
		if upper then upper[1] += 7 * f + j * 3 upper[3] += j * 4 end
		if out.Neck then out.Neck[1] -= 9 * f out.Neck[3] += j * 5 end
		a.flinch *= math.exp(-dt * 7)
	end
	-- regard
	a.lookW += ((a.lookTo or 0) - a.lookW) * min(1, dt * 7)
	if a.look and a.lookW > 0.01 and out.Neck then
		local p = typeof(a.look) == "Vector3" and a.look or (a.look.hrp and a.look.hrp.Position + Vector3.new(0, a.look.stand * 0.25, 0)) or nil
		if p then
			local waistYaw = out.Waist and out.Waist[2] or (a.kind == "R6" and out.Root and out.Root[2]) or 0
			local l = (CFrame.new(a.hrp.Position + Vector3.new(0, a.stand * 0.45, 0)) * CFrame.Angles(0, a.yaw + rad(waistYaw), 0)):PointToObjectSpace(p)
			local yaw = clamp(math.deg(math.atan2(-l.X, -l.Z)), -75, 75)
			local pitch = clamp(math.deg(math.atan2(l.Y, Vector3.new(l.X, 0, l.Z).Magnitude)), -40, 45)
			out.Neck[2] += (yaw * 0.8 - out.Neck[2]) * a.lookW
			out.Neck[1] += (pitch * 0.8 - out.Neck[1]) * a.lookW
		end
	end
	-- tête amortie (a.neckSmooth = raideur du ressort) : elle rejoint sa consigne en souplesse, sans à-coups
	if a.neckSmooth and out.Neck then
		local n, s = out.Neck, a.neckState
		if not s then
			s = {n[1], n[2], n[3], 0, 0, 0}
			a.neckState = s
		end
		local w = a.neckSmooth
		local steps = math.clamp(math.ceil(dt * 120), 1, 240)
		local h = dt / steps
		for _ = 1, steps do
			for i = 1, 3 do
				local acc = (n[i] - s[i]) * w * w - s[i + 3] * 1.7 * w
				s[i + 3] += acc * h
				s[i] += s[i + 3] * h
			end
		end
		n[1], n[2], n[3] = s[1], s[2], s[3]
	end
	-- ressorts des articulations (acteurs physiques)
	local ph = a.phys
	if ph then
		local st = a.springs
		if not st or Kit.fast() then st = {} a.springs = st end
		local steps = clamp(math.ceil(dt * 240), 1, 120)
		local h = dt / steps
		local fk, dk = ph.freq or 1, ph.damp
		for name, v in out do
			if not (name == "Neck" and a.neckSmooth) then
				local s = st[name]
				if not s then
					s = {v[1], v[2], v[3], 0, 0, 0}
					st[name] = s
				elseif dt > 0 then
					local w = (PFREQ[name] or 14) * fk
					local z = PDAMP[name] or dk or 0.62
					local ww, zz = w * w, 2 * z * w
					for _ = 1, steps do
						for i = 1, 3 do
							s[i + 3] += ((v[i] - s[i]) * ww - s[i + 3] * zz) * h
							s[i] += s[i + 3] * h
						end
					end
				end
				v[1], v[2], v[3] = s[1], s[2], s[3]
			end
		end
		-- rebond vertical (pas, coups)
		local bw = 13 / (ph.weight or 1) ^ 0.25
		local steps2 = clamp(math.ceil(dt * 240), 1, 120)
		local h2 = dt / steps2
		a.bob, a.bobV = a.bob or 0, a.bobV or 0
		for _ = 1, steps2 do
			a.bobV += (-a.bob * bw * bw - a.bobV * 2 * 0.5 * bw) * h2
			a.bob += a.bobV * h2
		end
		if Kit.fast() then a.bob, a.bobV = 0, 0 end
	end
	-- 4. applique
	for name, apply in a.joints do
		local v = out[name]
		apply(CFrame.Angles(rad(v[1]), rad(v[2]), rad(v[3])))
	end
	-- 5. hauteur du corps : la jambe la plus basse touche le sol
	local height = a.stand
	if not a.noLegs and a.air < 1 then
		-- inclinaison du bassin : bascule du corps entier + articulation Root (les jambes en dépendent)
		local pitch = a.pitch + (out.Root and rad(out.Root[1]) or 0)
		local function drop(hip, knee)
			if not hip then return 0 end
			local hx = rad(hip[1]) + pitch
			local kx = knee and rad(knee[1]) or 0
			return (a.L1 * cos(hx) + a.L2 * cos(hx + kx)) * cos(rad(hip[3])) + a.footH
		end
		local d = max(drop(out.RightHip, out.RightKnee), drop(out.LeftHip, out.LeftKnee), a.stand * 0.2)
		local solved = d + a.hipY * cos(pitch)
		height = solved + (a.stand - solved) * a.air
	end
	-- atterrissage : les jambes amortissent, le corps s'écrase un peu puis remonte
	if a.phys then
		if (a.prevAir or 0) >= 0.5 and a.air < 0.5 then
			a.bobV = (a.bobV or 0) - 7 * a.scale * (a.phys.weight or 1) ^ 0.5
			local up = a.kind == "R15" and "Waist" or "Root"
			a:kick(up, {-160, 0, 0})
			a:kick("Neck", {-120, 0, 0})
		end
		a.prevAir = a.air
	end
	local y = a.pos.Y + height + a.lift - a.sink + (a.bob or 0) * (1 - a.air)
	local lx, lz = 0, 0
	if a.lunge ~= 0 then -- élan du corps vers l'avant (ou recul) sans déplacer les pieds dans la scène
		lx, lz = -sin(a.yaw) * a.lunge * a.scale, -cos(a.yaw) * a.lunge * a.scale
	end
	a.hrp.CFrame = CFrame.new(a.pos.X + lx, y, a.pos.Z + lz) * CFrame.Angles(0, a.yaw, 0) * CFrame.Angles(a.pitch, 0, a.roll)
end

-- silhouette lumineuse laissée derrière un acteur (dash)
function Kit.ghost(a, color, life, transparency)
	if Kit.fast() then return end
	local folder = Instance.new("Model")
	folder.Name = "Ghost"
	for _, d in a.rig:GetDescendants() do
		if d:IsA("BasePart") and d.Transparency < 0.9 and d.Size.Magnitude > 0.7 then
			local c = d:Clone()
			c:ClearAllChildren()
			c.Anchored, c.CanCollide, c.CanQuery, c.CanTouch, c.CastShadow = true, false, false, false, false
			c.Material, c.Color, c.Transparency = Enum.Material.Neon, color, transparency or 0.45
			if c:IsA("MeshPart") then c.TextureID = "" end
			c.Parent = folder
			TweenService:Create(c, TweenInfo.new(life or 0.35), {Transparency = 1}):Play()
		end
	end
	folder.Parent = Kit.scene
	Debris:AddItem(folder, (life or 0.35) + 0.1)
end

---------------------------------------------------------------- caméra
function Kit.look(from, to, fov, roll)
	return CFrame.lookAt(from, to) * CFrame.Angles(0, 0, rad(roll or 0)), fov or 55
end
-- nouveau plan : fn(t) -> CFrame, fov (t = secondes de film depuis le début du plan). blend > 0 = raccord en mouvement au lieu d'une coupe
function Kit.cam(fn, blend)
	if blend and blend > 0 and camLast then camBlend = {from = camLast, fov = camera.FieldOfView, t0 = Kit.time, dur = blend} else camBlend = nil end
	camFn, camT0 = fn, Kit.time
end
function Kit.shake(amount) shakeAmp = max(shakeAmp, amount) end
Kit.handheld = 0 -- caméra portée à l'épaule (radians) : la caméra respire un peu, comme filmée par un vrai cadreur
function Kit.punch(fov) fovKick = fov end -- coup de zoom bref
-- la caméra ne traverse pas les troncs : si un obstacle est entre le sujet et elle, elle se rapproche
Kit.camSubject = nil
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Include

---------------------------------------------------------------- interface
local function buildGui(playerGui)
	gui = Instance.new("ScreenGui")
	gui.Name = "FightFilmGui"
	gui.IgnoreGuiInset, gui.ResetOnSpawn, gui.DisplayOrder = true, false, 200
	local function frame(props)
		local f = Instance.new("Frame")
		f.BorderSizePixel = 0
		f.BackgroundColor3 = Color3.new(0, 0, 0)
		for k, v in props do f[k] = v end
		f.Parent = gui
		return f
	end
	bars = {frame({Size = UDim2.new(1, 0, 0.11, 0), Position = UDim2.fromScale(0, -0.11), ZIndex = 5}), frame({Size = UDim2.new(1, 0, 0.11, 0), Position = UDim2.fromScale(0, 1), ZIndex = 5})}
	flash = frame({Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ZIndex = 8})
	fade = frame({Size = UDim2.fromScale(1, 1), BackgroundTransparency = 0, ZIndex = 10})
	subtitle = Instance.new("TextLabel")
	subtitle.BackgroundTransparency = 1
	subtitle.AnchorPoint = Vector2.new(0.5, 1)
	subtitle.Position, subtitle.Size = UDim2.fromScale(0.5, 0.86), UDim2.fromScale(0.8, 0.06)
	subtitle.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	subtitle.TextScaled, subtitle.TextColor3, subtitle.Text, subtitle.ZIndex = true, Color3.new(1, 1, 1), "", 6
	subtitle:SetAttribute("No3D", true)
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 4
	stroke.Parent = subtitle
	subtitle.Parent = gui
	gui.Parent = playerGui
end
function Kit.bars(on, t)
	TweenService:Create(bars[1], TweenInfo.new(t or 0.6, Enum.EasingStyle.Quad), {Position = UDim2.fromScale(0, on and 0 or -0.11)}):Play()
	TweenService:Create(bars[2], TweenInfo.new(t or 0.6, Enum.EasingStyle.Quad), {Position = UDim2.fromScale(0, on and 0.89 or 1)}):Play()
end
function Kit.fade(alpha, t) -- alpha : 0 = noir complet, 1 = image
	if t and t > 0 and not Kit.fast() then TweenService:Create(fade, TweenInfo.new(t), {BackgroundTransparency = alpha}):Play() else fade.BackgroundTransparency = alpha end
end
function Kit.flash(t, color, strength)
	if Kit.fast() then return end
	flash.BackgroundColor3 = color or Color3.new(1, 1, 1)
	flash.BackgroundTransparency = 1 - (strength or 0.85)
	TweenService:Create(flash, TweenInfo.new(t or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
end
local sayId = 0
function Kit.say(text, t)
	sayId += 1
	local id = sayId
	subtitle.Text = text
	Kit.delay(t or 2.5, function() if sayId == id then subtitle.Text = "" end end)
end
-- traits de vitesse plein écran pendant `t` secondes
function Kit.speedLines(t, strength)
	if Kit.fast() then return end
	local holder = Instance.new("Frame")
	holder.BackgroundTransparency = 1
	holder.Size = UDim2.fromScale(1, 1)
	holder.ZIndex = 4
	holder.Parent = gui
	local rng = Random.new()
	for i = 1, 26 do
		local a = rng:NextNumber(0, TAU)
		local line = Instance.new("Frame")
		line.BorderSizePixel = 0
		line.BackgroundColor3 = Color3.new(1, 1, 1)
		line.BackgroundTransparency = 1 - (strength or 0.5) * rng:NextNumber(0.4, 1)
		line.AnchorPoint = Vector2.new(0, 0.5)
		local r = rng:NextNumber(0.3, 0.48)
		line.Position = UDim2.fromScale(0.5 + cos(a) * r, 0.5 + sin(a) * r * 1.2)
		line.Size = UDim2.new(rng:NextNumber(0.12, 0.34), 0, 0, rng:NextInteger(2, 5))
		line.Rotation = math.deg(a)
		line.Parent = holder
		TweenService:Create(line, TweenInfo.new(t), {BackgroundTransparency = 1, Position = UDim2.fromScale(0.5 + cos(a) * (r + 0.3), 0.5 + sin(a) * (r + 0.3) * 1.2)}):Play()
	end
	Debris:AddItem(holder, t + 0.1)
end

---------------------------------------------------------------- début et fin
local saved = {}
function Kit.begin(scene, blockers)
	local player = Players.LocalPlayer
	Kit.time, Kit.scale, Kit.running, Kit.paused = 0, 1, true, false
	Kit.handheld = 0
	Kit.scene = scene
	table.clear(Kit.actors) table.clear(tweens)
	camFn, camBlend, camLast, shakeAmp, fovKick = nil, nil, nil, 0, 0
	camera = workspace.CurrentCamera
	saved.camType, saved.fov, saved.guis = camera.CameraType, camera.FieldOfView, {}
	for _, g in player.PlayerGui:GetChildren() do
		if g:IsA("ScreenGui") and g.Enabled then saved.guis[g] = true g.Enabled = false end
	end
	buildGui(player.PlayerGui)
	pcall(function() game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false) end)
	pcall(function() game:GetService("StarterGui"):SetCore("TopbarEnabled", false) end)
	game:GetService("ContextActionService"):BindActionAtPriority("FightFilmFreeze", function() return Enum.ContextActionResult.Sink end, false, 10000, table.unpack(Enum.PlayerActions:GetEnumItems()))
	rayParams.FilterDescendantsInstances = blockers or {}
	camera.CameraType = Enum.CameraType.Scriptable
	local lastClock = os.clock()
	local lastSweep = 0
	connection = RunService.RenderStepped:Connect(function()
		local real = os.clock()
		if real - lastSweep > 0.25 then -- une interface allumée par le jeu en cours de film (monture, événement...) ne doit pas passer devant l'image
			lastSweep = real
			for _, g in player.PlayerGui:GetChildren() do
				if g:IsA("ScreenGui") and g.Enabled and g ~= gui then saved.guis[g] = true g.Enabled = false end
			end
		end
		local dt = min(real - lastClock, 0.1)
		lastClock = real
		local scale = Kit.scale
		if real < stopUntil then scale *= stopScale end
		if Kit.paused then scale = 0 end
		if Kit.ffTo then -- tests : avance rapide (x5) jusqu'au temps demandé, puis pause
			if Kit.time < Kit.ffTo then scale = 5 else Kit.ffTo, Kit.paused, scale = nil, true, 0 end
		end
		do
			local fdt = dt * scale
			Kit.time += fdt
			local now = Kit.time
			for i = #tweens, 1, -1 do
				local tw = tweens[i]
				local u = clamp((now - tw.t0) / tw.dur, 0, 1)
				local ok, err = pcall(tw.fn, tw.ease(u), u)
				if not ok then warn("[FightFilm] tween : " .. tostring(err)) u = 1 end
				if u >= 1 then
					table.remove(tweens, i)
					if tw.done then pcall(tw.done) end
				end
			end
			for _, a in Kit.actors do
				if a.alive then stepActor(a, fdt, now) end
			end
		end
		if camera.CameraType ~= Enum.CameraType.Scriptable then camera.CameraType = Enum.CameraType.Scriptable end
		if camFn then
			local cf, fov = camFn(Kit.time - camT0)
			if camBlend then
				local u = clamp((Kit.time - camBlend.t0) / camBlend.dur, 0, 1)
				local e = u * u * (3 - 2 * u)
				cf = camBlend.from:Lerp(cf, e)
				fov = camBlend.fov + ((fov or 55) - camBlend.fov) * e
				if u >= 1 then camBlend = nil end
			end
			camLast = cf
			if Kit.camSubject then
				local subject = Kit.camSubject()
				local hit = subject and workspace:Raycast(subject, cf.Position - subject, rayParams)
				if hit then cf = cf.Rotation + (hit.Position + (subject - cf.Position).Unit * 1.2) end
			end
			if Kit.handheld > 0 then
				local t, hh = os.clock(), Kit.handheld
				cf *= CFrame.Angles(math.noise(t * 0.55, 11) * hh, math.noise(t * 0.45, 21) * hh, math.noise(t * 0.35, 31) * hh * 0.6)
			end
			if shakeAmp > 0.002 then
				local t = os.clock()
				cf *= CFrame.new(math.noise(t * 31, 1) * shakeAmp, math.noise(t * 29, 7) * shakeAmp, 0) * CFrame.Angles(math.noise(t * 27, 5) * shakeAmp * 0.03, math.noise(t * 25, 9) * shakeAmp * 0.03, math.noise(t * 23, 3) * shakeAmp * 0.05)
				shakeAmp *= math.exp(-dt * 6)
			end
			fovKick *= math.exp(-dt * 9)
			camera.CFrame = cf
			camera.FieldOfView = (fov or 55) + fovKick
		end
	end)
end

function Kit.finish()
	Kit.running = false
	if connection then connection:Disconnect() connection = nil end
	for i = #Kit.actors, 1, -1 do Kit.actors[i].alive = false end
	table.clear(Kit.actors) table.clear(tweens)
	camFn, Kit.camSubject, Kit.ffTo, Kit.paused = nil, nil, nil, false
	Kit.handheld = 0
	local player = Players.LocalPlayer
	for g in saved.guis or {} do if g.Parent then g.Enabled = true end end
	pcall(function() game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, true) end)
	pcall(function() game:GetService("StarterGui"):SetCore("TopbarEnabled", true) end)
	game:GetService("ContextActionService"):UnbindAction("FightFilmFreeze")
	if camera then
		camera.CameraType = (saved.camType == nil or saved.camType == Enum.CameraType.Scriptable) and Enum.CameraType.Custom or saved.camType
		camera.FieldOfView = saved.fov or 70
	end
	if gui then gui:Destroy() gui = nil end
	Kit.scene = nil
end

return Kit

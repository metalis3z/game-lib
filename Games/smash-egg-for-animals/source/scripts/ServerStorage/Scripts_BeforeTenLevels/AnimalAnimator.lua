-- AnimalAnimator : animations calculées pour les animaux en mesh à os (dossier AnimalKit.Models).
-- Aucune animation téléversée : le squelette de chaque modèle est lu au départ (pattes, ailes, queue, cou, nageoires)
-- À utiliser côté client (LocalScript) : la pose des os n'est pas répliquée du serveur vers les joueurs.
-- et les os sont bougés à chaque image. États : "Idle", "Walk", "Fly", "Swim", ou "Move" (le déplacement naturel du modèle).
--
--   local Animator = require(ReplicatedStorage.AnimalKit.AnimalAnimator)
--   local model, anim = Animator.spawn("Wolf", CFrame.new(0, 5, 0), {height = 4})  -- copie, mise à l'échelle, animation
--   anim:play("Walk")        -- change d'état en fondu
--   anim.speed = 1.5         -- cadence
--   anim:destroy()
--   Animator.new(model)      -- pour un modèle déjà placé
local RunService = game:GetService("RunService")

local M = {}
M.FADE = 0.25          -- durée du fondu entre deux états (s)
M.MaxDistance = 250    -- côté client : au-delà, l'animal n'est plus animé (studs)

local V = Vector3.new
local sin, cos, max, min, clamp, abs = math.sin, math.cos, math.max, math.min, math.clamp, math.abs
local TAU = math.pi * 2

-- déplacement naturel par modèle (les autres marchent) : "Fly" vole, "Swim" nage, "Slither" rampe, "Drift" flotte (tentacules)
local KIND = {}
for _, n in {"Tuna", "Trumpetfish", "Stingray", "Sailfish", "Pufferfish", "Hawkfish", "Cowfish", "Barracuda", "Archerfish", "Wrasse", "Whale",
	"Swordfish", "Surgeonfish", "Shark", "Seahorse", "RegalTang", "Plesiosaur", "Mosasaurus", "MoorishIdol", "Mandarinfish", "Megalodon",
	"Lionfish", "Leviathan", "Goldfish", "Wobbegong", "CoralGoby", "Butterflyfish", "Boxfish"} do KIND[n] = "Swim" end
for _, n in {"YiQi", "WingedImp", "Thunderbird", "StymphalianBird", "Simurgh", "Roc", "Quetzalcoatlus", "Pigeon", "Parrot", "Pterodactyl",
	"GiantPterodactyl", "Pteranodon", "Moth", "Dragonfly", "Owl", "Microraptor", "Garuda", "GargoyleBat", "FirePhoenix", "Caladrius", "Bat",
	"Argentavis", "Archaeopteryx", "Bugman", "Wyvern", "Dragon", "FireDragon", "FireDragonBaby", "RockCandyDragon", "Pegasus", "Griffin"} do KIND[n] = "Fly" end
for _, n in {"Snake", "Cobra", "TripleCobra", "Snail", "Hydra"} do KIND[n] = "Slither" end
for _, n in {"Kraken", "Jellyfish"} do KIND[n] = "Drift" end
M.Kinds = KIND

-- réglages de chaque état : amplitudes en radians, bob en fraction de la hauteur, rate en cycles par seconde (pour un animal de 5 studs)
local STATES = {
	-- sway / roll : le bassin et le dos ondulent avec les pas ; shift : report du poids d'une patte sur l'autre ; breathe : respiration ;
	-- look : la tête regarde autour d'elle ; ankle : le pied reste à plat ; flutter : oreilles, bras, nageoires qui frémissent ;
	-- lift : la queue se lève ; accent : petits gestes à l'arrêt (regarder, sauter, s'ébrouer, brouter...)
	Idle = {rate = 0.45, leg = 0.04, knee = 0, wing = 0.09, fold = 0.25, wave = 0.07, tail = 0.26, head = 0.2, nod = 0.07, bob = 0.02, tuck = 0, lean = 0, tent = 0.16,
		sway = 0, roll = 0, shift = 0.035, breathe = 0.035, look = 0.3, ankle = 0, flutter = 0.07, lift = 0, accent = 1},
	Walk = {rate = 1.8, leg = 0.68, knee = 0.6, wing = 0.08, fold = 0.25, wave = 0.07, tail = 0.28, head = 0.07, nod = 0.1, bob = 0.045, tuck = 0, lean = 0.04, tent = 0.24,
		sway = 0.07, roll = 0.05, breathe = 0.012, look = 0.06, ankle = 0.6, flutter = 0.14, lift = 0.16},
	Fly = {rate = 2.2, leg = 0.04, knee = 0, wing = 0.62, fold = 0, wave = 0.04, tail = 0.12, head = 0.04, nod = 0.05, bob = 0.05, tuck = 0.55, lean = 0.12, tent = 0.2,
		sway = 0.02, roll = 0.07, breathe = 0.01, look = 0.05, flutter = 0.2, lift = 0.05},
	Hover = {rate = 1.7, leg = 0.04, knee = 0, wing = 0.55, fold = 0, wave = 0.04, tail = 0.16, head = 0.16, nod = 0.04, bob = 0.045, tuck = 0.35, lean = 0, tent = 0.18,
		roll = 0.04, shift = 0.02, breathe = 0.02, look = 0.2, flutter = 0.12, accent = 1},
	Swim = {rate = 1.5, leg = 0, knee = 0, wing = 0.22, fold = 0, wave = 0.34, tail = 0, head = 0, nod = 0, bob = 0.012, tuck = 0, lean = 0, tent = 0.3,
		roll = 0.06, flutter = 0.18},
	Float = {rate = 0.9, leg = 0, knee = 0, wing = 0.2, fold = 0, wave = 0.24, tail = 0, head = 0, nod = 0, bob = 0.03, tuck = 0, lean = 0, tent = 0.24,
		roll = 0.03, shift = 0.03, flutter = 0.1, accent = 1},
	Slither = {rate = 1.2, leg = 0, knee = 0, wing = 0, fold = 0, wave = 0.32, tail = 0, head = 0, nod = 0, bob = 0, tuck = 0, lean = 0, tent = 0.2},
	Coil = {rate = 0.6, leg = 0, knee = 0, wing = 0, fold = 0, wave = 0.18, tail = 0, head = 0, nod = 0, bob = 0.008, tuck = 0, lean = 0, tent = 0.14,
		breathe = 0.02, accent = 1},
	Drift = {rate = 0.8, leg = 0, knee = 0, wing = 0, fold = 0, wave = 0, tail = 0, head = 0, nod = 0, bob = 0.03, tuck = 0, lean = 0, tent = 0.3},
	-- gardiens : course (grandes foulées, corps penché, queue levée) et bond (pattes repliées)
	Run = {rate = 2.7, leg = 0.85, knee = 0.75, wing = 0.12, fold = 0.2, wave = 0.07, tail = 0.22, head = 0.04, nod = 0.14, bob = 0.07, tuck = 0, lean = 0.1, tent = 0.3,
		sway = 0.09, roll = 0.06, breathe = 0.01, look = 0.02, ankle = 0.6, flutter = 0.2, lift = 0.28},
	Leap = {rate = 1.2, leg = 0.08, knee = 0, wing = 0.2, fold = 0.1, wave = 0.05, tail = 0.2, head = 0.05, nod = 0.03, bob = 0.01, tuck = 0.5, lean = 0.06, tent = 0.3,
		roll = 0.03, flutter = 0.2, lift = 0.2},
}
M.States = STATES
-- ce que "Idle" et "Move" veulent dire selon le déplacement naturel
local IDLE_OF = {Walk = "Idle", Fly = "Hover", Swim = "Float", Slither = "Coil", Drift = "Drift"}
local MOVE_OF = {Walk = "Walk", Fly = "Fly", Swim = "Swim", Slither = "Slither", Drift = "Drift"}

---------------------------------------------------------------- lecture du squelette
-- rend la description du squelette : pour chaque os animé son rôle, son côté, sa phase, ses poids
function M.analyze(mesh, kind)
	local list, byInst = {}, {}
	for _, b in mesh:GetDescendants() do
		if b:IsA("Bone") then
			b.Transform = CFrame.new()
			local rest = mesh.CFrame:ToObjectSpace(b.WorldCFrame)
			local node = {bone = b, pos = rest.Position, rot = rest.Rotation, inv = rest.Rotation:Inverse(), kids = {}, roles = {}}
			table.insert(list, node)
			byInst[b] = node
		end
	end
	local root
	for _, n in list do
		local p = byInst[n.bone.Parent]
		n.parent = p
		if p then table.insert(p.kids, n) elseif not root then root = n end
	end
	local rig = {nodes = list, root = root, kind = kind, driven = {}, legs = {}, wings = {}}
	if not root then return rig end
	local lo, hi = V(1, 1, 1) * math.huge, V(1, 1, 1) * -math.huge
	for _, n in list do lo, hi = lo:Min(n.pos), hi:Max(n.pos) end
	local height = max(mesh.Size.Y, 0.1)
	rig.height = height
	local eps = max(mesh.Size.X * 0.03, 0.04)
	local function axial(n) return abs(n.pos.X) < eps end
	local function drive(n) if not n.driven then n.driven = true table.insert(rig.driven, n) end end
	local function subtree(n, out)
		out = out or {}
		table.insert(out, n)
		for _, k in n.kids do subtree(k, out) end
		return out
	end
	drive(root)

	if kind == "Drift" then -- tout ondule depuis le haut : chaque os suit son parent avec un retard
		for _, n in list do
			if n ~= root then
				local depth, p = 0, n
				while p.parent do depth += 1 p = p.parent end
				local a = math.atan2(n.pos.Z - root.pos.Z, n.pos.X - root.pos.X)
				n.roles.tent = {depth = depth, dir = V(-sin(a), 0, cos(a)), seed = a}
				drive(n)
			end
		end
		return rig
	end

	-- membres : chaque sous-arbre qui part d'un os latéral accroché à un os de l'axe
	local limbs = {}
	for _, n in list do
		if n ~= root and not axial(n) and (n.parent == nil or axial(n.parent)) then
			local all = subtree(n)
			local tip, far = n, 0
			for _, k in all do
				local d = (k.pos - n.pos).Magnitude
				if d > far then tip, far = k, d end
			end
			-- la chaîne principale : de la racine du membre jusqu'à son bout
			local chain, k = {}, tip
			while k and k ~= n.parent do table.insert(chain, 1, k) k = k.parent end
			table.insert(limbs, {start = n, tip = tip, v = tip.pos - n.pos, len = far, all = all, chain = chain, side = n.pos.X >= 0 and 1 or -1})
		end
	end
	local swimmer = kind == "Swim" or kind == "Slither"
	local legRoots = {}
	for _, l in limbs do
		local down = l.len > 0 and -l.v.Y / l.len or 0
		local reachesGround = l.tip.pos.Y <= lo.Y + height * 0.16
		local lateral = l.len > 0 and abs(l.v.X) / l.len or 0
		if not swimmer and down > 0.2 and reachesGround then
			l.role = "leg"
			table.insert(rig.legs, l)
			table.insert(legRoots, l.start.pos.Z)
		else
			l.role = "wing" -- aile, bras ou nageoire : même mouvement, plus ou moins ample
			l.big = lateral > 0.5 and l.len > mesh.Size.X * 0.18
			table.insert(rig.wings, l)
		end
	end
	-- un marcheur sans patte trouvée (crabe, pattes sur les côtés) : ses membres qui descendent sont ses pattes,
	-- sauf la paire de devant s'il en a plus de quatre (les pinces)
	if kind == "Walk" and #rig.legs == 0 then
		local keep, frontZ = {}, math.huge
		for _, l in rig.wings do if l.v.Y <= l.len * 0.3 then frontZ = min(frontZ, l.start.pos.Z) end end
		local candidates = 0
		for _, l in rig.wings do if l.v.Y <= l.len * 0.3 then candidates += 1 end end
		for _, l in rig.wings do
			if l.v.Y <= l.len * 0.3 and not (candidates > 4 and l.start.pos.Z <= frontZ + 1e-3) then
				l.role, l.big = "leg", nil
				table.insert(rig.legs, l)
			else
				table.insert(keep, l)
			end
		end
		rig.wings = keep
	end
	for _, l in rig.legs do l.sweep = abs(l.v.X) > abs(l.v.Y) or (l.len < 1e-3 and abs(l.start.pos.X) > mesh.Size.X * 0.15) end -- patte couchée sur le côté : elle balaie d'avant en arrière
	-- pattes : avant ou arrière, puis une phase par patte (trot en diagonale, alternance pour deux pattes, vague pour six et plus)
	table.sort(rig.legs, function(a, b) if a.start.pos.Z ~= b.start.pos.Z then return a.start.pos.Z < b.start.pos.Z end return a.side < b.side end)
	local rows, lastZ = 0, nil
	for _, l in rig.legs do
		if not lastZ or l.start.pos.Z - lastZ > height * 0.08 then rows += 1 lastZ = l.start.pos.Z end
		l.row = rows
	end
	for _, l in rig.legs do
		l.phase = ((l.row % 2 == 1) == (l.side > 0)) and 0 or math.pi
		if rows > 2 then l.phase += l.row * 0.5 end
		for i, n in l.chain do
			n.roles.leg = {index = i, limb = l}
			drive(n)
		end
	end
	for _, l in rig.wings do
		for i, n in l.chain do
			n.roles.wing = {index = i, limb = l, count = #l.chain}
			drive(n)
		end
	end
	-- os des membres hors de la chaîne principale (doigts, plumes, oreilles, griffes...) : ils suivent avec un temps de retard
	for _, l in limbs do
		local inChain = {}
		for _, n in l.chain do inChain[n] = true end
		for _, n in l.all do
			if not inChain[n] then
				local depth, p = 0, n
				while p and p ~= l.start do depth += 1 p = p.parent end
				n.roles.follow = {limb = l, depth = depth}
				drive(n)
			end
		end
	end
	if kind == "Fly" then -- un animal volant : ses plus longs membres hors pattes sont ses ailes, quelle que soit leur direction
		local longest = 0
		for _, l in rig.wings do longest = max(longest, l.len) end
		for _, l in rig.wings do l.big = l.len >= longest * 0.6 end
	end
	rig.hasWings = false
	for _, l in rig.wings do if l.big then rig.hasWings = true end end

	-- l'axe : os du milieu. s = 0 à la tête (z minimum), 1 au bout de la queue
	local axis = {}
	for _, n in list do if axial(n) then table.insert(axis, n) end end
	local zMin, zMax = math.huge, -math.huge
	for _, n in axis do zMin, zMax = min(zMin, n.pos.Z), max(zMax, n.pos.Z) end
	local span = max(zMax - zMin, 1e-3)
	if swimmer then
		local behind = 0
		for _, n in axis do if n.pos.Z > root.pos.Z + 1e-3 or n == root then behind += 1 end end
		for _, n in axis do
			local s = (n.pos.Z - zMin) / span
			n.roles.wave = {s = s, gain = (kind == "Slither" and 0.8 or (0.2 + 0.8 * s)) * 2.4 / max(behind, 2)}
			drive(n)
		end
	else
		local frontRef, backRef = root.pos.Z, root.pos.Z
		for _, l in limbs do
			frontRef, backRef = min(frontRef, l.start.pos.Z), max(backRef, l.start.pos.Z)
		end
		local tails, necks = {}, {}
		for _, n in axis do
			if n ~= root then
				if n.pos.Z > backRef + height * 0.04 then table.insert(tails, n)
				elseif n.pos.Z < frontRef - height * 0.04 then table.insert(necks, n) end
			end
		end
		for _, n in tails do
			n.roles.tail = {s = (n.pos.Z - backRef) / max(zMax - backRef, 1e-3), gain = 1 / max(#tails, 1) ^ 0.5}
			drive(n)
		end
		-- le cou : seulement la chaîne qui mène à l'os le plus haut vers l'avant (la mâchoire ne hoche pas la tête)
		local head
		for _, n in necks do if not head or n.pos.Y - n.pos.Z > head.pos.Y - head.pos.Z then head = n end end
		local count, k = 0, head
		while k and k ~= root and axial(k) and k.pos.Z < frontRef - height * 0.04 do count += 1 k = k.parent end
		k = head
		while k and k ~= root and axial(k) and k.pos.Z < frontRef - height * 0.04 do
			k.roles.neck = {gain = 1 / max(count, 1)}
			drive(k)
			k = k.parent
		end
		-- le dos : les os du milieu entre les épaules et les hanches (u = 0 aux épaules, 1 aux hanches)
		local spines = {}
		for _, n in axis do
			if n ~= root and not n.roles.tail and not n.roles.neck and n.pos.Z >= frontRef - height * 0.04 and n.pos.Z <= backRef + height * 0.04 then table.insert(spines, n) end
		end
		for _, n in spines do
			n.roles.spine = {u = clamp((n.pos.Z - frontRef) / max(backRef - frontRef, 1e-3), 0, 1), gain = 1 / max(#spines, 1) ^ 0.5}
			drive(n)
		end
	end
	return rig
end

---------------------------------------------------------------- animateur
local Animator = {}
Animator.__index = Animator
local active = {}

function M.new(model, kind)
	local mesh = model:IsA("MeshPart") and model or (model.PrimaryPart and model.PrimaryPart:IsA("MeshPart") and model.PrimaryPart) or model:FindFirstChildWhichIsA("MeshPart", true)
	assert(mesh, "AnimalAnimator: no MeshPart in " .. model:GetFullName())
	kind = kind or model:GetAttribute("Move") or KIND[model.Name] or "Walk"
	local self = setmetatable({model = model, mesh = mesh, kind = kind, speed = 1, time = math.random() * 10, state = "", weights = {}, enabled = true,
		clock = 0, seed = math.random() * 20, nextAccent = 1.5 + math.random() * 4}, Animator)
	self.rig = M.analyze(mesh, kind)
	self.rateScale = clamp((5 / max(self.rig.height or 5, 0.5)) ^ 0.35, 0.45, 1.8) -- les petits battent plus vite que les grands
	self:play("Idle", 0)
	active[self] = true
	model.Destroying:Connect(function() active[self] = nil end)
	return self
end

-- "Idle", "Move", ou un état précis ("Walk", "Run", "Leap", "Fly", "Hover", "Swim", "Float", "Slither", "Drift").
-- Un état qui ne convient pas à l'animal est remplacé par le sien : un poisson qui « court » nage, un oiseau vole.
function Animator:play(name, fade)
	local resolved = name
	if name == "Idle" then resolved = IDLE_OF[self.kind] or "Idle"
	elseif name == "Move" then resolved = MOVE_OF[self.kind] or "Walk"
	elseif self.kind == "Drift" then resolved = "Drift"
	elseif self.kind == "Swim" then resolved = "Swim"
	elseif self.kind == "Slither" then resolved = "Slither"
	elseif self.kind == "Fly" and (name == "Walk" or name == "Run" or name == "Leap") then resolved = "Fly"
	elseif name == "Leap" and self.rig.hasWings then resolved = "Fly" end
	if not STATES[resolved] then resolved = "Idle" end
	self.state, self.requested = resolved, name
	self.fade = fade or M.FADE
	if self.fade <= 0 then
		self.weights = {[resolved] = 1}
	elseif not self.weights[resolved] then
		self.weights[resolved] = 0
	end
end

-- joue un geste tout de suite, par-dessus l'état en cours : "Roar" (se dresse et menace), "Crouch" (se ramasse avant de bondir),
-- ou un des petits gestes de l'arrêt ("Look", "Hop", "Shake", "Graze", "Flap", "Flick")
-- Coups signature des gardiens (BossStyles) : "Stomp" (se cabre et frappe le sol), "Pounce" (se ramasse et bondit),
-- "Spin" (tourbillon), "Thrash" (se débat), "Howl" (hurle vers le ciel), "Breath" (souffle en balayant), "Spout" (geyser), "Bow" (révérence)
function Animator:gesture(name, duration)
	self.accent = {name = name, dur = duration or 1, t0 = self.clock, side = math.random() < 0.5 and -1 or 1, force = true}
end

function Animator:destroy()
	active[self] = nil
	for _, n in self.rig.nodes do if n.bone.Parent then n.bone.Transform = CFrame.new() end end
end

local P = {} -- réglages mélangés de l'image en cours
-- petits gestes joués de temps en temps à l'arrêt, selon le déplacement naturel : {nom, durée en secondes}
local ACCENTS = {
	Walk = {{"Look", 1.8}, {"Hop", 0.7}, {"Shake", 0.9}, {"Graze", 2.4}, {"Look", 1.6}},
	Fly = {{"Look", 1.6}, {"Shake", 0.8}, {"Flap", 1.1}},
	Swim = {{"Flick", 0.8}},
	Slither = {{"Flick", 0.9}},
}
local function bell(u) return sin(clamp(u, 0, 1) * math.pi) end   -- 0 -> 1 -> 0 en douceur
local function hold(u) return clamp(min(u, 1 - u) * 5, 0, 1) end  -- monte vite, tient, redescend

function Animator:step(dt)
	local rig = self.rig
	if not rig.root then return end
	-- fondu : le poids de l'état demandé monte, les autres descendent
	local total = 0
	for name, w in self.weights do
		local target = name == self.state and 1 or 0
		local k = self.fade > 0 and dt / self.fade or 1
		w = w + clamp(target - w, -k, k)
		if w <= 0 and target == 0 then self.weights[name] = nil else self.weights[name] = w total += w end
	end
	for key in STATES.Idle do P[key] = 0 end
	for name, w in self.weights do
		for key, value in STATES[name] do P[key] += value * w / total end
	end
	self.time += dt * self.speed * P.rate * self.rateScale
	self.clock += dt
	local t = self.time * TAU       -- cycle du déplacement (pas, battement d'ailes, ondulation)
	local c = self.clock + self.seed -- temps réel : respiration, regards, frémissements (ne dépend pas de la cadence)
	local H = rig.height

	-- petit geste à l'arrêt
	local act, u, e, side = nil, 0, 0, 1
	local accent = self.accent
	if accent then
		u = (self.clock - accent.t0) / accent.dur
		if u >= 1 or (not accent.force and P.accent < 0.5) then self.accent = nil else act, e, side = accent.name, accent.force and 1 or P.accent, accent.side end
	elseif P.accent > 0.9 and self.clock >= self.nextAccent then
		local list = ACCENTS[rig.kind]
		if list then
			local pick = list[math.random(#list)]
			self.accent = {name = pick[1], dur = pick[2], t0 = self.clock, side = math.random() < 0.5 and -1 or 1}
		end
		self.nextAccent = self.clock + 3 + math.random() * 5
	end
	local b, h = bell(u) * e, hold(u) * e -- nuls quand aucun geste n'est en cours
	-- coups signature : courbes partagées par tout le squelette
	local rear = act == "Stomp" and (u < 0.55 and sin(u / 0.55 * math.pi * 0.5) or max(0, 1 - (u - 0.55) / 0.1)) or 0
	local slam = act == "Stomp" and u > 0.55 and bell((u - 0.55) / 0.45) or 0
	local coil = act == "Pounce" and (u < 0.4 and sin(u / 0.4 * math.pi * 0.5) or max(0, 1 - (u - 0.4) / 0.1)) or 0
	local lunge = act == "Pounce" and u > 0.4 and bell((u - 0.4) / 0.6) or 0

	for _, n in rig.driven do
		local rx, ry, rz, py = 0, 0, 0, 0
		local r = n.roles
		if n == rig.root then
			-- le corps entier : rebond des pas, respiration, balancement du bassin, report du poids
			py = sin(t * 2) * P.bob * H + sin(c * 1.7) * P.breathe * 0.25 * H
			rx = -P.lean + sin(c * 1.7) * P.breathe * 0.35
			ry = sin(t) * P.sway
			rz = sin(t) * P.roll + sin(c * 0.8) * P.shift
			if rig.kind == "Drift" then py = sin(t) * P.bob * H end
			if act == "Hop" then
				py += b * 0.22 * H
				rx -= sin(u * TAU) * 0.1 * e
			elseif act == "Shake" then
				rz += sin(u * 40) * 0.13 * b
			elseif act == "Flap" then
				py += b * 0.12 * H
			elseif act == "Roar" then -- se dresse, tremble de colère
				rx += h * 0.3
				py += h * 0.05 * H
				rz += sin(u * 46) * 0.03 * h
			elseif act == "Crouch" then
				py -= h * 0.1 * H
				rx -= h * 0.08
			elseif act == "Stomp" then -- se cabre, puis retombe de tout son poids
				rx += (rear * 0.42 - slam * 0.1) * e
				py += (rear * 0.09 - slam * 0.05) * H * e
				rz += sin(u * 40) * 0.02 * rear * e
			elseif act == "Pounce" then -- se ramasse, puis bondit en avant
				py += (lunge * 0.18 - coil * 0.1) * H * e
				rx += (lunge * 0.1 - coil * 0.12) * e
			elseif act == "Spin" then -- un tour complet sur lui-même, en l'air
				ry += u * u * (3 - 2 * u) * TAU * e
				py += b * 0.16 * H
				rz += b * 0.2
			elseif act == "Thrash" then -- se débat violemment
				rz += sin(u * 32) * 0.22 * h
				ry += sin(u * 19) * 0.16 * h
				py += b * 0.06 * H
			elseif act == "Howl" then -- dressé, tête vers le ciel
				rx += h * 0.22
				py += h * 0.04 * H
				rz += sin(u * 50) * 0.02 * h
			elseif act == "Breath" then -- s'arc-boute et balaie de gauche à droite
				rx -= h * 0.06
				py -= h * 0.03 * H
				ry += sin(u * TAU * 1.5) * 0.22 * h
			elseif act == "Spout" then -- remonte et souffle
				py += b * 0.14 * H
				rx += sin(u * TAU) * 0.14 * b
			elseif act == "Bow" then -- s'incline solennellement, puis se redresse
				rx -= sin(u * TAU) * 0.12 * e
				py -= b * 0.04 * H
			end
		end
		if r.spine then
			local g = r.spine.gain
			ry += sin(t + 0.4) * P.sway * 0.8 * (r.spine.u < 0.5 and 1 or -1) * g -- les épaules tournent à l'inverse des hanches
			rz -= sin(t) * P.roll * 0.5 * g
			rx += sin(c * 1.7 + 0.5) * P.breathe * 0.5 * g
			if act == "Shake" then rz += sin(u * 40 - 0.6) * 0.1 * b * g end
		end
		if r.leg then
			local l = r.leg.limb
			local ph = t + l.phase
			local i = r.leg.index
			if i == 1 then
				if l.sweep then
					ry += l.side * sin(ph) * P.leg * 0.7
					rz += l.side * max(0, cos(ph)) * P.leg * 0.5
				else
					rx += sin(ph) * P.leg - P.tuck * (l.row == 1 and #rig.legs > 2 and -0.6 or 1)
					rz -= sin(c * 0.8) * P.shift + sin(t) * P.roll * 0.6 -- les pattes restent d'aplomb quand le corps se balance
				end
				if act == "Hop" then
					rx += b * 0.35 * (l.row == 1 and -1 or 1)
				elseif act == "Roar" then
					if l.row == 1 and #rig.legs > 2 then
						rx -= h * 0.5 + sin(u * 22 + l.phase) * 0.22 * h -- les pattes avant battent l'air
					else
						rx -= h * 0.3 -- les pattes d'appui restent plantées pendant que le corps se dresse
					end
				elseif act == "Crouch" then
					rx += h * 0.25 * (l.row == 1 and -1 or 1)
				elseif act == "Stomp" then
					if l.row == 1 and #rig.legs > 2 then
						rx -= (rear * 0.75 + sin(u * 26 + l.phase) * 0.2 * rear) * e -- les pattes avant battent l'air, puis frappent
					else
						rx -= rear * 0.35 * e
					end
				elseif act == "Pounce" then
					rx += (coil * 0.25 * (l.row == 1 and -1 or 1) + lunge * (l.row == 1 and -0.75 or 0.55)) * e
				elseif act == "Howl" or act == "Bow" then
					rx -= h * ((act == "Bow" and l.row == 1 and #rig.legs > 2) and 0.4 or 0.22)
				elseif act == "Spin" then
					rx += b * 0.45 * (l.row == 1 and -1 or 1)
				end
			elseif i == 2 and not l.sweep then
				rx += -max(0, cos(ph)) * P.knee * P.leg * 2 + P.tuck * 0.8
				if act == "Hop" then rx -= b * 0.3 elseif act == "Crouch" then rx -= h * 0.4
				elseif act == "Pounce" then rx -= coil * 0.45 * e
				elseif act == "Stomp" and l.row == 1 then rx += rear * 0.6 * e
				elseif act == "Spin" then rx -= b * 0.5 end
			elseif i == 3 and not l.sweep then
				rx += (max(0, cos(ph)) * P.knee * P.leg * 2 - sin(ph) * P.leg) * P.ankle -- le pied reste à plat
			end
		end
		if r.wing then
			local l = r.wing.limb
			local amp = l.big and P.wing or P.wing * 0.45
			local lag = (r.wing.index - 1) * 0.55
			local share = r.wing.index == 1 and 1 or 0.45
			rz += l.side * (sin(t - lag) * amp * share - (r.wing.index == 1 and P.fold * (l.big and 1 or 0.3) or 0))
			ry += l.side * sin(t * 0.5 - lag) * amp * 0.22 * share -- l'aile balaie un peu d'avant en arrière
			rz += l.side * sin(c * 2.3 + l.start.pos.Z * 3 - lag) * P.flutter * (l.big and 0.35 or 1) * share -- frémissement
			if act == "Flap" and l.big then
				rz += l.side * (h * 0.3 + sin(u * 34 - lag) * 0.3 * b)
			elseif act == "Shake" then
				rz += l.side * sin(u * 40 - lag) * 0.12 * b
			elseif act == "Roar" then -- ailes (ou bras) grands ouverts, qui tremblent
				rz += l.side * (h * (l.big and 0.5 or 0.35) + sin(u * 44 - lag) * 0.08 * h) * share
			elseif act == "Howl" or act == "Breath" or act == "Bow" or act == "Stomp" then -- grands ouverts, frémissants
				rz += l.side * (h * (l.big and 0.6 or 0.35) + sin(u * 40 - lag) * 0.07 * h) * share
			elseif act == "Spin" or act == "Thrash" or act == "Spout" or act == "Pounce" then -- grands battements
				rz += l.side * (b * 0.3 + sin(u * 28 - lag) * 0.4 * b) * share
			end
		end
		if r.follow then
			local l = r.follow.limb
			local lag = r.follow.depth * 0.6
			if l.role == "leg" then
				rx += sin(t + l.phase - lag) * P.leg * 0.2
			else
				rz += l.side * sin(t - lag - 0.5) * (P.wing * 0.3 + P.flutter)
			end
		end
		if r.wave then
			local g = r.wave.gain
			ry += sin(t - r.wave.s * 4.2) * P.wave * g
			rz += sin(t - r.wave.s * 4.2 + 1.2) * P.roll * 0.5 * g + sin(c * 0.8) * P.shift * 0.4 * g -- le corps roule un peu en nageant
			if act == "Flick" then ry += sin(u * 26 - r.wave.s * 5) * 0.3 * b * g
			elseif act == "Roar" then ry += sin(u * 30 - r.wave.s * 5) * 0.28 * h * g -- se débat
			elseif act == "Thrash" then ry += sin(u * 30 - r.wave.s * 5) * 0.5 * h * g
			elseif act == "Spout" then ry += sin(u * 14 - r.wave.s * 4) * 0.35 * b * g
			elseif act == "Spin" then ry += sin(u * 20 - r.wave.s * 4) * 0.3 * b * g end
		end
		if r.tail then
			local g = r.tail.gain
			ry += sin(t * 0.5 - r.tail.s * 1.6) * P.tail * g + sin(c * 1.3 - r.tail.s * 2.2) * P.tail * 0.5 * g
			rx += sin(t - r.tail.s * 1.2) * P.tail * 0.25 * g - P.lift * g
			rz += sin(c * 0.9 - r.tail.s * 1.5) * P.tail * 0.2 * g
			if act == "Shake" then
				ry += sin(u * 44 - r.tail.s * 2) * 0.45 * b * g
			elseif act == "Hop" then
				rx -= b * 0.3 * g
			elseif act == "Roar" then
				rx -= h * 0.25 * g
				ry += sin(u * 36 - r.tail.s * 2) * 0.2 * h * g
			elseif act == "Stomp" or act == "Howl" then
				rx -= h * 0.3 * g
				ry += sin(u * 30 - r.tail.s * 2) * 0.15 * h * g
			elseif act == "Thrash" or act == "Spin" or act == "Pounce" or act == "Breath" then
				ry += sin(u * 34 - r.tail.s * 2) * 0.4 * b * g
			end
		end
		if r.neck then
			local g = r.neck.gain
			ry += (sin(c * 0.6) * 0.6 + sin(c * 0.23 + 1.3) * 0.4) * P.look * g + sin(t * 0.37) * P.head * g
			rx += (sin(t * 2 + 0.6) * P.nod + P.lean * 0.8) * g + sin(c * 0.9 + 0.7) * P.look * 0.15 * g
			rz += sin(c * 0.45 + 2) * P.look * 0.25 * g
			if act == "Look" then -- tourne la tête d'un côté et la penche, curieux
				ry += h * 0.75 * side * g
				rz += h * 0.25 * side * g
			elseif act == "Graze" then -- baisse la tête et broute
				rx -= (h * 0.55 + sin(u * 34) * 0.05 * h) * g
			elseif act == "Shake" then
				rz += sin(u * 40 - 1) * 0.2 * b * g
			elseif act == "Hop" then
				rx += b * 0.15 * g
			elseif act == "Roar" then -- tête haute, secouée
				rx += h * 0.28 * g
				ry += sin(u * 40) * 0.1 * h * g
			elseif act == "Howl" then -- hurle vers le ciel
				rx += (h * 0.7 + sin(u * 48) * 0.04 * h) * g
			elseif act == "Stomp" then
				rx += (rear * 0.35 - slam * 0.45) * e * g
			elseif act == "Breath" then -- cou tendu en avant, qui balaie
				rx -= h * 0.15 * g
				ry += sin(u * TAU * 1.5) * 0.3 * h * g
			elseif act == "Pounce" then
				rx += (lunge * 0.15 - coil * 0.25) * e * g
			elseif act == "Bow" then
				rx -= sin(u * TAU) * 0.7 * e * g
			elseif act == "Spout" then
				rx += b * 0.25 * g
			end
		end
		if r.tent then
			local a = sin(t - r.tent.depth * 0.9 + r.tent.seed) * P.tent
			local q = CFrame.fromAxisAngle(r.tent.dir, a)
			n.bone.Transform = n.inv * q * n.rot
		else
			local q = CFrame.fromEulerAnglesYXZ(rx, ry, rz)
			if py ~= 0 then
				n.bone.Transform = CFrame.new(n.inv * V(0, py, 0)) * (n.inv * q * n.rot)
			else
				n.bone.Transform = n.inv * q * n.rot
			end
		end
	end
end

-- avance tous les animateurs (appelé tout seul en jeu ; à appeler à la main dans Studio hors Play)
function M.step(dt)
	local camera = workspace.CurrentCamera
	local eye = RunService:IsClient() and RunService:IsRunning() and camera and camera.CFrame.Position
	for a in active do
		if not a.mesh.Parent then
			active[a] = nil
		elseif a.enabled and not (eye and (a.mesh.Position - eye).Magnitude > M.MaxDistance) then
			a:step(dt)
		end
	end
end
if RunService:IsRunning() then
	if RunService:IsClient() then RunService.RenderStepped:Connect(M.step) else RunService.Heartbeat:Connect(M.step) end
end

---------------------------------------------------------------- copies prêtes à poser
function M.names()
	local out = {}
	for _, m in script.Parent.Models:GetChildren() do table.insert(out, m.Name) end
	table.sort(out)
	return out
end

-- o.height : hauteur voulue (studs) ; o.scale : échelle ; o.parent : parent (workspace par défaut) ; o.state : état de départ
function M.spawn(name, cf, o)
	o = o or {}
	local src = script.Parent.Models:FindFirstChild(name)
	assert(src, "AnimalAnimator: unknown animal " .. tostring(name))
	local model = src:Clone()
	-- ScaleTo est absolu et certains modèles ont déjà une échelle interne : on multiplie celle qu'ils ont
	local factor = o.height and o.height / src:GetAttribute("Height") or o.scale
	if factor then model:ScaleTo(model:GetScale() * factor) end
	if cf then model:PivotTo(cf) end
	model.Parent = o.parent or workspace
	local anim = M.new(model)
	if o.state then anim:play(o.state, 0) end
	return model, anim
end

return M

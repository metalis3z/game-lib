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
	Idle = {rate = 0.45, leg = 0.04, knee = 0, wing = 0.09, fold = 0.25, wave = 0.07, tail = 0.26, head = 0.26, nod = 0.07, bob = 0.02, tuck = 0, lean = 0, tent = 0.16},
	Walk = {rate = 1.8, leg = 0.68, knee = 0.6, wing = 0.08, fold = 0.25, wave = 0.07, tail = 0.28, head = 0.07, nod = 0.1, bob = 0.045, tuck = 0, lean = 0.04, tent = 0.24},
	Fly = {rate = 2.2, leg = 0.04, knee = 0, wing = 0.62, fold = 0, wave = 0.04, tail = 0.12, head = 0.04, nod = 0.05, bob = 0.05, tuck = 0.55, lean = 0.12, tent = 0.2},
	Hover = {rate = 1.7, leg = 0.04, knee = 0, wing = 0.55, fold = 0, wave = 0.04, tail = 0.16, head = 0.16, nod = 0.04, bob = 0.045, tuck = 0.35, lean = 0, tent = 0.18},
	Swim = {rate = 1.5, leg = 0, knee = 0, wing = 0.22, fold = 0, wave = 0.34, tail = 0, head = 0, nod = 0, bob = 0.012, tuck = 0, lean = 0, tent = 0.3},
	Float = {rate = 0.9, leg = 0, knee = 0, wing = 0.2, fold = 0, wave = 0.24, tail = 0, head = 0, nod = 0, bob = 0.03, tuck = 0, lean = 0, tent = 0.24},
	Slither = {rate = 1.2, leg = 0, knee = 0, wing = 0, fold = 0, wave = 0.32, tail = 0, head = 0, nod = 0, bob = 0, tuck = 0, lean = 0, tent = 0.2},
	Coil = {rate = 0.6, leg = 0, knee = 0, wing = 0, fold = 0, wave = 0.18, tail = 0, head = 0, nod = 0, bob = 0.008, tuck = 0, lean = 0, tent = 0.14},
	Drift = {rate = 0.8, leg = 0, knee = 0, wing = 0, fold = 0, wave = 0, tail = 0, head = 0, nod = 0, bob = 0.03, tuck = 0, lean = 0, tent = 0.3},
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
	local self = setmetatable({model = model, mesh = mesh, kind = kind, speed = 1, time = math.random() * 10, state = "", weights = {}, enabled = true}, Animator)
	self.rig = M.analyze(mesh, kind)
	self.rateScale = clamp((5 / max(self.rig.height or 5, 0.5)) ^ 0.35, 0.45, 1.8) -- les petits battent plus vite que les grands
	self:play("Idle", 0)
	active[self] = true
	model.Destroying:Connect(function() active[self] = nil end)
	return self
end

-- "Idle", "Move", ou un état précis ("Walk", "Fly", "Hover", "Swim", "Float", "Slither", "Drift")
function Animator:play(name, fade)
	local resolved = name
	if name == "Idle" then resolved = IDLE_OF[self.kind] or "Idle"
	elseif name == "Move" then resolved = MOVE_OF[self.kind] or "Walk"
	elseif self.kind == "Swim" and (name == "Walk" or name == "Fly") then resolved = "Swim"
	elseif self.kind == "Slither" and name == "Walk" then resolved = "Slither"
	elseif self.kind == "Drift" then resolved = "Drift" end
	if not STATES[resolved] then resolved = "Idle" end
	self.state, self.requested = resolved, name
	self.fade = fade or M.FADE
	if self.fade <= 0 then
		self.weights = {[resolved] = 1}
	elseif not self.weights[resolved] then
		self.weights[resolved] = 0
	end
end

function Animator:destroy()
	active[self] = nil
	for _, n in self.rig.nodes do if n.bone.Parent then n.bone.Transform = CFrame.new() end end
end

local P = {} -- réglages mélangés de l'image en cours
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
	local t = self.time * TAU
	local H = rig.height

	for _, n in rig.driven do
		local rx, ry, rz, py = 0, 0, 0, 0
		local r = n.roles
		if n == rig.root then
			py = sin(t * 2) * P.bob * H
			rx = -P.lean
			if rig.kind == "Drift" then py = sin(t) * P.bob * H end
		end
		if r.leg then
			local l = r.leg.limb
			local ph = t + l.phase
			if r.leg.index == 1 then
				if l.sweep then
					ry += l.side * sin(ph) * P.leg * 0.7
					rz += l.side * max(0, cos(ph)) * P.leg * 0.5
				else
					rx += sin(ph) * P.leg - P.tuck * (l.row == 1 and #rig.legs > 2 and -0.6 or 1)
				end
			elseif r.leg.index == 2 and not l.sweep then
				rx += -max(0, cos(ph)) * P.knee * P.leg * 2 + P.tuck * 0.8
			end
		end
		if r.wing then
			local l = r.wing.limb
			local amp = l.big and P.wing or P.wing * 0.45
			local lag = (r.wing.index - 1) * 0.55
			local share = r.wing.index == 1 and 1 or 0.45
			rz += l.side * (sin(t - lag) * amp * share - (r.wing.index == 1 and P.fold * (l.big and 1 or 0.3) or 0))
		end
		if r.wave then
			ry += sin(t - r.wave.s * 4.2) * P.wave * r.wave.gain
		end
		if r.tail then
			ry += sin(t * 0.5 - r.tail.s * 1.6) * P.tail * r.tail.gain
			rx += sin(t - r.tail.s * 1.2) * P.tail * 0.25 * r.tail.gain
		end
		if r.neck then
			ry += sin(t * 0.37) * P.head * r.neck.gain
			rx += (sin(t * 2 + 0.6) * P.nod + P.lean * 0.8) * r.neck.gain
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

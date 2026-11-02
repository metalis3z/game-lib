-- BlackHole : portail "trou noir" (côté client). Utilisé par la cinématique Samouraï (FightFilm.SamuraiFilm) et l'arène du boss
-- (BossArenaClient : le portail du nord, les téléportations du Headless).
--   local bh = BlackHole.new(cframe, rayon, parent)   -- cframe.LookVector = vers qui il est tourné
--   bh:open(durée) / bh:close(durée, détruire) / bh:flare() / bh:suck(force 0..1) / bh:destroy()
-- v2 : disques en spirale qui tournent (maillages Spiral / SwirlWind), anneau de lumière déviée qui ondule, deux jets
-- lumineux de part et d'autre, et une vraie ASPIRATION quand il aspire (suck) : débris, poussière et traits de vent attirés en
-- spirale jusqu'au centre, de plus en plus vite.
-- Un coeur noir absolu (rien de lumineux ne passe devant), un liseré violet, un anneau de photons très lumineux, deux disques d'accrétion (orange, magenta) qui
-- tournent en sens inverse, un halo, des étincelles aspirées en spirale et des éclairs qui crépitent autour.
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BlackHole = {}
BlackHole.__index = BlackHole

local rgb = Color3.fromRGB
local rad, sin, cos = math.rad, math.sin, math.cos
local meshes = ReplicatedStorage:WaitForChild("FightFilm"):WaitForChild("Vfx"):WaitForChild("Meshes")

local function part(parent, shape, color, transp, mesh)
	local p = mesh and meshes:FindFirstChild(mesh):Clone() or Instance.new("Part")
	if not mesh then p.Shape = shape or Enum.PartType.Ball end
	p.Material = Enum.Material.Neon
	p.Color, p.Transparency = color, 1
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
	p.Size = Vector3.one * 0.1
	p.Parent = parent
	return p, transp
end

function BlackHole.new(cf, radius, parent)
	local self = setmetatable({}, BlackHole)
	self.cf, self.radius, self.k, self.boost, self.spin = cf, radius, 0, 0, 0
	local folder = Instance.new("Folder")
	folder.Name = "BlackHole"
	folder.Parent = parent or workspace
	self.folder = folder
	local R = radius
	-- {pièce, transparence, taille de base (Vector3), mode, rotation, recul}
	--   mode "flat" = maillage tourné dans le plan du portail ; "disc" = disque plat posé DERRIÈRE le coeur (recul en rayons),
	--   pour que rien de lumineux ne passe devant le coeur noir ; sinon une boule centrée
	self.layers = {}
	local function add(p, transp, size, mode, spin, back)
		table.insert(self.layers, {p = p, t = transp, size = size, mode = mode, spin = spin or 0, back = back or 0})
		return p
	end
	add(part(folder, Enum.PartType.Cylinder, rgb(150, 70, 255)), 0.86, Vector3.new(0.2, R * 3.6, R * 3.6), "disc", 0, 0.5)   -- halo lointain
	add(part(folder, Enum.PartType.Cylinder, rgb(120, 30, 210)), 0.7, Vector3.new(0.2, R * 2.5, R * 2.5), "disc", 0, 0.42)    -- lueur proche
	add(part(folder, nil, rgb(255, 130, 50), nil, "Shockwave"), 0.25, Vector3.new(R * 2.9, R * 0.12, R * 2.9), "flat", 2.6)   -- disque orange
	add(part(folder, nil, rgb(230, 70, 255), nil, "Shockwave"), 0.2, Vector3.new(R * 2.3, R * 0.14, R * 2.3), "flat", -3.8)   -- disque magenta
	add(part(folder, nil, rgb(255, 220, 255), nil, "Ring"), 0.05, Vector3.new(R * 1.55, R * 0.18, R * 1.55), "flat", 1.2)     -- anneau de photons
	add(part(folder, Enum.PartType.Cylinder, rgb(200, 90, 255)), 0.15, Vector3.new(0.2, R * 1.36, R * 1.36), "disc", 0, 0.05)  -- liseré violet
	-- spirales d'accrétion : deux bras qui tournent vite, en sens inverse des disques
	if meshes:FindFirstChild("Spiral") then
		add(part(folder, nil, rgb(255, 170, 90), nil, "Spiral"), 0.35, Vector3.new(R * 2.6, R * 0.25, R * 2.6), "flat", 5.5)
		add(part(folder, nil, rgb(200, 120, 255), nil, "Spiral"), 0.45, Vector3.new(R * 2.1, R * 0.25, R * 2.1), "flat", -7)
	end
	if meshes:FindFirstChild("SwirlWind") then
		add(part(folder, nil, rgb(255, 220, 255), nil, "SwirlWind"), 0.75, Vector3.new(R * 3.0, R * 0.6, R * 3.0), "flat", 3.2)
	end
	-- anneau d'Einstein : la lumière déviée autour de l'horizon (fin, très lumineux, il ondule)
	self.lens = add(part(folder, nil, rgb(255, 250, 235), nil, "Ring"), 0.25, Vector3.new(R * 1.32, R * 0.06, R * 1.32), "flat", 0.4)
	self.core = add(part(folder, Enum.PartType.Ball, rgb(0, 0, 0)), 0, Vector3.one * R * 1.15)                 -- coeur noir
	-- jets lumineux de part et d'autre du disque (le long de l'axe "haut" du portail)
	self.jets = {}
	for _, side in {1, -1} do
		local j = part(folder, Enum.PartType.Cylinder, rgb(190, 140, 255))
		table.insert(self.jets, {p = j, side = side})
	end
	self.debris = {}
	self.nextDebris = 0
	-- étincelles aspirées en spirale (elles naissent sur un disque autour et filent vers le centre)
	local emitHolder = part(folder, Enum.PartType.Block, rgb(0, 0, 0))
	emitHolder.Transparency = 1
	self.emitHolder = emitHolder
	local e = Instance.new("ParticleEmitter")
	e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	e.Color = ColorSequence.new(rgb(255, 230, 255), rgb(170, 60, 255))
	e.LightEmission, e.LightInfluence = 1, 0
	e.Shape, e.ShapeInOut, e.ShapeStyle = Enum.ParticleEmitterShape.Box, Enum.ParticleEmitterShapeInOut.Inward, Enum.ParticleEmitterShapeStyle.Volume
	e.Rate, e.Lifetime, e.Speed = 0, NumberRange.new(0.6, 1), NumberRange.new(R * 1.2, R * 2)
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, R * 0.05), NumberSequenceKeypoint.new(1, 0)})
	e.Orientation = Enum.ParticleOrientation.VelocityParallel
	e.Squash = NumberSequence.new(1.5)
	e.Parent = emitHolder
	self.emitter = e
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = rgb(190, 90, 255), R * 5, 0, false
	light.Parent = self.core
	self.light = light
	self.nextArc = 0
	self.conn = RunService.RenderStepped:Connect(function(dt) self:_step(dt) end)
	folder.AncestryChanged:Connect(function() if not folder:IsDescendantOf(game) then self:destroy() end end)
	return self
end

function BlackHole:_step(dt)
	local k = self.k
	self.spin += dt
	local pulse = 1 + 0.03 * sin(os.clock() * 5) + self.boost * 0.15
	local plane = self.cf * CFrame.Angles(rad(90), 0, 0) -- l'axe Y des maillages plats suit le regard du portail
	for _, L in self.layers do
		local s = L.size * k * pulse
		L.p.Size = Vector3.new(math.max(s.X, 0.05), math.max(s.Y, 0.05), math.max(s.Z, 0.05))
		if L.mode == "flat" then
			L.p.CFrame = plane * CFrame.Angles(0, self.spin * L.spin * (1 + self.boost * 2), 0)
		elseif L.mode == "disc" then
			L.p.CFrame = self.cf * CFrame.new(0, 0, L.back * self.radius * k) * CFrame.Angles(0, rad(90), 0)
		else
			L.p.CFrame = CFrame.new(self.cf.Position)
		end
		L.p.Transparency = 1 - (1 - L.t) * math.min(k * 1.4, 1)
	end
	local R = self.radius * k
	-- l'anneau de lumière ondule, les jets pulsent
	if self.lens then self.lens.Transparency = 1 - (1 - 0.25) * math.min(k * 1.4, 1) * (0.75 + 0.25 * sin(os.clock() * 7)) end
	for _, j in self.jets do
		local len = R * (2.6 + 0.6 * sin(os.clock() * 5 + j.side) + 1.5 * self.boost)
		j.p.Size = Vector3.new(math.max(len, 0.05), math.max(R * 0.12 * (1 + self.boost), 0.05), math.max(R * 0.12 * (1 + self.boost), 0.05))
		j.p.CFrame = self.cf * CFrame.new(0, j.side * (R * 0.6 + len / 2), 0) * CFrame.Angles(0, 0, math.rad(90))
		j.p.Transparency = 1 - 0.55 * math.min(k * 1.4, 1)
	end
	-- ASPIRATION : des débris et des traits de vent naissent autour et filent en spirale vers le centre
	if self.boost > 0.25 and k > 0.5 and os.clock() > self.nextDebris then
		self.nextDebris = os.clock() + 0.06 / self.boost
		local a = math.random() * math.pi * 2
		local dist = R * (2.6 + math.random() * 1.4)
		local streak = math.random() < 0.55
		local d = Instance.new("Part")
		d.Anchored, d.CanCollide, d.CanQuery, d.CanTouch, d.CastShadow = true, false, false, false, false
		if streak then
			d.Material, d.Color, d.Transparency = Enum.Material.Neon, math.random() < 0.5 and rgb(255, 230, 255) or rgb(190, 140, 255), 0.3
			d.Size = Vector3.new(R * 0.05, R * 0.05, R * (0.5 + math.random() * 0.6))
		else
			d.Material, d.Color = Enum.Material.Slate, rgb(70 + math.random(0, 40), 60, 90)
			d.Size = Vector3.one * R * (0.08 + math.random() * 0.1)
		end
		d.Parent = self.folder
		table.insert(self.debris, {p = d, a = a, dist = dist, t0 = os.clock(), life = 0.7 + math.random() * 0.5, z = (math.random() - 0.5) * R, streak = streak,
			spin = Vector3.new(math.random() * 6, math.random() * 6, math.random() * 6)})
	end
	for i = #self.debris, 1, -1 do
		local d = self.debris[i]
		local u = (os.clock() - d.t0) / d.life
		if u >= 1 or not d.p.Parent then
			d.p:Destroy()
			table.remove(self.debris, i)
		else
			local e = u * u -- de plus en plus vite
			local r = d.dist * (1 - e)
			local ang = d.a + e * 3.5 -- spirale
			local pos = self.cf * Vector3.new(math.cos(ang) * r, math.sin(ang) * r, d.z * (1 - e))
			if d.streak then
				local nextPos = self.cf * Vector3.new(math.cos(ang + 0.2) * r * 0.9, math.sin(ang + 0.2) * r * 0.9, d.z * (1 - e))
				if (nextPos - pos).Magnitude > 1e-3 then d.p.CFrame = CFrame.lookAt(pos, nextPos) end
				d.p.Transparency = 0.3 + 0.7 * u
			else
				d.p.CFrame = CFrame.new(pos) * CFrame.Angles(d.spin.X * u, d.spin.Y * u, d.spin.Z * u)
				d.p.Size = d.p.Size * (1 - dt * 0.8)
			end
		end
	end
	self.emitHolder.Size = Vector3.new(R * 3.2, R * 3.2, 0.3)
	self.emitHolder.CFrame = self.cf
	self.emitter.Rate = k > 0.2 and (40 + 160 * self.boost) or 0
	self.light.Brightness = 3 * k * (1 + self.boost)
	-- éclairs : de petits arcs qui jaillissent du disque
	if k > 0.5 and os.clock() > self.nextArc then
		self.nextArc = os.clock() + 0.15 + math.random() * 0.45 / (1 + self.boost * 2)
		local a = math.random() * math.pi * 2
		local from = self.cf * Vector3.new(cos(a) * R * 0.75, sin(a) * R * 0.75, 0)
		local to = self.cf * Vector3.new(cos(a + 0.4) * R * (1.4 + math.random() * 0.5), sin(a + 0.4) * R * (1.4 + math.random() * 0.5), (math.random() - 0.5) * R * 0.3)
		local d = (to - from).Magnitude
		local arc = Instance.new("Part")
		arc.Material, arc.Color = Enum.Material.Neon, math.random() < 0.5 and rgb(255, 200, 255) or rgb(200, 120, 255)
		arc.Anchored, arc.CanCollide, arc.CanQuery, arc.CanTouch, arc.CastShadow = true, false, false, false, false
		arc.Size = Vector3.new(R * 0.03 + 0.08, R * 0.03 + 0.08, d)
		arc.CFrame = CFrame.lookAt((from + to) / 2, to)
		arc.Parent = self.folder
		TweenService:Create(arc, TweenInfo.new(0.14), {Transparency = 1}):Play()
		game:GetService("Debris"):AddItem(arc, 0.16)
	end
end

function BlackHole:open(dur)
	local tw = Instance.new("NumberValue")
	tw.Value = self.k
	tw.Changed:Connect(function(v) self.k = v end)
	TweenService:Create(tw, TweenInfo.new(dur or 1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Value = 1}):Play()
	game:GetService("Debris"):AddItem(tw, (dur or 1) + 0.1)
end
function BlackHole:close(dur, destroy)
	local tw = Instance.new("NumberValue")
	tw.Value = self.k
	tw.Changed:Connect(function(v) self.k = v end)
	TweenService:Create(tw, TweenInfo.new(dur or 0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Value = 0}):Play()
	if destroy then task.delay((dur or 0.6) + 0.05, function() self:destroy() end) end
end
function BlackHole:suck(strength) self.boost = strength or 1 end
function BlackHole:flare()
	self.boost = math.max(self.boost, 1)
	task.delay(0.6, function() if self.boost == 1 then self.boost = 0 end end)
	local f = Instance.new("Part")
	f.Shape = Enum.PartType.Ball
	f.Material, f.Color, f.Transparency = Enum.Material.Neon, rgb(255, 220, 255), 0.1
	f.Anchored, f.CanCollide, f.CanQuery, f.CanTouch, f.CastShadow = true, false, false, false, false
	f.Size = Vector3.one * self.radius
	f.CFrame = CFrame.new(self.cf.Position)
	f.Parent = self.folder
	TweenService:Create(f, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.one * self.radius * 4, Transparency = 1}):Play()
	game:GetService("Debris"):AddItem(f, 0.55)
end
function BlackHole:destroy()
	if self.conn then self.conn:Disconnect() self.conn = nil end
	if self.folder then self.folder:Destroy() self.folder = nil end
end
return BlackHole

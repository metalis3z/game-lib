-- BossStyles : chaque gardien de zone a son style (côté client uniquement, rien n'est créé sur le serveur).
--   * aura permanente à ses couleurs (particules, lumière) et titre en dégradé animé
--   * coup signature au repos toutes les 8 à 13 s : geste du squelette (AnimalAnimator) + effets
--   * quand il repère un voleur : version enragée du coup, sceau néon qui tourne sous ses pattes, traînée et aura de colère
-- Enregistré par MeshAnimalClient (gardiens en mesh) ; le Pumpking (squelette à part) est trouvé tout seul grâce à son tag.
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local M = {}
local rng = Random.new()
local V, V2, CF, C = Vector3.new, Vector2.new, CFrame.new, Color3.fromRGB
local ANG = CFrame.Angles
local TAU, rad = math.pi * 2, math.rad
local UP = V(0, 1, 0)
local WINDUP = 0.35  -- durée du rugissement de repérage (ZoneBossServer)
local VIEW = 450    -- au-delà, pas de coup spécial : personne ne le verrait
local TEX = {
	Spark = "rbxasset://textures/particles/sparkles_main.dds",
	Fire = "rbxasset://textures/particles/fire_main.dds",
	Smoke = "rbxasset://textures/particles/smoke_main.dds",
}

local function SZ(a, b) return NumberSequence.new({NumberSequenceKeypoint.new(0, a), NumberSequenceKeypoint.new(1, b or a)}) end
local function TR(a, b) return NumberSequence.new({NumberSequenceKeypoint.new(0, a), NumberSequenceKeypoint.new(0.6, a + (b - a) * 0.35), NumberSequenceKeypoint.new(1, b)}) end
local function CS(...)
	local list = {...}
	if #list == 1 then return ColorSequence.new(list[1]) end
	local keys = {}
	for i, c in list do table.insert(keys, ColorSequenceKeypoint.new((i - 1) / (#list - 1), c)) end
	return ColorSequence.new(keys)
end
local RAINBOW = CS(C(255, 110, 200), C(255, 230, 90), C(110, 240, 255), C(180, 120, 255), C(255, 110, 200))

---------------------------------------------------------------- briques d'effets
local fxFolder
local function folder()
	if not fxFolder or not fxFolder.Parent then
		fxFolder = Instance.new("Folder")
		fxFolder.Name = "BossFX_Local"
		fxFolder.Parent = workspace
	end
	return fxFolder
end

local function part(props)
	local p = Instance.new("Part")
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
	p.Material = Enum.Material.Neon
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	if props.Shape then p.Shape = props.Shape end
	for k, v in props do if k ~= "Shape" then p[k] = v end end
	p.Parent = folder()
	return p
end

local function tween(obj, t, goal, style, dir)
	local tw = TweenService:Create(obj, TweenInfo.new(t, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), goal)
	tw:Play()
	return tw
end

local function emitter(parent, o)
	local e = Instance.new("ParticleEmitter")
	e.Texture = o.tex or TEX.Spark
	e.Color = typeof(o.color) == "ColorSequence" and o.color or CS(o.color or C(255, 255, 255))
	e.Size = o.size or SZ(1)
	e.Transparency = o.transp or TR(0.1, 1)
	e.Lifetime = NumberRange.new(o.life and o.life[1] or 1, o.life and o.life[2] or 1.5)
	e.Speed = NumberRange.new(o.speed and o.speed[1] or 2, o.speed and o.speed[2] or 5)
	e.SpreadAngle = o.spread or V2(180, 180)
	e.Rate = o.rate or 0
	e.Acceleration = o.accel or Vector3.zero
	e.Drag = o.drag or 0
	e.RotSpeed = o.rotspeed or NumberRange.new(-60, 60)
	e.Rotation = NumberRange.new(0, 360)
	e.LightEmission = o.light or 0.6
	e.LightInfluence = o.lightInf or 0
	e.EmissionDirection = o.dir or Enum.NormalId.Top
	if o.shape then
		e.Shape = o.shape
		e.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
	end
	e.Enabled = o.enabled ~= false
	e.Parent = parent
	return e
end

-- jet de particules ponctuel à un endroit du monde
local function burstAt(pos, o, n)
	local p = part({Size = V(1, 1, 1), Transparency = 1, CFrame = CF(pos)})
	local a = Instance.new("Attachment")
	a.Parent = p
	o.enabled = false
	local e = emitter(a, o)
	e:Emit(n)
	Debris:AddItem(p, (o.life and o.life[2] or 1.5) + 0.3)
end

-- onde de choc : un disque néon qui s'élargit en s'effaçant
local function ring(pos, color, r0, r1, dur, o)
	o = o or {}
	local th = o.thick or 0.5
	local p = part({Shape = Enum.PartType.Cylinder, Color = color, Transparency = o.t0 or 0.1, Size = V(th, r0 * 2, r0 * 2),
		CFrame = CF(pos + V(0, 0.25, 0)) * ANG(0, 0, rad(90))})
	tween(p, dur, {Size = V(th * 0.4, r1 * 2, r1 * 2), Transparency = 1}, o.style or Enum.EasingStyle.Quart)
	Debris:AddItem(p, dur + 0.05)
end

local function sphere(pos, color, r0, r1, dur, t0, material)
	local p = part({Shape = Enum.PartType.Ball, Color = color, Transparency = t0 or 0.4, Material = material or Enum.Material.Neon,
		Size = V(r0, r0, r0) * 2, CFrame = CF(pos)})
	tween(p, dur, {Size = V(r1, r1, r1) * 2, Transparency = 1}, Enum.EasingStyle.Quart)
	Debris:AddItem(p, dur + 0.05)
end

-- colonne de lumière verticale (rayon céleste, pilier de flammes)
local function pillar(base, color, radius, height, dur)
	local p = part({Shape = Enum.PartType.Cylinder, Color = color, Transparency = 0.05, Size = V(height, 0.2, 0.2),
		CFrame = CF(base + V(0, height / 2, 0)) * ANG(0, 0, rad(90))})
	tween(p, dur * 0.2, {Size = V(height, radius * 2, radius * 2)}, Enum.EasingStyle.Back)
	task.delay(dur * 0.3, function()
		if p.Parent then tween(p, dur * 0.7, {Size = V(height, 0.05, 0.05), Transparency = 1}, Enum.EasingStyle.Quad, Enum.EasingDirection.In) end
	end)
	Debris:AddItem(p, dur + 0.1)
end

-- geyser : une colonne qui jaillit du sol vers le haut
local function geyser(base, color, radius, height, dur)
	for i, r in {radius, radius * 0.45} do
		local p = part({Shape = Enum.PartType.Cylinder, Color = i == 1 and color or C(255, 255, 255), Transparency = i == 1 and 0.25 or 0,
			Size = V(1, r * 2, r * 2), CFrame = CF(base + V(0, 0.5, 0)) * ANG(0, 0, rad(90))})
		tween(p, dur * 0.25, {Size = V(height, r * 2, r * 2), CFrame = CF(base + V(0, height / 2, 0)) * ANG(0, 0, rad(90))}, Enum.EasingStyle.Quart)
		task.delay(dur * 0.4, function()
			if p.Parent then
				tween(p, dur * 0.6, {Size = V(height * 0.6, r * 3, r * 3), CFrame = CF(base + V(0, height * 0.8, 0)) * ANG(0, 0, rad(90)), Transparency = 1})
			end
		end)
		Debris:AddItem(p, dur + 0.1)
	end
end

-- coup de griffe : une lame de lumière qui s'étire puis s'efface
local function slash(cf, color, len, dur, width)
	local p = part({Size = V(0.3, width or 1.5, 0.3), Color = color, CFrame = cf})
	tween(p, dur * 0.25, {Size = V(0.3, width or 1.5, len)}, Enum.EasingStyle.Quart)
	task.delay(dur * 0.25, function()
		if p.Parent then tween(p, dur * 0.75, {Size = V(0.05, 0.1, len * 1.15), Transparency = 1}) end
	end)
	Debris:AddItem(p, dur + 0.05)
end

-- obélisque doré qui sort du sol, flamboie au sommet, puis replonge
local function obelisk(pos, color, height, dur)
	local p = part({Size = V(1.8, height, 1.8), Color = color, CFrame = CF(pos - V(0, height / 2 + 0.5, 0))})
	tween(p, 0.3, {CFrame = CF(pos + V(0, height / 2, 0))}, Enum.EasingStyle.Back)
	local tip = part({Shape = Enum.PartType.Ball, Size = V(3, 3, 3), Color = C(255, 255, 230), Transparency = 1, CFrame = CF(pos + V(0, height + 1.5, 0))})
	task.delay(0.3, function()
		if tip.Parent then
			tip.Transparency = 0.1
			tween(tip, 0.5, {Size = V(0.4, 0.4, 0.4), Transparency = 0.6})
		end
	end)
	task.delay(dur * 0.7, function()
		if p.Parent then tween(p, dur * 0.3, {CFrame = CF(pos - V(0, height / 2 + 0.5, 0)), Transparency = 1}, Enum.EasingStyle.Quad, Enum.EasingDirection.In) end
	end)
	Debris:AddItem(p, dur + 0.1)
	Debris:AddItem(tip, dur)
end

-- rocher qui jaillit du sol (la terre se fend)
local function rock(pos, s, dur)
	local rot = ANG(rng:NextNumber(-0.6, 0.6), rng:NextNumber(0, TAU), rng:NextNumber(-0.6, 0.6))
	local p = part({Size = V(s, s * 1.6, s), Color = C(95, 80, 65), Material = Enum.Material.Slate, CFrame = CF(pos - V(0, s, 0)) * rot})
	tween(p, 0.12, {CFrame = CF(pos + V(0, s * 0.35, 0)) * rot}, Enum.EasingStyle.Back)
	ring(pos, C(255, 140, 40), 0.5, s * 1.2, 0.6, {thick = 0.2})
	task.delay(dur * 0.7, function()
		if p.Parent then tween(p, dur * 0.3, {CFrame = CF(pos - V(0, s, 0)) * rot, Transparency = 1}, Enum.EasingStyle.Quad, Enum.EasingDirection.In) end
	end)
	Debris:AddItem(p, dur + 0.1)
end

-- débris projetés (terre, glace, bonbons, citrouilles) : simulés ici, sans physique
local flying = {}
local function chunks(origin, n, o)
	for _ = 1, n do
		local s = (o.size or 1.5) * rng:NextNumber(0.6, 1.4)
		local p = part({Shape = o.ball and Enum.PartType.Ball or Enum.PartType.Block, Size = V(s, s, s), Color = o.colors[rng:NextInteger(1, #o.colors)],
			Material = o.material or Enum.Material.Neon, CFrame = CF(origin) * ANG(rng:NextNumber(0, TAU), rng:NextNumber(0, TAU), 0)})
		local a, out = rng:NextNumber(0, TAU), rng:NextNumber((o.spread or 20) * 0.4, o.spread or 20)
		table.insert(flying, {p = p, v = V(math.cos(a) * out, rng:NextNumber((o.up or 30) * 0.6, o.up or 30), math.sin(a) * out),
			w = V(rng:NextNumber(-8, 8), rng:NextNumber(-8, 8), rng:NextNumber(-8, 8)), t = 0, life = o.life or 1.6, g = o.gravity or 110})
	end
end
RunService.Heartbeat:Connect(function(dt)
	for i = #flying, 1, -1 do
		local f = flying[i]
		f.t += dt
		if f.t >= f.life or not f.p.Parent then
			f.p:Destroy()
			table.remove(flying, i)
		else
			f.v -= V(0, f.g * dt, 0)
			f.p.CFrame = (f.p.CFrame + f.v * dt) * ANG(f.w.X * dt, f.w.Y * dt, f.w.Z * dt)
			local fade = (f.t / f.life - 0.65) / 0.35
			if fade > 0 then f.p.Transparency = fade end
		end
	end
end)

local function flashLight(pos, color, brightness, range, dur)
	local p = part({Size = V(1, 1, 1), Transparency = 1, CFrame = CF(pos + V(0, 3, 0))})
	local l = Instance.new("PointLight")
	l.Color, l.Brightness, l.Range = color, brightness, range
	l.Parent = p
	tween(l, dur, {Brightness = 0})
	Debris:AddItem(p, dur + 0.05)
end

-- tremblement de caméra, plus fort quand on est près
local shakes = {}
local function shake(origin, power, dur)
	local cam = workspace.CurrentCamera
	if not cam then return end
	local k = math.clamp(1 - (cam.CFrame.Position - origin).Magnitude / 170, 0, 1)
	if k > 0 then table.insert(shakes, {p = power * k, dur = dur, t = 0, s = rng:NextNumber(0, 100)}) end
end
RunService:BindToRenderStep("BossStylesShake", Enum.RenderPriority.Camera.Value + 1, function(dt)
	if #shakes == 0 then return end
	local x, y = 0, 0
	for i = #shakes, 1, -1 do
		local s = shakes[i]
		s.t += dt
		if s.t >= s.dur then
			table.remove(shakes, i)
		else
			local a = s.p * (1 - s.t / s.dur) ^ 2
			x += math.noise(s.t * 28, s.s) * a
			y += math.noise(s.s, s.t * 28) * a
		end
	end
	local cam = workspace.CurrentCamera
	if cam then cam.CFrame = cam.CFrame * ANG(rad(y * 4), rad(x * 4), 0) end
end)

-- éclair coloré à l'écran pour les joueurs proches
local flashGui
local function screenFlash(origin, color, strength, dur)
	local cam = workspace.CurrentCamera
	if not cam or (cam.CFrame.Position - origin).Magnitude > 140 then return end
	local pg = Players.LocalPlayer and Players.LocalPlayer:FindFirstChild("PlayerGui")
	if not pg then return end
	if not flashGui or not flashGui.Parent then
		flashGui = Instance.new("ScreenGui")
		flashGui.Name = "BossFlashGui"
		flashGui.ResetOnSpawn = false
		flashGui.IgnoreGuiInset = true
		flashGui.DisplayOrder = 30
		flashGui.Parent = pg
	end
	local f = Instance.new("Frame")
	f.BorderSizePixel = 0
	f.Size = UDim2.fromScale(1, 1)
	f.BackgroundColor3 = color
	f.BackgroundTransparency = 1 - strength
	f.Parent = flashGui
	tween(f, dur, {BackgroundTransparency = 1})
	Debris:AddItem(f, dur + 0.05)
end

---------------------------------------------------------------- un gardien
local Boss = {}
Boss.__index = Boss

function Boss:size()
	if self.body then return self.body.Size end
	local _, s = self.model:GetBoundingBox()
	return s
end
function Boss:center()
	if self.body then return self.body.Position end
	return (self.model:GetBoundingBox()).Position
end
function Boss:feet() return self:center() - V(0, self:size().Y / 2, 0) end
function Boss:top() return self:center() + V(0, self:size().Y / 2, 0) end
function Boss:forward() -- la tête du mesh est vers son -Z
	local lv = (self.body and self.body.CFrame or self.root.CFrame).LookVector
	local f = V(lv.X, 0, lv.Z)
	return f.Magnitude > 1e-3 and f.Unit or V(0, 0, -1)
end
function Boss:front(dist) return self:feet() + self:forward() * dist end
function Boss:mouth()
	local fwd = self:forward()
	if self.head and self.head.Parent then return self.head.WorldPosition + fwd * 1.5 end
	local s = self:size()
	return self:center() + V(0, s.Y * 0.15, 0) + fwd * s.Z * 0.48
end
function Boss:near(r)
	local cam = workspace.CurrentCamera
	return cam ~= nil and (cam.CFrame.Position - self:center()).Magnitude < (r or VIEW)
end
function Boss:alive() return self.model.Parent ~= nil and self.root.Parent ~= nil and (self.body == nil or self.body.Parent ~= nil) end

-- points d'accroche des effets : "feet", "top", "center", "head" (l'os de la tête, il suit l'animation)
function Boss:anchor(kind)
	if self.anchors[kind] then return self.anchors[kind] end
	local a
	if kind == "head" and self.head then
		a = self.head
	else
		local s = self:size()
		local host = self.body or self.root
		local base = Vector3.zero
		if not self.body then -- Pumpking : on vise le centre de son modèle, pas sa racine
			local cf = self.model:GetBoundingBox()
			base = self.root.CFrame:VectorToObjectSpace(cf.Position - self.root.Position)
		end
		local back = self.body and 1 or 0 -- dans le repère du mesh, l'arrière est vers +Z
		local offsets = {feet = V(0, -s.Y / 2 + 1, s.Z * 0.15 * back), top = V(0, s.Y / 2, 0), center = Vector3.zero,
			head = V(0, s.Y * 0.15, -s.Z * 0.45 * back)}
		a = Instance.new("Attachment")
		a.Name = "BossFX_" .. kind
		a.Position = base + (offsets[kind] or Vector3.zero)
		a.Parent = host
		table.insert(self.owned, a)
	end
	self.anchors[kind] = a
	return a
end

-- émetteur permanent ("body" : dans tout le volume du corps) ; chase = seulement pendant la poursuite
function Boss:emit(kind, o, chase)
	local parent
	if kind == "body" then
		parent = self.body or self.root
		o.shape = Enum.ParticleEmitterShape.Box
	else
		parent = self:anchor(kind)
	end
	if chase then o.enabled = false end
	local e = emitter(parent, o)
	table.insert(self.owned, e)
	if chase then table.insert(self.chaseFx, e) end
	return e
end

function Boss:light(kind, color, brightness, range)
	local l = Instance.new("PointLight")
	l.Color, l.Brightness, l.Range, l.Shadows = color, brightness, range, false
	l.Parent = self:anchor(kind)
	table.insert(self.owned, l)
	return l
end

-- ruban lumineux derrière lui pendant la poursuite
function Boss:trail(color)
	local host, s = self.body or self.root, self:size()
	local back = self.body and s.Z * 0.2 or 0
	local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
	a0.Position, a1.Position = V(0, s.Y * 0.25, back), V(0, -s.Y * 0.25, back)
	a0.Parent, a1.Parent = host, host
	local t = Instance.new("Trail")
	t.Attachment0, t.Attachment1 = a0, a1
	t.Color = color
	t.LightEmission = 1
	t.Lifetime = 0.45
	t.MinLength = 0.2
	t.FaceCamera = true
	t.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1)})
	t.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.15)})
	t.Enabled = false
	t.Parent = host
	for _, i in {a0, a1, t} do table.insert(self.owned, i) end
	table.insert(self.chaseFx, t)
end

-- jet continu depuis la gueule (souffle), qui suit la tête pendant qu'elle balaie
local function stream(st, o, dur)
	local p = part({Size = V(1, 1, 1), Transparency = 1})
	local a = Instance.new("Attachment")
	a.Parent = p
	o.dir = Enum.NormalId.Front
	local e = emitter(a, o)
	local function place()
		local m = st:mouth()
		p.CFrame = CFrame.lookAt(m, m + st:forward() * 10 - V(0, 3.5, 0))
	end
	place()
	local t, conn = 0, nil
	conn = RunService.RenderStepped:Connect(function(dt)
		t += dt
		if t > dur or not st:alive() then
			e.Enabled = false
			conn:Disconnect()
			Debris:AddItem(p, 2)
			return
		end
		place()
	end)
end

-- sceau de rage : un cercle et une étoile en néon qui tournent sous ses pattes
local function buildSigil(color, radius)
	local pieces = {}
	local function bar(a, b, w)
		table.insert(pieces, {p = part({Size = V(w, 0.2, (b - a).Magnitude + 0.3), Color = color, Transparency = 1}), off = CFrame.lookAt((a + b) / 2, b)})
	end
	local function onCircle(a, r) return V(math.cos(a), 0, math.sin(a)) * r end
	for i = 0, 11 do bar(onCircle(i / 12 * TAU, radius), onCircle((i + 1) / 12 * TAU, radius), 0.7) end
	for i = 0, 11 do bar(onCircle(i / 12 * TAU, radius * 0.9), onCircle((i + 1) / 12 * TAU, radius * 0.9), 0.25) end
	for i = 0, 4 do bar(onCircle(i / 5 * TAU, radius * 0.86), onCircle((i + 2) / 5 * TAU, radius * 0.86), 0.45) end
	return pieces
end

function Boss:updateSigil(now)
	local w = self.rage
	if w < 0.02 then
		if self.sigilShown then
			self.sigilShown = false
			for _, s in self.sigil do s.p.Transparency = 1 end
		end
		return
	end
	self.sigilShown = true
	local c = self:center()
	if now >= (self.groundAt or 0) then -- le sceau reste au sol, même quand il s'envole
		self.groundAt = now + 0.2
		local hit = workspace:Raycast(c, V(0, -150, 0), self.rayParams)
		self.groundY = hit and hit.Position.Y or (c.Y - self:size().Y / 2)
	end
	local base = CF(c.X, self.groundY + 0.15, c.Z) * ANG(0, now * 1.4, 0)
	local tr = 1 - w * (0.75 + 0.15 * math.sin(now * 8))
	for i, s in self.sigil do
		s.p.CFrame = (i > 24 and CF(c.X, self.groundY + 0.15, c.Z) * ANG(0, -now * 2.1, 0) or base) * s.off
		s.p.Transparency = tr
	end
end

-- titre au-dessus de sa tête : dégradé à ses couleurs
function Boss:styleTitle()
	for _, d in self.root:GetChildren() do
		if d:IsA("BillboardGui") then
			local l = d:FindFirstChildOfClass("TextLabel")
			if l and l.Text == self.model.Name then
				local g = Instance.new("UIGradient")
				g.Color = self.def.title or CS(self.def.color, self.def.accent, self.def.color)
				g.Parent = l
				local stroke = l:FindFirstChildOfClass("UIStroke")
				if stroke then stroke.Color = self.def.dark or Color3.new() end
				self.gradient = g
				self.titled = true
				table.insert(self.owned, g)
				return
			end
		end
	end
end

function Boss:signature(power, gesture)
	local sig = self.def.sig
	self.busy = os.clock() + sig.dur + 0.5
	if gesture and self.anim and sig.gesture then self.anim:gesture(sig.gesture, sig.dur) end
	task.spawn(function()
		local ok, err = pcall(sig.fx, self, power, sig.dur)
		if not ok then warn("[BossStyles] " .. tostring(err)) end
	end)
end

-- il frappe le voleur (attribut SmashAt posé par ZoneBossServer) : geste d'attaque + gros impact là où le joueur a été touché
function Boss:smash(p)
	local sig = self.def.sig
	if self.anim and sig and sig.gesture then pcall(function() self.anim:gesture(sig.gesture, 0.7) end) end
	local color, accent = self.def.color, self.def.accent or Color3.new(1, 1, 1)
	ring(p, accent, 3, 42, 0.45, {thick = 0.9})
	ring(p, color, 2, 28, 0.7, {thick = 1.8, t0 = 0.05})
	burstAt(p, {tex = TEX.Smoke, color = color, size = SZ(4, 12), transp = TR(0.2, 1), life = {0.6, 1.2}, speed = {18, 42}, spread = V2(90, 90), drag = 3, light = 0.3}, 45)
	chunks(p, 12, {colors = {color, accent}, material = Enum.Material.Neon, size = 1.2, up = 50, spread = 26})
	shake(p, 2.2, 0.6)
	flashLight(p, accent, 9, 55, 0.35)
end

function Boss:destroy()
	for _, i in self.owned do i:Destroy() end
	for _, s in self.sigil do s.p:Destroy() end
end

---------------------------------------------------------------- les styles, un par gardien
local STYLES = {}

-- COMMON : la Vache géante, « Ruée du troupeau » : se cabre et frappe le sol, terre et herbe volent
STYLES.Cow = {
	color = C(225, 170, 100), accent = C(255, 248, 225), dark = C(70, 40, 20),
	aura = function(st)
		st:emit("feet", {tex = TEX.Smoke, color = C(170, 140, 100), size = SZ(3, 7), transp = TR(0.6, 1), life = {1, 1.6}, speed = {1, 3}, rate = 3, light = 0, lightInf = 1})
		st:emit("feet", {tex = TEX.Smoke, color = C(170, 140, 100), size = SZ(4, 11), transp = TR(0.4, 1), life = {0.8, 1.3}, speed = {4, 9}, rate = 30, light = 0, lightInf = 1}, true)
		st:emit("head", {tex = TEX.Smoke, color = C(255, 255, 255), size = SZ(1.5, 5), transp = TR(0.3, 1), life = {0.5, 0.9}, speed = {2, 4}, accel = V(0, 4, 0), rate = 14, light = 0.2}, true)
		st:trail(CS(C(255, 240, 210), C(170, 120, 70)))
	end,
	sig = {gesture = "Stomp", dur = 1.5, fx = function(st, k, dur)
		task.wait(dur * 0.57)
		if not st:alive() then return end
		local p = st:front(st:size().Z * 0.38)
		ring(p, C(255, 245, 215), 3, 30 * k, 0.55, {thick = 0.7})
		ring(p, C(160, 110, 60), 2, 20 * k, 0.8, {thick = 1.6, t0 = 0.05})
		chunks(p, math.floor(14 * k), {colors = {C(115, 80, 50), C(95, 150, 55), C(150, 110, 70)}, material = Enum.Material.Slate, size = 1.6, up = 45, spread = 22})
		burstAt(p, {tex = TEX.Smoke, color = C(200, 170, 130), size = SZ(5, 14), transp = TR(0.2, 1), life = {1, 1.8}, speed = {12, 28}, spread = V2(85, 85), drag = 3, light = 0, lightInf = 1}, math.floor(40 * k))
		shake(p, 1.0 * k, 0.5)
		flashLight(p, C(255, 230, 180), 6, 40, 0.4)
		task.wait(0.12)
		ring(p, C(255, 245, 215), 2, 45 * k, 0.8, {thick = 0.35})
	end},
}

-- UNCOMMON : le Tigre géant, « Furie de la jungle » : se ramasse, bondit, trois griffures de lumière
STYLES.Tiger = {
	color = C(255, 150, 40), accent = C(255, 235, 150), dark = C(60, 25, 0),
	aura = function(st)
		st:emit("body", {tex = TEX.Spark, color = C(120, 220, 80), size = SZ(0.9, 0.3), life = {1.5, 2.5}, speed = {0.5, 2}, accel = V(0, -2, 0), rate = 5, light = 0.3, rotspeed = NumberRange.new(-200, 200)})
		st:light("head", C(255, 160, 40), 1.5, 18)
		st:emit("body", {tex = TEX.Spark, color = CS(C(255, 230, 120), C(255, 120, 20)), size = SZ(1.4, 0), life = {0.25, 0.45}, speed = {0, 1}, rate = 60, light = 1}, true)
		st:trail(CS(C(255, 200, 80), C(255, 90, 10)))
	end,
	sig = {gesture = "Pounce", dur = 1.4, fx = function(st, k, dur)
		task.wait(dur * 0.38)
		if not st:alive() then return end
		burstAt(st:feet(), {tex = TEX.Spark, color = C(120, 220, 80), size = SZ(1.2, 0.4), life = {1, 1.8}, speed = {10, 25}, spread = V2(70, 70), accel = V(0, -15, 0), rotspeed = NumberRange.new(-300, 300), light = 0.3}, math.floor(30 * k))
		task.wait(dur * 0.2)
		if not st:alive() then return end
		local fwd, s = st:forward(), st:size()
		local right = fwd:Cross(UP).Unit
		local base = st:feet() + fwd * (s.Z * 0.6) + V(0, s.Y * 0.5, 0)
		local diag = (right * 0.8 - UP).Unit
		for i = -1, 1 do
			local c = base + right * i * 3 + UP * (i * 0.8)
			slash(CFrame.lookAt(c, c + diag), C(255, 140, 30), 18 * k, 0.55, 2.2)
			slash(CFrame.lookAt(c, c + diag), C(255, 255, 230), 17 * k, 0.45, 0.8)
		end
		burstAt(base, {tex = TEX.Spark, color = CS(C(255, 255, 200), C(255, 120, 20)), size = SZ(1.6, 0), life = {0.3, 0.6}, speed = {20, 40}, light = 1}, math.floor(40 * k))
		ring(st:front(s.Z * 0.6), C(255, 150, 40), 2, 18 * k, 0.5, {thick = 0.4})
		shake(base, 0.6 * k, 0.35)
	end},
}

-- RARE : le Requin géant, « Raz-de-marée » : se débat, gerbes d'eau et tourbillon
local function splash(p, k)
	burstAt(p, {tex = TEX.Spark, color = CS(C(255, 255, 255), C(120, 210, 255)), size = SZ(1.4, 0.4), life = {0.8, 1.3}, speed = {25, 45}, spread = V2(35, 35), accel = V(0, -70, 0), light = 0.6}, math.floor(70 * k))
	burstAt(p, {tex = TEX.Smoke, color = C(210, 240, 255), size = SZ(4, 10), transp = TR(0.4, 1), life = {0.6, 1}, speed = {8, 16}, spread = V2(80, 80), drag = 2, light = 0.2}, math.floor(20 * k))
	ring(p, C(120, 220, 255), 2, 22 * k, 0.6, {thick = 0.5})
	ring(p, C(255, 255, 255), 1, 14 * k, 0.45, {thick = 0.3})
end
STYLES.Shark = {
	color = C(60, 180, 255), accent = C(220, 250, 255), dark = C(0, 30, 70),
	aura = function(st)
		st:emit("body", {tex = TEX.Spark, color = C(170, 230, 255), size = SZ(0.7, 1.1), transp = TR(0.2, 1), life = {1.5, 2.5}, speed = {1, 2}, accel = V(0, 8, 0), rate = 8, light = 0.5})
		st:light("center", C(60, 170, 255), 2, 30)
		st:emit("feet", {tex = TEX.Spark, color = CS(C(255, 255, 255), C(100, 200, 255)), size = SZ(1.2, 0.3), life = {0.5, 0.9}, speed = {10, 20}, spread = V2(50, 50), accel = V(0, -40, 0), rate = 50, light = 0.6}, true)
		st:trail(CS(C(200, 245, 255), C(40, 150, 255)))
	end,
	sig = {gesture = "Thrash", dur = 1.4, fx = function(st, k, dur)
		task.wait(dur * 0.12)
		if not st:alive() then return end
		splash(st:feet(), k)
		task.wait(dur * 0.4)
		if not st:alive() then return end
		splash(st:front(st:size().Z * 0.3), k)
		for i = 1, 3 do -- tourbillon : des anneaux qui se resserrent
			ring(st:feet(), C(60, 180, 255), 24 * k - i * 5, 3, 0.5, {thick = 0.5, t0 = 0.3, style = Enum.EasingStyle.Sine})
			task.wait(0.12)
		end
		burstAt(st:feet(), {tex = TEX.Spark, color = C(190, 240, 255), size = SZ(1, 1.6), transp = TR(0.1, 1), life = {1.2, 2}, speed = {10, 20}, spread = V2(10, 10), accel = V(0, 15, 0), light = 0.5}, math.floor(40 * k))
		shake(st:feet(), 0.5 * k, 0.4)
	end},
}

-- EPIC : la Baleine géante, « Geyser glacial » : un geyser de glace jaillit de son évent
STYLES.Whale = {
	color = C(160, 230, 255), accent = C(255, 255, 255), dark = C(10, 50, 90),
	aura = function(st)
		st:emit("body", {tex = TEX.Spark, color = C(240, 250, 255), size = SZ(0.6, 0.4), life = {2, 3}, speed = {0.5, 1.5}, accel = V(0, -3, 0), rate = 10, light = 0.5, rotspeed = NumberRange.new(-90, 90)})
		st:light("center", C(150, 220, 255), 2, 32)
		st:emit("feet", {tex = TEX.Smoke, color = C(210, 240, 255), size = SZ(5, 12), transp = TR(0.5, 1), life = {1, 1.6}, speed = {2, 5}, rate = 25, light = 0.3}, true)
		st:trail(CS(C(255, 255, 255), C(130, 210, 255)))
	end,
	sig = {gesture = "Spout", dur = 1.8, fx = function(st, k, dur)
		task.wait(dur * 0.28)
		if not st:alive() then return end
		local s = st:size()
		local base = st:top() + st:forward() * (s.Z * 0.15)
		local h = 42 * k
		geyser(base, C(170, 235, 255), 2.4 * k, h, 1.6)
		burstAt(base + V(0, h, 0), {tex = TEX.Spark, color = C(255, 255, 255), size = SZ(1.2, 0.5), life = {1.5, 2.5}, speed = {15, 30}, accel = V(0, -18, 0), rotspeed = NumberRange.new(-120, 120), light = 0.6}, math.floor(80 * k))
		task.wait(0.35)
		chunks(base + V(0, h * 0.8, 0), math.floor(12 * k), {colors = {C(180, 235, 255), C(230, 250, 255)}, material = Enum.Material.Ice, size = 1.4, up = 20, spread = 25, life = 2.2, gravity = 60})
		ring(st:feet(), C(220, 245, 255), 3, 40 * k, 0.9, {thick = 0.5})
		screenFlash(st:center(), C(200, 240, 255), 0.18, 0.5)
	end},
}

-- LEGENDARY : le Sphinx géant, « Malédiction du pharaon » : révérence, obélisques d'or, rayon vers le ciel
STYLES.Sphinx = {
	color = C(255, 210, 70), accent = C(255, 250, 200), dark = C(80, 50, 0),
	aura = function(st)
		st:emit("body", {tex = TEX.Spark, color = C(255, 215, 90), size = SZ(0.8, 0), life = {1, 2}, speed = {0.5, 2}, accel = V(0, 3, 0), rate = 8, light = 1})
		st:emit("feet", {tex = TEX.Smoke, color = C(225, 195, 140), size = SZ(3, 8), transp = TR(0.6, 1), life = {1.2, 2}, speed = {2, 4}, rate = 3, light = 0, lightInf = 1, rotspeed = NumberRange.new(-120, 120)})
		st:light("head", C(255, 200, 80), 2, 24)
		st:emit("feet", {tex = TEX.Smoke, color = C(225, 195, 140), size = SZ(6, 14), transp = TR(0.4, 1), life = {1, 1.6}, speed = {4, 9}, rate = 30, light = 0, lightInf = 1}, true)
		st:trail(CS(C(255, 240, 160), C(255, 170, 30)))
	end,
	sig = {gesture = "Bow", dur = 2.0, fx = function(st, k, dur)
		task.wait(dur * 0.3)
		if not st:alive() then return end
		local feet = st:feet()
		ring(feet, C(255, 215, 80), 4, 30 * k, 1.1, {thick = 0.6})
		ring(feet, C(255, 250, 200), 2, 20 * k, 0.9, {thick = 0.35})
		for i = 1, 8 do
			local a = i / 8 * TAU
			obelisk(feet + V(math.cos(a), 0, math.sin(a)) * 24 * k, C(255, 205, 60), 9 * k, 1.4)
		end
		task.wait(dur * 0.25)
		if not st:alive() then return end
		local eye = st:mouth() + V(0, 2, 0)
		pillar(eye, C(255, 225, 120), 1.4, 80, 1.0)
		burstAt(feet, {tex = TEX.Smoke, color = C(230, 200, 140), size = SZ(6, 16), transp = TR(0.3, 1), life = {1.2, 2}, speed = {15, 30}, spread = V2(85, 85), drag = 2, light = 0, lightInf = 1, rotspeed = NumberRange.new(-200, 200)}, math.floor(30 * k))
		burstAt(eye, {tex = TEX.Spark, color = C(255, 230, 120), size = SZ(1.5, 0), life = {0.6, 1.2}, speed = {20, 40}, light = 1}, math.floor(50 * k))
		screenFlash(feet, C(255, 220, 120), 0.15, 0.6)
		shake(feet, 0.5 * k, 0.5)
	end},
}

-- MYTHIC : le Dragon de feu géant, « Souffle infernal » : jet de flammes qui balaie, le sol s'embrase
STYLES.FireDragon = {
	color = C(255, 110, 30), accent = C(255, 230, 90), dark = C(70, 10, 0),
	aura = function(st)
		st:emit("body", {tex = TEX.Spark, color = CS(C(255, 230, 120), C(255, 80, 10)), size = SZ(0.6, 0), life = {1, 2}, speed = {1, 3}, accel = V(0, 8, 0), rate = 14, light = 1})
		st:emit("head", {tex = TEX.Smoke, color = C(60, 40, 30), size = SZ(1.5, 4), transp = TR(0.5, 1), life = {1, 1.5}, speed = {2, 4}, accel = V(0, 5, 0), rate = 4, light = 0, lightInf = 1})
		st.flicker = st:light("center", C(255, 120, 30), 2.5, 34)
		st:emit("body", {tex = TEX.Fire, color = CS(C(255, 240, 120), C(255, 100, 20), C(120, 20, 0)), size = SZ(4, 0.5), life = {0.4, 0.7}, speed = {1, 3}, rate = 45, light = 1}, true)
		st:trail(CS(C(255, 230, 90), C(255, 60, 0)))
	end,
	sig = {gesture = "Breath", dur = 1.8, fx = function(st, k, dur)
		task.wait(dur * 0.12)
		if not st:alive() then return end
		local len = dur * 0.72
		stream(st, {tex = TEX.Fire, color = CS(C(255, 255, 200), C(255, 160, 30), C(200, 40, 0)), size = SZ(3 * k, 14 * k), transp = TR(0, 1), life = {0.55, 0.75}, speed = {80, 95}, spread = V2(8, 8), rate = 220, light = 1, drag = 1}, len)
		stream(st, {tex = TEX.Smoke, color = C(60, 40, 30), size = SZ(4, 14), transp = TR(0.5, 1), life = {0.9, 1.3}, speed = {40, 55}, spread = V2(14, 14), rate = 40, light = 0, lightInf = 1}, len)
		local t = 0
		while t < len and st:alive() do
			local p = st:front(st:size().Z * 0.5 + 22 + rng:NextNumber(-4, 10))
			ring(p, C(255, 120, 20), 1, 9 * k, 0.5, {thick = 0.4})
			burstAt(p, {tex = TEX.Spark, color = CS(C(255, 230, 120), C(255, 80, 10)), size = SZ(1, 0), life = {0.5, 1}, speed = {10, 25}, spread = V2(60, 60), accel = V(0, -20, 0), light = 1}, 15)
			shake(p, 0.25 * k, 0.3)
			t += task.wait(0.22)
		end
	end},
}

-- SECRET : le Cerbère géant, « Hurlement des enfers » : six piliers de feu infernal l'entourent
STYLES.Cerberus = {
	color = C(190, 60, 255), accent = C(255, 60, 80), dark = C(30, 0, 40),
	aura = function(st)
		st:emit("body", {tex = TEX.Smoke, color = C(50, 10, 70), size = SZ(4, 9), transp = TR(0.55, 1), life = {1.2, 2}, speed = {1, 2}, accel = V(0, 3, 0), rate = 6, light = 0, lightInf = 0})
		st:light("head", C(255, 40, 60), 2.5, 26)
		st:emit("feet", {tex = TEX.Fire, color = CS(C(255, 80, 120), C(160, 30, 255), C(40, 0, 60)), size = SZ(5, 0.5), life = {0.5, 0.8}, speed = {3, 7}, rate = 40, light = 1}, true)
		st:trail(CS(C(255, 60, 90), C(120, 0, 200)))
	end,
	sig = {gesture = "Howl", dur = 1.8, fx = function(st, k, dur)
		task.wait(dur * 0.28)
		if not st:alive() then return end
		local feet = st:feet()
		ring(feet, C(255, 40, 70), 3, 34 * k, 0.7, {thick = 0.6})
		sphere(st:center(), C(170, 40, 255), 4, 26 * k, 0.6, 0.4, Enum.Material.ForceField)
		screenFlash(feet, C(200, 0, 40), 0.22, 0.6)
		shake(feet, 0.8 * k, 0.6)
		for i = 1, 6 do
			local a = i / 6 * TAU + rng:NextNumber(-0.2, 0.2)
			local p = feet + V(math.cos(a), 0, math.sin(a)) * 20 * k
			pillar(p, C(170, 40, 255), 2.2, 28 * k, 1.1)
			burstAt(p, {tex = TEX.Fire, color = CS(C(255, 90, 140), C(150, 30, 255)), size = SZ(5, 1), life = {0.8, 1.2}, speed = {20, 35}, spread = V2(15, 15), light = 1}, 30)
			task.wait(0.06)
		end
		task.wait(0.25)
		if st:alive() then ring(st:feet(), C(190, 60, 255), 2, 40 * k, 0.8, {thick = 0.35}) end
	end},
}

-- ANCIENT : le T-Rex géant, « Rugissement d'extinction » : ondes de choc, la terre se fend devant lui
STYLES.TRex = {
	color = C(255, 175, 70), accent = C(170, 230, 100), dark = C(50, 30, 10),
	aura = function(st)
		st:emit("feet", {tex = TEX.Smoke, color = C(150, 130, 100), size = SZ(3, 7), transp = TR(0.6, 1), life = {1, 1.6}, speed = {1, 3}, rate = 3, light = 0, lightInf = 1})
		st:emit("body", {tex = TEX.Spark, color = C(120, 190, 70), size = SZ(1, 0.4), life = {2, 3}, speed = {0.5, 1}, accel = V(0, -3, 0), rate = 3, light = 0.2, rotspeed = NumberRange.new(-200, 200)})
		st:emit("feet", {tex = TEX.Smoke, color = C(150, 130, 100), size = SZ(6, 14), transp = TR(0.4, 1), life = {1, 1.5}, speed = {5, 10}, rate = 35, light = 0, lightInf = 1}, true)
		st:trail(CS(C(255, 200, 120), C(140, 90, 40)))
	end,
	sig = {gesture = "Howl", dur = 2.0, fx = function(st, k, dur)
		task.wait(dur * 0.2)
		if not st:alive() then return end
		shake(st:center(), 1.6 * k, 1.3)
		for i = 1, 3 do
			sphere(st:mouth(), C(255, 230, 190), 2, 22 * k + i * 6, 0.55, 0.55, Enum.Material.ForceField)
			task.wait(0.14)
		end
		local fwd, origin = st:forward(), st:front(st:size().Z * 0.5)
		for i = 1, 10 do
			if not st:alive() then return end
			local p = origin + fwd * (i * 5 * k) + fwd:Cross(UP) * rng:NextNumber(-2.5, 2.5)
			rock(p, rng:NextNumber(2.5, 4.5) * k, 1.4)
			burstAt(p, {tex = TEX.Smoke, color = C(140, 120, 95), size = SZ(4, 10), transp = TR(0.3, 1), life = {0.8, 1.3}, speed = {8, 16}, spread = V2(60, 60), drag = 2, light = 0, lightInf = 1}, 10)
			task.wait(0.05)
		end
		burstAt(st:top(), {tex = TEX.Spark, color = C(120, 190, 70), size = SZ(1.2, 0.5), life = {2, 3}, speed = {10, 20}, accel = V(0, -8, 0), rotspeed = NumberRange.new(-250, 250), light = 0.2}, 40)
	end},
}

-- OG : le Dragon en sucre d'orge géant, « Sugar Rush » : tourbillon, explosion de confettis et de bonbons
STYLES.RockCandyDragon = {
	color = C(255, 130, 220), accent = C(120, 235, 255), dark = C(90, 0, 70), title = RAINBOW,
	aura = function(st)
		st:emit("body", {tex = TEX.Spark, color = RAINBOW, size = SZ(0.9, 0), life = {1, 1.8}, speed = {1, 3}, rate = 14, light = 1})
		st:light("center", C(255, 150, 230), 2, 30)
		st:emit("body", {tex = TEX.Spark, color = RAINBOW, size = SZ(1.4, 0), life = {0.5, 0.9}, speed = {1, 3}, rate = 60, light = 1}, true)
		st:trail(RAINBOW)
	end,
	sig = {gesture = "Spin", dur = 1.4, fx = function(st, k, dur)
		task.wait(dur * 0.45)
		if not st:alive() then return end
		local c = st:center()
		burstAt(c, {tex = TEX.Spark, color = RAINBOW, size = SZ(1.6, 0.6), life = {1.2, 2}, speed = {30, 55}, accel = V(0, -25, 0), drag = 1.5, rotspeed = NumberRange.new(-400, 400), light = 1}, math.floor(140 * k))
		chunks(c, math.floor(16 * k), {colors = {C(255, 120, 210), C(120, 235, 255), C(255, 235, 110), C(190, 140, 255)}, ball = true, size = 1.6, up = 40, spread = 30, life = 1.8})
		local feet = st:feet()
		for i, col in {C(255, 120, 210), C(255, 235, 110), C(120, 235, 255)} do
			ring(feet, col, 3, (22 + i * 8) * k, 0.7, {thick = 0.5})
			task.wait(0.09)
		end
		screenFlash(c, C(255, 170, 230), 0.14, 0.5)
		shake(c, 0.5 * k, 0.4)
	end},
}

-- DIVINE : le Dragon ange géant, « Jugement divin » : un rayon céleste l'illumine, puis frappe autour de lui
STYLES.Dragon = {
	color = C(255, 225, 130), accent = C(255, 255, 255), dark = C(90, 60, 0),
	aura = function(st)
		st:emit("body", {tex = TEX.Spark, color = C(255, 235, 160), size = SZ(0.8, 0), life = {1.2, 2}, speed = {0.5, 2}, accel = V(0, 4, 0), rate = 12, light = 1})
		st:emit("body", {tex = TEX.Spark, color = C(255, 255, 255), size = SZ(1.6, 1), transp = TR(0.2, 1), life = {3, 4}, speed = {0.5, 1}, accel = V(0, -2, 0), rate = 2, light = 0.5})
		st:light("center", C(255, 235, 170), 3, 38)
		st:emit("body", {tex = TEX.Spark, color = CS(C(255, 255, 255), C(255, 200, 80)), size = SZ(1.4, 0), life = {0.5, 0.9}, speed = {1, 3}, rate = 50, light = 1}, true)
		st:trail(CS(C(255, 255, 255), C(255, 200, 80)))
	end,
	sig = {gesture = "Howl", dur = 2.0, fx = function(st, k, dur)
		task.wait(dur * 0.15)
		if not st:alive() then return end
		local feet = st:feet()
		pillar(feet, C(255, 240, 180), 7 * k, 220, 1.3)
		pillar(feet, C(255, 255, 255), 3.5 * k, 220, 1.1)
		ring(feet, C(255, 220, 120), 4, 36 * k, 0.9, {thick = 0.6})
		burstAt(st:center(), {tex = TEX.Spark, color = C(255, 255, 255), size = SZ(1.8, 1), transp = TR(0.1, 1), life = {2, 3}, speed = {8, 18}, accel = V(0, -4, 0), rotspeed = NumberRange.new(-120, 120), light = 0.7}, math.floor(50 * k))
		screenFlash(feet, C(255, 250, 220), 0.3, 0.7)
		shake(feet, 0.7 * k, 0.5)
		task.wait(dur * 0.2)
		for _ = 1, 5 do
			if not st:alive() then return end
			local a, r = rng:NextNumber(0, TAU), rng:NextNumber(14, 34) * k
			local p = st:feet() + V(math.cos(a), 0, math.sin(a)) * r
			pillar(p, C(255, 235, 150), 1.8, 160, 0.6)
			ring(p, C(255, 255, 255), 1, 10, 0.45, {thick = 0.4})
			burstAt(p, {tex = TEX.Spark, color = C(255, 230, 140), size = SZ(1.2, 0), life = {0.4, 0.8}, speed = {15, 30}, spread = V2(70, 70), light = 1}, 20)
			task.wait(0.13)
		end
	end},
}

-- HALLOWEEN : le Pumpking, « Nova citrouille » : flammes spectrales et citrouilles qui volent
STYLES.Pumpking = {
	color = C(120, 255, 100), accent = C(255, 150, 30), dark = C(20, 50, 0),
	aura = function(st)
		st:emit("top", {tex = TEX.Fire, color = CS(C(200, 255, 160), C(60, 220, 60), C(0, 80, 20)), size = SZ(4, 0.5), life = {0.6, 1}, speed = {4, 8}, spread = V2(15, 15), rate = 25, light = 1})
		st:light("center", C(100, 255, 90), 2.5, 34)
		st:emit("feet", {tex = TEX.Smoke, color = C(90, 160, 80), size = SZ(5, 10), transp = TR(0.6, 1), life = {1.5, 2.5}, speed = {1, 3}, rate = 4, light = 0.3})
		st:emit("feet", {tex = TEX.Fire, color = CS(C(200, 255, 160), C(60, 220, 60)), size = SZ(5, 0.5), life = {0.5, 0.8}, speed = {3, 7}, rate = 40, light = 1}, true)
		st:trail(CS(C(160, 255, 120), C(255, 140, 20)))
	end,
	sig = {dur = 1.5, fx = function(st, k)
		local feet = st:feet()
		ring(feet, C(120, 255, 100), 3, 36 * k, 0.8, {thick = 0.6})
		ring(feet, C(255, 150, 30), 2, 26 * k, 0.65, {thick = 1})
		burstAt(st:center(), {tex = TEX.Fire, color = CS(C(220, 255, 180), C(60, 220, 60)), size = SZ(6, 1), life = {0.8, 1.3}, speed = {20, 40}, spread = V2(80, 80), light = 1}, math.floor(60 * k))
		chunks(st:top(), math.floor(10 * k), {colors = {C(255, 140, 20), C(255, 170, 40)}, ball = true, size = 2.2, up = 45, spread = 25, life = 2})
		screenFlash(feet, C(80, 255, 80), 0.14, 0.5)
		shake(feet, 0.7 * k, 0.5)
	end},
}
M.Styles = STYLES

---------------------------------------------------------------- enregistrement et boucle
local list = {}
function M.register(model, anim)
	local old = list[model]
	if old and old:alive() then
		old.anim = anim or old.anim
		return
	elseif old then -- le corps a été déchargé puis rechargé (streaming) : on refait ses effets
		old:destroy()
		list[model] = nil
	end
	local key = model:GetAttribute("Rig") == "Pumpking" and "Pumpking" or model:GetAttribute("Kit")
	local def = STYLES[key] or STYLES.Cow
	local root = model.PrimaryPart or model:FindFirstChild("Root") or model:FindFirstChildWhichIsA("BasePart", true)
	if not root then return end
	local body = model:FindFirstChild("Body")
	if body and not body:IsA("MeshPart") then body = nil end
	local st = setmetatable({model = model, anim = anim, root = root, body = body, def = def, owned = {}, chaseFx = {}, anchors = {},
		rage = 0, chasing = false, busy = 0, nextSig = os.clock() + rng:NextNumber(1.5, 4), speed = 0, last = root.Position, seed = rng:NextNumber(0, 100)}, Boss)
	if body then -- la tête : l'os du milieu le plus en avant
		local best, bestZ
		for _, b in body:GetDescendants() do
			if b:IsA("Bone") then
				local p = body.CFrame:PointToObjectSpace(b.WorldPosition)
				if math.abs(p.X) < body.Size.X * 0.04 + 0.1 and (not bestZ or p.Z < bestZ) then best, bestZ = b, p.Z end
			end
		end
		st.head = best
	end
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {model, folder()}
	st.rayParams = params
	local s = st:size()
	st.sigil = buildSigil(def.color, math.max(s.X, s.Z) * 0.5)
	local ok, err = pcall(def.aura, st)
	if not ok then warn("[BossStyles] aura " .. tostring(key) .. " : " .. tostring(err)) end
	list[model] = st
	model:GetAttributeChangedSignal("SmashAt"):Connect(function()
		local p = model:GetAttribute("SmashAt")
		if typeof(p) == "Vector3" and list[model] == st then
			local ok, e = pcall(st.smash, st, p)
			if not ok then warn("[BossStyles] smash : " .. tostring(e)) end
		end
	end)
end

RunService.RenderStepped:Connect(function(dt)
	if dt <= 0 then return end
	local now = os.clock()
	for model, st in list do
		if not st:alive() then
			st:destroy()
			list[model] = nil
			continue
		end
		local pos = st.root.Position
		st.speed += (V(pos.X - st.last.X, 0, pos.Z - st.last.Z).Magnitude / dt - st.speed) * math.min(1, dt * 6)
		st.last = pos
		local chasing = model:GetAttribute("Chasing") == true
		if chasing ~= st.chasing then
			st.chasing = chasing
			for _, e in st.chaseFx do e.Enabled = chasing end
			if chasing then -- repéré : version enragée de son coup, juste après le rugissement
				task.delay(WINDUP * 0.75, function()
					if st.chasing and st:alive() and st:near() then st:signature(1.5, false) end
				end)
			else
				st.nextSig = now + rng:NextNumber(4, 7)
			end
		end
		st.rage += ((chasing and 1 or 0) - st.rage) * math.min(1, dt * 4)
		st:updateSigil(now)
		if st.flicker then st.flicker.Brightness = 2.4 + math.noise(now * 6, st.seed) * 2.5 + st.rage * 2 end
		if st.gradient then st.gradient.Offset = V2(math.sin(now * 1.6) * 0.6, 0) end
		if not st.titled and now > (st.titleTry or 0) then
			st.titleTry = now + 1
			st:styleTitle()
		end
		-- coup signature au repos : de préférence quand il marque une pause
		if not chasing and now >= st.nextSig and now >= st.busy and not model:GetAttribute("Flying") then
			if not st:near() then
				st.nextSig = now + 2
			elseif st.speed < 3 or now > st.nextSig + 1.5 then
				st:signature(1, true)
				st.nextSig = now + rng:NextNumber(6, 9)
			end
		end
	end
end)

-- le Pumpking a son propre squelette (PumpkingClient) : on le trouve par son tag
task.spawn(function()
	while true do
		for _, m in CollectionService:GetTagged("ZoneBoss") do
			if m:GetAttribute("Rig") == "Pumpking" and not list[m] and m:IsDescendantOf(workspace) and m:FindFirstChildWhichIsA("BasePart", true) then
				M.register(m, nil)
			end
		end
		task.wait(1)
	end
end)

return M

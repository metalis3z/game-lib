-- FightFilm.Fx : contrôleur des effets. Il ne touche jamais aux originaux : il clone les copies rangées dans
-- ReplicatedStorage.FightFilm.Vfx (elles-mêmes copiées de Workspace["ALL VFX"]) et nettoie ses clones.
--   Fx.burst(nom, cframe, o)      effet ponctuel posé dans le monde (impact, explosion, fissure...)
--   Fx.attach(nom, pièce, o)      effet continu accroché à une pièce qui bouge (main, lame) -> handle:stop()
--   Fx.aura(dossier, acteur, o)   aura sur tout le corps -> handle:stop()
--   Fx.mesh(nom, cframe, o)       maillage qui grandit et s'efface (onde de choc, slash, vent)
--   Fx.projectile(from, to, t, o) projectile avec traînée, puis callback à l'arrivée
--   Fx.light(position, couleur, portée, intensité, durée)  éclair de lumière bref
-- o.scale grossit l'effet, o.color le teinte (les particules noires restent noires), o.mult multiplie le nombre de particules.
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local Kit = require(script.Parent:WaitForChild("Kit"))
local lib = script.Parent:WaitForChild("Vfx")
local meshes = lib:WaitForChild("Meshes")

local Fx = {}
local warned = {}
local function find(folder, name)
	local item = folder:FindFirstChild(name)
	if not item and not warned[name] then
		warned[name] = true
		warn("[FightFilm.Fx] effet introuvable : " .. tostring(name))
	end
	return item
end

local function scaleSequence(seq, k)
	local points = {}
	for _, p in seq.Keypoints do table.insert(points, NumberSequenceKeypoint.new(p.Time, p.Value * k, p.Envelope * k)) end
	return NumberSequence.new(points)
end
local function tune(e, o)
	local k = o.scale
	if k and k ~= 1 then
		e.Size = scaleSequence(e.Size, k)
		e.Speed = NumberRange.new(e.Speed.Min * k, e.Speed.Max * k)
		e.Acceleration = e.Acceleration * k
	end
	if o.color then
		local first = e.Color.Keypoints[1].Value
		if first.R + first.G + first.B > 0.25 then e.Color = ColorSequence.new(o.color) end
	end
	if o.rate then e.Rate *= o.rate end
end

-- allume tout ce que contient un clone ; renvoie la durée de vie la plus longue et la liste des émetteurs continus
local function fire(clone, o)
	local life, loops = 0, {}
	for _, d in clone:GetDescendants() do
		if d:IsA("ParticleEmitter") then
			tune(d, o)
			life = math.max(life, d.Lifetime.Max)
			local n = d:GetAttribute("EmitCount")
			if d:GetAttribute("Loop") then
				d.Enabled = true
				table.insert(loops, d)
			elseif not Kit.fast() then
				d:Emit(math.max(1, math.ceil((n and n > 0 and n or (o.count or 1)) * (o.mult or 1))))
			end
		elseif d:IsA("Beam") or d:IsA("Trail") then
			d.Enabled = true
			table.insert(loops, d)
		end
	end
	return life, loops
end

function Fx.burst(name, cf, o)
	o = o or {}
	local src = find(lib, name)
	if not src or not Kit.scene then return nil end
	local clone = src:Clone()
	clone.CFrame = typeof(cf) == "Vector3" and CFrame.new(cf) or cf
	clone.Parent = Kit.scene
	local life, loops = fire(clone, o)
	local hold = o.time or 0.25
	if #loops > 0 then
		task.delay(hold, function() for _, e in loops do e.Enabled = false end end)
	end
	Debris:AddItem(clone, (#loops > 0 and hold or 0) + life + 0.4)
	return clone
end

-- effet continu accroché à une pièce : les émetteurs sont recopiés dans un Attachment de cette pièce, ils la suivent
function Fx.attach(name, part, o)
	o = o or {}
	local src = find(lib, name)
	if not src or not part then return {stop = function() end} end
	local holder = Instance.new("Attachment")
	holder.Name = "Fx_" .. name
	holder.CFrame = o.offset or CFrame.new()
	holder.Parent = part
	local life, list = 0, {}
	for _, d in src:GetDescendants() do
		if d:IsA("ParticleEmitter") then
			local e = d:Clone()
			tune(e, o)
			life = math.max(life, e.Lifetime.Max)
			e.Parent = holder
			if o.pulse then
				if not Kit.fast() then e:Emit(math.max(1, math.ceil((e:GetAttribute("EmitCount") or 1) * (o.mult or 1)))) end
			else
				if not e:GetAttribute("Loop") then e.Rate = math.max(e.Rate, 8) end
				e.Enabled = true
			end
			table.insert(list, e)
		end
	end
	local handle = {}
	function handle.stop()
		for _, e in list do e.Enabled = false end
		Debris:AddItem(holder, life + 0.3)
	end
	if o.time then task.delay(o.time, handle.stop) end
	if o.pulse then Debris:AddItem(holder, life + 0.5) end
	return handle
end

-- aura sur tout le corps : chaque émetteur va sur son membre (les noms R6 sont convertis pour un R15)
local LIMB_R15 = {Head = "Head", Torso = "UpperTorso", ["Left Arm"] = "LeftLowerArm", ["Right Arm"] = "RightLowerArm", ["Left Leg"] = "LeftLowerLeg", ["Right Leg"] = "RightLowerLeg"}
function Fx.aura(name, actor, o)
	o = o or {}
	local src = find(lib, name)
	local list, life = {}, 0
	if src then
		for _, d in src:GetChildren() do
			local limb = d:IsA("ParticleEmitter") and d:GetAttribute("Limb")
			local part = limb and (actor.rig:FindFirstChild(limb) or actor.rig:FindFirstChild(LIMB_R15[limb] or ""))
			if part and not (o.limbs and not o.limbs[limb]) then
				local e = d:Clone()
				tune(e, o)
				life = math.max(life, e.Lifetime.Max)
				e.Enabled = true
				e.Parent = part
				table.insert(list, e)
			end
		end
	end
	local handle = {}
	function handle.stop()
		for _, e in list do e.Enabled = false Debris:AddItem(e, life + 0.3) end
	end
	if o.time then task.delay(o.time, handle.stop) end
	return handle
end

-- maillage animé : part de size0, grandit jusqu'à size1 en s'effaçant. o.spin = tours par seconde autour de son axe Y
function Fx.mesh(name, cf, o)
	o = o or {}
	local src = find(meshes, name)
	if not src or not Kit.scene or Kit.fast() then return nil end
	local m = src:Clone()
	local base = src.Size
	local function sizeOf(v) return typeof(v) == "Vector3" and v or base * (v or 1) end
	local s0, s1 = sizeOf(o.size0 or 0.2), sizeOf(o.size1 or 1.5)
	local t0, t1 = o.transp0 or 0.1, o.transp1 or 1
	cf = typeof(cf) == "Vector3" and CFrame.new(cf) or cf
	m.Size, m.CFrame, m.Transparency = s0, cf, t0
	m.Color = o.color or m.Color
	m.Material = o.material or Enum.Material.Neon
	m.Parent = Kit.scene
	local spin = (o.spin or 0) * math.pi * 2
	local dur = o.time or 0.4
	Kit.tween(dur, function(e, u)
		m.Size = s0:Lerp(s1, e)
		m.Transparency = t0 + (t1 - t0) * (o.fadeLate and math.max(0, (u - 0.4) / 0.6) or u)
		m.CFrame = (o.follow and o.follow() or cf) * CFrame.Angles(0, spin * u * dur, 0)
	end, o.ease or "outCubic", function() m:Destroy() end)
	return m
end

function Fx.light(where, color, range, brightness, time)
	if Kit.fast() or not Kit.scene then return end
	local holder
	if typeof(where) == "Vector3" then
		holder = Instance.new("Part")
		holder.Anchored, holder.CanCollide, holder.CanQuery, holder.CanTouch, holder.Transparency = true, false, false, false, 1
		holder.Size = Vector3.one * 0.2
		holder.Position = where
		holder.Parent = Kit.scene
		Debris:AddItem(holder, (time or 0.4) + 0.1)
	else
		holder = where
	end
	local l = Instance.new("PointLight")
	l.Color, l.Range, l.Brightness, l.Shadows = color, range or 16, brightness or 4, false
	l.Parent = holder
	TweenService:Create(l, TweenInfo.new(time or 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Brightness = 0}):Play()
	Debris:AddItem(l, (time or 0.4) + 0.05)
	return l
end

-- projectile : le modèle "Projectile" de la bibliothèque (fumée, étincelles, traînée) vole de from à to
function Fx.projectile(from, to, time, o)
	o = o or {}
	local src = find(lib, o.name or "Projectile")
	if not src or not Kit.scene then if o.done then Kit.delay(time, o.done) end return end
	local p = src:Clone()
	p.CFrame = CFrame.lookAt(from, to)
	p.Parent = Kit.scene
	local core = Instance.new("Part")
	core.Shape = Enum.PartType.Ball
	core.Size = Vector3.one * (o.size or 1.1)
	core.Material, core.Color = Enum.Material.Neon, o.color or Color3.fromRGB(190, 110, 255)
	core.Anchored, core.CanCollide, core.CanQuery, core.CanTouch, core.CastShadow = true, false, false, false, false
	core.Parent = p
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = core.Color, 14, 3, false
	light.Parent = core
	local life, loops = 0, {}
	for _, d in p:GetDescendants() do
		if d:IsA("ParticleEmitter") then
			tune(d, o)
			life = math.max(life, d.Lifetime.Max)
			d.Rate = math.min(d.Rate, 40)
			d.Enabled = true
			table.insert(loops, d)
		elseif d:IsA("Trail") then
			d.Enabled = true
			if o.color then d.Color = ColorSequence.new(o.color) end
		end
	end
	Kit.tween(time, function(e)
		local pos = from:Lerp(to, e) + Vector3.new(0, (o.arc or 0) * 4 * e * (1 - e), 0)
		p.CFrame = CFrame.lookAt(pos, pos + (to - from))
		core.CFrame = p.CFrame
	end, o.ease or "linear", function()
		for _, e in loops do e.Enabled = false end
		core:Destroy()
		Debris:AddItem(p, life + 0.3)
		if o.done then o.done(to) end
	end)
	return p
end

-- traînée de lame : deux Attachments le long de la lame, la Trail est allumée pendant les coups
function Fx.bladeTrail(blade, near, far, color)
	local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
	a0.Position, a1.Position = near, far
	a0.Parent, a1.Parent = blade, blade
	local trail = Instance.new("Trail")
	trail.Attachment0, trail.Attachment1 = a0, a1
	trail.Lifetime = 0.16
	trail.MinLength = 0.05
	trail.LightEmission, trail.LightInfluence = 1, 0
	trail.FaceCamera = false
	trail.Color = ColorSequence.new(color or Color3.fromRGB(210, 240, 255))
	trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 1)})
	trail.Enabled = false
	trail.Parent = blade
	return trail
end

return Fx

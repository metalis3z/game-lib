-- Effets propres à chaque dragon, dessinés côté client en gros blocs (style du jeu) :
--  * projectiles crachés par la gueule (éclats de glace, braises, étoiles, feuilles...)
--  * impact au sol là où le souffle touche (pics de glace, flaque de lave, trou noir, colonne de lumière...)
--  * satellites qui tournent autour du dragon
--  * arcs électriques et éclairs du Thunder Dragon
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

local TAG = "RideDragon"
local MAX_DISTANCE = 320
local IMPACT_INTERVAL = 0.2
local BLOCK_PROJECTILES = true -- projectiles en blocs crachés par la gueule (remplacés par les flammes animées du serveur)
local rng = Random.new()
local V, rad, rgb = Vector3.new, math.rad, Color3.fromRGB
local Mat = Enum.Material
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)

local folder = Instance.new("Folder")
folder.Name = "DragonVfx"
folder.Parent = workspace

local function newPart(size, cf, color, material, transparency, shape)
	local part = Instance.new("Part")
	part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.CastShadow = true, false, false, false, false
	part.TopSurface, part.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	if shape then part.Shape = shape end
	part.Material = material or Mat.Neon
	part.Color = color
	part.Transparency = transparency or 0
	part.Size = size
	part.CFrame = cf
	part.Parent = folder
	return part
end

local function randomUnit() return V(rng:NextNumber(-1, 1), rng:NextNumber(-1, 1), rng:NextNumber(-1, 1)).Unit end
local function randomSpin() return CFrame.Angles(rng:NextNumber(0, 6.28), rng:NextNumber(0, 6.28), rng:NextNumber(0, 6.28)) end
local function pick(list) return list[rng:NextInteger(1, #list)] end
-- repère dont l'axe "haut" suit la normale du sol
local function upright(position, normal)
	local right = normal:Cross(Vector3.zAxis)
	if right.Magnitude < 0.05 then right = normal:Cross(Vector3.xAxis) end
	return CFrame.fromMatrix(position, right.Unit, normal)
end

---------------------------------------------------------------- particules en blocs (projectiles, éclaboussures)
local motes = {}
-- style = {Color, Material, Transparency} ; opts = {Gravity, Spin, Grow, Fade, Aligned}
local function mote(position, velocity, size, life, style, opts)
	opts = opts or {}
	local cf = opts.Aligned and CFrame.lookAlong(position, velocity) or CFrame.new(position) * randomSpin()
	local part = newPart(size, cf, style[1], style[2], style[3])
	table.insert(motes, {
		Part = part, Position = position, Velocity = velocity, Rotation = cf.Rotation, Size = size, Life = life, Age = 0, Base = style[3] or 0,
		Gravity = opts.Gravity or 0, Spin = opts.Spin and randomUnit() * opts.Spin or nil, Grow = opts.Grow or 1, Fade = opts.Fade, Aligned = opts.Aligned,
	})
end

local function updateMotes(dt)
	for i = #motes, 1, -1 do
		local m = motes[i]
		m.Age += dt
		if m.Age >= m.Life then
			m.Part:Destroy()
			table.remove(motes, i)
			continue
		end
		local t = m.Age / m.Life
		m.Velocity -= V(0, m.Gravity * dt, 0)
		m.Position += m.Velocity * dt
		if m.Spin then m.Rotation = CFrame.fromAxisAngle(m.Spin.Unit, m.Spin.Magnitude * dt) * m.Rotation end
		if m.Aligned and m.Gravity ~= 0 then m.Rotation = CFrame.lookAlong(Vector3.zero, m.Velocity).Rotation end
		local scale = 1 + (m.Grow - 1) * t
		if not m.Fade and t > 0.7 then scale *= (1 - t) / 0.3 end -- rétrécit à la fin
		m.Part.Size = m.Size * math.max(scale, 0.02)
		m.Part.CFrame = CFrame.new(m.Position) * m.Rotation
		if m.Fade then m.Part.Transparency = m.Base + (1 - m.Base) * t * t end
	end
end

---------------------------------------------------------------- effets d'impact
-- blocs qui poussent du sol : pics de glace, cristaux, ronces, flammes...
local lightOnly = false -- vrai quand un impact vient d'avoir lieu au même endroit
local function sprout(position, normal, spec, unit)
	if lightOnly and spec.Life > 0.6 then return end
	for _ = 1, spec.Count do
		local style = pick(spec.Styles)
		local height = rng:NextNumber(spec.Height[1], spec.Height[2]) * unit
		local width = spec.Width * unit * rng:NextNumber(0.75, 1.2)
		local offset = V(rng:NextNumber(-1, 1), 0, rng:NextNumber(-1, 1)) * spec.Radius * unit
		local base = upright(position, normal) * CFrame.new(offset) * CFrame.Angles(rad(rng:NextNumber(-spec.Tilt, spec.Tilt)), rad(spec.Twist or rng:NextNumber(0, 90)), rad(rng:NextNumber(-spec.Tilt, spec.Tilt)))
		local part = newPart(V(width, 0.05, width), base, style[1], style[2], style[3])
		TweenService:Create(part, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = V(width, height, width), CFrame = base * CFrame.new(0, height / 2, 0)}):Play()
		local life = spec.Life * rng:NextNumber(0.8, 1.15)
		task.delay(life, function()
			if not part.Parent then return end
			TweenService:Create(part, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = V(width * 0.2, 0.05, width * 0.2), CFrame = base, Transparency = 1}):Play()
		end)
		Debris:AddItem(part, life + 0.35)
	end
end

-- disque à plat : flaque, givre, brûlure
local recentDiscs = {}
local function disc(position, normal, radius, style, life, lift)
	if lightOnly then return end
	-- pas de flaques empilées au même endroit quand on vise un point fixe
	local now, key = os.clock(), lift or 0
	for i = #recentDiscs, 1, -1 do
		local d = recentDiscs[i]
		if now > d.Until then
			table.remove(recentDiscs, i)
		elseif d.Key == key and (d.Position - position).Magnitude < radius * 0.8 then
			return
		end
	end
	table.insert(recentDiscs, {Position = position, Until = now + life * 0.7, Key = key})
	local cf = upright(position + normal * (lift or 0.06), normal) * CFrame.Angles(0, 0, rad(90))
	local part = newPart(V(0.12, radius * 0.5, radius * 0.5), cf, style[1], style[2], style[3], Enum.PartType.Cylinder)
	TweenService:Create(part, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = V(0.12, radius * 2, radius * 2)}):Play()
	task.delay(life - 0.6, function()
		if part.Parent then TweenService:Create(part, TweenInfo.new(0.6), {Transparency = 1}):Play() end
	end)
	Debris:AddItem(part, life + 0.05)
end

-- onde de choc : anneau qui s'élargit en s'effaçant
local function wave(position, normal, radius, color)
	local cf = upright(position + normal * 0.15, normal) * CFrame.Angles(0, 0, rad(90))
	local part = newPart(V(0.1, radius * 0.4, radius * 0.4), cf, color, Mat.Neon, 0.35, Enum.PartType.Cylinder)
	TweenService:Create(part, TweenInfo.new(0.38, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = V(0.1, radius * 2, radius * 2), Transparency = 1}):Play()
	Debris:AddItem(part, 0.42)
end

-- éclaboussures de blocs qui sautent
local function burst(position, normal, count, styles, size, speed, gravity, life, opts)
	for _ = 1, count do
		local direction = (normal * 1.4 + randomUnit()).Unit
		local s = size * rng:NextNumber(0.7, 1.3)
		opts = opts or {}
		mote(position + normal * 0.3, direction * speed * rng:NextNumber(0.6, 1.2), V(s, s, s), life * rng:NextNumber(0.8, 1.2), pick(styles), {Gravity = gravity, Spin = opts.Spin or 6, Fade = opts.Fade, Grow = opts.Grow})
	end
end

-- colonne de lumière
local function pillar(position, normal, height, width, color)
	local base = upright(position, normal)
	for i, w in {width, width * 0.5} do
		local part = newPart(V(w, height, w), base * CFrame.new(0, height / 2, 0) * CFrame.Angles(0, rad(45 * i), 0), i == 1 and color or WHITE, Mat.Neon, i == 1 and 0.45 or 0.1)
		TweenService:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = V(0.05, height * 1.3, 0.05), Transparency = 1}):Play()
		Debris:AddItem(part, 0.55)
	end
end

-- petit trou noir avec disque d'accrétion
local function blackHole(position, normal, size, ringColor, ringColor2)
	if lightOnly then return end
	local center = position + normal * size * 0.9
	local core = newPart(V(0.1, 0.1, 0.1), CFrame.new(center), BLACK, Mat.SmoothPlastic, 0, Enum.PartType.Ball)
	local tilt = CFrame.new(center) * CFrame.Angles(rad(rng:NextNumber(-25, 25)), 0, rad(90 + rng:NextNumber(-25, 25)))
	local ring = newPart(V(0.1, 0.2, 0.2), tilt, ringColor, Mat.Neon, 0.25, Enum.PartType.Cylinder)
	local halo = newPart(V(0.06, 0.2, 0.2), tilt, ringColor2, Mat.Neon, 0.6, Enum.PartType.Cylinder)
	local grow = TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	TweenService:Create(core, grow, {Size = V(size, size, size)}):Play()
	TweenService:Create(ring, grow, {Size = V(0.1, size * 2.2, size * 2.2)}):Play()
	TweenService:Create(halo, grow, {Size = V(0.06, size * 3.2, size * 3.2)}):Play()
	task.delay(0.75, function()
		local shrink = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		for _, part in {core, ring, halo} do
			if part.Parent then TweenService:Create(part, shrink, {Size = V(0.05, 0.05, 0.05)}):Play() end
		end
	end)
	for _, part in {core, ring, halo} do Debris:AddItem(part, 1.05) end
end

---------------------------------------------------------------- éclairs
local function segment(a, b, thickness, color, life)
	local part = newPart(V(thickness, thickness, (b - a).Magnitude), CFrame.lookAt((a + b) / 2, b), color, Mat.Neon)
	TweenService:Create(part, TweenInfo.new(life), {Transparency = 1, Size = V(thickness * 0.2, thickness * 0.2, part.Size.Z)}):Play()
	Debris:AddItem(part, life + 0.05)
end
local function bolt(a, b, steps, jitter, thickness, color, life, branch)
	local previous = a
	for i = 1, steps do
		local point = a:Lerp(b, i / steps)
		if i < steps then point += randomUnit() * jitter end
		segment(previous, point, thickness, color, life)
		if branch and i > 1 and i < steps and rng:NextNumber() < 0.3 then
			bolt(point, point + (point - previous).Unit * jitter * 2 + randomUnit() * jitter * 2.5, 2, jitter * 0.5, thickness * 0.55, color, life, false)
		end
		previous = point
	end
end

---------------------------------------------------------------- constructions qui poussent du sol
-- pieces = {{taille, CFrame relatif à la base, style}} : chaque pièce grandit depuis la base, reste "life" secondes puis se rétracte
local function structure(base, pieces, life)
	if lightOnly then return end
	for _, piece in pieces do
		local size, cf, style = piece[1], base * piece[2], piece[3]
		local part = newPart(size * 0.05, base, style[1], style[2], style[3])
		TweenService:Create(part, TweenInfo.new(0.2 + rng:NextNumber(0, 0.12), Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = size, CFrame = cf}):Play()
		task.delay(life, function()
			if part.Parent then TweenService:Create(part, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = size * 0.05, CFrame = base, Transparency = 1}):Play() end
		end)
		Debris:AddItem(part, life + 0.4)
	end
end
local function ground(position, normal, tilt)
	return upright(position, normal) * CFrame.Angles(rad(rng:NextNumber(-tilt, tilt)), rad(rng:NextNumber(0, 360)), rad(rng:NextNumber(-tilt, tilt)))
end
local Y45 = CFrame.Angles(0, rad(45), 0)
local POINT = CFrame.Angles(rad(54.7), 0, rad(45)) -- cube posé sur un coin : fait une pointe

local GEMS = {rgb(255, 150, 230), rgb(190, 150, 255), rgb(150, 235, 255), rgb(255, 225, 130)}
local LEAVES = {{rgb(70, 170, 70), Mat.LeafyGrass}, {rgb(150, 215, 90), Mat.LeafyGrass}, {rgb(40, 115, 55), Mat.LeafyGrass}}
local PETALS = {rgb(255, 130, 190), rgb(255, 225, 90), WHITE, rgb(190, 130, 255)}

-- vrai cristal : prisme de verre, pointe taillée, cœur lumineux
local function crystal(position, normal, unit, scale, tilt, life)
	local color = pick(GEMS)
	local h, w = rng:NextNumber(2.4, 4.6) * unit * scale, rng:NextNumber(0.8, 1.2) * unit * scale
	structure(ground(position, normal, tilt), {
		{V(w, h, w), CFrame.new(0, h / 2, 0) * Y45, {color, Mat.Glass, 0.25}},
		{V(w * 0.72, w * 0.72, w * 0.72), CFrame.new(0, h, 0) * POINT, {color:Lerp(WHITE, 0.35), Mat.Glass, 0.15}},
		{V(w * 0.34, h * 0.92, w * 0.34), CFrame.new(0, h / 2, 0) * Y45, {color:Lerp(WHITE, 0.5), Mat.Neon}},
		{V(w * 1.5, w * 0.35, w * 1.5), CFrame.new(0, w * 0.1, 0), {color:Lerp(BLACK, 0.25), Mat.Glass, 0.2}},
	}, life)
end
-- petit arbre : tronc, trois étages de feuillage, parfois un fruit
local function tree(position, normal, unit, scale, life)
	local h = rng:NextNumber(1.5, 2.4) * unit * scale
	local s = unit * scale
	local pieces = {
		{V(0.5 * s, h, 0.5 * s), CFrame.new(0, h / 2, 0), {rgb(120, 82, 50), Mat.Wood}},
		{V(2.2 * s, 1.3 * s, 2.2 * s), CFrame.new(0, h + 0.5 * s, 0), LEAVES[1]},
		{V(1.6 * s, 1.2 * s, 1.6 * s), CFrame.new(0, h + 1.5 * s, 0) * Y45, LEAVES[2]},
		{V(0.9 * s, 0.9 * s, 0.9 * s), CFrame.new(0, h + 2.4 * s, 0), LEAVES[3]},
	}
	if rng:NextNumber() < 0.5 then table.insert(pieces, {V(0.4 * s, 0.4 * s, 0.4 * s), CFrame.new(1.0 * s, h + 0.6 * s, 0.6 * s), {rgb(240, 60, 60), Mat.SmoothPlastic}}) end
	structure(ground(position, normal, 6), pieces, life)
end
local function flower(position, normal, unit, scale, life)
	local s, petal = unit * scale, pick(PETALS)
	structure(ground(position, normal, 10), {
		{V(0.16 * s, 0.9 * s, 0.16 * s), CFrame.new(0, 0.45 * s, 0), LEAVES[3]},
		{V(0.8 * s, 0.22 * s, 0.8 * s), CFrame.new(0, 0.95 * s, 0), {petal, Mat.SmoothPlastic}},
		{V(0.8 * s, 0.22 * s, 0.8 * s), CFrame.new(0, 0.95 * s, 0) * Y45, {petal, Mat.SmoothPlastic}},
		{V(0.34 * s, 0.34 * s, 0.34 * s), CFrame.new(0, 1.05 * s, 0), {rgb(255, 215, 70), Mat.Neon}},
	}, life)
end
local function grass(position, normal, unit, scale, life)
	local s, pieces = unit * scale, {}
	for i = 1, 3 do
		table.insert(pieces, {V(0.18 * s, rng:NextNumber(0.6, 1.2) * s, 0.18 * s), CFrame.new(rng:NextNumber(-0.4, 0.4) * s, 0.4 * s, rng:NextNumber(-0.4, 0.4) * s) * CFrame.Angles(rad(rng:NextNumber(-18, 18)), 0, rad(rng:NextNumber(-18, 18))), pick(LEAVES)})
	end
	structure(ground(position, normal, 0), pieces, life)
end
-- langue de feu : trois cubes lumineux qui s'affinent
local function flame(position, normal, unit, scale, palette, life)
	local s = unit * scale
	local h = rng:NextNumber(1.4, 2.4) * s
	structure(ground(position, normal, 12), {
		{V(1.1 * s, h * 0.5, 1.1 * s), CFrame.new(0, h * 0.25, 0) * Y45, {palette[1], Mat.Neon, 0.1}},
		{V(0.75 * s, h * 0.4, 0.75 * s), CFrame.new(0, h * 0.62, 0), {palette[2], Mat.Neon, 0.05}},
		{V(0.42 * s, h * 0.34, 0.42 * s), CFrame.new(0, h * 0.94, 0) * Y45, {palette[3], Mat.Neon}},
	}, life)
end
-- pic en trois segments qui s'affinent (glace, épine d'ombre, colonne d'eau)
local function spike(position, normal, unit, scale, tilt, styles, life)
	local s = unit * scale
	local h, w = rng:NextNumber(2.4, 5) * s, rng:NextNumber(0.8, 1.1) * s
	structure(ground(position, normal, tilt), {
		{V(w, h * 0.45, w), CFrame.new(0, h * 0.225, 0), styles[1]},
		{V(w * 0.66, h * 0.33, w * 0.66), CFrame.new(0, h * 0.6, 0) * Y45, styles[2]},
		{V(w * 0.36, h * 0.24, w * 0.36), CFrame.new(0, h * 0.87, 0), styles[3]},
	}, life)
end
local function rock(position, normal, unit, scale, life)
	local s = rng:NextNumber(0.7, 1.2) * unit * scale
	structure(ground(position, normal, 30), {
		{V(s, s, s), CFrame.new(0, s * 0.35, 0), {rgb(40, 30, 32), Mat.Basalt}},
		{V(s * 0.5, s * 0.5, s * 0.5), CFrame.new(s * 0.5, s * 0.2, s * 0.3) * Y45, {rgb(66, 48, 46), Mat.Basalt}},
	}, life)
end
local function around(position, normal, radius)
	local offset = V(rng:NextNumber(-1, 1), 0, rng:NextNumber(-1, 1)) * radius
	return (upright(position, normal) * CFrame.new(offset)).Position
end

---------------------------------------------------------------- styles par élément
-- Shoot = projectiles crachés, Impact = là où le souffle touche, Trail = traces laissées en marchant, Orbit = satellites
local ELEMENTS = {}

ELEMENTS.Fire = function(c1, c2, c3)
	local palette = {rgb(255, 110, 20), rgb(255, 190, 50), rgb(255, 244, 170)}
	local embers = {{rgb(255, 190, 50)}, {rgb(255, 110, 20)}, {rgb(255, 244, 170)}}
	return {
		Rate = 0,
		Impact = function(p, n, unit)
			disc(p, n, 2.6 * unit, {rgb(24, 16, 14), Mat.SmoothPlastic, 0.25}, 3.4)
			disc(p, n, 1.3 * unit, {rgb(255, 130, 30), Mat.Neon, 0.35}, 1.1, 0.1)
			for _ = 1, 3 do flame(around(p, n, 1.5 * unit), n, unit, rng:NextNumber(0.9, 1.5), palette, rng:NextNumber(0.5, 0.9)) end
			burst(p, n, 4, embers, 0.3 * unit, 12 * unit, -14 * unit, 1.1)
		end,
		Trail = function(p, n, unit)
			disc(p, n, 1.0 * unit, {rgb(24, 16, 14), Mat.SmoothPlastic, 0.35}, 2.6)
			flame(p, n, unit, 0.7, palette, 0.9)
			burst(p, n, 1, embers, 0.22 * unit, 6 * unit, -10 * unit, 0.9)
		end,
		Orbit = {Count = 4, Size = V(0.45, 0.45, 0.45), Styles = embers, Speed = 1.6},
	}
end

ELEMENTS.Ice = function(c1, c2, c3)
	local ice = {{rgb(140, 205, 245), Mat.Ice, 0.2}, {rgb(175, 225, 250), Mat.Ice, 0.2}, {rgb(215, 242, 255), Mat.Ice, 0.15}}
	local snow = {{rgb(235, 246, 255), Mat.Snow}, {rgb(190, 228, 250), Mat.Ice, 0.2}}
	return {
		Rate = 22, Speed = 64, Spread = 6,
		Shoot = function(origin, velocity, unit)
			local s = rng:NextNumber(0.45, 0.75) * unit
			mote(origin, velocity, V(s, s, s * rng:NextNumber(2.5, 4)), 0.55, pick(ice), {Aligned = true})
		end,
		Impact = function(p, n, unit)
			disc(p, n, 2.8 * unit, {rgb(170, 220, 248), Mat.Ice, 0.35}, 3.6)
			spike(p, n, unit, 1.25, 8, ice, 2.8)
			for _ = 1, 3 do spike(around(p, n, 1.7 * unit), n, unit, rng:NextNumber(0.5, 0.85), 32, ice, 2.6) end
			burst(p, n, 4, snow, 0.35 * unit, 16 * unit, 45 * unit, 0.8)
		end,
		Trail = function(p, n, unit)
			disc(p, n, 1.3 * unit, {rgb(190, 230, 250), Mat.Ice, 0.4}, 2.8)
			spike(around(p, n, 0.6 * unit), n, unit, 0.4, 25, ice, 2.2)
			burst(p, n, 1, snow, 0.2 * unit, 5 * unit, 14 * unit, 0.8)
		end,
		Orbit = {Count = 6, Size = V(0.3, 0.9, 0.3), Styles = ice, Speed = 1.1},
	}
end

ELEMENTS.Forest = function(c1, c2, c3)
	local petals = {{PETALS[1]}, {PETALS[2]}, {PETALS[3]}}
	return {
		Rate = 30, Speed = 54, Spread = 9,
		Shoot = function(origin, velocity, unit) -- une rafale de feuilles et de pétales
			local s = rng:NextNumber(0.6, 1.0) * unit
			mote(origin, velocity, V(s, s * 0.16, s * 0.7), 0.8, pick(LEAVES), {Spin = 13, Gravity = 9 * unit})
			if rng:NextNumber() < 0.3 then mote(origin, velocity * 0.9, V(0.4, 0.1, 0.4) * unit, 0.8, {pick(PETALS), Mat.SmoothPlastic}, {Spin = 10, Gravity = 6 * unit}) end
		end,
		Impact = function(p, n, unit)
			disc(p, n, 2.6 * unit, {rgb(70, 150, 60), Mat.LeafyGrass, 0.1}, 3.6)
			tree(p, n, unit, rng:NextNumber(1.0, 1.5), 3.0)
			for _ = 1, 2 do flower(around(p, n, 1.9 * unit), n, unit, rng:NextNumber(0.9, 1.3), 2.8) end
			for _ = 1, 3 do grass(around(p, n, 2.1 * unit), n, unit, 1.2, 2.8) end
			burst(p, n, 4, LEAVES, 0.4 * unit, 14 * unit, 30 * unit, 1)
		end,
		Trail = function(p, n, unit) -- un petit bois pousse dans ses pas
			if rng:NextNumber() < 0.55 then tree(p, n, unit, rng:NextNumber(0.5, 0.75), 2.8) else flower(p, n, unit, 1.1, 2.8) end
			grass(around(p, n, 0.9 * unit), n, unit, 1.0, 2.6)
			if rng:NextNumber() < 0.4 then flower(around(p, n, 1.0 * unit), n, unit, 0.9, 2.6) end
		end,
		Orbit = {Count = 5, Size = V(0.7, 0.12, 0.7), Styles = LEAVES, Speed = 1.3},
	}
end

ELEMENTS.Ocean = function(c1, c2, c3)
	local water = {{rgb(90, 200, 235), Mat.Glass, 0.3}, {rgb(40, 140, 215), Mat.Glass, 0.3}, {rgb(220, 250, 255), Mat.Glass, 0.2}}
	return {
		Rate = 30, Speed = 66, Spread = 4,
		Shoot = function(origin, velocity, unit)
			local s = rng:NextNumber(0.5, 0.85) * unit
			mote(origin, velocity, V(s, s, s * 2), 0.5, pick(water), {Aligned = true, Gravity = 16 * unit})
		end,
		Impact = function(p, n, unit)
			wave(p, n, 3.8 * unit, rgb(170, 235, 255))
			disc(p, n, 2.9 * unit, {rgb(60, 165, 225), Mat.Glass, 0.4}, 2.6)
			spike(p, n, unit, 0.9, 6, water, 0.35)
			burst(p, n, 7, water, 0.5 * unit, 24 * unit, 62 * unit, 0.8)
		end,
		Trail = function(p, n, unit)
			disc(p, n, 1.4 * unit, {rgb(70, 175, 230), Mat.Glass, 0.45}, 2.4)
			wave(p, n, 1.8 * unit, rgb(190, 240, 255))
			burst(p, n, 2, water, 0.25 * unit, 9 * unit, 40 * unit, 0.5)
		end,
		Orbit = {Count = 5, Size = V(0.5, 0.5, 0.5), Styles = water, Speed = 1.4},
	}
end

ELEMENTS.Thunder = function(c1, c2, c3)
	local function arcs(p, n, unit, count, reach)
		for _ = 1, count do
			local a = around(p, n, reach * unit) + n * 0.3
			bolt(a, around(p, n, reach * unit) + n * rng:NextNumber(0.3, 2.4) * unit, 4, 0.5 * unit, 0.16 * unit, rng:NextNumber() < 0.5 and c2 or c3, 0.16, false)
		end
	end
	return {
		Rate = 0,
		Impact = function(p, n, unit)
			disc(p, n, 1.8 * unit, {rgb(30, 28, 40), Mat.SmoothPlastic, 0.3}, 2.8)
			wave(p, n, 3.2 * unit, c2)
			arcs(p, n, unit, 4, 2.4)
			burst(p, n, 3, {{c2}, {c3}, {WHITE}}, 0.3 * unit, 30 * unit, 50 * unit, 0.4)
		end,
		Trail = function(p, n, unit)
			disc(p, n, 0.8 * unit, {rgb(30, 28, 40), Mat.SmoothPlastic, 0.4}, 2)
			arcs(p, n, unit, 2, 1.3)
		end,
		Orbit = {Count = 3, Size = V(0.35, 0.35, 0.35), Styles = {{c3}, {c2}}, Speed = 4.5},
	}
end

ELEMENTS.Lava = function(c1, c2, c3)
	local lava = {{rgb(255, 110, 20)}, {rgb(255, 200, 70)}, {rgb(230, 60, 20)}}
	local palette = {rgb(230, 60, 20), rgb(255, 130, 30), rgb(255, 220, 90)}
	return {
		Rate = 18, Speed = 50, Spread = 7,
		Shoot = function(origin, velocity, unit)
			local s = rng:NextNumber(0.6, 1.1) * unit
			mote(origin, velocity, V(s, s, s), 0.75, rng:NextNumber() < 0.75 and pick(lava) or {rgb(40, 30, 32), Mat.Basalt}, {Spin = 5, Gravity = 22 * unit})
		end,
		Impact = function(p, n, unit)
			disc(p, n, 3.1 * unit, {rgb(40, 30, 32), Mat.Basalt}, 4)
			disc(p, n, 2.4 * unit, lava[1], 3.8, 0.1)
			disc(p, n, 1.2 * unit, lava[2], 2.8, 0.14)
			for _ = 1, 2 do rock(around(p, n, 2.2 * unit), n, unit, 1.2, 3) end
			flame(around(p, n, 0.8 * unit), n, unit, 1.1, palette, 0.8)
			burst(p, n, 4, lava, 0.45 * unit, 16 * unit, 50 * unit, 0.9) -- bulles qui éclatent
		end,
		Trail = function(p, n, unit) -- empreinte en fusion
			disc(p, n, 1.3 * unit, {rgb(40, 30, 32), Mat.Basalt}, 3)
			disc(p, n, 0.9 * unit, lava[1], 2.8, 0.1)
			burst(p, n, 1, lava, 0.22 * unit, 7 * unit, 30 * unit, 0.6)
		end,
		Orbit = {Count = 4, Size = V(0.7, 0.7, 0.7), Styles = {{rgb(40, 30, 32), Mat.Basalt}, lava[1], {rgb(66, 48, 46), Mat.Basalt}, lava[2]}, Speed = 0.9},
	}
end

ELEMENTS.Crystal = function(c1, c2, c3)
	local sparkle = {{WHITE}, {GEMS[1]}, {GEMS[3]}, {GEMS[4]}}
	return {
		Rate = 26, Speed = 66, Spread = 6,
		Shoot = function(origin, velocity, unit) -- éclats de cristal de toutes les couleurs
			local s = rng:NextNumber(0.45, 0.7) * unit
			mote(origin, velocity, V(s, s, s * rng:NextNumber(2, 3.5)), 0.5, {pick(GEMS), Mat.Glass, 0.2}, {Aligned = true})
			if rng:NextNumber() < 0.5 then mote(origin, velocity * 0.8 + randomUnit() * 8 * unit, V(0.22, 0.22, 0.22) * unit, 0.6, pick(sparkle), {Spin = 10}) end
		end,
		Impact = function(p, n, unit) -- une vraie gerbe de cristaux
			disc(p, n, 2.6 * unit, {rgb(255, 190, 240), Mat.Neon, 0.6}, 2)
			crystal(p, n, unit, 1.35, 6, 3)
			for _ = 1, 4 do crystal(around(p, n, 1.6 * unit), n, unit, rng:NextNumber(0.5, 0.9), 34, 2.8) end
			burst(p, n, 5, sparkle, 0.25 * unit, 20 * unit, -6 * unit, 0.9)
		end,
		Trail = function(p, n, unit)
			crystal(p, n, unit, rng:NextNumber(0.4, 0.6), 22, 2.6)
			if rng:NextNumber() < 0.5 then crystal(around(p, n, 0.9 * unit), n, unit, 0.3, 30, 2.4) end
			burst(p, n, 1, sparkle, 0.18 * unit, 6 * unit, -6 * unit, 0.8)
		end,
		Orbit = {Count = 6, Size = V(0.35, 0.85, 0.35), Styles = {{GEMS[1], Mat.Glass, 0.2}, {GEMS[2], Mat.Glass, 0.2}, {GEMS[3], Mat.Glass, 0.2}}, Speed = 1.2},
	}
end

ELEMENTS.Shadow = function(c1, c2, c3)
	local dark = {{rgb(18, 16, 26), Mat.SmoothPlastic}, {rgb(44, 34, 66), Mat.SmoothPlastic}, {rgb(180, 90, 255), Mat.Neon}}
	local smoke = {{rgb(18, 16, 26), Mat.SmoothPlastic, 0.2}, {rgb(44, 34, 66), Mat.SmoothPlastic, 0.2}}
	return {
		Rate = 0,
		Impact = function(p, n, unit)
			disc(p, n, 3 * unit, {rgb(10, 8, 16), Mat.SmoothPlastic, 0.1}, 3.4)
			wave(p, n, 3.4 * unit, rgb(170, 90, 255))
			for _ = 1, 4 do spike(around(p, n, 1.6 * unit), n, unit, rng:NextNumber(0.6, 1.1), 38, dark, 2.4) end
			burst(p, n, 4, smoke, 0.5 * unit, 9 * unit, -8 * unit, 1.2, {Fade = true, Grow = 2.4})
		end,
		Trail = function(p, n, unit) -- flaque d'ombre d'où monte une fumée noire
			disc(p, n, 1.4 * unit, {rgb(10, 8, 16), Mat.SmoothPlastic, 0.15}, 2.8)
			burst(p, n, 2, smoke, 0.35 * unit, 5 * unit, -7 * unit, 1.1, {Fade = true, Grow = 2.2})
			if rng:NextNumber() < 0.4 then spike(around(p, n, 0.7 * unit), n, unit, 0.35, 30, dark, 2) end
		end,
		Orbit = {Count = 5, Size = V(0.5, 0.5, 0.5), Styles = dark, Speed = 1.8},
	}
end

ELEMENTS.Void = function(c1, c2, c3)
	local stars = {{WHITE}, {rgb(150, 235, 255)}, {rgb(255, 150, 240)}, {rgb(190, 130, 255)}}
	return {
		Rate = 22, Speed = 58, Spread = 7, ImpactInterval = 0.32,
		Shoot = function(origin, velocity, unit)
			local s = rng:NextNumber(0.2, 0.4) * unit
			mote(origin, velocity * rng:NextNumber(0.8, 1.2), V(s, s, s), 0.6, pick(stars), {Spin = 10})
		end,
		Impact = function(p, n, unit)
			blackHole(p, n, 2.2 * unit, rgb(255, 110, 230), rgb(110, 220, 255))
			wave(p, n, 4 * unit, rgb(170, 90, 255))
			disc(p, n, 2.8 * unit, {rgb(8, 5, 20), Mat.SmoothPlastic, 0.15}, 2.4)
			burst(p, n, 6, stars, 0.28 * unit, 14 * unit, -10 * unit, 1)
		end,
		Trail = function(p, n, unit) -- morceau de ciel étoilé au sol
			disc(p, n, 1.3 * unit, {rgb(12, 8, 30), Mat.SmoothPlastic, 0.15}, 2.8)
			burst(p, n, 3, stars, 0.16 * unit, 4 * unit, -5 * unit, 1.3)
		end,
		Orbit = {Count = 8, Size = V(0.3, 0.3, 0.3), Styles = stars, Speed = 1.5, Planet = true},
	}
end

ELEMENTS.Celestial = function(c1, c2, c3)
	local gold = {{rgb(255, 205, 70)}, {rgb(255, 240, 170)}, {WHITE}}
	return {
		Rate = 24, Speed = 70, Spread = 5, ImpactInterval = 0.22,
		Shoot = function(origin, velocity, unit)
			local s = rng:NextNumber(0.4, 0.7) * unit
			mote(origin, velocity, V(s, s, s * 0.3), 0.5, pick(gold), {Spin = 12})
			if rng:NextNumber() < 0.4 then mote(origin, velocity, V(0.25, 0.25, 2.2) * unit, 0.45, {WHITE, Mat.Neon, 0.3}, {Aligned = true}) end
		end,
		Impact = function(p, n, unit)
			pillar(p, n, 18 * unit, 1.8 * unit, rgb(255, 215, 90))
			wave(p, n, 3.8 * unit, rgb(255, 235, 150))
			disc(p, n, 2.4 * unit, {rgb(255, 235, 160), Mat.Neon, 0.5}, 1.5)
			burst(p, n, 5, gold, 0.3 * unit, 14 * unit, -14 * unit, 1)
		end,
		Trail = function(p, n, unit) -- empreinte de lumière
			disc(p, n, 1.1 * unit, {rgb(255, 230, 140), Mat.Neon, 0.45}, 2.2)
			burst(p, n, 2, gold, 0.2 * unit, 5 * unit, -8 * unit, 1.1)
		end,
		Orbit = {Count = 6, Size = V(0.6, 0.6, 0.18), Styles = gold, Speed = 1.3},
	}
end

---------------------------------------------------------------- dragons d'Halloween : satellites en plusieurs blocs
-- pièce soudée à un satellite : elle le suit quand on le déplace (le Weld sert aussi à l'animer)
local function attach(body, size, offset, color, material, transparency)
	local part = Instance.new("Part")
	part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.CastShadow, part.Massless = false, false, false, false, false, true
	part.TopSurface, part.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	part.Material, part.Color, part.Transparency, part.Size = material or Mat.SmoothPlastic, color, transparency or 0, size
	part.CFrame = body.CFrame * offset
	local weld = Instance.new("Weld")
	weld.Part0, weld.Part1, weld.C0 = body, part, offset
	weld.Parent = part
	part.Parent = body
	return weld
end
local FAR = CFrame.new(0, -500, 0)
-- chauve-souris qui bat des ailes (l'avant est -Z : elle regarde là où elle vole)
local function makeBat(unit, eyeColor)
	local dark, wing = rgb(26, 20, 34), rgb(52, 40, 66)
	local body = newPart(V(0.5, 0.5, 0.8) * unit, FAR, dark, Mat.SmoothPlastic)
	local wings = {}
	for _, s in {1, -1} do
		attach(body, V(0.16, 0.26, 0.16) * unit, CFrame.new(s * 0.17 * unit, 0.36 * unit, -0.28 * unit), dark)
		attach(body, V(0.1, 0.1, 0.08) * unit, CFrame.new(s * 0.13 * unit, 0.06 * unit, -0.41 * unit), eyeColor, Mat.Neon)
		local inner = attach(body, V(1.0, 0.1, 0.7) * unit, CFrame.new(s * 0.75 * unit, 0.1 * unit, 0), dark)
		local outer = attach(body, V(0.8, 0.1, 0.5) * unit, CFrame.new(s * 1.6 * unit, 0.1 * unit, 0.05 * unit), wing)
		table.insert(wings, {Side = s, Inner = inner, Outer = outer})
	end
	return body, function(t)
		local flap = math.sin(t * 15) * 0.85
		for _, w in wings do
			local s = w.Side
			local hinge = CFrame.new(s * 0.25 * unit, 0.1 * unit, 0) * CFrame.Angles(0, 0, s * flap)
			w.Inner.C0 = hinge * CFrame.new(s * 0.5 * unit, 0, 0)
			w.Outer.C0 = hinge * CFrame.new(s * 1.0 * unit, 0, 0) * CFrame.Angles(0, 0, s * flap * 0.7) * CFrame.new(s * 0.4 * unit, 0, 0.05 * unit)
		end
	end
end
-- mini citrouille-lanterne
local function makePumpkin(unit)
	local orange, dark, glow = rgb(255, 122, 24), rgb(214, 86, 14), rgb(255, 214, 70)
	local body = newPart(V(0.95, 0.8, 0.95) * unit, FAR, orange, Mat.Plastic)
	attach(body, V(1.05, 0.56, 0.66) * unit, CFrame.identity, dark, Mat.Plastic)
	attach(body, V(0.66, 0.56, 1.05) * unit, CFrame.identity, dark, Mat.Plastic)
	attach(body, V(0.2, 0.3, 0.2) * unit, CFrame.new(0.03 * unit, 0.52 * unit, 0), rgb(70, 130, 50))
	for _, s in {1, -1} do attach(body, V(0.22, 0.22, 0.08) * unit, CFrame.new(s * 0.22 * unit, 0.12 * unit, -0.53 * unit) * CFrame.Angles(0, 0, rad(45)), glow, Mat.Neon) end
	attach(body, V(0.62, 0.13, 0.08) * unit, CFrame.new(0, -0.18 * unit, -0.53 * unit), glow, Mat.Neon)
	return body
end
-- petit fantôme
local function makeGhost(unit)
	local white, dark = rgb(240, 245, 255), rgb(26, 20, 34)
	local body = newPart(V(0.8, 0.9, 0.7) * unit, FAR, white, Mat.SmoothPlastic, 0.15)
	attach(body, V(0.6, 0.28, 0.54) * unit, CFrame.new(0, 0.56 * unit, 0), white, nil, 0.15)
	for i, x in {-0.28, 0, 0.28} do attach(body, V(0.22, 0.34, 0.66) * unit, CFrame.new(x * unit, (i % 2 == 0 and -0.7 or -0.58) * unit, 0), white, nil, 0.15) end
	for _, s in {1, -1} do attach(body, V(0.16, 0.24, 0.08) * unit, CFrame.new(s * 0.18 * unit, 0.16 * unit, -0.36 * unit), dark) end
	attach(body, V(0.18, 0.2, 0.08) * unit, CFrame.new(0, -0.16 * unit, -0.36 * unit), dark)
	return body
end
-- crâne aux yeux verts, os qui tournoie
local function makeSkull(unit)
	local bone, dark = rgb(226, 220, 190), rgb(26, 30, 26)
	local body = newPart(V(0.85, 0.75, 0.85) * unit, FAR, bone, Mat.SmoothPlastic)
	attach(body, V(0.6, 0.3, 0.6) * unit, CFrame.new(0, -0.5 * unit, -0.08 * unit), rgb(180, 172, 140))
	for _, s in {1, -1} do
		attach(body, V(0.24, 0.26, 0.08) * unit, CFrame.new(s * 0.2 * unit, 0.06 * unit, -0.43 * unit), dark)
		attach(body, V(0.1, 0.1, 0.1) * unit, CFrame.new(s * 0.2 * unit, 0.06 * unit, -0.44 * unit), rgb(190, 255, 60), Mat.Neon)
	end
	attach(body, V(0.12, 0.14, 0.08) * unit, CFrame.new(0, -0.2 * unit, -0.43 * unit), dark)
	return body, nil, 0.5
end
local function makeBone(unit)
	local bone = rgb(226, 220, 190)
	local body = newPart(V(1.3, 0.24, 0.24) * unit, FAR, bone, Mat.SmoothPlastic)
	for _, s in {1, -1} do
		attach(body, V(0.3, 0.3, 0.3) * unit, CFrame.new(s * 0.7 * unit, 0.12 * unit, 0), bone)
		attach(body, V(0.3, 0.3, 0.3) * unit, CFrame.new(s * 0.7 * unit, -0.12 * unit, 0), bone)
	end
	return body, nil, 2.4
end

ELEMENTS.Halloween = function(c1, c2, c3)
	local ORANGE, PURPLE, GREEN, GLOW = rgb(255, 122, 24), rgb(150, 70, 220), rgb(130, 220, 60), rgb(255, 214, 70)
	local candy = {{rgb(255, 214, 50), Mat.SmoothPlastic}, {rgb(255, 140, 30), Mat.SmoothPlastic}, {WHITE, Mat.SmoothPlastic}, {PURPLE, Mat.SmoothPlastic}, {GREEN, Mat.SmoothPlastic}}
	local palette = {rgb(150, 60, 230), rgb(255, 130, 20), rgb(255, 235, 150)}
	-- citrouille-lanterne qui pousse du sol, visage lumineux
	local function pumpkin(position, normal, unit, scale, life)
		local s = unit * scale
		structure(ground(position, normal, 8), {
			{V(1.7 * s, 1.4 * s, 1.7 * s), CFrame.new(0, 0.7 * s, 0), {ORANGE, Mat.Plastic}},
			{V(1.9 * s, 1.0 * s, 1.2 * s), CFrame.new(0, 0.7 * s, 0), {rgb(214, 86, 14), Mat.Plastic}},
			{V(1.2 * s, 1.0 * s, 1.9 * s), CFrame.new(0, 0.7 * s, 0), {rgb(214, 86, 14), Mat.Plastic}},
			{V(0.3 * s, 0.5 * s, 0.3 * s), CFrame.new(0.05 * s, 1.6 * s, 0) * CFrame.Angles(0, 0, rad(-12)), {rgb(70, 130, 50), Mat.SmoothPlastic}},
			{V(0.36 * s, 0.36 * s, 0.12 * s), CFrame.new(-0.4 * s, 0.95 * s, 0.98 * s) * CFrame.Angles(0, 0, rad(45)), {GLOW, Mat.Neon}},
			{V(0.36 * s, 0.36 * s, 0.12 * s), CFrame.new(0.4 * s, 0.95 * s, 0.98 * s) * CFrame.Angles(0, 0, rad(45)), {GLOW, Mat.Neon}},
			{V(1.1 * s, 0.2 * s, 0.12 * s), CFrame.new(0, 0.45 * s, 0.98 * s), {GLOW, Mat.Neon}},
			{V(0.24 * s, 0.24 * s, 0.12 * s), CFrame.new(0, 0.62 * s, 0.98 * s), {GLOW, Mat.Neon}},
		}, life)
	end
	-- un esprit s'élève de l'impact
	local function ghost(p, n, unit)
		local s = unit * rng:NextNumber(0.8, 1.2)
		mote(p + n * unit, n * 7 * unit + randomUnit() * 2 * unit, V(1.0, 0.9, 1.25) * s, 1.3, {rgb(240, 245, 255), Mat.SmoothPlastic, 0.2}, {Aligned = true, Fade = true, Grow = 1.3})
	end
	return {
		Rate = 24, Speed = 60, Spread = 7, ImpactInterval = 0.26,
		Shoot = function(origin, velocity, unit) -- une pluie de bonbons, quelques chauves-souris
			local s = rng:NextNumber(0.35, 0.6) * unit
			mote(origin, velocity, V(s, s, s), 0.6, pick(candy), {Spin = 12, Gravity = 10 * unit})
			if rng:NextNumber() < 0.18 then mote(origin, velocity * 0.85 + randomUnit() * 6 * unit, V(1.0, 0.1, 0.42) * unit, 0.8, {rgb(26, 20, 34), Mat.SmoothPlastic}, {Spin = 16}) end
		end,
		Impact = function(p, n, unit)
			local first = not lightOnly
			disc(p, n, 2.8 * unit, {rgb(30, 18, 44), Mat.SmoothPlastic, 0.2}, 3.4)
			disc(p, n, 1.4 * unit, {rgb(255, 140, 30), Mat.Neon, 0.4}, 1.2, 0.1)
			wave(p, n, 3.6 * unit, rgb(170, 90, 255))
			pumpkin(p, n, unit, rng:NextNumber(1.0, 1.4), 2.8)
			if rng:NextNumber() < 0.6 then pumpkin(around(p, n, 2.2 * unit), n, unit, rng:NextNumber(0.5, 0.75), 2.6) end
			for _ = 1, 2 do flame(around(p, n, 1.8 * unit), n, unit, rng:NextNumber(0.8, 1.3), palette, rng:NextNumber(0.6, 1)) end
			if first then ghost(p, n, unit) end
			burst(p, n, 5, candy, 0.32 * unit, 16 * unit, 40 * unit, 0.9)
		end,
		Trail = function(p, n, unit) -- des petites citrouilles poussent dans ses pas
			disc(p, n, 1.1 * unit, {rgb(30, 18, 44), Mat.SmoothPlastic, 0.3}, 2.6)
			if rng:NextNumber() < 0.5 then pumpkin(p, n, unit, rng:NextNumber(0.35, 0.5), 2.6) else flame(p, n, unit, 0.7, palette, 0.9) end
			burst(p, n, 2, candy, 0.2 * unit, 7 * unit, 26 * unit, 0.8)
		end,
		Orbit = {Count = 6, Speed = 1.3, Make = function(unit, i)
			if i % 3 == 1 then return makeBat(unit, rgb(255, 150, 40)) end
			if i % 3 == 2 then return makePumpkin(unit) end
			return makeGhost(unit)
		end},
	}
end

ELEMENTS.Zombie = function(c1, c2, c3)
	local SKIN, SKIN_D, BONE, SLIME, SLIME_D, DIRT = rgb(120, 160, 88), rgb(70, 104, 62), rgb(226, 220, 190), rgb(150, 255, 60), rgb(70, 190, 40), rgb(84, 60, 44)
	local goo = {{SLIME, Mat.Neon, 0.15}, {SLIME_D, Mat.Glass, 0.2}, {rgb(190, 255, 110), Mat.Neon, 0.2}}
	local bones = {{BONE, Mat.SmoothPlastic}, {rgb(180, 172, 140), Mat.SmoothPlastic}}
	-- main de zombie qui sort de terre
	local function hand(position, normal, unit, scale, life)
		local s = unit * scale
		structure(ground(position, normal, 14), {
			{V(1.3 * s, 0.35 * s, 1.3 * s), CFrame.new(0, 0.12 * s, 0), {DIRT, Mat.SmoothPlastic}},
			{V(0.55 * s, 1.6 * s, 0.55 * s), CFrame.new(0, 0.9 * s, 0), {SKIN, Mat.Plastic}},
			{V(0.85 * s, 0.6 * s, 0.42 * s), CFrame.new(0, 1.95 * s, 0), {SKIN_D, Mat.Plastic}},
			{V(0.2 * s, 0.55 * s, 0.24 * s), CFrame.new(-0.3 * s, 2.5 * s, 0), {SKIN, Mat.SmoothPlastic}},
			{V(0.2 * s, 0.7 * s, 0.24 * s), CFrame.new(0, 2.58 * s, 0), {SKIN, Mat.SmoothPlastic}},
			{V(0.2 * s, 0.55 * s, 0.24 * s), CFrame.new(0.3 * s, 2.5 * s, 0), {SKIN, Mat.SmoothPlastic}},
			{V(0.2 * s, 0.42 * s, 0.24 * s), CFrame.new(0.55 * s, 2.0 * s, 0.05 * s), {SKIN, Mat.SmoothPlastic}},
		}, life)
	end
	local function grave(position, normal, unit, scale, life)
		local s = unit * scale
		structure(ground(position, normal, 9), {
			{V(1.6 * s, 0.4 * s, 1.1 * s), CFrame.new(0, 0.15 * s, 0), {DIRT, Mat.SmoothPlastic}},
			{V(1.3 * s, 1.7 * s, 0.4 * s), CFrame.new(0, 1.0 * s, 0), {rgb(126, 130, 138), Mat.Slate}},
			{V(0.9 * s, 0.35 * s, 0.4 * s), CFrame.new(0, 2.0 * s, 0), {rgb(126, 130, 138), Mat.Slate}},
			{V(0.18 * s, 0.8 * s, 0.1 * s), CFrame.new(0, 1.25 * s, 0.22 * s), {rgb(84, 88, 96), Mat.Slate}},
			{V(0.55 * s, 0.18 * s, 0.1 * s), CFrame.new(0, 1.45 * s, 0.22 * s), {rgb(84, 88, 96), Mat.Slate}},
		}, life)
	end
	return {
		Rate = 26, Speed = 52, Spread = 8, ImpactInterval = 0.26,
		Shoot = function(origin, velocity, unit) -- bave toxique et vieux os
			local s = rng:NextNumber(0.4, 0.75) * unit
			mote(origin, velocity, V(s, s, s), 0.7, pick(goo), {Spin = 6, Gravity = 24 * unit})
			if rng:NextNumber() < 0.2 then mote(origin, velocity * 0.9, V(0.22, 0.22, 1.0) * unit, 0.8, pick(bones), {Spin = 15, Gravity = 18 * unit}) end
		end,
		Impact = function(p, n, unit) -- flaque toxique, des mains et des tombes sortent du sol
			disc(p, n, 3.0 * unit, {rgb(40, 70, 30), Mat.SmoothPlastic, 0.15}, 3.8)
			disc(p, n, 2.2 * unit, {SLIME, Mat.Neon, 0.35}, 3.2, 0.1)
			wave(p, n, 3.4 * unit, rgb(150, 255, 70))
			hand(p, n, unit, rng:NextNumber(0.9, 1.3), 2.6)
			if rng:NextNumber() < 0.5 then grave(around(p, n, 2.2 * unit), n, unit, rng:NextNumber(0.8, 1.1), 3) else hand(around(p, n, 2.0 * unit), n, unit, rng:NextNumber(0.6, 0.8), 2.4) end
			burst(p, n, 4, goo, 0.4 * unit, 6 * unit, -9 * unit, 1.3, {Fade = true, Grow = 1.6}) -- bulles qui montent
			burst(p, n, 3, bones, 0.3 * unit, 18 * unit, 50 * unit, 0.9)
		end,
		Trail = function(p, n, unit)
			disc(p, n, 1.3 * unit, {SLIME_D, Mat.Neon, 0.4}, 2.8)
			if rng:NextNumber() < 0.35 then hand(around(p, n, 0.8 * unit), n, unit, 0.4, 2.2) end
			burst(p, n, 2, goo, 0.22 * unit, 4 * unit, -6 * unit, 1.1, {Fade = true, Grow = 1.5})
		end,
		Orbit = {Count = 5, Speed = 1.0, Make = function(unit, i)
			if i % 2 == 1 then return makeSkull(unit) end
			return makeBone(unit)
		end},
	}
end

ELEMENTS.Vampire = function(c1, c2, c3)
	local BLOOD, BLOOD_D, BLOOD_N = rgb(170, 10, 26), rgb(100, 4, 16), rgb(255, 40, 60)
	local blood = {{BLOOD, Mat.Glass, 0.1}, {BLOOD_D, Mat.Glass, 0.1}, {BLOOD_N, Mat.Neon, 0.1}}
	local crystal = {{BLOOD_D, Mat.Glass, 0.12}, {BLOOD, Mat.Glass, 0.1}, {BLOOD_N, Mat.Neon}}
	-- une nuée de chauves-souris s'envole de l'impact
	local function bats(p, n, unit, count)
		for _ = 1, count do
			mote(p + n * unit, (n * 1.2 + randomUnit()).Unit * rng:NextNumber(10, 18) * unit, V(1.1, 0.1, 0.45) * unit, rng:NextNumber(0.8, 1.2), {rgb(22, 16, 28), Mat.SmoothPlastic}, {Spin = 14, Gravity = -8 * unit, Fade = true})
		end
	end
	return {
		Rate = 36, Speed = 62, Spread = 5, ImpactInterval = 0.22,
		Shoot = function(origin, velocity, unit) -- il crache du sang : de grosses gouttes qui retombent
			local s = rng:NextNumber(0.4, 0.75) * unit
			mote(origin, velocity, V(s, s, s * rng:NextNumber(1.6, 2.6)), 0.75, pick(blood), {Aligned = true, Gravity = 30 * unit})
		end,
		Impact = function(p, n, unit) -- mare de sang, cristaux de sang, éclaboussures
			local first = not lightOnly
			disc(p, n, 3.2 * unit, {BLOOD_D, Mat.Glass, 0.05}, 4.5)
			disc(p, n, 2.0 * unit, {BLOOD, Mat.Glass, 0.1}, 4, 0.1)
			wave(p, n, 3.6 * unit, BLOOD_N)
			spike(p, n, unit, 1.1, 8, crystal, 2.4)
			for _ = 1, 3 do spike(around(p, n, 1.7 * unit), n, unit, rng:NextNumber(0.45, 0.8), 34, crystal, 2.2) end
			burst(p, n, 7, blood, 0.42 * unit, 22 * unit, 60 * unit, 0.8)
			if first then bats(p, n, unit, 3) end
		end,
		Trail = function(p, n, unit) -- il laisse des flaques de sang
			disc(p, n, 1.3 * unit, {BLOOD_D, Mat.Glass, 0.08}, 3.2)
			burst(p, n, 2, blood, 0.22 * unit, 7 * unit, 36 * unit, 0.6)
		end,
		Orbit = {Count = 5, Speed = 1.7, Make = function(unit, i) return makeBat(unit * 1.15, BLOOD_N) end},
	}
end

---------------------------------------------------------------- boucle
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude

local state = {} -- [dragon] = {Config, Orbiters, Shoot, Impact, Arc, Bolt, Time}

local function setup(dragon)
	local c1 = dragon:GetAttribute("Fire1") or rgb(255, 240, 150)
	local c2 = dragon:GetAttribute("Fire2") or rgb(255, 150, 40)
	local c3 = dragon:GetAttribute("Fire3") or rgb(220, 50, 20)
	local element = dragon:GetAttribute("Element")
	local config = (ELEMENTS[element] or ELEMENTS.Fire)(c1, c2, c3)
	local unit = (dragon:GetAttribute("Height") or 8.8) / 8.8
	local s = {Config = config, Element = element, Unit = unit, Orbiters = {}, Recent = {}, Shoot = 0, Impact = 0, Arc = 0, Bolt = 0, Time = rng:NextNumber(0, 10), C2 = c2, C3 = c3}
	local orbit = config.Orbit
	if orbit then
		for i = 1, orbit.Count do
			if orbit.Make then -- satellite en plusieurs blocs (chauve-souris, citrouille, crâne...) : Make rend la pièce, son animation, sa vitesse de rotation
				local part, update, spin = orbit.Make(unit, i)
				table.insert(s.Orbiters, {Part = part, Index = i, Made = true, Update = update, Spin = spin})
			else
				local style = orbit.Styles[(i - 1) % #orbit.Styles + 1]
				table.insert(s.Orbiters, {Part = newPart(orbit.Size * unit, CFrame.new(0, -500, 0), style[1], style[2], style[3]), Index = i})
			end
		end
		if orbit.Planet then -- petite planète à anneau, sur une orbite plus large
			local planet = newPart(V(0.9, 0.9, 0.9) * unit, CFrame.new(0, -500, 0), rgb(110, 60, 200), Mat.SmoothPlastic)
			local ring = newPart(V(0.08, 1.7, 1.7) * unit, CFrame.new(0, -500, 0), rgb(255, 110, 230), Mat.Neon, 0.2, Enum.PartType.Cylinder)
			table.insert(s.Orbiters, {Part = planet, Ring = ring, Index = 0, Planet = true})
		end
	end
	state[dragon] = s
	dragon.Destroying:Connect(function()
		for _, o in s.Orbiters do
			o.Part:Destroy()
			if o.Ring then o.Ring:Destroy() end
		end
		state[dragon] = nil
	end)
	return s
end

RunService.Heartbeat:Connect(function(dt)
	dt = math.min(dt, 0.1)
	updateMotes(dt)
	local camera = workspace.CurrentCamera
	for _, dragon in CollectionService:GetTagged(TAG) do
		if not dragon:IsDescendantOf(workspace) or not dragon:GetAttribute("Element") then continue end
		local root = dragon.PrimaryPart
		if not root then continue end
		local s = state[dragon] or setup(dragon)
		local near = (root.Position - camera.CFrame.Position).Magnitude < MAX_DISTANCE
		local unit, config = s.Unit, s.Config
		local height = unit * 8.8
		s.Time += dt

		-- satellites
		local orbit = config.Orbit
		for _, o in s.Orbiters do
			if not near then
				o.Part.CFrame = CFrame.new(0, -500, 0)
				if o.Ring then o.Ring.CFrame = o.Part.CFrame end
				continue
			end
			local count = orbit.Count
			local angle = s.Time * orbit.Speed * (o.Planet and 0.45 or 1) + o.Index / count * math.pi * 2
			local radius = height * (o.Planet and 1.35 or (0.9 + (o.Index % 2) * 0.2))
			local lift = height * (0.1 + math.sin(s.Time * 1.3 + o.Index * 1.7) * 0.14 + math.sin(angle) * 0.12)
			local position = root.Position + V(math.cos(angle) * radius, lift, math.sin(angle) * radius)
			if o.Made then -- il regarde là où il vole ; un os ou un crâne tournoie, les autres se balancent
				local facing = CFrame.lookAlong(position, V(-math.sin(angle), 0, math.cos(angle)))
				o.Part.CFrame = facing * (o.Spin and CFrame.Angles(s.Time * o.Spin, s.Time * o.Spin * 0.6, 0) or CFrame.Angles(0, 0, math.sin(s.Time * 2 + o.Index) * 0.2))
				if o.Update then o.Update(s.Time + o.Index * 0.7) end
			else
				o.Part.CFrame = CFrame.new(position) * CFrame.Angles(s.Time * 1.6 + o.Index, s.Time * 2.1, o.Index)
			end
			if o.Ring then o.Ring.CFrame = CFrame.new(position) * CFrame.Angles(rad(20), 0, rad(70)) end
		end
		if not near then continue end

		-- traînée : en marchant au sol, le dragon laisse derrière lui des traces de son élément
		if config.Trail then
			local velocity = root.AssemblyLinearVelocity
			local walk = V(velocity.X, 0, velocity.Z).Magnitude
			if walk > 3 then
				s.TrailDistance = (s.TrailDistance or 0) + walk * dt
				if s.TrailDistance > 4.5 * unit then
					s.TrailDistance = 0
					rayParams.FilterDescendantsInstances = {dragon.Parent, folder, workspace:FindFirstChild("ZoneEggs")}
					local floor = workspace:Raycast(root.Position, V(0, -((dragon:GetAttribute("GroundOffset") or 3.4) + 2.5), 0), rayParams)
					if floor then -- seulement quand il marche, pas en vol
						local behind = floor.Position - root.CFrame.ZVector * 3 * unit + root.CFrame.XVector * rng:NextNumber(-2, 2) * unit
						lightOnly = false
						config.Trail(behind, floor.Normal, unit)
					end
				end
			end
		end

		-- Thunder : petits arcs qui courent sur le corps
		if s.Element == "Thunder" then
			s.Arc -= dt
			if s.Arc <= 0 then
				s.Arc = rng:NextNumber(0.08, 0.3)
				local a = (root.CFrame * CFrame.new(rng:NextNumber(-0.55, 0.55) * height, rng:NextNumber(-0.25, 0.35) * height, rng:NextNumber(-0.6, 0.6) * height)).Position
				bolt(a, a + randomUnit() * rng:NextNumber(1.5, 3.5) * unit, 4, 0.45 * unit, 0.13 * unit, rng:NextNumber() < 0.5 and s.C2 or s.C3, 0.12, false)
			end
		end

		if not dragon:GetAttribute("Firing") then continue end
		local mouth = dragon:FindFirstChild("Mouth", true)
		if not mouth then continue end
		local origin, forward = mouth.WorldPosition, mouth.WorldCFrame.LookVector
		local reach = 34 * unit
		rayParams.FilterDescendantsInstances = {dragon, folder, dragon.Parent}
		local hit = workspace:Raycast(origin, forward * reach, rayParams)
		if not hit then -- le souffle retombe : on cherche le sol sous le bout du jet
			hit = workspace:Raycast(origin + forward * reach * 0.75, V(0, -26 * unit, 0), rayParams)
		end

		-- projectiles
		if BLOCK_PROJECTILES and config.Rate > 0 then
			s.Shoot += dt * config.Rate
			while s.Shoot >= 1 do
				s.Shoot -= 1
				local direction = (mouth.WorldCFrame * CFrame.Angles(rad(rng:NextNumber(-config.Spread, config.Spread)), rad(rng:NextNumber(-config.Spread, config.Spread)), 0)).LookVector
				config.Shoot(origin + direction * 0.5 * unit, direction * config.Speed * unit * rng:NextNumber(0.85, 1.15) + root.AssemblyLinearVelocity, unit)
			end
		end

		-- Thunder : éclairs crachés
		if s.Element == "Thunder" then
			s.Bolt -= dt
			if s.Bolt <= 0 then
				s.Bolt = 0.045
				local direction = (mouth.WorldCFrame * CFrame.Angles(rad(rng:NextNumber(-7, 7)), rad(rng:NextNumber(-7, 7)), 0)).LookVector
				local length = rng:NextNumber(26, 40) * unit
				local boltHit = workspace:Raycast(origin, direction * length, rayParams)
				local target = boltHit and boltHit.Position or origin + direction * length
				bolt(origin, target, 8, 1.5 * unit, 0.42 * unit, WHITE:Lerp(s.C3, 0.3), 0.1, true)
				bolt(origin, target, 6, 2.2 * unit, 0.22 * unit, s.C2, 0.12, false)
			end
		end

		-- impact là où le souffle touche
		s.Impact -= dt
		if hit and s.Impact <= 0 and config.Impact then
			s.Impact = config.ImpactInterval or IMPACT_INTERVAL
			local spread = randomUnit() * 3.2 * unit
			local point = hit.Position + (spread - hit.Normal * spread:Dot(hit.Normal))
			local now = os.clock()
			lightOnly = false
			for i = #s.Recent, 1, -1 do
				local r = s.Recent[i]
				if now - r.Time > 1.4 then
					table.remove(s.Recent, i)
				elseif (r.Position - point).Magnitude < 2.4 * unit then
					lightOnly = true
				end
			end
			if not lightOnly then table.insert(s.Recent, {Position = point, Time = now}) end
			config.Impact(point, hit.Normal, unit)
			lightOnly = false
		end
	end
end)

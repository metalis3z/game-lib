-- FightFilm.AlienCast : personnages et accessoires de la cinématique "Alien Invasion" (FightFilm.AlienFilm).
--   AlienCast.alien()            l'extraterrestre hostile : R6 articulé (Kit.makeR6), crâne allongé, grands yeux noirs, antennes,
--                                armure violette, griffes ; mâchoire articulée (Jaw) pour le cri
--   AlienCast.ship(scale)        le vaisseau : la soucoupe de l'event UFO (SkyEvents.Models.Ufo) agrandie, tout ancré
--   AlienCast.galaxy(pal, scale) une galaxie (SkyEvents.Models.Galaxy) recolorée avec sa propre palette
--   AlienCast.bench(width, h)    banc en bois de la scène 1
-- Allures : Kit.Gaits.alienStalk (marche lente et menaçante), Kit.Gaits.alienRun (charge)
-- Tout regarde vers -Z (l'avant d'un personnage Roblox).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Kit = require(script.Parent:WaitForChild("Kit"))
local AlienCast = {}
local rgb = Color3.fromRGB
local rad, sin, cos, max = math.rad, math.sin, math.cos, math.max
local V = Vector3.new
local function C(x, y, z, rx, ry, rz) return CFrame.new(x, y, z) * CFrame.Angles(rad(rx or 0), rad(ry or 0), rad(rz or 0)) end

AlienCast.SKIN = rgb(150, 205, 125)
AlienCast.ARMOR = rgb(62, 34, 96)
AlienCast.GLOW = rgb(90, 235, 255)

local function ellipsoid(p)
	local m = Instance.new("SpecialMesh")
	m.MeshType = Enum.MeshType.Sphere
	m.Parent = p
	return p
end

---------------------------------------------------------------- l'alien
function AlienCast.alien()
	local s = 1.25
	local SKIN, ARMOR, GLOW, DARK = AlienCast.SKIN, AlienCast.ARMOR, AlienCast.GLOW, rgb(26, 18, 40)
	local rig = Kit.makeR6({Name = "Alien", Scale = s, Colors = {Torso = ARMOR, Head = SKIN, Arms = SKIN, Legs = SKIN}})
	local head, torso = rig.Head, rig.Torso
	head.Transparency = 1 -- (le visage est fait de formes arrondies ci-dessous)
	local function d(limb, size, cf, color, o)
		o = o or {}
		o.Smooth = true
		local p = Kit.deco(limb, size * s, typeof(cf) == "Vector3" and CFrame.new(cf * s) or (CFrame.new(cf.Position * s) * cf.Rotation), color, o)
		p.Material = o.Neon and Enum.Material.Neon or (o.Material or Enum.Material.SmoothPlastic)
		return p
	end
	-- tête : grand crâne ovale penché vers l'arrière, menton pointu, grands yeux noirs en amande
	ellipsoid(d(head, V(1.55, 1.9, 1.75), C(0, 0.45, 0.18, -18, 0, 0), SKIN))
	ellipsoid(d(head, V(1.05, 1.0, 1.1), C(0, -0.32, -0.12), SKIN))
	for _, side in {-1, 1} do
		-- yeux noirs en amande, inclinés vers le centre (regard méchant), petite lueur rouge
		local eye = ellipsoid(d(head, V(0.66, 0.34, 0.22), C(side * 0.36, 0.1, -0.64, 0, side * 16, side * -32), rgb(10, 6, 16), {Material = Enum.Material.SmoothPlastic}))
		eye.Name = "Eye"
		eye.Reflectance = 0.2
		local glint = d(head, V(0.12, 0.12, 0.05), C(side * 0.32, 0.12, -0.75), rgb(255, 60, 100), {Neon = true})
		glint.Name = "EyeGlint"
		-- antennes
		d(head, V(0.1, 0.9, 0.1), C(side * 0.35, 1.45, 0.25, -15, 0, side * -20), SKIN)
		local tip = d(head, V(0.26, 0.26, 0.26), C(side * 0.52, 1.88, 0.37), GLOW, {Neon = true})
		tip.Shape = Enum.PartType.Ball
		tip.Name = "AntennaTip"
	end
	-- mâchoire articulée (cri) : une bouche sombre qui s'ouvre vers le bas
	local jaw = d(head, V(0.62, 0.16, 0.28), C(0, -0.55, -0.55), DARK)
	jaw.Name = "Jaw"
	local jawWeld = jaw:FindFirstChildOfClass("Weld")
	local mouth = d(head, V(0.5, 0.12, 0.1), C(0, -0.47, -0.66), rgb(120, 20, 60), {Neon = true})
	mouth.Name = "MouthGlow"
	mouth.Transparency = 1
	-- armure : plastron violet, cœur lumineux, épaulières, ceinture
	d(torso, V(2.12, 1.5, 1.12), C(0, 0.22, 0), ARMOR, {Material = Enum.Material.Metal})
	local core = d(torso, V(0.55, 0.55, 0.2), C(0, 0.3, -0.58), GLOW, {Neon = true})
	core.Shape = Enum.PartType.Ball
	core.Name = "Core"
	d(torso, V(1.6, 0.1, 0.06), C(0, -0.25, -0.57), GLOW, {Neon = true})
	d(torso, V(2.15, 0.35, 1.15), C(0, -0.82, 0), DARK, {Material = Enum.Material.Metal})
	for _, side in {-1, 1} do
		local arm = rig[side == 1 and "Right Arm" or "Left Arm"]
		d(arm, V(1.25, 0.55, 1.25), C(0, 0.78, 0, 0, 0, side * -12), ARMOR, {Material = Enum.Material.Metal})
		d(arm, V(1.1, 0.7, 1.1), C(0, -0.35, 0), ARMOR, {Material = Enum.Material.Metal})
		d(arm, V(1.12, 0.08, 1.12), C(0, -0.1, 0), GLOW, {Neon = true})
		-- trois griffes au bout de la main
		for i = -1, 1 do
			d(arm, V(0.14, 0.55, 0.14), C(i * 0.3, -1.22, -0.25, -25, 0, i * 8), rgb(230, 240, 220))
		end
		local leg = rig[side == 1 and "Right Leg" or "Left Leg"]
		d(leg, V(1.12, 0.8, 1.2), C(0, -0.62, -0.06), ARMOR, {Material = Enum.Material.Metal})
		d(leg, V(1.14, 0.08, 1.22), C(0, -0.2, -0.06), GLOW, {Neon = true})
	end
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = GLOW, 9, 0.8, false
	light.Parent = core
	for _, p in rig:GetDescendants() do
		if p:IsA("BasePart") then p.CastShadow = p.Material ~= Enum.Material.Neon end
	end
	return rig, {Jaw = jawWeld, Mouth = mouth, Core = core}
end

---------------------------------------------------------------- vaisseau (la soucoupe de l'event UFO, en géant)
function AlienCast.ship(scale)
	local template = ReplicatedStorage:WaitForChild("SkyEvents"):WaitForChild("Models"):WaitForChild("Ufo")
	local ship = template:Clone()
	ship.Name = "AlienShip"
	ship:ScaleTo(ship:GetScale() * (scale or 1))
	for _, p in ship:GetDescendants() do
		if p:IsA("BasePart") then
			p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch = true, false, false, false
		elseif p:IsA("LuaSourceContainer") then
			p:Destroy()
		end
	end
	local _, size = ship:GetBoundingBox()
	-- trappe lumineuse sous la soucoupe (le rayon d'aspiration en sort)
	local hatch = Instance.new("Part")
	hatch.Name = "Hatch"
	hatch.Shape = Enum.PartType.Cylinder
	hatch.Size = V(0.4, size.X * 0.28, size.X * 0.28)
	hatch.Material, hatch.Color = Enum.Material.Neon, rgb(160, 255, 170)
	hatch.Anchored, hatch.CanCollide, hatch.CanQuery, hatch.CanTouch, hatch.CastShadow = true, false, false, false, false
	hatch.CFrame = ship:GetPivot() * CFrame.new(0, -size.Y * 0.5, 0) * CFrame.Angles(0, 0, rad(90))
	hatch.Transparency = 1
	hatch.Parent = ship
	return ship, size
end

---------------------------------------------------------------- galaxies
function AlienCast.galaxy(palette, scale)
	local template = ReplicatedStorage:WaitForChild("SkyEvents"):WaitForChild("Models"):WaitForChild("Galaxy")
	local g = template:Clone()
	g.Name = "FilmGalaxy"
	local function lerpColor(u)
		for i = 1, #palette - 1 do
			local a, b = palette[i], palette[i + 1]
			if u <= b[1] then return a[2]:Lerp(b[2], (u - a[1]) / (b[1] - a[1])) end
		end
		return palette[#palette][2]
	end
	local i = 0
	for _, p in g:GetDescendants() do
		if p:IsA("BasePart") then
			p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
			local u = p:GetAttribute("ArmU")
			if u then p.Color = lerpColor(u) end
			if p.Name == "Nebula" then i += 1 p.Color = lerpColor((i % 5) / 5 + 0.1) end
			if p.Name == "CoreGlow" or p.Name == "Bulge" then p.Color = lerpColor(0.12) end
			if p.Name == "CoreHalo" or p.Name == "DustDisc" then p.Color = lerpColor(0.6) end
		elseif p:IsA("ParticleEmitter") and p.Name == "CosmicDust" then
			p.Color = ColorSequence.new(lerpColor(0.3), lerpColor(0.9))
		elseif p:IsA("PointLight") then
			p.Color = lerpColor(0.4)
		end
	end
	if scale and scale ~= 1 then g:ScaleTo(g:GetScale() * scale) end
	return g
end

---------------------------------------------------------------- banc en bois (scène 1)
function AlienCast.bench(width, height)
	local m = Instance.new("Model")
	m.Name = "Bench"
	local function p(size, cf, color)
		local part = Instance.new("Part")
		part.Size, part.CFrame, part.Color = size, cf, color
		part.Material = Enum.Material.Plastic
		pcall(function() part.MaterialVariant = "Studs" end)
		part.TopSurface, part.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch = true, false, false, false
		part.Parent = m
		return part
	end
	local WOOD, DARK = rgb(160, 110, 62), rgb(110, 72, 40)
	local seat = p(V(width, 0.5, 2.2), CFrame.new(0, height - 0.25, 0), WOOD)
	seat.Name = "Seat"
	for _, x in {-width / 2 + 0.6, width / 2 - 0.6} do
		p(V(0.6, height - 0.5, 1.8), CFrame.new(x, (height - 0.5) / 2, 0), DARK)
	end
	p(V(width, 1.6, 0.35), CFrame.new(0, height + 1.1, 1.0) * CFrame.Angles(rad(-12), 0, 0), WOOD).Name = "Back"
	m.PrimaryPart = seat
	return m
end

---------------------------------------------------------------- allures de l'alien (R6 : Root, Neck, épaules, hanches)
local G = Kit.Gaits
-- marche lente et menaçante : grands pas, buste en avant, bras griffus qui pendent devant lui
G.alienStalk = {stride = 5.2, fn = function(p)
	local s, c = sin(p), cos(p)
	return {RightHip = {30 * s}, LeftHip = {-30 * s}, RightShoulder = {22 - 14 * s, 0, 14}, LeftShoulder = {22 + 14 * s, 0, -14},
		Root = {-14 + 2 * math.abs(c), 5 * s, 3 * s}, Neck = {8, -6 * s, 0}}
end}
-- charge : penché très en avant, bras tendus, griffes en avant
G.alienRun = {stride = 8.4, fn = function(p)
	local s = sin(p)
	return {RightHip = {20 + 55 * s}, LeftHip = {20 - 55 * s}, RightShoulder = {70 - 30 * s, 0, 18}, LeftShoulder = {70 + 30 * s, 0, -18},
		Root = {-30, 6 * s, 0}, Neck = {28, 0, 0}}
end}

return AlienCast

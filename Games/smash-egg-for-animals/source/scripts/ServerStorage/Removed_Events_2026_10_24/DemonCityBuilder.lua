-- DemonCityBuilder : construit la ville détruite de la cinématique "Demon City" (Workspace.DestroyedCity), tout en Parts
-- Plastic + variante "Studs" (comme le reste du jeu), sauf les lumières (Neon) et les pièces invisibles.
--   Builder.build(parent)      construit tout (en cédant la main entre les morceaux : pas de gel du serveur)
--   Builder.get()              la ville (Workspace ou ServerStorage), construite si elle n'existe pas
--   Builder.show(on)           la ville n'est dans le monde QUE pendant l'event (sinon rangée dans ServerStorage)
--   Builder.setCollapsed(on)   la façade de l'hôtel effondrée (après le combo duo de la cinématique) ou intacte
-- Dossiers : DestroyedCity / Buildings, Debris, EnvironmentalEffects, BossArena, CinematicPoints (+ Ground : sol et rues)
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(ReplicatedStorage:WaitForChild("DemonCity"):WaitForChild("CinematicConfig"))

local Builder = {}
local V, rgb = Vector3.new, Color3.fromRGB
local rad, abs, max, min = math.rad, math.abs, math.max, math.min
local O = CFrame.new(Config.CENTER) -- repère de la ville : (0, 0, 0) = centre de la place, au niveau du sol
local HALF, AVE, CITY = Config.PLAZA_HALF, Config.AVENUE_HALF, Config.CITY_HALF

local ASPHALT, ASPHALT2, CONCRETE, CONCRETE2 = rgb(66, 62, 66), rgb(50, 47, 51), rgb(116, 110, 104), rgb(96, 91, 88)
local DARK, GLASS, BURNT = rgb(22, 18, 20), rgb(30, 27, 34), rgb(34, 28, 28)
local FIRE, EMBER, BLOOD = rgb(255, 120, 40), rgb(255, 70, 30), rgb(200, 25, 25)
local PALETTE = {rgb(112, 106, 102), rgb(92, 88, 90), rgb(128, 118, 104), rgb(84, 74, 70), rgb(120, 96, 84), rgb(72, 74, 82), rgb(140, 130, 118), rgb(100, 84, 80), rgb(86, 92, 96)}

---------------------------------------------------------------- briques de base
local function part(parent, size, cf, color, o)
	o = o or {}
	local p = Instance.new(o.wedge and "WedgePart" or "Part")
	if o.shape then p.Shape = o.shape end
	p.Size = size
	p.CFrame = cf
	p.Color = color
	if o.neon then
		p.Material = Enum.Material.Neon
	else
		p.Material = Enum.Material.Plastic
		p.MaterialVariant = "Studs"
	end
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	p.Anchored = true
	p.CanTouch = false
	p.CanCollide = o.collide ~= false
	if o.query ~= nil then p.CanQuery = o.query else p.CanQuery = o.collide ~= false end
	p.CastShadow = o.shadow ~= false and not o.neon
	if o.transparency then p.Transparency = o.transparency end
	p.Name = o.name or (o.neon and "Light" or "Part")
	p.Parent = parent
	return p
end
local function at(x, y, z, rx, ry, rz) return O * CFrame.new(x, y, z) * CFrame.Angles(rad(rx or 0), rad(ry or 0), rad(rz or 0)) end
local function folder(parent, name)
	local f = Instance.new("Folder")
	f.Name = name
	f.Parent = parent
	return f
end
local function marker(parent, name, pos, size)
	return part(parent, size or V(2, 2, 2), O * CFrame.new(pos), rgb(255, 0, 0), {collide = false, query = false, transparency = 1, name = name, shadow = false})
end

-- feu d'immeuble : flammes, lueur orange, fumée noire, braises (textures intégrées à Roblox, aucun id externe)
local function fireAt(parent, cf, size)
	size = size or 1
	local holder = part(parent, V(4, 4, 4) * size, cf, FIRE, {collide = false, query = false, transparency = 1, name = "BuildingFire", shadow = false})
	local f = Instance.new("Fire")
	f.Size, f.Heat = 9 * size, 14
	f.Color, f.SecondaryColor = rgb(255, 140, 50), rgb(200, 30, 10)
	f.Parent = holder
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = rgb(255, 110, 40), 34 * size, 2.2, false
	light.Parent = holder
	local smoke = Instance.new("ParticleEmitter")
	smoke.Name = "Smoke"
	smoke.Texture = "rbxasset://textures/particles/smoke_main.dds"
	smoke.Color = ColorSequence.new(rgb(40, 34, 34), rgb(16, 14, 16))
	smoke.LightInfluence = 0.6
	smoke.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 4 * size), NumberSequenceKeypoint.new(1, 16 * size)})
	smoke.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 1)})
	smoke.Lifetime = NumberRange.new(5, 8)
	smoke.Rate = 3
	smoke.Speed = NumberRange.new(6, 10)
	smoke.EmissionDirection = Enum.NormalId.Top
	smoke.SpreadAngle = Vector2.new(12, 12)
	smoke.RotSpeed = NumberRange.new(-20, 20)
	smoke.Rotation = NumberRange.new(0, 360)
	smoke.Acceleration = V(2, 1, 1)
	smoke.Parent = holder
	local embers = Instance.new("ParticleEmitter")
	embers.Name = "Embers"
	embers.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	embers.Color = ColorSequence.new(rgb(255, 200, 90), EMBER)
	embers.LightEmission, embers.LightInfluence = 1, 0
	embers.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0)})
	embers.Lifetime = NumberRange.new(1.5, 3)
	embers.Rate = 5
	embers.Speed = NumberRange.new(5, 12)
	embers.SpreadAngle = Vector2.new(35, 35)
	embers.EmissionDirection = Enum.NormalId.Top
	embers.Parent = holder
	return holder
end

---------------------------------------------------------------- la carte des rues
-- la place (±HALF), l'avenue sud, les rues est et ouest ; au nord, l'hôtel ferme la place
local function isRoad(x, z)
	if abs(x) <= HALF and abs(z) <= HALF then return true end
	if abs(x) <= AVE and z >= HALF and z <= CITY then return true end
	if abs(z) <= AVE and abs(x) >= HALF and abs(x) <= CITY then return true end
	return false
end
Builder.isRoad = isRoad
-- trottoirs / îlots (1 stud plus hauts que la chaussée) : les immeubles sont posés dessus
local SLABS = {
	{HALF, CITY, AVE, CITY}, {AVE, HALF, HALF, CITY},
	{-CITY, -HALF, AVE, CITY}, {-HALF, -AVE, HALF, CITY},
	{HALF, CITY, -CITY, -AVE}, {-CITY, -HALF, -CITY, -AVE},
	{-HALF, HALF, -CITY, -HALF},
}

---------------------------------------------------------------- immeubles
-- façades qui donnent sur une rue (ce sont elles qui ont des fenêtres, des fissures, des feux)
local function streetFaces(cx, cz, w, d)
	local faces = {}
	if isRoad(cx + w / 2 + 20, cz) then table.insert(faces, "E") end
	if isRoad(cx - w / 2 - 20, cz) then table.insert(faces, "W") end
	if isRoad(cx, cz + d / 2 + 20) then table.insert(faces, "S") end
	if isRoad(cx, cz - d / 2 - 20) then table.insert(faces, "N") end
	return faces
end
-- repère d'une façade : CFrame au centre de la face (vers l'extérieur = -Z local), largeur de la face
local function faceFrame(base, face, w, d)
	if face == "S" then return base * CFrame.new(0, 0, d / 2) * CFrame.Angles(0, math.pi, 0), w end
	if face == "N" then return base * CFrame.new(0, 0, -d / 2), w end
	if face == "E" then return base * CFrame.new(w / 2, 0, 0) * CFrame.Angles(0, -math.pi / 2, 0), d end
	return base * CFrame.new(-w / 2, 0, 0) * CFrame.Angles(0, math.pi / 2, 0), d
end

local function rubble(parent, rng, cf, spread, count, color)
	for _ = 1, count do
		local s = rng:NextNumber(1.5, 5)
		local p = cf * CFrame.new(rng:NextNumber(-spread, spread), s * 0.3, rng:NextNumber(-spread * 0.5, spread * 0.5))
		part(parent, V(s * rng:NextNumber(0.8, 1.6), s * rng:NextNumber(0.5, 1), s), p * CFrame.Angles(rng:NextNumber(-0.6, 0.6), rng:NextNumber(0, 6.28), rng:NextNumber(-0.6, 0.6)),
			(color or CONCRETE):Lerp(DARK, rng:NextNumber(0, 0.35)), {wedge = rng:NextNumber() < 0.4, shadow = false, name = "Rubble"})
	end
end

local function detailedBuilding(parent, rng, cx, cz, w, d, h, explosions)
	local m = Instance.new("Model")
	m.Name = "Building"
	local color = PALETTE[rng:NextInteger(1, #PALETTE)]
	local trim = color:Lerp(DARK, 0.35)
	local base = O * CFrame.new(cx, 1, cz) -- les îlots font 1 stud de haut
	local kinds = {"jagged", "tilted", "corner", "jagged"}
	local kind = kinds[rng:NextInteger(1, #kinds)]
	local hb = kind == "jagged" and h * 0.8 or kind == "tilted" and h * 0.74 or h
	part(m, V(w, hb, d), base * CFrame.new(0, hb / 2, 0), color, {name = "Body"})
	-- socle sombre (rez-de-chaussée, vitrines cassées)
	part(m, V(w + 0.6, 7, d + 0.6), base * CFrame.new(0, 3.5, 0), trim, {name = "Ground"})
	local top = hb
	if kind == "jagged" then
		-- haut déchiqueté : blocs de hauteurs différentes, collés aux bords
		for i = 1, rng:NextInteger(3, 5) do
			local bw, bd, bh = w * rng:NextNumber(0.25, 0.55), d * rng:NextNumber(0.25, 0.55), rng:NextNumber(5, 22)
			local ox, oz = (w - bw) / 2 * (rng:NextNumber() < 0.5 and -1 or 1), (d - bd) / 2 * rng:NextNumber(-1, 1)
			if i % 2 == 0 then ox, oz = (w - bw) / 2 * rng:NextNumber(-1, 1), (d - bd) / 2 * (rng:NextNumber() < 0.5 and -1 or 1) end
			part(m, V(bw, bh, bd), base * CFrame.new(ox, hb + bh / 2, oz) * CFrame.Angles(0, 0, rad(rng:NextNumber(-4, 4))), color, {name = "Broken"})
			top = max(top, hb + bh)
		end
		-- ferraille qui dépasse
		for _ = 1, 3 do
			part(m, V(0.5, rng:NextNumber(4, 9), 0.5), base * CFrame.new(rng:NextNumber(-w / 2.4, w / 2.4), hb + 3, rng:NextNumber(-d / 2.4, d / 2.4)) * CFrame.Angles(rad(rng:NextNumber(-30, 30)), 0, rad(rng:NextNumber(-30, 30))), rgb(70, 50, 44), {collide = false, query = false, shadow = false, name = "Rebar"})
		end
	elseif kind == "tilted" then
		-- le dernier tiers a glissé et penché sur un côté
		local th = h * 0.26
		local ang = rad(rng:NextNumber(8, 16)) * (rng:NextNumber() < 0.5 and -1 or 1)
		local hinge = CFrame.new((ang > 0 and -1 or 1) * w / 2, hb, 0)
		local cf = base * hinge * CFrame.Angles(0, 0, ang) * hinge:Inverse() * CFrame.new(0, hb + th / 2, 0)
		part(m, V(w * 0.96, th, d * 0.96), cf, color, {name = "Tilted"})
		part(m, V(w * 0.9, 1.2, d * 0.9), base * CFrame.new(0, hb + 0.4, 0), DARK, {name = "Gap"})
		top = hb + th
	else
		-- coin arraché en haut : on voit l'intérieur sombre
		local cw, ch = w * 0.4, h * 0.22
		part(m, V(cw, ch, d * 0.4), base * CFrame.new((w - cw) / 2 + 0.3, hb - ch / 2 + 0.3, (d * 0.6) / 2 + 0.3), DARK, {name = "Hole"})
		part(m, V(w * 0.3, 1, d * 0.3), base * CFrame.new(-w / 4, hb + 0.5, -d / 4), trim, {name = "Roof"})
	end
	m:SetAttribute("Top", top + 1)
	-- façades sur rue : bandes de fenêtres par étage (avec des trous), quelques fenêtres en feu, des fissures
	-- (plus on est près de la place, plus c'est détruit et en feu)
	local near = V(cx, 0, cz).Magnitude < 260
	local faces = streetFaces(cx, cz, w, d)
	for _, face in faces do
		local fcf, fw = faceFrame(base, face, w, d)
		for y = 12, hb - 6, 12 do
			local roll = rng:NextNumber()
			if roll < (near and 0.18 or 0.1) then
				-- étage soufflé : un grand trou noir
				local hw = fw * rng:NextNumber(0.3, 0.6)
				part(m, V(hw, 8, 0.6), fcf * CFrame.new(rng:NextNumber(-(fw - hw) / 2, (fw - hw) / 2), y, -0.2), DARK, {collide = false, query = false, shadow = false, name = "BlownFloor"})
			elseif roll < 0.92 then
				part(m, V(fw - 4, 5.5, 0.5), fcf * CFrame.new(0, y, -0.15), GLASS, {collide = false, query = false, shadow = false, name = "Windows"})
				if rng:NextNumber() < (near and 0.24 or 0.12) then
					local x, ww = rng:NextNumber(-(fw - 12) / 2, (fw - 12) / 2), rng:NextNumber(4, 9)
					part(m, V(ww, 4.6, 0.55), fcf * CFrame.new(x, y, -0.2), rng:NextNumber() < 0.6 and FIRE or EMBER, {neon = true, collide = false, query = false, name = "BurningWindow"})
					-- traînée de suie au-dessus
					part(m, V(ww * 0.9, 7, 0.45), fcf * CFrame.new(x, y + 6.2, -0.12), BURNT, {collide = false, query = false, shadow = false, name = "Soot"})
				end
			end
		end
		-- pilastres (rythme vertical de la façade)
		for _, sx in {-1, 1} do
			part(m, V(1.6, hb, 1.2), fcf * CFrame.new(sx * (fw / 2 - 0.8), hb / 2, -0.4), trim, {collide = false, query = false, name = "Pillar"})
		end
		for _ = 1, rng:NextInteger(1, 3) do
			local len = rng:NextNumber(10, 26)
			part(m, V(0.7, len, 0.4), fcf * CFrame.new(rng:NextNumber(-fw / 3, fw / 3), rng:NextNumber(len / 2 + 8, max(len / 2 + 9, hb - len / 2)), -0.35) * CFrame.Angles(0, 0, rad(rng:NextNumber(-40, 40))), DARK, {collide = false, query = false, shadow = false, name = "Crack"})
		end
	end
	-- feu dans l'immeuble
	if #faces > 0 and rng:NextNumber() < (near and 0.5 or 0.3) then
		local fcf, fw = faceFrame(base, faces[1], w, d)
		fireAt(m, fcf * CFrame.new(rng:NextNumber(-fw / 4, fw / 4), hb * rng:NextNumber(0.45, 0.85), -1.5), rng:NextNumber(0.9, 1.5))
	end
	-- gravats au pied
	if #faces > 0 and rng:NextNumber() < 0.4 then
		local fcf = faceFrame(base, faces[1], w, d)
		rubble(m, rng, fcf * CFrame.new(0, 0, -5), 8, rng:NextInteger(4, 6))
	end
	-- point d'explosion de fond (sur le toit)
	table.insert(explosions, (base * CFrame.new(0, top, 0)).Position)
	m.Parent = parent
	return m
end

-- ruine : il ne reste que des pans de murs à différentes hauteurs, un plancher effondré et des gravats
local function ruin(parent, rng, cx, cz, w, d, explosions)
	local m = Instance.new("Model")
	m.Name = "Ruin"
	local color = PALETTE[rng:NextInteger(1, #PALETTE)]
	local base = O * CFrame.new(cx, 1, cz)
	part(m, V(w, 1.5, d), base * CFrame.new(0, 0.75, 0), color:Lerp(DARK, 0.45), {name = "Floor"})
	for _, face in {"N", "S", "E", "W"} do
		local fcf, fw = faceFrame(base, face, w, d)
		local n = rng:NextInteger(3, 4)
		local segW = fw / n
		for i = 1, n do
			if rng:NextNumber() > 0.2 then
				local h = rng:NextNumber(6, 48)
				local x = -fw / 2 + segW * (i - 0.5)
				part(m, V(segW + 0.2, h, 2.5), fcf * CFrame.new(x, h / 2, 1.25) * CFrame.Angles(0, 0, rad(rng:NextNumber(-3, 3))), color, {name = "Wall"})
				if h > 17 then part(m, V(segW * 0.6, 5, 0.4), fcf * CFrame.new(x, 12, -0.1), DARK, {collide = false, query = false, shadow = false, name = "Hole"}) end
				if h > 30 then part(m, V(segW * 0.6, 5, 0.4), fcf * CFrame.new(x, 24, -0.1), DARK, {collide = false, query = false, shadow = false, name = "Hole"}) end
			end
		end
	end
	part(m, V(w * 0.8, 2, d * 0.55), base * CFrame.new(0, 7, d * 0.1) * CFrame.Angles(rad(rng:NextNumber(15, 30)), 0, rad(rng:NextNumber(-10, 10))), color:Lerp(DARK, 0.2), {name = "FallenFloor"})
	rubble(m, rng, base, w * 0.35, 8, color)
	if rng:NextNumber() < 0.65 then fireAt(m, base * CFrame.new(rng:NextNumber(-w / 4, w / 4), 3, rng:NextNumber(-d / 4, d / 4)), 1.5) end
	table.insert(explosions, (base * CFrame.new(0, 22, 0)).Position)
	m.Parent = parent
	return m
end

local function simpleBuilding(parent, rng, cx, cz, w, d, h, explosions)
	local m = Instance.new("Model")
	m.Name = "Building"
	local color = PALETTE[rng:NextInteger(1, #PALETTE)]:Lerp(rgb(40, 34, 38), 0.35)
	local base = O * CFrame.new(cx, 1, cz)
	part(m, V(w, h, d), base * CFrame.new(0, h / 2, 0), color, {name = "Body"})
	local tw, td, th = w * rng:NextNumber(0.35, 0.7), d * rng:NextNumber(0.35, 0.7), rng:NextNumber(6, 20)
	part(m, V(tw, th, td), base * CFrame.new((w - tw) / 2 * rng:NextNumber(-1, 1), h + th / 2, (d - td) / 2 * rng:NextNumber(-1, 1)) * CFrame.Angles(0, 0, rad(rng:NextNumber(-5, 5))), color, {name = "Broken"})
	if rng:NextNumber() < 0.12 then fireAt(m, base * CFrame.new(0, h + 3, 0), rng:NextNumber(1.4, 2.2)) end
	if rng:NextNumber() < 0.5 then table.insert(explosions, (base * CFrame.new(0, h, 0)).Position) end
	m.Parent = parent
	return m
end

-- l'hôtel abandonné au nord de la place : le boss est projeté contre sa façade, dont le milieu s'effondre
local function hotel(parent, rng)
	local m = Instance.new("Model")
	m.Name = "AbandonedHotel"
	local front = Config.Points.HotelFront
	local W, H, D = 124, 92, 56
	local color, trim = rgb(124, 108, 96), rgb(78, 66, 60)
	local back = front - 4 -- la façade fait 4 studs d'épaisseur
	part(m, V(W, H, D), at(0, H / 2, back - D / 2), color, {name = "Body"})
	-- intérieur sombre derrière la partie qui s'effondre
	part(m, V(62, 52, 1), at(0, 46, back + 0.4), DARK, {collide = false, query = false, name = "Interior"})
	local function facade(x0, x1, y0, y1)
		return part(m, V(x1 - x0, y1 - y0, 4), at((x0 + x1) / 2, (y0 + y1) / 2, front - 2), color, {name = "Facade"})
	end
	facade(-62, -30, 0, H)
	facade(30, 62, 0, H)
	facade(-30, 30, 0, 20)
	facade(-30, 30, 72, H)
	-- le milieu : 6 blocs qui disparaissent quand le boss s'y écrase
	local collapse = Instance.new("Folder")
	collapse.Name = "Collapsible"
	collapse.Parent = m
	for ix = 0, 2 do
		for iy = 0, 1 do
			local p = part(collapse, V(20, 26, 4), at(-20 + ix * 20, 33 + iy * 26, front - 2), color, {name = "FacadeBlock"})
			p:SetAttribute("Collapsible", true)
			-- fenêtres de ces blocs (disparaissent avec eux)
			part(collapse, V(16, 5, 0.5), at(-20 + ix * 20, 30 + iy * 26, front + 0.2), GLASS, {collide = false, query = false, name = "FacadeWindow"}):SetAttribute("Collapsible", true)
			part(collapse, V(16, 5, 0.5), at(-20 + ix * 20, 40 + iy * 26, front + 0.2), GLASS, {collide = false, query = false, name = "FacadeWindow"}):SetAttribute("Collapsible", true)
		end
	end
	-- tas de gravats (caché, il apparaît quand la façade s'effondre)
	local pile = Instance.new("Folder")
	pile.Name = "CollapseRubble"
	pile.Parent = m
	for i = 1, 14 do
		local s = rng:NextNumber(5, 11)
		local p = part(pile, V(s * 1.4, s * 0.7, s), at(rng:NextNumber(-30, 30), s * 0.3, front + rng:NextNumber(2, 16), rng:NextNumber(-25, 25), rng:NextNumber(0, 360), rng:NextNumber(-25, 25)), color:Lerp(DARK, rng:NextNumber(0, 0.4)), {wedge = i % 3 == 0, name = "Rubble"})
		p.Transparency, p.CanCollide, p.CanQuery = 1, false, false
	end
	-- fenêtres du reste de la façade
	for y = 10, H - 8, 12 do
		for _, x in {-46, 46} do part(m, V(26, 5, 0.5), at(x, y, front + 0.2), GLASS, {collide = false, query = false, name = "Windows"}) end
		if y < 20 or y > 72 then part(m, V(52, 5, 0.5), at(0, y, front + 0.2), GLASS, {collide = false, query = false, name = "Windows"}) end
	end
	-- corniches, entrée, enseigne
	part(m, V(W + 2, 3, 6), at(0, H - 1.5, front - 1), trim, {name = "Cornice"})
	part(m, V(W + 1, 2, 5), at(0, 20, front - 0.5), trim, {name = "Cornice"})
	part(m, V(26, 14, 1), at(0, 7, front + 0.1), DARK, {collide = false, name = "Entrance"})
	part(m, V(34, 2, 10), at(0, 15, front + 5), trim, {name = "Canopy"})
	local sign = part(m, V(56, 9, 1.2), at(0, H + 6, front - 2), DARK, {name = "Sign"})
	for _, x in {-24, 24} do part(m, V(1, 6, 1), at(x, H + 1.5, front - 2), rgb(70, 60, 56), {name = "SignPost"}) end
	local gui = Instance.new("SurfaceGui")
	gui.Face = Enum.NormalId.Back
	gui.LightInfluence = 0
	gui.Brightness = 2.5
	gui.PixelsPerStud = 20
	gui.Parent = sign
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.FontFace = Font.new("rbxasset://fonts/families/Bangers.json")
	label.RichText = true
	label.TextScaled = true
	label.Text = '<font color="#ff3020">GR</font><font color="#401010">A</font><font color="#ff3020">ND H</font><font color="#401010">O</font><font color="#ff3020">TEL</font>'
	label.Parent = gui
	fireAt(m, at(44, H + 2, front - 10), 2)
	fireAt(m, at(-50, 58, front + 1), 1.2)
	m.Parent = parent
	return m
end

---------------------------------------------------------------- voitures, bus, lampadaires, cratères
local CAR_COLORS = {rgb(150, 30, 30), rgb(40, 70, 130), rgb(200, 190, 170), rgb(60, 60, 64), rgb(180, 140, 40), rgb(70, 110, 80), rgb(120, 120, 126)}
local function car(parent, rng, x, z, yaw, o)
	o = o or {}
	local m = Instance.new("Model")
	m.Name = "Car"
	local color = o.burnt and BURNT or CAR_COLORS[rng:NextInteger(1, #CAR_COLORS)]
	local base = at(x, 0, z, 0, yaw, 0)
	if o.flipped then base = base * CFrame.new(0, 4.6, 0) * CFrame.Angles(0, 0, math.pi) end
	if o.tilt then base = base * CFrame.Angles(rad(o.tilt), 0, 0) end
	local crush = o.crushed and 0.55 or 1
	part(m, V(6, 2.2 * crush, 12), base * CFrame.new(0, 1.9, 0), color, {name = "Body"})
	part(m, V(5.4, 1.9 * crush, 6), base * CFrame.new(0, 2.9 + 1.0 * crush, 0.6), color:Lerp(DARK, 0.15), {name = "Cabin"})
	part(m, V(5.5, 1.3 * crush, 0.3), base * CFrame.new(0, 3.0 + 0.9 * crush, -2.5), GLASS, {collide = false, name = "Windshield"})
	for _, wx in {-2.9, 2.9} do
		for _, wz in {-3.8, 3.8} do
			part(m, V(1, 2.6, 2.6), base * CFrame.new(wx, 1.3, wz), rgb(24, 22, 24), {shape = Enum.PartType.Cylinder, collide = false, name = "Wheel"})
		end
	end
	part(m, V(4.4, 0.6, 0.3), base * CFrame.new(0, 2.2, -6.05), rgb(255, 240, 200), {neon = not o.burnt, collide = false, name = "Headlights"})
	part(m, V(4.4, 0.6, 0.3), base * CFrame.new(0, 2.2, 6.05), rgb(200, 20, 20), {neon = not o.burnt, collide = false, name = "Taillights"})
	if o.burning then fireAt(m, base * CFrame.new(0, 4, -2), 1) end
	m.Parent = parent
	return m
end

local function bus(parent, x, z, yaw)
	local m = Instance.new("Model")
	m.Name = "OverturnedBus"
	local base = at(x, 0, z, 0, yaw, 0) * CFrame.new(0, 4.5, 0) * CFrame.Angles(0, 0, rad(90)) -- couché sur le flanc
	local yellow = rgb(196, 150, 40)
	part(m, V(9, 8, 30), base, yellow, {name = "Body"})
	part(m, V(0.4, 3, 26), base * CFrame.new(4.6, 1.2, 0), GLASS, {collide = false, name = "Windows"})
	part(m, V(0.4, 3, 26), base * CFrame.new(-4.6, 1.2, 0), GLASS, {collide = false, name = "Windows"})
	part(m, V(9.2, 1, 30.2), base * CFrame.new(0, -3.6, 0), rgb(40, 36, 36), {name = "Underside"})
	for _, wz in {-10, 10} do
		for _, wx in {-4, 4} do
			part(m, V(1.2, 3.4, 3.4), base * CFrame.new(wx, -4.6, wz), rgb(24, 22, 24), {shape = Enum.PartType.Cylinder, collide = false, name = "Wheel"})
		end
	end
	fireAt(m, base * CFrame.new(5, 0, -8), 1.3)
	m.Parent = parent
	return m
end

local function lamp(parent, rng, x, z, facing)
	local m = Instance.new("Model")
	m.Name = "StreetLamp"
	local state = rng:NextNumber()
	local steel = rgb(58, 58, 62)
	local base = at(x, 1, z, 0, facing, 0)
	if state < 0.2 then
		-- tombé au sol
		part(m, V(0.9, 22, 0.9), base * CFrame.Angles(rad(86), 0, 0) * CFrame.new(0, 11, 0), steel, {name = "Pole"})
		part(m, V(1.8, 1.2, 0.8), base * CFrame.new(0, 0.6, 0), steel, {name = "Stump"})
	else
		local bend = state < 0.5 and rng:NextNumber(14, 32) or rng:NextNumber(-3, 3)
		local pole = base * CFrame.Angles(rad(bend), 0, 0)
		part(m, V(0.9, 22, 0.9), pole * CFrame.new(0, 11, 0), steel, {name = "Pole"})
		part(m, V(0.6, 0.6, 6), pole * CFrame.new(0, 21.7, -2.7), steel, {name = "Arm"})
		local lit = state > 0.75
		local head = part(m, V(1.6, 0.7, 2.4), pole * CFrame.new(0, 21.2, -5.4), lit and rgb(255, 90, 50) or rgb(50, 46, 46), {neon = lit, collide = false, name = "Head"})
		if lit then
			local l = Instance.new("SpotLight")
			l.Face, l.Angle, l.Range, l.Brightness, l.Color, l.Shadows = Enum.NormalId.Bottom, 80, 34, 2, rgb(255, 80, 50), false
			l.Parent = head
		end
	end
	m.Parent = parent
	return m
end

local function crater(parent, rng, x, z, r)
	local m = Instance.new("Model")
	m.Name = "Crater"
	part(m, V(0.3, (r + 4) * 2, (r + 4) * 2), at(x, 0.05, z, 0, 0, 90), rgb(38, 32, 32), {shape = Enum.PartType.Cylinder, collide = false, query = false, shadow = false, name = "Scorch"})
	part(m, V(0.3, r * 2, r * 2), at(x, 0.12, z, 0, 0, 90), rgb(20, 16, 18), {shape = Enum.PartType.Cylinder, collide = false, query = false, shadow = false, name = "Hole"})
	local n = 9
	for i = 1, n do
		local a = (i / n) * math.pi * 2 + rng:NextNumber(-0.2, 0.2)
		local s = r * rng:NextNumber(0.3, 0.45)
		local cf = at(x + math.cos(a) * r, s * 0.25, z + math.sin(a) * r) * CFrame.Angles(0, -a + math.pi / 2, 0) * CFrame.Angles(rad(-28), 0, 0)
		part(m, V(s * 1.4, s * 0.55, s), cf, ASPHALT:Lerp(DARK, rng:NextNumber(0, 0.4)), {wedge = i % 2 == 0, shadow = false, name = "Rim"})
	end
	-- fissures qui partent du cratère
	for _ = 1, 4 do
		local a = rng:NextNumber(0, math.pi * 2)
		local px, pz = x + math.cos(a) * r, z + math.sin(a) * r
		for _ = 1, 3 do
			a += rng:NextNumber(-0.6, 0.6)
			local len = rng:NextNumber(6, 13)
			local nx, nz = px + math.cos(a) * len, pz + math.sin(a) * len
			part(m, V(0.7, 0.12, len + 0.6), at((px + nx) / 2, 0.06, (pz + nz) / 2, 0, -math.deg(a) + 90, 0), rgb(20, 16, 18), {collide = false, query = false, shadow = false, name = "Crack"})
			px, pz = nx, nz
		end
	end
	m.Parent = parent
	return m
end

---------------------------------------------------------------- construction complète
function Builder.build(parent)
	local rng = Random.new(Config.SEED)
	local pause = function() task.wait() end
	local city = Instance.new("Model")
	city.Name = "DestroyedCity"
	city:SetAttribute("Center", Config.CENTER)
	city:SetAttribute("PlazaHalf", HALF)
	local buildings = folder(city, "Buildings")
	local debris = folder(city, "Debris")
	local env = folder(city, "EnvironmentalEffects")
	local arena = folder(city, "BossArena")
	local points = folder(city, "CinematicPoints")
	local ground = folder(city, "Ground")
	city.Parent = parent
	local explosions = {}

	------------------------------------------------ sol, îlots, marquages
	part(ground, V(1000, 6, 1000), at(0, -3, 0), ASPHALT, {name = "Asphalt"})
	for _, s in SLABS do
		local x0, x1, z0, z1 = s[1], s[2], s[3], s[4]
		part(ground, V(x1 - x0, 1, z1 - z0), at((x0 + x1) / 2, 0.5, (z0 + z1) / 2), CONCRETE2, {name = "Sidewalk"})
	end
	-- au-delà de la ville : terrain vague sombre
	part(ground, V(2400, 4, 2400), at(0, -4.5, 0), rgb(36, 30, 30), {collide = false, query = false, name = "Outskirts"})
	-- taches d'asphalte plus sombre (réparations, brûlures)
	for _ = 1, 26 do
		local x, z
		repeat x, z = rng:NextNumber(-CITY, CITY), rng:NextNumber(-CITY, CITY) until isRoad(x, z)
		part(ground, V(rng:NextNumber(8, 26), 0.1, rng:NextNumber(8, 26)), at(x, 0.04, z, 0, rng:NextNumber(0, 90), 0), ASPHALT2, {collide = false, query = false, shadow = false, name = "Patch"})
	end
	-- marquages (avenue sud, rues est / ouest), parfois effacés
	for z = HALF + 20, CITY - 10, 18 do
		if rng:NextNumber() > 0.2 then part(ground, V(1, 0.1, 8), at(0, 0.05, z), rgb(200, 170, 60), {collide = false, query = false, shadow = false, name = "Line"}) end
	end
	for _, side in {-1, 1} do
		for x = HALF + 20, CITY - 10, 18 do
			if rng:NextNumber() > 0.2 then part(ground, V(8, 0.1, 1), at(side * x, 0.05, 0), rgb(200, 170, 60), {collide = false, query = false, shadow = false, name = "Line"}) end
		end
	end
	-- passages piétons aux entrées de la place
	for i = -3, 3 do
		part(ground, V(3, 0.1, 12), at(i * 8, 0.05, HALF - 8), rgb(190, 186, 176), {collide = false, query = false, shadow = false, name = "Crosswalk"})
		for _, side in {-1, 1} do part(ground, V(12, 0.1, 3), at(side * (HALF - 8), 0.05, i * 8), rgb(190, 186, 176), {collide = false, query = false, shadow = false, name = "Crosswalk"}) end
	end
	pause()

	------------------------------------------------ immeubles
	hotel(buildings, rng)
	local count = 0
	for _, s in SLABS do
		local x0, x1, z0, z1 = s[1], s[2], s[3], s[4]
		local step = 62
		local nx, nz = max(1, math.floor((x1 - x0 - 12) / step)), max(1, math.floor((z1 - z0 - 12) / step))
		local sx, sz = (x1 - x0) / nx, (z1 - z0) / nz
		for ix = 0, nx - 1 do
			for iz = 0, nz - 1 do
				local cx, cz = x0 + sx * (ix + 0.5), z0 + sz * (iz + 0.5)
				local reserved = abs(cx) < 80 and cz < -HALF and cz > -200 -- (l'hôtel)
				if not reserved then
					local w = min(sx - 14, rng:NextNumber(30, 48))
					local d = min(sz - 14, rng:NextNumber(30, 48))
					cx += rng:NextNumber(-1, 1) * max(0, (sx - 14 - w) / 2)
					cz += rng:NextNumber(-1, 1) * max(0, (sz - 14 - d) / 2)
					local front = #streetFaces(cx, cz, w, d) > 0
					local dist = V(cx, 0, cz).Magnitude
					if front and dist < 240 and rng:NextNumber() < 0.24 then
						ruin(buildings, rng, cx, cz, w, d, explosions)
					elseif front and dist <= 330 then
						detailedBuilding(buildings, rng, cx, cz, w, d, rng:NextNumber(48, 120), explosions)
					else
						simpleBuilding(buildings, rng, cx, cz, w, d, rng:NextNumber(70, 175), explosions)
					end
					count += 1
					if count % 4 == 0 then pause() end
				end
			end
		end
	end
	-- silhouettes lointaines : la ville continue à perte de vue
	local skyline = folder(buildings, "Skyline")
	for i = 1, 44 do
		local a = (i / 44) * math.pi * 2 + rng:NextNumber(-0.05, 0.05)
		local r = rng:NextNumber(500, 700)
		local w, h = rng:NextNumber(40, 90), rng:NextNumber(110, 280)
		local x, z = math.cos(a) * r, math.sin(a) * r
		part(skyline, V(w, h, w * rng:NextNumber(0.7, 1.2)), at(x, h / 2 - 4, z, 0, rng:NextNumber(0, 90), 0), rgb(38, 32, 36):Lerp(rgb(70, 40, 40), rng:NextNumber(0, 0.4)), {collide = false, query = false, shadow = false, name = "FarTower"})
		if rng:NextNumber() < 0.35 then
			part(skyline, V(2, 2, 2), at(x, h - 3, z), rgb(255, 40, 30), {neon = true, collide = false, query = false, name = "AviationLight"})
		end
		if rng:NextNumber() < 0.5 then table.insert(explosions, (O * CFrame.new(x, h - 4, z)).Position) end
		if i % 11 == 0 then pause() end
	end
	pause()

	------------------------------------------------ débris : voitures, bus, lampadaires, cratères, morceaux de béton
	local cars = folder(debris, "Cars")
	local CARS = {
		{-72, 62, 20}, {82, -42, 100, {flipped = true}}, {-88, -72, 200, {burning = true, burnt = true}}, {62, 86, 75}, {-40, -92, 160, {crushed = true}},
		{-18, 160, 0}, {20, 210, 180, {crushed = true}}, {-12, 300, 10, {burning = true, burnt = true}}, {16, 362, 170}, {0, 250, 90},
		{170, -14, 90}, {262, 16, 270, {flipped = true, burning = true, burnt = true}}, {350, -8, 85},
		{-160, 12, 270}, {-240, -16, 100, {tilt = 8}}, {-330, 10, 260, {burning = true, burnt = true}},
	}
	for _, c in CARS do car(cars, rng, c[1], c[2], c[3], c[4]) end
	bus(debris, 96, 34, 4)
	pause()
	local lamps = folder(debris, "StreetLamps")
	for z = HALF + 20, CITY - 10, 50 do
		lamp(lamps, rng, AVE + 4, z, 90)
		lamp(lamps, rng, -AVE - 4, z, -90)
	end
	for _, side in {-1, 1} do
		for x = HALF + 20, CITY - 10, 60 do
			lamp(lamps, rng, side * x, AVE + 4, 0)
			lamp(lamps, rng, side * x, -AVE - 4, 180)
		end
	end
	for _, c in {{-HALF + 4, -HALF + 6}, {HALF - 4, -HALF + 6}, {-HALF + 4, HALF - 4}, {HALF - 4, HALF - 4}} do lamp(lamps, rng, c[1], c[2], 0) end
	pause()
	local craters = folder(debris, "Craters")
	for _, c in {{0, -6, 15}, {-20, 190, 9}, {250, 5, 10}, {-200, -10, 8}, {44, -66, 7}, {-58, 40, 6}} do crater(craters, rng, c[1], c[2], c[3]) end
	pause()
	local chunks = folder(debris, "Concrete")
	for i = 1, 150 do
		local x, z
		repeat x, z = rng:NextNumber(-CITY, CITY), rng:NextNumber(-CITY, CITY) until isRoad(x, z) and not (abs(x) < 55 and abs(z) < 55)
		local s = rng:NextNumber(1.2, 5)
		part(chunks, V(s * rng:NextNumber(0.8, 1.8), s * rng:NextNumber(0.5, 1), s), at(x, s * 0.3, z, rng:NextNumber(-30, 30), rng:NextNumber(0, 360), rng:NextNumber(-30, 30)),
			(rng:NextNumber() < 0.5 and CONCRETE or ASPHALT):Lerp(DARK, rng:NextNumber(0, 0.3)), {wedge = rng:NextNumber() < 0.35, collide = s > 2.5, query = false, shadow = false, name = "Chunk"})
		if i % 50 == 0 then pause() end
	end
	-- grandes dalles penchées au bord de la place (abris pendant le combat)
	for _, c in {{-90, -40, 30}, {88, 70, -20}, {-70, 92, 70}, {40, 96, 10}, {-96, 10, 95}} do
		part(chunks, V(16, 2, 11), at(c[1], 3, c[2], 18, c[3], 8), CONCRETE:Lerp(DARK, 0.2), {name = "Slab"})
		rubble(chunks, rng, at(c[1], 0, c[2]), 6, 3)
	end
	-- barrières de chantier
	for _, c in {{-26, 128, 10}, {24, 132, -15}, {128, 26, 80}, {-130, -24, 95}} do
		local m = Instance.new("Model")
		m.Name = "Barrier"
		local base = at(c[1], 0, c[2], 0, c[3], 0)
		part(m, V(10, 1.4, 0.5), base * CFrame.new(0, 3, 0), rgb(200, 40, 30), {name = "Board"})
		part(m, V(10, 0.5, 0.52), base * CFrame.new(0, 3, 0), rgb(230, 225, 215), {collide = false, name = "Stripe"})
		for _, x in {-4, 4} do part(m, V(0.6, 3.2, 1.6), base * CFrame.new(x, 1.6, 0), rgb(60, 60, 60), {name = "Leg"}) end
		m.Parent = debris
	end
	pause()

	------------------------------------------------ ambiance : cendres, braises, colonnes de fumée, lueurs rouges
	local ash = part(env, V(520, 1, 520), at(0, 140, 0), rgb(0, 0, 0), {collide = false, query = false, transparency = 1, name = "AshFall", shadow = false})
	local e = Instance.new("ParticleEmitter")
	e.Name = "Ash"
	e.Texture = "rbxasset://textures/particles/smoke_main.dds"
	e.Color = ColorSequence.new(rgb(120, 112, 110), rgb(60, 54, 54))
	e.LightInfluence = 0.8
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0.25)})
	e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.3), NumberSequenceKeypoint.new(1, 1)})
	e.Lifetime = NumberRange.new(10, 15)
	e.Rate = 45
	e.Speed = NumberRange.new(6, 11)
	e.EmissionDirection = Enum.NormalId.Bottom
	e.SpreadAngle = Vector2.new(25, 25)
	e.Acceleration = V(3, -1, 1.5)
	e.RotSpeed = NumberRange.new(-60, 60)
	e.Rotation = NumberRange.new(0, 360)
	e.Parent = ash
	local emberField = part(env, V(300, 1, 300), at(0, 1, 0), rgb(0, 0, 0), {collide = false, query = false, transparency = 1, name = "EmberField", shadow = false})
	local em = Instance.new("ParticleEmitter")
	em.Name = "Embers"
	em.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	em.Color = ColorSequence.new(rgb(255, 210, 110), EMBER)
	em.LightEmission, em.LightInfluence = 1, 0
	em.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.45), NumberSequenceKeypoint.new(1, 0)})
	em.Lifetime = NumberRange.new(3, 6)
	em.Rate = 30
	em.Speed = NumberRange.new(2, 6)
	em.EmissionDirection = Enum.NormalId.Top
	em.SpreadAngle = Vector2.new(40, 40)
	em.Acceleration = V(2, 1.5, 1)
	em.Parent = emberField
	for i, c in {{-260, -300}, {300, -260}, {-340, 220}, {280, 330}, {-120, -380}, {390, 60}, {-400, -60}, {140, 400}} do
		local col = part(env, V(10, 10, 10), at(c[1], 150, c[2]), rgb(0, 0, 0), {collide = false, query = false, transparency = 1, name = "SmokeColumn", shadow = false})
		local s = Instance.new("ParticleEmitter")
		s.Name = "Smoke"
		s.Texture = "rbxasset://textures/particles/smoke_main.dds"
		s.Color = ColorSequence.new(rgb(46, 36, 36), rgb(20, 16, 18))
		s.LightInfluence = 0.5
		s.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 24), NumberSequenceKeypoint.new(1, 70)})
		s.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 1)})
		s.Lifetime = NumberRange.new(12, 16)
		s.Rate = 1.4
		s.Speed = NumberRange.new(10, 16)
		s.EmissionDirection = Enum.NormalId.Top
		s.SpreadAngle = Vector2.new(8, 8)
		s.Acceleration = V(3, 0, 2)
		s.RotSpeed = NumberRange.new(-10, 10)
		s.Rotation = NumberRange.new(0, 360)
		s.Parent = col
		if i <= 4 then
			local glow = part(env, V(4, 4, 4), at(c[1], 60, c[2]), FIRE, {collide = false, query = false, transparency = 1, name = "FireGlow", shadow = false})
			local l = Instance.new("PointLight")
			l.Color, l.Range, l.Brightness, l.Shadows = rgb(255, 90, 40), 120, 3, false
			l.Parent = glow
		end
	end
	-- lueurs rouges et orangées basses qui éclairent les ruines autour de la place
	for _, c in {{-96, -96}, {96, -96}, {-96, 96}, {96, 96}, {0, -100}, {0, 150}} do
		local g = part(env, V(2, 2, 2), at(c[1], 8, c[2]), BLOOD, {collide = false, query = false, transparency = 1, name = "RedGlow", shadow = false})
		local l = Instance.new("PointLight")
		l.Color, l.Range, l.Brightness, l.Shadows = rgb(255, 50, 30), 70, 1.6, false
		l.Parent = g
	end
	local boomFolder = folder(env, "ExplosionPoints")
	for i, p in explosions do
		local m = part(boomFolder, V(1, 1, 1), CFrame.new(p), rgb(0, 0, 0), {collide = false, query = false, transparency = 1, name = "ExplosionPoint", shadow = false})
		m:SetAttribute("Index", i)
	end
	pause()

	------------------------------------------------ arène du boss : murs invisibles, places de départ, repères
	arena:SetAttribute("Center", Config.CENTER)
	arena:SetAttribute("Half", Config.ARENA_HALF)
	local A = Config.ARENA_HALF
	for _, w in {{0, -A - 2, A * 2 + 8, 4}, {0, A + 2, A * 2 + 8, 4}, {-A - 2, 0, 4, A * 2 + 8}, {A + 2, 0, 4, A * 2 + 8}} do
		part(arena, V(w[3], 120, w[4]), at(w[1], 60, w[2]), rgb(255, 0, 0), {transparency = 1, query = false, name = "ArenaWall", shadow = false})
	end
	for i = 1, 8 do
		marker(arena, "Spawn", V(-35 + (i - 1) * 10, 3, 78 + (i % 2) * 6), V(2, 1, 2))
	end
	marker(arena, "BossSpot", Config.Points.BossSpot + V(0, 1, 0))
	marker(points, "HeroKino", Config.Points.HeroKino + V(0, 1, 0))
	marker(points, "HeroRex", Config.Points.HeroRex + V(0, 1, 0))
	marker(points, "BossLand", Config.Points.BossLand + V(0, 1, 0))
	marker(points, "BossWall", V(0, 30, Config.Points.HotelFront))
	marker(points, "TrueDemonRise", Config.Points.TrueDemon)
	marker(points, "CamFlyStart", V(0, 170, 400))
	marker(points, "CamFlyEnd", V(0, 6, 92))
	return city
end

---------------------------------------------------------------- ville unique (Workspace pendant l'event, ServerStorage le reste du temps)
local city
function Builder.get()
	if city and city.Parent then return city end
	city = workspace:FindFirstChild("DestroyedCity") or ServerStorage:FindFirstChild("DestroyedCity")
	if not city then
		city = Builder.build(ServerStorage)
	end
	return city
end
function Builder.show(on)
	local c = Builder.get()
	local target = on and workspace or ServerStorage
	if c.Parent ~= target then c.Parent = target end
	return c
end
function Builder.setCollapsed(on)
	local c = Builder.get()
	local h = c:FindFirstChild("Buildings") and c.Buildings:FindFirstChild("AbandonedHotel")
	if not h then return end
	for _, p in h.Collapsible:GetChildren() do
		if p:IsA("BasePart") then
			p.Transparency = on and 1 or 0
			p.CanCollide = not on and p.Name == "FacadeBlock"
			p.CanQuery = not on and p.Name == "FacadeBlock"
		end
	end
	for _, p in h.CollapseRubble:GetChildren() do
		if p:IsA("BasePart") then
			p.Transparency = on and 0 or 1
			p.CanCollide, p.CanQuery = on, on
		end
	end
end

return Builder

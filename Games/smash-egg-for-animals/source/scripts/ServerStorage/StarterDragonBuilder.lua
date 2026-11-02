-- Outil d'édition (pas utilisé en jeu) : le DRAGON DE DÉPART, style "gros blocs à studs" (comme les animaux du jeu).
-- Formes simples et trapues, studs sur toutes les faces, bouche rectangulaire ouverte avec dents blanches.
-- Mêmes articulations que les autres dragons (Weld + attribut Anim), donc mêmes animations et même pilotage.
local Kit = require(script.Parent.PetBuilderKit)
local rgb = Kit.rgb
local V = Vector3.new
local rad = math.rad
local M = {}
local SCALE = 0.975 -- 1,5 fois la première version
local STUDS = Enum.SurfaceType.Studs

local DEFAULT = {
	Red = rgb(226, 44, 40), Dark = rgb(160, 26, 30), Light = rgb(246, 84, 62), Black = rgb(30, 24, 30),
	Cream = rgb(255, 226, 160), Orange = rgb(255, 150, 40), Yellow = rgb(255, 214, 80), White = rgb(255, 255, 255),
	Horn = rgb(244, 232, 204), Mouth = rgb(80, 12, 24), Tongue = rgb(255, 120, 150), Wood = rgb(124, 80, 48), Gold = rgb(255, 204, 70),
}

function M.build(parent, variant)
	variant = variant or {}
	local C = setmetatable(variant.Colors or {}, {__index = DEFAULT}) -- couleurs du dragon ; le reste vient du dragon de feu
	local k = Kit.new(variant.Name or "Fire Dragon")
	-- bloc à studs sur toutes les faces (matière Plastic) ; mat = autre matière sans studs
	local function B(to, size, cf, color, mat)
		local p = k:box(to, size, cf, color)
		if mat then
			p.Material = mat
			p.TopSurface = Enum.SurfaceType.Smooth
		else
			p.TopSurface, p.BottomSurface, p.LeftSurface, p.RightSurface, p.FrontSurface, p.BackSurface = STUDS, STUDS, STUDS, STUDS, STUDS, STUDS
		end
		return p
	end
	local function R45(x, y, z, ax) return CFrame.new(x, y, z) * (ax == "y" and CFrame.Angles(0, rad(45), 0) or CFrame.Angles(rad(45), 0, 0)) end

	-- ------------------------------------------------------------ CORPS : un gros bloc, dos sombre, ventre crème
	B(nil, V(5, 3, 7), V(0, 0, 0), C.Red)
	B(nil, V(4.2, 0.6, 6.2), V(0, 1.7, 0), C.Dark)
	B(nil, V(4.2, 0.6, 6.2), V(0, -1.7, 0), C.Cream)
	B(nil, V(3.4, 2.0, 0.5), V(0, -0.3, 3.65), C.Cream)                       -- plastron
	for _, s in {1, -1} do                                                     -- écailles en losange sur les flancs
		B(nil, V(0.4, 1.3, 1.3), R45(s * 2.55, 0.2, 1.4), C.Dark)
		B(nil, V(0.4, 1.3, 1.3), R45(s * 2.55, 0.2, -1.4), C.Light)
	end
	for i, z in {2.3, 0.7, -0.9, -2.5} do                                      -- crête dorsale
		B(nil, V(0.7, 1.2, 1.2), R45(0, 2.35, z), i % 2 == 1 and C.Orange or C.Yellow)
	end

	-- ------------------------------------------------------------ PATTES : bloc + pied large + trois griffes blanches
	for _, sx in {1, -1} do
		for _, sz in {1, -1} do
			local hip = V(sx * 1.9, -1.2, sz * 2.4)
			local j = k:joint("Leg", hip, {Phase = (sx * sz == 1) and 0 or math.pi})
			B(j, V(1.7, 1.7, 1.7), hip + V(0, -0.85, 0), C.Dark)
			B(j, V(2.0, 0.7, 2.3), hip + V(0, -1.95, 0.3), C.Red)
			for c = -1, 1 do B(j, V(0.42, 0.42, 0.55), hip + V(c * 0.62, -2.08, 1.65), C.White, Enum.Material.SmoothPlastic) end
		end
	end
	local groundY = -1.2 - 2.3

	-- ------------------------------------------------------------ COU et TÊTE
	local neck = k:joint("Neck", V(0, 0.9, 3.0))
	B(neck, V(2.8, 2.8, 2.2), V(0, 1.7, 3.8), C.Red)
	B(neck, V(1.8, 2.2, 0.4), V(0, 1.5, 4.95), C.Cream)
	B(neck, V(0.7, 1.1, 1.1), R45(0, 3.2, 3.3), C.Orange)
	local head = k:joint("Head", V(0, 2.6, 4.4), {Parent = neck})
	B(head, V(4.4, 3.2, 3.4), V(0, 3.9, 5.6), C.Red)                           -- crâne (face avant à z = 7.3)
	B(head, V(3.6, 0.5, 2.8), V(0, 5.55, 5.5), C.Dark)                         -- dessus du crâne
	-- yeux : blanc, pupille noire, reflet, sourcil froncé
	for _, s in {1, -1} do
		B(head, V(1.3, 1.4, 0.25), V(s * 1.2, 4.55, 7.32), C.White, Enum.Material.SmoothPlastic)
		B(head, V(0.65, 0.9, 0.3), V(s * 1.05, 4.45, 7.36), C.Pupil or C.Black, C.Pupil and Enum.Material.Neon or Enum.Material.SmoothPlastic)
		B(head, V(0.28, 0.28, 0.34), V(s * 1.22, 4.78, 7.38), C.White, Enum.Material.Neon)
		B(head, V(1.6, 0.45, 0.5), CFrame.new(s * 1.2, 5.35, 7.3) * CFrame.Angles(0, 0, rad(s * 16)), C.Dark)
		B(head, V(0.5, 1.4, 1.4), R45(s * 2.4, 3.6, 4.9), C.Orange)                -- joue
	end
	-- BOUCHE rectangulaire, courte : mâchoire du haut fixe, fond sombre, dents blanches
	B(head, V(3.6, 1.1, 2.0), V(0, 3.25, 8.2), C.Red)                           -- museau (dessous à y = 2.7)
	B(head, V(3.2, 0.35, 1.7), V(0, 3.92, 8.15), C.Light)
	for _, s in {1, -1} do B(head, V(0.5, 0.35, 0.5), V(s * 0.85, 4.05, 8.75), C.Black, Enum.Material.SmoothPlastic) end   -- narines
	B(head, V(3.2, 1.6, 0.3), V(0, 2.1, 7.35), C.Mouth, Enum.Material.SmoothPlastic)                                        -- fond de la gueule
	B(head, V(3.2, 0.2, 1.8), V(0, 2.68, 8.2), C.Mouth, Enum.Material.SmoothPlastic)                                         -- palais
	for i = -2, 2 do B(head, V(0.44, 0.42, 0.4), V(i * 0.7, 2.5, 9.0), C.White, Enum.Material.SmoothPlastic) end            -- dents du haut, devant
	for _, s in {1, -1} do
		for _, z in {7.75, 8.35} do B(head, V(0.36, 0.4, 0.4), V(s * 1.6, 2.5, z), C.White, Enum.Material.SmoothPlastic) end -- dents du haut, côtés
	end
	B(head, V(3.7, 1.0, 1.7), V(0, 1.9, 6.5), C.Red)                            -- gorge sous le crâne : ferme le dessous de la tête
	B(head, V(2.6, 0.4, 1.4), V(0, 1.35, 6.5), C.Cream)
	-- mâchoire du bas, articulée : presque fermée au repos, les dents du bas passent derrière celles du haut
	local jaw = k:joint("Jaw", V(0, 2.3, 7.2), {Parent = head})
	B(jaw, V(3.5, 0.95, 1.85), V(0, 1.9, 8.1), C.Red)                           -- dessus à y = 2.375 (museau à 2.7)
	B(jaw, V(2.7, 0.4, 1.5), V(0, 1.35, 8.1), C.Cream)                          -- menton
	B(jaw, V(3.1, 0.12, 1.7), V(0, 2.39, 8.1), C.Mouth, Enum.Material.SmoothPlastic)
	B(jaw, V(1.7, 0.2, 1.4), V(0, 2.46, 7.95), C.Tongue, Enum.Material.SmoothPlastic) -- langue
	for i = 0, 3 do B(jaw, V(0.4, 0.42, 0.34), V(-1.05 + i * 0.7, 2.58, 8.6), C.White, Enum.Material.SmoothPlastic) end      -- dents du bas, devant
	for _, s in {1, -1} do B(jaw, V(0.32, 0.4, 0.36), V(s * 1.35, 2.56, 8.05), C.White, Enum.Material.SmoothPlastic) end
	-- cornes en trois blocs qui s'affinent, crête sur le crâne
	for _, s in {1, -1} do
		B(head, V(1.0, 1.0, 1.0), V(s * 1.35, 6.2, 4.9), C.Horn, Enum.Material.SmoothPlastic)
		B(head, V(0.75, 0.9, 0.75), V(s * 1.55, 7.05, 4.6), C.Horn, Enum.Material.SmoothPlastic)
		B(head, V(0.48, 0.8, 0.48), V(s * 1.75, 7.8, 4.3), C.White, Enum.Material.SmoothPlastic)
		B(head, V(1.2, 0.3, 1.2), V(s * 1.35, 5.85, 4.9), C.Gold, Enum.Material.Metal)   -- anneau doré à la base
	end
	B(head, V(0.7, 1.0, 1.0), R45(0, 6.1, 6.0), C.Yellow)
	B(head, V(0.7, 0.8, 0.8), R45(0, 6.0, 5.0), C.Orange)

	-- ------------------------------------------------------------ AILES : bras + grandes plaques à studs, liseré lumineux
	for _, s in {1, -1} do
		local base = V(s * 2.3, 1.5, 1.2)
		local wing = k:joint("Wing", base, {Side = s})
		B(wing, V(3.2, 0.7, 0.9), base + V(s * 1.7, 0.1, 0), C.Dark)
		B(wing, V(3.0, 0.3, 3.2), base + V(s * 1.7, -0.05, -1.9), C.WingA or C.Orange)
		B(wing, V(3.0, 0.14, 0.3), base + V(s * 1.7, -0.05, -3.55), C.Glow or C.Yellow, Enum.Material.Neon)
		B(wing, V(0.5, 0.9, 0.5), base + V(s * 3.2, 0.7, 0.1), C.White, Enum.Material.SmoothPlastic)   -- griffe du coude
		local tipPos = base + V(s * 3.3, 0, 0)
		local tip = k:joint("WingTip", tipPos, {Parent = wing, Side = s})
		B(tip, V(2.8, 0.6, 0.8), tipPos + V(s * 1.5, 0.1, -0.05), C.Dark)
		B(tip, V(2.8, 0.3, 2.7), tipPos + V(s * 1.5, -0.05, -1.7), C.WingA or C.Orange)
		B(tip, V(2.8, 0.14, 0.3), tipPos + V(s * 1.5, -0.05, -3.1), C.Glow or C.Yellow, Enum.Material.Neon)
		B(tip, V(1.5, 0.3, 1.7), tipPos + V(s * 3.6, -0.05, -1.0), C.WingB or C.Yellow)
		B(tip, V(0.45, 0.8, 0.45), tipPos + V(s * 2.9, 0.6, 0.1), C.White, Enum.Material.SmoothPlastic)
	end

	-- ------------------------------------------------------------ QUEUE : trois blocs qui s'affinent, pointe en flamme
	local parentJoint
	local tailDefs = {{V(0, 0.1, -3.5), V(2.8, 2.2, 2.0)}, {V(0, 0.0, -5.4), V(2.0, 1.6, 1.9)}, {V(0, -0.1, -7.2), V(1.3, 1.1, 1.8)}}
	for i, def in tailDefs do
		local j = k:joint("Tail", def[1], {Parent = parentJoint, Phase = (i - 1) * 0.8})
		local size = def[2]
		B(j, size, def[1] + V(0, 0, -size.Z / 2 + 0.1), i % 2 == 1 and C.Red or C.Dark)
		B(j, V(size.X * 0.7, 0.3, size.Z * 0.9), def[1] + V(0, -size.Y / 2 - 0.05, -size.Z / 2 + 0.1), C.Cream)
		B(j, V(0.6, 1.0 - i * 0.12, 1.0 - i * 0.12), R45(0, def[1].Y + size.Y / 2 + 0.3, def[1].Z - size.Z / 2 + 0.1), i % 2 == 1 and C.Yellow or C.Orange)
		parentJoint = j
		if i == 3 then
			B(j, V(1.9, 0.6, 1.9), R45(0, -0.1, -9.5, "y"), C.WingA or C.Orange, Enum.Material.Neon)
			B(j, V(1.1, 0.7, 1.1), R45(0, -0.1, -10.1, "y"), C.Glow or C.Yellow, Enum.Material.Neon)
		end
	end

	-- ------------------------------------------------------------ SELLE (bois + métal doré) et siège
	B(nil, V(3.4, 0.6, 2.6), V(0, 2.2, -0.1), C.Wood, Enum.Material.Wood)
	B(nil, V(3.6, 1.0, 0.5), V(0, 2.6, 1.3), C.Gold, Enum.Material.Metal)
	B(nil, V(3.6, 1.2, 0.45), V(0, 2.7, -1.5), C.Wood, Enum.Material.Wood)
	B(nil, V(5.3, 0.6, 0.9), V(0, 0.6, -0.1), C.Wood, Enum.Material.Wood)
	for _, s in {1, -1} do B(nil, V(0.3, 0.9, 0.9), V(s * 2.7, 0.6, -0.1), C.Gold, Enum.Material.Metal) end
	local seat = Instance.new("Seat")
	seat.Name = "Seat"
	seat.CFrame = k.Origin * CFrame.new(0, 2.75, -0.1) * CFrame.Angles(0, math.pi, 0)
	seat.Transparency = 1
	seat.Massless = true
	seat.CanCollide, seat.CanTouch, seat.CanQuery = false, false, false
	local sw = Instance.new("WeldConstraint")
	sw.Part0, sw.Part1 = k.Root, seat
	sw.Parent = seat
	seat.Parent = k.Model
	local mouth = Instance.new("Attachment")
	mouth.Name = "Mouth"
	mouth.Parent = head.Part
	mouth.WorldCFrame = k.Origin * CFrame.new(0, 2.55, 9.1) * CFrame.Angles(0, math.pi, 0)

	-- détails propres à la variante (cristaux, feuilles, éclairs...) : B = bloc, R45 = losange
	if variant.Extra then variant.Extra({B = B, R45 = R45, V = V, rad = rad, C = C, Head = head, Kit = k}) end

	local model, root = k.Model, k.Root
	model:ScaleTo(SCALE)
	seat.Size = V(2.2, 0.3, 2.2)
	local height = (5.5 - groundY) * SCALE
	model:SetAttribute("GroundOffset", -groundY * SCALE)
	model:SetAttribute("Level", 1)
	local fire = variant.Fire or {Color3.fromRGB(255, 240, 150), Color3.fromRGB(255, 150, 40), Color3.fromRGB(220, 50, 20)}
	model:SetAttribute("Fire1", fire[1])
	model:SetAttribute("Fire2", fire[2])
	model:SetAttribute("Fire3", fire[3])
	model:SetAttribute("Height", height)
	root.PivotOffset = CFrame.new(0, groundY * SCALE, 0)
	local old = parent:FindFirstChild(model.Name)
	if old then old:Destroy() end
	model.Parent = parent
	return model, k.Count
end

return M

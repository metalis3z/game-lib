-- Thème Halloween : déguise les gardiens des zones (ZoneBossServer) au moment où ils apparaissent.
-- Les modèles de ServerStorage.ZoneBosses ne sont pas modifiés : on recolore et on habille la copie.
-- Chaque pièce ajoutée est soudée à l'articulation voulue (Head, Body, WingR...), donc elle suit les animations.
-- Les modèles regardent vers +Z, posés à l'origine : toutes les positions ci-dessous sont dans ce repère.
local M = {}
local rgb = Color3.fromRGB
local rad = math.rad
local A = CFrame.Angles
local function V(x, y, z) return Vector3.new(x, y, z) end

-- nom affiché de chaque gardien déguisé
M.Titles = {
	Chicken = "Zombie Chicken", Goose = "Vampire Goose", Eagle = "Skeleton Eagle", Bee = "Pumpkin Bee",
	Phoenix = "Witch Phoenix", Pegasus = "Nightmare Pegasus", Demon = "Mummy Demon",
}

local function key(part)
	local c = part.Color
	return string.format("%d,%d,%d", math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5)) .. (part.Material == Enum.Material.Neon and "N" or "")
end

-- prépare un modèle : retrouve ses articulations et à laquelle chaque bloc est soudé
local function open(model)
	local S = {Model = model, Joints = {}, Parts = {}}
	local nameOf = {}
	for _, d in model:GetDescendants() do
		if d:IsA("Weld") and d:GetAttribute("Anim") then
			local side, pair = d:GetAttribute("Side"), d:GetAttribute("Pair")
			local name = d:GetAttribute("Anim") .. (side and (side == 1 and "R" or "L") or "") .. (pair == 2 and "2" or "")
			S.Joints[name] = d.Part1
			nameOf[d.Part1] = name
		end
	end
	for _, p in model:GetDescendants() do
		if p:IsA("BasePart") and p.Name ~= "JointPart" and p.Name ~= "Root" then
			local weld = p:FindFirstChildOfClass("WeldConstraint")
			table.insert(S.Parts, {Part = p, Joint = weld and nameOf[weld.Part0] or "?", Key = key(p)})
		end
	end

	-- recolore : map["r,g,b"] ou map["Joint:r,g,b"] = Color3, ou {Color3, neon (true/false)}. Les clés des pièces Neon finissent par N.
	function S.recolor(map)
		for _, e in S.Parts do
			local to = map[e.Joint .. ":" .. e.Key] or map[string.gsub(e.Joint, "[RL]2?$", "") .. ":" .. e.Key] or map[e.Key]
			if to and not e.Done then
				e.Done = true
				if typeof(to) == "Color3" then
					e.Part.Color = to
				else
					e.Part.Color = to[1]
					e.Part.Material = to[2] and Enum.Material.Neon or Enum.Material.Plastic
				end
			end
		end
	end

	-- les yeux : pupilles (nommées Pupil), plaque de l'oeil derrière chaque pupille, petit reflet Neon
	function S.eyes(plate, pupil, glint)
		for _, e in S.Parts do
			if e.Part.Name == "Pupil" then
				for _, o in S.Parts do
					local p = o.Part
					if p ~= e.Part and o.Joint == e.Joint and p.Name == "Block" and (p.Position - e.Part.Position).Magnitude < 0.75 then
						o.Done = true
						if p.Size.X > e.Part.Size.X then
							if plate then p.Color, p.Material = plate[1], plate[2] and Enum.Material.Neon or Enum.Material.Plastic end
						elseif glint then
							p.Color = glint
						end
					end
				end
				e.Done = true
				if pupil then e.Part.Color, e.Part.Material = pupil[1], pupil[2] and Enum.Material.Neon or Enum.Material.Plastic end
			end
		end
	end

	-- ajoute un bloc soudé à une articulation. opts : Neon, Wedge, Smooth (sans studs), Name, Transparency
	function S.add(joint, size, cf, color, opts)
		opts = opts or {}
		local holder = S.Joints[joint]
		if not holder then return nil end
		local p = Instance.new(opts.Wedge and "WedgePart" or "Part")
		p.Name = opts.Name or (opts.Neon and "Glow" or "Block")
		p.Size = size
		p.CFrame = typeof(cf) == "Vector3" and CFrame.new(cf) or cf
		p.Color = color
		p.Material = opts.Neon and Enum.Material.Neon or Enum.Material.Plastic
		p.Transparency = opts.Transparency or 0
		local surface = (opts.Smooth or opts.Neon or opts.Wedge) and Enum.SurfaceType.Smooth or Enum.SurfaceType.Studs
		p.TopSurface, p.BottomSurface, p.FrontSurface, p.BackSurface, p.LeftSurface, p.RightSurface = surface, surface, surface, surface, surface, surface
		p.Anchored = false
		p.Massless = true
		p.CanCollide, p.CanQuery, p.CanTouch = false, false, false
		p.CastShadow = not opts.Neon
		local weld = Instance.new("WeldConstraint")
		weld.Part0, weld.Part1 = holder, p
		weld.Parent = p
		p.Parent = model
		return p
	end

	-- bande qui fait le tour d'une boîte (bandage, bague) : 4 plaques. cf = centre de la bande, wx / wz = largeur et profondeur de la boîte
	function S.ring(joint, cf, wx, wz, h, th, color, opts)
		cf = typeof(cf) == "Vector3" and CFrame.new(cf) or cf
		opts = opts or {Smooth = true}
		S.add(joint, V(th, h, wz + th * 2), cf * CFrame.new(wx / 2 + th / 2, 0, 0), color, opts)
		S.add(joint, V(th, h, wz + th * 2), cf * CFrame.new(-wx / 2 - th / 2, 0, 0), color, opts)
		S.add(joint, V(wx, h, th), cf * CFrame.new(0, 0, wz / 2 + th / 2), color, opts)
		S.add(joint, V(wx, h, th), cf * CFrame.new(0, 0, -wz / 2 - th / 2), color, opts)
	end
	return S
end

local BONE, BONE2, INK = rgb(244, 240, 226), rgb(214, 206, 184), rgb(24, 20, 30)
local SKINS = {}

---------------------------------------------------------------- POULET ZOMBIE
function SKINS.Chicken(S)
	local add = S.add
	S.eyes({rgb(34, 28, 40), false}, {rgb(170, 255, 60), true}, rgb(230, 255, 160))
	S.recolor({
		["250,250,250"] = rgb(150, 178, 128), ["236,228,214"] = rgb(118, 146, 102), -- plumes verdâtres
		["226,44,40"] = rgb(132, 36, 72), ["170,26,30"] = rgb(92, 22, 52),            -- crête et barbillon violacés
		["255,205,50"] = rgb(150, 150, 80), ["255,150,40"] = rgb(120, 112, 56),       -- bec et pattes ternes
		["120,20,30"] = rgb(60, 20, 40),
	})
	-- cervelle à l'air sur le crâne
	add("Head", V(2.9, 0.14, 3.3), V(1.75, 20.46, 5.0), rgb(92, 22, 44), {Smooth = true})
	add("Head", V(2.2, 0.7, 2.6), V(1.8, 20.75, 5.0), rgb(255, 140, 180))
	add("Head", V(1.3, 0.5, 1.4), V(2.0, 21.25, 5.3), rgb(255, 170, 200))
	add("Head", V(0.16, 0.2, 2.5), V(1.5, 21.12, 5.0), rgb(200, 90, 130), {Smooth = true})
	add("Head", V(2.1, 0.2, 0.16), V(1.8, 21.12, 4.4), rgb(200, 90, 130), {Smooth = true})
	-- plaie au poitrail : on voit les côtes
	add("Body", V(3.2, 3.6, 0.16), V(-1.5, 8.8, 6.16), rgb(104, 22, 44), {Smooth = true})
	for i = 0, 2 do add("Body", V(2.9, 0.5, 0.34), V(-1.5, 9.9 - i * 1.1, 6.3), BONE, {Smooth = true}) end
	add("Body", V(0.5, 3.0, 0.3), V(-1.5, 8.8, 6.24), BONE2, {Smooth = true})
	-- cicatrice recousue
	add("Body", V(0.22, 3.4, 0.14), CFrame.new(2.1, 9.4, 6.16) * A(0, 0, rad(12)), INK, {Smooth = true})
	for i = -1, 1 do add("Body", V(1.0, 0.2, 0.16), CFrame.new(2.1 - i * 0.24, 9.4 + i * 1.1, 6.18) * A(0, 0, rad(12)), INK, {Smooth = true}) end
	-- taches de pourriture
	add("Body", V(2.6, 0.14, 3.2), V(-1.8, 13.86, -1.4), rgb(86, 108, 82), {Smooth = true})
	add("Body", V(1.8, 0.14, 2.0), V(2.0, 13.86, 2.2), rgb(98, 76, 116), {Smooth = true})
	add("WingL", V(0.14, 2.4, 2.8), V(-6.06, 9.6, 0.8), rgb(98, 76, 116), {Smooth = true})
	add("WingR", V(0.14, 1.8, 2.2), V(6.06, 8.4, -1.6), rgb(86, 108, 82), {Smooth = true})
	-- os qui dépasse de l'aile
	add("WingR", V(2.4, 0.45, 0.45), CFrame.new(6.9, 10.7, 1.2) * A(0, 0, rad(20)), BONE, {Smooth = true})
	add("WingR", V(0.5, 0.8, 0.8), CFrame.new(8.0, 11.1, 1.2) * A(0, 0, rad(20)), BONE)
	-- flèche plantée dans le dos
	local arrow = CFrame.new(-1.6, 15.4, -2.6) * A(rad(-50), 0, rad(8))
	add("Body", V(0.3, 0.3, 5.0), arrow, rgb(110, 76, 44), {Smooth = true})
	add("Body", V(0.14, 1.1, 1.3), arrow * CFrame.new(0, 0, -2.0), rgb(200, 40, 50), {Smooth = true})
	add("Body", V(1.1, 0.14, 1.3), arrow * CFrame.new(0, 0, -2.0), rgb(200, 40, 50), {Smooth = true})
	-- bave verte
	add("Jaw", V(0.3, 1.2, 0.3), V(0.55, 15.3, 10.3), rgb(150, 255, 70), {Neon = true})
	add("Jaw", V(0.24, 0.7, 0.24), V(-0.5, 15.5, 10.1), rgb(150, 255, 70), {Neon = true})
end

---------------------------------------------------------------- OIE VAMPIRE
function SKINS.Goose(S)
	local add = S.add
	local BLACK, RED, GOLD = rgb(22, 18, 30), rgb(172, 22, 36), rgb(255, 200, 60)
	S.eyes({rgb(255, 232, 232), false}, {rgb(255, 30, 40), true}, rgb(255, 200, 200))
	S.recolor({
		["250,250,250"] = rgb(222, 218, 236), ["236,232,224"] = rgb(196, 190, 214), -- teint blafard
		["70,70,80"] = BLACK, ["190,190,200"] = rgb(58, 48, 72),
		["226,110,30"] = rgb(72, 60, 84), ["255,150,40"] = rgb(96, 84, 110),
		["255,130,150"] = rgb(200, 30, 50),
	})
	-- cape : sur le dos, puis qui retombe derrière la queue
	add("Body", V(7.4, 0.4, 13.6), V(0, 12.5, -3.7), BLACK, {Smooth = true})
	local drape = CFrame.new(0, 8.9, -11.5) * A(rad(-10), 0, 0)
	add("Body", V(8.4, 7.6, 0.4), drape, BLACK, {Smooth = true})
	add("Body", V(7.6, 7.0, 0.16), drape * CFrame.new(0, 0, 0.3), RED, {Smooth = true})
	for i = -1.5, 1.5, 1 do add("Body", V(1.5, 1.6, 0.4), drape * CFrame.new(i * 2.1, -4.3, 0) * A(0, 0, rad(45)), BLACK, {Smooth = true}) end
	-- grand col relevé autour du cou
	local back = CFrame.new(0, 14.5, 1.7) * A(rad(-10), 0, 0)
	add("Body", V(6.0, 4.6, 0.4), back, BLACK, {Smooth = true})
	add("Body", V(5.4, 4.2, 0.16), back * CFrame.new(0, 0, 0.3), RED, {Smooth = true})
	for _, s in {1, -1} do
		local side = CFrame.new(s * 3.0, 14.3, 3.5) * A(0, 0, rad(-14) * s)
		add("Body", V(0.4, 4.4, 3.6), side, BLACK, {Smooth = true})
		add("Body", V(0.16, 4.0, 3.2), side * CFrame.new(-s * 0.3, 0, 0), RED, {Smooth = true})
		add("Body", V(0.4, 1.6, 3.6), side * CFrame.new(0, 3.0, 0) * A(0, math.pi, 0), BLACK, {Wedge = true}) -- pointe du col, haute derrière
	end
	-- médaillon et sa chaîne
	for _, s in {1, -1} do add("Body", V(0.22, 2.8, 0.14), CFrame.new(s * 0.95, 10.9, 6.16) * A(0, 0, rad(34) * s), GOLD, {Smooth = true}) end
	add("Body", V(1.5, 1.5, 0.22), CFrame.new(0, 9.5, 6.2) * A(0, 0, rad(45)), GOLD, {Smooth = true})
	add("Body", V(0.8, 0.8, 0.28), CFrame.new(0, 9.5, 6.26) * A(0, 0, rad(45)), rgb(255, 30, 50), {Neon = true})
	-- cheveux noirs plaqués, pointe sur le front
	add("Head", V(4.4, 0.4, 4.8), V(0, 19.62, 6.0), BLACK)
	add("Head", V(1.5, 0.4, 1.5), CFrame.new(0, 19.62, 8.0) * A(0, rad(45), 0), BLACK, {Smooth = true})
	for _, s in {1, -1} do add("Head", V(0.3, 2.0, 2.4), V(s * 2.22, 18.7, 5.0), BLACK, {Smooth = true}) end
	-- crocs
	for _, s in {1, -1} do add("Head", V(0.4, 1.2, 0.5), CFrame.new(s * 1.28, 16.1, 10.5) * A(math.pi, 0, 0), rgb(255, 255, 250), {Wedge = true}) end
end

---------------------------------------------------------------- AIGLE SQUELETTE
function SKINS.Eagle(S)
	local add = S.add
	local GAP, SOUL = rgb(26, 22, 32), rgb(90, 255, 230)
	S.eyes({rgb(16, 12, 20), false}, {SOUL, true}, rgb(200, 255, 245))
	-- un vrai squelette : la chair et les plumes disparaissent, il ne reste que le crâne et les serres, puis on pose les os
	local keep = {Head = true, Jaw = true, FootL = true, FootR = true}
	for _, e in S.Parts do
		if not keep[e.Joint] then
			e.Done = true
			e.Part.Transparency = 1
			e.Part.CastShadow = false
		end
	end
	S.recolor({
		["250,250,250"] = BONE, ["226,226,232"] = rgb(222, 216, 198), ["255,220,90"] = rgb(232, 222, 180),
		["255,205,50"] = rgb(226, 214, 170), ["226,160,30"] = rgb(200, 186, 140), ["200,200,206"] = GAP, ["40,30,26"] = rgb(190, 182, 160),
	})
	-- un os entre deux points, avec ses deux têtes
	local function bone(joint, a, b, thick, color)
		local mid, len = (a + b) / 2, (b - a).Magnitude
		add(joint, V(thick, thick, len), CFrame.lookAt(mid, b), color or BONE, {Smooth = true})
		add(joint, V(thick * 1.5, thick * 1.5, thick * 1.5), CFrame.lookAt(a, b), BONE2)
		add(joint, V(thick * 1.5, thick * 1.5, thick * 1.5), CFrame.lookAt(b, a), BONE2)
	end
	-- fêlure sur le crâne
	add("Head", V(0.16, 0.12, 1.5), CFrame.new(0.5, 17.26, 6.6) * A(0, rad(25), 0), GAP, {Smooth = true})
	add("Head", V(0.16, 0.12, 1.2), CFrame.new(0.95, 17.26, 5.5) * A(0, rad(-30), 0), GAP, {Smooth = true})
	-- cou : vertèbres
	for i = 0, 5 do add("Neck", V(1.1 - i * 0.05, 0.62, 1.1 - i * 0.05), CFrame.new(0, 10.4 + i * 0.75, 2.2 + i * 0.5) * A(rad(-30), 0, 0), i % 2 == 0 and BONE or BONE2) end
	-- colonne vertébrale
	for i = 0, 8 do add("Body", V(1.0, 0.8, 0.9), V(0, 12.5 - i * 0.14, 3.6 - i * 1.02), i % 2 == 0 and BONE or BONE2) end
	for i = 0, 8, 2 do add("Body", V(0.3, 0.7, 0.5), V(0, 13.2 - i * 0.14, 3.6 - i * 1.02), BONE, {Smooth = true}) end -- épines
	-- cage thoracique : cinq paires de côtes qui se referment sur le bréchet
	for i = 0, 4 do
		local z, w, bottom = 3.4 - i * 1.5, 3.3 - i * 0.2, 6.2 + i * 0.5
		local top = 12.2 - i * 0.2
		for _, s in {1, -1} do
			add("Body", V(w - 0.3, 0.42, 0.42), V(s * (w + 0.3) / 2, top, z), BONE, {Smooth = true})                 -- départ sur la colonne
			add("Body", V(0.42, top - bottom, 0.42), V(s * w, (top + bottom) / 2, z), BONE, {Smooth = true})           -- flanc
			add("Body", V(0.6, 0.6, 0.6), V(s * w, top, z), BONE2)
			add("Body", V(w - 1.0, 0.42, 0.42), CFrame.new(s * (w + 0.6) / 2, bottom - 0.3, z + 0.3) * A(0, rad(18) * s, rad(-18) * s), BONE, {Smooth = true}) -- retour vers le bréchet
		end
	end
	add("Body", V(0.7, 0.8, 6.6), CFrame.new(0, 6.0, 0.9) * A(rad(-16), 0, 0), BONE)                  -- bréchet
	add("Body", V(0.3, 1.6, 4.6), CFrame.new(0, 5.2, 1.2) * A(rad(-16), 0, 0), BONE2, {Smooth = true}) -- sa quille
	for _, s in {1, -1} do bone("Body", V(s * 0.4, 7.2, 4.6), V(s * 3.0, 11.6, 3.0), 0.4) end           -- fourchette
	-- bassin
	add("Body", V(3.4, 1.0, 2.8), V(0, 7.6, -4.4), BONE)
	for _, s in {1, -1} do
		add("Body", V(0.5, 2.2, 3.0), CFrame.new(s * 1.9, 7.2, -4.4) * A(0, 0, rad(-14) * s), BONE2)
		add("Body", V(0.14, 0.9, 1.0), V(s * 2.2, 7.0, -4.4), GAP, {Smooth = true})
	end
	-- âme qui brûle dans la cage thoracique
	local soul = add("Body", V(1.5, 1.5, 1.5), CFrame.new(0, 9.4, 0.6) * A(rad(45), rad(30), 0), SOUL, {Neon = true})
	add("Body", V(0.8, 0.8, 0.8), CFrame.new(0, 9.4, 0.6) * A(rad(20), rad(60), rad(45)), rgb(220, 255, 250), {Neon = true})
	if soul then
		local light = Instance.new("PointLight")
		light.Color, light.Range, light.Brightness, light.Shadows = SOUL, 18, 2, false
		light.Parent = soul
	end
	-- pattes : fémur et tibia
	for _, s in {1, -1} do
		local side = s == 1 and "R" or "L"
		bone("Hip" .. side, V(s * 2.2, 6.6, 0), V(s * 2.3, 3.2, 0.4), 0.6)
		bone("Knee" .. side, V(s * 2.3, 3.0, 0.3), V(s * 2.3, 0.7, 0), 0.45)
	end
	-- ailes : humérus, radius et cubitus, puis les longs os des doigts qui s'ouvrent en éventail ; quelques plumes en lambeaux
	for _, s in {1, -1} do
		local wing, tip = s == 1 and "WingR" or "WingL", s == 1 and "WingTipR" or "WingTipL"
		local x = s * 5.0
		local shoulder, elbow, wrist = V(x, 11.6, 2.4), V(x, 6.6, 1.4), V(x, 5.9, -4.6)
		bone(wing, shoulder, elbow, 0.6)
		bone(wing, elbow, wrist, 0.42)
		bone(wing, elbow + V(0, 0.7, -0.2), wrist + V(0, 0.8, 0.2), 0.3)
		bone(wing, shoulder + V(0, -0.6, -0.4), V(x, 10.6, -5.0), 0.26)  -- os des plumes du bras
		bone(wing, V(x, 9.0, 1.8), V(x, 8.6, -5.2), 0.26)
		bone(tip, wrist, V(x, 10.2, -11.2), 0.34)
		bone(tip, wrist, V(x, 7.4, -11.6), 0.3)
		bone(tip, wrist, V(x, 4.6, -10.6), 0.28)
		add(tip, V(0.1, 2.2, 3.4), CFrame.new(x, 8.7, -9.4) * A(rad(-22), 0, 0), rgb(44, 38, 52), {Smooth = true, Transparency = 0.25})
		add(tip, V(0.1, 1.6, 2.8), CFrame.new(x, 6.2, -9.2) * A(rad(16), 0, 0), rgb(34, 30, 42), {Smooth = true, Transparency = 0.25})
		add(wing, V(0.1, 2.4, 3.6), CFrame.new(x, 9.6, -2.2) * A(rad(8), 0, 0), rgb(44, 38, 52), {Smooth = true, Transparency = 0.25})
	end
	-- queue : vertèbres, puis les os des plumes en éventail
	for i = 0, 4 do add("Tail1", V(0.8 - i * 0.06, 0.6, 0.8), V(0, 10.9, -4.8 - i * 0.95), i % 2 == 0 and BONE or BONE2) end
	for i = -2, 2 do bone("Tail2", V(i * 0.3, 10.9, -8.8), V(i * 0.95, 11.0 - math.abs(i) * 0.15, -12.6), 0.24) end
end

---------------------------------------------------------------- ABEILLE CITROUILLE
function SKINS.Bee(S)
	local add = S.add
	local ORANGE, DARK, GLOW = rgb(240, 112, 15), rgb(48, 30, 54), rgb(255, 214, 70)
	S.eyes({GLOW, true}, nil, rgb(255, 250, 200))
	S.recolor({
		["Tail2:220,220,230"] = rgb(255, 250, 240), ["Tail2:250,250,250"] = rgb(255, 225, 60), -- dard en bonbon
		["255,208,64"] = ORANGE, ["255,208,64N"] = {rgb(255, 150, 30), true}, ["255,240,200"] = rgb(255, 170, 80),
		["Comb:44,38,40"] = rgb(60, 130, 50), -- antennes : vrilles vertes
		["44,38,40"] = DARK, ["70,46,36"] = rgb(60, 110, 40), ["205,236,255"] = rgb(255, 200, 130),
	})
	-- queue de citrouille, feuille et vrille sur la tête
	add("Head", V(1.0, 1.4, 1.0), CFrame.new(0.2, 14.3, 2.6) * A(0, 0, rad(-12)), rgb(84, 60, 36))
	add("Head", V(1.25, 0.36, 1.25), CFrame.new(0.36, 15.05, 2.6) * A(0, 0, rad(-12)), rgb(64, 46, 28), {Smooth = true})
	add("Head", V(2.0, 0.16, 1.2), CFrame.new(1.5, 13.95, 2.6) * A(0, rad(20), rad(-16)), rgb(60, 130, 50), {Smooth = true})
	add("Head", V(0.14, 0.12, 1.2), CFrame.new(1.5, 14.06, 2.6) * A(0, rad(20), rad(-16)) * A(0, rad(90), 0), rgb(110, 180, 80), {Smooth = true})
	add("Head", V(0.22, 0.22, 1.3), CFrame.new(-1.0, 13.95, 2.2) * A(0, rad(-50), 0), rgb(60, 130, 50), {Smooth = true})
	add("Head", V(0.22, 0.9, 0.22), V(-1.55, 14.4, 1.8), rgb(60, 130, 50), {Smooth = true})
	-- sourire de lanterne taillé sous les yeux
	for i = -2, 2 do add("Head", V(0.72, 0.5, 0.14), V(i * 0.72, i % 2 == 0 and 10.05 or 9.72, 5.96), GLOW, {Neon = true}) end
	-- côtes de citrouille sur le ventre
	for _, x in {-2.2, 0, 2.2} do add("Body", V(0.3, 2.2, 0.14), V(x, 9.9, 4.26), rgb(196, 80, 8), {Smooth = true}) end
end

---------------------------------------------------------------- PHÉNIX SORCIER
function SKINS.Phoenix(S)
	local add = S.add
	local HAT, BAND, GOLD = rgb(36, 26, 52), rgb(240, 112, 15), rgb(255, 200, 60)
	S.eyes({rgb(190, 255, 120), true}, nil, rgb(240, 255, 210))
	S.recolor({
		["Neck:255,200,60"] = rgb(150, 90, 196), ["Head:255,200,60"] = rgb(150, 90, 196),
		["226,50,36"] = rgb(74, 40, 110), ["240,80,40"] = rgb(96, 54, 136), ["255,140,40"] = rgb(126, 70, 170), ["255,222,90"] = rgb(170, 110, 210),
		["255,200,60"] = rgb(70, 60, 80), ["120,60,30"] = rgb(40, 32, 48), ["226,160,30"] = rgb(60, 52, 70), ["140,20,20"] = rgb(30, 20, 44),
		-- flammes vertes et violettes de sorcière
		["255,222,90N"] = {rgb(150, 255, 70), true}, ["255,140,40N"] = {rgb(90, 230, 60), true}, ["226,50,36N"] = {rgb(170, 80, 255), true}, ["250,250,250N"] = {rgb(220, 255, 160), true},
	})
	-- chapeau de sorcière, la pointe pliée vers l'arrière
	local base = CFrame.new(0, 17.9, 5.7) * A(rad(-6), 0, rad(4))
	add("Head", V(5.8, 0.36, 5.8), base, HAT)
	add("Head", V(3.5, 0.7, 3.5), base * CFrame.new(0, 0.5, 0), BAND, {Smooth = true})
	add("Head", V(1.1, 0.8, 0.2), base * CFrame.new(0, 0.5, 1.78), GOLD, {Smooth = true})
	add("Head", V(0.5, 0.36, 0.24), base * CFrame.new(0, 0.5, 1.82), HAT, {Smooth = true})
	local cf = base * CFrame.new(0, 0.85, 0)
	for i, w in {3.2, 2.5, 1.8, 1.2, 0.7} do
		add("Head", V(w, 1.25, w), cf * CFrame.new(0, 0.6, 0), i % 2 == 1 and HAT or rgb(48, 34, 68), {Smooth = i > 1})
		cf = cf * CFrame.new(0, 1.15, 0) * A(rad(-9 - i * 3), 0, 0)
	end
	add("Head", V(0.5, 0.5, 0.14), base * CFrame.new(0.9, 1.8, 1.62) * A(0, 0, rad(45)), rgb(255, 230, 110), {Neon = true}) -- étoile
end

---------------------------------------------------------------- PÉGASE CAUCHEMAR
function SKINS.Pegasus(S)
	local add = S.add
	local FIRE, FIRE2, VIOLET = rgb(255, 110, 20), rgb(255, 170, 40), rgb(190, 70, 255)
	S.eyes({rgb(14, 10, 18), false}, {rgb(255, 80, 20), true}, rgb(255, 220, 160))
	S.recolor({
		["Head:120,190,255"] = rgb(20, 14, 26), ["Head:90,150,240"] = rgb(20, 14, 26), -- sourcils, naseaux
		["Comb:250,250,250"] = {rgb(255, 225, 110), true},
		["250,250,250"] = rgb(40, 32, 52), ["232,242,255"] = rgb(52, 42, 66), ["214,234,255"] = rgb(30, 24, 40), -- robe noire
		-- crinière, queue, bouts des ailes et fanons : des flammes
		["120,190,255"] = {FIRE, true}, ["170,220,255"] = {FIRE2, true}, ["255,180,210"] = {VIOLET, true},
		["255,205,90"] = {FIRE, true}, ["255,235,150N"] = {FIRE2, true},
	})
	-- masque d'os sur le chanfrein, dents de squelette
	add("Head", V(2.6, 0.3, 2.4), V(0, 18.52, 12.75), BONE, {Smooth = true})
	add("Head", V(1.6, 0.3, 1.4), V(0, 20.32, 11.3), BONE, {Smooth = true})
	for _, s in {1, -1} do
		for i = 0, 2 do add("Head", V(0.16, 0.6, 0.42), V(s * 1.66, 16.3, 12.1 + i * 0.62), BONE, {Smooth = true}) end
	end
	-- vertèbres sur le dos, côtes sur le poitrail
	for i = 0, 4 do add("Body", V(0.9, 0.5, 0.9), V(0, 13.95, 1.6 - i * 1.7), BONE) end
	for i = 0, 2 do add("Body", V(4.8 - i * 0.6, 0.42, 0.2), V(0, 9.3 - i * 1.3, 7.2), BONE, {Smooth = true}) end
end

---------------------------------------------------------------- DÉMON MOMIE
function SKINS.Demon(S)
	local add, ring = S.add, S.ring
	local WRAP, WRAP2, GREEN = rgb(232, 220, 188), rgb(204, 190, 156), rgb(150, 255, 70)
	S.eyes({rgb(16, 12, 18), false}, {GREEN, true}, rgb(230, 255, 190))
	S.recolor({
		["WingTip:150,20,30"] = rgb(170, 150, 112), ["WingTip:114,35,154"] = rgb(128, 112, 84), -- ailes en lambeaux de tissu
		["52,36,66"] = rgb(58, 66, 70), ["30,20,40"] = rgb(40, 46, 52), ["74,50,94"] = rgb(78, 88, 90),
		["205,210,220"] = rgb(226, 214, 180), ["60,40,30"] = WRAP2,
		["255,60,40N"] = {GREEN, true},
	})
	-- bandelettes autour du torse (la lueur verte passe entre elles)
	for i, y in {7.5, 9.5, 11.7, 13.9} do
		ring("Body", CFrame.new(0, y, 0.3) * A(0, 0, rad(i % 2 == 0 and 6 or -5)), 7.7, 6.3, 0.95, 0.16, i % 2 == 0 and WRAP2 or WRAP)
	end
	-- épaules
	for _, s in {1, -1} do
		ring("Body", CFrame.new(s * 4.3, 12.5, 1.4) * A(0, 0, rad(8) * s), 2.1, 2.1, 0.6, 0.14, WRAP)
		ring("Body", CFrame.new(s * 4.3, 13.9, 1.4) * A(0, 0, rad(-6) * s), 2.1, 2.1, 0.6, 0.14, WRAP2)
		add("Body", V(0.14, 3.2, 0.7), CFrame.new(s * 5.5, 10.9, 0.9) * A(rad(8), 0, rad(6) * s), WRAP, {Smooth = true}) -- bout qui pend
	end
	-- tête : bandeau sur le front, bande sous les yeux, bout qui pend
	ring("Head", CFrame.new(0, 18.85, 2.5) * A(0, 0, rad(4)), 5.7, 5.3, 0.85, 0.16, WRAP)
	ring("Head", CFrame.new(0, 15.95, 2.5) * A(0, 0, rad(-4)), 5.7, 5.1, 0.6, 0.14, WRAP2)
	add("Head", V(0.14, 2.8, 0.8), CFrame.new(-2.98, 14.3, 1.3) * A(rad(-8), 0, 0), WRAP, {Smooth = true})
	add("Head", V(0.9, 0.16, 5.4), CFrame.new(0.6, 19.1, 2.5) * A(0, 0, rad(4)), WRAP2, {Smooth = true})
	-- jambes
	for _, s in {1, -1} do
		local hip, knee = s == 1 and "HipR" or "HipL", s == 1 and "KneeR" or "KneeL"
		ring(hip, CFrame.new(s * 2.05, 6.6, 0) * A(0, 0, rad(6) * s), 3.0, 3.1, 0.6, 0.14, WRAP)
		ring(hip, CFrame.new(s * 2.05, 4.6, 0) * A(0, 0, rad(-7) * s), 3.0, 3.1, 0.6, 0.14, WRAP2)
		ring(knee, CFrame.new(s * 2.05, 2.9, 0) * A(0, 0, rad(8) * s), 1.6, 1.7, 0.5, 0.12, WRAP)
		ring(knee, CFrame.new(s * 2.05, 1.6, 0) * A(0, 0, rad(-6) * s), 1.6, 1.7, 0.5, 0.12, WRAP2)
	end
end

-- déguise un gardien fraîchement cloné (encore à sa position d'origine). Renvoie true si un costume existe.
function M.Apply(model, templateName)
	local skin = SKINS[templateName]
	if not skin then return false end
	skin(open(model))
	model:SetAttribute("Skin", "Halloween")
	return true
end

return M

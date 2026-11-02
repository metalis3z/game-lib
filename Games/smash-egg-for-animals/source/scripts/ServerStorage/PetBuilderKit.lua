-- Outil d'édition (pas utilisé en jeu) : construit les modèles d'animaux de ReplicatedStorage.EggSystem.Pets.
-- Construit à l'échelle 1 autour du Root (avant = +Z), puis réduit à PET_SCALE.
-- Articulations lues par PetClient : Weld avec attribut Anim (Leg, Arm, Wing, WingTip, Tail, Neck, Head, Jaw), Phase, Side, Held.
local Kit = {}
Kit.__index = Kit
local PET_SCALE = 0.35
local rad = math.rad
local INK = Color3.fromRGB(30, 22, 40)

function Kit.rgb(r, g, b) return Color3.fromRGB(r, g, b) end
function Kit.shade(c, f)
	if f >= 1 then return c:Lerp(Color3.new(1, 1, 1), f - 1) end
	return Color3.new(c.R * f, c.G * f, c.B * f)
end
local rgb, shade = Kit.rgb, Kit.shade

function Kit.new(name)
	local self = setmetatable({}, Kit)
	local model = Instance.new("Model")
	model.Name = name
	local root = Instance.new("Part")
	root.Name = "Root"
	root.Size = Vector3.new(1, 1, 1)
	root.Transparency = 1
	root.Anchored = true
	root.CanCollide, root.CanQuery, root.CanTouch = false, false, false
	root.CFrame = CFrame.new(0, 20, 0)
	root.Parent = model
	model.PrimaryPart = root
	self.Model, self.Root, self.Origin, self.Count = model, root, root.CFrame, 0
	return self
end

-- articulation : pos relatif au Root ; opts.Parent = articulation parente
function Kit:joint(kind, pos, opts)
	opts = opts or {}
	local jp = Instance.new("Part")
	jp.Name = "JointPart"
	jp.Size = Vector3.new(0.2, 0.2, 0.2)
	jp.Transparency = 1
	jp.Anchored = false
	jp.Massless = true
	jp.CanCollide, jp.CanQuery, jp.CanTouch = false, false, false
	jp.CFrame = self.Origin * CFrame.new(pos)
	jp.Parent = self.Model
	local parent = opts.Parent and opts.Parent.Part or self.Root
	local w = Instance.new("Weld")
	w.Name = kind
	w.Part0, w.Part1 = parent, jp
	w.C0 = parent.CFrame:ToObjectSpace(jp.CFrame)
	w:SetAttribute("Anim", kind)
	if opts.Phase then w:SetAttribute("Phase", opts.Phase) end
	if opts.Side then w:SetAttribute("Side", opts.Side) end
	if opts.Held then w:SetAttribute("Held", true) end
	w.Parent = jp
	return {Part = jp, Pos = pos}
end

-- pièce : cf relatif au Root ; to = articulation (ou nil = corps)
function Kit:box(to, size, cf, color, opts)
	opts = opts or {}
	if typeof(cf) == "Vector3" then cf = CFrame.new(cf) end
	local p = Instance.new(opts.Wedge and "WedgePart" or "Part")
	p.Name = "Stud"
	p.Size = size
	p.CFrame = self.Origin * cf
	p.Color = color
	p.Material = opts.Neon and Enum.Material.Neon or Enum.Material.Plastic
	p.Transparency = opts.Transparency or 0
	p.TopSurface = opts.Studs and Enum.SurfaceType.Studs or Enum.SurfaceType.Smooth
	p.BottomSurface = Enum.SurfaceType.Smooth
	p.Anchored = false
	p.Massless = true
	p.CanCollide, p.CanQuery, p.CanTouch = false, false, false
	local wc = Instance.new("WeldConstraint")
	wc.Part0 = to and to.Part or self.Root
	wc.Part1 = p
	wc.Parent = p
	p.Parent = self.Model
	self.Count += 1
	return p
end

-- bloc aux arêtes adoucies (3 pièces) : le style de base des corps et des têtes
function Kit:rbox(to, size, cf, color, bevel, opts)
	if typeof(cf) == "Vector3" then cf = CFrame.new(cf) end
	local b = bevel or 0.4
	local o = opts or {}
	self:box(to, Vector3.new(size.X, size.Y - 2 * b, size.Z - 2 * b), cf, color, o)
	self:box(to, Vector3.new(size.X - 2 * b, size.Y, size.Z - 2 * b), cf, o.Top or color, {Studs = o.Studs ~= false, Neon = o.Neon, Transparency = o.Transparency})
	self:box(to, Vector3.new(size.X - 2 * b, size.Y - 2 * b, size.Z), cf, color, o)
end

-- oeil expressif posé sur un plan (face = CFrame du centre du visage, +Z vers l'avant)
function Kit:eye(to, face, side, cfg)
	cfg = cfg or {}
	local s = cfg.Size or 1
	local c = face * CFrame.new(side * (cfg.Dx or 1.0), cfg.Dy or 0.3, 0)
	local look = -side * 0.08 * s
	local function plate(w, h, d, color, dx, dy, o) self:box(to, Vector3.new(w * s, h * s, d), c * CFrame.new((dx or 0) * s, (dy or 0) * s, d / 2 - 0.04) * CFrame.Angles(0, 0, rad(o and o.Rot or 0)), color, o) end
	plate(1.25, 1.5, 0.12, cfg.Rim or INK)
	plate(1.02, 1.28, 0.18, cfg.White or rgb(255, 255, 255))
	plate(0.74, 0.98, 0.24, cfg.Iris or rgb(70, 46, 40), look, -0.08, {Neon = cfg.Glow})
	plate(cfg.Slit and 0.26 or 0.46, 0.7, 0.3, cfg.Pupil or rgb(20, 16, 28), look, -0.1)
	plate(0.28, 0.28, 0.36, rgb(255, 255, 255), look + side * 0.2, 0.28)
	plate(0.15, 0.15, 0.36, rgb(255, 255, 255), look - side * 0.17, -0.32)
	if cfg.Lashes then
		for i = 0, 2 do plate(0.14, 0.48, 0.14, cfg.Rim or INK, side * (0.22 + i * 0.28), 0.82 - i * 0.1, {Rot = -side * (18 + i * 16)}) end
	end
	if cfg.Brow then plate(1.5, 0.36, 0.4, cfg.Brow, 0, 0.75, {Rot = side * (cfg.BrowAngle or 20)}) end
end

function Kit:blush(to, face, cfg)
	cfg = cfg or {}
	for _, s in {1, -1} do
		self:box(to, Vector3.new(0.75, 0.4, 0.1), face * CFrame.new(s * (cfg.Dx or 1.55), cfg.Dy or -0.45, 0.02), cfg.Color or rgb(255, 150, 170))
	end
end

function Kit:smile(to, face, dy, w, color)
	self:box(to, Vector3.new(w, 0.16, 0.12), face * CFrame.new(0, dy, 0.03), color or INK)
	for _, s in {1, -1} do self:box(to, Vector3.new(0.34, 0.16, 0.12), face * CFrame.new(s * (w / 2 + 0.08), dy + 0.1, 0.03) * CFrame.Angles(0, 0, rad(s * 38)), color or INK) end
end

-- chaîne de segments fixés à une même articulation ; +Y du start = sens de la pousse
function Kit:chain(to, start, steps, opts)
	local cf = start
	for _, st in steps do
		local len, thick = st[1], st[2]
		self:box(to, Vector3.new(thick, len + thick * 0.35, st.Depth or thick), cf * CFrame.new(0, len / 2, 0), st[5], opts)
		cf = cf * CFrame.new(0, len, 0) * CFrame.Angles(rad(st[3] or 0), 0, rad(st[4] or 0))
	end
	return cf
end

-- oreilles pointues sur une tête (center = centre de la tête, size = taille de la tête)
function Kit:pointEars(to, center, size, cfg)
	for _, s in {1, -1} do
		local base = CFrame.new(center + Vector3.new(s * size.X * (cfg.Spread or 0.3), size.Y / 2 - 0.15, cfg.Z or -0.2)) * CFrame.Angles(rad(cfg.Tilt or 0), 0, rad(-s * (cfg.Lean or 14)))
		local w, h = cfg.W or 1.1, cfg.H or 1.5
		self:box(to, Vector3.new(w, h * 0.6, 0.5), base * CFrame.new(0, h * 0.3, 0), cfg.Color)
		self:box(to, Vector3.new(w * 0.7, h * 0.4, 0.5), base * CFrame.new(0, h * 0.72, 0), cfg.Color)
		self:box(to, Vector3.new(w * 0.48, w * 0.48, 0.5), base * CFrame.new(0, h * 0.95, 0) * CFrame.Angles(0, 0, rad(45)), cfg.TipColor or cfg.Color)
		self:box(to, Vector3.new(w * 0.5, h * 0.5, 0.2), base * CFrame.new(0, h * 0.4, 0.2), cfg.Inner or rgb(255, 180, 190))
	end
end

-- QUADRUPÈDE : corps, 4 pattes articulées, cou optionnel, tête, queue articulée. Renvoie les repères utiles.
function Kit:quad(p)
	local W, H, L = p.W or 4.2, p.H or 3.4, p.L or 6.2
	self:rbox(nil, Vector3.new(W, H, L), Vector3.new(0, 0, 0), p.Body, 0.5, {Top = p.Back or p.Body})
	if p.Belly then self:box(nil, Vector3.new(W - 1.2, 0.3, L - 1.4), Vector3.new(0, -H / 2 + 0.05, 0), p.Belly) end
	-- pattes (diagonales en phase)
	local legLen = p.Leg or 2.4
	local lw = p.LegW or 1.25
	local hipY = -H / 2 + 0.5
	for _, sx in {1, -1} do
		for _, sz in {1, -1} do
			local hip = Vector3.new(sx * (W / 2 - lw / 2 - 0.15), hipY, sz * (L / 2 - lw / 2 - 0.3))
			local j = self:joint("Leg", hip, {Phase = (sx * sz == 1) and 0 or math.pi})
			self:box(j, Vector3.new(lw, legLen, lw), hip + Vector3.new(0, -legLen / 2, 0), p.LegColor or p.Body)
			self:box(j, Vector3.new(lw + 0.15, 0.7, lw + 0.15), hip + Vector3.new(0, -legLen - 0.2, 0.05), p.Hoof or shade(p.Body, 0.6), {Studs = false})
		end
	end
	local bottom = hipY - legLen - 0.55
	-- cou + tête
	local hs = p.Head or Vector3.new(3.8, 3.4, 3.2)
	local neck, head, hc
	if p.Neck then
		local nb = Vector3.new(0, H / 2 - 0.6, L / 2 - 0.9)
		neck = self:joint("Neck", nb)
		local nl = p.Neck
		local ncf = CFrame.new(nb) * CFrame.Angles(rad(p.NeckTilt or 28), 0, 0)
		self:rbox(neck, Vector3.new(p.NeckW or 1.9, nl + 0.8, p.NeckW or 1.9), ncf * CFrame.new(0, nl / 2, 0), p.Body, 0.3, {Studs = false})
		local top = (ncf * CFrame.new(0, nl, 0)).Position
		head = self:joint("Head", top, {Parent = neck})
		hc = top + Vector3.new(0, hs.Y / 2 - 0.9, hs.Z / 2 - 0.9)
	else
		local hb = Vector3.new(0, H / 2 - 0.9 + (p.HeadUp or 0), L / 2 - 0.3)
		head = self:joint("Head", hb)
		hc = hb + Vector3.new(0, hs.Y / 2 - 1.0, hs.Z / 2 - 0.5)
	end
	self:rbox(head, hs, hc, p.HeadColor or p.Body, 0.45, {Top = p.HeadTop or p.HeadColor or p.Body})
	local face = CFrame.new(hc + Vector3.new(0, 0, hs.Z / 2))
	-- queue
	local tails = {}
	local parent
	local tp = Vector3.new(0, (p.TailY or 0.6), -L / 2 + 0.1)
	for i = 1, p.TailJoints or 1 do
		local j = self:joint("Tail", tp, {Parent = parent, Phase = (i - 1) * 0.8})
		table.insert(tails, {Joint = j, Pos = tp})
		parent = j
		tp = tp + Vector3.new(0, p.TailRise or 0.25, -(p.TailStep or 1.1))
	end
	return {Head = head, HeadCenter = hc, HeadSize = hs, Face = face, Neck = neck, Tails = tails, Bottom = bottom, W = W, H = H, L = L}
end

-- AILE HORIZONTALE de chauve-souris : os au bord avant, membrane vers l'arrière ; inner = Wing, outer = WingTip
function Kit:batWing(side, base, cfg)
	local wing = self:joint("Wing", base, {Side = side})
	local L1, L2 = cfg.L1 or 3.2, cfg.L2 or 3.6
	local tipPos = base + Vector3.new(side * L1, 0, 0)
	local tip = self:joint("WingTip", tipPos, {Parent = wing, Side = side})
	local chord = cfg.Chord or 3.4
	local function seg(to, x0, x1, c0, c1, color)
		local n = math.max(1, math.floor((x1 - x0) / 0.8 + 0.5))
		for i = 1, n do
			local f = (i - 0.5) / n
			local x = x0 + (x1 - x0) * f
			local c = (c0 + (c1 - c0) * f) * (0.82 + 0.18 * math.abs(math.sin(f * math.pi * (cfg.Scallops or 1))))
			self:box(to, Vector3.new((x1 - x0) / n + 0.03, 0.22, c), base + Vector3.new(side * x, 0, -c / 2 + 0.2), i % 2 == 0 and color or shade(color, 1.14))
		end
	end
	seg(wing, 0.3, L1, chord * 0.75, chord, cfg.Dark)
	seg(tip, L1, L1 + L2, chord, chord * 0.35, cfg.Light)
	self:box(wing, Vector3.new(L1 + 0.3, 0.55, 0.6), base + Vector3.new(side * L1 / 2, 0.05, 0.25), cfg.Bone)
	self:box(tip, Vector3.new(L2 + 0.3, 0.45, 0.5), base + Vector3.new(side * (L1 + L2 / 2), 0.05, 0.25), cfg.Bone)
	for i, f in {0.15, 0.6} do -- doigts vers l'arrière
		self:box(tip, Vector3.new(0.3, 0.34, chord * (0.95 - i * 0.2)), CFrame.new(base + Vector3.new(side * (L1 + L2 * f), 0.05, -chord * 0.4 + 0.3)) * CFrame.Angles(0, rad(side * 14), 0), cfg.Bone)
	end
	self:box(wing, Vector3.new(0.3, 0.34, chord * 0.9), base + Vector3.new(side * L1 * 0.5, 0.05, -chord * 0.4 + 0.3), cfg.Bone)
	self:box(tip, Vector3.new(0.5, 0.4, 0.9), base + Vector3.new(side * (L1 + L2 + 0.2), 0.05, 0.55), cfg.Claw)
	self:box(wing, Vector3.new(0.45, 0.4, 0.8), base + Vector3.new(side * L1, 0.1, 0.8), cfg.Claw)
	return wing, tip
end

-- AILE À PLUMES horizontale : plumes vers l'extérieur et l'arrière ; inner = Wing, outer = WingTip (optionnel)
function Kit:featherWing(side, base, cfg)
	local wing = self:joint("Wing", base, {Side = side})
	local L1, L2 = cfg.L1 or 2.6, cfg.L2 or 2.8
	local tip = cfg.Tip ~= false and self:joint("WingTip", base + Vector3.new(side * L1, 0, 0), {Parent = wing, Side = side}) or wing
	local function feathers(to, x0, x1, len0, len1, colors, y)
		local n = math.max(2, math.floor((x1 - x0) / 0.75 + 0.5))
		for i = 1, n do
			local f = (i - 0.5) / n
			local x = x0 + (x1 - x0) * f
			local len = len0 + (len1 - len0) * f
			local cf = CFrame.new(base + Vector3.new(side * x, y, 0.2)) * CFrame.Angles(0, rad(side * (8 + f * 26)), 0)
			self:box(to, Vector3.new(0.8, 0.22, len), cf * CFrame.new(0, 0, -len / 2), colors[(i % #colors) + 1])
			self:box(to, Vector3.new(0.58, 0.22, 0.58), cf * CFrame.new(0, 0, -len) * CFrame.Angles(0, rad(45), 0), cfg.TipColor or colors[1])
		end
	end
	feathers(wing, 0.2, L1, cfg.Len or 2.6, (cfg.Len or 2.6) * 1.25, {cfg.Main, cfg.Alt}, 0)
	feathers(wing, 0.2, L1, (cfg.Len or 2.6) * 0.5, (cfg.Len or 2.6) * 0.6, {cfg.Cover or cfg.Main, cfg.Cover or cfg.Main}, 0.2)
	if tip ~= wing then
		feathers(tip, L1, L1 + L2, (cfg.Len or 2.6) * 1.25, (cfg.Len or 2.6) * 0.7, {cfg.Alt, cfg.Main}, 0)
		feathers(tip, L1, L1 + L2, (cfg.Len or 2.6) * 0.6, (cfg.Len or 2.6) * 0.35, {cfg.Cover or cfg.Main, cfg.Cover or cfg.Main}, 0.2)
		self:box(tip, Vector3.new(L2, 0.5, 0.7), base + Vector3.new(side * (L1 + L2 / 2), 0.25, 0.2), cfg.Cover or cfg.Main)
	end
	self:box(wing, Vector3.new(L1 + 0.3, 0.6, 0.8), base + Vector3.new(side * L1 / 2, 0.25, 0.2), cfg.Cover or cfg.Main)
	return wing, tip
end

-- termine : hauteur au sol, mise à l'échelle, remplacement du modèle existant
function Kit:finish(folder, groundOverride)
	local bottom = math.huge
	for _, d in self.Model:GetChildren() do
		if d:IsA("BasePart") and d.Transparency < 1 then
			local cf, s = d.CFrame, d.Size
			local ext = math.abs(cf.UpVector.Y) * s.Y / 2 + math.abs(cf.RightVector.Y) * s.X / 2 + math.abs(cf.LookVector.Y) * s.Z / 2
			bottom = math.min(bottom, d.Position.Y - ext)
		end
	end
	local ground = groundOverride or (self.Root.Position.Y - bottom)
	self.Model:ScaleTo(PET_SCALE)
	self.Model:SetAttribute("GroundOffset", math.floor(ground * PET_SCALE * 100 + 0.5) / 100)
	local old = folder:FindFirstChild(self.Model.Name)
	if old then old:Destroy() end
	self.Model.Parent = folder
	return self.Count
end

return Kit

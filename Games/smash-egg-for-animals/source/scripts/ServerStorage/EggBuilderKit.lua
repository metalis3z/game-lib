-- Outil d'édition (pas utilisé en jeu) : construit les modèles d'oeufs de ReplicatedStorage.EggSystem.EggModels.
-- Tout est construit à l'échelle 1 autour du Root (avant = +Z, bas de l'oeuf à -6.5), puis remis à l'échelle du modèle.
local Kit = {}
Kit.__index = Kit

local RMAX, Y0, HTOP, HBOT = 5.2, -1.5, 8.3, 5.2

function Kit.R(y)
	local h = y > Y0 and HTOP or HBOT
	return RMAX * math.sqrt(math.max(0.03, 1 - ((y - Y0) / h) ^ 2))
end

local function slope(y) -- inclinaison de la surface (0 au plus large, >0 vers le haut)
	return math.atan((Kit.R(y - 0.25) - Kit.R(y + 0.25)) / 0.5)
end

function Kit.rgb(r, g, b) return Color3.fromRGB(r, g, b) end
function Kit.shade(c, f)
	if f >= 1 then return c:Lerp(Color3.new(1, 1, 1), f - 1) end
	return Color3.new(c.R * f, c.G * f, c.B * f)
end

-- ouvre le modèle : garde Root (et les Fx), enlève tout le reste
function Kit.open(model)
	local self = setmetatable({}, Kit)
	self.Model = model
	self.Scale = model:GetScale()
	model:ScaleTo(1)
	self.Origin = CFrame.new(model.PrimaryPart.Position)
	for _, d in model:GetChildren() do
		if d:IsA("BasePart") and d ~= model.PrimaryPart and d.Name ~= "Fx" then d:Destroy() end
	end
	self.Count = 0
	return self
end

function Kit:close()
	self.Model:ScaleTo(self.Scale)
	return self.Count
end

-- pièce brute, cf relatif au centre de l'oeuf
function Kit:part(name, size, cf, color, opts)
	opts = opts or {}
	local p = Instance.new(opts.Wedge and "WedgePart" or "Part")
	p.Name = name
	p.Anchored = true
	p.Size = size
	p.CFrame = self.Origin * cf
	p.Color = color
	p.Material = opts.Neon and Enum.Material.Neon or Enum.Material.Plastic
	p.Transparency = opts.Transparency or 0
	p.TopSurface = opts.Studs and Enum.SurfaceType.Studs or Enum.SurfaceType.Smooth
	p.BottomSurface = Enum.SurfaceType.Smooth
	p.Parent = self.Model
	self.Count += 1
	return p
end

-- coquille : 13 étages à 16 côtés ; colorAt(i, y) donne la couleur de l'étage
function Kit:shell(colorAt)
	for i = 1, 13 do
		local y = -7 + i
		local a = Kit.R(y)
		local color = colorAt(i, y)
		for k = 0, 7 do
			self:part("Stud", Vector3.new(2 * a, 1, 2 * a * math.tan(math.pi / 16)), CFrame.new(0, y, 0) * CFrame.Angles(0, k * math.pi / 8, 0), color, {Studs = true})
		end
	end
	local a = Kit.R(6) * 0.62
	self:part("Stud", Vector3.new(2 * a, 0.5, 2 * a), CFrame.new(0, 6.7, 0), colorAt(14, 6.7), {Studs = true})
	self:part("Stud", Vector3.new(2 * a, 0.5, 2 * a), CFrame.new(0, 6.7, 0) * CFrame.Angles(0, math.pi / 4, 0), colorAt(14, 6.7), {Studs = true})
end

-- repère posé sur la coquille : +Z sort de l'oeuf, +Y monte le long de la surface, +X tangent
function Kit:surface(yaw, y, out)
	return CFrame.Angles(0, math.rad(yaw), 0) * CFrame.new(0, y, Kit.R(y) + (out or 0)) * CFrame.Angles(-slope(y), 0, 0)
end

-- plaque collée sur la coquille
function Kit:plate(name, yaw, y, w, h, d, color, opts)
	opts = opts or {}
	local cf = self:surface(yaw, y, d / 2 - 0.06 + (opts.Out or 0)) * CFrame.new(opts.Dx or 0, opts.Dy or 0, 0) * CFrame.Angles(0, 0, math.rad(opts.Rot or 0))
	return self:part(name, Vector3.new(w, h, d), cf, color, opts)
end

-- oeil expressif : blanc, iris, pupille, deux reflets (+ cils / sourcil en option)
function Kit:eye(side, cfg)
	cfg = cfg or {}
	local yaw, y = side * (cfg.Yaw or 24), cfg.Y or 1.3
	local s = cfg.Size or 1
	local look = side * -(cfg.Cross or 0.12) * s
	self:plate("Relief", yaw, y, 1.9 * s, 2.3 * s, 0.25, cfg.Rim or Kit.rgb(30, 22, 40))
	self:plate("Relief", yaw, y, 1.6 * s, 2.0 * s, 0.34, cfg.White or Kit.rgb(255, 255, 255))
	self:plate("Relief", yaw, y, 1.15 * s, 1.5 * s, 0.42, cfg.Iris or Kit.rgb(70, 140, 235), {Dx = look, Dy = -0.12 * s, Neon = cfg.Glow})
	self:plate("Relief", yaw, y, (cfg.Slit and 0.38 or 0.72) * s, 1.05 * s, 0.5, cfg.Pupil or Kit.rgb(20, 16, 28), {Dx = look, Dy = -0.14 * s})
	self:plate("Relief", yaw, y, 0.42 * s, 0.42 * s, 0.58, Kit.rgb(255, 255, 255), {Dx = look + side * 0.3 * s, Dy = 0.42 * s})
	self:plate("Relief", yaw, y, 0.22 * s, 0.22 * s, 0.58, Kit.rgb(255, 255, 255), {Dx = look - side * 0.25 * s, Dy = -0.5 * s})
	if cfg.Lashes then
		for i = 0, 2 do
			self:plate("Relief", yaw, y, 0.22 * s, 0.75 * s, 0.3, cfg.Rim or Kit.rgb(30, 22, 40), {Dx = side * (0.35 + i * 0.42) * s, Dy = (1.25 - i * 0.14) * s, Rot = -side * (18 + i * 16)})
		end
	end
	if cfg.Brow then -- sourcil incliné vers le centre = regard féroce
		self:plate("Relief", yaw, y, 2.3 * s, 0.55 * s, 0.62, cfg.Brow, {Dy = 1.15 * s, Rot = side * (cfg.BrowAngle or 20)})
	end
end

function Kit:blush(cfg)
	cfg = cfg or {}
	for _, side in {1, -1} do
		self:plate("Relief", side * (cfg.Yaw or 44), cfg.Y or -0.2, 1.3, 0.65, 0.2, cfg.Color or Kit.rgb(255, 150, 170))
	end
end

-- chaîne de segments (corne, queue, antenne, bois...) : start = CFrame de départ, +Y = sens de la pousse
-- steps = { {Len, Thick, BendX, BendZ, Color}, ... } ; renvoie le CFrame du bout
function Kit:chain(name, start, steps, opts)
	local cf = start
	for _, st in steps do
		local len, thick = st[1], st[2]
		self:part(name, Vector3.new(thick, len + thick * 0.35, st.Depth or thick), cf * CFrame.new(0, len / 2, 0), st[5], opts)
		cf = cf * CFrame.new(0, len, 0) * CFrame.Angles(math.rad(st[3] or 0), 0, math.rad(st[4] or 0))
	end
	return cf
end

-- nid : deux couronnes de 12 blocs + fond
function Kit:nest(c1, c2, opts)
	opts = opts or {}
	local rng = Random.new(opts.Seed or 1)
	local base = Kit.R(-6)
	local outer = base + (opts.Extra or 3.1)
	for ring, cfg in {{R = outer, Y = -6.0, W = 2.5, H = 1.0}, {R = outer - 1.2, Y = -5.1, W = 2.1, H = 1.0}} do
		for k = 0, 11 do
			local ang = k * math.pi / 6 + ring * 0.26
			local len = 2 * cfg.R * math.tan(math.pi / 12) + 0.4
			self:part("Nest", Vector3.new(cfg.W, cfg.H, len), CFrame.Angles(0, ang, 0) * CFrame.new(cfg.R, cfg.Y, 0) * CFrame.Angles(0, 0, rng:NextNumber(-0.07, 0.07)), (k + ring) % 2 == 0 and c1 or c2, {Studs = true})
		end
	end
	self:part("Nest", Vector3.new(outer * 1.5, 0.6, outer * 1.5), CFrame.new(0, -6.2, 0), c2)
	self:part("Nest", Vector3.new(outer * 1.5, 0.6, outer * 1.5), CFrame.new(0, -6.2, 0) * CFrame.Angles(0, math.pi / 4, 0), c2)
	return outer
end

-- brins qui dépassent du nid
function Kit:straws(color, count, outer, len, seed)
	local rng = Random.new(seed or 5)
	for k = 0, count - 1 do
		local ang = k * 2 * math.pi / count + 0.3
		self:part("Nest", Vector3.new(0.35, 0.35, len or 2.4), CFrame.Angles(0, ang, 0) * CFrame.new(outer + 0.2, -4.5, 0) * CFrame.Angles(rng:NextNumber(-0.5, 0.5), rng:NextNumber(-0.6, 0.6), 0), color)
	end
end

-- aile de chauve-souris (dragon, démon)
function Kit:batWing(side, cfg)
	local sweep = math.rad(cfg.Sweep or 22)
	local k = cfg.Size or 1
	local plane = CFrame.new(side * 3.6, cfg.Y or 1.6, -1.2) * CFrame.Angles(0, side == 1 and sweep or math.pi - sweep, 0)
	local function bone(p, q, thick, depth, color)
		local d = q - p
		self:part("Decor", Vector3.new(d.Magnitude + thick * 0.6, thick, depth), plane * CFrame.new((p.X + q.X) / 2, (p.Y + q.Y) / 2, 0) * CFrame.Angles(0, 0, math.atan2(d.Y, d.X)), color)
	end
	local shoulder, elbow, wrist = Vector2.new(0, 0), Vector2.new(4.6, 4.4) * k, Vector2.new(8.6, 5.9) * k
	local tips = {Vector2.new(11.4, 1.2) * k, Vector2.new(8.4, -1.0) * k, Vector2.new(5.2, -1.8) * k}
	local function top(u)
		if u <= elbow.X then return u / elbow.X * elbow.Y end
		if u <= wrist.X then return elbow.Y + (u - elbow.X) / (wrist.X - elbow.X) * (wrist.Y - elbow.Y) end
		return wrist.Y + (u - wrist.X) / (tips[1].X - wrist.X) * (tips[1].Y - wrist.Y)
	end
	local anchors = {Vector2.new(0.4, -2.2 * k), tips[3], tips[2], tips[1]}
	local function bottom(u)
		for i = 1, #anchors - 1 do
			local a, b = anchors[i], anchors[i + 1]
			if u <= b.X or i == #anchors - 1 then
				local t = math.clamp((u - a.X) / (b.X - a.X), 0, 1)
				return a.Y + (b.Y - a.Y) * t + math.sin(t * math.pi) * 1.25 * k
			end
		end
	end
	local u, w = 0.8, 0.8
	while u < tips[1].X - 0.3 do
		local t, b = top(u) - 0.1, bottom(u)
		if t - b > 0.35 then
			local f = u / tips[1].X
			self:part("Decor", Vector3.new(w + 0.02, t - b, 0.3), plane * CFrame.new(u, (t + b) / 2, 0), cfg.Dark:Lerp(cfg.Light, f * 0.8 + (math.floor(u / w) % 2) * 0.12))
		end
		u += w
	end
	bone(shoulder, elbow, 1.0, 0.8, cfg.Bone)
	bone(elbow, wrist, 0.85, 0.7, cfg.Bone)
	for i, tip in tips do bone(wrist:Lerp(elbow, (i - 1) * 0.28), tip, 0.5, 0.5, Kit.shade(cfg.Bone, 1.08)) end
	self:part("Decor", Vector3.new(1.3, 1.3, 1.0), plane * CFrame.new(elbow.X, elbow.Y, 0) * CFrame.Angles(0, 0, math.rad(45)), cfg.Bone)
	self:part("Decor", Vector3.new(1.1, 1.1, 0.9), plane * CFrame.new(wrist.X, wrist.Y, 0) * CFrame.Angles(0, 0, math.rad(45)), cfg.Bone)
	self:part("Decor", Vector3.new(0.5, 1.5, 0.5), plane * CFrame.new(elbow.X - 0.2, elbow.Y + 1.2, 0) * CFrame.Angles(0, 0, math.rad(12)), cfg.Claw)
	self:part("Decor", Vector3.new(0.5, 1.4, 0.5), plane * CFrame.new(wrist.X + 0.3, wrist.Y + 1.1, 0) * CFrame.Angles(0, 0, math.rad(-18)), cfg.Claw)
	for _, tip in tips do
		self:part("Decor", Vector3.new(0.45, 0.9, 0.45), plane * CFrame.new(tip.X + 0.1, tip.Y - 0.45, 0) * CFrame.Angles(0, 0, math.rad(-10)), cfg.Claw)
	end
	self:part("Decor", Vector3.new(1.6, 1.6, 1.4), plane * CFrame.new(0.4, 0.3, 0), cfg.Bone)
end

-- aile à plumes (poule, licorne) : plumes en éventail sur deux rangs
function Kit:featherWing(side, cfg)
	local sweep = math.rad(cfg.Sweep or 18)
	local k = cfg.Size or 1
	local plane = CFrame.new(side * (cfg.X or 3.9), cfg.Y or 0.8, cfg.Z or -0.8) * CFrame.Angles(0, side == 1 and sweep or math.pi - sweep, 0)
	local n = cfg.Count or 7
	for i = 0, n - 1 do
		local f = i / (n - 1)
		local ang = math.rad((cfg.From or 62) - f * (cfg.Span or 96))
		local len = (3.2 + math.sin(f * math.pi * 0.85 + 0.35) * 4.2) * k
		local base = plane * CFrame.Angles(0, 0, ang)
		self:part("Decor", Vector3.new(len, 1.15 * k, 0.32), base * CFrame.new(len / 2 + 0.6, 0, 0), i % 2 == 0 and cfg.Main or cfg.Alt)
		self:part("Decor", Vector3.new(0.9 * k, 0.8 * k, 0.32), base * CFrame.new(len + 0.9, 0, 0) * CFrame.Angles(0, 0, math.rad(45)), cfg.Tip or cfg.Alt)
		self:part("Decor", Vector3.new(len * 0.5, 0.95 * k, 0.5), base * CFrame.new(len * 0.25 + 0.5, 0, 0), cfg.Cover or cfg.Main)
	end
	self:part("Decor", Vector3.new(2.2 * k, 2.2 * k, 0.9), plane * CFrame.new(0.5, 0, 0) * CFrame.Angles(0, 0, math.rad(45)), cfg.Cover or cfg.Main)
end

return Kit

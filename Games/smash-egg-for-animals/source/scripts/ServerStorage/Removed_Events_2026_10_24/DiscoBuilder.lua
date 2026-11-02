-- DiscoBuilder : construit les modèles du DISCO EVENT dans ReplicatedStorage.DiscoEvent (RIEN n'est posé dans workspace).
-- DiscoEventClient les clone chez chaque joueur pendant l'event et les enlève à la fin : la carte n'est jamais modifiée.
-- Toutes les dimensions viennent de la carte (étendue réelle de ses pièces, zones d'œufs, fin de la Galaxy Zone) : la boîte de
-- nuit entoure la carte avec de la marge, sans rien traverser. Aucune pièce ne bloque : CanCollide / CanQuery / CanTouch = false.
-- Reconstruire (barre de commande, en Edit) : require(game.ServerStorage.DiscoBuilder).build()
local M = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local rgb = Color3.fromRGB

local TEX = {
	Tile = "rbxassetid://78961726782405",   -- carreau LED (dessiné pour le Disco Event)
	Glint = "rbxassetid://113227300445053", -- reflet de miroir (dessiné pour le Disco Event)
	Sheet = "rbxassetid://83726142184589",  -- mini boule à facettes, 4 x 4 images (dessinée pour le Disco Event)
	Glow = "rbxassetid://4509687978",       -- halo (bibliothèque VFX du jeu)
	Star = "rbxassetid://1084970835",       -- étoile (bibliothèque VFX du jeu)
	Stars = "rbxassetid://123320605329253", -- petites lumières LED éparses (dessinées pour le Disco Event)
}
local MAGENTA, CYAN, VIOLET, PINK, BLUE, AQUA = rgb(255, 70, 215), rgb(70, 220, 255), rgb(150, 90, 255), rgb(255, 130, 235), rgb(80, 130, 255), rgb(60, 255, 225)
local PALETTE = {MAGENTA, CYAN, VIOLET, PINK, BLUE, AQUA}
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local NEON = Enum.Material.Neon
local METAL = Enum.Material.Metal

local function part(parent, props)
	local p = Instance.new(props.Class or "Part")
	props.Class = nil
	p.Anchored = true
	p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = false, false, false, false
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	p.Material = Enum.Material.SmoothPlastic
	if props.Shape then p.Shape = props.Shape props.Shape = nil end
	for k, v in props do p[k] = v end
	p.Parent = parent
	return p
end
local function group(parent, name, class)
	local f = Instance.new(class or "Model")
	f.Name = name
	f.Parent = parent
	return f
end
local function weld(a, b)
	local w = Instance.new("Weld")
	w.Part0, w.Part1 = a, b
	w.C0 = a.CFrame:ToObjectSpace(b.CFrame)
	w.Parent = b
	b.Anchored = false
	b.Massless = true
end
local function texture(p, face, image, studs, color, transparency, name)
	local t = Instance.new("Texture")
	t.Name = name or "Texture"
	t.Texture = image
	t.Face = face
	t.StudsPerTileU, t.StudsPerTileV = studs, studs
	t.Color3 = color
	t.Transparency = transparency
	t.Parent = p
	return t
end
local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function stroke(o, thickness)
	return new("UIStroke", {Thickness = thickness, Color = Color3.new(0, 0, 0), ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual}, o)
end
local function beam(name, a0, a1, color, w0, w1, t0, t1, parent)
	return new("Beam", {Name = name, Attachment0 = a0, Attachment1 = a1, Texture = TEX.Glow, TextureMode = Enum.TextureMode.Stretch, TextureSpeed = 0,
		Width0 = w0, Width1 = w1, FaceCamera = true, LightEmission = 1, LightInfluence = 0, Segments = 1,
		Color = ColorSequence.new(Color3.new(1, 1, 1), color),
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, t0), NumberSequenceKeypoint.new(0.6, (t0 + t1) / 2 + 0.08), NumberSequenceKeypoint.new(1, t1)})}, parent)
end

---------------------------------------------------------------- mesure de la carte
local SKIP = {BossArena = true, DestroyedCity = true, SkyEventFx = true, DiscoEventFx = true, GalaxyClientFx = true}
function M.measure()
	local inf = math.huge
	local lo, hi = Vector3.new(inf, inf, inf), Vector3.new(-inf, -inf, -inf)
	local visLoY, visHiY, visLoX, visHiX = inf, -inf, inf, -inf
	for _, top in workspace:GetChildren() do
		if not SKIP[top.Name] and not top:IsA("Camera") and not top:IsA("Terrain") then
			local list = top:IsA("BasePart") and {top} or top:GetDescendants()
			for _, p in list do
				if p:IsA("BasePart") and math.abs(p.Position.X) < 7000 and p.Position.Y > -320 and p.Position.Y < 700 and math.abs(p.Position.Z) < 3000 then
					local cf, h = p.CFrame, p.Size / 2
					local r, u, l = cf.RightVector, cf.UpVector, cf.LookVector
					local ext = Vector3.new(math.abs(r.X) * h.X + math.abs(u.X) * h.Y + math.abs(l.X) * h.Z,
						math.abs(r.Y) * h.X + math.abs(u.Y) * h.Y + math.abs(l.Y) * h.Z,
						math.abs(r.Z) * h.X + math.abs(u.Z) * h.Y + math.abs(l.Z) * h.Z)
					lo, hi = lo:Min(p.Position - ext), hi:Max(p.Position + ext)
					if p.Transparency < 0.95 then
						visLoY = math.min(visLoY, p.Position.Y - ext.Y)
						visHiY = math.max(visHiY, p.Position.Y + ext.Y)
						visLoX = math.min(visLoX, p.Position.X - ext.X)
						visHiX = math.max(visHiX, p.Position.X + ext.X)
					end
				end
			end
		end
	end
	local zones = {}
	for _, c in workspace:GetChildren() do
		if c:IsA("BasePart") and string.find(string.lower(c.Name), "egg zone", 1, true) then table.insert(zones, c) end
	end
	table.sort(zones, function(a, b) return a.Position.X < b.Position.X end)
	local galaxy = workspace:FindFirstChild("GALACTIC galaxy egg zone") or zones[#zones]
	local corridorCeiling = workspace:FindFirstChild("Corridor") and workspace.Corridor:FindFirstChild("Ceiling")
	local safe = workspace:FindFirstChild("safe zone")
	return {
		Lo = lo, Hi = hi, VisLoY = visLoY, VisHiY = visHiY, VisLoX = visLoX, VisHiX = visHiX,
		ZoneZ = zones[1].Position.Z, ZoneTop = zones[1].Position.Y + zones[1].Size.Y / 2,
		GalaxyEnd = galaxy.Position.X + galaxy.Size.X / 2,
		SpawnX = safe and safe:IsA("BasePart") and safe.Position.X or zones[1].Position.X - 150,
		PlayerTop = corridorCeiling and corridorCeiling.Position.Y - corridorCeiling.Size.Y / 2 or 60, -- (plafond invisible du couloir)
	}
end

---------------------------------------------------------------- écran LED (SurfaceGui animée par DiscoEventClient)
local function screen(parent, name, cf, w, h, face, title, sub, bars)
	local p = part(parent, {Name = name, Size = Vector3.new(w, h, 2), CFrame = cf, Color = rgb(6, 5, 14)})
	local gui = new("SurfaceGui", {Name = "Screen", Face = face, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, PixelsPerStud = 3,
		LightInfluence = 0, Brightness = 1.5, MaxDistance = 3000, ClipsDescendants = true}, p)
	gui:SetAttribute("DiscoScreen", true)
	local bg = new("Frame", {Name = "Background", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0}, gui)
	new("UIGradient", {Name = "Flow", Rotation = 25, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(40, 10, 90)), ColorSequenceKeypoint.new(0.35, rgb(170, 30, 160)),
		ColorSequenceKeypoint.new(0.7, rgb(40, 60, 200)), ColorSequenceKeypoint.new(1, rgb(20, 150, 200))})}, bg)
	new("Frame", {Name = "Shade", Size = UDim2.fromScale(1, 1), BackgroundColor3 = rgb(8, 4, 24), BackgroundTransparency = 0.35, BorderSizePixel = 0}, bg)
	new("UIStroke", {Thickness = 10, Color = MAGENTA, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, bg)
	local t = new("TextLabel", {Name = "Title", BackgroundTransparency = 1, Position = UDim2.fromScale(0.18, 0.06), Size = UDim2.fromScale(0.64, 0.36),
		FontFace = FONT, Text = title, TextScaled = true, TextColor3 = Color3.new(1, 1, 1)}, bg)
	stroke(t, 6)
	new("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 255, 255)), ColorSequenceKeypoint.new(0.5, rgb(255, 170, 245)), ColorSequenceKeypoint.new(1, rgb(150, 235, 255))}), Rotation = 90}, t)
	if sub then
		local s = new("TextLabel", {Name = "Sub", BackgroundTransparency = 1, Position = UDim2.fromScale(0.2, 0.42), Size = UDim2.fromScale(0.6, 0.13),
			FontFace = FONT, Text = sub, TextScaled = true, TextColor3 = rgb(140, 240, 255)}, bg)
		stroke(s, 4)
	end
	for i, x in {0.03, 0.83} do
		new("ImageLabel", {Name = "DiscoSprite", BackgroundTransparency = 1, Position = UDim2.fromScale(x, 0.05), Size = UDim2.fromScale(0.14, 0.14 * w / h),
			Image = TEX.Sheet, ImageRectSize = Vector2.new(128, 128), ImageRectOffset = Vector2.new((i - 1) * 256, 0)}, bg)
	end
	local eq = new("Frame", {Name = "Eq", BackgroundTransparency = 1, Position = UDim2.fromScale(0.05, 0.6), Size = UDim2.fromScale(0.9, 0.36)}, bg)
	for i = 1, bars do
		local bar = new("Frame", {Name = "Bar", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new((i - 1) / bars, 2, 1, 0), Size = UDim2.new(1 / bars, -4, 0.3, 0),
			BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, LayoutOrder = i}, eq)
		new("UIGradient", {Rotation = -90, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, CYAN), ColorSequenceKeypoint.new(0.6, VIOLET), ColorSequenceKeypoint.new(1, MAGENTA)})}, bar)
		new("UICorner", {CornerRadius = UDim.new(0, 4)}, bar)
	end
	return p
end

---------------------------------------------------------------- boule à facettes
local TILE_COLORS = {{rgb(206, 208, 222), 58}, {rgb(246, 246, 255), 12}, {rgb(196, 168, 255), 10}, {rgb(160, 232, 255), 8}, {rgb(255, 178, 238), 8}, {rgb(140, 160, 255), 4}}
local function discoBall(parent, name, center, R, tile, rays, ceilY, groundY)
	local m = group(parent, name)
	local root = part(m, {Name = "Root", Size = Vector3.one, CFrame = CFrame.new(center), Transparency = 1})
	m.PrimaryPart = root
	local core = part(m, {Name = "Core", Shape = Enum.PartType.Ball, Size = Vector3.one * (2 * R - 0.8), CFrame = CFrame.new(center), Color = rgb(30, 28, 44)})
	weld(root, core)
	local tiles = group(m, "Tiles")
	local rng = Random.new(5)
	local function pick()
		local r = rng:NextNumber(0, 100)
		for _, c in TILE_COLORS do r -= c[2] if r <= 0 then return c[1] end end
		return TILE_COLORS[1][1]
	end
	local rings = math.floor(math.pi * R / tile)
	local count = 0
	for i = 0, rings - 1 do
		local lat = -math.pi / 2 + (i + 0.5) * math.pi / rings
		local circ = 2 * math.pi * R * math.cos(lat)
		local n = math.max(5, math.floor(circ / tile + 0.5))
		local w, h = circ / n * 0.86, math.pi * R / rings * 0.86
		local offset = rng:NextNumber(0, 2 * math.pi)
		for j = 0, n - 1 do
			local lon = offset + j * 2 * math.pi / n
			local nrm = Vector3.new(math.cos(lat) * math.cos(lon), math.sin(lat), math.cos(lat) * math.sin(lon))
			local up = Vector3.new(-math.sin(lat) * math.cos(lon), math.cos(lat), -math.sin(lat) * math.sin(lon))
			local pos = center + nrm * (R - 0.15)
			local t = part(tiles, {Name = "Tile", Size = Vector3.new(w, h, 0.5), CFrame = CFrame.lookAt(pos, pos + nrm, up), Color = pick(), Reflectance = 0.32})
			weld(root, t)
			count += 1
		end
	end
	-- cap + anneau en haut (comme une vraie boule à facettes)
	local cap = part(m, {Name = "Cap", Shape = Enum.PartType.Cylinder, Size = Vector3.new(R * 0.12, R * 0.22, R * 0.22), CFrame = CFrame.new(center + Vector3.new(0, R + R * 0.04, 0)) * CFrame.Angles(0, 0, math.pi / 2),
		Color = rgb(170, 172, 190), Material = METAL})
	weld(root, cap)
	-- lumière centrale, halo, éclats qui glissent sur la surface
	new("PointLight", {Name = "CoreLight", Range = math.min(60, R * 1.5), Brightness = 2, Color = rgb(225, 195, 255), Shadows = false}, core)
	new("ParticleEmitter", {Name = "Halo", Texture = TEX.Glow, LockedToPart = true, Rate = 1.2, Lifetime = NumberRange.new(2.2), Speed = NumberRange.new(0),
		Size = NumberSequence.new(R * 3.4), LightEmission = 1, LightInfluence = 0,
		Color = ColorSequence.new(rgb(190, 120, 255), rgb(255, 120, 230)),
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.82), NumberSequenceKeypoint.new(1, 1)})}, core)
	new("ParticleEmitter", {Name = "Glints", Texture = TEX.Glint, Shape = Enum.ParticleEmitterShape.Sphere, ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface,
		Rate = math.floor(R * 0.9), Lifetime = NumberRange.new(0.2, 0.45), Speed = NumberRange.new(0), LightEmission = 1, LightInfluence = 0,
		RotSpeed = NumberRange.new(-90, 90), Rotation = NumberRange.new(0, 360),
		Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 255, 255)), ColorSequenceKeypoint.new(0.5, rgb(170, 240, 255)), ColorSequenceKeypoint.new(1, rgb(255, 170, 240))}),
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.35, R * 0.12), NumberSequenceKeypoint.new(1, 0)})}, core)
	-- faisceaux colorés : attachés au Root, ils tournent avec la boule (vers le sol, un sur quatre vers le plafond)
	for k = 1, rays do
		local az = (k - 1) / rays * math.pi * 2 + 0.3
		local upward = k % 4 == 0
		local el = upward and math.rad(30) or -math.rad(18 + (k % 3) * 13)
		local dir = Vector3.new(math.cos(el) * math.cos(az), math.sin(el), math.cos(el) * math.sin(az))
		local length = upward and (ceilY - center.Y) / math.sin(el) or (center.Y - groundY) / -math.sin(el)
		local a0 = new("Attachment", {Name = "RayFrom" .. k, Position = dir * (R + 0.5)}, root)
		local a1 = new("Attachment", {Name = "RayTo" .. k, Position = dir * length}, root)
		local b = beam("Ray", a0, a1, PALETTE[(k - 1) % #PALETTE + 1], R * 0.14, math.min(length * 0.09, 70), 0.5, 0.95, root)
		b:SetAttribute("T0", 0.5)
	end
	return m, count
end

---------------------------------------------------------------- lyre (projecteur mobile) suspendue
local function movingHead(parent, pos, color, phase, aim, sweep)
	local m = group(parent, "MovingHead")
	local yoke = part(m, {Name = "Yoke", Size = Vector3.new(6, 4, 6), CFrame = CFrame.new(pos), Color = rgb(30, 30, 38), Material = METAL})
	local head = part(m, {Name = "Head", Shape = Enum.PartType.Cylinder, Size = Vector3.new(8, 6, 6), CFrame = CFrame.new(pos - Vector3.new(0, 6, 0)) * CFrame.Angles(0, 0, math.pi / 2),
		Color = rgb(22, 22, 30), Material = METAL})
	local lens = part(m, {Name = "Lens", Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.4, 5, 5), CFrame = head.CFrame * CFrame.new(-4.1, 0, 0), Color = color, Material = NEON})
	weld(head, lens)
	local out = new("Attachment", {Name = "Out", Position = Vector3.new(-4.4, 0, 0)}, head)
	local target = new("Attachment", {Name = "Target"}, yoke)
	target.WorldPosition = aim
	beam("Light", out, target, color, 2.5, 34, 0.45, 0.93, head)
	m:SetAttribute("Phase", phase)
	m:SetAttribute("Aim", aim)
	m:SetAttribute("Sweep", sweep)
	m.PrimaryPart = yoke
	return m
end

---------------------------------------------------------------- DJ : capybara R6 (bras, jambes, tête en blocs, accessoires soudés)
local BROWN, SNOUT, DARK = rgb(128, 88, 58), rgb(150, 108, 72), rgb(48, 32, 24)
local JACKET, PANTS = rgb(118, 46, 214), rgb(34, 28, 58)
local function r6Joint(name, p0, p1, c0, c1)
	local j = Instance.new("Motor6D")
	j.Name, j.Part0, j.Part1, j.C0, j.C1 = name, p0, p1, c0, c1
	j.Parent = p0
	return j
end
local function accessory(m, body, name, props, offset)
	props.Name = name
	props.CFrame = body.CFrame * offset
	local p = part(m, props)
	local w = Instance.new("Weld")
	w.Part0, w.Part1, w.C0 = body, p, offset
	w.Parent = p
	p.Anchored = false
	p.Massless = true
	return p
end
local function buildDJ(parent)
	local m = group(parent, "DJ Capy")
	local function body(name, size, cf, color)
		local p = part(m, {Name = name, Size = size, CFrame = cf, Color = color})
		p.Anchored = false
		return p
	end
	local hrp = part(m, {Name = "HumanoidRootPart", Size = Vector3.new(2, 2, 1), CFrame = CFrame.new(0, 3, 0), Transparency = 1})
	local torso = body("Torso", Vector3.new(2, 2, 1), CFrame.new(0, 3, 0), JACKET)
	local head = body("Head", Vector3.new(1.7, 1.25, 1.5), CFrame.new(0, 4.625, 0), BROWN)
	local la = body("Left Arm", Vector3.new(1, 2, 1), CFrame.new(-1.5, 3, 0), JACKET)
	local ra = body("Right Arm", Vector3.new(1, 2, 1), CFrame.new(1.5, 3, 0), JACKET)
	local ll = body("Left Leg", Vector3.new(1, 2, 1), CFrame.new(-0.5, 1, 0), PANTS)
	local rl = body("Right Leg", Vector3.new(1, 2, 1), CFrame.new(0.5, 1, 0), PANTS)
	m.PrimaryPart = hrp
	local R0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
	r6Joint("RootJoint", hrp, torso, R0, R0)
	r6Joint("Neck", torso, head, CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0), CFrame.new(0, -0.625, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0))
	r6Joint("Right Shoulder", torso, ra, CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0))
	r6Joint("Left Shoulder", torso, la, CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0))
	r6Joint("Right Hip", torso, rl, CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0), CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0))
	r6Joint("Left Hip", torso, ll, CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0))
	local hum = Instance.new("Humanoid")
	hum.RigType = Enum.HumanoidRigType.R6
	hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
	hum.Parent = m
	-- tête de capybara : museau long et carré, gros nez sombre, deux dents, petites oreilles rondes
	accessory(m, head, "Snout", {Size = Vector3.new(1.35, 0.85, 0.85), Color = SNOUT}, CFrame.new(0, -0.15, -0.95))
	accessory(m, head, "Nose", {Size = Vector3.new(1.0, 0.38, 0.14), Color = DARK}, CFrame.new(0, 0.05, -1.4))
	accessory(m, head, "Smile", {Size = Vector3.new(0.75, 0.07, 0.06), Color = DARK}, CFrame.new(0, -0.38, -1.39))
	accessory(m, head, "ToothL", {Size = Vector3.new(0.17, 0.22, 0.06), Color = rgb(255, 252, 240)}, CFrame.new(-0.1, -0.52, -1.33))
	accessory(m, head, "ToothR", {Size = Vector3.new(0.17, 0.22, 0.06), Color = rgb(255, 252, 240)}, CFrame.new(0.1, -0.52, -1.33))
	for _, x in {-0.62, 0.62} do
		accessory(m, head, "Ear", {Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.18, 0.42, 0.42), Color = DARK}, CFrame.new(x, 0.62, 0.35) * CFrame.Angles(0, math.pi / 2, 0))
	end
	-- lunettes de DJ (verres néon rose / cyan, monture noire)
	accessory(m, head, "GlassesFrame", {Size = Vector3.new(1.82, 0.42, 0.1), Color = rgb(12, 12, 16)}, CFrame.new(0, 0.2, -0.79))
	accessory(m, head, "LensL", {Size = Vector3.new(0.72, 0.3, 0.06), Color = MAGENTA, Material = NEON}, CFrame.new(-0.44, 0.2, -0.84))
	accessory(m, head, "LensR", {Size = Vector3.new(0.72, 0.3, 0.06), Color = CYAN, Material = NEON}, CFrame.new(0.44, 0.2, -0.84))
	accessory(m, head, "TempleL", {Size = Vector3.new(0.06, 0.08, 1.1), Color = rgb(12, 12, 16)}, CFrame.new(-0.88, 0.22, -0.25))
	accessory(m, head, "TempleR", {Size = Vector3.new(0.06, 0.08, 1.1), Color = rgb(12, 12, 16)}, CFrame.new(0.88, 0.22, -0.25))
	-- casque audio
	accessory(m, head, "HeadbandTop", {Size = Vector3.new(1.95, 0.18, 0.32), Color = rgb(24, 24, 32)}, CFrame.new(0, 0.74, 0.05))
	for _, x in {-1, 1} do
		accessory(m, head, "HeadbandSide", {Size = Vector3.new(0.16, 0.62, 0.3), Color = rgb(24, 24, 32)}, CFrame.new(x * 0.96, 0.45, 0.05))
		accessory(m, head, "EarCup", {Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.36, 0.82, 0.82), Color = rgb(30, 30, 40)}, CFrame.new(x * 1.0, 0.02, 0.05))
		accessory(m, head, "EarCupNeon", {Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.08, 0.86, 0.86), Color = x < 0 and MAGENTA or CYAN, Material = NEON}, CFrame.new(x * 1.2, 0.02, 0.05))
	end
	-- la touche drôle : une mandarine posée sur la tête (le capybara la garde pendant tout le set)
	accessory(m, head, "Mandarin", {Shape = Enum.PartType.Ball, Size = Vector3.one * 0.62, Color = rgb(255, 150, 30)}, CFrame.new(0, 0.95, -0.3))
	accessory(m, head, "MandarinLeaf", {Size = Vector3.new(0.3, 0.05, 0.16), Color = rgb(70, 190, 70)}, CFrame.new(0.12, 1.27, -0.3) * CFrame.Angles(0, 0, 0.4))
	-- veste : t-shirt rose, chaîne en or avec un médaillon boule à facettes, bordure néon
	accessory(m, torso, "Shirt", {Size = Vector3.new(0.8, 1.9, 0.05), Color = rgb(255, 110, 210)}, CFrame.new(0, 0, -0.52))
	accessory(m, torso, "LapelL", {Size = Vector3.new(0.14, 1.9, 0.06), Color = CYAN, Material = NEON}, CFrame.new(-0.47, 0, -0.53))
	accessory(m, torso, "LapelR", {Size = Vector3.new(0.14, 1.9, 0.06), Color = CYAN, Material = NEON}, CFrame.new(0.47, 0, -0.53))
	accessory(m, torso, "ChainL", {Size = Vector3.new(0.08, 0.95, 0.06), Color = rgb(255, 205, 60), Material = METAL}, CFrame.new(-0.22, 0.5, -0.56) * CFrame.Angles(0, 0, -0.42))
	accessory(m, torso, "ChainR", {Size = Vector3.new(0.08, 0.95, 0.06), Color = rgb(255, 205, 60), Material = METAL}, CFrame.new(0.22, 0.5, -0.56) * CFrame.Angles(0, 0, 0.42))
	accessory(m, torso, "Medallion", {Shape = Enum.PartType.Ball, Size = Vector3.one * 0.42, Color = rgb(225, 228, 245), Reflectance = 0.5}, CFrame.new(0, 0.02, -0.6))
	accessory(m, torso, "JacketHem", {Size = Vector3.new(2.04, 0.14, 1.04), Color = MAGENTA, Material = NEON}, CFrame.new(0, -0.93, 0))
	-- bras : poignets néon, pattes de capybara
	for _, arm in {la, ra} do
		accessory(m, arm, "Cuff", {Size = Vector3.new(1.04, 0.16, 1.04), Color = CYAN, Material = NEON}, CFrame.new(0, -0.48, 0))
		accessory(m, arm, "Paw", {Size = Vector3.new(1.02, 0.42, 1.02), Color = BROWN}, CFrame.new(0, -0.8, 0))
	end
	-- baskets blanches à semelle néon
	for _, leg in {ll, rl} do
		accessory(m, leg, "Sneaker", {Size = Vector3.new(1.04, 0.42, 1.3), Color = rgb(245, 245, 250)}, CFrame.new(0, -0.8, -0.14))
		accessory(m, leg, "Sole", {Size = Vector3.new(1.06, 0.1, 1.32), Color = MAGENTA, Material = NEON}, CFrame.new(0, -1.0, -0.14))
	end
	for _, d in m:GetDescendants() do
		if d:IsA("BasePart") and d ~= hrp then d.Anchored = false end
	end
	return m
end

---------------------------------------------------------------- scène du DJ (au fond, plus loin que la Galaxy Zone)
local function buildStage(parent, front, zC, floorY, DJ_SCALE)
	local stage = group(parent, "Stage")
	local TOP = 52
	local depth, width = 240, 330
	local cx = front + depth / 2
	local platform = part(stage, {Name = "Platform", Size = Vector3.new(depth, TOP - floorY, width), CFrame = CFrame.new(cx, (TOP + floorY) / 2, zC), Color = rgb(18, 14, 36), Reflectance = 0.1})
	texture(platform, Enum.NormalId.Top, TEX.Tile, 16, MAGENTA, 0.25, "LedFloor")
	texture(platform, Enum.NormalId.Left, TEX.Tile, 12, VIOLET, 0.55, "LedFront")
	part(stage, {Name = "EdgeNeon", Material = NEON, Color = MAGENTA, Size = Vector3.new(2, 2, width), CFrame = CFrame.new(front - 0.5, TOP - 1, zC)})
	part(stage, {Name = "EdgeNeon", Material = NEON, Color = CYAN, Size = Vector3.new(2, 2, width), CFrame = CFrame.new(front - 0.5, TOP - 14, zC)})
	for _, s in {-1, 1} do
		part(stage, {Name = "EdgeNeon", Material = NEON, Color = VIOLET, Size = Vector3.new(depth, 2, 2), CFrame = CFrame.new(cx, TOP - 1, zC + s * (width / 2 + 0.5))})
	end
	-- DJ
	local djX = front + 92
	local dj = buildDJ(stage)
	dj:ScaleTo(DJ_SCALE)
	dj:PivotTo(CFrame.new(djX, TOP + 3 * DJ_SCALE, zC) * CFrame.Angles(0, math.pi / 2, 0))
	-- table de mixage (devant le DJ, côté public) : dessinée pour un DJ d'échelle 7, puis agrandie avec lui (autour de ses pieds)
	local booth = group(stage, "Booth")
	local bx = djX - 9.5
	local bh = 19
	local body = part(booth, {Name = "Body", Size = Vector3.new(9, bh, 64), CFrame = CFrame.new(bx, TOP + bh / 2, zC), Color = rgb(12, 12, 20), Reflectance = 0.2})
	local gui = new("SurfaceGui", {Name = "Screen", Face = Enum.NormalId.Left, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, PixelsPerStud = 6, LightInfluence = 0, Brightness = 1.6, MaxDistance = 3000}, body)
	gui:SetAttribute("DiscoScreen", true)
	local bg = new("Frame", {Name = "Background", Size = UDim2.fromScale(1, 1), BackgroundColor3 = rgb(10, 6, 24), BorderSizePixel = 0}, gui)
	local title = new("TextLabel", {Name = "Title", BackgroundTransparency = 1, Position = UDim2.fromScale(0.05, 0.08), Size = UDim2.fromScale(0.9, 0.42),
		FontFace = FONT, Text = "DJ CAPY", TextScaled = true, TextColor3 = Color3.new(1, 1, 1)}, bg)
	stroke(title, 5)
	new("UIGradient", {Name = "Flow", Color = ColorSequence.new({ColorSequenceKeypoint.new(0, MAGENTA), ColorSequenceKeypoint.new(0.5, rgb(255, 255, 255)), ColorSequenceKeypoint.new(1, CYAN)})}, title)
	local eq = new("Frame", {Name = "Eq", BackgroundTransparency = 1, Position = UDim2.fromScale(0.05, 0.58), Size = UDim2.fromScale(0.9, 0.36)}, bg)
	for i = 1, 20 do
		local bar = new("Frame", {Name = "Bar", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new((i - 1) / 20, 2, 1, 0), Size = UDim2.new(1 / 20, -4, 0.3, 0),
			BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0}, eq)
		new("UIGradient", {Rotation = -90, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, CYAN), ColorSequenceKeypoint.new(0.6, VIOLET), ColorSequenceKeypoint.new(1, MAGENTA)})}, bar)
	end
	part(booth, {Name = "Top", Size = Vector3.new(11, 1, 66), CFrame = CFrame.new(bx, TOP + bh + 0.5, zC), Color = rgb(38, 38, 52), Material = METAL})
	for _, y in {TOP + 1.5, TOP + bh - 1} do
		part(booth, {Name = "LedStrip", Material = NEON, Color = y < TOP + 5 and CYAN or MAGENTA, Size = Vector3.new(0.6, 0.8, 64), CFrame = CFrame.new(bx - 4.6, y, zC)})
	end
	local deckY = TOP + bh + 1
	for i, s in {-1, 1} do
		local z = zC + s * 18
		part(booth, {Name = "DeckBase", Size = Vector3.new(9, 1.2, 14), CFrame = CFrame.new(bx, deckY + 0.6, z), Color = rgb(150, 152, 170), Material = METAL})
		local platter = part(booth, {Name = "Platter", Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.6, 8.4, 8.4), CFrame = CFrame.new(bx, deckY + 1.5, z - 1.5) * CFrame.Angles(0, 0, math.pi / 2), Color = rgb(16, 16, 20)})
		platter:SetAttribute("Spin", s * 3.5)
		weld(platter, part(booth, {Name = "RecordLabel", Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.68, 2.6, 2.6), CFrame = platter.CFrame, Color = i == 1 and MAGENTA or CYAN, Material = NEON}))
		weld(platter, part(booth, {Name = "RecordMark", Size = Vector3.new(0.7, 0.4, 3.6), CFrame = platter.CFrame * CFrame.new(0, 0, 2.2), Color = rgb(235, 235, 245)}))
		part(booth, {Name = "Tonearm", Size = Vector3.new(0.5, 0.5, 6), CFrame = CFrame.new(bx + 2.8, deckY + 2.1, z + 4) * CFrame.Angles(0, 0.5, 0), Color = rgb(210, 212, 225), Material = METAL})
	end
	part(booth, {Name = "Mixer", Size = Vector3.new(8, 1.6, 12), CFrame = CFrame.new(bx, deckY + 0.8, zC), Color = rgb(28, 28, 36), Material = METAL})
	for r = 0, 2 do
		for c = 0, 3 do
			part(booth, {Name = "Knob", Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.7, 1, 1), CFrame = CFrame.new(bx + 2.6 - r * 1.6, deckY + 1.9, zC - 4.5 + c * 3) * CFrame.Angles(0, 0, math.pi / 2),
				Color = ({MAGENTA, CYAN, rgb(240, 240, 250)})[r + 1]})
		end
	end
	for c = 0, 3 do
		part(booth, {Name = "Fader", Size = Vector3.new(1.4, 0.6, 0.6), CFrame = CFrame.new(bx - 2.4, deckY + 1.9, zC - 4.5 + c * 3), Color = rgb(240, 240, 250)})
		local button = part(booth, {Name = "PadButton", Material = NEON, Color = PALETTE[c + 1], Size = Vector3.new(0.9, 0.3, 0.9), CFrame = CFrame.new(bx - 3.6, deckY + 1.75, zC - 4.5 + c * 3)})
		button:SetAttribute("Blink", c)
	end
	booth.WorldPivot = CFrame.new(djX, TOP, zC)
	booth:ScaleTo(DJ_SCALE / 7)
	-- enceintes de chaque côté (deux caissons empilés, haut-parleurs côté public)
	local speakers = group(stage, "Speakers")
	for _, s in {-1, 1} do
		local z = zC + s * 132
		for k = 0, 1 do
			local cy = TOP + 19 + k * 38
			local cab = part(speakers, {Name = "Cabinet", Size = Vector3.new(30, 36, 34), CFrame = CFrame.new(front + 26, cy, z), Color = rgb(16, 16, 22)})
			texture(cab, Enum.NormalId.Left, TEX.Tile, 6, rgb(40, 40, 60), 0.75, "Grille")
			local fx = front + 26 - 15.2
			part(speakers, {Name = "WooferRim", Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.8, 22, 22), CFrame = CFrame.new(fx, cy - 4, z), Color = rgb(120, 122, 140), Material = METAL})
			part(speakers, {Name = "WooferCone", Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.9, 18.5, 18.5), CFrame = CFrame.new(fx - 0.1, cy - 4, z), Color = rgb(30, 30, 38)})
			local cap = part(speakers, {Name = "DustCap", Shape = Enum.PartType.Ball, Size = Vector3.one * 5.5, CFrame = CFrame.new(fx + 1.2, cy - 4, z), Color = rgb(70, 70, 86)})
			cap:SetAttribute("Home", cap.CFrame)
			part(speakers, {Name = "Tweeter", Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.9, 7, 7), CFrame = CFrame.new(fx - 0.1, cy + 12, z), Color = rgb(120, 122, 140), Material = METAL})
			part(speakers, {Name = "SpeakerNeon", Material = NEON, Color = k == 0 and CYAN or MAGENTA, Size = Vector3.new(0.6, 0.8, 34), CFrame = CFrame.new(fx - 0.2, cy - 17.4, z)})
		end
	end
	-- mur LED derrière le DJ
	local back = front + depth
	screen(stage, "LedWall", CFrame.new(back - 14, TOP + 82, zC), 300, 150, Enum.NormalId.Front, "DJ CAPY", "DISCO NIGHT", 32).CFrame =
		CFrame.new(back - 14, TOP + 82, zC) * CFrame.Angles(0, math.pi / 2, 0)
	-- arche de projecteurs au-dessus de la scène
	local arch = group(stage, "Arch")
	local archX, archTop = front + 22, TOP + 175
	for _, s in {-1, 1} do
		local z = zC + s * (width / 2 + 10)
		part(arch, {Name = "Tower", Size = Vector3.new(10, archTop - floorY, 10), CFrame = CFrame.new(archX, (archTop + floorY) / 2, z), Color = rgb(50, 50, 64), Material = METAL})
		part(arch, {Name = "TowerNeon", Material = NEON, Color = s < 0 and MAGENTA or CYAN, Size = Vector3.new(1, archTop - floorY, 1.5), CFrame = CFrame.new(archX - 5.2, (archTop + floorY) / 2, z - s * 3)})
	end
	part(arch, {Name = "TopBeam", Size = Vector3.new(10, 10, width + 30), CFrame = CFrame.new(archX, archTop, zC), Color = rgb(50, 50, 64), Material = METAL})
	part(arch, {Name = "TopNeon", Material = NEON, Color = VIOLET, Size = Vector3.new(1, 1.4, width + 30), CFrame = CFrame.new(archX - 5.2, archTop - 3, zC)})
	local heads = group(stage, "StageLights")
	for k = 0, 5 do
		local z = zC - 130 + k * 52
		movingHead(heads, Vector3.new(archX, archTop - 7, z), PALETTE[k % #PALETTE + 1], k * 1.1, Vector3.new(front - 260, 2, zC + (k - 2.5) * 40), Vector3.new(160, 0, 110))
	end
	return stage, djX
end

---------------------------------------------------------------- petit modèle pour l'étiquette de mutation (SkyEvents.Models.DiscoIcon)
local function buildIcon()
	local models = ReplicatedStorage:WaitForChild("SkyEvents"):WaitForChild("Models")
	local old = models:FindFirstChild("DiscoIcon")
	if old then old:Destroy() end
	local m = Instance.new("Model")
	m.Name = "DiscoIcon"
	local R = 1
	part(m, {Name = "Core", Shape = Enum.PartType.Ball, Size = Vector3.one * (2 * R - 0.06), CFrame = CFrame.new(), Color = rgb(40, 36, 60)})
	local rng = Random.new(9)
	local rings = 8
	for i = 0, rings - 1 do
		local lat = -math.pi / 2 + (i + 0.5) * math.pi / rings
		local circ = 2 * math.pi * R * math.cos(lat)
		local n = math.max(5, math.floor(circ / (math.pi * R / rings) + 0.5))
		for j = 0, n - 1 do
			local lon = j * 2 * math.pi / n + i * 0.3
			local nrm = Vector3.new(math.cos(lat) * math.cos(lon), math.sin(lat), math.cos(lat) * math.sin(lon))
			local up = Vector3.new(-math.sin(lat) * math.cos(lon), math.cos(lat), -math.sin(lat) * math.sin(lon))
			local pos = nrm * R
			local roll = rng:NextNumber()
			local color = roll < 0.55 and rgb(215, 218, 235) or roll < 0.7 and rgb(255, 255, 255) or roll < 0.8 and rgb(255, 120, 225) or roll < 0.9 and rgb(110, 225, 255) or rgb(170, 130, 255)
			part(m, {Name = "Tile", Size = Vector3.new(circ / n * 0.84, math.pi * R / rings * 0.84, 0.05), CFrame = CFrame.lookAt(pos, pos + nrm, up), Color = color,
				Material = roll >= 0.7 and NEON or Enum.Material.SmoothPlastic})
		end
	end
	part(m, {Name = "Cap", Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.14, 0.3, 0.3), CFrame = CFrame.new(0, R + 0.05, 0) * CFrame.Angles(0, 0, math.pi / 2), Color = rgb(180, 182, 200)})
	m.PrimaryPart = m.Core
	m.Parent = models
	return m
end

---------------------------------------------------------------- tout
function M.build()
	local map = M.measure()
	local old = ReplicatedStorage:FindFirstChild("DiscoEvent")
	if old then old:Destroy() end
	local root = Instance.new("Folder")
	root.Name = "DiscoEvent"
	local club = group(root, "Club")
	local zoneZ = map.ZoneZ
	local MARGIN = 170
	local floorY = math.floor(map.VisLoY) - 40
	local ceilY = math.max(340, math.ceil(map.VisHiY) + 120)
	local groundY = map.ZoneTop
	local stageFront = math.ceil(math.max(map.Hi.X, map.GalaxyEnd)) + 130
	local x0, x1 = math.floor(map.Lo.X) - MARGIN, stageFront + 240 + 150
	local z0, z1 = math.floor(map.Lo.Z) - MARGIN, math.ceil(map.Hi.Z) + MARGIN
	local wallH, wy = ceilY - floorY, (ceilY + floorY) / 2

	-- murs : panneaux sombres, pilastres néon, bandeaux néon, reflets, écrans LED
	local enc = group(club, "Enclosure")
	local function splits(a, b)
		local n = math.ceil((b - a) / 2000)
		local list = {}
		for i = 1, n do table.insert(list, {a + (i - 1) * (b - a) / n, a + i * (b - a) / n}) end
		return list
	end
	local function wallAlongX(z, inward, face)
		for _, seg in splits(x0, x1) do
			local len, cx = seg[2] - seg[1], (seg[1] + seg[2]) / 2
			local w = part(enc, {Name = "Wall", Size = Vector3.new(len, wallH, 6), CFrame = CFrame.new(cx, wy, z), Color = rgb(16, 13, 34), Reflectance = 0.06})
			texture(w, face, TEX.Stars, 70, rgb(230, 200, 255), 0.15, "ReflectionDots")
			part(enc, {Name = "NeonBand", Material = NEON, Color = MAGENTA, Size = Vector3.new(len, 3, 1.5), CFrame = CFrame.new(cx, groundY + 20, z + inward * 3.8)})
			part(enc, {Name = "NeonBand", Material = NEON, Color = CYAN, Size = Vector3.new(len, 3, 1.5), CFrame = CFrame.new(cx, ceilY - 30, z + inward * 3.8)})
		end
		local n = math.floor((x1 - x0) / 300)
		for k = 0, n do
			part(enc, {Name = "Pilaster", Material = NEON, Color = PALETTE[k % 3 + 1], Size = Vector3.new(5, wallH, 1.5), CFrame = CFrame.new(x0 + 40 + k * (x1 - x0 - 80) / n, wy, z + inward * 3.8)})
		end
		for k = 1, 3 do
			local x = x0 + (x1 - x0) * (k - 0.5) / 3
			local s = screen(enc, "LedScreen", CFrame.new(x, groundY + 125, z + inward * 5), 220, 120, inward > 0 and Enum.NormalId.Back or Enum.NormalId.Front,
				"DISCO NIGHT", "DJ CAPY IS LIVE", 24)
			s:SetAttribute("Index", k)
		end
	end
	local function wallAlongZ(x, inward, face)
		for _, seg in splits(z0, z1) do
			local len, cz = seg[2] - seg[1], (seg[1] + seg[2]) / 2
			local w = part(enc, {Name = "Wall", Size = Vector3.new(6, wallH, len), CFrame = CFrame.new(x, wy, cz), Color = rgb(16, 13, 34), Reflectance = 0.06})
			texture(w, face, TEX.Stars, 70, rgb(230, 200, 255), 0.15, "ReflectionDots")
			part(enc, {Name = "NeonBand", Material = NEON, Color = MAGENTA, Size = Vector3.new(1.5, 3, len), CFrame = CFrame.new(x + inward * 3.8, groundY + 20, cz)})
			part(enc, {Name = "NeonBand", Material = NEON, Color = CYAN, Size = Vector3.new(1.5, 3, len), CFrame = CFrame.new(x + inward * 3.8, ceilY - 30, cz)})
		end
		local n = math.max(1, math.floor((z1 - z0) / 300))
		for k = 0, n do
			part(enc, {Name = "Pilaster", Material = NEON, Color = PALETTE[k % 3 + 1], Size = Vector3.new(1.5, wallH, 5), CFrame = CFrame.new(x + inward * 3.8, wy, z0 + 40 + k * (z1 - z0 - 80) / n)})
		end
	end
	wallAlongX(z0, 1, Enum.NormalId.Back)
	wallAlongX(z1, -1, Enum.NormalId.Front)
	wallAlongZ(x0, 1, Enum.NormalId.Right)
	wallAlongZ(x1, -1, Enum.NormalId.Left)

	-- plafond : panneaux très sombres avec des petites lumières (étoiles / reflets qui glissent), poutres et néons
	local ceiling = group(club, "Ceiling")
	for _, sx in splits(x0, x1) do
		for _, sz in splits(z0, z1) do
			local p = part(ceiling, {Name = "CeilingPanel", Size = Vector3.new(sx[2] - sx[1], 4, sz[2] - sz[1]), CFrame = CFrame.new((sx[1] + sx[2]) / 2, ceilY + 2, (sz[1] + sz[2]) / 2),
				Color = rgb(12, 10, 26), Transparency = 0.04})
			texture(p, Enum.NormalId.Bottom, TEX.Stars, 95, rgb(255, 235, 255), 0.05, "Stars1")
			texture(p, Enum.NormalId.Bottom, TEX.Stars, 141, rgb(130, 220, 255), 0.2, "Stars2")
		end
	end
	local trussY = ceilY - 9
	for r, z in {zoneZ - 260, zoneZ, zoneZ + 260} do
		for _, seg in splits(x0, x1) do
			local len, cx = seg[2] - seg[1], (seg[1] + seg[2]) / 2
			part(ceiling, {Name = "Truss", Size = Vector3.new(len, 8, 8), CFrame = CFrame.new(cx, trussY, z), Color = rgb(58, 58, 72), Material = METAL})
			part(ceiling, {Name = "TrussNeon", Material = NEON, Color = PALETTE[r], Size = Vector3.new(len, 0.8, 2), CFrame = CFrame.new(cx, trussY - 4.5, z)})
		end
	end
	local nCross = math.floor((x1 - x0) / 460)
	for k = 0, nCross do
		local x = x0 + 60 + k * (x1 - x0 - 120) / nCross
		part(ceiling, {Name = "CrossTruss", Size = Vector3.new(8, 8, z1 - z0 - 20), CFrame = CFrame.new(x, trussY + 0.5, (z0 + z1) / 2), Color = rgb(58, 58, 72), Material = METAL})
	end

	-- sol de la boîte (sous la carte, ne se voit qu'au-delà des bords) : carreaux LED sombres
	local floor = group(club, "Floor")
	for _, sx in splits(x0, x1) do
		for _, sz in splits(z0, z1) do
			local p = part(floor, {Name = "FloorPanel", Size = Vector3.new(sx[2] - sx[1], 4, sz[2] - sz[1]), CFrame = CFrame.new((sx[1] + sx[2]) / 2, floorY - 2, (sz[1] + sz[2]) / 2),
				Color = rgb(10, 8, 22), Reflectance = 0.15})
			texture(p, Enum.NormalId.Top, TEX.Tile, 40, rgb(150, 70, 230), 0.55, "LedFloor")
		end
	end

	-- projecteurs mobiles sous les poutres de côté : leurs faisceaux balaient les zones
	local rigs = group(club, "LightRigs")
	local n = math.floor((stageFront - 200 - (x0 + 260)) / 440)
	for row, z in {zoneZ - 260, zoneZ + 260} do
		for k = 0, n do
			local x = x0 + 260 + k * 440 + (row == 2 and 220 or 0)
			if x < stageFront - 120 then
				movingHead(rigs, Vector3.new(x, trussY - 8, z), PALETTE[(k + row) % #PALETTE + 1], k * 0.9 + row * 2,
					Vector3.new(x, groundY + 1, zoneZ), Vector3.new(170, 0, 120))
			end
		end
	end

	-- LA boule à facettes géante, au centre de la carte (au milieu de sa partie visible, au-dessus de l'axe des zones),
	-- assez haut pour que la caméra (zoom max) ne la touche jamais
	local R = 50
	local ballY = map.PlayerTop + game:GetService("StarterPlayer").CameraMaxZoomDistance + 25 + R
	local center = Vector3.new(math.floor((map.VisLoX + map.VisHiX) / 2), ballY, zoneZ)
	local balls = group(club, "DiscoBalls")
	local main, tiles = discoBall(balls, "MainBall", center, R, 6.2, 16, ceilY, groundY)
	main:SetAttribute("Spin", 0.22)
	-- deux petites boules : au-dessus du spawn et au-dessus de la fin de la carte
	local miniY = ballY + 10
	local w = discoBall(balls, "MiniBallSpawn", Vector3.new(math.floor(map.SpawnX), miniY, zoneZ), 16, 4.2, 8, ceilY, groundY)
	w:SetAttribute("Spin", -0.3)
	local e = discoBall(balls, "MiniBallEnd", Vector3.new(math.floor(map.GalaxyEnd - 500), miniY, zoneZ), 16, 4.2, 8, ceilY, groundY)
	e:SetAttribute("Spin", 0.3)

	local stage, djX = buildStage(club, stageFront, zoneZ, floorY, 16)

	-- repères pour DiscoEventClient (et pour vérifier que la carte est intacte)
	root:SetAttribute("MapLo", map.Lo)
	root:SetAttribute("MapHi", map.Hi)
	root:SetAttribute("BallCenter", center)
	root:SetAttribute("StageFront", stageFront)
	root:SetAttribute("GalaxyEnd", map.GalaxyEnd)
	root:SetAttribute("CeilingY", ceilY)
	root:SetAttribute("FloorY", floorY)
	root:SetAttribute("Bounds", Vector3.new(x1 - x0, wallH, z1 - z0))
	root:SetAttribute("BoundsMin", Vector3.new(x0, floorY, z0))
	root.Parent = ReplicatedStorage
	buildIcon()
	local parts = 0
	for _, d in root:GetDescendants() do if d:IsA("BasePart") then parts += 1 end end
	return string.format("Disco club built: %d parts (main ball %d tiles). Box X %d..%d Z %d..%d Y %d..%d | ball %s | stage front %d (Galaxy ends %.1f) | DJ x %.1f",
		parts, tiles, x0, x1, z0, z1, floorY, ceilY, tostring(center), stageFront, map.GalaxyEnd, djX)
end

return M

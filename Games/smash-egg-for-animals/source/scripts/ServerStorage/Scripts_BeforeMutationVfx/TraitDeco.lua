-- Habillage des traits et des mutations, commun aux œufs et aux animaux :
--   Hat(model, "Witch" | "Cowboy", {Name})  chapeau en blocs posé sur la TÊTE de l'animal (ou sur la coquille de l'œuf),
--                                           soudé à l'articulation de la tête : il suit l'animal et ses animations
--   MutationFx(model, mutation)             effets qui suivent le modèle : projecteurs et cœurs pour Like, étincelles pour Gold / Diamond / Rainbow
local CollectionService = game:GetService("CollectionService")
local M = {}
local rgb = Color3.fromRGB

-- boîte englobante (alignée sur le monde) d'une liste de pièces
local function boxOf(parts)
	local lo, hi = Vector3.new(math.huge, math.huge, math.huge), Vector3.new(-math.huge, -math.huge, -math.huge)
	for _, p in parts do
		local cf, h = p.CFrame, p.Size / 2
		local ext = Vector3.new(
			math.abs(cf.RightVector.X) * h.X + math.abs(cf.UpVector.X) * h.Y + math.abs(cf.LookVector.X) * h.Z,
			math.abs(cf.RightVector.Y) * h.X + math.abs(cf.UpVector.Y) * h.Y + math.abs(cf.LookVector.Y) * h.Z,
			math.abs(cf.RightVector.Z) * h.X + math.abs(cf.UpVector.Z) * h.Y + math.abs(cf.LookVector.Z) * h.Z)
		lo, hi = lo:Min(p.Position - ext), hi:Max(p.Position + ext)
	end
	return (lo + hi) / 2, hi - lo
end

-- où poser un chapeau : {pièce à laquelle le souder, centre du dessus, largeur disponible, pièces ancrées ou non}
local function perch(model)
	local root = model.PrimaryPart
	local holder, parts, anchored = root, {}, true
	local isEgg = false
	for _, d in model:GetDescendants() do
		if d:IsA("BasePart") and d.Name == "Decor" then isEgg = true end
		if d:IsA("BasePart") and d ~= root and d.Transparency < 1 and d.Name ~= "JointPart" then anchored = d.Anchored end
	end
	if isEgg then -- œuf : seulement la coquille (les cornes, oreilles et autres ornements ne comptent pas)
		for _, d in model:GetDescendants() do
			if d:IsA("BasePart") and d.Name == "Stud" and not d:FindFirstAncestor("TraitHat") then table.insert(parts, d) end
		end
	else -- animal : les pièces soudées à l'articulation de la tête
		local head
		for _, d in model:GetDescendants() do
			if d:IsA("Weld") and d:GetAttribute("Anim") == "Head" then head = d.Part1 break end
		end
		if head then
			for _, d in model:GetDescendants() do
				local weld = d:IsA("BasePart") and d.Transparency < 1 and d:FindFirstChildOfClass("WeldConstraint")
				if weld and weld.Part0 == head then table.insert(parts, d) end
			end
			if #parts > 0 then holder = head end
		end
	end
	local center, size
	if #parts > 0 then
		center, size = boxOf(parts)
	else
		local cf, s = model:GetBoundingBox()
		center, size = cf.Position, s
	end
	local width = math.min(size.X, size.Z)
	if isEgg then width *= 0.62 end -- le haut d'un œuf est plus étroit que son ventre
	return holder, center + Vector3.new(0, size.Y / 2, 0), math.max(width, 0.4), anchored, isEgg
end

function M.Hat(model, trait, opts)
	opts = opts or {}
	local name = opts.Name or "TraitHat"
	if not model.PrimaryPart or model:FindFirstChild(name) then return nil end
	local holder, top, width, anchored, isEgg = perch(model)
	local w = width * (isEgg and 0.95 or 0.8)
	local _, yaw = model:GetPivot():ToOrientation()
	local base = CFrame.new(top - Vector3.new(0, w * (isEgg and 0.12 or 0.04), 0)) * CFrame.Angles(0, yaw, 0)
	local hat = Instance.new("Model")
	hat.Name = name
	local function piece(size, cf, color, neon)
		local p = Instance.new("Part")
		p.Name = "Hat"
		p.Size = size * w
		p.CFrame = base * CFrame.new(cf.Position * w) * cf.Rotation
		p.Color = color
		p.Material = neon and Enum.Material.Neon or Enum.Material.Plastic
		local surface = neon and Enum.SurfaceType.Smooth or Enum.SurfaceType.Studs
		p.TopSurface, p.BottomSurface = surface, Enum.SurfaceType.Smooth
		p.Massless, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
		p.Anchored = anchored
		local weld = Instance.new("WeldConstraint")
		weld.Part0, weld.Part1 = holder, p
		weld.Parent = p
		p.Parent = hat
		return p
	end
	if trait == "Witch" then
		local dark, dark2 = rgb(44, 22, 74), rgb(60, 32, 98)
		piece(Vector3.new(1.7, 0.1, 1.7), CFrame.new(0, 0.05, 0), dark)
		piece(Vector3.new(1.02, 0.18, 1.02), CFrame.new(0, 0.19, 0), rgb(190, 95, 255), true)
		piece(Vector3.new(0.3, 0.24, 0.08), CFrame.new(0, 0.19, 0.52), rgb(255, 215, 90), true)
		local cf = CFrame.new(0, 0.28, 0)
		for i, s in {0.95, 0.76, 0.58, 0.4, 0.24} do -- cône en étages, la pointe pliée vers l'arrière
			piece(Vector3.new(s, 0.3, s), cf * CFrame.new(0, 0.14, 0), i % 2 == 1 and dark or dark2)
			cf = cf * CFrame.new(0, 0.27, 0) * CFrame.Angles(math.rad(-7 - i * 4), 0, 0)
		end
		piece(Vector3.new(0.16, 0.16, 0.16), cf * CFrame.new(0, 0.06, 0) * CFrame.Angles(math.rad(45), 0, math.rad(45)), rgb(255, 215, 90), true)
	else
		local brown, band = rgb(140, 90, 50), rgb(70, 40, 25)
		piece(Vector3.new(2.0, 0.1, 1.6), CFrame.new(0, 0.05, 0), brown)
		for _, s in {1, -1} do piece(Vector3.new(0.14, 0.26, 1.6), CFrame.new(s * 0.98, 0.16, 0) * CFrame.Angles(0, 0, math.rad(-20) * s), brown) end -- bords relevés
		piece(Vector3.new(1.06, 0.16, 1.02), CFrame.new(0, 0.18, 0), band)
		piece(Vector3.new(0.2, 0.2, 0.06), CFrame.new(0, 0.18, 0.53), rgb(255, 215, 90), true)
		piece(Vector3.new(1.0, 0.5, 0.96), CFrame.new(0, 0.5, 0), brown)
		for _, s in {1, -1} do piece(Vector3.new(0.36, 0.14, 0.9), CFrame.new(s * 0.3, 0.8, 0), rgb(160, 105, 60)) end -- creux du dessus
	end
	hat.Parent = model
	return hat
end

local SPARKLES = {
	Gold = ColorSequence.new(rgb(255, 235, 130), rgb(255, 180, 40)),
	Diamond = ColorSequence.new(rgb(210, 250, 255), rgb(110, 210, 255)),
	Rainbow = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 80, 80)), ColorSequenceKeypoint.new(0.33, rgb(255, 220, 70)), ColorSequenceKeypoint.new(0.66, rgb(80, 220, 255)), ColorSequenceKeypoint.new(1, rgb(200, 110, 255))}),
	Like = ColorSequence.new(rgb(255, 90, 160), rgb(90, 210, 255)),
	Cosmic = ColorSequence.new(rgb(150, 180, 255), rgb(230, 150, 255)),
	Storm = ColorSequence.new(rgb(200, 245, 255), rgb(80, 190, 255)),
	Alien = ColorSequence.new(rgb(170, 255, 140), rgb(60, 230, 110)),
	Candy = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 120, 200)), ColorSequenceKeypoint.new(0.5, rgb(255, 240, 140)), ColorSequenceKeypoint.new(1, rgb(140, 215, 255))}),
	Blood = ColorSequence.new(rgb(255, 90, 90), rgb(150, 10, 30)),
	Frozen = ColorSequence.new(rgb(255, 255, 255), rgb(150, 220, 255)),
	Hacked = ColorSequence.new(rgb(180, 255, 200), rgb(20, 230, 90)),
}

-- Mutations des events du ciel (SkyEventsServer). Tout est accroché au modèle (attachments, particules, rayons) : ça suit
-- l'œuf, l'animal au sol, dans les mains et dans le jardin. EventMutationFxClient fait tourner les orbites (tag "EventOrbit")
-- et crépiter les arcs (tag "StormArc").
local EVENT_FX = {
	Cosmic = {Main = rgb(150, 180, 255), Hot = rgb(255, 210, 140), Light = rgb(150, 150, 255)},
	Storm = {Main = rgb(120, 220, 255), Hot = rgb(235, 255, 255), Light = rgb(120, 210, 255)},
	Alien = {Main = rgb(110, 255, 120), Hot = rgb(220, 255, 170), Light = rgb(100, 255, 120)},
	Candy = {Main = rgb(255, 120, 200), Hot = rgb(255, 240, 150), Light = rgb(255, 140, 210)},
	Blood = {Main = rgb(200, 20, 40), Hot = rgb(255, 110, 110), Light = rgb(255, 50, 60)},
	Frozen = {Main = rgb(150, 220, 255), Hot = rgb(240, 252, 255), Light = rgb(150, 220, 255)},
	Hacked = {Main = rgb(30, 255, 100), Hot = rgb(200, 255, 215), Light = rgb(40, 255, 110)},
}

local function emitter(parent, props)
	local e = Instance.new("ParticleEmitter")
	e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	e.LightEmission = 1
	for k, v in props do e[k] = v end
	e.Parent = parent
	return e
end

-- une traînée lumineuse qui tourne autour du modèle : deux attachments (tête + bord de la traînée) déplacés par le client
local function orbiter(root, name, opts)
	local a = Instance.new("Attachment")
	a.Name = name .. "A"
	local b = Instance.new("Attachment")
	b.Name = name .. "B"
	for key, value in opts do if key ~= "Color" and key ~= "Width" and key ~= "Life" then a:SetAttribute(key, value) end end
	a:SetAttribute("Partner", b.Name)
	a:SetAttribute("Width", opts.Width)
	a.Position = Vector3.new(opts.Radius, opts.Height, 0)
	b.Position = a.Position + Vector3.new(0, opts.Width, 0)
	a.Parent, b.Parent = root, root
	local trail = Instance.new("Trail")
	trail.Attachment0, trail.Attachment1 = a, b
	trail.Lifetime = opts.Life
	trail.LightEmission, trail.LightInfluence = 1, 0
	trail.FaceCamera = true
	trail.Color = ColorSequence.new(opts.Color)
	trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.05), NumberSequenceKeypoint.new(1, 1)})
	trail.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.15)})
	trail.Parent = a
	CollectionService:AddTag(a, "EventOrbit")
	return a
end

local function eventFx(model, root, holder, mutation, s, size)
	local fx = EVENT_FX[mutation]
	local glow = Instance.new("PointLight")
	glow.Name = "EventGlow"
	glow.Color, glow.Range, glow.Brightness, glow.Shadows = fx.Light, math.clamp(s * 1.4, 5, 16), 0.7, false
	glow.Parent = root
	if mutation == "Cosmic" then
		-- trois comètes en orbite (inclinées différemment) avec des éclats de roche, et de la poussière d'étoiles
		for i = 1, 3 do
			local head = orbiter(root, "Comet" .. i, {Radius = s * (0.75 + i * 0.08), Height = size.Y * (0.05 + i * 0.12), Speed = 2.2 + i * 0.35, Phase = i * 2.09,
				Tilt = (i - 2) * 0.45, Width = s * 0.12, Life = 0.55, Color = i == 2 and fx.Hot or fx.Main})
			emitter(head, {Name = "Rocks", Color = ColorSequence.new(fx.Hot, rgb(255, 120, 60)), Rate = 6, Lifetime = NumberRange.new(0.3, 0.6),
				Speed = NumberRange.new(0, s * 0.1), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, s * 0.09), NumberSequenceKeypoint.new(1, 0)})})
		end
		emitter(holder, {Name = "Stardust", Color = ColorSequence.new(rgb(200, 210, 255), rgb(170, 120, 255)), Rate = 7, Lifetime = NumberRange.new(1.5, 2.5),
			Speed = NumberRange.new(s * 0.05, s * 0.2), SpreadAngle = Vector2.new(180, 180), Drag = 1,
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4, s * 0.07), NumberSequenceKeypoint.new(1, 0)})})
	elseif mutation == "Storm" then
		-- petit nuage d'orage au-dessus, étincelles électriques, et deux arcs qui crépitent autour
		local top = Instance.new("Attachment")
		top.Name = "StormCloud"
		top.Position = Vector3.new(0, size.Y * 0.62 + s * 0.35, 0)
		top.Parent = root
		emitter(top, {Name = "Cloud", Texture = "rbxasset://textures/particles/smoke_main.dds", LightEmission = 0, Color = ColorSequence.new(rgb(70, 76, 96), rgb(40, 44, 60)),
			Rate = 9, Lifetime = NumberRange.new(1.2, 1.8), Speed = NumberRange.new(0, s * 0.06), SpreadAngle = Vector2.new(180, 20), RotSpeed = NumberRange.new(-30, 30),
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, s * 0.25), NumberSequenceKeypoint.new(0.5, s * 0.45), NumberSequenceKeypoint.new(1, s * 0.3)}),
			Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.25, 0.25), NumberSequenceKeypoint.new(1, 1)})})
		emitter(top, {Name = "Drops", Color = ColorSequence.new(fx.Main), Rate = 10, Lifetime = NumberRange.new(0.4, 0.6), EmissionDirection = Enum.NormalId.Bottom,
			Speed = NumberRange.new(s * 1.2, s * 1.6), SpreadAngle = Vector2.new(12, 12), Size = NumberSequence.new(s * 0.03)})
		emitter(holder, {Name = "Sparks", Color = ColorSequence.new(fx.Hot, fx.Main), Rate = 9, Lifetime = NumberRange.new(0.15, 0.35), Speed = NumberRange.new(s * 0.4, s * 0.9),
			SpreadAngle = Vector2.new(180, 180), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, s * 0.1), NumberSequenceKeypoint.new(1, 0)})})
		for i = 1, 2 do
			local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
			a0.Name, a1.Name = "Arc" .. i .. "A", "Arc" .. i .. "B"
			a0.Parent, a1.Parent = root, root
			local beam = Instance.new("Beam")
			beam.Name = "StormArc"
			beam.Attachment0, beam.Attachment1 = a0, a1
			beam.Segments = 12
			beam.Width0, beam.Width1 = s * 0.06, s * 0.03
			beam.Color = ColorSequence.new(fx.Hot, fx.Main)
			beam.LightEmission, beam.LightInfluence = 1, 0
			beam.FaceCamera = true
			beam.Enabled = false
			beam:SetAttribute("Reach", Vector3.new(size.X * 0.6, size.Y * 0.55, size.Z * 0.6))
			beam.Parent = root
			CollectionService:AddTag(beam, "StormArc")
		end
	elseif mutation == "Alien" then
		-- halo vert qui tourne au-dessus (deux traînées très rapides = un anneau), lueur qui monte, signes extraterrestres
		for i = 1, 2 do
			orbiter(root, "Halo" .. i, {Radius = s * 0.42, Height = size.Y * 0.62 + s * 0.22, Speed = 7, Phase = i * math.pi, Tilt = 0, Width = s * 0.07, Life = 0.42,
				Color = fx.Main})
		end
		orbiter(root, "Ring", {Radius = s * 0.8, Height = -size.Y * 0.3, Speed = -3, Phase = 0, Tilt = 0.12, Width = s * 0.05, Life = 0.9, Color = fx.Hot})
		local foot = Instance.new("Attachment")
		foot.Name = "AlienLift"
		foot.Position = Vector3.new(0, -size.Y * 0.45, 0)
		foot.Parent = root
		emitter(foot, {Name = "Lift", Color = ColorSequence.new(fx.Hot, fx.Main), Rate = 10, Lifetime = NumberRange.new(1, 1.6), EmissionDirection = Enum.NormalId.Top,
			Speed = NumberRange.new(s * 0.3, s * 0.6), SpreadAngle = Vector2.new(8, 8), Shape = Enum.ParticleEmitterShape.Disc, ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface,
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, s * 0.06), NumberSequenceKeypoint.new(1, 0)}),
			Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1)})})
		foot.Orientation = Vector3.new(0, 0, 0)
	elseif mutation == "Candy" then
		-- trois bonbons (rose, jaune, bleu) qui tournent autour, et du sucre qui pétille
		for i, color in {fx.Main, fx.Hot, rgb(140, 215, 255)} do
			local head = orbiter(root, "Candy" .. i, {Radius = s * 0.8, Height = size.Y * (i - 2) * 0.18, Speed = 2.6, Phase = i * 2.09, Tilt = (i - 2) * 0.35,
				Width = s * 0.16, Life = 0.4, Color = color})
			emitter(head, {Name = "Sugar", Color = ColorSequence.new(Color3.new(1, 1, 1), color), Rate = 5, Lifetime = NumberRange.new(0.4, 0.8),
				Speed = NumberRange.new(0, s * 0.05), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, s * 0.08), NumberSequenceKeypoint.new(1, 0)})})
		end
		emitter(holder, {Name = "Sprinkles", Color = SPARKLES.Candy, Rate = 8, Lifetime = NumberRange.new(1, 1.6), Speed = NumberRange.new(s * 0.2, s * 0.4),
			SpreadAngle = Vector2.new(180, 180), Acceleration = Vector3.new(0, -s * 0.6, 0), RotSpeed = NumberRange.new(-200, 200),
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, s * 0.07), NumberSequenceKeypoint.new(1, s * 0.04)})})
	elseif mutation == "Blood" then
		-- deux chauves-souris (traînées sombres) qui tournoient de façon désordonnée, brume rouge au sol, gouttes qui tombent
		for i = 1, 2 do
			orbiter(root, "Bat" .. i, {Radius = s * (0.7 + i * 0.12), Height = size.Y * (0.25 + i * 0.12), Speed = 3.4 + i * 0.6, Phase = i * math.pi, Tilt = 0.7 * (i == 1 and 1 or -1),
				Width = s * 0.14, Life = 0.35, Color = rgb(120, 18, 36)})
		end
		local foot = Instance.new("Attachment")
		foot.Name = "BloodMist"
		foot.Position = Vector3.new(0, -size.Y * 0.42, 0)
		foot.Parent = root
		emitter(foot, {Name = "Mist", Texture = "rbxasset://textures/particles/smoke_main.dds", LightEmission = 0.3, Color = ColorSequence.new(rgb(200, 30, 50), rgb(90, 10, 20)),
			Rate = 6, Lifetime = NumberRange.new(1.4, 2.2), Speed = NumberRange.new(s * 0.05, s * 0.15), SpreadAngle = Vector2.new(180, 5), RotSpeed = NumberRange.new(-20, 20),
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, s * 0.3), NumberSequenceKeypoint.new(1, s * 0.6)}),
			Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3, 0.55), NumberSequenceKeypoint.new(1, 1)})})
		emitter(holder, {Name = "Embers", Color = ColorSequence.new(fx.Hot, fx.Main), Rate = 6, Lifetime = NumberRange.new(1, 1.8), Speed = NumberRange.new(s * 0.1, s * 0.3),
			SpreadAngle = Vector2.new(180, 180), Acceleration = Vector3.new(0, s * 0.3, 0),
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, s * 0.07), NumberSequenceKeypoint.new(1, 0)})})
	elseif mutation == "Frozen" then
		-- quatre éclats de glace en orbite, neige qui tombe dessus, brume froide au sol
		for i = 1, 4 do
			orbiter(root, "Ice" .. i, {Radius = s * 0.78, Height = size.Y * (0.05 + (i % 2) * 0.25), Speed = 1.8, Phase = i * math.pi / 2, Tilt = 0.2,
				Width = s * 0.1, Life = 0.6, Color = i % 2 == 0 and fx.Hot or fx.Main})
		end
		local top = Instance.new("Attachment")
		top.Name = "Snow"
		top.Position = Vector3.new(0, size.Y * 0.7 + s * 0.3, 0)
		top.Parent = root
		emitter(top, {Name = "Snowflakes", Color = ColorSequence.new(Color3.new(1, 1, 1)), LightEmission = 0.4, Rate = 10, Lifetime = NumberRange.new(1.4, 2),
			EmissionDirection = Enum.NormalId.Bottom, Speed = NumberRange.new(s * 0.3, s * 0.5), SpreadAngle = Vector2.new(40, 40), RotSpeed = NumberRange.new(-60, 60),
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, s * 0.08), NumberSequenceKeypoint.new(1, s * 0.05)})})
		local foot = Instance.new("Attachment")
		foot.Name = "FrostMist"
		foot.Position = Vector3.new(0, -size.Y * 0.42, 0)
		foot.Parent = root
		emitter(foot, {Name = "Mist", Texture = "rbxasset://textures/particles/smoke_main.dds", LightEmission = 0.4, Color = ColorSequence.new(rgb(230, 248, 255), rgb(170, 220, 255)),
			Rate = 5, Lifetime = NumberRange.new(1.6, 2.4), Speed = NumberRange.new(s * 0.05, s * 0.12), SpreadAngle = Vector2.new(180, 5), RotSpeed = NumberRange.new(-15, 15),
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, s * 0.3), NumberSequenceKeypoint.new(1, s * 0.55)}),
			Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3, 0.5), NumberSequenceKeypoint.new(1, 1)})})
	elseif mutation == "Hacked" then
		-- HACKED (event HACKER) : deux anneaux de données qui tournent très vite (croisés), du code vert qui monte en colonnes,
		-- des étincelles de bug, et un panneau holographique "</>" qui clignote au-dessus (HackerEventClient le fait scintiller)
		for i = 1, 2 do
			orbiter(root, "Data" .. i, {Radius = s * 0.72, Height = size.Y * (i == 1 and 0.15 or -0.1), Speed = i == 1 and 5.5 or -4.5, Phase = i * math.pi,
				Tilt = i == 1 and 0.55 or -0.55, Width = s * 0.06, Life = 0.5, Color = i == 1 and fx.Main or fx.Hot})
		end
		local foot = Instance.new("Attachment")
		foot.Name = "HackCode"
		foot.Position = Vector3.new(0, -size.Y * 0.45, 0)
		foot.Parent = root
		emitter(foot, {Name = "Code", Color = ColorSequence.new(fx.Hot, fx.Main), Rate = 14, Lifetime = NumberRange.new(0.9, 1.5), EmissionDirection = Enum.NormalId.Top,
			Speed = NumberRange.new(s * 0.35, s * 0.7), SpreadAngle = Vector2.new(4, 4), Shape = Enum.ParticleEmitterShape.Disc, ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume,
			Squash = NumberSequence.new(2.2), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, s * 0.05), NumberSequenceKeypoint.new(1, s * 0.03)}),
			Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(0.7, 0.3), NumberSequenceKeypoint.new(1, 1)})})
		foot.Orientation = Vector3.new(0, 0, 0)
		emitter(holder, {Name = "Glitch", Color = ColorSequence.new(Color3.new(1, 1, 1), fx.Main), Rate = 5, Lifetime = NumberRange.new(0.08, 0.2),
			Speed = NumberRange.new(0, 0), Shape = Enum.ParticleEmitterShape.Box, Rotation = NumberRange.new(0, 0), LightEmission = 1, Squash = NumberSequence.new(-1.5),
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, s * 0.18), NumberSequenceKeypoint.new(1, s * 0.12)})})
		local holo = Instance.new("BillboardGui")
		holo.Name = "HackHolo"
		holo.Size = UDim2.fromScale(s * 0.45 + 1, s * 0.25 + 0.6)
		holo.StudsOffset = Vector3.new(0, size.Y * 0.5 + s * 0.28, 0)
		holo.LightInfluence = 0
		holo.MaxDistance = 90 + s * 4
		local code = Instance.new("TextLabel")
		code.Name = "Code"
		code.BackgroundTransparency = 1
		code.Size = UDim2.fromScale(1, 1)
		code.Font = Enum.Font.Code
		code.Text = "</>"
		code.TextScaled = true
		code.TextColor3 = fx.Main
		local st = Instance.new("UIStroke")
		st.Thickness = 2
		st.Color = rgb(0, 40, 10)
		st.Parent = code
		code.Parent = holo
		holo.Parent = root
		CollectionService:AddTag(code, "HackHolo")
	end
end

function M.MutationFx(model, mutation)
	local root = model.PrimaryPart
	local colors = mutation and SPARKLES[mutation]
	if not root or not colors or root:FindFirstChild("MutationFx") then return end
	local _, size = model:GetBoundingBox()
	local s = math.max(size.X, size.Y, size.Z)
	local holder = Instance.new("Attachment")
	holder.Name = "MutationFx"
	holder.Parent = root
	local sparkle = Instance.new("ParticleEmitter")
	sparkle.Name = "Sparkles"
	sparkle.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	sparkle.Color = colors
	sparkle.LightEmission = 0.9
	sparkle.Rate = mutation == "Like" and 10 or 6
	sparkle.Lifetime = NumberRange.new(0.8, 1.5)
	sparkle.Speed = NumberRange.new(s * 0.25, s * 0.6)
	sparkle.SpreadAngle = Vector2.new(180, 180)
	sparkle.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, s * 0.16), NumberSequenceKeypoint.new(1, 0)})
	sparkle.Parent = holder
	if EVENT_FX[mutation] then
		eventFx(model, root, holder, mutation, s, size)
		return
	end
	if mutation ~= "Like" then return end

	-- LIKE (event concert) : trois projecteurs de scène braqués sur le modèle, des cœurs qui montent, une lueur rose.
	-- Les projecteurs sont des Beam accrochés au modèle : ils le suivent. MutationFxClient les fait balayer.
	local foot = Instance.new("Attachment")
	foot.Name = "SpotTarget"
	foot.Position = Vector3.new(0, -size.Y * 0.35, 0)
	foot.Parent = root
	for i, color in {rgb(255, 80, 170), rgb(90, 210, 255), rgb(255, 225, 90)} do
		local angle = (i - 1) * math.pi * 2 / 3
		local lamp = Instance.new("Attachment")
		lamp.Name = "Spot" .. i
		lamp.Position = Vector3.new(math.sin(angle) * s * 1.1, s * 1.9, math.cos(angle) * s * 1.1)
		lamp:SetAttribute("Home", lamp.Position)
		lamp:SetAttribute("Phase", i * 2.1)
		lamp.Parent = root
		CollectionService:AddTag(lamp, "LikeSpot")
		local beam = Instance.new("Beam")
		beam.Attachment0, beam.Attachment1 = lamp, foot
		beam.Width0, beam.Width1 = s * 0.12, s * 1.1
		beam.FaceCamera = true
		beam.Color = ColorSequence.new(color)
		beam.LightEmission, beam.LightInfluence = 1, 0
		beam.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(0.8, 0.75), NumberSequenceKeypoint.new(1, 1)})
		beam.Parent = lamp
	end
	local hearts = Instance.new("ParticleEmitter")
	hearts.Name = "Hearts"
	hearts.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	hearts.Color = ColorSequence.new(rgb(255, 90, 160))
	hearts.LightEmission = 0.6
	hearts.Rate = 2.5
	hearts.Lifetime = NumberRange.new(1.4, 2.2)
	hearts.Speed = NumberRange.new(s * 0.5, s * 0.9)
	hearts.SpreadAngle = Vector2.new(25, 25)
	hearts.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.2, s * 0.22), NumberSequenceKeypoint.new(1, s * 0.1)})
	hearts.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.7, 0.2), NumberSequenceKeypoint.new(1, 1)})
	hearts.Parent = holder
	local glow = Instance.new("PointLight")
	glow.Name = "LikeGlow"
	glow.Color, glow.Range, glow.Brightness, glow.Shadows = rgb(255, 110, 190), math.clamp(s * 3, 8, 40), 1.4, false
	glow.Parent = root
end

return M

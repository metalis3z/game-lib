-- SkyEventsServer : trois events du ciel (commande admin StartSkyEvent, ce serveur ou tous les serveurs, durée au choix)
--   METEOR SHOWER : des météores en studs tombent sur les zones d'œufs (cercle rouge au sol avant l'impact, explosion,
--                   cratère). Un œuf touché peut prendre la mutation COSMIC.
--   THUNDERSTORM  : des nuages d'orage dérivent au-dessus des zones (pluie), la foudre frappe les œufs -> mutation STORM.
--   UFO INVASION  : une soucoupe vole de zone en zone et scanne des œufs avec son rayon vert -> mutation ALIEN.
--   CANDY RAIN    : des nuages de barbe à papa dérivent au-dessus des zones et lâchent des bonbons sur les œufs -> CANDY.
--   BLOOD MOON    : une lune rouge géante se lève au sud, des chauves-souris en plongent vers les œufs -> BLOOD.
--   BLIZZARD      : il neige sur la map, un esprit de givre (flocon géant) gèle des œufs de zone en zone -> FROZEN.
--   HACKER ATTACK : un drone-ordinateur (tête de mort sur l'écran) scanne chaque zone et envoie un rayon de données sur
--                   TOUS ses œufs. Chaque œuf n'a qu'UN essai : 1 % de chance de prendre la mutation HACKED (x5).
-- Les trois mutations donnent x4 de revenu (EggConfig.Mutations) ; l'œuf les garde, l'animal qui en sort aussi
-- (EggZoneServer -> PetServer), avec un effet autour de lui (TraitDeco.MutationFx).
-- Modèles : ReplicatedStorage.SkyEvents.Models (Meteor, StormCloud, Ufo). Fin de l'event : attribut <Event>EventEnd de
-- ReplicatedStorage (HUD côté client : SkyEventsClient).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local CollectionService = game:GetService("CollectionService")

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local Config = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local TraitDeco = require(ReplicatedStorage.EggSystem:WaitForChild("TraitDeco"))
local models = ReplicatedStorage:WaitForChild("SkyEvents"):WaitForChild("Models")
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local startRemote = remotes:WaitForChild("StartSkyEvent")
local announceRemote = remotes:WaitForChild("BroadcastAnnounce")
local notifyRemote = ReplicatedStorage.EggSystem:WaitForChild("Remotes"):WaitForChild("Notify")

------------------------------------------------------------------ RÉGLAGES
local TOPIC = "AdminSkyEvent"
local MIN_DURATION, MAX_DURATION = 10, 86400
local rgb = Color3.fromRGB
local EVENTS = {
	Meteor = {Mutation = "Cosmic", Attribute = "MeteorEventEnd", Title = "METEOR SHOWER", Label = "☄ COSMIC ☄", Color = rgb(170, 150, 255),
		Announce = "METEOR SHOWER! Meteors are falling on the egg zones for %s. A hit egg can get the x4 COSMIC trait!",
		Chance = 0.2, SplashChance = 0.2},     -- œuf visé / œufs autour de l'impact (50 %)
	Storm = {Mutation = "Storm", Attribute = "StormEventEnd", Title = "THUNDERSTORM", Label = "⚡ STORM ⚡", Color = rgb(120, 220, 255),
		Announce = "THUNDERSTORM! Lightning strikes the egg zones for %s. A struck egg can get the x4 STORM trait!",
		Chance = 0.2},
	Ufo = {Mutation = "Alien", Attribute = "UfoEventEnd", Title = "UFO INVASION", Label = "🛸 ALIEN 🛸", Color = rgb(110, 255, 120),
		Announce = "UFO INVASION! A flying saucer is scanning eggs for %s. A scanned egg can get the x4 ALIEN trait!",
		Chance = 0.2},
	Candy = {Mutation = "Candy", Attribute = "CandyEventEnd", Title = "CANDY RAIN", Label = "🍬 CANDY 🍬", Color = rgb(255, 130, 210),
		Announce = "CANDY RAIN! Cotton candy clouds drop candies on the egg zones for %s. A hit egg can get the x4 CANDY trait!",
		Chance = 0.2},
	BloodMoon = {Mutation = "Blood", Attribute = "BloodMoonEventEnd", Title = "BLOOD MOON", Label = "🦇 BLOOD 🦇", Color = rgb(255, 70, 80),
		Announce = "BLOOD MOON! Bats are diving on the egg zones for %s. A bitten egg can get the x4 BLOOD trait!",
		Chance = 0.2},
	Blizzard = {Mutation = "Frozen", Attribute = "BlizzardEventEnd", Title = "BLIZZARD", Label = "❄ FROZEN ❄", Color = rgb(170, 230, 255),
		Announce = "BLIZZARD! The Frost Spirit is freezing eggs for %s. A frozen egg can get the x4 FROZEN trait!",
		Chance = 0.2},
	Hacker = {Mutation = "Hacked", Attribute = "HackerEventEnd", Title = "HACKER ATTACK", Label = "💻 HACKED 💻", Color = rgb(40, 255, 110),
		Announce = "SYSTEM HACKED for %s! Every minute a hacker wave sweeps through ALL the egg zones: every egg it touches has a 10%% chance to get the x5 HACKED trait!",
		WaveEvery = 60, WaveTime = 10, WaveChance = 0.1, ReturnTime = 3, -- (HACKER seulement) toutes les 60 s une vague traverse toutes les zones en 10 s : chaque œuf touché, 10 % de chance
		Chance = 0.2},
}
local METEOR_EVERY = {1.2, 2.4}  -- secondes entre deux météores
local METEOR_FALL = 1.7          -- durée de la chute
local CLOUDS = 3                 -- nuages d'orage en même temps
local STRIKE_EVERY = {1.0, 1.9}  -- secondes entre deux éclairs
local UFO_HOVER = 42             -- hauteur de vol de la soucoupe au-dessus des œufs
local UFO_SPEED = 90             -- studs/s

local rng = Random.new()
local state = {}
for name in EVENTS do state[name] = {Running = false, Stop = false, EndAt = 0} end
local function alive(st) return not st.Stop and workspace:GetServerTimeNow() < st.EndAt end
local function sleep(st, seconds)
	local t = 0
	while t < seconds and alive(st) do t += task.wait() end
end
local function describe(secs)
	secs = math.floor(secs)
	local h, m, s = secs // 3600, (secs % 3600) // 60, secs % 60
	if h > 0 then return string.format("%dh%02dm", h, m) end
	if m > 0 then return string.format("%dm%02ds", m, s) end
	return s .. "s"
end

local fxFolder = workspace:FindFirstChild("SkyEventFx") or Instance.new("Folder")
fxFolder.Name = "SkyEventFx"
fxFolder.Parent = workspace
local function eventFolder(name)
	local f = fxFolder:FindFirstChild(name)
	if not f then
		f = Instance.new("Folder")
		f.Name = name
		f.Parent = fxFolder
	end
	return f
end

------------------------------------------------------------------ EFFETS
-- OPTIMISATION : un effet n'est créé que si un joueur peut le voir (à moins de WATCH studs). Ailleurs, l'event continue
-- (mêmes chances de mutation), mais sans rien construire : beaucoup moins d'objets envoyés à tous les joueurs = moins de lag.
local WATCH = 300
local FX_COUNT = 0.6 -- explosions de particules : 40 % de particules en moins
local function watched(position, radius)
	radius = radius or WATCH
	for _, player in Players:GetPlayers() do
		local character = player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if root and (root.Position - position).Magnitude < radius then return true end
	end
	return false
end
local function fxPart(size, cf, color, material, transparency, shape)
	local p = Instance.new("Part")
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
	if shape then p.Shape = shape end
	p.Material = material or Enum.Material.Neon
	p.Color = color
	p.Transparency = transparency or 0
	p.Size = size
	p.CFrame = cf
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	return p
end

local function burst(position, props, count, life)
	if not watched(position) then return nil end
	if count > 0 then count = math.max(1, math.floor(count * FX_COUNT)) end
	local at = Instance.new("Attachment")
	at.WorldPosition = position
	at.Parent = workspace.Terrain
	local e = Instance.new("ParticleEmitter")
	e.Rate = 0
	e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	for k, v in props do e[k] = v end
	e.Parent = at
	e:Emit(count)
	Debris:AddItem(at, life or 3)
	return e
end

local function shockwave(position, radius, color, time)
	if not watched(position) then return end
	local ring = fxPart(Vector3.new(0.4, 2, 2), CFrame.new(position) * CFrame.Angles(0, 0, math.rad(90)), color, Enum.Material.Neon, 0.25, Enum.PartType.Cylinder)
	ring.Parent = fxFolder
	TweenService:Create(ring, TweenInfo.new(time or 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(0.4, radius * 2, radius * 2), Transparency = 1}):Play()
	Debris:AddItem(ring, (time or 0.6) + 0.1)
end

local function flash(position, color, range, brightness, time)
	if not watched(position) then return end
	local p = fxPart(Vector3.one * 0.2, CFrame.new(position), color, Enum.Material.Neon, 1)
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = color, range, brightness, false
	light.Parent = p
	p.Parent = fxFolder
	TweenService:Create(light, TweenInfo.new(time or 0.4), {Brightness = 0}):Play()
	Debris:AddItem(p, (time or 0.4) + 0.1)
end

local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local function floatText(position, text, color)
	if not watched(position, 250) then return end
	local holder = fxPart(Vector3.one * 0.2, CFrame.new(position), color, Enum.Material.Neon, 1)
	holder.Parent = fxFolder
	local bb = Instance.new("BillboardGui")
	bb.Size = UDim2.fromOffset(240, 50)
	bb.AlwaysOnTop = true
	bb.LightInfluence = 0
	bb.MaxDistance = 250
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.FontFace = FONT
	label.TextScaled = true
	label.Text = text
	label.TextColor3 = color
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 3
	stroke.Parent = label
	label.Parent = bb
	bb.Parent = holder
	TweenService:Create(holder, TweenInfo.new(1.4), {CFrame = CFrame.new(position + Vector3.new(0, 8, 0))}):Play()
	TweenService:Create(label, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1}):Play()
	TweenService:Create(stroke, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1}):Play()
	Debris:AddItem(holder, 1.5)
end

------------------------------------------------------------------ ZONES ET ŒUFS
local function getZones()
	local zones = {}
	for _, c in workspace:GetChildren() do
		if c:IsA("BasePart") and string.find(string.lower(c.Name), "egg zone", 1, true) then table.insert(zones, c) end
	end
	table.sort(zones, function(a, b) return a.Position.X < b.Position.X end)
	return zones
end

local function validEgg(e)
	return e and e.Parent and e:IsA("Model") and e:GetAttribute("EggKey") and e.PrimaryPart and not e:GetAttribute("Hatching")
		and not e:GetAttribute("EventMutation") and not e:GetAttribute("ConcertMutation")
end

-- weighted = true : les œufs lancés par un admin (AdminEgg) comptent 5 fois, ils sont bien plus souvent visés par l'event
local ADMIN_WEIGHT = 5
local function eggsIn(zonePart, weighted)
	local zoneEggs = workspace:FindFirstChild("ZoneEggs")
	local folder = zoneEggs and zoneEggs:FindFirstChild(zonePart.Name)
	local list = {}
	if folder then
		for _, e in folder:GetChildren() do
			if validEgg(e) then
				table.insert(list, e)
				if weighted and e:GetAttribute("AdminEgg") then
					for _ = 2, ADMIN_WEIGHT do table.insert(list, e) end
				end
			end
		end
	end
	return list
end

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
local function groundAt(position)
	local ignore = {fxFolder}
	for _, name in {"ZoneEggs", "PlacedPets", "PlacedEggs"} do
		local f = workspace:FindFirstChild(name)
		if f then table.insert(ignore, f) end
	end
	for _, p in Players:GetPlayers() do if p.Character then table.insert(ignore, p.Character) end end
	rayParams.FilterDescendantsInstances = ignore
	local hit = workspace:Raycast(position + Vector3.new(0, 60, 0), Vector3.new(0, -200, 0), rayParams)
	return hit and hit.Position or position
end

local function eggTop(egg)
	return egg:GetPivot().Position + Vector3.new(0, (egg:GetAttribute("Height") or 3) * 0.5, 0)
end

------------------------------------------------------------------ MUTATION SUR UN ŒUF
local function text(parent, str, pos, size, color, gradient)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Position, l.Size = pos, size
	l.FontFace = FONT
	l.Text = str
	l.TextScaled = true
	l.TextColor3 = color
	local s = Instance.new("UIStroke") s.Thickness = 3 s.Parent = l
	if gradient then
		local g = Instance.new("UIGradient") g.Color = gradient g.Parent = l
		CollectionService:AddTag(g, "AnimatedGradient") -- fait défiler les couleurs (PetClient)
	end
	CollectionService:AddTag(l, "Text3D")
	l.Parent = parent
	return l
end

-- petite fenêtre 3D avec le modèle de l'event (ReplicatedStorage.SkyEvents.Models), cadrée automatiquement ;
-- le client la fait tourner (tag "SpinIcon", MutationIconClient)
local ICON_MODELS = {Cosmic = "Meteor", Storm = "StormCloud", Alien = "Ufo", Candy = "Lollipop", Blood = "Bat", Frozen = "FrostSpirit", Hacked = "HackerDrone"}
local iconModels = ReplicatedStorage:WaitForChild("SkyEvents"):WaitForChild("Models")
local function mutationIcon(parent, mutation, position)
	local template = iconModels:FindFirstChild(ICON_MODELS[mutation] or "")
	if not template then return end
	local view = Instance.new("ViewportFrame")
	view.Name = "MutationIcon"
	-- pastille ronde claire de la couleur de la mutation derrière le modèle (une chauve-souris noire se voit sur un fond sombre)
	local tint = Config.GetMutation(mutation)
	tint = tint and tint.Color or Color3.new(1, 1, 1)
	view.BackgroundColor3 = tint:Lerp(Color3.new(1, 1, 1), 0.55)
	view.BackgroundTransparency = 0.15
	view.Position, view.Size = position, UDim2.fromScale(0.2, 0.62)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0.5, 0)
	corner.Parent = view
	view:SetAttribute("KeepCorners", true)
	local ring = Instance.new("UIStroke")
	ring.Thickness = 2.5
	ring.Color = tint:Lerp(Color3.new(0, 0, 0), 0.45)
	ring.Parent = view
	view.Ambient = rgb(230, 230, 240)
	view.LightColor = rgb(255, 245, 230)
	view.LightDirection = Vector3.new(-0.3, -0.6, 1)
	local ratio = Instance.new("UIAspectRatioConstraint")
	ratio.AspectRatio = 1
	ratio.Parent = view
	-- le modèle et la caméra sont construits par chaque joueur (MutationIconClient) : un modèle posé ici n'arriverait pas
	-- chez les joueurs (streaming), et la caméra d'un ViewportFrame ne se réplique pas
	view:SetAttribute("IconModel", template.Name)
	CollectionService:AddTag(view, "SpinIcon")
	view.Parent = parent
	return view
end

local function applyMutation(egg, ev)
	local root = egg.PrimaryPart
	if not root or not validEgg(egg) then return false end
	if not Config.MutationsAllowed() then return false end -- nuit : aucune nouvelle mutation (vérifié ici, au moment d'écrire)
	local mutation = Config.GetMutation(ev.Mutation)
	egg:SetAttribute("EventMutation", ev.Mutation)
	local height = egg:GetAttribute("Height") or 3
	-- étiquette au-dessus des autres étiquettes de l'œuf
	local base = height * 0.98 + 1.5
	local labelH = 1.5 + height * 0.14
	local y = base + (3 + height * 0.3) / 2 + 0.4 + labelH / 2
	for _, other in {"WitchTraitLabel", "CowboyTraitLabel", "ConcertLabel"} do
		if root:FindFirstChild(other) then y += labelH + 0.3 end
	end
	local bb = Instance.new("BillboardGui")
	bb.Name = "EventMutationLabel"
	bb.Size = UDim2.new(5.5 + height * 0.5, 0, labelH, 0)
	bb.StudsOffsetWorldSpace = Vector3.new(0, y, 0)
	bb.MaxDistance = 120 + height * 6
	bb.LightInfluence = 0
	-- nom de la mutation au milieu, et de chaque côté le modèle 3D de l'event qui tourne (chauve-souris pour BLOOD...) au lieu d'un emoji
	local name = string.match(string.gsub(ev.Label, "[^%w ]", ""), "^%s*(.-)%s*$")
	text(bb, name, UDim2.fromScale(0.2, 0), UDim2.fromScale(0.6, 0.62), Color3.new(1, 1, 1), Config.Gradients[ev.Mutation])
	mutationIcon(bb, ev.Mutation, UDim2.fromScale(0, 0))
	mutationIcon(bb, ev.Mutation, UDim2.fromScale(0.8, 0))
	text(bb, "x" .. (mutation and mutation.Mult or 4) .. " TRAIT", UDim2.fromScale(0, 0.62), UDim2.fromScale(1, 0.38), rgb(120, 255, 140))
	bb.Parent = root
	pcall(TraitDeco.MutationFx, egg, ev.Mutation) -- comètes / arcs / halo autour de l'œuf
	local info = Config.Eggs[egg:GetAttribute("EggKey")]
	local zone = egg.Parent and egg.Parent.Name or "a zone"
	notifyRemote:FireAllClients(string.upper(ev.Mutation) .. " TRAIT! A " .. (info and info.Name or "egg") .. " got x" .. (mutation and mutation.Mult or 4) .. " in the " .. zone .. "!")
	return true
end

-- Révélation d'une mutation, en trois temps :
--   1) charge (0,55 s) : des particules convergent vers l'œuf, une lumière monte, un anneau se resserre
--   2) moment fort : la mutation est écrite À CET INSTANT (applyMutation revérifie l'œuf et la nuit), flash, anneau au sol
--      qui s'élargit, colonne de lumière, gerbe qui se disperse
--   3) fin : texte "xN TRAIT!" qui monte. Les mutations plus rares (multiplicateur plus haut) ont une révélation plus grande.
local REVEAL_CHARGE = 0.55
local function revealMutation(egg, ev)
	if not watched(eggTop(egg)) then applyMutation(egg, ev) return end
	local top = eggTop(egg)
	local height = egg:GetAttribute("Height") or 3
	local mutation = Config.GetMutation(ev.Mutation)
	local mult = mutation and mutation.Mult or 4
	local big = mult >= 5
	-- 1) charge
	local holder = fxPart(Vector3.one * 0.2, CFrame.new(top - Vector3.new(0, height * 0.4, 0)), ev.Color, Enum.Material.Neon, 1)
	holder.Parent = fxFolder
	local charge = Instance.new("ParticleEmitter")
	charge.Texture, charge.LightEmission, charge.LightInfluence = "rbxassetid://1084970835", 1, 0
	charge.Color = ColorSequence.new(Color3.new(1, 1, 1), ev.Color)
	charge.Shape, charge.ShapeInOut, charge.ShapeStyle = Enum.ParticleEmitterShape.Sphere, Enum.ParticleEmitterShapeInOut.Inward, Enum.ParticleEmitterShapeStyle.Surface
	charge.Rate, charge.Lifetime, charge.Speed = 40, NumberRange.new(0.35, 0.45), NumberRange.new(height * 4 + 10, height * 4 + 14)
	charge.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 0.7)})
	charge.Parent = holder
	local sphere = Instance.new("Part")
	sphere.Anchored, sphere.CanCollide, sphere.CanQuery, sphere.CanTouch, sphere.CastShadow = true, false, false, false, false
	sphere.Size = Vector3.one * (height * 4 + 12)
	sphere.CFrame = holder.CFrame
	sphere.Transparency = 1
	sphere.Parent = holder
	charge.Parent = sphere -- la sphère d'émission entoure l'œuf, les particules convergent vers lui
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = ev.Color, 25 + height * 2, 0, false
	light.Parent = holder
	TweenService:Create(light, TweenInfo.new(REVEAL_CHARGE, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Brightness = 5}):Play()
	task.wait(REVEAL_CHARGE)
	charge.Enabled = false
	-- 2) moment fort : on écrit la mutation maintenant (l'œuf a pu être ramassé ou la nuit tomber entre-temps)
	if not applyMutation(egg, ev) then
		TweenService:Create(light, TweenInfo.new(0.3), {Brightness = 0}):Play()
		Debris:AddItem(holder, 0.6)
		return
	end
	top = eggTop(egg)
	flash(top, ev.Color, 50 + height * 3, big and 9 or 6, 0.6)
	TweenService:Create(light, TweenInfo.new(0.8), {Brightness = 0}):Play()
	Debris:AddItem(holder, 1)
	burst(top, {Color = ColorSequence.new(ev.Color, Color3.new(1, 1, 1)), LightEmission = 1, Speed = NumberRange.new(14, 34), SpreadAngle = Vector2.new(180, 180), Drag = 2,
		Lifetime = NumberRange.new(0.5, 1.1), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.4), NumberSequenceKeypoint.new(1, 0)})}, big and 110 or 70)
	burst(top, {Texture = "rbxassetid://1084970835", Color = ColorSequence.new(Color3.new(1, 1, 1), ev.Color), LightEmission = 1, Speed = NumberRange.new(6, 14), SpreadAngle = Vector2.new(180, 180), Drag = 2,
		RotSpeed = NumberRange.new(-180, 180), Lifetime = NumberRange.new(0.8, 1.3), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(1, 0)})}, big and 22 or 12)
	-- anneau au sol (texture "light ring") qui s'élargit en tournant
	local ground = top - Vector3.new(0, height, 0) + Vector3.new(0, 0.3, 0)
	for k = 1, big and 2 or 1 do
		local ringPart = fxPart(Vector3.new(4, 0.1, 4), CFrame.new(ground), ev.Color, Enum.Material.Neon, 1)
		local decal = Instance.new("Decal")
		decal.Face, decal.Texture, decal.Color3 = Enum.NormalId.Top, "rbxassetid://8271495905", ev.Color
		decal.Parent = ringPart
		ringPart.Parent = fxFolder
		local r = (10 + height * 2.2) * 2 * (k == 2 and 1.5 or 1)
		TweenService:Create(ringPart, TweenInfo.new(0.7 + k * 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = Vector3.new(r, 0.1, r), CFrame = ringPart.CFrame * CFrame.Angles(0, math.rad(120), 0)}):Play()
		TweenService:Create(decal, TweenInfo.new(0.7 + k * 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1}):Play()
		Debris:AddItem(ringPart, 1.1)
	end
	shockwave(ground, 10 + height * 2, ev.Color)
	-- colonne de lumière : deux Beams (rayons + halo) qui se referment
	local skyPart = fxPart(Vector3.one * 0.2, CFrame.new(top + Vector3.new(0, 110, 0)), ev.Color, Enum.Material.Neon, 1)
	local footPart = fxPart(Vector3.one * 0.2, CFrame.new(ground), ev.Color, Enum.Material.Neon, 1)
	skyPart.Parent, footPart.Parent = fxFolder, fxFolder
	local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
	a0.Parent, a1.Parent = skyPart, footPart
	for i, texture in {"rbxassetid://1084975295", "rbxassetid://4509687978"} do
		local beam = Instance.new("Beam")
		beam.Attachment0, beam.Attachment1 = a0, a1
		beam.Texture, beam.TextureMode, beam.TextureSpeed = texture, Enum.TextureMode.Stretch, 1.5
		beam.FaceCamera, beam.LightEmission, beam.LightInfluence = true, 1, 0
		beam.Color = ColorSequence.new(Color3.new(1, 1, 1), ev.Color)
		beam.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.6, i == 1 and 0.4 or 0.6), NumberSequenceKeypoint.new(1, 0.3)})
		local w = (height * 0.9 + 3) * (i == 1 and 1 or 2.2) * (big and 1.4 or 1)
		beam.Width0, beam.Width1 = w, w
		beam.Parent = skyPart
		TweenService:Create(beam, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Width0 = 0.2, Width1 = 0.2}):Play()
	end
	Debris:AddItem(skyPart, 1)
	Debris:AddItem(footPart, 1)
	-- 3) fin
	floatText(top + Vector3.new(0, height * 0.5, 0), "x" .. mult .. " " .. string.upper(ev.Mutation) .. " TRAIT!", ev.Color)
end

-- tentative sur un œuf : réussite = séquence de révélation de la couleur de l'event, sinon "No luck..."
local function tryEgg(egg, ev, chance, quietMiss)
	if not validEgg(egg) then return end
	if not Config.MutationsAllowed() then return end -- nuit : pas de tirage, pas d'effet qui ferait croire à une mutation
	if rng:NextNumber() < chance then
		task.spawn(revealMutation, egg, ev)
	elseif not quietMiss then
		floatText(eggTop(egg), "No luck...", rgb(220, 220, 220))
	end
end

------------------------------------------------------------------ METEOR SHOWER
local meteorHits
local function dropMeteor(st, ev, ground, target)
	if not watched(ground) then
		task.wait(METEOR_FALL)
		meteorHits(ev, ground, target, 7 * 2)
		return
	end
	local model = models.Meteor:Clone()
	local scale = rng:NextNumber(1.6, 2.6)
	model:ScaleTo(scale)
	local core = model.PrimaryPart
	-- flammes, traînée, lumière
	local fire = Instance.new("ParticleEmitter")
	fire.Texture = "rbxasset://textures/particles/fire_main.dds"
	fire.Color = ColorSequence.new(rgb(255, 220, 120), rgb(255, 80, 20))
	fire.LightEmission = 0.8
	fire.Rate = 70
	fire.Lifetime = NumberRange.new(0.3, 0.6)
	fire.Speed = NumberRange.new(2, 6)
	fire.SpreadAngle = Vector2.new(30, 30)
	fire.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 4 * scale), NumberSequenceKeypoint.new(1, 1 * scale)})
	fire.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1)})
	fire.Parent = core:FindFirstChild("Fire")
	local flames = Instance.new("ParticleEmitter") -- flammes animées (flipbook "Fire1" de ServerStorage["ALL VFX"]["vfx 2 "].Big)
	flames.Texture, flames.FlipbookLayout, flames.FlipbookMode = "rbxassetid://11395089850", Enum.ParticleFlipbookLayout.Grid4x4, Enum.ParticleFlipbookMode.OneShot
	flames.Color = ColorSequence.new(rgb(255, 210, 140), rgb(255, 110, 50))
	flames.LightEmission, flames.Rate = 0.9, 18
	flames.Lifetime = NumberRange.new(0.45, 0.55)
	flames.Speed = NumberRange.new(1, 3)
	flames.RotSpeed, flames.Rotation = NumberRange.new(-60, 60), NumberRange.new(0, 360)
	flames.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 5 * scale), NumberSequenceKeypoint.new(1, 3 * scale)})
	flames.Parent = core:FindFirstChild("Fire")
	local smoke = Instance.new("ParticleEmitter") -- fumée sombre derrière le météore ("SmokeDark1" de la bibliothèque)
	smoke.Texture, smoke.LightEmission = "rbxassetid://10180479311", 0
	smoke.Color = ColorSequence.new(rgb(60, 52, 50), rgb(30, 28, 28))
	smoke.Rate, smoke.Lifetime, smoke.Speed = 14, NumberRange.new(1.2, 1.8), NumberRange.new(0, 2)
	smoke.RotSpeed, smoke.Rotation = NumberRange.new(-30, 30), NumberRange.new(0, 360)
	smoke.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 3 * scale), NumberSequenceKeypoint.new(1, 8 * scale)})
	smoke.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.4), NumberSequenceKeypoint.new(1, 1)})
	smoke.Parent = core
	local trail = Instance.new("Trail")
	trail.Attachment0, trail.Attachment1 = core:FindFirstChild("Trail0"), core:FindFirstChild("Trail1")
	trail.Lifetime = 0.7
	trail.FaceCamera = true
	trail.LightEmission = 1
	trail.Color = ColorSequence.new(rgb(255, 230, 150), rgb(255, 70, 20))
	trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1)})
	trail.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.1)})
	trail.Parent = core
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = rgb(255, 140, 60), 40, 3, false
	light.Parent = core

	-- cercle d'alerte rouge au sol pendant la chute
	local radius = 7 * scale
	local warn = fxPart(Vector3.new(0.3, radius * 2, radius * 2), CFrame.new(ground + Vector3.new(0, 0.2, 0)) * CFrame.Angles(0, 0, math.rad(90)), rgb(255, 60, 40), Enum.Material.Neon, 0.6, Enum.PartType.Cylinder)
	warn.Parent = eventFolder("Meteor")
	local inner = fxPart(Vector3.new(0.35, 1, 1), warn.CFrame, rgb(255, 160, 60), Enum.Material.Neon, 0.3, Enum.PartType.Cylinder)
	inner.Parent = warn
	TweenService:Create(inner, TweenInfo.new(METEOR_FALL, Enum.EasingStyle.Linear), {Size = Vector3.new(0.35, radius * 2, radius * 2)}):Play()

	-- chute en biais depuis le ciel (côté sud), de plus en plus vite, en tournoyant
	local start = ground + Vector3.new(rng:NextNumber(-90, 90), 260, -rng:NextNumber(100, 170))
	local spin = CFrame.Angles(rng:NextNumber(0, 6), rng:NextNumber(0, 6), 0)
	model:PivotTo(CFrame.new(start))
	model.Parent = eventFolder("Meteor")
	local t0 = os.clock()
	while true do
		local k = math.min((os.clock() - t0) / METEOR_FALL, 1)
		local pos = start:Lerp(ground + Vector3.new(0, 2 * scale, 0), k * k)
		model:PivotTo(CFrame.new(pos) * spin * CFrame.Angles(k * 9, k * 5, 0))
		if k >= 1 then break end
		RunService.Heartbeat:Wait()
	end
	model:Destroy()
	warn:Destroy()

	-- IMPACT : explosion, onde de choc, lumière, cratère fumant, éclats de roche
	burst(ground + Vector3.new(0, 2, 0), {Texture = "rbxasset://textures/particles/fire_main.dds", Color = ColorSequence.new(rgb(255, 230, 140), rgb(255, 70, 20)),
		LightEmission = 0.8, Speed = NumberRange.new(15 * scale, 30 * scale), SpreadAngle = Vector2.new(70, 70), EmissionDirection = Enum.NormalId.Top,
		Lifetime = NumberRange.new(0.4, 0.9), Drag = 3, Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 5 * scale), NumberSequenceKeypoint.new(1, 1)}),
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1)})}, 40)
	burst(ground + Vector3.new(0, 2, 0), {Texture = "rbxasset://textures/particles/smoke_main.dds", Color = ColorSequence.new(rgb(90, 80, 76), rgb(50, 46, 44)),
		LightEmission = 0, Speed = NumberRange.new(6 * scale, 14 * scale), SpreadAngle = Vector2.new(80, 80), EmissionDirection = Enum.NormalId.Top,
		Lifetime = NumberRange.new(1.2, 2.2), Drag = 2, RotSpeed = NumberRange.new(-40, 40), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 4 * scale), NumberSequenceKeypoint.new(1, 9 * scale)}),
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1)})}, 22, 4)
	shockwave(ground + Vector3.new(0, 0.4, 0), radius * 2.4, rgb(255, 150, 60), 0.7)
	flash(ground + Vector3.new(0, 6, 0), rgb(255, 150, 70), 70, 8, 0.6)
	-- boule de feu animée (flipbook) et anneau de feu qui s'élargit au sol
	burst(ground + Vector3.new(0, 3 * scale, 0), {Texture = "rbxassetid://11395090403", FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
		Color = ColorSequence.new(rgb(255, 220, 150), rgb(255, 100, 40)), LightEmission = 0.9, Speed = NumberRange.new(2, 6), SpreadAngle = Vector2.new(180, 180),
		Lifetime = NumberRange.new(0.6, 0.6), Rotation = NumberRange.new(0, 360), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 8 * scale), NumberSequenceKeypoint.new(1, 14 * scale)})}, 6, 1.5)
	do
		local ringPart = fxPart(Vector3.new(4, 0.1, 4), CFrame.new(ground + Vector3.new(0, 0.35, 0)), rgb(255, 140, 50), Enum.Material.Neon, 1)
		local decal = Instance.new("Decal")
		decal.Face, decal.Texture, decal.Color3 = Enum.NormalId.Top, "rbxassetid://8271495905", rgb(255, 150, 60)
		decal.Parent = ringPart
		ringPart.Parent = eventFolder("Meteor")
		TweenService:Create(ringPart, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = Vector3.new(radius * 5, 0.1, radius * 5)}):Play()
		TweenService:Create(decal, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1}):Play()
		Debris:AddItem(ringPart, 0.7)
	end
	local crater = fxPart(Vector3.new(0.3, radius * 1.5, radius * 1.5), CFrame.new(ground + Vector3.new(0, 0.12, 0)) * CFrame.Angles(0, 0, math.rad(90)), rgb(40, 32, 30), Enum.Material.Slate, 0.1, Enum.PartType.Cylinder)
	crater.Parent = eventFolder("Meteor")
	local glow = fxPart(Vector3.new(0.32, radius * 0.7, radius * 0.7), crater.CFrame, rgb(255, 110, 30), Enum.Material.Neon, 0.2, Enum.PartType.Cylinder)
	glow.Parent = crater
	TweenService:Create(crater, TweenInfo.new(6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1}):Play()
	TweenService:Create(glow, TweenInfo.new(3), {Transparency = 1}):Play()
	Debris:AddItem(crater, 6.2)
	for _ = 1, 3 do -- éclats de roche qui volent puis retombent (optimisation : 3 au lieu de 6)
		local chunk = fxPart(Vector3.one * rng:NextNumber(0.8, 1.6) * scale * 0.6, CFrame.new(ground + Vector3.new(0, 2, 0)), rgb(80, 64, 56), Enum.Material.Plastic, 0)
		chunk.Anchored = false
		chunk.AssemblyLinearVelocity = Vector3.new(rng:NextNumber(-30, 30), rng:NextNumber(40, 70), rng:NextNumber(-30, 30))
		chunk.AssemblyAngularVelocity = Vector3.new(rng:NextNumber(-10, 10), rng:NextNumber(-10, 10), rng:NextNumber(-10, 10))
		chunk.Parent = eventFolder("Meteor")
		Debris:AddItem(chunk, 2.2)
	end

	meteorHits(ev, ground, target, radius)
end
-- œufs touchés : celui visé, et ceux tout près de l'impact
function meteorHits(ev, ground, target, radius)
	if target and validEgg(target) then tryEgg(target, ev, ev.Chance) end
	local zoneEggs = workspace:FindFirstChild("ZoneEggs")
	if zoneEggs then
		for _, folder in zoneEggs:GetChildren() do
			for _, egg in folder:GetChildren() do
				if egg ~= target and validEgg(egg) and (egg:GetPivot().Position - ground).Magnitude < radius * 1.4 then
					tryEgg(egg, ev, ev.SplashChance, true)
				end
			end
		end
	end
end

local function runMeteor(st, ev)
	local zones = getZones()
	if #zones == 0 then return end
	while alive(st) do
		local zone = zones[rng:NextInteger(1, #zones)]
		local eggs = eggsIn(zone, true)
		local target, ground
		if #eggs > 0 and rng:NextNumber() < 0.85 then
			target = eggs[rng:NextInteger(1, #eggs)]
			ground = groundAt(target:GetPivot().Position)
		else
			local top = zone.Position + Vector3.new(rng:NextNumber(-0.4, 0.4) * zone.Size.X, zone.Size.Y / 2, rng:NextNumber(-0.4, 0.4) * zone.Size.Z)
			ground = groundAt(top)
		end
		task.spawn(dropMeteor, st, ev, ground, target)
		sleep(st, rng:NextNumber(METEOR_EVERY[1], METEOR_EVERY[2]))
	end
	sleep(st, 0) -- (les derniers météores finissent leur chute tout seuls)
end

------------------------------------------------------------------ THUNDERSTORM
-- éclair : une chaîne de Beams (cœur blanc + halo coloré, texture d'éclair de la bibliothèque ALL VFX) qui zigzague,
-- avec des ramifications qui partent sur les côtés. Il frappe deux fois en scintillant, puis s'éteint en douceur.
local BOLT_TEXTURE = "rbxassetid://10713705343" -- "stravant's lightning" (ServerStorage["ALL VFX"]["vfx 2 "])
local GLOW_TEXTURE = "rbxassetid://4509687978"  -- "glow"
local function bolt(from, to, color)
	local holder = fxPart(Vector3.one * 0.1, CFrame.new(), color, Enum.Material.Neon, 1)
	holder.Name = "Bolt"
	local beams = {}
	local function segment(a, b, width)
		local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
		a0.WorldPosition, a1.WorldPosition = a, b
		a0.Parent, a1.Parent = holder, holder
		for layer = 1, 2 do
			local beam = Instance.new("Beam")
			beam.Attachment0, beam.Attachment1 = a0, a1
			beam.FaceCamera, beam.LightEmission, beam.LightInfluence, beam.Segments = true, 1, 0, 1
			if layer == 1 then
				beam.Texture, beam.Width0, beam.Width1 = BOLT_TEXTURE, width, width * 0.85
				beam.Color = ColorSequence.new(Color3.new(1, 1, 1))
			else
				beam.Texture, beam.Width0, beam.Width1 = GLOW_TEXTURE, width * 4, width * 3.4
				beam.Color = ColorSequence.new(color)
			end
			beam.TextureMode, beam.TextureLength = Enum.TextureMode.Stretch, 1
			beam.Parent = holder
			table.insert(beams, {Beam = beam, Base = layer == 1 and 0 or 0.35})
		end
	end
	local function chain(a, b, width, depth)
		local n = math.max(3, math.floor((b - a).Magnitude / 9))
		local dir = (b - a)
		local side1 = dir:Cross(Vector3.new(0, 0, 1)).Unit
		if side1 ~= side1 then side1 = Vector3.new(1, 0, 0) end
		local side2 = dir:Cross(side1).Unit
		local prev = a
		for i = 1, n do
			local k = i / n
			local jitter = math.sin(k * math.pi) * (depth == 0 and 7 or 3)
			local point = i == n and b or a:Lerp(b, k) + side1 * rng:NextNumber(-jitter, jitter) + side2 * rng:NextNumber(-jitter, jitter)
			segment(prev, point, width * (1 - k * 0.35))
			-- ramification
			if depth < 2 and i < n - 1 and rng:NextNumber() < (depth == 0 and 0.45 or 0.25) then
				local len = dir.Magnitude * rng:NextNumber(0.15, 0.3) / (depth + 1)
				local branchDir = (dir.Unit + side1 * rng:NextNumber(-1.2, 1.2) + side2 * rng:NextNumber(-1.2, 1.2)).Unit
				chain(point, point + branchDir * len, width * 0.5, depth + 1)
			end
			prev = point
		end
	end
	chain(from, to, 2.2, 0)
	holder.Parent = fxFolder
	-- scintillement : frappe, coupure, deuxième frappe, puis fondu
	local function setAlpha(alpha)
		for _, entry in beams do entry.Beam.Transparency = NumberSequence.new(math.clamp(entry.Base + alpha * (1 - entry.Base), 0, 1)) end
	end
	task.spawn(function()
		setAlpha(0)
		task.wait(0.06) setAlpha(0.85)
		task.wait(0.05) setAlpha(0)
		task.wait(0.08)
		for i = 1, 8 do setAlpha(i / 8) task.wait(0.03) end
		holder:Destroy()
	end)
	ReplicatedStorage:SetAttribute("LightningAt", workspace:GetServerTimeNow()) -- le ciel flashe chez les joueurs (SkyEventsClient)
end

-- impact de foudre au sol : anneau électrique qui s'étend (texture "lightning ring") et gerbe d'étincelles
local function lightningImpact(position, color)
	local ring = fxPart(Vector3.new(4, 0.1, 4), CFrame.new(position + Vector3.new(0, 0.3, 0)), color, Enum.Material.Neon, 1)
	local decal = Instance.new("Decal")
	decal.Face, decal.Texture, decal.Color3 = Enum.NormalId.Top, "rbxassetid://7150933366", color
	decal.Parent = ring
	ring.Parent = fxFolder
	TweenService:Create(ring, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(26, 0.1, 26), CFrame = ring.CFrame * CFrame.Angles(0, math.rad(90), 0)}):Play()
	TweenService:Create(decal, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1}):Play()
	Debris:AddItem(ring, 0.5)
	burst(position, {Texture = "rbxasset://textures/particles/sparkles_main.dds", Color = ColorSequence.new(Color3.new(1, 1, 1), color), LightEmission = 1, Drag = 3,
		Speed = NumberRange.new(20, 45), SpreadAngle = Vector2.new(80, 80), EmissionDirection = Enum.NormalId.Top, Acceleration = Vector3.new(0, -30, 0),
		Lifetime = NumberRange.new(0.3, 0.7), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.7), NumberSequenceKeypoint.new(1, 0)})}, 35)
end

local function spawnCloud(zone, folder)
	local cloud = models.StormCloud:Clone()
	cloud:ScaleTo(1.5)
	local home = Vector3.new(zone.Position.X + rng:NextNumber(-0.25, 0.25) * zone.Size.X, zone.Position.Y + zone.Size.Y / 2 + 75, zone.Position.Z + rng:NextNumber(-0.2, 0.2) * zone.Size.Z)
	cloud:PivotTo(CFrame.new(home + Vector3.new(0, 80, 0)))
	cloud.Parent = folder
	-- pluie sous le nuage
	local core = cloud.PrimaryPart
	local rain = Instance.new("ParticleEmitter")
	rain.Name = "Rain"
	rain.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	rain.Color = ColorSequence.new(rgb(170, 210, 255))
	rain.LightEmission = 0.3
	rain.Shape = Enum.ParticleEmitterShape.Box
	rain.EmissionDirection = Enum.NormalId.Bottom
	rain.Rate = 90
	rain.Lifetime = NumberRange.new(0.9, 1.1)
	rain.Speed = NumberRange.new(70, 80)
	rain.Size = NumberSequence.new(0.35)
	rain.Squash = NumberSequence.new(3)
	rain.Transparency = NumberSequence.new(0.35)
	rain.Parent = core
	local flashLight = Instance.new("PointLight")
	flashLight.Name = "Flash"
	flashLight.Color, flashLight.Range, flashLight.Brightness, flashLight.Shadows = rgb(170, 230, 255), 60, 0, false
	flashLight.Parent = core
	return {Model = cloud, Zone = zone, Home = home, Pos = home + Vector3.new(0, 80, 0), Phase = rng:NextNumber(0, 6), Light = flashLight, Moved = os.clock()}
end

local function runStorm(st, ev)
	local zones = getZones()
	if #zones == 0 then return end
	local folder = eventFolder("Storm")
	local clouds = {}
	local function freeZone()
		local taken = {}
		for _, c in clouds do taken[c.Zone] = true end
		local options = {}
		for _, z in zones do if not taken[z] then table.insert(options, z) end end
		if #options == 0 then options = zones end
		return options[rng:NextInteger(1, #options)]
	end
	for _ = 1, math.min(CLOUDS, #zones) do table.insert(clouds, spawnCloud(freeZone(), folder)) end
	-- les nuages descendent, dérivent doucement, et changent de zone de temps en temps
	local conn = RunService.Heartbeat:Connect(function(dt)
		local t = os.clock()
		for _, c in clouds do
			if c.Model.Parent then
				local goal = c.Home + Vector3.new(math.sin(t * 0.18 + c.Phase) * c.Zone.Size.X * 0.22, math.sin(t * 0.5 + c.Phase) * 1.5, math.cos(t * 0.13 + c.Phase) * 10)
				c.Pos = c.Pos:Lerp(goal, math.min(dt * 0.9, 1))
				c.Model:PivotTo(CFrame.new(c.Pos) * CFrame.Angles(0, math.sin(t * 0.1 + c.Phase) * 0.2, 0))
			end
		end
	end)
	while alive(st) do
		sleep(st, rng:NextNumber(STRIKE_EVERY[1], STRIKE_EVERY[2]))
		if not alive(st) then break end
		local c = clouds[rng:NextInteger(1, #clouds)]
		if os.clock() - c.Moved > rng:NextNumber(25, 40) then -- le nuage part au-dessus d'une autre zone
			c.Zone = freeZone()
			c.Home = Vector3.new(c.Zone.Position.X + rng:NextNumber(-0.25, 0.25) * c.Zone.Size.X, c.Home.Y, c.Zone.Position.Z + rng:NextNumber(-0.2, 0.2) * c.Zone.Size.Z)
			c.Moved = os.clock()
		else
			-- éclair : sur un œuf sous le nuage si possible, sinon dans le vide de la zone
			local from = c.Pos - Vector3.new(0, 8, 0)
			local eggs = eggsIn(c.Zone)
			local best, bestD
			for _, egg in eggs do
				local d = (Vector3.new(egg:GetPivot().Position.X, 0, egg:GetPivot().Position.Z) - Vector3.new(from.X, 0, from.Z)).Magnitude + rng:NextNumber(0, 30)
				if not bestD or d < bestD then best, bestD = egg, d end
			end
			local to = best and eggTop(best) or groundAt(from + Vector3.new(rng:NextNumber(-25, 25), 0, rng:NextNumber(-25, 25)))
			bolt(from, to, ev.Color)
			c.Light.Brightness = 6
			TweenService:Create(c.Light, TweenInfo.new(0.4), {Brightness = 0}):Play()
			flash(to + Vector3.new(0, 3, 0), ev.Color, 45, 7, 0.5)
			burst(to, {Color = ColorSequence.new(Color3.new(1, 1, 1), ev.Color), LightEmission = 1, Speed = NumberRange.new(15, 35), SpreadAngle = Vector2.new(180, 180),
				Lifetime = NumberRange.new(0.2, 0.5), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})}, 30)
			shockwave(to - Vector3.new(0, best and (best:GetAttribute("Height") or 3) or 0, 0) + Vector3.new(0, 0.3, 0), 12, ev.Color, 0.45)
			lightningImpact(best and (best:GetPivot().Position - Vector3.new(0, (best:GetAttribute("Height") or 3) * 0.5, 0)) or to, ev.Color)
			if best then tryEgg(best, ev, ev.Chance) end
		end
	end
	conn:Disconnect()
	-- fin : les nuages remontent et s'en vont
	for _, c in clouds do
		local from = c.Pos
		task.spawn(function()
			local t0 = os.clock()
			local rain = c.Model.PrimaryPart and c.Model.PrimaryPart:FindFirstChild("Rain")
			if rain then rain.Enabled = false end
			while os.clock() - t0 < 2 and c.Model.Parent do
				local k = (os.clock() - t0) / 2
				c.Model:PivotTo(CFrame.new(from + Vector3.new(0, k * k * 160, 0)))
				RunService.Heartbeat:Wait()
			end
			c.Model:Destroy()
		end)
	end
	task.wait(2.1)
end

------------------------------------------------------------------ UFO INVASION
local function runUfo(st, ev)
	local zones = getZones()
	if #zones == 0 then return end
	local folder = eventFolder("Ufo")
	local ufo = models.Ufo:Clone()
	local index = rng:NextInteger(1, #zones)
	local first = zones[index]
	local floorY = first.Position.Y + first.Size.Y / 2
	local pos = Vector3.new(first.Position.X, floorY + 260, first.Position.Z)
	local spin, tilt = 0, 0
	local beam -- rayon tracteur
	-- la soucoupe est un assemblage physique (pièces soudées à Root) guidé par AlignPosition / AlignOrientation :
	-- les joueurs voient un mouvement interpolé et fluide, au lieu d'un modèle ancré téléporté à chaque image
	ufo:PivotTo(CFrame.new(pos))
	local root = ufo.PrimaryPart
	for _, p in ufo:GetDescendants() do
		if p:IsA("BasePart") then
			p.Anchored, p.CanCollide, p.CanTouch, p.CanQuery, p.Massless = false, false, false, false, p ~= root
			if p ~= root then local w = Instance.new("WeldConstraint") w.Part0, w.Part1 = root, p w.Parent = p end
		end
	end
	local att = Instance.new("Attachment") att.Parent = root
	local align = Instance.new("AlignPosition")
	align.Mode, align.Attachment0, align.MaxForce, align.MaxVelocity, align.Responsiveness = Enum.PositionAlignmentMode.OneAttachment, att, math.huge, math.huge, 40
	align.Position = pos
	align.Parent = root
	local orient = Instance.new("AlignOrientation")
	orient.Mode, orient.Attachment0, orient.MaxTorque, orient.MaxAngularVelocity, orient.Responsiveness = Enum.OrientationAlignmentMode.OneAttachment, att, math.huge, math.huge, 30
	orient.Parent = root
	ufo.Parent = folder
	pcall(function() root:SetNetworkOwner(nil) end)
	local conn = RunService.Heartbeat:Connect(function(dt)
		spin += dt * 1.6
		local bob = math.sin(os.clock() * 2) * 1.2
		align.Position = pos + Vector3.new(0, bob, 0)
		orient.CFrame = CFrame.Angles(tilt, 0, 0) * CFrame.Angles(0, spin, 0)
	end)
	local function flyTo(dest)
		local from = pos
		local dist = (dest - from).Magnitude
		local time = math.clamp(dist / UFO_SPEED, 0.6, 6)
		local t0 = os.clock()
		while alive(st) do
			local k = math.min((os.clock() - t0) / time, 1)
			local e = k * k * (3 - 2 * k)
			pos = from:Lerp(dest, e)
			tilt = math.sin(k * math.pi) * 0.18 -- penche en avant pendant le vol
			if k >= 1 then break end
			RunService.Heartbeat:Wait()
		end
		tilt = 0
	end
	-- rayon tracteur : deux Beams en cône (rayons de lumière + halo) avec un dégradé de transparence, un cercle lumineux
	-- qui tourne au sol, un projecteur et des particules qui montent. Il s'ouvre et se referme en douceur.
	local function setBeam(on, groundY)
		if beam then
			local old = beam
			beam = nil
			for _, b in old:GetDescendants() do
				if b:IsA("Beam") then TweenService:Create(b, TweenInfo.new(0.3), {Width1 = 0.5}):Play() end
				if b:IsA("Decal") then TweenService:Create(b, TweenInfo.new(0.3), {Transparency = 1}):Play() end
			end
			Debris:AddItem(old, 0.35)
		end
		if not on then return end
		beam = Instance.new("Model")
		beam.Name = "TractorBeam"
		local topPos = pos - Vector3.new(0, 4, 0)
		local top = fxPart(Vector3.one * 0.2, CFrame.new(topPos), ev.Color, Enum.Material.Neon, 1)
		top.Parent = beam
		local bottom = fxPart(Vector3.new(20, 0.1, 20), CFrame.new(pos.X, groundY + 0.25, pos.Z), ev.Color, Enum.Material.Neon, 1)
		bottom.Parent = beam
		local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
		a0.Parent, a1.Parent = top, bottom
		for i, texture in {"rbxassetid://1084975295", "rbxassetid://4509687978"} do
			local b = Instance.new("Beam")
			b.Attachment0, b.Attachment1 = a0, a1
			b.Texture, b.TextureMode, b.TextureSpeed, b.TextureLength = texture, Enum.TextureMode.Stretch, i == 1 and 0.8 or -0.3, 1
			b.FaceCamera, b.Segments, b.LightEmission, b.LightInfluence = true, 12, 1, 0
			b.Color = ColorSequence.new(Color3.new(1, 1, 1):Lerp(ev.Color, 0.4), ev.Color)
			b.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, i == 1 and 0.05 or 0.3), NumberSequenceKeypoint.new(0.7, i == 1 and 0.35 or 0.55), NumberSequenceKeypoint.new(1, 0.75)})
			b.Brightness = 2.5 -- reste lisible en plein jour
			b.Width0, b.Width1 = 3, 0.5
			b.Parent = top
			TweenService:Create(b, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Width1 = i == 1 and 18 or 22}):Play()
		end
		local ring = Instance.new("Decal")
		ring.Face, ring.Texture, ring.Color3, ring.Transparency = Enum.NormalId.Top, "rbxassetid://8271495905", ev.Color, 0.15
		ring.Parent = bottom
		TweenService:Create(bottom, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {CFrame = bottom.CFrame * CFrame.Angles(0, math.pi, 0)}):Play()
		local spot = Instance.new("SpotLight")
		spot.Face, spot.Angle, spot.Range, spot.Brightness, spot.Color, spot.Shadows = Enum.NormalId.Bottom, 40, 70, 4, ev.Color, false
		spot.Parent = top
		beam.Parent = folder
	end
	-- arrivée : descend du ciel, flash et onde d'énergie quand elle se stabilise
	flyTo(Vector3.new(first.Position.X, floorY + UFO_HOVER + 10, first.Position.Z))
	flash(pos, ev.Color, 90, 6, 0.8)
	shockwave(pos - Vector3.new(0, 4, 0), 45, ev.Color, 0.9)
	local dir = 1
	while alive(st) do
		local zone = zones[index]
		local zoneFloor = zone.Position.Y + zone.Size.Y / 2
		flyTo(Vector3.new(zone.Position.X + rng:NextNumber(-0.2, 0.2) * zone.Size.X, zoneFloor + UFO_HOVER + 10, zone.Position.Z))
		local eggs = eggsIn(zone, true)
		for _ = 1, math.min(rng:NextInteger(2, 3), #eggs) do
			if not alive(st) then break end
			local egg = table.remove(eggs, rng:NextInteger(1, #eggs))
			if validEgg(egg) then
				local at = egg:GetPivot().Position
				flyTo(Vector3.new(at.X, at.Y + UFO_HOVER, at.Z))
				if not alive(st) then break end
				-- scan : rayon vert, l'œuf est entouré de particules qui montent
				local ground = groundAt(at).Y
				setBeam(true, ground)
				local scan = burst(at, {Color = ColorSequence.new(ev.Color, Color3.new(1, 1, 1)), LightEmission = 1, Rate = 40, EmissionDirection = Enum.NormalId.Top,
					Speed = NumberRange.new(10, 18), SpreadAngle = Vector2.new(25, 25), Lifetime = NumberRange.new(1, 1.6),
					Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.8), NumberSequenceKeypoint.new(1, 0)})}, 0, 3)
				flash(at + Vector3.new(0, 4, 0), ev.Color, 30, 3, 2)
				sleep(st, 1.9)
				if scan then scan.Enabled = false end
				setBeam(false)
				tryEgg(egg, ev, ev.Chance)
				sleep(st, 0.5)
			end
		end
		sleep(st, 0.6)
		if #zones > 1 then -- zone suivante (demi-tour au bout de la map)
			if not zones[index + dir] then dir = -dir end
			index += dir
		end
	end
	setBeam(false)
	-- départ : petit flash, puis elle remonte en flèche dans le ciel
	flash(pos, ev.Color, 80, 5, 0.6)
	shockwave(pos - Vector3.new(0, 4, 0), 35, ev.Color, 0.6)
	local from = pos
	local t0 = os.clock()
	while os.clock() - t0 < 1.4 do
		local k = (os.clock() - t0) / 1.4
		pos = from + Vector3.new(0, k * k * 320, 0)
		RunService.Heartbeat:Wait()
	end
	conn:Disconnect()
	ufo:Destroy()
end

------------------------------------------------------------------ CANDY RAIN
local CANDY_COLORS = {rgb(255, 90, 160), rgb(120, 200, 255), rgb(255, 215, 80), rgb(150, 255, 150), rgb(200, 140, 255)}

local function dropCandy(ev, from, to, egg)
	-- un bonbon emballé (cœur recoloré) ou, une fois sur trois, une sucette en spirale
	local lollipop = models:FindFirstChild("Lollipop") and rng:NextNumber() < 0.33
	local candy = (lollipop and models.Lollipop or models.Candy):Clone()
	candy:ScaleTo(lollipop and 1.5 or 1.7)
	local color = CANDY_COLORS[rng:NextInteger(1, #CANDY_COLORS)]
	for _, p in candy:GetChildren() do
		if p.Name == "Tint" then -- bonbon en mesh : on teinte sa texture ; ancien bonbon en blocs : sa couleur
			local look = p:FindFirstChildOfClass("SurfaceAppearance")
			if look then look.Color = color else p.Color = color end
		end
	end
	local root = candy.PrimaryPart
	local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
	a0.Position, a1.Position = Vector3.new(0, 1, 0), Vector3.new(0, -1, 0)
	a0.Parent, a1.Parent = root, root
	local trail = Instance.new("Trail")
	trail.Attachment0, trail.Attachment1 = a0, a1
	trail.Lifetime = 0.35
	trail.LightEmission = 0.6
	trail.Color = ColorSequence.new(color, Color3.new(1, 1, 1))
	trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1)})
	trail.Parent = root
	candy:PivotTo(CFrame.new(from))
	candy.Parent = eventFolder("Candy")
	local time = math.clamp((from - to).Magnitude / 70, 0.6, 1.4)
	local t0 = os.clock()
	local spin = rng:NextNumber(6, 12)
	while true do
		local k = math.min((os.clock() - t0) / time, 1)
		candy:PivotTo(CFrame.new(from:Lerp(to, k * k)) * CFrame.Angles(k * spin, k * spin * 0.6, 0))
		if k >= 1 then break end
		RunService.Heartbeat:Wait()
	end
	candy:Destroy()
	-- pluie de confettis et de sucre à l'impact
	burst(to, {Texture = "rbxasset://textures/particles/sparkles_main.dds", Color = ColorSequence.new(color, Color3.new(1, 1, 1)), LightEmission = 0.7,
		Speed = NumberRange.new(14, 28), SpreadAngle = Vector2.new(70, 70), EmissionDirection = Enum.NormalId.Top, Acceleration = Vector3.new(0, -40, 0),
		Lifetime = NumberRange.new(0.6, 1.1), RotSpeed = NumberRange.new(-300, 300), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 0.4)})}, 28)
	-- étoiles de sucre multicolores qui retombent en tournant
	burst(to, {Texture = "rbxassetid://1084970835", Color = ColorSequence.new({ColorSequenceKeypoint.new(0, CANDY_COLORS[1]), ColorSequenceKeypoint.new(0.5, CANDY_COLORS[2]), ColorSequenceKeypoint.new(1, CANDY_COLORS[3])}),
		LightEmission = 1, Speed = NumberRange.new(8, 18), SpreadAngle = Vector2.new(60, 60), EmissionDirection = Enum.NormalId.Top, Acceleration = Vector3.new(0, -25, 0), Drag = 1,
		Lifetime = NumberRange.new(0.8, 1.3), RotSpeed = NumberRange.new(-200, 200), Rotation = NumberRange.new(0, 360),
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.4), NumberSequenceKeypoint.new(1, 0)})}, 14)
	flash(to + Vector3.new(0, 2, 0), color, 22, 2.5, 0.35)
	shockwave(to + Vector3.new(0, 0.3, 0), 9, color, 0.4)
	if egg then tryEgg(egg, ev, ev.Chance) end
end

local function runCandy(st, ev)
	local zones = getZones()
	if #zones == 0 then return end
	local folder = eventFolder("Candy")
	local clouds = {}
	local function freeZone()
		local taken = {}
		for _, c in clouds do taken[c.Zone] = true end
		local options = {}
		for _, z in zones do if not taken[z] then table.insert(options, z) end end
		if #options == 0 then options = zones end
		return options[rng:NextInteger(1, #options)]
	end
	local function home(zone)
		return Vector3.new(zone.Position.X + rng:NextNumber(-0.25, 0.25) * zone.Size.X, zone.Position.Y + zone.Size.Y / 2 + 60, zone.Position.Z + rng:NextNumber(-0.2, 0.2) * zone.Size.Z)
	end
	for _ = 1, math.min(2, #zones) do
		local zone = freeZone()
		local cloud = models.CandyCloud:Clone()
		cloud:ScaleTo(1.4)
		local h = home(zone)
		cloud:PivotTo(CFrame.new(h + Vector3.new(0, 90, 0)))
		cloud.Parent = folder
		table.insert(clouds, {Model = cloud, Zone = zone, Home = h, Pos = h + Vector3.new(0, 90, 0), Phase = rng:NextNumber(0, 6), Moved = os.clock()})
	end
	local conn = RunService.Heartbeat:Connect(function(dt)
		local t = os.clock()
		for _, c in clouds do
			if c.Model.Parent then
				local goal = c.Home + Vector3.new(math.sin(t * 0.2 + c.Phase) * c.Zone.Size.X * 0.22, math.sin(t * 0.7 + c.Phase) * 2, math.cos(t * 0.15 + c.Phase) * 10)
				c.Pos = c.Pos:Lerp(goal, math.min(dt * 0.9, 1))
				c.Model:PivotTo(CFrame.new(c.Pos) * CFrame.Angles(0, math.sin(t * 0.12 + c.Phase) * 0.25, 0))
			end
		end
	end)
	while alive(st) do
		sleep(st, rng:NextNumber(0.8, 1.5))
		if not alive(st) then break end
		local c = clouds[rng:NextInteger(1, #clouds)]
		if os.clock() - c.Moved > rng:NextNumber(25, 40) then
			c.Zone = freeZone()
			c.Home = home(c.Zone)
			c.Moved = os.clock()
		else
			local from = c.Pos + Vector3.new(rng:NextNumber(-12, 12), -4, rng:NextNumber(-8, 8))
			local best, bestD
			for _, egg in eggsIn(c.Zone) do
				local p = egg:GetPivot().Position
				local d = (Vector3.new(p.X, 0, p.Z) - Vector3.new(from.X, 0, from.Z)).Magnitude + rng:NextNumber(0, 35)
				if not bestD or d < bestD then best, bestD = egg, d end
			end
			local to = best and eggTop(best) or groundAt(from + Vector3.new(rng:NextNumber(-20, 20), 0, rng:NextNumber(-20, 20)))
			task.spawn(dropCandy, ev, from, to, best)
		end
	end
	conn:Disconnect()
	for _, c in clouds do
		local from = c.Pos
		task.spawn(function()
			local t0 = os.clock()
			while os.clock() - t0 < 2 and c.Model.Parent do
				local k = (os.clock() - t0) / 2
				c.Model:PivotTo(CFrame.new(from + Vector3.new(0, k * k * 160, 0)))
				RunService.Heartbeat:Wait()
			end
			c.Model:Destroy()
		end)
	end
	task.wait(2.1)
end

------------------------------------------------------------------ BLOOD MOON
-- ailes de la chauve-souris : elles battent autour de leur charnière (près du corps)
local function batRig(bat)
	local root = bat.PrimaryPart
	local wings = {}
	for _, p in bat:GetChildren() do
		if p:IsA("BasePart") and (p.Name == "WingL" or p.Name == "WingR" or p.Name == "TipL" or p.Name == "TipR") then
			local side = string.sub(p.Name, -1) == "L" and -1 or 1
			table.insert(wings, {Part = p, Side = side, Base = root.CFrame:ToObjectSpace(p.CFrame)})
		end
	end
	return function(cf, flap)
		bat:PivotTo(cf)
		local hingeScale = bat:GetScale()
		for _, w in wings do
			local hinge = CFrame.new(w.Side * 0.8 * hingeScale, 0.3 * hingeScale, 0)
			w.Part.CFrame = cf * hinge * CFrame.Angles(0, 0, w.Side * flap) * hinge:Inverse() * w.Base
		end
	end
end

local function bezier(a, b, c, t)
	return a:Lerp(b, t):Lerp(b:Lerp(c, t), t)
end

local function flyBat(st, ev, from, egg)
	if not watched(eggTop(egg)) then
		task.wait(3)
		if validEgg(egg) then tryEgg(egg, ev, ev.Chance) end
		return
	end
	local bat = models.Bat:Clone()
	bat:ScaleTo(1.8)
	bat.Parent = eventFolder("BloodMoon")
	local pose = batRig(bat)
	local target = eggTop(egg) + Vector3.new(0, 3, 0)
	local mid = target + Vector3.new(rng:NextNumber(-60, 60), 70, rng:NextNumber(-40, 40))
	local time = math.clamp((target - from).Magnitude / 130, 2.2, 4.5)
	local t0 = os.clock()
	local last = from
	-- vol plané depuis la lune jusqu'à l'œuf
	while bat.Parent do
		local k = math.min((os.clock() - t0) / time, 1)
		local p = bezier(from, mid, target, k)
		local dir = p - last
		local cf = dir.Magnitude > 0.01 and CFrame.lookAt(p, p + dir) or CFrame.new(p)
		pose(cf, math.sin(os.clock() * 16) * 0.75)
		last = p
		if k >= 1 then break end
		RunService.Heartbeat:Wait()
	end
	-- il tournoie autour de l'œuf, puis le mord
	local t1 = os.clock()
	while bat.Parent and os.clock() - t1 < 1.3 do
		local a = (os.clock() - t1) * 6
		local r = 5 + (egg:GetAttribute("Height") or 3) * 0.4
		local p = target + Vector3.new(math.cos(a) * r, math.sin(a * 2) * 1.2, math.sin(a) * r)
		pose(CFrame.lookAt(p, p + Vector3.new(-math.sin(a), 0, math.cos(a))), math.sin(os.clock() * 20) * 0.8)
		RunService.Heartbeat:Wait()
	end
	burst(target, {Color = ColorSequence.new(rgb(255, 80, 90), rgb(120, 0, 20)), LightEmission = 0.8, Speed = NumberRange.new(10, 22), SpreadAngle = Vector2.new(180, 180),
		Lifetime = NumberRange.new(0.4, 0.8), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 0)})}, 30)
	tryEgg(egg, ev, ev.Chance)
	-- et repart vers le ciel
	local up, t2 = bat:GetPivot().Position, os.clock()
	while bat.Parent and os.clock() - t2 < 1.6 do
		local k = (os.clock() - t2) / 1.6
		local p = up + Vector3.new(k * 30, k * k * 140, -k * 60)
		pose(CFrame.lookAt(p, p + Vector3.new(0.3, 1, -0.6)), math.sin(os.clock() * 18) * 0.8)
		RunService.Heartbeat:Wait()
	end
	burst(bat:GetPivot().Position, {Texture = "rbxasset://textures/particles/smoke_main.dds", Color = ColorSequence.new(rgb(60, 20, 40)), LightEmission = 0,
		Speed = NumberRange.new(4, 10), SpreadAngle = Vector2.new(180, 180), Lifetime = NumberRange.new(0.6, 1), Size = NumberSequence.new(4)}, 8)
	bat:Destroy()
end

local function runBloodMoon(st, ev)
	local zones = getZones()
	if #zones == 0 then return end
	local folder = eventFolder("BloodMoon")
	-- la lune se lève au sud de la map, au milieu, derrière le mur
	local minX, maxX = zones[1].Position.X, zones[#zones].Position.X
	local z = zones[1].Position.Z - zones[1].Size.Z / 2 - 380
	local moon = models.BloodMoon:Clone()
	moon:ScaleTo(2.4)
	do
		local mroot = moon.PrimaryPart
		local _, msize = moon:GetBoundingBox()
		local function moonFx(name, texture, size, rate, life, rot, transparency, color)
			local e = Instance.new("ParticleEmitter")
			e.Name, e.Texture, e.LockedToPart, e.LightEmission, e.LightInfluence = name, texture, true, 1, 0
			e.Color = ColorSequence.new(color)
			e.Rate, e.Lifetime, e.Speed = rate, NumberRange.new(life, life), NumberRange.new(0, 0)
			e.RotSpeed, e.Rotation = NumberRange.new(rot, rot), NumberRange.new(0, 360)
			e.Size = NumberSequence.new(size)
			e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, transparency), NumberSequenceKeypoint.new(1, 1)})
			e.Parent = mroot
		end
		moonFx("Rays", "rbxassetid://1084975295", msize.X * 1.9, 0.6, 5, 6, 0.55, rgb(255, 40, 50))     -- rayons qui tournent lentement
		moonFx("Halo", "rbxassetid://4509687978", msize.X * 1.6, 0.8, 3, 0, 0.45, rgb(255, 30, 40))      -- halo qui respire
		local light = Instance.new("PointLight")
		light.Color, light.Range, light.Brightness, light.Shadows = rgb(255, 40, 50), 60, 2, false
		light.Parent = mroot
	end
	moon.Parent = folder
	local skyPos = Vector3.new((minX + maxX) / 2, 300, z)
	local t0 = os.clock()
	while os.clock() - t0 < 4 and alive(st) do
		local k = (os.clock() - t0) / 4
		moon:PivotTo(CFrame.new(skyPos - Vector3.new(0, (1 - k * k * (3 - 2 * k)) * 260, 0)))
		RunService.Heartbeat:Wait()
	end
	moon:PivotTo(CFrame.new(skyPos))
	local spawnFrom = skyPos + Vector3.new(0, -60, 120)
	while alive(st) do
		local zone = zones[rng:NextInteger(1, #zones)]
		local eggs = eggsIn(zone, true)
		if #eggs > 0 then
			-- les chauves-souris partent de la lune (étalées le long de la map pour ne pas traverser toute la map)
			local egg = eggs[rng:NextInteger(1, #eggs)]
			local from = Vector3.new(egg:GetPivot().Position.X + rng:NextNumber(-80, 80), spawnFrom.Y, spawnFrom.Z)
			task.spawn(flyBat, st, ev, from, egg)
		end
		sleep(st, rng:NextNumber(0.9, 1.7))
	end
	-- la lune se couche
	local t1 = os.clock()
	while os.clock() - t1 < 3 and moon.Parent do
		local k = (os.clock() - t1) / 3
		moon:PivotTo(CFrame.new(skyPos - Vector3.new(0, k * k * 300, 0)))
		RunService.Heartbeat:Wait()
	end
	moon:Destroy()
	task.wait(3) -- les dernières chauves-souris finissent leur vol
end

------------------------------------------------------------------ BLIZZARD
local function freezeBurst(egg, ev)
	local top = eggTop(egg)
	local height = egg:GetAttribute("Height") or 3
	local center = egg:GetPivot().Position
	-- un bloc de glace se forme autour de l'œuf, puis éclate
	local block = fxPart(Vector3.one * (height * 0.6), CFrame.new(center) * CFrame.Angles(0, rng:NextNumber(0, 1), 0), rgb(190, 235, 255), Enum.Material.Glass, 0.9)
	block.Parent = eventFolder("Blizzard")
	TweenService:Create(block, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = Vector3.new(height + 2, height + 2, height + 2), Transparency = 0.35}):Play()
	task.wait(0.9)
	block:Destroy()
	burst(center, {Color = ColorSequence.new(Color3.new(1, 1, 1), ev.Color), LightEmission = 0.8, Speed = NumberRange.new(14, 30), SpreadAngle = Vector2.new(180, 180),
		Acceleration = Vector3.new(0, -50, 0), Lifetime = NumberRange.new(0.5, 1), RotSpeed = NumberRange.new(-200, 200),
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.1), NumberSequenceKeypoint.new(1, 0.3)})}, 45)
	shockwave(center - Vector3.new(0, height / 2 - 0.3, 0), 10 + height, ev.Color, 0.5)
	tryEgg(egg, ev, ev.Chance)
end

local function runBlizzard(st, ev)
	local zones = getZones()
	if #zones == 0 then return end
	local folder = eventFolder("Blizzard")
	local spirit = models.FrostSpirit:Clone()
	spirit:ScaleTo(1.3)
	spirit.Parent = folder
	local core = spirit:FindFirstChild("Core")
	if core then
		local light = Instance.new("PointLight")
		light.Color, light.Range, light.Brightness, light.Shadows = ev.Color, 40, 2, false
		light.Parent = core
		local sparkle = Instance.new("ParticleEmitter")
		sparkle.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		sparkle.Color = ColorSequence.new(Color3.new(1, 1, 1), ev.Color)
		sparkle.LightEmission = 1
		sparkle.Rate = 25
		sparkle.Lifetime = NumberRange.new(1, 2)
		sparkle.Speed = NumberRange.new(3, 9)
		sparkle.SpreadAngle = Vector2.new(180, 180)
		sparkle.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.4), NumberSequenceKeypoint.new(1, 0)})
		sparkle.Parent = core
		local flakes = Instance.new("ParticleEmitter") -- éclats de givre en étoile qui tournoient
		flakes.Texture, flakes.LightEmission, flakes.LightInfluence = "rbxassetid://1084970835", 1, 0
		flakes.Color = ColorSequence.new(Color3.new(1, 1, 1), rgb(170, 230, 255))
		flakes.Rate, flakes.Lifetime, flakes.Speed = 10, NumberRange.new(1.2, 2), NumberRange.new(2, 6)
		flakes.SpreadAngle, flakes.Drag = Vector2.new(180, 180), 1
		flakes.RotSpeed, flakes.Rotation = NumberRange.new(-120, 120), NumberRange.new(0, 360)
		flakes.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, 2.2), NumberSequenceKeypoint.new(1, 0)})
		flakes.Parent = core
		local halo = Instance.new("ParticleEmitter") -- halo glacé qui respire autour du cœur
		halo.Texture, halo.LockedToPart, halo.LightEmission, halo.LightInfluence = "rbxassetid://8095997435", true, 1, 0
		halo.Color = ColorSequence.new(rgb(190, 240, 255))
		halo.Rate, halo.Lifetime, halo.Speed = 0.7, NumberRange.new(2.4, 2.4), NumberRange.new(0, 0)
		halo.RotSpeed, halo.Rotation = NumberRange.new(25, 25), NumberRange.new(0, 360)
		halo.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 18), NumberSequenceKeypoint.new(1, 30)})
		halo.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3, 0.5), NumberSequenceKeypoint.new(1, 1)})
		halo.Parent = core
	end
	local index = rng:NextInteger(1, #zones)
	local first = zones[index]
	local pos = Vector3.new(first.Position.X, first.Position.Y + first.Size.Y / 2 + 240, first.Position.Z)
	local spin = 0
	local conn = RunService.Heartbeat:Connect(function(dt)
		spin += dt * 0.9
		spirit:PivotTo(CFrame.new(pos + Vector3.new(0, math.sin(os.clock() * 1.6) * 1.5, 0)) * CFrame.Angles(0, spin, 0) * CFrame.Angles(math.rad(70), 0, 0))
	end)
	local function flyTo(dest)
		local from = pos
		local time = math.clamp((dest - from).Magnitude / 75, 0.6, 6)
		local t0 = os.clock()
		while alive(st) do
			local k = math.min((os.clock() - t0) / time, 1)
			pos = from:Lerp(dest, k * k * (3 - 2 * k))
			if k >= 1 then break end
			RunService.Heartbeat:Wait()
		end
	end
	flyTo(Vector3.new(first.Position.X, first.Position.Y + first.Size.Y / 2 + 40, first.Position.Z))
	local dir = 1
	while alive(st) do
		local zone = zones[index]
		local floorY = zone.Position.Y + zone.Size.Y / 2
		flyTo(Vector3.new(zone.Position.X + rng:NextNumber(-0.2, 0.2) * zone.Size.X, floorY + 40, zone.Position.Z))
		local eggs = eggsIn(zone, true)
		for _ = 1, math.min(rng:NextInteger(2, 3), #eggs) do
			if not alive(st) then break end
			local egg = table.remove(eggs, rng:NextInteger(1, #eggs))
			if validEgg(egg) then
				local at = egg:GetPivot().Position
				flyTo(Vector3.new(at.X, at.Y + 26, at.Z))
				if not alive(st) then break end
				-- rayon de givre jusqu'à l'œuf
				local top = eggTop(egg)
				local len = math.max(pos.Y - top.Y, 2)
				local ray = fxPart(Vector3.new(len, 2.2, 2.2), CFrame.new(pos.X, top.Y + len / 2, pos.Z) * CFrame.Angles(0, 0, math.rad(90)), ev.Color, Enum.Material.Neon, 0.35, Enum.PartType.Cylinder)
				ray.Parent = folder
				TweenService:Create(ray, TweenInfo.new(1.2), {Size = Vector3.new(len, 0.4, 0.4), Transparency = 0.9}):Play()
				Debris:AddItem(ray, 1.25)
				freezeBurst(egg, ev)
				sleep(st, 0.6)
			end
		end
		sleep(st, 0.5)
		if #zones > 1 then
			if not zones[index + dir] then dir = -dir end
			index += dir
		end
	end
	-- départ : remonte et disparaît dans un éclat de neige
	local from, t0 = pos, os.clock()
	while os.clock() - t0 < 1.4 do
		local k = (os.clock() - t0) / 1.4
		pos = from + Vector3.new(0, k * k * 260, 0)
		RunService.Heartbeat:Wait()
	end
	conn:Disconnect()
	spirit:Destroy()
end

------------------------------------------------------------------ HACKER ATTACK
local HACK_HOVER = 58  -- hauteur du drone au-dessus du sol de la zone
local HACK_SPEED = 110 -- studs/s

-- rayon de données : un trait vert en zigzag « circuit imprimé » (angles droits) du drone jusqu'à l'œuf
local function dataBeam(from, to, color)
	local holder = Instance.new("Model")
	holder.Name = "DataBeam"
	local points = {from}
	local steps = 5
	for i = 1, steps - 1 do
		local p = from:Lerp(to, i / steps)
		local last = points[#points]
		-- un coude horizontal puis vertical : effet piste de circuit
		table.insert(points, Vector3.new(p.X + rng:NextNumber(-4, 4), last.Y, p.Z + rng:NextNumber(-4, 4)))
		table.insert(points, Vector3.new(points[#points].X, p.Y, points[#points].Z))
	end
	table.insert(points, to)
	for i = 1, #points - 1 do
		local a, b = points[i], points[i + 1]
		local len = (b - a).Magnitude
		if len > 0.05 then
			local cf = CFrame.lookAt((a + b) / 2, b)
			fxPart(Vector3.new(0.4, 0.4, len + 0.4), cf, rgb(220, 255, 230), Enum.Material.Neon, 0).Parent = holder
			fxPart(Vector3.new(1.5, 1.5, len + 0.4), cf, color, Enum.Material.Neon, 0.6).Parent = holder
		end
	end
	holder.Parent = eventFolder("Hacker")
	for _, p in holder:GetChildren() do
		TweenService:Create(p, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1}):Play()
	end
	Debris:AddItem(holder, 0.6)
end

-- pluie de bits verts qui jaillit d'un point
local function bits(position, color, count)
	burst(position, {Color = ColorSequence.new(rgb(220, 255, 230), color), LightEmission = 1, Speed = NumberRange.new(8, 20), SpreadAngle = Vector2.new(180, 180),
		Acceleration = Vector3.new(0, -25, 0), Lifetime = NumberRange.new(0.4, 0.9), Squash = NumberSequence.new(1.6), Rotation = NumberRange.new(0, 0),
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.7), NumberSequenceKeypoint.new(1, 0.2)})}, count)
end

-- balayage du scanner : un mur vert translucide traverse toute la zone
local function scanSweep(zone, color, time)
	local floorY = zone.Position.Y + zone.Size.Y / 2
	local minX, maxX = zone.Position.X - zone.Size.X / 2, zone.Position.X + zone.Size.X / 2
	local wall = fxPart(Vector3.new(0.6, 14, zone.Size.Z), CFrame.new(minX, floorY + 7, zone.Position.Z), color, Enum.Material.Neon, 0.55)
	wall.Parent = eventFolder("Hacker")
	local line = fxPart(Vector3.new(1.2, 0.3, zone.Size.Z), CFrame.new(minX, floorY + 0.2, zone.Position.Z), rgb(220, 255, 230), Enum.Material.Neon, 0.1)
	line.Parent = wall
	TweenService:Create(wall, TweenInfo.new(time, Enum.EasingStyle.Sine), {CFrame = CFrame.new(maxX, floorY + 7, zone.Position.Z)}):Play()
	TweenService:Create(line, TweenInfo.new(time, Enum.EasingStyle.Sine), {CFrame = CFrame.new(maxX, floorY + 0.2, zone.Position.Z)}):Play()
	task.delay(time, function()
		TweenService:Create(wall, TweenInfo.new(0.3), {Transparency = 1}):Play()
		TweenService:Create(line, TweenInfo.new(0.3), {Transparency = 1}):Play()
	end)
	Debris:AddItem(wall, time + 0.4)
end

local function runHacker(st, ev)
	local zones = getZones()
	if #zones == 0 then return end
	local folder = eventFolder("Hacker")
	local drone = models.HackerDrone:Clone()
	do -- anneau holographique sous le drone et éclats de données qui grésillent
		local droot = drone.PrimaryPart
		local holo = Instance.new("ParticleEmitter")
		holo.Name, holo.Texture, holo.LockedToPart, holo.LightEmission, holo.LightInfluence = "HoloRing", "rbxassetid://8099267640", true, 1, 0
		holo.Color = ColorSequence.new(rgb(40, 255, 110))
		holo.Orientation, holo.EmissionDirection = Enum.ParticleOrientation.VelocityPerpendicular, Enum.NormalId.Bottom
		holo.Rate, holo.Lifetime, holo.Speed = 1.2, NumberRange.new(1.4, 1.4), NumberRange.new(0.01, 0.01)
		holo.RotSpeed, holo.Rotation = NumberRange.new(60, 60), NumberRange.new(0, 360)
		holo.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 10), NumberSequenceKeypoint.new(1, 22)})
		holo.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.4), NumberSequenceKeypoint.new(1, 1)})
		holo.Parent = droot
		local bits = Instance.new("ParticleEmitter")
		bits.Name, bits.Texture, bits.LightEmission = "Glitch", "rbxasset://textures/particles/sparkles_main.dds", 1
		bits.Color = ColorSequence.new(Color3.new(1, 1, 1), rgb(40, 255, 110))
		bits.Rate, bits.Lifetime, bits.Speed, bits.SpreadAngle = 12, NumberRange.new(0.1, 0.25), NumberRange.new(8, 18), Vector2.new(180, 180)
		bits.Squash = NumberSequence.new(-1.5)
		bits.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.8), NumberSequenceKeypoint.new(1, 0)})
		bits.Parent = droot
	end
	drone:ScaleTo(1.8) -- (le modèle lui-même fait déjà le double de l'ancien)
	drone.Parent = folder
	local origin = drone.PrimaryPart:FindFirstChild("BeamOrigin")
	local index = rng:NextInteger(1, #zones)
	local first = zones[index]
	local pos = Vector3.new(first.Position.X, first.Position.Y + first.Size.Y / 2 + 300, first.Position.Z)
	local yaw, glitchUntil = math.pi, 0
	local lastShipPos, bank
	local conn = RunService.Heartbeat:Connect(function(dt)
		local t = os.clock()
		-- vaisseau : il se tourne dans le sens où il vole (nez vers l'avant) et s'incline dans les virages
		local moved = lastShipPos and (pos - lastShipPos) / math.max(dt, 1e-3) or Vector3.zero
		lastShipPos = pos
		local flat = Vector3.new(moved.X, 0, moved.Z)
		local turn = 0
		if flat.Magnitude > 4 then
			local want = math.atan2(-flat.X, -flat.Z)
			turn = (want - yaw + math.pi) % (2 * math.pi) - math.pi
			yaw += turn * (1 - math.exp(-dt * 4))
		else
			yaw += math.sin(t * 0.7) * dt * 0.25 -- en vol stationnaire : il pivote doucement
		end
		bank = (bank or 0) + (math.clamp(-turn * 0.6, -0.5, 0.5) - (bank or 0)) * (1 - math.exp(-dt * 3))
		local jitter = t < glitchUntil and Vector3.new(rng:NextNumber(-0.8, 0.8), rng:NextNumber(-0.5, 0.5), rng:NextNumber(-0.8, 0.8)) or Vector3.zero
		drone:PivotTo(CFrame.new(pos + Vector3.new(0, math.sin(t * 2.2) * 1.4, 0) + jitter) * CFrame.Angles(0, yaw, 0) * CFrame.Angles(math.sin(t * 1.3) * 0.05, 0, math.sin(t * 1.7) * 0.06 + (bank or 0)))
		for _, rotor in drone:GetChildren() do -- les pales tournent
			if rotor.Name == "Rotor" and rotor.PrimaryPart then rotor:PivotTo(rotor:GetPivot() * CFrame.Angles(dt * 28, 0, 0)) end
		end
	end)
	local function flyTo(dest)
		local from = pos
		local time = math.clamp((dest - from).Magnitude / HACK_SPEED, 0.6, 6)
		local t0 = os.clock()
		while alive(st) do
			local k = math.min((os.clock() - t0) / time, 1)
			pos = from:Lerp(dest, k * k * (3 - 2 * k))
			if k >= 1 then break end
			RunService.Heartbeat:Wait()
		end
	end
	-- arrivée : il tombe du ciel en bugant
	glitchUntil = os.clock() + 2.5
	flyTo(Vector3.new(first.Position.X, first.Position.Y + first.Size.Y / 2 + HACK_HOVER, first.Position.Z))
	-- VAGUE : toutes les WaveEvery secondes, un mur de code vert traverse TOUTES les zones d'un bout à l'autre en WaveTime secondes,
	-- le drone surfe au-dessus. Quand la vague passe sur une zone, 3 œufs de cette zone sont piratés (x5 HACKED), à coup sûr.
	local minX, maxX, minZ, maxZ, floorY = math.huge, -math.huge, math.huge, -math.huge, math.huge
	for _, zone in zones do
		minX = math.min(minX, zone.Position.X - zone.Size.X / 2)
		maxX = math.max(maxX, zone.Position.X + zone.Size.X / 2)
		minZ = math.min(minZ, zone.Position.Z - zone.Size.Z / 2)
		maxZ = math.max(maxZ, zone.Position.Z + zone.Size.Z / 2)
		floorY = math.min(floorY, zone.Position.Y + zone.Size.Y / 2)
	end
	local centerZ, depth = (minZ + maxZ) / 2, maxZ - minZ
	-- la vague touche un œuf : il bugue (anneau de scan au sol, éclats de pixels, colonne de code) ; 10 % de chance d'être piraté
	local function hitEgg(egg)
		if not validEgg(egg) or egg:GetAttribute("EventMutation") == ev.Mutation then return end
		local top = eggTop(egg)
		if not watched(top, 200) then
			if rng:NextNumber() < (ev.WaveChance or 0.1) then tryEgg(egg, ev, 1, true) end
			return
		end
		local height = egg:GetAttribute("Height") or 3
		local ground = top - Vector3.new(0, height, 0)
		local ring = fxPart(Vector3.new(0.3, height * 1.6, height * 1.6), CFrame.new(ground + Vector3.new(0, 0.25, 0)) * CFrame.Angles(0, 0, math.pi / 2), ev.Color, Enum.Material.Neon, 0.2)
		ring.Shape = Enum.PartType.Cylinder
		ring.Parent = folder
		TweenService:Create(ring, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(0.3, height * 4, height * 4), Transparency = 1}):Play()
		Debris:AddItem(ring, 0.55)
		-- plan de scan qui remonte le long de l'œuf
		local scanPlane = fxPart(Vector3.new(height * 1.5, 0.15, height * 1.5), CFrame.new(ground), rgb(220, 255, 230), Enum.Material.Neon, 0.3)
		scanPlane.Parent = folder
		TweenService:Create(scanPlane, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {CFrame = CFrame.new(top + Vector3.new(0, 0.3, 0)), Transparency = 1}):Play()
		Debris:AddItem(scanPlane, 0.4)
		bits(top - Vector3.new(0, height * 0.4, 0), ev.Color, 10)
		if rng:NextNumber() < (ev.WaveChance or 0.1) then
			tryEgg(egg, ev, 1, true)
			bits(top, ev.Color, 60)
			-- colonne de données vers le ciel
			local column = fxPart(Vector3.new(height * 0.5, 60, height * 0.5), CFrame.new(top + Vector3.new(0, 30, 0)), ev.Color, Enum.Material.Neon, 0.25)
			column.Parent = folder
			TweenService:Create(column, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(0.1, 80, 0.1), Transparency = 1}):Play()
			Debris:AddItem(column, 1)
			floatText(top + Vector3.new(0, 2, 0), "HACKED!", ev.Color)
		end
	end
	local function wave()
		local time = ev.WaveTime or 5
		local height = 60
		local wall = fxPart(Vector3.new(3, height, depth + 20), CFrame.new(minX, floorY + height / 2, centerZ), ev.Color, Enum.Material.Neon, 0.55)
		wall.Parent = folder
		local core = fxPart(Vector3.new(0.8, height, depth + 20), CFrame.new(minX, floorY + height / 2, centerZ), rgb(220, 255, 230), Enum.Material.Neon, 0.15)
		core.Parent = folder
		local glow = fxPart(Vector3.new(16, height * 0.7, depth + 20), CFrame.new(minX - 8, floorY + height * 0.35, centerZ), ev.Color, Enum.Material.Neon, 0.85)
		glow.Parent = folder
		local spray = Instance.new("ParticleEmitter")
		spray.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		spray.Color = ColorSequence.new(rgb(220, 255, 230), ev.Color)
		spray.LightEmission, spray.Rate, spray.Lifetime = 1, 260, NumberRange.new(0.4, 0.9)
		spray.Speed, spray.SpreadAngle = NumberRange.new(10, 25), Vector2.new(60, 60)
		spray.EmissionDirection = Enum.NormalId.Back
		spray.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 0)})
		spray.Parent = wall
		local info = TweenInfo.new(time, Enum.EasingStyle.Linear)
		TweenService:Create(wall, info, {CFrame = CFrame.new(maxX, floorY + height / 2, centerZ)}):Play()
		TweenService:Create(core, info, {CFrame = CFrame.new(maxX, floorY + height / 2, centerZ)}):Play()
		TweenService:Create(glow, info, {CFrame = CFrame.new(maxX - 8, floorY + height * 0.35, centerZ)}):Play()
		-- chaque œuf de chaque zone est touché au moment où le front de la vague passe sur lui
		for _, zone in zones do
			for _, egg in eggsIn(zone) do
				local x = egg:GetPivot().Position.X
				local k = math.clamp((x - minX) / math.max(maxX - minX, 1), 0, 1)
				task.delay(k * time, function() if alive(st) then hitEgg(egg) end end)
			end
		end
		-- le drone surfe sur la vague
		local t0 = os.clock()
		glitchUntil = os.clock() + time
		while os.clock() - t0 < time do
			local k = (os.clock() - t0) / time
			pos = Vector3.new(minX + (maxX - minX) * k, floorY + height + 14, centerZ)
			RunService.Heartbeat:Wait()
		end
		for _, p in {wall, core, glow} do TweenService:Create(p, TweenInfo.new(0.5), {Transparency = 1}):Play() end
		spray.Enabled = false
		Debris:AddItem(wall, 1.5) Debris:AddItem(core, 0.6) Debris:AddItem(glow, 0.6)
	end
	local function flyBack(dest, seconds) -- retour en ligne droite en un temps fixe (fin de la map -> début)
		local from, t0 = pos, os.clock()
		while alive(st) do
			local k = math.min((os.clock() - t0) / seconds, 1)
			pos = from:Lerp(dest, k * k * (3 - 2 * k)) + Vector3.new(0, math.sin(k * math.pi) * 25, 0)
			if k >= 1 then break end
			RunService.Heartbeat:Wait()
		end
	end
	local home = Vector3.new(minX, floorY + 74, centerZ)
	while alive(st) do
		-- la vague part du début de la map : le drone s'y place, bug, et lance la vague
		flyTo(home)
		if not alive(st) then break end
		glitchUntil = os.clock() + 1.2
		flash(pos - Vector3.new(0, 8, 0), ev.Color, 60, 3, 1.2)
		sleep(st, 1.2)
		if not alive(st) then break end
		wave()
		-- arrivé au bout : il revient au début de la map en 3 s et y attend la vague suivante (une minute après le départ de celle-ci)
		local nextAt = os.clock() + (ev.WaveEvery or 60) - (ev.WaveTime or 10) - 1.2
		flyBack(home, ev.ReturnTime or 3)
		while alive(st) and os.clock() < nextAt do sleep(st, 0.5) end
	end
	-- départ : il bug et remonte en flèche
	glitchUntil = os.clock() + 2
	local from, t0 = pos, os.clock()
	while os.clock() - t0 < 1.4 do
		local k = (os.clock() - t0) / 1.4
		pos = from + Vector3.new(0, k * k * 300, 0)
		RunService.Heartbeat:Wait()
	end
	conn:Disconnect()
	drone:Destroy()
end

------------------------------------------------------------------ EVENT
local RUNNERS = {Meteor = runMeteor, Storm = runStorm, Ufo = runUfo, Candy = runCandy, BloodMoon = runBloodMoon, Blizzard = runBlizzard, Hacker = runHacker}

local function runEvent(name, duration)
	local st, ev = state[name], EVENTS[name]
	if st.Running then return end
	st.Running, st.Stop = true, false
	st.EndAt = workspace:GetServerTimeNow() + duration
	ReplicatedStorage:SetAttribute(ev.Attribute, st.EndAt)
	ReplicatedStorage:SetAttribute(name .. "EventStart", workspace:GetServerTimeNow()) -- la musique va au premier event lancé (SkyEventsClient)
	local ok, err = pcall(RUNNERS[name], st, ev)
	if not ok then warn("[SkyEvents] " .. name .. " : " .. tostring(err)) end
	local f = fxFolder:FindFirstChild(name)
	if f then
		task.delay(3, function() if not state[name].Running then f:ClearAllChildren() end end)
	end
	ReplicatedStorage:SetAttribute(ev.Attribute, nil)
	ReplicatedStorage:SetAttribute(name .. "EventStart", nil)
	st.Running, st.Stop = false, false
end

------------------------------------------------------------------ COMMANDE ADMIN + TOUS LES SERVEURS
local function handle(name, action, duration)
	local ev, st = EVENTS[name], state[name]
	if not ev then return end
	if action == "start" then
		if st.Running then return end
		announceRemote:FireAllClients("EVENT", string.format(ev.Announce, describe(duration)), 0)
		task.spawn(runEvent, name, duration)
	elseif action == "stop" then
		st.Stop = true
	end
end

-- lancement par un autre script (ce serveur seulement) : ServerStorage.GameBindables.RunSkyEvent:Fire(nom, "start" / "stop", durée)
-- (ex. CutsceneEventServer : la cinématique Hacker Infiltration lance l'event HACKER ATTACK)
game:GetService("ServerStorage"):WaitForChild("GameBindables"):WaitForChild("RunSkyEvent").Event:Connect(function(name, action, duration)
	handle(name, action, math.clamp(tonumber(duration) or 600, MIN_DURATION, MAX_DURATION))
end)
pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		if type(data) == "table" then
			handle(data.event, data.action, math.clamp(tonumber(data.duration) or 600, MIN_DURATION, MAX_DURATION))
		end
	end)
end)

startRemote.OnServerEvent:Connect(function(player, name, action, duration, scope) -- scope "server" = ce serveur seulement
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	local ev = EVENTS[name]
	if not ev or (action ~= "start" and action ~= "stop") then return end
	duration = math.clamp(tonumber(duration) or 600, MIN_DURATION, MAX_DURATION)
	if action == "start" and state[name].Running then
		notifyRemote:FireClient(player, ev.Title .. " is already running")
		return
	end
	local ok = scope ~= "server" and pcall(function() MessagingService:PublishAsync(TOPIC, {event = name, action = action, duration = duration}) end)
	if not ok then handle(name, action, duration) end -- Studio : ce serveur seulement
	notifyRemote:FireClient(player, ev.Title .. (action == "start" and (" started (" .. describe(duration) .. ")") or " stopped"))
end)

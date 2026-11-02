-- DiscoEventClient : tout ce que ce joueur VOIT pendant le DISCO EVENT. L'état vient du serveur (attribut DiscoEventEnd de
-- ReplicatedStorage, posé par SkyEventsServer) ; ce script n'envoie rien au serveur et ne touche jamais la carte.
--   * la boîte de nuit (ReplicatedStorage.DiscoEvent.Club, faite par ServerStorage.DiscoBuilder) est clonée ici au début de
--     l'event (fondu) et enlevée à la fin : murs, plafond étoilé, poutres, projecteurs mobiles, boules à facettes, scène, DJ
--   * nuit : une ColorCorrection "DiscoNight" à soi (douce : la carte reste bien lisible) + la brume de ZoneLightingClient.
--     Aucune propriété de Lighting n'est modifiée (les cinématiques gardent les leurs) ; tout revient en fondu à la fin
--   * animations (une seule boucle, coupée quand l'event est fini) : boules qui tournent lentement, faisceaux qui balaient les
--     zones, reflets qui glissent au plafond et sur les murs, écrans LED, platines, enceintes, DJ capybara qui mixe (ses
--     Motor6D sont animés ici : aucun ID d'animation). Les pulsations suivent la musique du Disco Event (PlaybackLoudness)
--   * œufs mis en lumière par le serveur (tag "DiscoSpot") : un faisceau tombe de la boule géante sur l'œuf
--   * musique, HUD et timer : SkyEventsClient, comme les autres events
-- Rien n'est affiché pendant la cinématique d'arrivée (la forêt de l'intro est là où se trouve la scène) ni dans les arènes.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local CollectionService = game:GetService("CollectionService")

local player = Players.LocalPlayer
local rgb = Color3.fromRGB
local PALETTE = {rgb(255, 70, 215), rgb(70, 220, 255), rgb(150, 90, 255), rgb(255, 130, 235), rgb(80, 130, 255), rgb(60, 255, 225)}
local NIGHT = {TintColor = rgb(196, 182, 255), Brightness = -0.1, Contrast = 0.16, Saturation = 0.18}
local NEUTRAL = {TintColor = Color3.new(1, 1, 1), Brightness = 0, Contrast = 0, Saturation = 0}
local BPM = 118           -- tempo de secours si la musique du Disco Event ne joue pas (un autre event a la musique)
local FADE_TIME = 2.4     -- fondu du décor
local DROP_TIME = 4.5     -- la boule géante descend du plafond
local DJ_NEAR = 1600      -- le DJ n'est animé que si la caméra est à moins de cette distance
local SPOT_NEAR = 1300    -- faisceaux sur les œufs : seulement près de la caméra

local fxFolder = Instance.new("Folder")
fxFolder.Name = "DiscoEventFx" -- (local à ce joueur)
fxFolder.Parent = workspace

local function now() return workspace:GetServerTimeNow() end
local function wanted()
	local endAt = ReplicatedStorage:GetAttribute("DiscoEventEnd")
	return type(endAt) == "number" and endAt > now() and player:GetAttribute("IntroState") ~= "playing"
		and player:GetAttribute("InBossArena") ~= true and player:GetAttribute("InDemonArena") ~= true
end

---------------------------------------------------------------- nuit (ColorCorrection à soi, en fondu)
local night
local function setNight(on)
	if on and not night then
		night = Instance.new("ColorCorrectionEffect")
		night.Name = "DiscoNight"
		night.TintColor, night.Brightness, night.Contrast, night.Saturation = NEUTRAL.TintColor, 0, 0, 0
		night.Parent = Lighting
	end
	if not night then return end
	local cc = night
	local tw = TweenService:Create(cc, TweenInfo.new(on and 3 or 2.5, Enum.EasingStyle.Sine), on and NIGHT or NEUTRAL)
	if not on then
		night = nil
		tw.Completed:Once(function() cc:Destroy() end)
	end
	tw:Play()
end

---------------------------------------------------------------- le décor
local club   -- clone en cours (jamais deux)
local state  -- tout ce qu'on anime, rempli par prepare()
local function prepare(c, root)
	local s = {Club = c, Balls = {}, Heads = {}, Screens = {}, Sprites = {}, Platters = {}, Pads = {}, Caps = {}, Fade = {}, Textures = {},
		Guis = {}, Beams = {}, Emitters = {}, Ceiling = {}, Walls = {}, Floors = {}, StageFloor = nil, Joints = {}, Born = os.clock(), Fading = 0}
	s.CeilY = root:GetAttribute("CeilingY") or 340
	local balls = c:FindFirstChild("DiscoBalls")
	for _, m in balls and balls:GetChildren() or {} do
		local r = m:FindFirstChild("Root")
		if r then
			local core = m:FindFirstChild("Core")
			local tiles = {}
			for _, tile in m:FindFirstChild("Tiles") and m.Tiles:GetChildren() or {} do table.insert(tiles, tile) end
			table.insert(s.Balls, {Model = m, Root = r, Home = r.Position, Spin = m:GetAttribute("Spin") or 0.25, R = core and core.Size.X / 2 or 20,
				Light = core and core:FindFirstChild("CoreLight"), Main = m.Name == "MainBall", Rays = {}, Tiles = tiles, Lit = {}})
		end
	end
	for _, d in c:GetDescendants() do
		if d:IsA("Model") and d.Name == "MovingHead" then
			local yoke, head = d:FindFirstChild("Yoke"), d:FindFirstChild("Head")
			local target = yoke and yoke:FindFirstChild("Target")
			if head and target then
				table.insert(s.Heads, {Head = head, Target = target, Pos = yoke.Position - Vector3.new(0, 6, 0), Phase = d:GetAttribute("Phase") or 0,
					Aim = d:GetAttribute("Aim") or yoke.Position - Vector3.new(0, 300, 0), Sweep = d:GetAttribute("Sweep") or Vector3.new(150, 0, 100)})
			end
		elseif d:IsA("SurfaceGui") and d:GetAttribute("DiscoScreen") then
			local bg = d:FindFirstChild("Background")
			local eq = bg and bg:FindFirstChild("Eq")
			local bars = {}
			if eq then for _, b in eq:GetChildren() do if b.Name == "Bar" then table.insert(bars, b) end end end
			local flow = bg and (bg:FindFirstChild("Flow") or (bg:FindFirstChild("Title") and bg.Title:FindFirstChild("Flow")))
			table.insert(s.Screens, {Gui = d, Bars = bars, Flow = flow, Part = d.Parent})
			table.insert(s.Guis, d)
		elseif d:IsA("ImageLabel") and d.Name == "DiscoSprite" then
			table.insert(s.Sprites, d)
		elseif d:IsA("BasePart") then
			if d.Name == "Platter" then table.insert(s.Platters, {Part = d, Home = d.CFrame, Spin = d:GetAttribute("Spin") or 3})
			elseif d.Name == "PadButton" then table.insert(s.Pads, {Part = d, Index = d:GetAttribute("Blink") or 0, Color = d.Color})
			elseif d.Name == "DustCap" then table.insert(s.Caps, {Part = d, Home = d:GetAttribute("Home") or d.CFrame}) end
			local inBall = balls and d:IsDescendantOf(balls)
			if not inBall then table.insert(s.Fade, {d, d.Transparency}) end
		elseif d:IsA("Texture") then
			table.insert(s.Textures, {d, d.Transparency})
			if d.Name == "Stars1" or d.Name == "Stars2" then table.insert(s.Ceiling, d)
			elseif d.Name == "ReflectionDots" then table.insert(s.Walls, d)
			elseif d.Name == "LedFloor" then
				if d.Parent and d.Parent.Name == "Platform" then s.StageFloor = d else table.insert(s.Floors, d) end
			end
		elseif d:IsA("Beam") then
			table.insert(s.Beams, d)
			local ball = d.Name == "Ray" and d.Parent and d.Parent.Name == "Root" and d.Parent.Parent
			if ball then
				for _, b in s.Balls do if b.Model == ball then table.insert(b.Rays, d) end end
			end
		elseif d:IsA("ParticleEmitter") then
			table.insert(s.Emitters, d)
		elseif d:IsA("Motor6D") then
			s.Joints[d.Name] = d
		end
	end
	local stage = c:FindFirstChild("Stage")
	local dj = stage and stage:FindFirstChild("DJ Capy")
	s.DJ = dj
	s.DJScale = dj and dj:FindFirstChild("Head") and dj.Head.Size.Y / 1.25 or 7
	s.DJPos = dj and dj.PrimaryPart and dj.PrimaryPart.Position or Vector3.zero
	return s
end

-- k = 0 (invisible) -> 1 (normal) pour les murs, le plafond, la scène...
local function setFade(s, k)
	for _, e in s.Fade do e[1].Transparency = 1 - (1 - e[2]) * k end
	for _, e in s.Textures do e[1].Transparency = 1 - (1 - e[2]) * k end
	local on = k > 0.55
	for _, g in s.Guis do g.Enabled = on end
	for _, b in s.Beams do b.Enabled = on end
	for _, e in s.Emitters do e.Enabled = on end
end

local function start()
	local root = ReplicatedStorage:FindFirstChild("DiscoEvent")
	local template = root and root:FindFirstChild("Club")
	if not template then warn("[DiscoEventClient] ReplicatedStorage.DiscoEvent.Club introuvable") return false end
	if club then club:Destroy() end -- (sécurité : jamais deux boîtes de nuit)
	local c = template:Clone()
	local s = prepare(c, root)
	setFade(s, 0)
	for _, b in s.Balls do b.Root.CFrame = CFrame.new(b.Home.X, s.CeilY + b.R * 2 + 20, b.Home.Z) end
	c.Parent = fxFolder
	club, state = c, s
	setNight(true)
	return true
end

local function stop()
	local s = state
	setNight(false)
	if not s then return end
	s.Leaving = os.clock() -- la boucle fait remonter les boules et estompe le décor, puis l'enlève
end

---------------------------------------------------------------- œufs mis en lumière (tag "DiscoSpot" posé par le serveur)
local spots = {} -- [œuf] = {objets}
local function clearSpot(egg)
	local sp = spots[egg]
	spots[egg] = nil
	if not sp then return end
	for _, o in sp.Objects do
		if o:IsA("Beam") then
			TweenService:Create(o, TweenInfo.new(0.4), {Width0 = 0, Width1 = 0}):Play()
		end
	end
	task.delay(0.45, function() for _, o in sp.Objects do o:Destroy() end end)
end
local function addSpot(egg)
	if spots[egg] or not state or not egg:IsA("Model") then return end
	local main
	for _, b in state.Balls do if b.Main then main = b end end
	if not main then return end
	local pivot = egg:GetPivot()
	local camera = workspace.CurrentCamera
	if not camera or (camera.CFrame.Position - pivot.Position).Magnitude > SPOT_NEAR then return end
	local h = math.max(egg:GetAttribute("Height") or 3, 1)
	local foot = pivot.Position - Vector3.new(0, h * 0.5, 0)
	local a0, a1, a2 = Instance.new("Attachment"), Instance.new("Attachment"), Instance.new("Attachment")
	a0.WorldPosition = main.Root.Position - Vector3.new(0, main.R, 0)
	a1.WorldPosition = foot
	a2.WorldPosition = foot + Vector3.new(0, 0.3, 0)
	a0.Parent, a1.Parent, a2.Parent = workspace.Terrain, workspace.Terrain, workspace.Terrain
	local color = PALETTE[math.random(#PALETTE)]
	local objects = {a0, a1, a2}
	for i, tex in {"rbxassetid://4509687978", "rbxassetid://1084975295"} do
		local b = Instance.new("Beam")
		b.Attachment0, b.Attachment1 = a0, a1
		b.Texture, b.TextureMode, b.TextureSpeed = tex, Enum.TextureMode.Stretch, i == 2 and 0.8 or 0
		b.FaceCamera, b.LightEmission, b.LightInfluence, b.Segments = true, 1, 0, 1
		b.Color = ColorSequence.new(Color3.new(1, 1, 1), color)
		b.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(0.85, i == 1 and 0.55 or 0.7), NumberSequenceKeypoint.new(1, 0.4)})
		b.Width0, b.Width1 = 0, 0
		b.Parent = a0
		TweenService:Create(b, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Width0 = 5, Width1 = (h * 1.3 + 7) * (i == 1 and 1.4 or 1)}):Play()
		table.insert(objects, b)
	end
	-- cercle de lumière au sol + éclats
	local glints = Instance.new("ParticleEmitter")
	glints.Texture = "rbxassetid://113227300445053"
	glints.Color = ColorSequence.new(Color3.new(1, 1, 1), color)
	glints.LightEmission, glints.LightInfluence = 1, 0
	glints.Rate, glints.Lifetime, glints.Speed = 14, NumberRange.new(0.4, 0.8), NumberRange.new(h * 0.6 + 2, h * 1.2 + 4)
	glints.SpreadAngle = Vector2.new(70, 70)
	glints.EmissionDirection = Enum.NormalId.Top
	glints.Drag = 3
	glints.RotSpeed, glints.Rotation = NumberRange.new(-120, 120), NumberRange.new(0, 360)
	glints.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, 0.5 + h * 0.12), NumberSequenceKeypoint.new(1, 0)})
	glints.Parent = a2
	local ring = Instance.new("ParticleEmitter")
	ring.Texture = "rbxassetid://8271495905"
	ring.Color = ColorSequence.new(color)
	ring.LightEmission, ring.LightInfluence = 1, 0
	ring.Orientation, ring.EmissionDirection = Enum.ParticleOrientation.VelocityPerpendicular, Enum.NormalId.Top
	ring.Speed, ring.Rate, ring.Lifetime = NumberRange.new(0.01), 2.5, NumberRange.new(0.9)
	ring.RotSpeed, ring.Rotation, ring.LockedToPart = NumberRange.new(90), NumberRange.new(0, 360), true
	ring.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, h * 0.8 + 2), NumberSequenceKeypoint.new(1, h * 2 + 6)})
	ring.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.3), NumberSequenceKeypoint.new(1, 1)})
	ring.Parent = a2
	-- piste de danse qui tourne sous l'œuf pendant qu'il est dans la lumière
	local floorDisc = Instance.new("ParticleEmitter")
	floorDisc.Texture = "rbxassetid://71245072274787"
	floorDisc.LightEmission, floorDisc.LightInfluence = 0.8, 0
	floorDisc.Orientation, floorDisc.EmissionDirection = Enum.ParticleOrientation.VelocityPerpendicular, Enum.NormalId.Top
	floorDisc.Speed, floorDisc.Rate, floorDisc.Lifetime = NumberRange.new(0.01), 1.5, NumberRange.new(1.4)
	floorDisc.RotSpeed, floorDisc.Rotation, floorDisc.LockedToPart = NumberRange.new(80), NumberRange.new(0, 360), true
	floorDisc.Size = NumberSequence.new(h * 2.2 + 6)
	floorDisc.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3, 0.35), NumberSequenceKeypoint.new(0.7, 0.35), NumberSequenceKeypoint.new(1, 1)})
	floorDisc.Parent = a2
	local beams = {}
	for _, o in objects do if o:IsA("Beam") then table.insert(beams, o) end end
	spots[egg] = {Objects = objects, Beams = beams, Phase = math.random() * 10, Glints = glints}
end
CollectionService:GetInstanceAddedSignal("DiscoSpot"):Connect(function(egg) task.defer(addSpot, egg) end)
CollectionService:GetInstanceRemovedSignal("DiscoSpot"):Connect(clearSpot)

---------------------------------------------------------------- pulsation : la musique du Disco Event, sinon un tempo fixe
local level, avg, peak = 0, 0, 1
local function pulse(dt, t)
	local music = SoundService:FindFirstChild("SkyEventMusic_Disco")
	local loud = music and music.IsPlaying and music.Volume > 0.05 and music.PlaybackLoudness or nil
	if loud then
		peak = math.max(peak * (1 - dt * 0.05), loud, 1)
		local x = loud / peak
		avg += (x - avg) * math.min(1, dt * 1.5)
		local hit = math.clamp((x - avg) * 3.2, 0, 1)
		level = math.max(level - dt * 3.2, hit)
	else
		local beat = (t * BPM / 60) % 1
		level = math.exp(-beat * 6)
	end
	return level
end

---------------------------------------------------------------- DJ capybara : il mixe (Motor6D animés à la main, pas d'ID d'animation)
-- Repères R6 : épaule droite -> rotation Z positive = bras vers l'avant (gauche : négative) ; cou -> rotation X = hocher la tête ;
-- RootJoint -> translation Z = monter / descendre le buste.
local function animateDJ(s, t, beatLevel)
	local j = s.Joints
	local scale = s.DJScale
	local b = t * BPM / 60
	local beat = b % 1
	local bounce = math.exp(-beat * 5)
	local hype = (b % 32) >= 28 -- les 4 derniers temps de chaque cycle de 8 mesures : les deux bras en l'air
	local groove = math.sin(b * math.pi)
	if j.RootJoint then
		j.RootJoint.Transform = CFrame.new(0, 0, -(0.06 + 0.1 * bounce) * scale) * CFrame.Angles(0.08 + 0.05 * bounce, groove * 0.05, groove * 0.06)
	end
	if j.Neck then
		j.Neck.Transform = CFrame.Angles(0.06 - 0.2 * bounce - 0.06 * beatLevel, 0, math.sin(b * math.pi * 0.5) * 0.18)
	end
	local rs, ls = j["Right Shoulder"], j["Left Shoulder"]
	if hype then
		local wave = math.sin(t * 9) * 0.25
		if rs then rs.Transform = CFrame.Angles(0, 0, 2.7 + wave) end
		if ls then ls.Transform = CFrame.Angles(0, 0, -2.7 + wave) end
	else
		-- main droite : scratch sur la platine (va-et-vient rapide) ; main gauche : potards et faders de la table
		local scratch = math.sin(t * 2 * math.pi * BPM / 60) * 0.22
		local knob = math.sin(b * math.pi * 0.25) * 0.18
		if rs then rs.Transform = CFrame.Angles(0, scratch, 1.12 + 0.06 * bounce) end
		if ls then ls.Transform = CFrame.Angles(0, -0.25 + knob, -1.05 - 0.08 * bounce) end
	end
	local step = math.sin(b * math.pi) * 0.12
	if j["Right Hip"] then j["Right Hip"].Transform = CFrame.Angles(0, 0, step) end
	if j["Left Hip"] then j["Left Hip"].Transform = CFrame.Angles(0, 0, step) end
end

---------------------------------------------------------------- une seule boucle d'animation (rien quand l'event est fini)
local screenClock = 0
RunService.PreSimulation:Connect(function()
	-- (après l'Animator : nos Transform restent pour l'image)
	local s = state
	if s and s.DJ and s.DJ.Parent and not s.Leaving then
		local camera = workspace.CurrentCamera
		if camera and (camera.CFrame.Position - s.DJPos).Magnitude < DJ_NEAR then animateDJ(s, os.clock(), level) end
	end
end)

RunService.RenderStepped:Connect(function(dt)
	local s = state
	if not s then return end
	local t = os.clock()
	local p = pulse(dt, t)
	-- entrée / sortie (fondu du décor, boules qui descendent du plafond ou y remontent)
	local k, drop
	if s.Leaving then
		local u = math.clamp((t - s.Leaving) / FADE_TIME, 0, 1)
		k, drop = 1 - u, u * u
		if u >= 1 then
			for egg in spots do clearSpot(egg) end
			s.Club:Destroy()
			if state == s then state, club = nil, nil end
			return
		end
	else
		local age = t - s.Born
		k = math.clamp(age / FADE_TIME, 0, 1)
		local d = math.clamp(age / DROP_TIME, 0, 1)
		drop = (1 - d) ^ 3
	end
	if math.abs(k - s.Fading) > 0.04 or (k == 1 and s.Fading ~= 1) or (k == 0 and s.Fading ~= 0) then
		s.Fading = k
		setFade(s, k)
	end
	-- boules : rotation lente et élégante, léger flottement, pulsation de la lumière et des faisceaux
	for _, b in s.Balls do
		local high = s.CeilY + b.R * 2 + 20
		local y = b.Home.Y + (high - b.Home.Y) * drop + math.sin(t * 0.6 + b.Home.X * 0.01) * 1.5
		b.Root.CFrame = CFrame.new(b.Home.X, y, b.Home.Z) * CFrame.Angles(0, t * b.Spin, 0) * CFrame.Angles(math.sin(t * 0.21) * 0.05, 0, 0)
		if b.Light then b.Light.Brightness = 1.6 + 2.2 * p end
		for _, r in b.Rays do r.Brightness = 1 + 1.4 * p end
		-- quelques miroirs s'allument un instant (reflets qui scintillent sur la boule), plus nombreux sur le temps fort
		for tile, info in b.Lit do
			if t >= info[3] then tile.Color, tile.Material, b.Lit[tile] = info[1], info[2], nil end
		end
		if #b.Tiles > 0 and drop < 0.2 then
			for _ = 1, (b.Main and 2 or 1) + math.floor(p * 3) do
				local tile = b.Tiles[math.random(#b.Tiles)]
				if not b.Lit[tile] then
					b.Lit[tile] = {tile.Color, tile.Material, t + 0.12 + math.random() * 0.2}
					tile.Material = Enum.Material.Neon
					tile.Color = math.random() < 0.6 and Color3.new(1, 1, 1) or PALETTE[math.random(#PALETTE)]
				end
			end
		end
	end
	-- projecteurs mobiles : chacun balaie la zone sous lui (mouvements lents et doux)
	for i, h in s.Heads do
		local ph = h.Phase
		local target = h.Aim + Vector3.new(math.sin(t * 0.37 + ph) * h.Sweep.X, 0, math.sin(t * 0.29 + ph * 1.7) * h.Sweep.Z)
		h.Target.WorldPosition = target
		h.Head.CFrame = CFrame.lookAt(h.Pos, target) * CFrame.Angles(0, -math.pi / 2, 0)
	end
	-- reflets de la boule qui glissent au plafond et sur les murs ; sol LED dont la couleur tourne
	for _, tex in s.Ceiling do
		if tex.Name == "Stars1" then tex.OffsetStudsU = t * 7 else tex.OffsetStudsV = t * 5 end
	end
	for _, tex in s.Walls do tex.OffsetStudsU = t * 9 end
	local hue = (t * 0.04) % 1
	for _, tex in s.Floors do tex.Color3 = Color3.fromHSV(hue, 0.6, 0.9) end
	if s.StageFloor then s.StageFloor.Color3 = Color3.fromHSV((hue + math.floor(t * BPM / 60) * 0.17) % 1, 0.65, 0.75 + 0.25 * p) end
	-- platines, boutons de la table, membranes des enceintes
	for _, pl in s.Platters do
		pl.Part.CFrame = CFrame.new(pl.Home.Position) * CFrame.Angles(0, t * pl.Spin, 0) * (pl.Home - pl.Home.Position)
	end
	local beatIndex = math.floor(t * BPM / 60)
	for _, pad in s.Pads do
		local on = (beatIndex + pad.Index) % 4 == 0
		pad.Part.Color = on and Color3.new(1, 1, 1) or pad.Color
	end
	for _, cap in s.Caps do cap.Part.CFrame = cap.Home * CFrame.new(-1.2 * p, 0, 0) end
	for _, sp in spots do
		local c = Color3.fromHSV((t * 0.5 + sp.Phase) % 1, 0.7, 1)
		for _, b in sp.Beams do b.Color = ColorSequence.new(Color3.new(1, 1, 1), c) end
		if sp.Glints then sp.Glints.Color = ColorSequence.new(Color3.new(1, 1, 1), c) end
	end
	-- écrans LED : dégradé qui coule, égaliseurs, mini boules (12 images par seconde)
	screenClock += dt
	if screenClock >= 1 / 12 then
		screenClock = 0
		local frame = math.floor(t * 12) % 16
		local offset = Vector2.new(frame % 4 * 128, frame // 4 * 128)
		for _, sp in s.Sprites do sp.ImageRectOffset = offset end
		for _, sc in s.Screens do
			if sc.Flow then sc.Flow.Rotation = (t * 25) % 360 end
			local n = #sc.Bars
			for i, bar in sc.Bars do
				local x = i / n
				local hgt = 0.15 + 0.55 * p * (0.6 + 0.4 * math.sin(x * 9 + t * 3)) + 0.25 * math.abs(math.sin(t * 4.3 + i * 1.7))
				bar.Size = UDim2.new(bar.Size.X.Scale, bar.Size.X.Offset, math.clamp(hgt, 0.08, 1), 0)
			end
		end
	end
end)

---------------------------------------------------------------- l'event commence / finit (idempotent : jamais deux boîtes, jamais deux nuits)
local active = false
while true do
	local w = wanted()
	if w and not active then
		active = start()
		if active then for _, egg in CollectionService:GetTagged("DiscoSpot") do task.spawn(addSpot, egg) end end
	elseif not w and active then
		active = false
		stop()
	end
	task.wait(0.25)
end

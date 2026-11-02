-- ConcertEventClient : tout ce qu'on voit et entend pendant l'event CONCERT (lancé par ConcertEventServer)
--  * chaque zone d'oeufs devient une scène : tours de lumières en studs avec projecteurs qui balayent, lasers,
--    boule disco géante, couleurs qui changent sur le rythme
--  * ambiance de soirée (écran plus sombre et plus coloré) + musique de concert
--  * j'aime lancés par les danseurs : explosion de confettis + cris de la foule si l'oeuf prend le trait LIKE x5
--  * la musique de fond "Days" est mise en pause jusqu'à la fin de l'event
--  * HUD en bas à droite : image (micro), "CONCERT" et le temps restant
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local assets = ReplicatedStorage:WaitForChild("ConcertAssets")
local fxRemote = ReplicatedStorage:WaitForChild("ConcertFx")
local rgb = Color3.fromRGB
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)

local COLORS = {rgb(255, 60, 200), rgb(80, 220, 255), rgb(255, 230, 70), rgb(140, 80, 255), rgb(80, 255, 140), rgb(255, 120, 40)}
local BPM = 124
local BEAT = 60 / BPM
local ANIM_RANGE = 650 -- on n'anime que les zones proches de la caméra

local function color(t, offset) -- couleur qui change sur le rythme
	local i = math.floor(t / (BEAT * 2) + (offset or 0)) % #COLORS + 1
	return COLORS[i]
end

local function studs(p)
	p.TopSurface, p.FrontSurface, p.BackSurface, p.LeftSurface, p.RightSurface = Enum.SurfaceType.Studs, Enum.SurfaceType.Studs, Enum.SurfaceType.Studs, Enum.SurfaceType.Studs, Enum.SurfaceType.Studs
	p.BottomSurface = Enum.SurfaceType.Inlet
end
local function part(parent, props)
	local p = Instance.new("Part")
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
	for k, v in props do p[k] = v end
	p.Parent = parent
	return p
end
-- cylindre (axe X) qui va de a à b
local function beamCF(a, b)
	return CFrame.lookAt((a + b) / 2, b) * CFrame.Angles(0, math.rad(90), 0)
end

---------------------------------------------------------------- LA SCÈNE DE CHAQUE ZONE
local stages = {} -- {zone, center, radius, lamps = {}, lasers = {}, disco}
local stageFolder

local function buildStage(zone)
	local half = zone.Size / 2
	local top = zone.Position.Y + half.Y
	local center = Vector3.new(zone.Position.X, top, zone.Position.Z)
	local folder = Instance.new("Folder")
	folder.Name = zone.Name
	folder.Parent = stageFolder
	local st = {zone = zone, center = center, radius = math.max(half.X, half.Z), lamps = {}, lasers = {}, folder = folder}
	local TOWER_H = 34
	local inset = 5
	local corners = {
		Vector3.new(-half.X + inset, 0, -half.Z + inset), Vector3.new(half.X - inset, 0, -half.Z + inset),
		Vector3.new(-half.X + inset, 0, half.Z - inset), Vector3.new(half.X - inset, 0, half.Z - inset),
	}
	for i, c in corners do
		local base = center + c
		-- tour en studs (treillis) : 4 montants + barres
		for _, o in {Vector3.new(-1.2, 0, -1.2), Vector3.new(1.2, 0, -1.2), Vector3.new(-1.2, 0, 1.2), Vector3.new(1.2, 0, 1.2)} do
			local p = part(folder, {Size = Vector3.new(0.6, TOWER_H, 0.6), CFrame = CFrame.new(base + o + Vector3.new(0, TOWER_H / 2, 0)), Color = rgb(45, 45, 52), Material = Enum.Material.Metal})
			studs(p)
		end
		for y = 4, TOWER_H, 6 do
			local p = part(folder, {Size = Vector3.new(3, 0.4, 3), CFrame = CFrame.new(base + Vector3.new(0, y, 0)), Color = rgb(60, 60, 70), Material = Enum.Material.Metal})
			studs(p)
		end
		local plate = part(folder, {Size = Vector3.new(4, 1, 4), CFrame = CFrame.new(base + Vector3.new(0, TOWER_H + 0.5, 0)), Color = rgb(30, 30, 35)})
		studs(plate)
		-- tête lumineuse (projecteur) + son faisceau
		local headPos = base + Vector3.new(0, TOWER_H + 2.2, 0)
		local head = part(folder, {Size = Vector3.new(2.4, 2.4, 3.2), CFrame = CFrame.new(headPos), Color = rgb(25, 25, 30)})
		studs(head)
		local lens = part(folder, {Size = Vector3.new(1.8, 1.8, 0.3), CFrame = CFrame.new(headPos), Material = Enum.Material.Neon, Color = COLORS[i]})
		local glow = part(folder, {Shape = Enum.PartType.Cylinder, Size = Vector3.new(80, 7, 7), Material = Enum.Material.Neon, Transparency = 0.82, Color = COLORS[i], CFrame = CFrame.new(headPos)})
		local core = part(folder, {Shape = Enum.PartType.Cylinder, Size = Vector3.new(80, 1.6, 1.6), Material = Enum.Material.Neon, Transparency = 0.45, Color = COLORS[i], CFrame = CFrame.new(headPos)})
		local spot = Instance.new("SpotLight")
		spot.Face = Enum.NormalId.Front
		spot.Range, spot.Angle, spot.Brightness, spot.Shadows = 90, 28, 6, false
		spot.Parent = lens
		table.insert(st.lamps, {pos = headPos, head = head, lens = lens, glow = glow, core = core, spot = spot, phase = i * 1.7, side = (i % 2 == 0) and 1 or -1})
	end
	-- lasers entre les tours (ils balayent la zone)
	for i = 1, 6 do
		local from = st.lamps[(i - 1) % 4 + 1].pos + Vector3.new(0, 0.5, 0)
		local laser = part(folder, {Size = Vector3.new(0.25, 0.25, 10), Material = Enum.Material.Neon, Color = COLORS[(i % #COLORS) + 1], CFrame = CFrame.new(from)})
		table.insert(st.lasers, {from = from, part = laser, phase = i * 1.3})
	end
	-- boule disco géante au-dessus du centre
	local discoPos = center + Vector3.new(0, 46, 0)
	local disco = Instance.new("Model")
	disco.Name = "DiscoBall"
	local ball = part(disco, {Size = Vector3.new(7, 7, 7), CFrame = CFrame.new(discoPos), Color = rgb(210, 215, 230), Material = Enum.Material.Metal, Reflectance = 0.4})
	studs(ball)
	for _, s in {Vector3.new(7.6, 3.2, 3.2), Vector3.new(3.2, 7.6, 3.2), Vector3.new(3.2, 3.2, 7.6)} do
		local p = part(disco, {Size = s, CFrame = CFrame.new(discoPos), Color = rgb(235, 240, 255), Material = Enum.Material.Metal, Reflectance = 0.5})
		studs(p)
	end
	part(disco, {Size = Vector3.new(0.3, 30, 0.3), CFrame = CFrame.new(discoPos + Vector3.new(0, 18.5, 0)), Color = rgb(40, 40, 45)})
	disco.PrimaryPart = ball
	local dl = Instance.new("PointLight") dl.Range, dl.Brightness = 40, 3 dl.Parent = ball
	local sp = Instance.new("ParticleEmitter")
	sp.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	sp.LightEmission = 1
	sp.Rate = 25
	sp.Lifetime = NumberRange.new(1.5, 2.5)
	sp.Speed = NumberRange.new(15, 30)
	sp.SpreadAngle = Vector2.new(180, 180)
	sp.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 0)})
	sp.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, COLORS[1]), ColorSequenceKeypoint.new(0.5, COLORS[2]), ColorSequenceKeypoint.new(1, COLORS[3])})
	sp.Parent = ball
	disco.Parent = folder
	st.disco = {model = disco, pos = discoPos, light = dl}
	-- tout s'allume d'un coup (fondu)
	for _, d in folder:GetDescendants() do
		if d:IsA("BasePart") then
			local target = d.Transparency
			d.Transparency = 1
			TweenService:Create(d, TweenInfo.new(1.2), {Transparency = target}):Play()
		end
	end
	table.insert(stages, st)
end

local function animateStage(st, t)
	for i, l in st.lamps do
		-- le projecteur balaye la zone en suivant le rythme
		local a = t * 0.7 + l.phase
		local r = st.radius * (0.25 + 0.45 * (0.5 + 0.5 * math.sin(t * 0.9 + l.phase)))
		local target = st.center + Vector3.new(math.cos(a) * r * l.side, 0, math.sin(a * 1.3) * r)
		local dir = (target - l.pos).Unit
		local c = color(t, i)
		local hit = l.pos + dir * 80
		l.head.CFrame = CFrame.lookAt(l.pos, target)
		l.lens.CFrame = CFrame.lookAt(l.pos + dir * 1.65, target)
		l.glow.CFrame = beamCF(l.pos, hit)
		l.core.CFrame = l.glow.CFrame
		l.lens.Color, l.glow.Color, l.core.Color, l.spot.Color = c, c, c, c
		-- flash sur le temps fort
		local pulse = 1 - ((t % BEAT) / BEAT)
		l.glow.Transparency = 0.86 - pulse * 0.08
	end
	for _, z in st.lasers do
		local a = t * 1.6 + z.phase
		local target = st.center + Vector3.new(math.cos(a) * st.radius * 0.8, 2 + math.abs(math.sin(a * 2)) * 6, math.sin(a * 0.8) * st.radius * 0.8)
		local len = (target - z.from).Magnitude
		z.part.Size = Vector3.new(0.25, 0.25, len)
		z.part.CFrame = CFrame.lookAt((z.from + target) / 2, target)
		z.part.Color = color(t * 1.5, z.phase)
	end
	if st.disco then
		st.disco.model:PivotTo(CFrame.new(st.disco.pos) * CFrame.Angles(0, t * 0.8, 0))
		st.disco.light.Color = color(t, 3)
	end
end

---------------------------------------------------------------- AMBIANCE + MUSIQUE
local cc, music
local pausedDays -- musique de fond "Days" mise en pause pendant le concert
local function startAmbience()
	local days = SoundService:FindFirstChild("Days")
	if days and days.IsPlaying then
		days:Pause()
		pausedDays = days
	end
	cc = Instance.new("ColorCorrectionEffect")
	cc.Name = "ConcertAmbience"
	cc.Parent = Lighting
	TweenService:Create(cc, TweenInfo.new(2), {Brightness = -0.06, Contrast = 0.18, Saturation = 0.25, TintColor = rgb(235, 215, 255)}):Play()
	music = assets:FindFirstChild("Music") and assets.Music:Clone()
	if music then
		local target = music.Volume
		music.Volume = 0
		music.Parent = SoundService
		music:Play()
		TweenService:Create(music, TweenInfo.new(3), {Volume = target}):Play()
	end
end
local function stopAmbience()
	-- la musique "Days" reprend à la fin de l'event
	if pausedDays and pausedDays.Parent then pausedDays:Resume() end
	pausedDays = nil
	if cc then
		local old = cc
		cc = nil
		TweenService:Create(old, TweenInfo.new(1.5), {Brightness = 0, Contrast = 0, Saturation = 0, TintColor = Color3.new(1, 1, 1)}):Play()
		Debris:AddItem(old, 1.6)
	end
	if music then
		local old = music
		music = nil
		TweenService:Create(old, TweenInfo.new(2), {Volume = 0}):Play()
		Debris:AddItem(old, 2.1)
	end
end

---------------------------------------------------------------- HUD EN BAS À DROITE
local hud = Instance.new("Frame")
hud.Name = "ConcertHud"
hud.BackgroundTransparency = 1
hud.Size = UDim2.fromOffset(170, 54)
hud.Visible = false
hud:GetPropertyChangedSignal("Visible"):Connect(function() -- le dernier event arrivé se place au-dessus des autres
	if hud.Visible then hud.LayoutOrder = -math.floor(os.clock() * 10) end
end)
-- image : un micro en studs, vu dans un ViewportFrame
local view = Instance.new("ViewportFrame")
view.BackgroundTransparency = 1
view.Size = UDim2.fromOffset(54, 54)
view.Ambient = rgb(200, 190, 220)
view.LightColor = rgb(255, 240, 255)
view.LightDirection = Vector3.new(-0.4, -0.6, -1)
view.Parent = hud
do
	local mic = Instance.new("Model")
	local function p(size, cf, c, mat)
		local x = Instance.new("Part") x.Anchored = true x.Size = size x.CFrame = cf x.Color = c x.Material = mat or Enum.Material.Plastic studs(x) x.Parent = mic return x
	end
	local tilt = CFrame.Angles(0, 0, math.rad(-25))
	p(Vector3.new(0.7, 3, 0.7), tilt * CFrame.new(0, -1.2, 0), rgb(35, 35, 40))
	p(Vector3.new(0.9, 0.5, 0.9), tilt * CFrame.new(0, 0.4, 0), rgb(255, 60, 200), Enum.Material.Neon)
	p(Vector3.new(1.6, 1.6, 1.6), tilt * CFrame.new(0, 1.3, 0), rgb(190, 195, 210), Enum.Material.Metal)
	p(Vector3.new(1.7, 0.3, 1.7), tilt * CFrame.new(0, 1.3, 0), rgb(120, 125, 140), Enum.Material.Metal)
	for _, n in {Vector3.new(-1.6, 1.8, 0), Vector3.new(1.4, 2.4, 0), Vector3.new(1.7, 0.6, 0)} do
		p(Vector3.new(0.35, 0.6, 0.2), CFrame.new(n), rgb(80, 220, 255), Enum.Material.Neon)
	end
	mic.Parent = view
	local cam = Instance.new("Camera")
	cam.FieldOfView = 40
	cam.CFrame = CFrame.lookAt(Vector3.new(0, 0.6, -9), Vector3.new(0, 0.6, 0))
	cam.Parent = view
	view.CurrentCamera = cam
end
local function label(textStr, pos, size, col, thickness)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Position, l.Size = pos, size
	l.FontFace = FONT
	l.Text = textStr
	l.TextScaled = true
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.TextColor3 = col
	local s = Instance.new("UIStroke") s.Thickness = thickness s.Parent = l
	l.Parent = hud
	return l
end
local title = label("CONCERT", UDim2.fromOffset(58, 5), UDim2.new(1, -58, 0, 15), Color3.new(1, 1, 1), 2)
local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, COLORS[1]), ColorSequenceKeypoint.new(0.5, COLORS[2]), ColorSequenceKeypoint.new(1, COLORS[3])})
titleGradient.Parent = title
local timer = label("00:00", UDim2.fromOffset(58, 20), UDim2.new(1, -58, 0, 30), Color3.new(1, 1, 1), 3)
task.spawn(function()
	hud.Parent = player:WaitForChild("PlayerGui"):WaitForChild("EventStackGui"):WaitForChild("Stack")
end)

local function clock(seconds)
	seconds = math.max(0, math.ceil(seconds))
	local h, m, s = seconds // 3600, seconds % 3600 // 60, seconds % 60
	return h > 0 and string.format("%d:%02d:%02d", h, m, s) or string.format("%02d:%02d", m, s)
end

---------------------------------------------------------------- COUPS DE PROJECTEUR SUR LES OEUFS
local function confetti(position, size)
	local at = Instance.new("Attachment")
	at.WorldPosition = position
	at.Parent = workspace.Terrain
	local e = Instance.new("ParticleEmitter")
	e.Rate = 0
	e.Lifetime = NumberRange.new(1.5, 2.5)
	e.Speed = NumberRange.new(20, 40)
	e.SpreadAngle = Vector2.new(60, 60)
	e.EmissionDirection = Enum.NormalId.Top
	e.Acceleration = Vector3.new(0, -30, 0)
	e.Drag = 1.5
	e.RotSpeed = NumberRange.new(-300, 300)
	e.Rotation = NumberRange.new(0, 360)
	e.Size = NumberSequence.new(size)
	e.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, COLORS[1]), ColorSequenceKeypoint.new(0.25, COLORS[2]), ColorSequenceKeypoint.new(0.5, COLORS[3]), ColorSequenceKeypoint.new(0.75, COLORS[4]), ColorSequenceKeypoint.new(1, COLORS[5])})
	e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	e.LightEmission = 0.5
	e.Parent = at
	e:Emit(90)
	Debris:AddItem(at, 3)
end

local activeSpots = {}
fxRemote.OnClientEvent:Connect(function(kind, pos, height, success)
	if not stageFolder then return end
	local near = (camera.CFrame.Position - pos).Magnitude < ANIM_RANGE * 1.5
	if not near then return end
	height = height or 3
	local top = pos + Vector3.new(0, 90, 0)
	if kind == "aim" then
		-- le faisceau cherche l'oeuf puis se pose dessus
		local key = tostring(pos)
		local beam = part(stageFolder, {Shape = Enum.PartType.Cylinder, Material = Enum.Material.Neon, Color = Color3.new(1, 1, 1), Transparency = 0.6, Size = Vector3.new(90, height + 4, height + 4)})
		local light = Instance.new("PointLight") light.Range = 12 + height * 2 light.Brightness = 4 light.Parent = beam
		local start = os.clock()
		local conn
		conn = RunService.RenderStepped:Connect(function()
			local k = math.min(1, (os.clock() - start) / 1.1)
			local wobble = (1 - k) * 18
			local aimAt = pos + Vector3.new(math.sin(os.clock() * 9) * wobble, 0, math.cos(os.clock() * 7) * wobble)
			beam.CFrame = beamCF(top, aimAt + (aimAt - top).Unit * 2)
		end)
		activeSpots[key] = {beam = beam, conn = conn}
		task.delay(3, function()
			if activeSpots[key] and activeSpots[key].beam == beam then
				conn:Disconnect()
				beam:Destroy()
				activeSpots[key] = nil
			end
		end)
	elseif kind == "result" then
		local key = tostring(pos)
		local s = activeSpots[key]
		if s then
			activeSpots[key] = nil
			s.conn:Disconnect()
			local finalColor = success and COLORS[1] or rgb(150, 150, 160)
			s.beam.Color = finalColor
			TweenService:Create(s.beam, TweenInfo.new(success and 1.4 or 0.5), {Transparency = 1, Size = s.beam.Size * Vector3.new(1, success and 2.5 or 0.3, success and 2.5 or 0.3)}):Play()
			Debris:AddItem(s.beam, 1.5)
		end
		if success then
			confetti(pos + Vector3.new(0, height / 2, 0), 0.6 + height * 0.05)
			local ring = part(stageFolder, {Shape = Enum.PartType.Cylinder, Material = Enum.Material.Neon, Color = COLORS[2], Transparency = 0.2,
				Size = Vector3.new(0.3, 2, 2), CFrame = CFrame.new(pos - Vector3.new(0, height / 2 - 0.3, 0)) * CFrame.Angles(0, 0, math.rad(90))})
			TweenService:Create(ring, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(0.3, 30 + height * 3, 30 + height * 3), Transparency = 1}):Play()
			Debris:AddItem(ring, 0.9)
			local cheer = assets:FindFirstChild("Cheer")
			if cheer and (camera.CFrame.Position - pos).Magnitude < 250 then
				local c = cheer:Clone() c.Parent = SoundService c:Play() Debris:AddItem(c, 8)
			end
		end
	end
end)

---------------------------------------------------------------- MARCHE / ARRÊT DE L'EVENT
local running = false
local function startConcert()
	if running then return end
	running = true
	stageFolder = Instance.new("Folder")
	stageFolder.Name = "ConcertStages"
	stageFolder.Parent = workspace
	stages = {}
	for _, zone in CollectionService:GetTagged("EggZoneArea") do
		if zone:IsA("BasePart") then pcall(buildStage, zone) end
	end
	startAmbience()
end
local function stopConcert()
	if not running then return end
	running = false
	stopAmbience()
	local f = stageFolder
	stageFolder = nil
	stages = {}
	if f then
		for _, d in f:GetDescendants() do
			if d:IsA("BasePart") then TweenService:Create(d, TweenInfo.new(1), {Transparency = 1}):Play() end
		end
		Debris:AddItem(f, 1.1)
	end
end

RunService.RenderStepped:Connect(function()
	local t = os.clock()
	if running then
		local camPos = camera.CFrame.Position
		for _, st in stages do
			local near = (camPos - st.center).Magnitude < ANIM_RANGE + st.radius
			if near ~= st.shown then
				st.shown = near
				st.folder.Parent = near and stageFolder or nil -- les scènes lointaines sont retirées (performances)
			end
			if near then animateStage(st, t) end
		end
		titleGradient.Rotation = (t * 120) % 360
		-- si la musique "Days" redémarre pendant le concert (joueur qui vient d'arriver...), on la remet en pause
		local days = SoundService:FindFirstChild("Days")
		if days and days.IsPlaying then
			days:Pause()
			pausedDays = days
		end
	end
	-- petites boules disco des oeufs qui ont la mutation : elles tournent et changent de couleur
	for _, disco in CollectionService:GetTagged("ConcertDisco") do
		local root = disco.PrimaryPart
		if root then
			local l = root:FindFirstChild("ConcertLight")
			if l then l.Color = color(t, disco:GetAttribute("Seed") or 0) end
			disco:PivotTo(CFrame.new(disco:GetPivot().Position) * CFrame.Angles(0, t * 1.5, 0))
		end
	end
end)

local function refresh()
	if ReplicatedStorage:GetAttribute("ConcertTime") then startConcert() else stopConcert() end
end
ReplicatedStorage:GetAttributeChangedSignal("ConcertTime"):Connect(refresh)
refresh()

while true do
	local endAt = ReplicatedStorage:GetAttribute("ConcertEventEnd")
	local left = type(endAt) == "number" and endAt - workspace:GetServerTimeNow() or 0
	if left > 0 then
		timer.Text = clock(left)
		hud.Visible = true
	else
		hud.Visible = false
	end
	task.wait(0.2)
end

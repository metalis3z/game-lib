-- Cinématique d'arrivée, jouée une fois aux nouveaux joueurs (attribut TutorialDone = false), avant le tutoriel.
--   1. Forêt d'Halloween (Workspace.IntroForest) : le gardien de la dernière zone arrive du fond en bondissant d'arbre en arbre,
--      se pose devant la caméra, rugit, puis charge.
--   2. La dernière zone, vue d'en haut.
--   3. Survol de toutes les zones, de la dernière à la première, avec leur nom.
-- Bouton SKIP carré en bas à droite. Le serveur (IntroServer) charge le décor là où est la caméra et pose le boss.
-- Attribut du joueur IntroState ("playing" / "done" / "none") : le tutoriel (TutorialClient) attend la fin.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local ContextActionService = game:GetService("ContextActionService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local system = ReplicatedStorage:WaitForChild("IntroSystem")
local Config = require(system:WaitForChild("IntroConfig"))
local stage = system:WaitForChild("Stage")
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))

local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local STUDS = "rbxassetid://7447638591"
local rgb = Color3.fromRGB
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
-- éclairage de la forêt : nuit violette et brume (posé sur cet écran seulement, puis remis comme avant)
local NIGHT = {ClockTime = 0.4, Brightness = 2.4, Ambient = rgb(168, 132, 226), OutdoorAmbient = rgb(140, 112, 200), FogColor = rgb(58, 36, 96), FogStart = 140, FogEnd = 640, ExposureCompensation = 0.7}

local playing, skipped = false, false

---------------------------------------------------------------- interface : bandes noires, titres, fondu, bouton SKIP
local function buildGui()
	local gui = Instance.new("ScreenGui")
	gui.Name = "IntroGui"
	gui.DisplayOrder = 500
	gui.IgnoreGuiInset = true
	gui.ResetOnSpawn = false
	local function frame(name, color, transparency, position, size, z)
		local f = Instance.new("Frame")
		f.Name = name
		f.BackgroundColor3, f.BackgroundTransparency, f.BorderSizePixel = color, transparency, 0
		f.Position, f.Size, f.ZIndex = position, size, z
		f.Parent = gui
		return f
	end
	frame("BarTop", BLACK, 0, UDim2.fromScale(0, 0), UDim2.fromScale(1, 0.09), 2)
	frame("BarBottom", BLACK, 0, UDim2.fromScale(0, 0.91), UDim2.fromScale(1, 0.09), 2)
	local fade = frame("Fade", BLACK, 0, UDim2.fromScale(0, 0), UDim2.fromScale(1, 1), 10)
	local function text(name, position, size, textSize, thickness)
		local l = Instance.new("TextLabel")
		l.Name = name
		l:SetAttribute("No3D", true) -- ces textes s'effacent en fondu : pas de relief Text3D
		l.BackgroundTransparency = 1
		l.AnchorPoint = Vector2.new(0.5, 0.5)
		l.Position, l.Size = position, size
		l.FontFace = FONT
		l.Text = ""
		l.TextSize = textSize
		l.TextColor3 = WHITE
		l.TextTransparency = 1
		l.ZIndex = 5
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = thickness
		stroke.Transparency = 1
		stroke.Parent = l
		local scale = Instance.new("UIScale")
		scale.Parent = l
		l.Parent = gui
		return l
	end
	local title = text("Title", UDim2.fromScale(0.5, 0.74), UDim2.new(0.9, 0, 0, 80), 68, 6)
	local sub = text("Sub", UDim2.fromScale(0.5, 0.84), UDim2.new(0.9, 0, 0, 40), 30, 4)

	-- bouton SKIP : carré, en bas à droite, dans le style des boutons du jeu
	local skip = Instance.new("TextButton")
	skip.Name = "Skip"
	skip.AnchorPoint = Vector2.new(1, 1)
	skip.Position = UDim2.new(1, -26, 1, -26)
	skip.Size = UDim2.fromOffset(96, 96)
	skip.BackgroundColor3 = WHITE
	skip.BorderSizePixel = 0
	skip.Text = ""
	skip.AutoButtonColor = false
	skip.ZIndex = 20
	local fill = Instance.new("UIGradient")
	fill.Rotation = 90
	fill.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 160, 140)), ColorSequenceKeypoint.new(0.55, rgb(232, 52, 52)), ColorSequenceKeypoint.new(1, rgb(170, 26, 36))})
	fill.Parent = skip
	local outline = Instance.new("UIStroke")
	outline.Thickness = 5
	outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	outline.Parent = skip
	local studs = Instance.new("ImageLabel")
	studs.BackgroundTransparency = 1
	studs.Size = UDim2.fromScale(1, 1)
	studs.Image, studs.ScaleType, studs.TileSize, studs.ImageTransparency = STUDS, Enum.ScaleType.Tile, UDim2.fromOffset(32, 32), 0.72
	studs.ZIndex = 20
	studs.Parent = skip
	local inner = Instance.new("Frame")
	inner.BackgroundTransparency = 1
	inner.Position, inner.Size = UDim2.fromOffset(6, 6), UDim2.new(1, -12, 1, -12)
	inner.ZIndex = 21
	local line = Instance.new("UIStroke")
	line.Thickness = 3
	line.Color, line.Transparency = WHITE, 0.45
	line.Parent = inner
	inner.Parent = skip
	local function buttonText(str, position, size)
		local l = Instance.new("TextLabel")
		l.BackgroundTransparency = 1
		l.Position, l.Size = position, size
		l.FontFace = FONT
		l.Text, l.TextScaled, l.TextColor3 = str, true, WHITE
		l.ZIndex = 22
		local s = Instance.new("UIStroke")
		s.Thickness = 3
		s.Parent = l
		l.Parent = skip
	end
	buttonText(">>", UDim2.fromScale(0.16, 0.1), UDim2.fromScale(0.68, 0.46))
	buttonText("SKIP", UDim2.fromScale(0.1, 0.54), UDim2.fromScale(0.8, 0.34))
	skip.Activated:Connect(function() skipped = true end)
	skip.Parent = gui
	gui.Parent = playerGui
	return {Gui = gui, Fade = fade, Title = title, Sub = sub}
end

local function fadeTo(ui, transparency, seconds)
	TweenService:Create(ui.Fade, TweenInfo.new(seconds), {BackgroundTransparency = transparency}):Play()
end
local function showTitle(ui, main, sub, color)
	for _, entry in {{ui.Title, main, color}, {ui.Sub, sub, WHITE}} do
		local label = entry[1]
		label.Text = entry[2]
		label.TextColor3 = entry[3]
		label.TextTransparency = 0
		label.UIStroke.Transparency = 0
		label.UIScale.Scale = 0.5
		TweenService:Create(label.UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	end
end
local function hideTitle(ui, seconds)
	for _, label in {ui.Title, ui.Sub} do
		TweenService:Create(label, TweenInfo.new(seconds), {TextTransparency = 1}):Play()
		TweenService:Create(label.UIStroke, TweenInfo.new(seconds), {Transparency = 1}):Play()
	end
end

---------------------------------------------------------------- outils de mise en scène
-- attend "seconds" en appelant step(avancement 0..1, dt) à chaque image ; false si le joueur a appuyé sur SKIP
local function hold(seconds, step)
	local t = 0
	while t < seconds do
		if skipped then return false end
		local dt = RunService.RenderStepped:Wait()
		t += dt
		if step then step(math.min(t / seconds, 1), dt) end
	end
	return not skipped
end

local savedLight
local function night(on)
	if on then
		savedLight = savedLight or {}
		for key, value in NIGHT do
			if savedLight[key] == nil then savedLight[key] = Lighting[key] end
			Lighting[key] = value
		end
	elseif savedLight then
		for key, value in savedLight do Lighting[key] = value end
		savedLight = nil
	end
end

local function boom(volume)
	local assets = ReplicatedStorage:FindFirstChild("CutsceneAssets")
	local source = assets and assets:FindFirstChild("BoomSound")
	if not source then return end
	local s = source:Clone()
	s.Volume = volume
	s.Parent = SoundService
	s:Play()
	Debris:AddItem(s, 4)
end

local function dust(position, amount, size)
	local part = Instance.new("Part")
	part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.Transparency = true, false, false, false, 1
	part.Size = Vector3.new(size * 3, 1, size * 3)
	part.CFrame = CFrame.new(position)
	part.Parent = workspace
	local e = Instance.new("ParticleEmitter")
	e.Texture = "rbxasset://textures/particles/smoke_main.dds"
	e.Color = ColorSequence.new(rgb(150, 120, 190), rgb(70, 50, 100))
	e.LightEmission = 0.2
	e.Rate = 0
	e.Lifetime = NumberRange.new(0.8, 1.6)
	e.Speed = NumberRange.new(size * 1.5, size * 4)
	e.SpreadAngle = Vector2.new(80, 80)
	e.Drag = 2
	e.Rotation, e.RotSpeed = NumberRange.new(0, 360), NumberRange.new(-60, 60)
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, size), NumberSequenceKeypoint.new(1, size * 2.6)})
	e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 1)})
	e.Parent = part
	e:Emit(amount)
	Debris:AddItem(part, 2)
end

-- pose le boss : "ground" = le point sous ses pattes, dir = la direction (à plat) vers laquelle il avance, pitch = cabré / piqué.
-- Sa vitesse est donnée à la racine : PumpkingClient s'en sert pour animer ses pattes et ses ailes.
local function setBoss(root, ground, dir, pitch, velocity)
	local feet = CFrame.lookAt(ground, ground - dir) * CFrame.Angles(pitch, 0, 0) -- le modèle regarde vers +Z
	root.CFrame = feet * root.PivotOffset:Inverse()
	root.AssemblyLinearVelocity = velocity
end

-- les zones, de la première à la dernière : {X, Z, Top, SizeX, SizeZ, Color}, publiées par IntroServer
-- (leurs pièces sont trop loin pour être toujours chargées sur cet écran)
local function zonesByX()
	local ok, list = pcall(function() return HttpService:JSONDecode(system:GetAttribute("Zones")) end)
	return ok and list or {}
end

---------------------------------------------------------------- les trois scènes
local function forestScene(ui, camera)
	local forest = workspace:WaitForChild("IntroForest", 12)
	local boss = workspace:WaitForChild("IntroBoss", 12)
	local spot = forest and forest:WaitForChild("CameraSpot", 8)
	local land = forest and forest:WaitForChild("BossLand", 2)
	local start = forest and forest:WaitForChild("BossStart", 2)
	local root = boss and (boss.PrimaryPart or boss:WaitForChild("Root", 6))
	if not (spot and land and start and root) then return true end -- décor pas arrivé : on passe à la suite
	local points = {start.Position}
	for i = 1, 6 do
		local perch = forest:WaitForChild("Perch" .. i, 4) -- (le décor arrive par paquets : on attend chaque cime)
		if perch then table.insert(points, perch.Position) end
	end
	table.insert(points, land.Position)

	night(true)
	local eye = spot.Position
	local far = eye + Vector3.new(260, 14, -6)
	local shake = 0
	local bossAt = points[1]
	local push = 0
	local function film(dt)
		night(true) -- (le serveur peut réécrire l'heure pendant la scène)
		shake = math.max(0, shake - dt * 2.4)
		push = math.min(push + dt * 1.1, 14)
		local look = far:Lerp(bossAt + Vector3.new(0, 12, 0), 0.6)
		local jitter = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5) * shake
		camera.CFrame = CFrame.lookAt(eye + Vector3.new(push, 0, 0) + jitter, look + jitter)
	end
	local toCamera = Vector3.new(-1, 0, 0)
	setBoss(root, bossAt, toCamera, 0, Vector3.zero)
	camera.FieldOfView = 58
	fadeTo(ui, 1, 1.1)
	if not hold(1.3, function(_, dt) film(dt) end) then return false end

	for i = 2, #points do
		local from, to = points[i - 1], points[i]
		local flat = (to - from) * Vector3.new(1, 0, 1)
		local dir = flat.Magnitude > 0.1 and flat.Unit or toCamera
		-- il se ramasse...
		boss:SetAttribute("Jump", true)
		if not hold(i == 2 and 0.2 or Config.PerchTime, function(_, dt)
			setBoss(root, from, dir, 0, Vector3.zero)
			film(dt)
		end) then return false end
		-- ...et bondit
		boss:SetAttribute("Jump", nil)
		boss:SetAttribute("Flying", true)
		local last = i == #points
		local duration = last and Config.LeapTime * 1.25 or Config.LeapTime
		local arc = 14 + flat.Magnitude * 0.16
		local speed = flat.Magnitude / duration
		if not hold(duration, function(u, dt)
			bossAt = from:Lerp(to, u) + Vector3.new(0, arc * 4 * u * (1 - u), 0)
			local rise = (to.Y - from.Y) / duration + arc * 4 * (1 - 2 * u) / duration
			setBoss(root, bossAt, dir, -math.atan2(rise, speed) * 0.5, dir * speed + Vector3.new(0, rise, 0))
			film(dt)
		end) then return false end
		boss:SetAttribute("Flying", nil)
		bossAt = to
		setBoss(root, to, last and toCamera or dir, 0, Vector3.zero)
		shake = last and 2.6 or 0.9
		boom(last and 1 or 0.35)
		dust(to, last and 40 or 14, last and 9 or 5)
	end

	-- posé devant la caméra : il rugit deux fois (la caméra s'approche de sa tête et tremble), son nom s'affiche
	showTitle(ui, string.upper(Config.Boss), "Guardian of the last zone", rgb(255, 150, 40))
	local head = bossAt + Vector3.new(0, 15, 0)
	local roaring = false
	if not hold(Config.RoarTime, function(u, dt)
		local t = u * Config.RoarTime
		local want = (t > 0.25 and t < 1.3) or (t > 1.6 and t < 2.7) -- PumpkingClient rugit quand l'attribut Chasing s'allume
		if want ~= roaring then
			roaring = want
			boss:SetAttribute("Chasing", want or nil)
			if want then boom(0.7) end
		end
		if roaring then shake = math.max(shake, 1.3) end
		setBoss(root, bossAt, toCamera, 0, Vector3.zero)
		film(dt)
		-- la caméra avance vers lui et se resserre
		local s = u * u * (3 - 2 * u)
		local eyeNow = camera.CFrame.Position
		camera.CFrame = CFrame.lookAt(eyeNow + (head - eyeNow) * 0.22 * s, camera.CFrame.Position + camera.CFrame.LookVector * 40 + (head - eyeNow).Unit * 30 * s)
		camera.FieldOfView = 58 - 10 * s
	end) then return false end
	boss:SetAttribute("Chasing", true)
	-- puis il charge droit sur la caméra
	hideTitle(ui, 0.25)
	fadeTo(ui, 0, 0.5)
	local from = bossAt
	local ok = hold(0.55, function(u, dt)
		bossAt = from + toCamera * (u * u * 46)
		setBoss(root, bossAt, toCamera, 0, toCamera * 80)
		film(dt)
	end)
	boss:SetAttribute("Chasing", nil)
	return ok
end

local function lastZoneScene(ui, camera, zones)
	stage:FireServer("lastzone")
	local zone = zones[#zones]
	local edge = zone.X + zone.SizeX / 2
	local z = zone.Z
	local target = Vector3.new(zone.X - 12, zone.Top + 6, z)
	night(false)
	camera.FieldOfView = 62
	fadeTo(ui, 1, 0.5)
	local rarity = EggConfig.Rarities[#EggConfig.Rarities]
	showTitle(ui, string.upper(EggConfig.ZoneTitles[rarity] or "Last Zone"), rarity .. "  ·  The last zone", rgb(255, 150, 40))
	local ok = hold(Config.ZoneShotTime, function(u)
		local s = u * u * (3 - 2 * u)
		camera.CFrame = CFrame.lookAt(Vector3.new(edge + 30, 112 - 8 * s, z + 74 - 148 * s), target) -- au-dessus des arbres du plateau du fond
	end)
	hideTitle(ui, 0.3)
	return ok
end

local function flyScene(ui, camera, zones)
	local first, last = zones[1], zones[#zones]
	local fromX, toX = last.X + last.SizeX / 2 + 20, first.X - first.SizeX / 2 - 34
	local fromZ, toZ = last.Z, first.Z
	stage:FireServer("fly")
	local shown
	local ok = hold(Config.FlyTime, function(u)
		local s = 0.6 * u + 0.4 * (0.5 - 0.5 * math.cos(u * math.pi)) -- départ et arrivée en douceur, vitesse presque constante entre les deux
		local x = fromX + (toX - fromX) * s
		local eye = Vector3.new(x, 68 - 14 * s, fromZ + (toZ - fromZ) * s)
		camera.CFrame = CFrame.lookAt(eye, eye + Vector3.new(-110, -44, 0))
		-- le nom de la zone que la caméra regarde (un peu devant elle)
		local ahead = x - 50
		for i, zone in zones do
			if math.abs(ahead - zone.X) <= zone.SizeX / 2 and shown ~= i then
				shown = i
				local rarity = EggConfig.Rarities[i]
				if rarity then showTitle(ui, string.upper(EggConfig.ZoneTitles[rarity] or "Zone"), rarity, Color3.fromHex(zone.Color):Lerp(WHITE, 0.45)) end
			end
		end
	end)
	hideTitle(ui, 0.3)
	return ok
end

---------------------------------------------------------------- déroulé
local function run()
	if playing then return end
	playing, skipped = true, false
	player:SetAttribute("IntroState", "playing")
	local ui = buildGui()
	-- le reste de l'interface disparaît le temps de la cinématique
	local hidden = {}
	local function hideGui(g)
		if g:IsA("ScreenGui") and g ~= ui.Gui and g.Enabled then
			hidden[g] = true
			g.Enabled = false
		end
	end
	for _, g in playerGui:GetChildren() do hideGui(g) end
	local added = playerGui.ChildAdded:Connect(function(g) task.defer(hideGui, g) end)
	pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false) end)
	-- le personnage ne bouge pas pendant la cinématique : on avale les touches de déplacement et de saut
	ContextActionService:BindActionAtPriority("IntroFreeze", function() return Enum.ContextActionResult.Sink end, false,
		Enum.ContextActionPriority.High.Value + 50, Enum.PlayerActions.CharacterForward, Enum.PlayerActions.CharacterBackward,
		Enum.PlayerActions.CharacterLeft, Enum.PlayerActions.CharacterRight, Enum.PlayerActions.CharacterJump,
		Enum.KeyCode.Thumbstick1, Enum.KeyCode.ButtonA)
	local camera = workspace.CurrentCamera
	local fov = camera.FieldOfView
	stage:FireServer("start")

	local keepCamera = RunService.RenderStepped:Connect(function() -- les scripts de caméra de Roblox ne reprennent pas la main
		if camera.CameraType ~= Enum.CameraType.Scriptable then camera.CameraType = Enum.CameraType.Scriptable end
	end)
	local ok, err = pcall(function()
		local zones = zonesByX()
		if forestScene(ui, camera) and #zones > 0 and lastZoneScene(ui, camera, zones) then
			flyScene(ui, camera, zones)
		end
	end)
	if not ok then warn("[IntroClient] " .. tostring(err)) end

	-- fin (ou SKIP) : fondu au noir, tout est remis en place, retour au joueur
	fadeTo(ui, 0, 0.3)
	task.wait(0.35)
	keepCamera:Disconnect()
	night(false)
	stage:FireServer("end")
	camera.FieldOfView = fov
	camera.CameraType = Enum.CameraType.Custom
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then camera.CameraSubject = humanoid end
	ContextActionService:UnbindAction("IntroFreeze")
	pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true) end)
	added:Disconnect()
	for g in hidden do
		if g.Parent then g.Enabled = true end
	end
	for _, name in {"BarTop", "BarBottom", "Skip", "Title", "Sub"} do ui.Gui[name].Visible = false end
	task.wait(0.4) -- le décor autour du joueur revient
	fadeTo(ui, 1, 0.6)
	task.wait(0.65)
	ui.Gui:Destroy()
	playing = false
	player:SetAttribute("IntroState", "done")
end

player:GetAttributeChangedSignal("PlayIntro"):Connect(function()
	if player:GetAttribute("PlayIntro") then task.spawn(run) end
end)

-- nouveaux joueurs : on attend que le serveur dise si le tutoriel est à faire
if not game:IsLoaded() then game.Loaded:Wait() end
local waited = 0
while player:GetAttribute("TutorialDone") == nil and waited < 25 do waited += task.wait(0.2) end
if player:GetAttribute("TutorialDone") == false then
	task.wait(1.5)
	run()
elseif not playing then
	player:SetAttribute("IntroState", "none")
end

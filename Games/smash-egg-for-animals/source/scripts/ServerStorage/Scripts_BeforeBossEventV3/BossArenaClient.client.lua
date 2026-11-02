-- BossArenaClient : tout ce que voit un joueur pendant le combat contre le Headless (BossArenaServer) :
--   * l'interface : barre de vie du boss (nom en dégradé, contours animés), la sienne, les annonces, la bulle où le boss parle,
--     les chiffres de dégâts
--   * le boss : il glisse d'un point à l'autre (attributs Move*), regarde là où il marche, et chaque membre est animé ici selon
--     son action (Action / ActionT : idle, walk, roar, slam, snap, vanish, appear, die) ; il devient rouge 0,25 s quand on le
--     touche (HurtT)
--   * les effets (remote BossArena.Fx) : l'onde, les lasers, les explosions, les coups de batte, les téléportations par trou
--     noir (module BlackHole), la fissure du sol à sa mort
--   * l'éclairage nocturne violet, la musique, le trou noir du portail nord, tant qu'il est dans l'arène (attribut InBossArena)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local shared = ReplicatedStorage:WaitForChild("BossArena")
local fxRemote = shared:WaitForChild("Fx")
local BlackHole = require(ReplicatedStorage:WaitForChild("BlackHole"))
local rgb = Color3.fromRGB
local rad, sin, cos = math.rad, math.sin, math.cos
local VIOLET, MAGENTA, GOLD = rgb(190, 90, 255), rgb(255, 140, 255), rgb(255, 210, 90)
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local function now() return workspace:GetServerTimeNow() end
local function inArena() return player:GetAttribute("InBossArena") == true end

local function sound(id, volume, speed, position)
	local s = Instance.new("Sound")
	s.SoundId = typeof(id) == "number" and ("rbxassetid://" .. id) or id
	s.Volume, s.PlaybackSpeed = volume or 0.5, speed or 1
	if position then
		local a = Instance.new("Attachment")
		a.WorldPosition = position
		a.Parent = workspace.Terrain
		s.RollOffMinDistance, s.RollOffMaxDistance = 30, 600
		s.Parent = a
		Debris:AddItem(a, 8)
	else
		s.Parent = SoundService
		Debris:AddItem(s, 8)
	end
	s:Play()
	return s
end
local SND = {Thunder = "rbxasset://sounds/HalloweenThunder.wav", Laser = "rbxasset://sounds/electronicpingshort.wav", Snap = "rbxasset://sounds/snap.wav",
	Hit = 115569575216445, Boom = 9119747138, Thud = "rbxasset://sounds/collide.wav", Ghost = "rbxasset://sounds/HalloweenGhost.wav"}

---------------------------------------------------------------- style : dégradés et contours animés
local animated = {} -- [UIGradient] = {speed, mode}
local function gradient(parent, colors, rotation, speed, mode)
	local points = {}
	for i, c in colors do points[i] = ColorSequenceKeypoint.new((i - 1) / (#colors - 1), c) end
	local g = Instance.new("UIGradient")
	g.Color = ColorSequence.new(points)
	g.Rotation = rotation or 90
	g.Parent = parent
	if speed then animated[g] = {speed = speed, mode = mode or "rot"} end
	return g
end
local function stroke(parent, thickness, colors, speed)
	local s = Instance.new("UIStroke")
	s.Thickness = thickness
	s.Color = Color3.new(1, 1, 1)
	s.LineJoinMode = Enum.LineJoinMode.Round
	s.Parent = parent
	gradient(s, colors, 0, speed or 90, "rot")
	return s
end
RunService.RenderStepped:Connect(function(dt)
	local t = os.clock()
	for g, info in animated do
		if not g.Parent then animated[g] = nil
		elseif info.mode == "rot" then g.Rotation = (g.Rotation + info.speed * dt) % 360
		else g.Offset = Vector2.new(math.sin(t * info.speed) * 0.35, 0) end
	end
end)
local DARK_EDGE = {rgb(20, 6, 40), rgb(190, 90, 255), rgb(20, 6, 40), rgb(255, 140, 255), rgb(20, 6, 40)}
local function fancyLabel(parent, props, colors, strokeThickness)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.FontFace = FONT
	l.TextScaled = true
	l.TextColor3 = Color3.new(1, 1, 1)
	for k, v in props do l[k] = v end
	gradient(l, colors or {rgb(255, 255, 255), rgb(230, 190, 255)}, 90, 1.6, "offset")
	stroke(l, strokeThickness or 3, DARK_EDGE, 120)
	l.Parent = parent
	return l
end

---------------------------------------------------------------- interface
local gui = Instance.new("ScreenGui")
gui.Name = "BossArenaGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 20
gui.Enabled = false
gui.Parent = player:WaitForChild("PlayerGui")
local function bar(parent, size, position, colors)
	local back = Instance.new("Frame")
	back.Size, back.Position = size, position
	back.AnchorPoint = Vector2.new(0.5, 0)
	back.BackgroundColor3 = rgb(22, 16, 34)
	back.BorderSizePixel = 0
	stroke(back, 3, {rgb(255, 255, 255), rgb(190, 90, 255), rgb(60, 20, 110), rgb(255, 140, 255), rgb(255, 255, 255)}, 70)
	local lag = Instance.new("Frame")
	lag.Name = "Lag"
	lag.BackgroundColor3 = rgb(255, 245, 255)
	lag.BorderSizePixel = 0
	lag.Size = UDim2.fromScale(1, 1)
	lag.Parent = back
	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.BackgroundColor3 = Color3.new(1, 1, 1)
	fill.BorderSizePixel = 0
	fill.Size = UDim2.fromScale(1, 1)
	fill.Parent = back
	gradient(fill, colors, 0, 0.9, "offset")
	local shine = Instance.new("Frame")
	shine.BackgroundColor3 = Color3.new(1, 1, 1)
	shine.BackgroundTransparency = 0.72
	shine.BorderSizePixel = 0
	shine.Size = UDim2.new(1, 0, 0.38, 0)
	shine.Parent = fill
	back.Parent = parent
	return back, fill, lag
end
local top = Instance.new("Frame")
top.Name = "BossBar"
top.BackgroundTransparency = 1
top.AnchorPoint = Vector2.new(0.5, 0)
top.Position = UDim2.new(0.5, 0, 0, 58)
top.Size = UDim2.fromOffset(660, 82)
top.Parent = gui
fancyLabel(top, {Text = "THE HEADLESS", Size = UDim2.new(1, 0, 0, 32)}, {rgb(255, 230, 140), rgb(255, 255, 255), rgb(220, 150, 255)}, 3)
local enraged = fancyLabel(top, {Text = "ENRAGED", Size = UDim2.fromOffset(150, 24), Position = UDim2.new(1, -150, 0, 6), Visible = false}, {rgb(255, 80, 90), rgb(255, 200, 120)}, 2.5)
local bossBack, bossFill, bossLag = bar(top, UDim2.new(1, 0, 0, 36), UDim2.new(0.5, 0, 0, 38), {rgb(130, 40, 255), rgb(255, 110, 230), rgb(130, 40, 255)})
local bossText = fancyLabel(bossBack, {Text = "10,000 / 10,000", Size = UDim2.new(1, 0, 0.78, 0), Position = UDim2.fromScale(0, 0.11), ZIndex = 3}, nil, 2.5)
-- (la vie du joueur : c'est la barre de vie qui existe déjà dans le jeu qui l'affiche)
local banner = fancyLabel(gui, {Text = "", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.3), Size = UDim2.fromOffset(820, 78), Visible = false}, {rgb(255, 255, 255), rgb(255, 220, 140)}, 4.5)
local bannerGradient = banner:FindFirstChildOfClass("UIGradient")
local bannerScale = Instance.new("UIScale")
bannerScale.Parent = banner
local bannerId = 0
local function showBanner(text, color, t)
	bannerId += 1
	local id = bannerId
	color = color or Color3.new(1, 1, 1)
	bannerGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(0.5, color), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))})
	banner.Text, banner.Visible, banner.Rotation = text, true, -3
	bannerScale.Scale = 0.4
	TweenService:Create(bannerScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	TweenService:Create(banner, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 0}):Play()
	task.delay(t or 2, function()
		if bannerId ~= id then return end
		TweenService:Create(bannerScale, TweenInfo.new(0.2), {Scale = 0.6}):Play()
		task.delay(0.2, function() if bannerId == id then banner.Visible = false end end)
	end)
end
local function comma(n)
	local out = tostring(math.floor(n)):reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return (out:gsub("^,", ""))
end

---------------------------------------------------------------- éclairage, musique, trou noir du portail nord
local ARENA_LIGHT = {ClockTime = 0, Brightness = 2.4, Ambient = rgb(130, 110, 165), OutdoorAmbient = rgb(150, 125, 190), FogColor = rgb(40, 20, 66),
	FogStart = 350, FogEnd = 2000, ColorShift_Top = rgb(190, 150, 255), ExposureCompensation = 0.45}
local saved, music, gateHole
local leftovers = {} -- fissures, débris... nettoyés en quittant l'arène
local function setArenaMood(on)
	if on and not saved then
		saved = {}
		for k, v in ARENA_LIGHT do saved[k] = Lighting[k] Lighting[k] = v end
		local days = SoundService:FindFirstChild("Days")
		if days and days.IsPlaying then days:Pause() saved.__days = days end
		music = Instance.new("Sound")
		music.SoundId, music.Looped, music.Volume = "rbxassetid://1838626086", true, 0
		music.Parent = SoundService
		music:Play()
		TweenService:Create(music, TweenInfo.new(1.5), {Volume = 0.45}):Play()
		local gate = workspace:FindFirstChild("BossArena") and workspace.BossArena:FindFirstChild("BossPortal")
		local center = gate and gate:GetAttribute("Center")
		if center then
			gateHole = BlackHole.new(CFrame.lookAt(center, center + Vector3.new(0, 0, 1)), gate:GetAttribute("Radius") or 16, workspace)
			gateHole:open(1.5)
		end
	elseif not on and saved then
		for k, v in saved do if k ~= "__days" then Lighting[k] = v end end
		if saved.__days then saved.__days:Resume() end
		saved = nil
		if music then music:Destroy() music = nil end
		if gateHole then gateHole:destroy() gateHole = nil end
		for _, o in leftovers do if o.Parent then o:Destroy() end end
		table.clear(leftovers)
	end
end
local hiddenGuis = {}
local function refreshArena()
	local on = inArena()
	gui.Enabled = on
	setArenaMood(on)
	local playerGui = player:FindFirstChild("PlayerGui")
	if on and playerGui then
		local g = playerGui:FindFirstChild("TutorialGui")
		if g and g.Enabled then g.Enabled = false hiddenGuis[g] = true end
	elseif not on then
		for g in hiddenGuis do if g.Parent then g.Enabled = true end end
		table.clear(hiddenGuis)
	end
end
player:GetAttributeChangedSignal("InBossArena"):Connect(refreshArena)
refreshArena()
task.spawn(function()
	while true do
		task.wait(0.5)
		if saved then
			for k, v in ARENA_LIGHT do if Lighting[k] ~= v then Lighting[k] = v end end
			-- le tutoriel peut revenir pendant le combat : on le recache
			local g = player.PlayerGui:FindFirstChild("TutorialGui")
			if g and g.Enabled then g.Enabled = false hiddenGuis[g] = true end
		end
	end
end)

-- secousse de l'écran (décalage de caméra du personnage)
local shakeAmp, shakeUntil = 0, 0
local function shake(amount, dur)
	shakeAmp = math.max(shakeAmp, amount)
	shakeUntil = math.max(shakeUntil, os.clock() + (dur or 0.4))
end
RunService.RenderStepped:Connect(function()
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	if os.clock() < shakeUntil then
		local k = (shakeUntil - os.clock())
		humanoid.CameraOffset = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5) * shakeAmp * math.min(k * 3, 1)
	elseif shakeAmp > 0 then
		shakeAmp = 0
		humanoid.CameraOffset = Vector3.zero
	end
end)

---------------------------------------------------------------- effets de base
local fxFolder = Instance.new("Folder")
fxFolder.Name = "BossArenaFx"
fxFolder.Parent = workspace
local function fxPart(size, cf, color, transp, shape, material)
	local p = Instance.new("Part")
	p.Size, p.CFrame, p.Color = size, cf, color
	p.Material = material or Enum.Material.Neon
	p.Transparency = transp or 0
	if shape then p.Shape = shape end
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
	p.Parent = fxFolder
	return p
end
local function sparkle(pos, color, count, speed, size, texture)
	local holder = fxPart(Vector3.one * 0.2, CFrame.new(pos), color, 1)
	local e = Instance.new("ParticleEmitter")
	e.Texture = texture or "rbxasset://textures/particles/sparkles_main.dds"
	e.Color = ColorSequence.new(Color3.new(1, 1, 1), color)
	e.LightEmission, e.LightInfluence = 1, 0
	e.Rate = 0
	e.Lifetime = NumberRange.new(0.35, 0.8)
	e.Speed = NumberRange.new(speed * 0.5, speed)
	e.SpreadAngle = Vector2.new(180, 180)
	e.Drag = 3
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, size), NumberSequenceKeypoint.new(1, 0)})
	e.Parent = holder
	e:Emit(count)
	Debris:AddItem(holder, 1.4)
end
local function smoke(pos, color, count, size)
	local holder = fxPart(Vector3.one * 0.2, CFrame.new(pos), color, 1)
	local e = Instance.new("ParticleEmitter")
	e.Texture = "rbxasset://textures/particles/smoke_main.dds"
	e.Color = ColorSequence.new(color)
	e.LightEmission = 0.1
	e.Rate = 0
	e.Lifetime = NumberRange.new(1, 1.8)
	e.Speed = NumberRange.new(size * 0.6, size * 1.4)
	e.SpreadAngle = Vector2.new(70, 70)
	e.EmissionDirection = Enum.NormalId.Top
	e.Drag = 2
	e.RotSpeed = NumberRange.new(-40, 40)
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, size * 0.5), NumberSequenceKeypoint.new(1, size * 1.6)})
	e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 1)})
	e.Parent = holder
	e:Emit(count)
	Debris:AddItem(holder, 2.5)
end
local function expand(p, toSize, time, toTransp)
	TweenService:Create(p, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = toSize, Transparency = toTransp or 1}):Play()
	Debris:AddItem(p, time + 0.05)
end
local function ringAt(pos, color, from, to, time, transp)
	local r = fxPart(Vector3.new(0.3, from, from), CFrame.new(pos) * CFrame.Angles(0, 0, rad(90)), color, transp or 0.15, Enum.PartType.Cylinder)
	expand(r, Vector3.new(0.3, to, to), time, 1)
end

-- chiffres de dégâts : "-50" qui saute et s'efface
local function damageNumber(pos, amount)
	local holder = fxPart(Vector3.one * 0.2, CFrame.new(pos + Vector3.new(math.random(-3, 3), 0, math.random(-3, 3))), Color3.new(), 1)
	local bb = Instance.new("BillboardGui")
	bb.Size = UDim2.fromOffset(150, 64)
	bb.LightInfluence = 0
	bb.Parent = holder
	local l = fancyLabel(bb, {Text = "-" .. amount, Size = UDim2.fromScale(1, 1)}, {rgb(255, 245, 140), rgb(255, 120, 60), rgb(255, 40, 80)}, 3)
	local scale = Instance.new("UIScale")
	scale.Scale = 0.3
	scale.Parent = l
	TweenService:Create(scale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1.15}):Play()
	TweenService:Create(holder, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = holder.CFrame + Vector3.new(0, 9, 0)}):Play()
	task.delay(0.5, function()
		TweenService:Create(l, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
		local s = l:FindFirstChildOfClass("UIStroke")
		if s then TweenService:Create(s, TweenInfo.new(0.4), {Transparency = 1}):Play() end
	end)
	Debris:AddItem(holder, 1)
end

---------------------------------------------------------------- le boss : déplacement, animation, bulle, flash rouge
local MOTORS = {"Root", "RightShoulder", "LeftShoulder", "RightHip", "LeftHip"}
local PART_OF = {Root = "Torso", RightShoulder = "Right Arm", LeftShoulder = "Left Arm", RightHip = "Right Leg", LeftHip = "Left Leg"}
local function A(x, y, z) return CFrame.Angles(rad(x or 0), rad(y or 0), rad(z or 0)) end
local function smooth(u) u = math.clamp(u, 0, 1) return u * u * (3 - 2 * u) end
local function blend(a, b, u)
	local out = {}
	for _, n in MOTORS do out[n] = (a[n] or CFrame.identity):Lerp(b[n] or CFrame.identity, u) end
	return out
end
local function idlePose(t)
	-- respiration lente, l'espadon qui balance, le poids qui passe d'une jambe à l'autre, et de temps en temps il tourne le buste
	local b = sin(t * 1.4)
	local look = math.clamp(sin(t * 0.37) * 1.6, -1, 1) * 22 * math.max(0, sin(t * 0.21)) -- regard alentour
	local shift = sin(t * 0.6)
	return {Root = A(-4 + 2.5 * b, look, 2 * shift), RightShoulder = A(16 + 4 * b + 3 * sin(t * 0.9), 0, 10), LeftShoulder = A(8 - 3 * b, 0, -10 - 2 * b),
		RightHip = A(-3 * shift, 0, 2), LeftHip = A(3 * shift, 0, -2)}
end
local IDLE = idlePose(0)
local function pose(action, e, t)
	if action == "walk" then
		local s = sin(t * 3.6)
		return {Root = A(-8, 6 * s, 3 * s), RightHip = A(30 * s), LeftHip = A(-30 * s), RightShoulder = A(20 - 12 * s, 0, 10), LeftShoulder = A(26 * s, 0, -10)}
	elseif action == "roar" then
		local u = smooth(e / 0.4) * (1 - smooth((e - 1.6) / 0.4))
		return blend(idlePose(t), {Root = A(16), RightShoulder = A(35, 0, 80), LeftShoulder = A(35, 0, -80), RightHip = A(-10), LeftHip = A(10)}, u)
	elseif action == "slam" then
		local WIND = 1.3
		local raise = {Root = A(14), RightShoulder = A(172, 0, -8), LeftShoulder = A(168, 0, 8), RightHip = A(-6), LeftHip = A(10)}
		local strike = {Root = A(-34), RightShoulder = A(48, 0, -4), LeftShoulder = A(44, 0, 4), RightHip = A(-30), LeftHip = A(40)}
		if e < WIND then return blend(IDLE, raise, smooth(e / WIND)) end
		if e < WIND + 0.14 then return blend(raise, strike, smooth((e - WIND) / 0.14)) end
		if e < WIND + 0.8 then return strike end
		return blend(strike, IDLE, smooth((e - WIND - 0.8) / 0.5))
	elseif action == "snap" then
		local up = {Root = A(-4, 10), RightShoulder = A(14, 0, 8), LeftShoulder = A(140, 0, -25)}
		local flick = {Root = A(-6, 14), RightShoulder = A(14, 0, 8), LeftShoulder = A(155, 0, -8)}
		if e < 0.4 then return blend(IDLE, up, smooth(e / 0.4)) end
		if e < 0.6 then return blend(up, flick, smooth((e - 0.4) / 0.12)) end
		return blend(flick, IDLE, smooth((e - 0.6) / 0.6))
	elseif action == "vanish" then
		return blend(IDLE, {Root = A(18), RightShoulder = A(60, 0, 60), LeftShoulder = A(60, 0, -60), RightHip = A(-10), LeftHip = A(10)}, smooth(e / 0.5))
	elseif action == "appear" then
		local crouch = {Root = A(-22), RightShoulder = A(30, 0, 40), LeftShoulder = A(30, 0, -40), RightHip = A(40), LeftHip = A(-30)}
		return blend(crouch, IDLE, smooth((e - 0.3) / 0.8))
	elseif action == "die" then
		local kneel = {Root = A(-28), RightHip = A(85), LeftHip = A(-70), RightShoulder = A(10, 0, 28), LeftShoulder = A(24, 0, -22)}
		return blend(IDLE, kneel, smooth(e / 0.9))
	end
	return idlePose(t)
end

local bossState = {yaw = 0, current = {}, fade = 0, hurtSeen = nil, lastStep = 0, bubble = nil}
local function bossModel() return workspace:FindFirstChild("ArenaHeadless") end
local function setFade(model, a)
	if math.abs(a - bossState.fade) < 0.02 then return end
	bossState.fade = a
	for _, d in model:GetDescendants() do if d:IsA("BasePart") or d:IsA("Decal") then d.LocalTransparencyModifier = a end end
	local h = model:FindFirstChildOfClass("Highlight")
	if h then h.Enabled = a < 0.9 end
end
-- bulle : ce que dit le boss, au-dessus de ses épaules
local function bubbleFor(model)
	if bossState.bubble and bossState.bubble.Parent then return bossState.bubble end
	local torso = model:FindFirstChild("Torso")
	if not torso then return nil end
	local bb = Instance.new("BillboardGui")
	bb.Name = "BossSpeech"
	bb.Size = UDim2.fromOffset(640, 110)
	bb.StudsOffsetWorldSpace = Vector3.new(0, torso.Size.Y * 1.15, 0)
	bb.LightInfluence = 0
	bb.MaxDistance = 1500
	bb.Enabled = false
	bb.Parent = torso
	local l = fancyLabel(bb, {Name = "Text", Text = "", Size = UDim2.fromScale(1, 1)}, {rgb(255, 255, 255), rgb(225, 170, 255), rgb(255, 255, 255)}, 4)
	local sc = Instance.new("UIScale")
	sc.Parent = l
	bossState.bubble = bb
	return bb
end
local sayId = 0
local function bossSay(text, colors, t)
	local model = bossModel()
	local bb = model and bubbleFor(model)
	if not bb then showBanner(text, VIOLET, t) return end
	sayId += 1
	local id = sayId
	local l = bb.Text
	l.Text = text
	local g = l:FindFirstChildOfClass("UIGradient")
	local c = colors or {rgb(255, 255, 255), rgb(225, 170, 255)}
	g.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, c[1]), ColorSequenceKeypoint.new(0.5, c[2]), ColorSequenceKeypoint.new(1, c[1])})
	bb.Enabled = true
	local sc = l:FindFirstChildOfClass("UIScale")
	sc.Scale = 0.3
	l.Rotation = math.random(-4, 4)
	TweenService:Create(sc, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	sound(SND.Ghost, 0.35, 0.55 + math.random() * 0.2)
	task.delay(t or 2.4, function()
		if sayId ~= id then return end
		TweenService:Create(sc, TweenInfo.new(0.2), {Scale = 0}):Play()
		task.delay(0.2, function() if sayId == id then bb.Enabled = false end end)
	end)
end

---------------------------------------------------------------- effets permanents du boss : flamme du cou, aura, épée chargée
-- (tout est ajouté ici, côté client, sur le modèle du serveur ; phase 2 = tout vire au rouge-magenta et s'intensifie)
local FIRE_TEX, SMOKE_TEX, SPARK_TEX = "rbxasset://textures/particles/fire_main.dds", "rbxasset://textures/particles/smoke_main.dds", "rbxasset://textures/particles/sparkles_main.dds"
local bossFx = {model = nil}
local function emitter(parent, props)
	local e = Instance.new("ParticleEmitter")
	e.LightInfluence = 0
	for k, v in props do e[k] = v end
	e.Parent = parent
	return e
end
local function decorateBoss(model)
	bossFx = {model = model, arcs = 0}
	local stump, torso, blade = model:FindFirstChild("Stump"), model:FindFirstChild("Torso"), model:FindFirstChild("Blade")
	if not stump or not torso then return end
	local k = torso.Size.X / 2 -- échelle du boss (torse R6 = 2 de large)
	-- la flamme qui brûle à la place de la tête
	bossFx.neck = emitter(stump, {Texture = FIRE_TEX, LightEmission = 1, Rate = 60, Lifetime = NumberRange.new(0.5, 0.9),
		Speed = NumberRange.new(4 * k, 7 * k), SpreadAngle = Vector2.new(12, 12), EmissionDirection = Enum.NormalId.Top, Acceleration = Vector3.new(0, 3 * k, 0),
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.3 * k), NumberSequenceKeypoint.new(0.5, 1.0 * k), NumberSequenceKeypoint.new(1, 0)}),
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1)}),
		RotSpeed = NumberRange.new(-90, 90), Rotation = NumberRange.new(0, 360),
		Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 230, 255)), ColorSequenceKeypoint.new(0.4, MAGENTA), ColorSequenceKeypoint.new(1, rgb(90, 20, 180))})})
	bossFx.embers = emitter(stump, {Texture = SPARK_TEX, LightEmission = 1, Rate = 14, Lifetime = NumberRange.new(1, 1.8),
		Speed = NumberRange.new(3 * k, 6 * k), SpreadAngle = Vector2.new(35, 35), EmissionDirection = Enum.NormalId.Top, Drag = 1,
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25 * k), NumberSequenceKeypoint.new(1, 0)}), Color = ColorSequence.new(rgb(255, 200, 255))})
	bossFx.neckLight = Instance.new("PointLight")
	bossFx.neckLight.Color, bossFx.neckLight.Range, bossFx.neckLight.Brightness, bossFx.neckLight.Shadows = MAGENTA, 14 * k, 2.5, false
	bossFx.neckLight.Parent = stump
	-- une brume sombre qui s'échappe du corps
	bossFx.aura = emitter(torso, {Texture = SMOKE_TEX, LightEmission = 0.25, Rate = 10, Lifetime = NumberRange.new(1.4, 2.2),
		Speed = NumberRange.new(0.5 * k, 1.5 * k), SpreadAngle = Vector2.new(180, 180), Acceleration = Vector3.new(0, 1.5 * k, 0), Drag = 0.5,
		Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.5 * k), NumberSequenceKeypoint.new(1, 3.5 * k)}),
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75), NumberSequenceKeypoint.new(1, 1)}),
		RotSpeed = NumberRange.new(-30, 30), Color = ColorSequence.new(rgb(70, 20, 120))})
	-- l'espadon : une traînée violette quand il frappe, et des étincelles qui s'y accumulent quand il charge
	if blade then
		local h = blade.Size.Y >= blade.Size.Z and Vector3.new(0, blade.Size.Y / 2, 0) or Vector3.new(0, 0, blade.Size.Z / 2)
		local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
		a0.Position, a1.Position = h, -h
		a0.Parent, a1.Parent = blade, blade
		local trail = Instance.new("Trail")
		trail.Attachment0, trail.Attachment1 = a0, a1
		trail.Lifetime = 0.28
		trail.LightEmission, trail.LightInfluence = 1, 0
		trail.Color = ColorSequence.new(rgb(255, 220, 255), VIOLET)
		trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 1)})
		trail.FaceCamera = true
		trail.Enabled = false
		trail.Parent = blade
		bossFx.trail = trail
		bossFx.charge = emitter(blade, {Texture = SPARK_TEX, LightEmission = 1, Rate = 6, Lifetime = NumberRange.new(0.3, 0.6),
			Speed = NumberRange.new(0.5, 2), SpreadAngle = Vector2.new(180, 180), Shape = Enum.ParticleEmitterShape.Box,
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5 * k), NumberSequenceKeypoint.new(1, 0)}), Color = ColorSequence.new(rgb(255, 210, 255), VIOLET)})
		bossFx.bladeLight = Instance.new("PointLight")
		bossFx.bladeLight.Color, bossFx.bladeLight.Range, bossFx.bladeLight.Brightness, bossFx.bladeLight.Shadows = VIOLET, 10 * k, 0.5, false
		bossFx.bladeLight.Parent = blade
	end
end
RunService.Heartbeat:Connect(function()
	local model = bossModel()
	if not model then return end
	if bossFx.model ~= model then decorateBoss(model) end
	if not bossFx.neck then return end
	local t = now()
	local action = model:GetAttribute("Action") or "idle"
	local e = t - (model:GetAttribute("ActionT") or t)
	local rage = model:GetAttribute("Phase") == 2
	local hidden = action == "vanish" or (action == "die" and e > 2.6)
	-- flamme du cou : plus haute quand il rugit, rouge en phase 2, éteinte quand il disparaît
	local boost = (action == "roar" and 2.2) or (action == "slam" and e < 1.3 and 1.6) or (action == "snap" and 1.5) or 1
	bossFx.neck.Rate = hidden and 0 or 60 * boost * (rage and 1.5 or 1)
	bossFx.embers.Rate = hidden and 0 or 14 * boost * (rage and 2 or 1)
	bossFx.aura.Rate = hidden and 0 or (rage and 22 or 10)
	bossFx.neckLight.Brightness = hidden and 0 or 2.5 * boost + math.sin(t * 13) * 0.4
	if rage ~= bossFx.rage then
		bossFx.rage = rage
		local hot = rage and rgb(255, 70, 110) or MAGENTA
		bossFx.neck.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 235, 240)), ColorSequenceKeypoint.new(0.4, hot), ColorSequenceKeypoint.new(1, rage and rgb(140, 10, 60) or rgb(90, 20, 180))})
		bossFx.neckLight.Color = hot
		bossFx.aura.Color = ColorSequence.new(rage and rgb(110, 10, 40) or rgb(70, 20, 120))
		if bossFx.trail then bossFx.trail.Color = ColorSequence.new(rgb(255, 230, 240), hot) end
	end
	-- l'espadon : il se charge pendant l'élan du coup au sol, la traînée suit le coup
	if bossFx.charge then
		local charging = action == "slam" and e < 1.3
		bossFx.charge.Rate = hidden and 0 or (charging and 140 * e or (rage and 18 or 6))
		bossFx.bladeLight.Brightness = charging and 1 + e * 5 or 0.5
		bossFx.trail.Enabled = (action == "slam" and e > 1.1 and e < 1.7) or action == "roar"
	end
	-- phase 2 : des petits éclairs crépitent autour de lui
	if rage and not hidden and os.clock() > (bossFx.nextArc or 0) then
		bossFx.nextArc = os.clock() + 0.25 + math.random() * 0.4
		local torso = model:FindFirstChild("Torso")
		if torso then
			local k = torso.Size.X / 2
			local from = torso.Position + Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10)) / 10 * 3 * k
			local to = from + Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5).Unit * (2 + math.random() * 2) * k
			local d = (to - from).Magnitude
			local arc = fxPart(Vector3.new(0.15 * k, 0.15 * k, d), CFrame.lookAt((from + to) / 2, to), rgb(255, 150, 200), 0)
			TweenService:Create(arc, TweenInfo.new(0.12), {Transparency = 1}):Play()
			Debris:AddItem(arc, 0.14)
		end
	end
end)

RunService.RenderStepped:Connect(function(dt)
	local model = bossModel()
	if not model or not model.PrimaryPart then return end
	local hrp = model.PrimaryPart
	local t = now()
	local from, to, t0, dur = model:GetAttribute("MoveFrom"), model:GetAttribute("MoveTo"), model:GetAttribute("MoveT0"), model:GetAttribute("MoveDur")
	local height = model:GetAttribute("Height") or 30
	local pos = Vector3.new(hrp.Position.X, hrp.Position.Y - height, hrp.Position.Z)
	local moving = false
	if from and to and t0 and dur and t < t0 + dur and dur > 0.05 then
		pos = from:Lerp(to, smooth((t - t0) / dur))
		moving = true
	elseif to and t0 and t >= t0 then
		pos = to
	end
	-- il regarde là où il marche (pas les joueurs) ; à l'arrêt il garde son orientation
	if moving then
		local dir = to - from
		if Vector3.new(dir.X, 0, dir.Z).Magnitude > 0.5 then
			local want = math.atan2(-dir.X, -dir.Z)
			local diff = (want - bossState.yaw + math.pi) % (2 * math.pi) - math.pi
			bossState.yaw += diff * (1 - math.exp(-dt * 3))
		end
	end
	local action = model:GetAttribute("Action") or "idle"
	local e = t - (model:GetAttribute("ActionT") or t)
	if action == "walk" and not moving then action = "idle" end
	-- pas lourds : il tangue un peu, chaque pas soulève de la poussière et fait trembler le sol
	local bob = 0
	if action == "walk" then
		bob = math.abs(sin(t * 3.6)) * 0.9
		local step = math.floor(t * 3.6 / math.pi)
		if step ~= bossState.lastStep then
			bossState.lastStep = step
			local foot = pos + CFrame.Angles(0, bossState.yaw, 0) * Vector3.new(step % 2 == 0 and 5 or -5, 0.3, 0)
			smoke(foot, rgb(120, 100, 140), 6, 5)
			sound(SND.Thud, 0.7, 0.35, foot)
			local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if root and (root.Position - foot).Magnitude < 80 then shake(0.35, 0.18) end
		end
	end
	hrp.CFrame = CFrame.new(pos + Vector3.new(0, height + bob, 0)) * CFrame.Angles(0, bossState.yaw, 0)
	local target = pose(action, e, t)
	local k = 1 - math.exp(-dt * 12)
	for _, n in MOTORS do
		local part = model:FindFirstChild(PART_OF[n])
		local motor = part and part:FindFirstChild(n)
		if motor then
			local cur = (bossState.current[n] or CFrame.identity):Lerp(target[n] or CFrame.identity, k)
			bossState.current[n] = cur
			motor.Transform = cur
		end
	end
	-- disparition / apparition (trou noir), mort
	local fade = 0
	if action == "vanish" then fade = smooth((e - 0.35) / 0.55)
	elseif action == "appear" then fade = 1 - smooth((e - 0.05) / 0.7)
	elseif action == "die" then fade = smooth((e - 2.6) / 2.4) end
	setFade(model, fade)
	-- touché : rouge pendant 0,25 s
	local hurtT = model:GetAttribute("HurtT")
	local h = model:FindFirstChildOfClass("Highlight")
	if h then
		local red = hurtT and t - hurtT >= -0.05 and t - hurtT < 0.25
		if red then
			local u = math.clamp((t - hurtT) / 0.25, 0, 1)
			h.FillColor, h.FillTransparency = rgb(235, 25, 35), 0.3 + 0.5 * u
			h.OutlineColor = rgb(255, 70, 70)
		else
			h.FillColor, h.FillTransparency = rgb(120, 40, 200), 0.85
			h.OutlineColor = rgb(220, 140, 255)
		end
	end
end)

---------------------------------------------------------------- barres de vie
local shownBoss, lagBoss = 1, 1
RunService.Heartbeat:Connect(function(dt)
	if not gui.Enabled then return end
	local model = bossModel()
	if model then
		local hp, max = model:GetAttribute("Hp") or 0, model:GetAttribute("MaxHp") or 1
		local f = math.clamp(hp / max, 0, 1)
		shownBoss += (f - shownBoss) * math.min(1, dt * 12)
		lagBoss = math.max(shownBoss, lagBoss - dt * 0.25)
		bossFill.Size = UDim2.fromScale(shownBoss, 1)
		bossLag.Size = UDim2.fromScale(lagBoss, 1)
		bossText.Text = comma(hp) .. " / " .. comma(max)
		local phase2 = model:GetAttribute("Phase") == 2
		enraged.Visible = phase2
		if phase2 then enraged.Rotation = sin(os.clock() * 8) * 3 end
	end
end)

---------------------------------------------------------------- l'onde du coup au sol
local function wave(o, t0, speed, dur)
	-- une seule onde lisse et transparente (des Beams courbés en cercle, pas de morceaux) : un mur d'énergie violet qui avance,
	-- une crête lumineuse sur le dessus, une lueur au ras du sol
	local N = 36
	local holder = fxPart(Vector3.one * 0.2, CFrame.new(o), VIOLET, 1)
	local LAYERS = { -- {hauteur, centre, couleur, transparence}
		{9, 4.5, rgb(170, 80, 255), 0.82},                                                 -- la masse de l'onde
		{4.6, 2.3, rgb(255, 190, 255), 0.62},                                              -- le coeur
		{0.9, 4.7, rgb(255, 245, 255), 0.25},                                              -- la crête
		{1.6, 0.6, MAGENTA, 0.35},                                                         -- la lueur au sol
	}
	local layers = {}
	for _, spec in LAYERS do
		local L = {spec = spec, atts = {}, beams = {}}
		for i = 1, N do
			local att = Instance.new("Attachment")
			att.Parent = holder
			L.atts[i] = att
		end
		for i = 1, N do
			local beam = Instance.new("Beam")
			beam.Attachment0, beam.Attachment1 = L.atts[i], L.atts[i % N + 1]
			beam.Width0, beam.Width1 = spec[1], spec[1]
			beam.Color = ColorSequence.new(spec[3])
			beam.Transparency = NumberSequence.new(spec[4])
			beam.LightEmission, beam.LightInfluence = 1, 0
			beam.FaceCamera = false
			beam.Segments = 8
			beam.Parent = holder
			L.beams[i] = beam
		end
		table.insert(layers, L)
	end
	local crater = fxPart(Vector3.new(0.4, 6, 6), CFrame.new(o + Vector3.new(0, 0.3, 0)) * CFrame.Angles(0, 0, rad(90)), rgb(255, 210, 255), 0.1, Enum.PartType.Cylinder)
	expand(crater, Vector3.new(0.4, 70, 70), 0.9, 1)
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = VIOLET, 80, 6, false
	light.Parent = crater
	sparkle(o + Vector3.new(0, 2, 0), VIOLET, 60, 40, 2.5)
	smoke(o + Vector3.new(0, 1, 0), rgb(110, 90, 140), 24, 10)
	-- le sol se fend sous l'espadon et des blocs sautent
	for i = 1, 9 do
		local a = i / 9 * math.pi * 2 + math.random() * 0.4
		local len = 10 + math.random() * 12
		local dir = CFrame.lookAt(o + Vector3.new(0, 0.12, 0), o + Vector3.new(cos(a), 0, sin(a)) * 10 + Vector3.new(0, 0.12, 0))
		local crack = fxPart(Vector3.new(1.6, 0.2, 0.1), dir, rgb(255, 150, 255), 0)
		TweenService:Create(crack, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(1.6, 0.2, len), CFrame = dir * CFrame.new(0, 0, -len / 2)}):Play()
		task.delay(1.6, function() TweenService:Create(crack, TweenInfo.new(1), {Transparency = 1}):Play() end)
		Debris:AddItem(crack, 2.7)
	end
	for i = 1, 12 do
		local rock = Instance.new("Part")
		rock.Size = Vector3.one * (1 + math.random() * 2)
		rock.Color, rock.Material = rgb(55, 45, 70), Enum.Material.Slate
		rock.CFrame = CFrame.new(o + Vector3.new(math.random(-5, 5), 2, math.random(-5, 5))) * CFrame.Angles(math.random(), math.random(), math.random())
		rock.CanCollide, rock.CanQuery, rock.CanTouch = true, false, false
		rock.Parent = fxFolder
		local a = math.random() * math.pi * 2
		rock.AssemblyLinearVelocity = Vector3.new(cos(a) * math.random(15, 35), math.random(35, 70), sin(a) * math.random(15, 35))
		rock.AssemblyAngularVelocity = Vector3.new(math.random(-8, 8), math.random(-8, 8), math.random(-8, 8))
		Debris:AddItem(rock, 3)
	end
	sound(SND.Boom, 0.9, 0.6, o)
	sound(SND.Thunder, 0.8, 0.7, o)
	shake(1.2, 0.5)
	local nextSpark, lastFade = 0, 0
	local step = math.pi * 2 / N
	local conn
	conn = RunService.RenderStepped:Connect(function()
		local e = now() - t0
		if e > dur then
			conn:Disconnect()
			holder:Destroy()
			return
		end
		local r = math.max(e * speed, 1)
		local curve = 4 / 3 * math.tan(step / 4) * r -- poignées de Bézier d'un arc de cercle parfait
		local grow = math.min(e / 0.25, 1) -- elle sort du sol
		local fade = e > dur - 0.6 and (e - (dur - 0.6)) / 0.6 or 0
		for _, L in layers do
			local h, y = L.spec[1], L.spec[2]
			for i = 1, N do
				local ang = i * step
				local c, sn = cos(ang), sin(ang)
				-- X de l'attache = tangente au cercle (sens des courbes), Y = vers le haut (sens de la largeur)
				L.atts[i].CFrame = CFrame.fromMatrix(Vector3.new(c * r, (y + 0.15 * sin(e * 9 + i)) * grow, sn * r), Vector3.new(-sn, 0, c), Vector3.yAxis)
			end
			for i = 1, N do
				local beam = L.beams[i]
				beam.CurveSize0, beam.CurveSize1 = curve, -curve
				beam.Width0, beam.Width1 = h * grow, h * grow
			end
			if fade ~= lastFade then
				local seq = NumberSequence.new(L.spec[4] + (1 - L.spec[4]) * fade)
				for i = 1, N do L.beams[i].Transparency = seq end
			end
		end
		lastFade = fade
		if os.clock() > nextSpark then -- étincelles le long du front de l'onde
			nextSpark = os.clock() + 0.05
			local ang = math.random() * math.pi * 2
			sparkle(Vector3.new(o.X + cos(ang) * r, o.Y + 4.5, o.Z + sin(ang) * r), rgb(255, 220, 255), 5, 10, 1)
		end
	end)
end

local function laser(a, b)
	local d = (b - a).Magnitude
	local beam = fxPart(Vector3.new(d, 0.45, 0.45), CFrame.lookAt((a + b) / 2, b) * CFrame.Angles(0, rad(90), 0), rgb(255, 50, 60), 0, Enum.PartType.Cylinder)
	local glowP = fxPart(Vector3.new(d, 1.3, 1.3), beam.CFrame, rgb(255, 120, 130), 0.6, Enum.PartType.Cylinder)
	expand(beam, Vector3.new(d, 0.05, 0.05), 0.3, 1)
	expand(glowP, Vector3.new(d, 0.1, 0.1), 0.3, 1)
	sparkle(a, rgb(255, 120, 120), 8, 8, 0.6)
	sparkle(b, rgb(255, 80, 80), 20, 18, 0.9)
	sound(SND.Laser, 0.5, 0.7, a)
end

local function boom(p, s)
	s = s or 1
	local ball = fxPart(Vector3.one * 2 * s, CFrame.new(p), rgb(255, 170, 80), 0, Enum.PartType.Ball)
	expand(ball, Vector3.one * 10 * s, 0.45, 1)
	ringAt(p, VIOLET, 2 * s, 16 * s, 0.5)
	sparkle(p, rgb(255, 160, 60), math.floor(30 * s), 26 * s, 1.2 * s)
	smoke(p, rgb(70, 60, 80), math.floor(8 * s), 3 * s)
	sound(SND.Boom, 0.7, 1.1, p)
end

---------------------------------------------------------------- téléportation : un trou noir l'avale, un autre le recrache
local function holeAt(pos, radius)
	local cam = workspace.CurrentCamera
	local look = cam and Vector3.new(cam.CFrame.Position.X, pos.Y, cam.CFrame.Position.Z) or (pos + Vector3.new(0, 0, 1))
	local bh = BlackHole.new(CFrame.lookAt(pos, look), radius, fxFolder)
	return bh
end
local function teleportFx(from, to, t0, height)
	local r = height * 0.42
	local c1, c2 = from + Vector3.new(0, height * 0.9, 0), to + Vector3.new(0, height * 0.9, 0)
	local h1 = holeAt(c1, r)
	h1:open(0.35)
	h1:suck(1.2)
	sound(SND.Thunder, 0.6, 0.5, c1)
	sound(SND.Ghost, 0.6, 0.4, c1)
	task.delay(1.15, function() h1:flare() h1:close(0.5, true) end)
	task.delay(math.max(0, t0 + 0.7 - now()), function()
		local h2 = holeAt(c2, r)
		h2:open(0.35)
		sound(SND.Thunder, 0.6, 0.6, c2)
		task.delay(0.45, function() h2:flare() ringAt(to + Vector3.new(0, 0.3, 0), VIOLET, 4, 60, 0.7) smoke(to, rgb(110, 80, 150), 16, 8) end)
		task.delay(1.4, function() h2:close(0.5, true) end)
	end)
end

---------------------------------------------------------------- mort : le sol se fissure sous lui
local function deathFx(p, height)
	local center = p + Vector3.new(0, 0.15, 0)
	ringAt(center, rgb(255, 230, 255), 6, 90, 0.9)
	sparkle(center + Vector3.new(0, 4, 0), VIOLET, 80, 50, 3)
	sound(SND.Boom, 1, 0.45, center)
	sound(SND.Thunder, 1, 0.5, center)
	shake(2, 1.2)
	-- cratère sombre
	local crater = fxPart(Vector3.new(0.25, 4, 4), CFrame.new(center) * CFrame.Angles(0, 0, rad(90)), rgb(18, 12, 26), 0, Enum.PartType.Cylinder, Enum.Material.Slate)
	TweenService:Create(crater, TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = Vector3.new(0.25, 46, 46)}):Play()
	table.insert(leftovers, crater)
	local glow = fxPart(Vector3.new(0.3, 3, 3), CFrame.new(center + Vector3.new(0, 0.02, 0)) * CFrame.Angles(0, 0, rad(90)), rgb(255, 120, 60), 0.1, Enum.PartType.Cylinder)
	TweenService:Create(glow, TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = Vector3.new(0.3, 22, 22)}):Play()
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = rgb(255, 120, 60), 70, 4, false
	light.Parent = glow
	table.insert(leftovers, glow)
	-- fissures : des zigzags lumineux (lave violette et orange) qui partent du centre et s'allongent
	for i = 1, 16 do
		local a = i / 16 * math.pi * 2 + math.random() * 0.3
		local point = center
		local delay = 0
		for k = 1, 6 do
			a += (math.random() - 0.5) * 0.7
			local len = 7 + math.random() * 7 - k * 0.6
			local nextPoint = point + Vector3.new(cos(a) * len, 0, sin(a) * len)
			local w = math.max(2.4 - k * 0.32, 0.5)
			-- chaque morceau part du bout du précédent et s'allonge vers le suivant (axe Z = sens de la fissure)
			local dir = CFrame.lookAt(point, nextPoint)
			local full = len + w * 0.5
			local dark = fxPart(Vector3.new(w + 0.8, 0.2, 0.1), dir, rgb(16, 10, 22), 0, nil, Enum.Material.Slate)
			local hot = fxPart(Vector3.new(w * 0.45, 0.25, 0.1), dir + Vector3.new(0, 0.03, 0), k % 2 == 0 and rgb(255, 130, 60) or MAGENTA, 0)
			table.insert(leftovers, dark)
			table.insert(leftovers, hot)
			task.delay(delay, function()
				local info = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				TweenService:Create(dark, info, {Size = Vector3.new(w + 0.8, 0.2, full), CFrame = dir * CFrame.new(0, 0, -full / 2)}):Play()
				TweenService:Create(hot, info, {Size = Vector3.new(w * 0.45, 0.25, full), CFrame = dir * CFrame.new(0, 0.03, -full / 2)}):Play()
				if math.random() < 0.4 then sparkle(nextPoint + Vector3.new(0, 1, 0), rgb(255, 150, 80), 8, 12, 0.8) end
			end)
			delay += 0.09
			point = nextPoint
		end
	end
	-- débris projetés
	for i = 1, 22 do
		local rock = Instance.new("Part")
		rock.Size = Vector3.one * (1 + math.random() * 2.5)
		rock.Color = rgb(50 + math.random(0, 20), 42, 62)
		rock.Material = Enum.Material.Slate
		rock.CFrame = CFrame.new(center + Vector3.new(math.random(-6, 6), 2, math.random(-6, 6))) * CFrame.Angles(math.random(), math.random(), math.random())
		rock.CanCollide, rock.CanQuery, rock.CanTouch = true, false, false
		rock.Parent = fxFolder
		local a = math.random() * math.pi * 2
		rock.AssemblyLinearVelocity = Vector3.new(cos(a) * math.random(15, 40), math.random(40, 80), sin(a) * math.random(15, 40))
		rock.AssemblyAngularVelocity = Vector3.new(math.random(-8, 8), math.random(-8, 8), math.random(-8, 8))
		Debris:AddItem(rock, 4)
	end
	smoke(center + Vector3.new(0, 2, 0), rgb(90, 75, 110), 30, 14)
	-- puis il s'effondre et se dissout en lumière
	task.delay(2.6, function()
		sparkle(p + Vector3.new(0, height, 0), VIOLET, 120, 40, 2.5)
		sparkle(p + Vector3.new(0, height * 0.5, 0), GOLD, 60, 30, 1.8)
		sound(SND.Ghost, 0.8, 0.5, p)
	end)
	task.delay(2.2, function()
		if inArena() then showBanner("THE HEADLESS HAS FALLEN!", GOLD, 4.5) end
	end)
end

---------------------------------------------------------------- effets envoyés par le serveur
fxRemote.OnClientEvent:Connect(function(data)
	if type(data) ~= "table" then return end
	if data.k == "start" then
		showBanner("DEFEAT THE HEADLESS!", rgb(230, 190, 255), 2.5)
		sound(SND.Thunder, 0.8, 0.5)
		task.delay(2.7, function() if inArena() then showBanner("HIT HIM WITH YOUR BAT!", rgb(255, 220, 120), 2.5) end end)
	elseif data.k == "banner" then
		if inArena() then showBanner(data.text, data.color, data.t) end
	elseif data.k == "say" then
		if inArena() then bossSay(data.text, data.colors, data.t) end
	elseif data.k == "wave" then
		wave(data.o, data.t0, data.speed, data.dur)
	elseif data.k == "laser" then
		laser(data.a, data.b)
	elseif data.k == "boom" then
		boom(data.p, data.s)
	elseif data.k == "hit" then
		if data.big then
			sparkle(data.p, MAGENTA, 26, 22, 1.5)
			ringAt(data.p, rgb(255, 220, 255), 1, 9, 0.25, 0.3)
			if _G.BatHitSound then _G.BatHitSound(data.p) else sound(SND.Hit, 0.9, 0.65, data.p) end
			if data.amount then damageNumber(data.p + Vector3.new(0, 4, 0), data.amount) end
		else
			sparkle(data.p, Color3.new(1, 1, 1), 14, 18, 0.9)
			sound(SND.Thud, 0.7, 0.8, data.p)
			shake(0.6, 0.25)
		end
	elseif data.k == "snap" then
		ringAt(data.p, MAGENTA, 3, 46, 0.6, 0.1)
		local flash = fxPart(Vector3.one * 3, CFrame.new(data.p), rgb(255, 230, 255), 0, Enum.PartType.Ball)
		expand(flash, Vector3.one * 16, 0.35, 1)
		sparkle(data.p, VIOLET, 50, 34, 1.6)
		sound(SND.Snap, 1, 0.5, data.p)
		sound(SND.Thunder, 0.5, 1.4, data.p)
	elseif data.k == "tp" then
		teleportFx(data.from, data.to, data.t0, data.height)
	elseif data.k == "death" then
		deathFx(data.p, data.height)
	elseif data.k == "reward" then
		-- ma récompense (classement aux dégâts), juste après "THE HEADLESS HAS FALLEN!"
		local medal = ({rgb(255, 215, 80), rgb(225, 230, 245), rgb(230, 150, 90)})[data.rank] or VIOLET
		task.delay(4.8, function()
			showBanner("TOP #" .. data.rank .. "  >  " .. string.upper(data.pet) .. "!", medal, 3.5)
			sound(SND.Ghost, 0.5, 1.4)
			sparkle(workspace.CurrentCamera.CFrame * Vector3.new(0, 2, -12), medal, 40, 14, 0.6)
		end)
	end
end)

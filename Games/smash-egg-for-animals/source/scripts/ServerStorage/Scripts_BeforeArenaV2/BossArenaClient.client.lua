-- BossArenaClient : tout ce que voit un joueur pendant le combat contre le Headless (BossArenaServer) :
--   * la barre de vie du boss (en haut), la sienne (en bas), les annonces au centre
--   * le boss : il glisse d'un point à l'autre (attributs Move*), se tourne vers sa cible (FaceTo), et chaque membre est animé
--     ici selon son action (Action / ActionT : idle, walk, roar, slam, snap, die) — rien n'est animé sur le serveur
--   * les effets (remote BossArena.Fx) : l'onde du coup au sol, les lasers des robots, les explosions, les coups de batte
--   * l'éclairage nocturne violet et la musique de combat tant qu'il est dans l'arène (attribut InBossArena)
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
local rgb = Color3.fromRGB
local rad, sin, cos = math.rad, math.sin, math.cos
local VIOLET, MAGENTA = rgb(190, 90, 255), rgb(255, 140, 255)
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local function now() return workspace:GetServerTimeNow() end
local function inArena() return player:GetAttribute("InBossArena") == true end

local function sound(id, volume, speed, parent)
	local s = Instance.new("Sound")
	s.SoundId = typeof(id) == "number" and ("rbxassetid://" .. id) or id
	s.Volume, s.PlaybackSpeed = volume or 0.5, speed or 1
	s.Parent = parent or SoundService
	s:Play()
	Debris:AddItem(s, 8)
	return s
end
local SND = {Thunder = "rbxasset://sounds/HalloweenThunder.wav", Laser = "rbxasset://sounds/electronicpingshort.wav", Snap = "rbxasset://sounds/snap.wav",
	Hit = "rbxasset://sounds/swordslash.wav", Boom = 9119747138, Thud = "rbxasset://sounds/collide.wav"}

---------------------------------------------------------------- interface
local gui = Instance.new("ScreenGui")
gui.Name = "BossArenaGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 20
gui.Enabled = false
gui.Parent = player:WaitForChild("PlayerGui")
local function label(parent, props, stroke)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.FontFace = FONT
	l.TextScaled = true
	l.TextColor3 = Color3.new(1, 1, 1)
	for k, v in props do l[k] = v end
	local s = Instance.new("UIStroke")
	s.Thickness, s.Color = stroke or 3, Color3.new(0, 0, 0)
	s.Parent = l
	l.Parent = parent
	return l
end
local function bar(parent, size, position, colors)
	local back = Instance.new("Frame")
	back.Size, back.Position = size, position
	back.AnchorPoint = Vector2.new(0.5, 0)
	back.BackgroundColor3 = rgb(24, 20, 32)
	back.BorderSizePixel = 0
	local stroke = Instance.new("UIStroke")
	stroke.Thickness, stroke.Color = 3, rgb(10, 8, 14)
	stroke.Parent = back
	local lag = Instance.new("Frame")
	lag.Name = "Lag"
	lag.BackgroundColor3 = rgb(255, 255, 255)
	lag.BorderSizePixel = 0
	lag.Size = UDim2.fromScale(1, 1)
	lag.Parent = back
	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.BackgroundColor3 = Color3.new(1, 1, 1)
	fill.BorderSizePixel = 0
	fill.Size = UDim2.fromScale(1, 1)
	fill.Parent = back
	local g = Instance.new("UIGradient")
	g.Color = ColorSequence.new(colors[1], colors[2])
	g.Rotation = 0
	g.Parent = fill
	local shine = Instance.new("Frame")
	shine.BackgroundColor3 = Color3.new(1, 1, 1)
	shine.BackgroundTransparency = 0.75
	shine.BorderSizePixel = 0
	shine.Size = UDim2.new(1, 0, 0.35, 0)
	shine.Parent = fill
	back.Parent = parent
	return back, fill, lag
end
local top = Instance.new("Frame")
top.Name = "BossBar"
top.BackgroundTransparency = 1
top.AnchorPoint = Vector2.new(0.5, 0)
top.Position = UDim2.new(0.5, 0, 0, 62)
top.Size = UDim2.fromOffset(640, 74)
top.Parent = gui
local bossName = label(top, {Text = "THE HEADLESS", Size = UDim2.new(1, 0, 0, 28), TextColor3 = rgb(230, 200, 255)}, 3)
local enraged = label(top, {Text = "ENRAGED", Size = UDim2.fromOffset(140, 22), Position = UDim2.new(1, -140, 0, 4), TextColor3 = rgb(255, 80, 110), Visible = false}, 2.5)
local bossBack, bossFill, bossLag = bar(top, UDim2.new(1, 0, 0, 34), UDim2.new(0.5, 0, 0, 34), {rgb(150, 60, 255), rgb(255, 120, 230)})
local bossText = label(bossBack, {Text = "10,000 / 10,000", Size = UDim2.new(1, 0, 0.8, 0), Position = UDim2.fromScale(0, 0.1), ZIndex = 3}, 2.5)
local me = Instance.new("Frame")
me.Name = "PlayerBar"
me.BackgroundTransparency = 1
me.AnchorPoint = Vector2.new(0.5, 1)
me.Position = UDim2.new(0.5, 0, 1, -182) -- au-dessus du bouton Auto Swing
me.Size = UDim2.fromOffset(320, 50)
me.Parent = gui
label(me, {Text = "YOUR HP", Size = UDim2.new(1, 0, 0, 18), TextColor3 = rgb(200, 255, 200)}, 2)
local meBack, meFill, meLag = bar(me, UDim2.new(1, 0, 0, 26), UDim2.new(0.5, 0, 0, 22), {rgb(90, 230, 90), rgb(40, 170, 60)})
local meText = label(meBack, {Text = "100 / 100", Size = UDim2.new(1, 0, 0.8, 0), Position = UDim2.fromScale(0, 0.1), ZIndex = 3}, 2)
local banner = label(gui, {Text = "", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.3), Size = UDim2.fromOffset(760, 70), Visible = false}, 4)
local bannerScale = Instance.new("UIScale")
bannerScale.Parent = banner
local bannerId = 0
local function showBanner(text, color, t)
	bannerId += 1
	local id = bannerId
	banner.Text, banner.TextColor3, banner.Visible = text, color or Color3.new(1, 1, 1), true
	banner.TextTransparency = 0
	bannerScale.Scale = 0.6
	TweenService:Create(bannerScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	task.delay(t or 2, function() if bannerId == id then banner.Visible = false end end)
end
local function comma(n)
	local s = tostring(math.floor(n))
	local out = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return (out:gsub("^,", ""))
end

---------------------------------------------------------------- éclairage et musique de l'arène
local ARENA_LIGHT = {ClockTime = 0, Brightness = 2.4, Ambient = rgb(130, 110, 165), OutdoorAmbient = rgb(150, 125, 190), FogColor = rgb(40, 20, 66),
	FogStart = 350, FogEnd = 2000, ColorShift_Top = rgb(190, 150, 255), ExposureCompensation = 0.45}
local saved
local music
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
	elseif not on and saved then
		for k, v in saved do if k ~= "__days" then Lighting[k] = v end end
		if saved.__days then saved.__days:Resume() end
		saved = nil
		if music then music:Destroy() music = nil end
	end
end
local hiddenGuis = {}
local function refreshArena()
	local on = inArena()
	gui.Enabled = on
	setArenaMood(on)
	-- le texte du tutoriel passerait derrière la barre du boss : caché pendant le combat
	local playerGui = player:FindFirstChild("PlayerGui")
	if on and playerGui then
		for _, name in {"TutorialGui"} do
			local g = playerGui:FindFirstChild(name)
			if g and g.Enabled then g.Enabled = false hiddenGuis[g] = true end
		end
	elseif not on then
		for g in hiddenGuis do if g.Parent then g.Enabled = true end end
		table.clear(hiddenGuis)
	end
end
player:GetAttributeChangedSignal("InBossArena"):Connect(refreshArena)
refreshArena()
-- (d'autres scripts réécrivent l'éclairage : on le réimpose tant qu'on est dans l'arène)
task.spawn(function()
	while true do
		task.wait(0.5)
		if saved then for k, v in ARENA_LIGHT do if Lighting[k] ~= v then Lighting[k] = v end end end
	end
end)

---------------------------------------------------------------- le boss : déplacement et animation
local MOTORS = {"Root", "RightShoulder", "LeftShoulder", "RightHip", "LeftHip"}
local function A(x, y, z) return CFrame.Angles(rad(x or 0), rad(y or 0), rad(z or 0)) end
local function smooth(u) u = math.clamp(u, 0, 1) return u * u * (3 - 2 * u) end
local function blend(a, b, u)
	local out = {}
	for _, n in MOTORS do out[n] = (a[n] or CFrame.identity):Lerp(b[n] or CFrame.identity, u) end
	return out
end
local IDLE = {Root = A(-3), RightShoulder = A(14, 0, 8), LeftShoulder = A(10, 0, -8)}
local function pose(action, e, t)
	if action == "walk" then
		local s = sin(t * 4.2)
		return {Root = A(-6, 4 * s), RightHip = A(26 * s), LeftHip = A(-26 * s), RightShoulder = A(16 - 8 * s, 0, 8), LeftShoulder = A(22 * s, 0, -8)}
	elseif action == "roar" then
		local u = smooth(e / 0.4) * (1 - smooth((e - 1.6) / 0.4))
		return blend(IDLE, {Root = A(14), RightShoulder = A(30, 0, 75), LeftShoulder = A(30, 0, -75), RightHip = A(-8), LeftHip = A(8)}, u)
	elseif action == "slam" then
		local WIND = 1.3
		local raise = {Root = A(12), RightShoulder = A(172, 0, -8), LeftShoulder = A(168, 0, 8), RightHip = A(-6), LeftHip = A(10)}
		local strike = {Root = A(-32), RightShoulder = A(48, 0, -4), LeftShoulder = A(44, 0, 4), RightHip = A(-28), LeftHip = A(38)}
		if e < WIND then return blend(IDLE, raise, smooth(e / WIND)) end
		if e < WIND + 0.14 then return blend(raise, strike, smooth((e - WIND) / 0.14)) end
		if e < WIND + 0.8 then return strike end
		return blend(strike, IDLE, smooth((e - WIND - 0.8) / 0.5))
	elseif action == "snap" then
		local up = {Root = A(-4), RightShoulder = A(14, 0, 8), LeftShoulder = A(135, 0, -25)}
		local flick = {Root = A(-6), RightShoulder = A(14, 0, 8), LeftShoulder = A(150, 0, -10)}
		if e < 0.4 then return blend(IDLE, up, smooth(e / 0.4)) end
		if e < 0.65 then return blend(up, flick, smooth((e - 0.4) / 0.15)) end
		return blend(flick, IDLE, smooth((e - 0.65) / 0.6))
	elseif action == "die" then
		local kneel = {Root = A(-26), RightHip = A(85), LeftHip = A(-70), RightShoulder = A(10, 0, 25), LeftShoulder = A(20, 0, -20)}
		return blend(IDLE, kneel, smooth(e / 0.8))
	end
	local b = sin(t * 1.5)
	return {Root = A(-3 + 2 * b), RightShoulder = A(14 + 3 * b, 0, 8), LeftShoulder = A(10 - 3 * b, 0, -8)}
end

local bossState = {yaw = 0, current = {}}
local function bossModel() return workspace:FindFirstChild("ArenaHeadless") end
RunService.RenderStepped:Connect(function(dt)
	local model = bossModel()
	if not model or not model.PrimaryPart then return end
	local hrp = model.PrimaryPart
	local t = now()
	-- position : glisse de MoveFrom à MoveTo pendant MoveDur
	local from, to, t0, dur = model:GetAttribute("MoveFrom"), model:GetAttribute("MoveTo"), model:GetAttribute("MoveT0"), model:GetAttribute("MoveDur")
	local height = model:GetAttribute("Height") or 30
	local pos = Vector3.new(hrp.Position.X, hrp.Position.Y - height, hrp.Position.Z)
	local moving = false
	if from and to and t0 and dur and t < t0 + dur + 0.05 then
		local k = smooth((t - t0) / dur)
		pos = from:Lerp(to, k)
		moving = true
	elseif to and t0 and t >= t0 then
		pos = to
	end
	-- regard
	local aim = moving and (to - from) or nil
	local face = model:GetAttribute("FaceTo")
	if not aim and face then aim = face - pos end
	if aim and Vector3.new(aim.X, 0, aim.Z).Magnitude > 0.5 then
		local want = math.atan2(-aim.X, -aim.Z)
		local diff = (want - bossState.yaw + math.pi) % (2 * math.pi) - math.pi
		bossState.yaw += diff * (1 - math.exp(-dt * 4))
	end
	hrp.CFrame = CFrame.new(pos + Vector3.new(0, height, 0)) * CFrame.Angles(0, bossState.yaw, 0)
	-- membres
	local action = model:GetAttribute("Action") or "idle"
	local e = t - (model:GetAttribute("ActionT") or t)
	if action == "walk" and not moving then action = "idle" end
	local target = pose(action, e, t)
	local hurtT = model:GetAttribute("HurtT")
	if hurtT and t - hurtT < 0.25 then target.Root = (target.Root or CFrame.identity) * A(8 * (1 - (t - hurtT) / 0.25)) end
	local k = 1 - math.exp(-dt * 14)
	for _, n in MOTORS do
		local part = n == "Root" and model:FindFirstChild("Torso") or model:FindFirstChild(n == "RightShoulder" and "Right Arm" or n == "LeftShoulder" and "Left Arm" or n == "RightHip" and "Right Leg" or "Left Leg")
		local motor = part and part:FindFirstChild(n)
		if motor then
			local cur = bossState.current[n] or CFrame.identity
			cur = cur:Lerp(target[n] or CFrame.identity, k)
			bossState.current[n] = cur
			motor.Transform = cur
		end
	end
	-- mort : il s'efface
	if action == "die" and e > 2 then
		local a = math.clamp((e - 2) / 2.5, 0, 1)
		for _, d in model:GetDescendants() do if d:IsA("BasePart") then d.LocalTransparencyModifier = a end end
	end
end)

---------------------------------------------------------------- barres de vie
local shownBoss, lagBoss = 1, 1
local shownMe, lagMe = 1, 1
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
		if phase2 then enraged.TextTransparency = 0.25 + 0.25 * sin(os.clock() * 6) end
	end
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local f = math.clamp(humanoid.Health / math.max(humanoid.MaxHealth, 1), 0, 1)
		shownMe += (f - shownMe) * math.min(1, dt * 12)
		lagMe = math.max(shownMe, lagMe - dt * 0.4)
		meFill.Size = UDim2.fromScale(shownMe, 1)
		meLag.Size = UDim2.fromScale(lagMe, 1)
		meText.Text = math.ceil(humanoid.Health) .. " / " .. math.floor(humanoid.MaxHealth)
	end
end)

---------------------------------------------------------------- effets
local fxFolder = Instance.new("Folder")
fxFolder.Name = "BossArenaFx"
fxFolder.Parent = workspace
local function fxPart(size, cf, color, transp, shape)
	local p = Instance.new("Part")
	p.Size, p.CFrame, p.Color = size, cf, color
	p.Material = Enum.Material.Neon
	p.Transparency = transp or 0
	if shape then p.Shape = shape end
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
	p.Parent = fxFolder
	return p
end
local function sparkle(pos, color, count, speed, size)
	local holder = fxPart(Vector3.one * 0.2, CFrame.new(pos), color, 1)
	local e = Instance.new("ParticleEmitter")
	e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	e.Color = ColorSequence.new(Color3.new(1, 1, 1), color)
	e.LightEmission, e.LightInfluence = 1, 0
	e.Rate = 0
	e.Lifetime = NumberRange.new(0.3, 0.7)
	e.Speed = NumberRange.new(speed * 0.5, speed)
	e.SpreadAngle = Vector2.new(180, 180)
	e.Drag = 3
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, size), NumberSequenceKeypoint.new(1, 0)})
	e.Parent = holder
	e:Emit(count)
	Debris:AddItem(holder, 1.2)
end
local function expand(p, toSize, time, toTransp)
	TweenService:Create(p, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = toSize, Transparency = toTransp or 1}):Play()
	Debris:AddItem(p, time + 0.05)
end

-- l'onde : un mur de lumière violet qui s'élargit à partir du boss
local function wave(o, t0, speed, dur)
	local N = 72
	local core, halo = {}, {}
	for i = 1, N do
		core[i] = fxPart(Vector3.new(1.4, 4.5, 2), CFrame.new(o), VIOLET, 0.15)
		halo[i] = fxPart(Vector3.new(3, 5.5, 2), CFrame.new(o), MAGENTA, 0.82)
	end
	local crater = fxPart(Vector3.new(0.4, 6, 6), CFrame.new(o + Vector3.new(0, 0.3, 0)) * CFrame.Angles(0, 0, rad(90)), rgb(255, 210, 255), 0.1, Enum.PartType.Cylinder)
	expand(crater, Vector3.new(0.4, 70, 70), 0.9, 1)
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = VIOLET, 80, 6, false
	light.Parent = crater
	sparkle(o + Vector3.new(0, 2, 0), VIOLET, 60, 40, 2.5)
	sound(SND.Boom, 0.9, 0.6)
	sound(SND.Thunder, 0.8, 0.7)
	local conn
	conn = RunService.RenderStepped:Connect(function()
		local e = now() - t0
		if e > dur then
			conn:Disconnect()
			for i = 1, N do core[i]:Destroy() halo[i]:Destroy() end
			return
		end
		local r = math.max(e * speed, 1)
		local len = 2 * math.pi * r / N * 1.06
		local fade = e > dur - 0.6 and (e - (dur - 0.6)) / 0.6 or 0
		for i = 1, N do
			local a = i / N * math.pi * 2
			local cf = CFrame.new(o.X + cos(a) * r, o.Y + 2.25, o.Z + sin(a) * r) * CFrame.Angles(0, -a, 0)
			core[i].CFrame, core[i].Size = cf, Vector3.new(1.4, 4.5, len)
			core[i].Transparency = 0.15 + 0.85 * fade
			halo[i].CFrame, halo[i].Size = cf * CFrame.new(-1, 0.6, 0), Vector3.new(3, 5.5, len)
			halo[i].Transparency = 0.82 + 0.18 * fade
		end
	end)
end

local function laser(a, b)
	local d = (b - a).Magnitude
	local beam = fxPart(Vector3.new(d, 0.45, 0.45), CFrame.lookAt((a + b) / 2, b) * CFrame.Angles(0, rad(90), 0), rgb(255, 50, 60), 0, Enum.PartType.Cylinder)
	local glowP = fxPart(Vector3.new(d, 1.2, 1.2), beam.CFrame, rgb(255, 120, 130), 0.6, Enum.PartType.Cylinder)
	expand(beam, Vector3.new(d, 0.05, 0.05), 0.3, 1)
	expand(glowP, Vector3.new(d, 0.1, 0.1), 0.3, 1)
	sparkle(b, rgb(255, 80, 80), 18, 18, 0.8)
	sound(SND.Laser, 0.5, 0.7)
end

local function boom(p, s)
	s = s or 1
	local ball = fxPart(Vector3.one * 2 * s, CFrame.new(p), rgb(255, 170, 80), 0, Enum.PartType.Ball)
	expand(ball, Vector3.one * 10 * s, 0.45, 1)
	local ring = fxPart(Vector3.new(0.3, 2 * s, 2 * s), CFrame.new(p) * CFrame.Angles(0, 0, rad(90)), VIOLET, 0.2, Enum.PartType.Cylinder)
	expand(ring, Vector3.new(0.3, 16 * s, 16 * s), 0.5, 1)
	sparkle(p, rgb(255, 160, 60), math.floor(30 * s), 26 * s, 1.2 * s)
	sound(SND.Boom, 0.7, 1.1)
end

fxRemote.OnClientEvent:Connect(function(data)
	if type(data) ~= "table" then return end
	if data.k == "start" then
		showBanner("DEFEAT THE HEADLESS!", rgb(230, 190, 255), 2.5)
		sound(SND.Thunder, 0.8, 0.5)
		task.delay(2.7, function() if inArena() then showBanner("HIT HIM WITH YOUR BAT!", rgb(255, 220, 120), 2.5) end end)
	elseif data.k == "banner" then
		if inArena() then showBanner(data.text, data.color, data.t) end
	elseif data.k == "wave" then
		wave(data.o, data.t0, data.speed, data.dur)
	elseif data.k == "laser" then
		laser(data.a, data.b)
	elseif data.k == "boom" then
		boom(data.p, data.s)
	elseif data.k == "hit" then
		sparkle(data.p, data.big and MAGENTA or Color3.new(1, 1, 1), data.big and 24 or 12, 20, data.big and 1.4 or 0.8)
		if data.big then sound(SND.Hit, 0.6, 0.8 + math.random() * 0.3) else sound(SND.Thud, 0.6, 0.8) end
	elseif data.k == "snap" then
		local ring = fxPart(Vector3.new(0.3, 3, 3), CFrame.new(data.p) * CFrame.Angles(0, 0, rad(90)), MAGENTA, 0.1, Enum.PartType.Cylinder)
		expand(ring, Vector3.new(0.3, 40, 40), 0.6, 1)
		local flash = fxPart(Vector3.one * 3, CFrame.new(data.p), rgb(255, 230, 255), 0, Enum.PartType.Ball)
		expand(flash, Vector3.one * 14, 0.35, 1)
		sparkle(data.p, VIOLET, 40, 30, 1.5)
		sound(SND.Snap, 1, 0.5)
		sound(SND.Thunder, 0.5, 1.4)
	end
end)

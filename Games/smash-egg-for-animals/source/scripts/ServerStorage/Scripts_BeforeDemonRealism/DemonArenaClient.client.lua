-- DemonArenaClient : tout ce que voit un joueur pendant le combat contre le TRUE DEMON (DemonBossController) :
--   * l'interface : barre de vie du boss (nom, PV, phase), annonces, bulle où le boss parle, chiffres de dégâts, flash rouge
--     quand on est touché
--   * le boss : il glisse d'un point à l'autre (attributs Move*), se tourne vers sa cible (Face), et chaque articulation est animée
--     ici selon son action (Action / ActionT) avec les poses de FightFilm.DemonCast ; il rougit quand on le touche (HurtT)
--   * les effets (remote DemonCity.ArenaFx) : onde, météores, griffes, charge, colonnes de feu, mort
--   * l'ambiance de la ville (DemonCity.Mood : ciel rouge), la musique, des explosions et des éclairs au loin, tant qu'il est
--     dans l'arène (attribut InDemonArena) ; l'écran noir laissé par la cinématique est retiré à l'arrivée
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local shared = ReplicatedStorage:WaitForChild("DemonCity")
local Config = require(shared:WaitForChild("CinematicConfig"))
local Mood = require(shared:WaitForChild("Mood"))
local fxRemote = shared:WaitForChild("ArenaFx")
local FF = ReplicatedStorage:WaitForChild("FightFilm")
local Kit = require(FF:WaitForChild("Kit"))
local DemonCast = require(FF:WaitForChild("DemonCast"))
local B = DemonCast.Poses
local VFX = FF:WaitForChild("Vfx")
local MESHES = VFX:WaitForChild("Meshes")

local V, rgb = Vector3.new, Color3.fromRGB
local rad, sin, cos, clamp, random = math.rad, math.sin, math.cos, math.clamp, math.random
local C = Config.CENTER
local S = Config.Sounds
local RED, ORANGE, GOLD, WHITE = rgb(255, 50, 30), rgb(255, 140, 40), rgb(255, 210, 90), rgb(255, 255, 255)
local HEAVY = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local function now() return workspace:GetServerTimeNow() end
local function inArena() return player:GetAttribute("InDemonArena") == true end
local function smooth(u) u = clamp(u, 0, 1) return u * u * (3 - 2 * u) end

---------------------------------------------------------------- sons
local function sound(id, volume, speed, position)
	local s = Instance.new("Sound")
	s.SoundId = typeof(id) == "number" and ("rbxassetid://" .. id) or id
	s.Volume, s.PlaybackSpeed = volume or 0.5, speed or 1
	if position then
		local a = Instance.new("Attachment")
		a.WorldPosition = position
		a.Parent = workspace.Terrain
		s.RollOffMinDistance, s.RollOffMaxDistance = 40, 700
		s.Parent = a
		Debris:AddItem(a, 8)
	else
		s.Parent = SoundService
		Debris:AddItem(s, 8)
	end
	s:Play()
	return s
end

---------------------------------------------------------------- interface
local gui = Instance.new("ScreenGui")
gui.Name = "DemonArenaGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 20
gui.Enabled = false
gui.Parent = player:WaitForChild("PlayerGui")
local function stroke(parent, thickness, color)
	local s = Instance.new("UIStroke")
	s.Thickness, s.Color = thickness, color or Color3.new(0, 0, 0)
	s.LineJoinMode = Enum.LineJoinMode.Round
	s.Parent = parent
	return s
end
local function gradient(parent, colors, rotation)
	local pts = {}
	for i, c in colors do pts[i] = ColorSequenceKeypoint.new((i - 1) / math.max(1, #colors - 1), c) end
	local g = Instance.new("UIGradient")
	g.Color = ColorSequence.new(pts)
	g.Rotation = rotation or 0
	g.Parent = parent
	return g
end
local function label(parent, props)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.FontFace = HEAVY
	l.TextScaled = true
	l.TextColor3 = WHITE
	for k, v in props do l[k] = v end
	l.Parent = parent
	return l
end
-- barre de vie du boss
local top = Instance.new("Frame")
top.BackgroundTransparency = 1
top.AnchorPoint = Vector2.new(0.5, 0)
top.Position, top.Size = UDim2.new(0.5, 0, 0, 42), UDim2.new(0.5, 0, 0, 64)
top.Parent = gui
local nameLabel = label(top, {Text = Config.Lines.BossName, Size = UDim2.new(1, 0, 0, 30), TextColor3 = WHITE})
gradient(nameLabel, {rgb(255, 210, 190), RED, rgb(150, 0, 10)}, 90)
stroke(nameLabel, 3, rgb(30, 0, 4))
local phaseLabel = label(top, {Text = "PHASE 2", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 4), Size = UDim2.new(0.22, 0, 0, 22), TextColor3 = GOLD})
stroke(phaseLabel, 2.5, rgb(30, 0, 4))
local back = Instance.new("Frame")
back.Position, back.Size = UDim2.new(0, 0, 0, 34), UDim2.new(1, 0, 0, 26)
back.BackgroundColor3 = rgb(22, 8, 10)
back.BorderSizePixel = 0
back.Parent = top
stroke(back, 3, rgb(255, 70, 40))
local lag = Instance.new("Frame")
lag.BackgroundColor3 = rgb(255, 235, 220)
lag.BorderSizePixel = 0
lag.Size = UDim2.fromScale(1, 1)
lag.Parent = back
local fill = Instance.new("Frame")
fill.BackgroundColor3 = WHITE
fill.BorderSizePixel = 0
fill.Size = UDim2.fromScale(1, 1)
fill.Parent = back
local fillGradient = gradient(fill, {rgb(255, 90, 50), rgb(220, 20, 30), rgb(120, 0, 20)}, 0)
local shine = Instance.new("Frame")
shine.BackgroundColor3 = WHITE
shine.BackgroundTransparency = 0.75
shine.BorderSizePixel = 0
shine.Size = UDim2.new(1, 0, 0.38, 0)
shine.Parent = fill
local hpText = label(back, {Text = "", Size = UDim2.fromScale(1, 0.8), Position = UDim2.fromScale(0, 0.1), ZIndex = 3})
stroke(hpText, 2)
-- grande annonce au centre
local banner = label(gui, {Text = "", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.3), Size = UDim2.fromOffset(820, 78), Visible = false})
local bannerGradient = gradient(banner, {WHITE, GOLD, WHITE}, 90)
stroke(banner, 4.5, rgb(30, 0, 4))
local bannerScale = Instance.new("UIScale")
bannerScale.Parent = banner
local bannerId = 0
local function showBanner(text, color, t)
	bannerId += 1
	local id = bannerId
	color = color or WHITE
	bannerGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, WHITE), ColorSequenceKeypoint.new(0.5, color), ColorSequenceKeypoint.new(1, WHITE)})
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
-- flash rouge quand on est touché
local hurtFrame = Instance.new("Frame")
hurtFrame.BackgroundColor3 = rgb(200, 0, 0)
hurtFrame.BackgroundTransparency = 1
hurtFrame.BorderSizePixel = 0
hurtFrame.Size = UDim2.fromScale(1, 1)
hurtFrame.ZIndex = 0
hurtFrame.Parent = gui
local function comma(n)
	local out = tostring(math.floor(n)):reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return (out:gsub("^,", ""))
end

---------------------------------------------------------------- secousse de l'écran (décalage de caméra du personnage)
local shakeAmp, shakeUntil = 0, 0
local function shake(amount, dur)
	shakeAmp = math.max(shakeAmp, amount)
	shakeUntil = math.max(shakeUntil, os.clock() + (dur or 0.4))
end
local function shakeNear(pos, amount, range)
	local char = player.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	local d = (root.Position - pos).Magnitude
	if d < (range or 80) then shake(amount * (1 - d / (range or 80)) + 0.1, 0.4) end
end
RunService.RenderStepped:Connect(function()
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	if os.clock() < shakeUntil then
		local k = shakeUntil - os.clock()
		humanoid.CameraOffset = V(random() - 0.5, random() - 0.5, random() - 0.5) * shakeAmp * math.min(k * 3, 1)
	elseif shakeAmp > 0 then
		shakeAmp = 0
		humanoid.CameraOffset = Vector3.zero
	end
end)

---------------------------------------------------------------- effets de base
local fxFolder = Instance.new("Folder")
fxFolder.Name = "DemonArenaFx"
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
local function scaleSeq(seq, k)
	local pts = {}
	for _, p in seq.Keypoints do table.insert(pts, NumberSequenceKeypoint.new(p.Time, p.Value * k, p.Envelope * k)) end
	return NumberSequence.new(pts)
end
-- effet de la bibliothèque du jeu (FightFilm.Vfx) : copié, allumé, nettoyé
local function libBurst(name, cf, o)
	o = o or {}
	local src = VFX:FindFirstChild(name)
	if not src then return end
	local clone = src:Clone()
	if clone:IsA("BasePart") then
		clone.Anchored, clone.CanCollide, clone.CanQuery, clone.CanTouch = true, false, false, false
		clone.Transparency = 1
		clone.CFrame = typeof(cf) == "Vector3" and CFrame.new(cf) or cf
	end
	clone.Parent = fxFolder
	local life, loops = 0, {}
	for _, d in clone:GetDescendants() do
		if d:IsA("ParticleEmitter") then
			local k = o.scale or 1
			if k ~= 1 then
				d.Size = scaleSeq(d.Size, k)
				d.Speed = NumberRange.new(d.Speed.Min * k, d.Speed.Max * k)
				d.Acceleration *= k
			end
			if o.color then
				local first = d.Color.Keypoints[1].Value
				if first.R + first.G + first.B > 0.25 then d.Color = ColorSequence.new(o.color) end
			end
			life = math.max(life, d.Lifetime.Max)
			if d:GetAttribute("Loop") then
				d.Enabled = true
				table.insert(loops, d)
			else
				local n = d:GetAttribute("EmitCount")
				d:Emit(math.max(1, math.ceil((n and n > 0 and n or 1) * (o.mult or 1))))
			end
		elseif d:IsA("Beam") or d:IsA("Trail") then
			d.Enabled = true
			table.insert(loops, d)
		end
	end
	local hold = o.time or 0.25
	if #loops > 0 then task.delay(hold, function() for _, e in loops do e.Enabled = false end end) end
	Debris:AddItem(clone, hold + life + 0.5)
	return clone
end
-- maillage qui grandit et s'efface
local function libMesh(name, cf, size0, size1, time, color, transp0)
	local src = MESHES:FindFirstChild(name)
	if not src then return end
	local m = src:Clone()
	m.Anchored, m.CanCollide, m.CanQuery, m.CanTouch, m.CastShadow = true, false, false, false, false
	m.Material = Enum.Material.Neon
	m.Color = color or m.Color
	m.Size, m.CFrame, m.Transparency = size0, cf, transp0 or 0.1
	m.Parent = fxFolder
	local t0 = os.clock()
	local conn
	conn = RunService.RenderStepped:Connect(function()
		local u = (os.clock() - t0) / time
		if u >= 1 then conn:Disconnect() m:Destroy() return end
		local e = 1 - (1 - u) ^ 3
		m.Size = size0:Lerp(size1, e)
		m.Transparency = (transp0 or 0.1) + (1 - (transp0 or 0.1)) * u
	end)
	return m
end
local function flashLight(pos, color, range, brightness, time)
	local holder = fxPart(V(0.2, 0.2, 0.2), CFrame.new(pos), color, 1)
	local l = Instance.new("PointLight")
	l.Color, l.Range, l.Brightness, l.Shadows = color, range, brightness, false
	l.Parent = holder
	TweenService:Create(l, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Brightness = 0}):Play()
	Debris:AddItem(holder, time + 0.1)
end
local function rocks(center, count, power, size, color)
	for _ = 1, count do
		local r = Instance.new("Part")
		r.Size = V(1, 1, 1) * (size * (0.5 + random()))
		r.Color = color or rgb(74, 66, 66)
		r.Material = Enum.Material.Plastic
		r.MaterialVariant = "Studs"
		r.CFrame = CFrame.new(center + V(random(-3, 3), 1.5, random(-3, 3))) * CFrame.Angles(random(), random(), random())
		r.CanCollide, r.CanQuery, r.CanTouch, r.CastShadow = true, false, false, false
		r.Parent = fxFolder
		local a = random() * math.pi * 2
		r.AssemblyLinearVelocity = V(cos(a) * random(10, 30) * power, random(30, 60) * power, sin(a) * random(10, 30) * power)
		r.AssemblyAngularVelocity = V(random(-8, 8), random(-8, 8), random(-8, 8))
		Debris:AddItem(r, 3)
	end
end
local function ground(p, up) return V(p.X, C.Y + (up or 0.15), p.Z) end
-- disque plat au sol (cercle d'avertissement)
local function disc(pos, radius, color, transp)
	return fxPart(V(0.2, radius * 2, radius * 2), CFrame.new(ground(pos)) * CFrame.Angles(0, 0, rad(90)), color, transp, Enum.PartType.Cylinder)
end
local function damageNumber(pos, amount)
	local holder = fxPart(V(0.2, 0.2, 0.2), CFrame.new(pos + V(random(-3, 3), 0, random(-3, 3))), Color3.new(), 1)
	local bb = Instance.new("BillboardGui")
	bb.Size = UDim2.fromOffset(150, 64)
	bb.LightInfluence = 0
	bb.Parent = holder
	local l = label(bb, {Text = "-" .. amount, Size = UDim2.fromScale(1, 1)})
	gradient(l, {rgb(255, 245, 140), rgb(255, 120, 60), rgb(255, 40, 60)}, 90)
	local st = stroke(l, 3, rgb(40, 0, 6))
	local scale = Instance.new("UIScale")
	scale.Scale = 0.3
	scale.Parent = l
	TweenService:Create(scale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1.15}):Play()
	TweenService:Create(holder, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = holder.CFrame + V(0, 9, 0)}):Play()
	task.delay(0.5, function()
		TweenService:Create(l, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
		TweenService:Create(st, TweenInfo.new(0.4), {Transparency = 1}):Play()
	end)
	Debris:AddItem(holder, 1)
end
local function explosion(pos, s, color)
	s = s or 1
	libBurst("Explosion-01", pos, {scale = 2.5 * s, color = color or ORANGE, time = 0.3})
	libBurst("Smoke-01", pos, {scale = 2 * s})
	flashLight(pos + V(0, 3, 0), color or ORANGE, 40 * s, 5, 0.5)
	sound(S.Boom, 0.6, 0.85 + random() * 0.3, pos)
end

---------------------------------------------------------------- ambiance (ciel rouge, musique, explosions au loin)
local music
local ambientOn = false
local function boomPoints()
	local city = workspace:FindFirstChild("DestroyedCity")
	local env = city and city:FindFirstChild("EnvironmentalEffects")
	local f = env and env:FindFirstChild("ExplosionPoints")
	return f and f:GetChildren() or {}
end
local function setMood(on)
	if on and not ambientOn then
		ambientOn = true
		Mood.enter()
		music = Instance.new("Sound")
		music.SoundId, music.Looped, music.Volume = "rbxassetid://" .. Config.Music.Fight, true, 0
		music.Parent = SoundService
		music:Play()
		TweenService:Create(music, TweenInfo.new(1.5), {Volume = 0.45}):Play()
		task.spawn(function()
			while ambientOn do
				task.wait(2.5 + random() * 3.5)
				if not ambientOn then break end
				local pts = boomPoints()
				if #pts > 0 then
					local p = pts[random(#pts)]
					if p:IsA("BasePart") then explosion(p.Position, 2 + random() * 2, random() < 0.3 and RED or ORANGE) end
				end
				if random() < 0.35 then
					local pos = C + V(random(-450, 450), 0, random(-450, 450))
					local bolt = libMesh("Thunder", CFrame.new(pos + V(0, 140, 0)) * CFrame.Angles(0, random() * 6.28, 0), V(26, 220, 30), V(32, 250, 36), 0.35, rgb(255, 130, 120), 0)
					if bolt then flashLight(pos + V(0, 240, 0), rgb(255, 120, 110), 700, 4, 0.3) end
					sound(S.Thunder, 0.45, 0.8 + random() * 0.3)
				end
			end
		end)
	elseif not on and ambientOn then
		ambientOn = false
		Mood.leave()
		if music then
			local m = music
			music = nil
			TweenService:Create(m, TweenInfo.new(1), {Volume = 0}):Play()
			Debris:AddItem(m, 1.1)
		end
		fxFolder:ClearAllChildren()
	end
end
-- l'écran noir laissé par la cinématique : retiré en douceur une fois arrivé dans l'arène
local function clearTransition(delay)
	local g = player.PlayerGui:FindFirstChild("DemonTransitionGui")
	if not g then return end
	task.delay(delay or 0.6, function()
		local black = g:FindFirstChild("Black")
		if black then TweenService:Create(black, TweenInfo.new(0.9), {BackgroundTransparency = 1}):Play() end
		Debris:AddItem(g, 1)
	end)
end
local function refresh()
	local on = inArena()
	gui.Enabled = on
	setMood(on)
	if on then clearTransition(0.6) end
end
player:GetAttributeChangedSignal("InDemonArena"):Connect(refresh)
refresh()

---------------------------------------------------------------- le boss : déplacement, animation, bulle, rougeur
local boss -- {model, hrp, joints, stand, scale, cur = {}, yaw, phase, lastPos, bubble, highlight}
local stompGait, runGait = Kit.Gaits.demonStomp, Kit.Gaits.demonRun

local function updateBar()
	if not boss then return end
	local hp, max = boss.model:GetAttribute("Hp") or 0, boss.model:GetAttribute("MaxHp") or 1
	local k = clamp(hp / max, 0, 1)
	TweenService:Create(fill, TweenInfo.new(0.15), {Size = UDim2.fromScale(k, 1)}):Play()
	task.delay(0.35, function() TweenService:Create(lag, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Size = UDim2.fromScale(k, 1)}):Play() end)
	hpText.Text = comma(hp) .. " / " .. comma(max)
end
local function updatePhase()
	if not boss then return end
	local rage = boss.model:GetAttribute("Phase") == 2
	phaseLabel.Text = rage and "ENRAGED" or "PHASE 2"
	phaseLabel.TextColor3 = rage and rgb(255, 70, 40) or GOLD
	fillGradient.Color = rage and ColorSequence.new(rgb(255, 160, 60), rgb(255, 30, 20)) or ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 90, 50)), ColorSequenceKeypoint.new(0.5, rgb(220, 20, 30)), ColorSequenceKeypoint.new(1, rgb(120, 0, 20))})
	if rage and inArena() then Mood.setLevel(2, 2) end
end

local function onBoss(model)
	local hrp = model:WaitForChild("HumanoidRootPart", 10)
	local head = model:WaitForChild("Head", 10)
	if not hrp or not head then return end
	local b = {model = model, hrp = hrp, joints = DemonCast.joints(model), stand = model:GetAttribute("Stand") or 18, scale = model:GetAttribute("DemonScale") or 6,
		cur = {}, yaw = 0, phase = 0, highlight = model:FindFirstChildOfClass("Highlight")}
	-- bulle au-dessus de la tête
	local bb = Instance.new("BillboardGui")
	bb.Name = "DemonSpeech"
	bb.Size = UDim2.fromOffset(420, 70)
	bb.StudsOffsetWorldSpace = V(0, b.scale * 2.6, 0)
	bb.AlwaysOnTop = true
	bb.LightInfluence = 0
	bb.Enabled = false
	bb.Parent = head
	local speech = label(bb, {Text = "", Size = UDim2.fromScale(1, 1)})
	gradient(speech, {WHITE, rgb(255, 150, 120)}, 90)
	stroke(speech, 3, rgb(40, 0, 4))
	b.bubble, b.speech = bb, speech
	boss = b
	model:GetAttributeChangedSignal("Hp"):Connect(updateBar)
	model:GetAttributeChangedSignal("Phase"):Connect(updatePhase)
	model:GetAttributeChangedSignal("HurtT"):Connect(function()
		if b.highlight then
			b.highlight.FillTransparency = 0.55
			TweenService:Create(b.highlight, TweenInfo.new(0.25), {FillTransparency = 1}):Play()
		end
	end)
	updateBar()
	updatePhase()
	model.AncestryChanged:Connect(function() if not model:IsDescendantOf(workspace) and boss == b then boss = nil end end)
end
workspace.ChildAdded:Connect(function(child) if child.Name == "TrueDemonBoss" then task.spawn(onBoss, child) end end)
if workspace:FindFirstChild("TrueDemonBoss") then task.spawn(onBoss, workspace.TrueDemonBoss) end

-- pose voulue selon l'action et le temps depuis son début
local function merge(a, b)
	local out = {}
	for k, v in a do out[k] = v end
	for k, v in b or {} do out[k] = v end
	return out
end
local CFG = Config.Boss
local function targetPose(b, action, t, moving)
	if action == "appear" then
		if t < 1.0 then return B.FALL, 20 end
		if t < 1.7 then return B.LAND, 26 end
		if t < 3.0 then return B.ROAR, 12 end
		return B.IDLE, 8
	elseif action == "slam" then
		if t < CFG.SlamWindup then return B.SLAM_WIND, 9 end
		if t < CFG.SlamWindup + 0.9 then return B.SLAM, 30 end
		return B.IDLE, 6
	elseif action == "swipe" then
		if t < CFG.SwipeWindup then return B.SWIPE_WIND, 10 end
		if t < CFG.SwipeWindup + 0.45 then return B.SWIPE, 32 end
		return B.IDLE, 7
	elseif action == "meteor" then
		if t < CFG.MeteorWarn + 0.6 then return B.METEOR, 9 end
		return B.IDLE, 6
	elseif action == "chargeWarn" then
		return B.CHARGE, 10
	elseif action == "pillars" then
		if t < 0.55 then return B.SLAM_WIND, 12 end
		if t < 1.4 then return B.SLAM, 30 end
		return B.IDLE, 6
	elseif action == "enrage" then
		if t < 2.2 then return B.ROAR, 10 end
		return B.IDLE, 6
	elseif action == "die" then
		if t < 1.0 then return B.HURT, 10 end
		return B.KNEEL, 5
	end
	return B.IDLE, moving and 10 or 6
end

local function wrapAngle(a) return (a + math.pi) % (2 * math.pi) - math.pi end
local lastAction, lastActionT
local landed
RunService.RenderStepped:Connect(function(dt)
	local b = boss
	if not b or not b.model.Parent then return end
	local m = b.model
	local t = now()
	-- déplacement
	local from, to = m:GetAttribute("MoveFrom"), m:GetAttribute("MoveTo")
	if not from or not to then return end
	local t0, dur = m:GetAttribute("MoveT0") or 0, m:GetAttribute("MoveDur") or 0.01
	local u = clamp((t - t0) / dur, 0, 1)
	local linear = m:GetAttribute("MoveLinear") == true
	local pos = from:Lerp(to, linear and u or smooth(u))
	local moving = u < 1 and (to - from).Magnitude > 0.5
	local moved = b.lastPos and V(pos.X - b.lastPos.X, 0, pos.Z - b.lastPos.Z).Magnitude or 0
	b.lastPos = pos
	local action, actionT = m:GetAttribute("Action") or "idle", m:GetAttribute("ActionT") or t
	local at = t - actionT
	if action ~= lastAction or actionT ~= lastActionT then
		lastAction, lastActionT = action, actionT
		landed = false
	end
	-- orientation : vers là où il marche, sinon vers sa cible
	local want = b.yaw
	local dir
	if moving then dir = to - from else
		local f = m:GetAttribute("Face")
		if f then dir = f - pos end
	end
	if dir and V(dir.X, 0, dir.Z).Magnitude > 0.5 then want = math.atan2(-dir.X, -dir.Z) end
	local turnRate = (action == "charge" or action == "chargeWarn" or action == "swipe") and 14 or 5
	b.yaw += wrapAngle(want - b.yaw) * math.min(1, dt * turnRate)
	-- hauteur : chute à l'apparition, effondrement à la mort
	local lift, pitch = 0, 0
	if action == "appear" then
		if at < 1.0 then
			lift = 150 * (1 - at) ^ 2
		elseif not landed then
			landed = true
			local p = ground(pos, 0.5)
			libBurst("Ground-Impact", p, {scale = 4})
			libBurst("Big-Crack-01", p, {scale = 3.5})
			for i = 1, 3 do
				task.delay((i - 1) * 0.08, function() libMesh("Shockwave", CFrame.new(ground(pos, 0.6 + i * 0.2)), V(6, 2, 6), V(160 + i * 30, 2, 160 + i * 30), 1.1, ({ORANGE, RED, rgb(70, 56, 56)})[i], 0.15) end)
			end
			rocks(p, 12, 1.2, 2)
			flashLight(p + V(0, 6, 0), RED, 160, 6, 0.8)
			sound(S.Boom, 1, 0.6)
			sound(S.CosmicBoom, 0.6, 0.8)
			shakeNear(p, 2.5, 200)
		end
	elseif action == "die" and at > 1.2 then
		local k = clamp((at - 1.2) / 0.9, 0, 1)
		pitch = -rad(80) * k * k
		lift = -b.stand * 0.45 * k
	end
	b.hrp.CFrame = CFrame.new(pos + V(0, b.stand + lift, 0)) * CFrame.Angles(0, b.yaw, 0) * CFrame.Angles(pitch, 0, 0)
	-- pose
	local pose, rate = targetPose(b, action, at, moving)
	if action == "walk" or (moving and not linear) then
		b.phase += moved / (stompGait.stride * b.scale) * math.pi * 2
		local step = math.floor(b.phase / math.pi)
		if b.lastStep and step ~= b.lastStep then
			sound(S.Thud, 0.7, 0.5, ground(pos))
			shakeNear(pos, 0.6, 60)
			libBurst("Smoke-01", ground(pos, 0.5), {scale = 2})
		end
		b.lastStep = step
		pose = merge(B.IDLE, stompGait.fn(b.phase))
		rate = 12
	elseif action == "charge" then
		b.phase += moved / (runGait.stride * b.scale) * math.pi * 2
		pose = runGait.fn(b.phase)
		rate = 18
	end
	-- respiration et ondulation de la queue au repos
	local breathe = sin(t * 1.8)
	local k = 1 - math.exp(-dt * rate)
	for name, j in b.joints do
		local want3 = pose[name] or {0, 0, 0}
		local cur = b.cur[name]
		if not cur then cur = {want3[1] or 0, want3[2] or 0, want3[3] or 0} b.cur[name] = cur end
		local wx, wy, wz = want3[1] or 0, want3[2] or 0, want3[3] or 0
		if name == "Root" then wx += breathe * 1.5 end
		if name == "Neck" then wx += sin(t * 1.8 - 0.6) * 1.5 end
		if name == "Tail" then wy += sin(t * 1.3) * 10 end
		if name == "Tail2" then wy += sin(t * 1.3 - 0.8) * 12 end
		if name == "WingR" then wz += breathe * 4 end
		if name == "WingL" then wz -= breathe * 4 end
		cur[1] += (wx - cur[1]) * k
		cur[2] += (wy - cur[2]) * k
		cur[3] += (wz - cur[3]) * k
		j.obj.C0 = j.base * CFrame.Angles(rad(cur[1]), rad(cur[2]), rad(cur[3]))
	end
end)

---------------------------------------------------------------- effets du combat (remote DemonCity.ArenaFx)
local bubbleId = 0
local handlers = {}
handlers.start = function()
	clearTransition(0.4)
	showBanner(Config.Lines.Title, RED, 2.6)
	task.delay(2.8, function() showBanner("FIGHT!", GOLD, 1.4) end)
	sound(S.Screech, 0.9, 0.4)
end
handlers.say = function(d)
	local b = boss
	if not b then return end
	bubbleId += 1
	local id = bubbleId
	b.speech.Text = d.text
	b.bubble.Enabled = true
	task.delay(d.t or 2.4, function() if bubbleId == id and b.bubble.Parent then b.bubble.Enabled = false end end)
end
handlers.banner = function(d) showBanner(d.text, d.color, d.t) end
handlers.ouch = function()
	hurtFrame.BackgroundTransparency = 0.55
	TweenService:Create(hurtFrame, TweenInfo.new(0.45), {BackgroundTransparency = 1}):Play()
	shake(0.8, 0.3)
end
handlers.hit = function(d)
	libBurst("Punch-01", d.p, {scale = 1.4, color = GOLD})
	damageNumber(d.p + V(0, 3, 0), d.amount)
	if _G.BatHitSound then _G.BatHitSound(d.p) else sound(S.BatHit, 0.9, 0.65, d.p) end
end
-- l'onde : un anneau rouge qui traverse toute la place
handlers.wave = function(d)
	local o = ground(d.o, 0.6)
	libBurst("Ground-Impact", o, {scale = 3})
	libBurst("Big-Crack-01", o, {scale = 3})
	rocks(o, 10, 1, 1.8)
	sound(S.Boom, 1, 0.7, o)
	shakeNear(o, 1.6, 140)
	local src = MESHES:FindFirstChild("Shockwave")
	if not src then return end
	local ring = src:Clone()
	ring.Anchored, ring.CanCollide, ring.CanQuery, ring.CanTouch, ring.CastShadow = true, false, false, false, false
	ring.Material, ring.Color = Enum.Material.Neon, RED
	ring.Parent = fxFolder
	local ring2 = ring:Clone()
	ring2.Color = rgb(255, 170, 90)
	ring2.Parent = fxFolder
	local conn
	conn = RunService.RenderStepped:Connect(function()
		local e = now() - d.t0
		if e > d.dur or not ring.Parent then conn:Disconnect() ring:Destroy() ring2:Destroy() return end
		local r = math.max(1, e * d.speed)
		ring.Size = V(r * 2, 3.5, r * 2)
		ring.CFrame = CFrame.new(o + V(0, 1.2, 0))
		ring.Transparency = 0.05 + 0.5 * (e / d.dur)
		ring2.Size = V(r * 2 - 2, 1.5, r * 2 - 2)
		ring2.CFrame = CFrame.new(o + V(0, 0.6, 0))
		ring2.Transparency = 0.2 + 0.6 * (e / d.dur)
	end)
end
-- météores : cercles rouges, puis boules de feu qui tombent du ciel
handlers.meteorWarn = function(d)
	sound(S.Thunder, 0.6, 0.7)
	for _, p in d.points do
		local outer = disc(p, d.r, RED, 0.55)
		local inner = disc(p + V(0, 0.05, 0), 0.1, rgb(255, 160, 60), 0.35)
		local start = p + V(random(-30, 30), 120, random(-30, 30))
		local ball = fxPart(V(5, 5, 5), CFrame.new(start), rgb(255, 120, 40), 0, Enum.PartType.Ball)
		local fire = Instance.new("Fire")
		fire.Size, fire.Heat, fire.Color, fire.SecondaryColor = 8, 0, rgb(255, 150, 50), rgb(200, 20, 10)
		fire.Parent = ball
		local light = Instance.new("PointLight")
		light.Color, light.Range, light.Brightness, light.Shadows = ORANGE, 30, 3, false
		light.Parent = ball
		local conn
		conn = RunService.RenderStepped:Connect(function()
			local e = now() - d.t0
			local k = clamp(e / d.warn, 0, 1)
			inner.Size = V(0.2, d.r * 2 * k, d.r * 2 * k)
			outer.Transparency = 0.45 + 0.25 * sin(e * 14)
			ball.CFrame = CFrame.new(start:Lerp(ground(p, 2), k * k))
			if e >= d.warn then
				conn:Disconnect()
				outer:Destroy()
				inner:Destroy()
				ball:Destroy()
				local g = ground(p, 0.6)
				explosion(g, 1.2, ORANGE)
				libMesh("Shockwave", CFrame.new(g), V(2, 1, 2), V(d.r * 3, 1.5, d.r * 3), 0.6, RED, 0.2)
				rocks(g, 4, 0.7, 1.2)
				shakeNear(g, 1, 50)
			end
		end)
	end
end
handlers.swipe = function(d)
	libBurst("Slash-01", CFrame.lookAt(d.p, d.p + d.dir), {scale = 3.2, color = RED})
	libBurst("Wind-01", d.p, {scale = 2})
	sound(S.Swing, 1, 0.55, d.p)
	shakeNear(d.p, 0.6, 40)
end
-- charge : une bande rouge au sol, puis il fonce
handlers.chargeWarn = function(d)
	local from, to = ground(d.from, 0.2), ground(d.to, 0.2)
	local len = (to - from).Magnitude
	local stripe = fxPart(V(d.width, 0.2, len), CFrame.lookAt((from + to) / 2, to), RED, 0.5)
	local edgeL = fxPart(V(0.6, 0.25, len), CFrame.lookAt((from + to) / 2, to) * CFrame.new(-d.width / 2, 0, 0), rgb(255, 200, 120), 0.2)
	local edgeR = fxPart(V(0.6, 0.25, len), CFrame.lookAt((from + to) / 2, to) * CFrame.new(d.width / 2, 0, 0), rgb(255, 200, 120), 0.2)
	sound(S.Screech, 0.8, 0.55)
	local conn
	conn = RunService.RenderStepped:Connect(function()
		local e = now() - d.t0
		stripe.Transparency = 0.45 + 0.3 * sin(e * 16)
		if e > d.warn + 0.9 then conn:Disconnect() stripe:Destroy() edgeL:Destroy() edgeR:Destroy() end
	end)
	task.delay(d.warn, function()
		for i = 0, 6 do
			task.delay(i * 0.12, function() libBurst("Smoke-01", from:Lerp(to, i / 6) + V(0, 1, 0), {scale = 2.5}) end)
		end
		sound(S.Whoosh, 1, 0.5)
	end)
end
handlers.chargeEnd = function(d)
	local g = ground(d.p, 0.6)
	libBurst("Ground-Impact", g, {scale = 2.5})
	libMesh("Shockwave", CFrame.new(g), V(4, 1, 4), V(60, 1.5, 60), 0.7, ORANGE, 0.2)
	sound(S.Thud, 1, 0.5, g)
	shakeNear(g, 1.2, 80)
end
-- colonnes de feu qui avancent vers chaque joueur
handlers.pillars = function(d)
	sound(S.Fire, 0.7, 0.8)
	for _, pts in d.lines do
		for i, p in pts do
			local warnAt = d.t0 + (i - 1) * d.step
			local eruptAt = warnAt + d.warn
			task.delay(math.max(0, warnAt - now()), function()
				local mark = disc(p, d.r, RED, 0.4)
				task.delay(math.max(0, eruptAt - now()), function()
					mark:Destroy()
					local g = ground(p, 0)
					local pillar = fxPart(V(1, d.r * 1.6, d.r * 1.6), CFrame.new(g) * CFrame.Angles(0, 0, rad(90)), rgb(255, 110, 40), 0.1, Enum.PartType.Cylinder)
					local core = fxPart(V(1, d.r * 0.8, d.r * 0.8), CFrame.new(g) * CFrame.Angles(0, 0, rad(90)), rgb(255, 230, 160), 0, Enum.PartType.Cylinder)
					local t0 = os.clock()
					local conn
					conn = RunService.RenderStepped:Connect(function()
						local e = os.clock() - t0
						if e > 0.75 then conn:Disconnect() pillar:Destroy() core:Destroy() return end
						local h = 26 * math.min(1, e / 0.12)
						pillar.Size = V(h, d.r * 1.6, d.r * 1.6)
						pillar.CFrame = CFrame.new(g + V(0, h / 2, 0)) * CFrame.Angles(0, 0, rad(90))
						core.Size = V(h, d.r * 0.8, d.r * 0.8)
						core.CFrame = pillar.CFrame
						local fade = math.max(0, (e - 0.3) / 0.45)
						pillar.Transparency = 0.1 + 0.9 * fade
						core.Transparency = fade
					end)
					libBurst("Fire-01", g + V(0, 2, 0), {scale = 1.6})
					flashLight(g + V(0, 6, 0), ORANGE, 30, 4, 0.4)
					if i % 2 == 1 then sound(S.Boom, 0.35, 1.3, g) end
					shakeNear(g, 0.5, 30)
				end)
			end)
		end
	end
end
handlers.enrage = function()
	Mood.setLevel(2, 2)
	local b = boss
	local p = b and ground(b.hrp.Position, 0.6) or ground(C)
	libMesh("Shockwave", CFrame.new(p), V(6, 2, 6), V(220, 3, 220), 1.4, RED, 0.1)
	libBurst("Explosion-01", p + V(0, 10, 0), {scale = 6, color = RED})
	flashLight(p + V(0, 10, 0), RED, 220, 6, 1)
	hurtFrame.BackgroundTransparency = 0.6
	TweenService:Create(hurtFrame, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
	sound(S.Screech, 1, 0.35)
	sound(S.Meltdown, 0.6, 0.8)
	shake(1.4, 0.8)
end
handlers.death = function(d)
	local p = d.p
	sound(S.Screech, 1, 0.3)
	for i = 1, 6 do
		task.delay(0.25 * i, function()
			explosion(p + V(random(-12, 12), random(4, 30), random(-12, 12)), 2.2, i % 2 == 0 and RED or ORANGE)
		end)
	end
	task.delay(2, function()
		libMesh("Sphere", CFrame.new(p + V(0, 14, 0)), V(4, 4, 4), V(160, 160, 160), 1.4, WHITE, 0)
		libBurst("Realistic-Explosion-01", p + V(0, 14, 0), {scale = 10})
		flashLight(p + V(0, 14, 0), ORANGE, 400, 8, 1.5)
		sound(S.CosmicBoom, 1, 0.7)
		sound(S.Boom, 1, 0.55)
		shake(2.2, 1)
		local b = boss
		if b then
			for _, part in b.model:GetDescendants() do
				if part:IsA("BasePart") and part.Transparency < 1 then TweenService:Create(part, TweenInfo.new(1.2), {Transparency = 1}):Play() end
			end
		end
	end)
end
handlers.reward = function(d)
	task.delay(2.5, function()
		showBanner("#" .. d.rank .. "  —  " .. tostring(d.pet) .. "!", GOLD, 4)
	end)
end
fxRemote.OnClientEvent:Connect(function(d)
	if type(d) ~= "table" then return end
	local h = handlers[d.k]
	if h then
		local ok, err = pcall(h, d)
		if not ok then warn("[DemonArena] " .. tostring(d.k) .. " : " .. tostring(err)) end
	end
end)

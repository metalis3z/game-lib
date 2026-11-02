-- SkyEventsClient : côté joueur des events du ciel (SkyEventsServer)
--   * HUD en bas à droite (pile EventStackGui, comme le Cowboy) : le modèle de l'event qui tourne + nom + timer
--   * ambiance de l'écran pendant l'event (teinte légère : violette, bleu-orage, verte)
--   * éclairs qui clignotent dans les nuages d'orage, lumières du bord de la soucoupe qui tournent
--   * SONS : au lancement, la musique de fond "Days" est mise en pause et la musique de l'event démarre (fondu) ;
--     elle reprend à la fin. Plusieurs events en même temps : on entend celui lancé en dernier. Tonnerre à chaque éclair.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local models = ReplicatedStorage:WaitForChild("SkyEvents"):WaitForChild("Models")
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local rgb = Color3.fromRGB

local EVENTS = {
	{Name = "Meteor", Title = "METEOR SHOWER", Color = rgb(200, 170, 255), Model = "Meteor", Cam = 11,
		Tint = {TintColor = rgb(235, 225, 255), Saturation = 0.08, Brightness = -0.02, Contrast = 0.06}},
	{Name = "Storm", Title = "THUNDERSTORM", Color = rgb(140, 225, 255), Model = "StormCloud", Cam = 52,
		Tint = {TintColor = rgb(205, 220, 245), Saturation = -0.3, Brightness = -0.08, Contrast = 0.08}},
	{Name = "Ufo", Title = "UFO INVASION", Color = rgb(140, 255, 140), Model = "Ufo", Cam = 46,
		Tint = {TintColor = rgb(225, 255, 225), Saturation = 0.05, Brightness = 0, Contrast = 0.04}},
	{Name = "Candy", Title = "CANDY RAIN", Color = rgb(255, 150, 215), Model = "CandyCloud", Cam = 50,
		Tint = {TintColor = rgb(255, 235, 248), Saturation = 0.15, Brightness = 0.02, Contrast = 0.03}},
	{Name = "BloodMoon", Title = "BLOOD MOON", Color = rgb(255, 90, 90), Model = "Bat", Cam = 11,
		Tint = {TintColor = rgb(255, 185, 185), Saturation = -0.15, Brightness = -0.12, Contrast = 0.12}},
	{Name = "Blizzard", Title = "BLIZZARD", Color = rgb(180, 235, 255), Model = "FrostSpirit", Cam = 36,
		Tint = {TintColor = rgb(225, 240, 255), Saturation = -0.3, Brightness = 0.04, Contrast = 0.02}},
	{Name = "Hacker", Title = "HACKER ATTACK", Color = rgb(60, 255, 120), Model = "HackerDrone", Cam = 30,
		Tint = {TintColor = rgb(195, 255, 205), Saturation = -0.35, Brightness = -0.1, Contrast = 0.18}},
}

---------------------------------------------------------------- HUD
local function label(parent, text, pos, size, color, thickness)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Position, l.Size = pos, size
	l.FontFace = FONT
	l.Text = text
	l.TextScaled = true
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.TextColor3 = color
	local s = Instance.new("UIStroke")
	s.Thickness = thickness
	s.Color = Color3.new(0, 0, 0)
	s.Parent = l
	l.Parent = parent
	return l
end

for _, ev in EVENTS do
	local hud = Instance.new("Frame")
	hud.Name = ev.Name .. "Hud"
	hud.BackgroundTransparency = 1
	hud.Size = UDim2.fromOffset(170, 54)
	hud.Visible = false
	hud:GetPropertyChangedSignal("Visible"):Connect(function() -- le dernier event arrivé se place au-dessus des autres
		if hud.Visible then hud.LayoutOrder = -math.floor(os.clock() * 10) end
	end)
	local view = Instance.new("ViewportFrame")
	view.Name = "Icon"
	view.BackgroundTransparency = 1
	view.Size = UDim2.fromOffset(54, 54)
	view.Ambient = rgb(200, 200, 210)
	view.LightColor = rgb(255, 245, 230)
	view.LightDirection = Vector3.new(-0.3, -0.6, 1)
	view.Parent = hud
	local model = models:WaitForChild(ev.Model):Clone()
	model:PivotTo(CFrame.new())
	model.Parent = view
	local cam = Instance.new("Camera")
	cam.FieldOfView = 40
	cam.CFrame = CFrame.lookAt(Vector3.new(0, ev.Cam * 0.35, -ev.Cam), Vector3.zero)
	cam.Parent = view
	view.CurrentCamera = cam
	label(hud, ev.Title, UDim2.fromOffset(58, 5), UDim2.new(1, -58, 0, 15), ev.Color, 2)
	local timer = label(hud, "00:00", UDim2.fromOffset(58, 20), UDim2.new(1, -58, 0, 30), Color3.new(1, 1, 1), 3)
	ev.Hud, ev.Timer, ev.View, ev.IconModel = hud, timer, view, model
	task.spawn(function() hud.Parent = playerGui:WaitForChild("EventStackGui"):WaitForChild("Stack") end)
end

local function clock(seconds)
	seconds = math.max(0, math.ceil(seconds))
	local h, m, s = seconds // 3600, seconds % 3600 // 60, seconds % 60
	return h > 0 and string.format("%d:%02d:%02d", h, m, s) or string.format("%02d:%02d", m, s)
end

---------------------------------------------------------------- ambiance (une ColorCorrection, fondue d'un event à l'autre)
local cc = Instance.new("ColorCorrectionEffect")
cc.Name = "SkyEventTint"
cc.Parent = Lighting
local NEUTRAL = {TintColor = Color3.new(1, 1, 1), Saturation = 0, Brightness = 0, Contrast = 0}
local currentTint
local blizzard = false
local function setTint(tint)
	if tint == currentTint then return end
	currentTint = tint
	TweenService:Create(cc, TweenInfo.new(2.5, Enum.EasingStyle.Sine), tint or NEUTRAL):Play()
end

---------------------------------------------------------------- neige autour de la caméra pendant le Blizzard
local snowPart = Instance.new("Part")
snowPart.Name = "BlizzardSnow"
snowPart.Anchored, snowPart.CanCollide, snowPart.CanQuery, snowPart.CanTouch = true, false, false, false
snowPart.Transparency = 1
snowPart.Size = Vector3.new(120, 1, 120)
local snow = Instance.new("ParticleEmitter")
snow.Texture = "rbxasset://textures/particles/sparkles_main.dds"
snow.Color = ColorSequence.new(Color3.new(1, 1, 1))
snow.LightEmission = 0.3
snow.EmissionDirection = Enum.NormalId.Bottom
snow.Shape = Enum.ParticleEmitterShape.Box
snow.Rate = 0
snow.Lifetime = NumberRange.new(3, 4)
snow.Speed = NumberRange.new(14, 22)
snow.SpreadAngle = Vector2.new(15, 15)
snow.Acceleration = Vector3.new(6, 0, 3)
snow.RotSpeed = NumberRange.new(-90, 90)
snow.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0.35)})
snow.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1, 0.1), NumberSequenceKeypoint.new(0.9, 0.2), NumberSequenceKeypoint.new(1, 1)})
snow.Parent = snowPart
snowPart.Parent = workspace
RunService.RenderStepped:Connect(function()
	if snow.Rate > 0 then snowPart.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position + Vector3.new(0, 45, 0)) end
end)

---------------------------------------------------------------- SONS
-- musiques sous licence de la bibliothèque Roblox (APM Music, Pro Sound Effects...) : utilisables dans tous les jeux
local MUSIC = {
	Meteor = {Id = "rbxassetid://9045936046", Volume = 0.6},                    -- Massive Black Hole (orchestral spatial)
	Storm = {Id = "rbxassetid://1838626031", Volume = 0.5,                      -- Hell Ride (No Choir) : épique, sans chœur ni paroles
		Layer = "rbxassetid://82247046952844", LayerVolume = 0.45,              -- + pluie et tonnerre léger par-dessus
		Sting = "rbxassetid://9120021539"},                                     -- coup de tonnerre au lancement
	Ufo = {Id = "rbxassetid://9040159960", Volume = 0.55},                      -- Alien Invasion (sci-fi inquiétant)
	Candy = {Id = "rbxassetid://1845212471", Volume = 0.55},                    -- Bundles Of Joy (joyeux)
	BloodMoon = {Id = "rbxassetid://1835248722", Volume = 0.6},                 -- Stalking the Prey : percussions sombres et cuivres menaçants
	Blizzard = {Id = "rbxassetid://9045935780", Volume = 0.55,                  -- Ice World (spatial glacé)
		Layer = "rbxassetid://112385924701681", LayerVolume = 0.35},            -- + vent qui hurle par-dessus
	Hacker = {Id = "rbxassetid://1841267486", Volume = 0.5},                    -- Glitch Cranker : électro qui grésille
}
local THUNDER = {"rbxassetid://9120021539", "rbxassetid://9120021794"}

local sounds = {} -- [event] = {Music, Layer}
local function soundsFor(name)
	if sounds[name] then return sounds[name] end
	local cfg = MUSIC[name]
	local function make(id, suffix)
		local snd = Instance.new("Sound")
		snd.Name = "SkyEvent" .. suffix .. "_" .. name
		snd.SoundId = id
		snd.Looped = true
		snd.Volume = 0
		snd.Parent = SoundService -- (SettingsHandler la range dans le groupe "Music" : le curseur Music la règle)
		return snd
	end
	sounds[name] = {Music = make(cfg.Id, "Music"), Layer = cfg.Layer and make(cfg.Layer, "Layer") or nil}
	return sounds[name]
end

local function fade(snd, volume, time, stopAfter)
	if not snd then return end
	local tw = TweenService:Create(snd, TweenInfo.new(time, Enum.EasingStyle.Sine), {Volume = volume})
	if stopAfter then tw.Completed:Once(function(state) if state == Enum.PlaybackState.Completed and snd.Volume <= 0.001 then snd:Stop() end end) end
	tw:Play()
end

local function oneShot(id, volume, parent)
	local snd = Instance.new("Sound")
	snd.SoundId = id
	snd.Volume = volume
	snd.PlaybackSpeed = 0.9 + math.random() * 0.2
	snd.RollOffMinDistance, snd.RollOffMaxDistance = 80, 900
	snd.Parent = parent or SoundService
	snd:Play()
	Debris:AddItem(snd, 20)
	return snd
end

local playing -- event dont la musique joue
local pausedDays = false -- c'est nous qui avons mis "Days" en pause
local activeSince = {}

local function updateSound(active)
	-- le PREMIER event lancé garde la musique jusqu'à ce qu'il finisse ; le suivant prend le relais ensuite.
	-- On se fie à l'heure de début donnée par le serveur (un joueur qui arrive en cours d'event voit le même ordre).
	local newest, newestAt
	for name in active do
		if not activeSince[name] then
			activeSince[name] = ReplicatedStorage:GetAttribute(name .. "EventStart") or workspace:GetServerTimeNow()
			local cfg = MUSIC[name]
			if cfg and cfg.Sting then oneShot(cfg.Sting, 1) end -- son de lancement
		end
		if not newestAt or activeSince[name] < newestAt then newest, newestAt = name, activeSince[name] end
	end
	for name in activeSince do if not active[name] then activeSince[name] = nil end end

	if newest ~= playing then
		if playing then
			local old = sounds[playing]
			fade(old.Music, 0, 1.5, true)
			fade(old.Layer, 0, 1.5, true)
		end
		playing = newest
		if newest and MUSIC[newest] then
			local cfg, snd = MUSIC[newest], soundsFor(newest)
			snd.Music.TimePosition = 0
			snd.Music:Play()
			fade(snd.Music, cfg.Volume, 2)
			if snd.Layer then
				snd.Layer:Play()
				fade(snd.Layer, cfg.LayerVolume or 0.3, 2)
			end
		end
	end

	-- musique de fond "Days" : en pause pendant les events, reprend après
	local days = SoundService:FindFirstChild("Days")
	if newest then
		if days and days.IsPlaying then
			days:Pause()
			pausedDays = true
		end
	elseif pausedDays then
		pausedDays = false
		if days and days.Parent and not days.IsPlaying then days:Resume() end
	end
end

-- tonnerre à chaque éclair de l'orage (son 3D, là où l'éclair tombe)
task.spawn(function()
	local fx = workspace:WaitForChild("SkyEventFx", math.huge)
	fx.ChildAdded:Connect(function(child)
		if child.Name ~= "Bolt" then return end
		task.defer(function()
			local lowest
			for _, p in child:GetChildren() do
				if p:IsA("BasePart") and (not lowest or p.Position.Y < lowest.Y) then lowest = p.Position end
			end
			if not lowest then return end
			local at = Instance.new("Attachment")
			at.WorldPosition = lowest
			at.Parent = workspace.Terrain
			oneShot(THUNDER[math.random(#THUNDER)], 1.2, at)
			Debris:AddItem(at, 20)
		end)
	end)
end)

---------------------------------------------------------------- boucle : timers, ambiance
task.spawn(function()
	while true do
		local tint
		local active = {}
		blizzard = false
		for _, ev in EVENTS do
			local endAt = ReplicatedStorage:GetAttribute(ev.Name .. "EventEnd")
			local left = type(endAt) == "number" and endAt - workspace:GetServerTimeNow() or 0
			if left > 0 then
				ev.Timer.Text = clock(left)
				ev.Hud.Visible = true
				tint = tint or ev.Tint
				if ev.Name == "Blizzard" then blizzard = true end
				active[ev.Name] = true
			else
				ev.Hud.Visible = false
			end
		end
		setTint(tint)
		snow.Rate = blizzard and 260 or 0
		updateSound(active)
		task.wait(0.2)
	end
end)

---------------------------------------------------------------- chaque image : icônes qui tournent, éclairs dans les nuages, lumières de la soucoupe
local rng = Random.new()
local nextFlash = 0
RunService.RenderStepped:Connect(function()
	local t = os.clock()
	for _, ev in EVENTS do
		if ev.Hud.Visible and ev.IconModel then ev.IconModel:PivotTo(CFrame.Angles(0, t * 0.9, 0)) end
	end
	local fx = workspace:FindFirstChild("SkyEventFx")
	if not fx then return end
	-- nuages d'orage : de temps en temps une lueur passe dans un nuage
	local storm = fx:FindFirstChild("Storm")
	if storm and t >= nextFlash then
		nextFlash = t + rng:NextNumber(0.15, 0.5)
		for _, cloud in storm:GetChildren() do
			for _, p in cloud:GetChildren() do
				if p.Name == "Flash" and p:IsA("BasePart") then
					local on = rng:NextNumber() < 0.12
					p.Transparency = on and rng:NextNumber(0.2, 0.6) or 1
					local light = p:FindFirstChildOfClass("PointLight")
					if light then light.Brightness = on and rng:NextNumber(2, 5) or 0 end -- l'éclair illumine le ventre du nuage
				end
			end
		end
	end
	-- soucoupe : les lumières du bord s'allument en vague, en vert et en jaune
	local ufo = fx:FindFirstChild("Ufo")
	if ufo then
		for _, saucer in ufo:GetChildren() do
			if saucer:IsA("Model") then
				for _, p in saucer:GetChildren() do
					if p.Name == "RimLight" then
						local k = (math.sin(t * 8 - (p:GetAttribute("Index") or 0) * 0.8) + 1) / 2
						p.Color = rgb(110, 255, 130):Lerp(rgb(255, 235, 110), k)
						p.Transparency = 0.6 - k * 0.6
					end
				end
			end
		end
	end
end)

---------------------------------------------------------------- orage : le ciel flashe à chaque éclair (attribut LightningAt posé par SkyEventsServer)
-- Purement visuel : un ColorCorrection local qui s'éclaircit deux fois très vite puis revient à la normale.
do
	local Lighting = game:GetService("Lighting")
	local TweenService = game:GetService("TweenService")
	local flashFx = Instance.new("ColorCorrectionEffect")
	flashFx.Name = "StormFlash"
	flashFx.Brightness, flashFx.Contrast, flashFx.TintColor = 0, 0, Color3.fromRGB(225, 240, 255)
	flashFx.Parent = Lighting
	local token = 0
	ReplicatedStorage:GetAttributeChangedSignal("LightningAt"):Connect(function()
		token += 1
		local mine = token
		flashFx.Brightness, flashFx.Contrast = 0.32, 0.15
		task.wait(0.06)
		if mine ~= token then return end
		flashFx.Brightness = 0.05
		task.wait(0.05)
		if mine ~= token then return end
		flashFx.Brightness = 0.22
		TweenService:Create(flashFx, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Brightness = 0, Contrast = 0}):Play()
	end)
end

-- Pile des events en bas à droite : le premier event est tout en bas, les suivants se posent juste au-dessus.
-- Contient : la nuit (toujours là), la chance du serveur, et le HUD de la sorcière (ajouté par WitchEventClient).
-- Gère aussi le fondu noir quand la nuit tombe.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local gui = script.Parent
local stack = gui:WaitForChild("Stack")
local HEAVY = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)

local function clock(seconds)
	seconds = math.max(0, math.ceil(seconds))
	local h, m, s = seconds // 3600, seconds % 3600 // 60, seconds % 60
	return h > 0 and string.format("%d:%02d:%02d", h, m, s) or string.format("%02d:%02d", m, s)
end

local function entry(name, emoji, color)
	local frame = Instance.new("Frame")
	frame.Name = name
	frame.BackgroundTransparency = 1
	frame.Size = UDim2.fromOffset(150, 54)
	frame.Visible = false
	local function text(str, position, size, textColor, thickness)
		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.Position, label.Size = position, size
		label.FontFace = HEAVY
		label.Text = str
		label.TextScaled = true
		label.TextColor3 = textColor
		label.TextXAlignment = Enum.TextXAlignment.Left
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = thickness
		stroke.Color = Color3.new(0, 0, 0)
		stroke.Parent = label
		label.Parent = frame
		return label
	end
	local icon = text(emoji, UDim2.fromOffset(0, 3), UDim2.fromOffset(48, 48), Color3.new(1, 1, 1), 2.5)
	icon.TextXAlignment = Enum.TextXAlignment.Center
	local title = text(string.upper(name), UDim2.fromOffset(54, 5), UDim2.new(1, -54, 0, 15), color, 2)
	local timer = text("00:00", UDim2.fromOffset(54, 20), UDim2.new(1, -54, 0, 30), Color3.new(1, 1, 1), 3)
	frame:GetPropertyChangedSignal("Visible"):Connect(function()
		if frame.Visible then frame.LayoutOrder = -math.floor(os.clock() * 10) end
	end)
	frame.Parent = stack
	return frame, title, timer, icon
end

local luck, luckTitle, luckTimer = entry("Luck", "🍀", Color3.fromRGB(150, 255, 130))
local huge, hugeTitle, hugeTimer = entry("Huge Egg", "🥚", Color3.fromRGB(255, 210, 80))
-- events vitesse (SpeedEventServer) : 2X / 4X SPEED sur le tapis
-- icône : un bonhomme bleu (en blocs, dans une ViewportFrame) qui court, avec "x2" / "x4" écrit au-dessus
local RunService = game:GetService("RunService")
local runners = {} -- {frame, parts, mult}
local function runnerIcon(icon, mult, color)
	icon.Text = ""
	local view = Instance.new("ViewportFrame")
	view.Name = "Runner"
	view.BackgroundTransparency = 1
	view.Position = UDim2.fromOffset(2, 10)
	view.Size = UDim2.fromOffset(46, 44)
	view.Ambient = Color3.fromRGB(170, 180, 210)
	view.LightColor = Color3.fromRGB(255, 255, 255)
	view.LightDirection = Vector3.new(-1, -0.6, -0.4)
	view.Parent = icon
	local BLUE, DARK, SKIN = Color3.fromRGB(40, 130, 255), Color3.fromRGB(20, 60, 170), Color3.fromRGB(120, 200, 255)
	local function part(size, col)
		local p = Instance.new("Part")
		p.Anchored, p.CanCollide = true, false
		p.Size, p.Color = size, col
		p.Material = Enum.Material.SmoothPlastic
		p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		p.Parent = view
		return p
	end
	local parts = {
		Head = part(Vector3.new(1.2, 1.2, 1.2), SKIN),
		Torso = part(Vector3.new(2, 2, 1), BLUE),
		LArm = part(Vector3.new(0.8, 2, 0.8), BLUE), RArm = part(Vector3.new(0.8, 2, 0.8), DARK),
		LLeg = part(Vector3.new(0.9, 2, 0.9), DARK), RLeg = part(Vector3.new(0.9, 2, 0.9), BLUE),
	}
	local cam = Instance.new("Camera")
	cam.FieldOfView = 40
	cam.CFrame = CFrame.lookAt(Vector3.new(11, 0.6, 0), Vector3.new(0, 0, 0)) -- de profil
	cam.Parent = view
	view.CurrentCamera = cam
	-- "x2" / "x4" au-dessus du bonhomme
	local tag = Instance.new("TextLabel")
	tag.Name = "Mult"
	tag.BackgroundTransparency = 1
	tag.Position, tag.Size = UDim2.fromOffset(0, -6), UDim2.fromOffset(48, 18)
	tag.FontFace = HEAVY
	tag.Text = "x" .. mult
	tag.TextScaled = true
	tag.TextColor3 = color
	tag.ZIndex = 3
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2.5
	stroke.Parent = tag
	tag.Parent = icon
	return parts
end

local speedEntries = {}
for _, mult in {2, 4} do
	local color = mult == 2 and Color3.fromRGB(255, 220, 90) or Color3.fromRGB(255, 120, 70)
	local frame, title, timer, icon = entry(mult .. "X Speed", "", color)
	title.Text = mult .. "X SPEED"
	speedEntries[mult] = {frame, timer}
	table.insert(runners, {frame, runnerIcon(icon, mult, color), mult})
end

-- animation de course (seulement quand l'icône est affichée) ; le x4 court plus vite que le x2
RunService.RenderStepped:Connect(function()
	local t = os.clock()
	for _, r in runners do
		if r[1].Visible then
			local p, speed = r[2], r[3] == 4 and 18 or 11
			local s = math.sin(t * speed)
			local bob = math.abs(math.cos(t * speed)) * 0.35
			local body = CFrame.new(0, bob, 0) * CFrame.Angles(math.rad(-15), 0, 0) -- penché vers l'avant
			p.Torso.CFrame = body
			p.Head.CFrame = body * CFrame.new(0, 1.65, 0)
			local function limb(part, joint, angle) part.CFrame = body * joint * CFrame.Angles(angle, 0, 0) * CFrame.new(0, -0.9, 0) end
			limb(p.LArm, CFrame.new(-1.4, 0.9, 0), s * 1.1)
			limb(p.RArm, CFrame.new(1.4, 0.9, 0), -s * 1.1)
			limb(p.LLeg, CFrame.new(-0.5, -1, 0), -s * 1.0)
			limb(p.RLeg, CFrame.new(0.5, -1, 0), s * 1.0)
		end
	end
end)

-- musique des events vitesse (la même pour 2X et 4X) : "Action Route" (APM Music, album Speed Fever, bibliothèque Roblox)
-- Si un event du ciel joue déjà sa musique (SkyEventsClient), on ne la superpose pas. "Days" est mise en pause pendant l'event.
local SoundService = game:GetService("SoundService")
local SPEED_MUSIC_ID, SPEED_MUSIC_VOLUME = "rbxassetid://9042431845", 0.55
local SKY = {"Meteor", "Storm", "Ufo", "Candy", "BloodMoon", "Blizzard", "Hacker"}
local speedMusic = SoundService:FindFirstChild("SpeedEventMusic") or Instance.new("Sound") -- (réutilisé si l'écran est recréé)
speedMusic.Name = "SpeedEventMusic"
speedMusic.SoundId = SPEED_MUSIC_ID
speedMusic.Looped = true
speedMusic.Volume = 0
speedMusic.Parent = SoundService
local speedMusicOn, pausedDays = false, false
local function setSpeedMusic(on)
	local now = workspace:GetServerTimeNow()
	local skyPlaying = false
	for _, name in SKY do
		local e = ReplicatedStorage:GetAttribute(name .. "EventEnd")
		if type(e) == "number" and e > now then skyPlaying = true break end
	end
	on = on and not skyPlaying
	local days = SoundService:FindFirstChild("Days")
	if on then
		if days and days.IsPlaying then days:Pause() pausedDays = true end
	elseif pausedDays then
		pausedDays = false
		if days and days.Parent and not days.IsPlaying and not skyPlaying then days:Resume() end
	end
	if on == speedMusicOn then return end
	speedMusicOn = on
	if on then
		speedMusic.TimePosition = 0
		speedMusic:Play()
		TweenService:Create(speedMusic, TweenInfo.new(2, Enum.EasingStyle.Sine), {Volume = SPEED_MUSIC_VOLUME}):Play()
	else
		local tw = TweenService:Create(speedMusic, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {Volume = 0})
		tw.Completed:Once(function() if not speedMusicOn then speedMusic:Stop() end end)
		tw:Play()
	end
end
while true do
	local now = workspace:GetServerTimeNow()
	local hugeAt = ReplicatedStorage:GetAttribute("HugeEggAt")
	if type(hugeAt) == "number" then
		hugeTitle.Text, hugeTimer.Text = "HUGE EGG IN", clock(hugeAt - now)
		huge.Visible = true
	end

	local luckEnd, mult = ReplicatedStorage:GetAttribute("LuckEnd"), ReplicatedStorage:GetAttribute("LuckMultiplier")
	if type(luckEnd) == "number" and luckEnd > now and type(mult) == "number" then
		luckTitle.Text, luckTimer.Text = mult .. "X SERVER LUCK", clock(luckEnd - now)
		luck.Visible = true
	else
		luck.Visible = false
	end

	local speedActive = false
	for mult, e in speedEntries do
		local finish = ReplicatedStorage:GetAttribute("SpeedX" .. mult .. "End")
		if type(finish) == "number" and finish > now then
			e[2].Text = clock(finish - now)
			e[1].Visible = true
			speedActive = true
		else
			e[1].Visible = false
		end
	end
	setSpeedMusic(speedActive)
	task.wait(0.2)
end

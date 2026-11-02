-- WitchEventClient : pendant l'event SORCIERE TIME
--  * ambiance "horreur" (ecran sombre, brouillard violet) + banniere au lancement
--  * HUD en bas a droite : image de la sorciere (ViewportFrame) + timer du temps restant
-- Tout est local a chaque joueur. Pilote par les attributs WitchTime / WitchEventEnd de ReplicatedStorage.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local PURPLE = Color3.fromRGB(190, 90, 255)
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)

local DARK = {
	ClockTime = 18.7, -- crepuscule : on voit bien les zones et la sorciere
	Brightness = 1.8,
	Ambient = Color3.fromRGB(105, 80, 135),
	OutdoorAmbient = Color3.fromRGB(125, 95, 155),
	FogColor = Color3.fromRGB(70, 40, 105),
	FogStart = 300,
	FogEnd = 3000,
	ExposureCompensation = 0,
}
local DARK_CC = {TintColor = Color3.fromRGB(225, 205, 250), Saturation = -0.05, Contrast = 0.05}

local gui = Instance.new("ScreenGui")
gui.Name = "WitchEventGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 20
gui.IgnoreGuiInset = true
gui.Parent = playerGui

------------------------------------------------------------------ BANNIERE
local function makeLabel(parent, text, size, pos, textSize, color)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.AnchorPoint = Vector2.new(0.5, 0)
	l.Position, l.Size = pos, size
	l.FontFace = FONT
	l.Text = text
	l.TextSize = textSize
	l.TextColor3 = color or PURPLE
	l.TextTransparency = 1
	local s = Instance.new("UIStroke")
	s.Thickness = 3
	s.Color = Color3.new(0, 0, 0)
	s.Transparency = 1
	s.Parent = l
	l.Parent = parent
	return l, s
end
local banner, bannerStroke = makeLabel(gui, "WITCH TIME", UDim2.new(0.8, 0, 0, 80), UDim2.fromScale(0.5, 0.14), 72)
local sub, subStroke = makeLabel(gui, "The witch is flying over the zones... she can give eggs a trait!", UDim2.new(0.8, 0, 0, 40), UDim2.new(0.5, 0, 0.14, 84), 26, Color3.fromRGB(230, 220, 255))

local function fade(label, stroke, to, t)
	TweenService:Create(label, TweenInfo.new(t), {TextTransparency = to}):Play()
	TweenService:Create(stroke, TweenInfo.new(t), {Transparency = to}):Play()
end

------------------------------------------------------------------ HUD (petit, sans fond) : tête de sorcière + temps restant
local HUD_SHOWN = UDim2.new(1, -16, 1, -96)
local HUD_HIDDEN = UDim2.new(1, 220, 1, -96)

local hud = Instance.new("Frame")
hud.Name = "WitchHud"
hud.AnchorPoint = Vector2.new(1, 1)
hud.Size = UDim2.new(0, 150, 0, 54)
hud.Position = HUD_HIDDEN
hud.BackgroundTransparency = 1
hud.Visible = false
hud:GetPropertyChangedSignal("Visible"):Connect(function() -- le dernier event arrivé se place au-dessus des autres
	if hud.Visible then hud.LayoutOrder = -math.floor(os.clock() * 10) end
end)
task.spawn(function() hud.Parent = playerGui:WaitForChild("EventStackGui"):WaitForChild("Stack") end)

-- tête de sorcière en dessin (formes simples, contours noirs)
local function witchHead(parent)
	local holder = Instance.new("Frame")
	holder.Name = "WitchIcon"
	holder.BackgroundTransparency = 1
	holder.Size = UDim2.fromOffset(54, 54)
	holder.Parent = parent
	local function shape(pos, size, color, round, rotation, z)
		local f = Instance.new("Frame")
		f.BorderSizePixel = 0
		f.BackgroundColor3 = color
		f.Position, f.Size = UDim2.fromScale(pos[1], pos[2]), UDim2.fromScale(size[1], size[2])
		f.Rotation = rotation or 0
		f.ZIndex = z or 2
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(round or 0, 0)
		corner.Parent = f
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 1.5
		stroke.Color = Color3.new(0, 0, 0)
		stroke.Parent = f
		f.Parent = holder
		return f
	end
	local HAT, HAT_DARK, SKIN, HAIR, GOLD = Color3.fromRGB(140, 70, 220), Color3.fromRGB(96, 44, 170), Color3.fromRGB(140, 215, 100), Color3.fromRGB(60, 30, 90), Color3.fromRGB(255, 205, 60)
	shape({0.16, 0.46}, {0.68, 0.5}, HAIR, 0.3, 0, 1)                      -- cheveux
	shape({0.26, 0.44}, {0.48, 0.5}, SKIN, 0.5, 0, 2)                      -- visage
	shape({0.52, 0.02}, {0.12, 0.14}, HAT_DARK, 0.4, 28, 3)                -- pointe du chapeau, penchée
	shape({0.42, 0.08}, {0.2, 0.16}, HAT, 0.2, 14, 3)
	shape({0.34, 0.18}, {0.32, 0.18}, HAT, 0.15, 6, 3)
	shape({0.28, 0.28}, {0.44, 0.16}, HAT, 0.1, 0, 3)
	shape({0.28, 0.37}, {0.44, 0.06}, GOLD, 0, 0, 4)                       -- ruban
	shape({0.44, 0.355}, {0.12, 0.09}, Color3.fromRGB(255, 240, 150), 0.2, 0, 5) -- boucle
	shape({0.06, 0.42}, {0.88, 0.1}, HAT_DARK, 0.5, 0, 4)                  -- bord du chapeau
	for _, x in {0.34, 0.54} do                                             -- yeux
		shape({x, 0.58}, {0.13, 0.15}, Color3.new(1, 1, 1), 0.5, 0, 5)
		shape({x + 0.045, 0.62}, {0.055, 0.08}, Color3.new(0, 0, 0), 0.5, 0, 6)
	end
	shape({0.46, 0.7}, {0.09, 0.12}, Color3.fromRGB(110, 180, 80), 0.4, 0, 5)  -- nez
	shape({0.38, 0.84}, {0.25, 0.05}, Color3.fromRGB(60, 20, 40), 0.5, 0, 5)   -- sourire
	shape({0.47, 0.84}, {0.05, 0.05}, Color3.new(1, 1, 1), 0.2, 0, 6)          -- dent
	return holder
end
local icon = witchHead(hud)

local function hudLabel(text, pos, size, color, thickness)
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
	l.Parent = hud
	return l
end
hudLabel("WITCH TIME", UDim2.new(0, 60, 0, 4), UDim2.new(0, 90, 0, 14), PURPLE, 2)
local timerLabel = hudLabel("00:00", UDim2.new(0, 60, 0, 18), UDim2.new(0, 90, 0, 32), Color3.fromRGB(255, 255, 255), 3)

-- la tête se balance doucement
game:GetService("RunService").RenderStepped:Connect(function()
	if hud.Visible then icon.Rotation = math.sin(os.clock() * 2.5) * 7 end
	-- orbes des œufs ensorcelés : elles tournent autour de leur œuf
	local t = os.clock()
	for _, orb in game:GetService("CollectionService"):GetTagged("WitchOrb") do
		local center, radius = orb:GetAttribute("Center"), orb:GetAttribute("Radius")
		if center and radius then
			local angle = t * (orb:GetAttribute("Speed") or 2) + (orb:GetAttribute("Phase") or 0)
			local lift = (orb:GetAttribute("Lift") or 0) + math.sin(t * 2 + angle) * radius * 0.12
			orb.CFrame = CFrame.new(center + Vector3.new(math.cos(angle) * radius, lift, math.sin(angle) * radius)) * CFrame.Angles(t * 3, t * 2, 0)
		end
	end
end)

local function formatTime(s)
	s = math.max(0, math.ceil(s))
	local h, m, sec = s // 3600, (s % 3600) // 60, s % 60
	if h > 0 then return string.format("%d:%02d:%02d", h, m, sec) end
	return string.format("%02d:%02d", m, sec)
end

------------------------------------------------------------------ SONS : rire de sorcière au lancement + musique "Days" coupée pendant l'event
local SoundService = game:GetService("SoundService")
local laughTemplate = ReplicatedStorage:WaitForChild("WitchLaugh", 10)
local musicVolume -- volume normal de la musique, remis à la fin de l'event
local musicFading = false

local function dayMusic() return SoundService:FindFirstChild("Days") end

local function playLaugh()
	if not laughTemplate then return end
	local laugh = laughTemplate:Clone()
	laugh.Parent = SoundService
	laugh:Play()
	laugh.Ended:Once(function() laugh:Destroy() end)
	game:GetService("Debris"):AddItem(laugh, 15)
end

local function stopMusic()
	local music = dayMusic()
	if not music then return end
	musicVolume = musicVolume or music.Volume
	musicFading = true
	local tween = TweenService:Create(music, TweenInfo.new(1.5), {Volume = 0})
	tween:Play()
	tween.Completed:Once(function()
		musicFading = false
		if ReplicatedStorage:GetAttribute("WitchTime") == true then music:Pause() end
	end)
end

local function resumeMusic()
	local music = dayMusic()
	if not music then return end
	musicFading = false
	music.Volume = 0
	if not music.IsPlaying then music:Resume() end
	TweenService:Create(music, TweenInfo.new(3), {Volume = musicVolume or 0.5}):Play()
end

------------------------------------------------------------------ AMBIANCE + HUD
local original, originalCC
local active = false
local ready = false -- false pendant la mise en place : un joueur qui arrive en plein event n'entend pas le rire

local function cc()
	return Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
end

local function setActive(on)
	if on == active then return end
	active = on
	if on then
		if ready then playLaugh() end
		stopMusic()
		original = {}
		for prop in DARK do original[prop] = Lighting[prop] end
		local c = cc()
		originalCC = c and {TintColor = c.TintColor, Saturation = c.Saturation, Contrast = c.Contrast}
		TweenService:Create(Lighting, TweenInfo.new(5), DARK):Play()
		if c then TweenService:Create(c, TweenInfo.new(5), DARK_CC):Play() end

		hud.Visible = true
		TweenService:Create(hud, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = HUD_SHOWN}):Play()
		task.spawn(function()
			while active do
				local endAt = ReplicatedStorage:GetAttribute("WitchEventEnd")
				if endAt then timerLabel.Text = formatTime(endAt - workspace:GetServerTimeNow()) end
				-- la musique reste coupée (même si elle démarre après, quand on rejoint en plein event)
				local music = dayMusic()
				if music and music.IsPlaying and not musicFading then
					musicVolume = musicVolume or music.Volume
					music.Volume = 0
					music:Pause()
				end
				task.wait(0.2)
			end
		end)
		task.spawn(function()
			fade(banner, bannerStroke, 0, 0.6)
			fade(sub, subStroke, 0, 0.6)
			task.wait(5)
			fade(banner, bannerStroke, 1, 1)
			fade(sub, subStroke, 1, 1)
		end)
	else
		resumeMusic()
		local slide = TweenService:Create(hud, TweenInfo.new(0.5), {Position = HUD_HIDDEN})
		slide:Play()
		slide.Completed:Once(function() if not active then hud.Visible = false end end)
		if original then
			TweenService:Create(Lighting, TweenInfo.new(4), table.clone(original)):Play()
		end
		local c = cc()
		if c and originalCC then TweenService:Create(c, TweenInfo.new(4), originalCC):Play() end
	end
end

ReplicatedStorage:GetAttributeChangedSignal("WitchTime"):Connect(function()
	setActive(ReplicatedStorage:GetAttribute("WitchTime") == true)
end)
setActive(ReplicatedStorage:GetAttribute("WitchTime") == true)
ready = true

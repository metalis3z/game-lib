-- HackerEventClient : le style « hacker » pendant l'event HACKER ATTACK (SkyEventsServer, attribut HackerEventEnd)
--   * intro plein écran : lignes de terminal tapées, puis « SYSTEM HACKED » qui bug (décalage rouge / cyan)
--   * pendant l'event : lignes de balayage vertes, bords d'écran verts, petits bugs d'écran au hasard
--   * pluie de code vert (0 et 1) qui tombe autour de la caméra, dans le monde
--   * le panneau « </> » des œufs et animaux HACKED clignote et change de symbole (tag HackHolo, TraitDeco)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")

local player = Players.LocalPlayer
local rgb = Color3.fromRGB
local GREEN = rgb(40, 255, 110)
local DIM = rgb(0, 120, 45)
local rng = Random.new()

local function active()
	local endAt = ReplicatedStorage:GetAttribute("HackerEventEnd")
	return type(endAt) == "number" and endAt > workspace:GetServerTimeNow()
end

---------------------------------------------------------------- écran
local gui = Instance.new("ScreenGui")
gui.Name = "HackerEventGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 4
gui.Enabled = false
gui.Parent = player:WaitForChild("PlayerGui")

-- lignes de balayage (scanlines) très légères
local scan = Instance.new("Frame")
scan.Name = "Scanlines"
scan.BackgroundTransparency = 1
scan.Size = UDim2.fromScale(1, 1)
scan.Parent = gui
for i = 0, 59 do
	local l = Instance.new("Frame")
	l.BorderSizePixel = 0
	l.BackgroundColor3 = GREEN
	l.BackgroundTransparency = 0.96
	l.Position = UDim2.fromScale(0, i / 60)
	l.Size = UDim2.new(1, 0, 0, 2)
	l.Parent = scan
end
-- grosse ligne de balayage qui descend
local sweep = Instance.new("Frame")
sweep.BorderSizePixel = 0
sweep.BackgroundColor3 = GREEN
sweep.BackgroundTransparency = 0.9
sweep.Size = UDim2.new(1, 0, 0.06, 0)
sweep.Parent = gui
local sweepGrad = Instance.new("UIGradient")
sweepGrad.Rotation = 90
sweepGrad.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.8, 0.3), NumberSequenceKeypoint.new(1, 1)})
sweepGrad.Parent = sweep
-- bords d'écran verts
local edges = {}
for _, e in {{UDim2.new(1, 0, 0.12, 0), UDim2.fromScale(0, 0), 90}, {UDim2.new(1, 0, 0.12, 0), UDim2.fromScale(0, 0.88), -90}, {UDim2.new(0.08, 0, 1, 0), UDim2.fromScale(0, 0), 0}, {UDim2.new(0.08, 0, 1, 0), UDim2.fromScale(0.92, 0), 180}} do
	local f = Instance.new("Frame")
	f.BorderSizePixel = 0
	f.BackgroundColor3 = GREEN
	f.Size, f.Position = e[1], e[2]
	local g = Instance.new("UIGradient")
	g.Rotation = e[3]
	g.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(1, 1)})
	g.Parent = f
	f.Parent = gui
	table.insert(edges, f)
end
-- bandes de bug (glitch)
local glitchBars = {}
for i = 1, 6 do
	local b = Instance.new("Frame")
	b.BorderSizePixel = 0
	b.Visible = false
	b.Parent = gui
	table.insert(glitchBars, b)
end

---------------------------------------------------------------- intro « SYSTEM HACKED »
local intro = Instance.new("ScreenGui")
intro.Name = "HackerIntro"
intro.ResetOnSpawn = false
intro.IgnoreGuiInset = true
intro.DisplayOrder = 80
intro.Enabled = false
intro.Parent = gui.Parent
local black = Instance.new("Frame")
black.BorderSizePixel = 0
black.BackgroundColor3 = rgb(0, 6, 2)
black.Size = UDim2.fromScale(1, 1)
black.Parent = intro
local terminal = Instance.new("TextLabel")
terminal.BackgroundTransparency = 1
terminal.Position = UDim2.fromScale(0.06, 0.08)
terminal.Size = UDim2.fromScale(0.88, 0.5)
terminal.Font = Enum.Font.Code
terminal.TextSize = 22
terminal.TextXAlignment = Enum.TextXAlignment.Left
terminal.TextYAlignment = Enum.TextYAlignment.Top
terminal.TextColor3 = GREEN
terminal.Text = ""
terminal.Parent = black
local bigLayers = {}
for i, color in {rgb(255, 40, 80), rgb(40, 220, 255), GREEN} do -- rouge / cyan décalés, vert par-dessus
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.AnchorPoint = Vector2.new(0.5, 0.5)
	l.Position = UDim2.fromScale(0.5, 0.55)
	l.Size = UDim2.fromScale(0.8, 0.16)
	l.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	l.Text = "SYSTEM HACKED"
	l.TextScaled = true
	l.TextColor3 = color
	l.TextTransparency = i < 3 and 0.35 or 0
	l.ZIndex = i + 1
	l.Visible = false
	if i == 3 then
		local s = Instance.new("UIStroke")
		s.Thickness = 4
		s.Color = rgb(0, 30, 10)
		s.Parent = l
	end
	l.Parent = black
	bigLayers[i] = l
end
local sub = Instance.new("TextLabel")
sub.BackgroundTransparency = 1
sub.AnchorPoint = Vector2.new(0.5, 0)
sub.Position = UDim2.fromScale(0.5, 0.65)
sub.Size = UDim2.fromScale(0.7, 0.05)
sub.Font = Enum.Font.Code
sub.TextScaled = true
sub.TextColor3 = rgb(200, 255, 215)
sub.Text = "each zone: 50% chance that 3 eggs get HACKED x5"
sub.Visible = false
sub.Parent = black

local LINES = {
	"> connecting to egg_server.exe ...",
	"> bypassing firewall ........ OK",
	"> injecting virus.lua ....... OK",
	"> downloading eggs[*] ....... 100%",
	"> ACCESS GRANTED",
}
local playingIntro = false
local function playIntro()
	if playingIntro then return end
	playingIntro = true
	intro.Enabled = true
	black.BackgroundTransparency = 0.05
	terminal.Text = ""
	terminal.TextTransparency = 0
	for _, l in bigLayers do l.Visible = false end
	sub.Visible = false
	-- lignes tapées
	local text = ""
	for _, line in LINES do
		for c = 1, #line do
			terminal.Text = text .. line:sub(1, c) .. "_"
			if c % 3 == 0 then task.wait() end
		end
		text ..= line .. "\n"
		terminal.Text = text
		task.wait(0.12)
	end
	-- SYSTEM HACKED qui bug
	for _, l in bigLayers do l.Visible = true end
	sub.Visible = true
	local t0 = os.clock()
	while os.clock() - t0 < 2.2 do
		local k = os.clock() - t0
		local amp = k < 0.4 and 14 or (rng:NextNumber() < 0.15 and 18 or 3)
		bigLayers[1].Position = UDim2.new(0.5, -amp + rng:NextInteger(-2, 2), 0.55, rng:NextInteger(-2, 2))
		bigLayers[2].Position = UDim2.new(0.5, amp + rng:NextInteger(-2, 2), 0.55, rng:NextInteger(-2, 2))
		bigLayers[3].Position = UDim2.new(0.5, rng:NextNumber() < 0.08 and rng:NextInteger(-12, 12) or 0, 0.55, 0)
		bigLayers[3].Text = rng:NextNumber() < 0.07 and "SYST3M H4CK3D" or "SYSTEM HACKED"
		task.wait(0.04)
	end
	-- fondu
	local info = TweenInfo.new(0.5)
	TweenService:Create(black, info, {BackgroundTransparency = 1}):Play()
	TweenService:Create(terminal, info, {TextTransparency = 1}):Play()
	for _, l in bigLayers do TweenService:Create(l, info, {TextTransparency = 1}):Play() end
	TweenService:Create(sub, info, {TextTransparency = 1}):Play()
	task.wait(0.55)
	intro.Enabled = false
	for i, l in bigLayers do l.TextTransparency = i < 3 and 0.35 or 0 end
	sub.TextTransparency = 0
	playingIntro = false
end

---------------------------------------------------------------- pluie de code dans le monde
local rainFolder = Instance.new("Folder")
rainFolder.Name = "HackerCodeRain"
local columns = {}
local COLUMN_COUNT = 26
local function randomCode(n)
	local t = {}
	for i = 1, n do t[i] = rng:NextNumber() < 0.5 and "0" or "1" end
	return table.concat(t, "\n")
end
for i = 1, COLUMN_COUNT do
	local p = Instance.new("Part")
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
	p.Transparency = 1
	p.Size = Vector3.one * 0.2
	local bb = Instance.new("BillboardGui")
	bb.Size = UDim2.fromScale(1.6, 18)
	bb.LightInfluence = 0
	bb.MaxDistance = 140
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Size = UDim2.fromScale(1, 1)
	l.Font = Enum.Font.Code
	l.TextScaled = true
	l.TextColor3 = Color3.new(1, 1, 1)
	l.Text = randomCode(12)
	local g = Instance.new("UIGradient") -- tête claire en bas, queue qui s'efface en haut
	g.Rotation = 90
	g.Color = ColorSequence.new(DIM, rgb(200, 255, 215))
	g.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.6, 0.35), NumberSequenceKeypoint.new(1, 0)})
	g.Parent = l
	l.Parent = bb
	bb.Parent = p
	p.Parent = rainFolder
	columns[i] = {Part = p, Label = l, Pos = Vector3.zero, Speed = 0, Alive = false}
end
local function respawn(col, camPos, anywhere)
	local angle = rng:NextNumber(0, math.pi * 2)
	local dist = rng:NextNumber(18, 75)
	local y = anywhere and rng:NextNumber(-10, 45) or rng:NextNumber(35, 55)
	col.Pos = camPos + Vector3.new(math.cos(angle) * dist, y, math.sin(angle) * dist)
	col.Speed = rng:NextNumber(14, 32)
	col.Alive = true
end

---------------------------------------------------------------- boucle
local running = false
local nextGlitch, nextCode, nextHolo = 0, 0, 0
local HOLO = {"</>", "01", "{ }", "#!", "0x5", "</>"}

local function setRunning(on)
	if on == running then return end
	running = on
	gui.Enabled = on
	if on then
		rainFolder.Parent = workspace
		local cam = workspace.CurrentCamera
		for _, col in columns do respawn(col, cam.CFrame.Position, true) end
		task.spawn(playIntro)
	else
		rainFolder.Parent = nil
	end
end

RunService.RenderStepped:Connect(function(dt)
	-- les panneaux </> des œufs et animaux HACKED clignotent (même après l'event)
	local t = os.clock()
	if t >= nextHolo then
		nextHolo = t + 0.12
		for _, label in CollectionService:GetTagged("HackHolo") do
			if rng:NextNumber() < 0.25 then label.Text = HOLO[rng:NextInteger(1, #HOLO)] end
			label.TextTransparency = rng:NextNumber() < 0.12 and 0.7 or 0
		end
	end
	if not running then return end
	local cam = workspace.CurrentCamera
	if not cam then return end
	local camPos = cam.CFrame.Position
	-- pluie de code
	local changeCode = t >= nextCode
	if changeCode then nextCode = t + 0.15 end
	for _, col in columns do
		col.Pos -= Vector3.new(0, col.Speed * dt, 0)
		if col.Pos.Y < camPos.Y - 30 or (Vector3.new(col.Pos.X, 0, col.Pos.Z) - Vector3.new(camPos.X, 0, camPos.Z)).Magnitude > 90 then
			respawn(col, camPos, false)
		end
		col.Part.CFrame = CFrame.new(col.Pos)
		if changeCode and rng:NextNumber() < 0.3 then col.Label.Text = randomCode(12) end
	end
	-- écran : balayage qui descend, bords qui respirent
	sweep.Position = UDim2.fromScale(0, (t * 0.25) % 1.1 - 0.06)
	local breathe = 0.5 + 0.5 * math.sin(t * 2.4)
	for _, f in edges do f.BackgroundTransparency = 0.25 + breathe * 0.35 end
	-- petits bugs d'écran
	if t >= nextGlitch then
		nextGlitch = t + rng:NextNumber(2.5, 7)
		task.spawn(function()
			for _ = 1, rng:NextInteger(2, 4) do
				for _, b in glitchBars do
					b.Visible = rng:NextNumber() < 0.7
					b.BackgroundColor3 = ({GREEN, rgb(255, 40, 80), rgb(40, 220, 255), Color3.new(1, 1, 1)})[rng:NextInteger(1, 4)]
					b.BackgroundTransparency = rng:NextNumber(0.55, 0.85)
					b.Position = UDim2.new(rng:NextNumber(-0.2, 0.3), 0, rng:NextNumber(0, 1), 0)
					b.Size = UDim2.new(rng:NextNumber(0.4, 1.2), 0, 0, rng:NextInteger(3, 26))
				end
				task.wait(0.05)
			end
			for _, b in glitchBars do b.Visible = false end
		end)
	end
end)

task.spawn(function()
	while true do
		setRunning(active())
		task.wait(0.3)
	end
end)

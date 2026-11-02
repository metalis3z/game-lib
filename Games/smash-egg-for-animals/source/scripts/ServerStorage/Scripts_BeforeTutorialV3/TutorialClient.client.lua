-- Tutoriel des nouveaux joueurs (attribut TutorialDone = false, posé par TutorialServer), après la cinématique d'arrivée.
-- Un bandeau en haut de l'écran donne l'étape en cours (avec une barre d'avancement). Dans le monde : des chevrons lumineux
-- qui courent au sol vers la cible, un anneau et une flèche qui rebondit dessus, la cible entourée d'un contour. Pour la
-- dernière étape, une flèche à l'écran montre le bouton des animaux.
-- Chaque étape se valide toute seule quand le joueur a fait ce qui est demandé :
--   1. courir sur son tapis        2. aller dans la première zone        3. casser un œuf au marteau et attraper l'animal
--   4. le ramener dans la safe zone        5. le poser dans son jardin
-- Le bouton X ferme le tutoriel. À la fin (ou au X) le serveur retient que c'est fait (remote TutorialComplete).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local completeRemote = ReplicatedStorage:WaitForChild("TutorialSystem"):WaitForChild("TutorialComplete")

local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local STUDS = "rbxassetid://7447638591"
local rgb = Color3.fromRGB
local WHITE = Color3.new(1, 1, 1)

-- on attend la décision du serveur, puis la fin de la cinématique
local waited = 0
while player:GetAttribute("TutorialDone") == nil and waited < 30 do waited += task.wait(0.25) end
if player:GetAttribute("TutorialDone") ~= false then return end
waited = 0
while player:GetAttribute("IntroState") ~= "done" and player:GetAttribute("IntroState") ~= "none" and waited < 90 do waited += task.wait(0.25) end

---------------------------------------------------------------- ce que le joueur a fait
local function rootPart()
	local character = player.Character
	return character and character:FindFirstChild("HumanoidRootPart")
end
local function myBase()
	local number = player:GetAttribute("BaseNumber")
	local bases = workspace:FindFirstChild("all base")
	return number and bases and bases:FindFirstChild("base " .. number)
end
-- la première zone : {X, Z, Top, SizeX, SizeZ}, publiée par IntroServer (sa pièce n'est pas toujours chargée sur cet écran)
local function firstZone()
	local system = ReplicatedStorage:FindFirstChild("IntroSystem")
	local ok, list = pcall(function() return HttpService:JSONDecode(system:GetAttribute("Zones")) end)
	return ok and list[1] or nil
end
local function inZone(zone, position)
	return zone ~= nil and position ~= nil and math.abs(position.X - zone.X) <= zone.SizeX / 2 and math.abs(position.Z - zone.Z) <= zone.SizeZ / 2
end
local function inside(part, position)
	if not part or not position then return false end
	local rel = part.CFrame:PointToObjectSpace(position)
	return math.abs(rel.X) <= part.Size.X / 2 and math.abs(rel.Z) <= part.Size.Z / 2
end
local function nearestEgg()
	local root, folder = rootPart(), workspace:FindFirstChild("ZoneEggs")
	if not root or not folder then return nil end
	local best, bestDistance
	for _, zone in folder:GetChildren() do
		for _, egg in zone:GetChildren() do
			if egg:IsA("Model") and egg:GetAttribute("MaxHp") then
				local distance = (egg:GetPivot().Position - root.Position).Magnitude
				if not bestDistance or distance < bestDistance then best, bestDistance = egg, distance end
			end
		end
	end
	return best
end
local function carrying() return (player:GetAttribute("Carrying") or 0) > 0 end

local speedAtStart = 0
local STEPS = {
	{
		Text = "Walk onto your TREADMILL: you run by yourself and gain Speed!",
		Enter = function() speedAtStart = player:GetAttribute("Speed") or 0 end,
		Target = function()
			local base = myBase()
			local belt = base and base:FindFirstChild("Treadmill") and base.Treadmill:FindFirstChild("Belt")
			return belt and belt.Position, base and base:FindFirstChild("Treadmill") -- (position, objet à entourer)
		end,
		Done = function() return (player:GetAttribute("Speed") or 0) >= speedAtStart + 15 end,
	},
	{
		Text = "JUMP off the treadmill, then run to the FOREST ZONE!",
		Target = function()
			local zone = firstZone()
			return zone and Vector3.new(zone.X - zone.SizeX / 2 + 24, zone.Top, zone.Z)
		end,
		Done = function()
			local root = rootPart()
			return root ~= nil and inZone(firstZone(), root.Position)
		end,
	},
	{
		Text = function()
			return player:GetAttribute("HammerOut") and "SMASH an egg until it breaks, then GRAB the animal!" or "Take out your HAMMER (slot 1), then smash an egg!"
		end,
		Target = function()
			local egg = nearestEgg()
			return egg and egg:GetPivot().Position, egg
		end,
		Done = carrying,
	},
	{
		Text = "Run back to the SAFE ZONE before the guardian catches you!",
		Target = function()
			local base = myBase()
			return base and base:FindFirstChild("Spawn") and base.Spawn.Position
		end,
		Done = function()
			local root = rootPart()
			return not carrying() and root ~= nil and inside(workspace:FindFirstChild("safe zone"), root.Position)
		end,
		Back = function() return not carrying() end, -- le gardien a repris l'animal : on retourne casser un œuf
	},
	{
		Text = "Press the PAW button on the right, then EQUIP BEST to place your pet!",
		ScreenHint = true, -- une flèche à l'écran montre le bouton
		Target = function()
			local base = myBase()
			return base and base:FindFirstChild("animaux") and base.animaux.Position
		end,
		Done = function() return (player:GetAttribute("Income") or 0) > 0 end,
	},
}

---------------------------------------------------------------- bandeau
local gui = Instance.new("ScreenGui")
gui.Name = "TutorialGui"
gui.DisplayOrder = 30
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false
local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.AnchorPoint = Vector2.new(0.5, 0)
panel.Position = UDim2.new(0.5, 0, 0, 64)
panel.Size = UDim2.new(0.92, 0, 0, 92)
panel.BackgroundColor3 = WHITE
panel.BorderSizePixel = 0
local limit = Instance.new("UISizeConstraint")
limit.MaxSize = Vector2.new(660, 92)
limit.Parent = panel
local fill = Instance.new("UIGradient")
fill.Rotation = 90
fill.Color = ColorSequence.new(rgb(58, 70, 118), rgb(26, 30, 56))
fill.Parent = panel
local outline = Instance.new("UIStroke")
outline.Thickness = 5
outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
outline.Parent = panel
local studs = Instance.new("ImageLabel")
studs.Name = "Studs"
studs.BackgroundTransparency = 1
studs.Size = UDim2.fromScale(1, 1)
studs.Image, studs.ScaleType, studs.TileSize, studs.ImageTransparency = STUDS, Enum.ScaleType.Tile, UDim2.fromOffset(40, 40), 0.86
studs.Parent = panel
local inner = Instance.new("Frame")
inner.Name = "Inner"
inner.BackgroundTransparency = 1
inner.Position, inner.Size = UDim2.fromOffset(6, 6), UDim2.new(1, -12, 1, -12)
local line = Instance.new("UIStroke")
line.Thickness = 3
line.Color, line.Transparency = WHITE, 0.6
line.Parent = inner
inner.Parent = panel
local pop = Instance.new("UIScale")
pop.Parent = panel
local function label(parent, name, position, size, color, thickness)
	local l = Instance.new("TextLabel")
	l.Name = name
	l.BackgroundTransparency = 1
	l.Position, l.Size = position, size
	l.FontFace = FONT
	l.Text = ""
	l.TextScaled = true
	l.TextColor3 = color
	l.ZIndex = 3
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = thickness
	stroke.Parent = l
	l.Parent = parent
	return l
end
-- pastille jaune : numéro de l'étape
local chip = Instance.new("Frame")
chip.Name = "Chip"
chip.Position, chip.Size = UDim2.fromOffset(14, 14), UDim2.fromOffset(64, 64)
chip.BackgroundColor3 = WHITE
chip.BorderSizePixel = 0
chip.ZIndex = 2
local chipFill = Instance.new("UIGradient")
chipFill.Rotation = 90
chipFill.Color = ColorSequence.new(rgb(255, 240, 130), rgb(250, 170, 30))
chipFill.Parent = chip
local chipOutline = Instance.new("UIStroke")
chipOutline.Thickness = 4
chipOutline.Parent = chip
chip.Parent = panel
local number = label(chip, "Number", UDim2.fromScale(0.08, 0.12), UDim2.fromScale(0.84, 0.76), WHITE, 3)
local message = label(panel, "Message", UDim2.new(0, 92, 0, 12), UDim2.new(1, -150, 0, 46), WHITE, 3)
message.TextXAlignment = Enum.TextXAlignment.Left
local distance = label(panel, "Distance", UDim2.new(0, 92, 0, 56), UDim2.new(1, -150, 0, 18), rgb(255, 226, 110), 2.5)
distance.TextXAlignment = Enum.TextXAlignment.Left
-- barre d'avancement, tout en bas du bandeau
local track = Instance.new("Frame")
track.Name = "Progress"
track.Position, track.Size = UDim2.new(0, 92, 1, -16), UDim2.new(1, -150, 0, 8)
track.BackgroundColor3 = rgb(16, 18, 30)
track.BorderSizePixel = 0
track.ZIndex = 3
local trackOutline = Instance.new("UIStroke")
trackOutline.Thickness = 2
trackOutline.Parent = track
local progress = Instance.new("Frame")
progress.Name = "Fill"
progress.Size = UDim2.fromScale(0, 1)
progress.BackgroundColor3 = rgb(120, 240, 90)
progress.BorderSizePixel = 0
progress.ZIndex = 4
progress.Parent = track
track.Parent = panel
-- bouton X : carré, en haut à droite du bandeau
local close = Instance.new("TextButton")
close.Name = "Close"
close.AnchorPoint = Vector2.new(1, 0)
close.Position, close.Size = UDim2.new(1, -12, 0, 12), UDim2.fromOffset(36, 36)
close.BackgroundColor3 = WHITE
close.BorderSizePixel = 0
close.Text = ""
close.AutoButtonColor = false
close.ZIndex = 4
local closeFill = Instance.new("UIGradient")
closeFill.Rotation = 90
closeFill.Color = ColorSequence.new(rgb(255, 150, 130), rgb(214, 40, 44))
closeFill.Parent = close
local closeOutline = Instance.new("UIStroke")
closeOutline.Thickness = 4
closeOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
closeOutline.Parent = close
label(close, "X", UDim2.fromScale(0.14, 0.08), UDim2.fromScale(0.72, 0.8), WHITE, 2.5).Text = "X"
close.Parent = panel
panel.Parent = gui
gui.Parent = playerGui

---------------------------------------------------------------- guidage dans le monde
-- la cible : un anneau carré qui tourne au sol, une flèche qui rebondit au-dessus, un contour sur l'objet à atteindre
local YELLOW, ORANGE = rgb(255, 232, 90), rgb(255, 160, 40)
local guide = Instance.new("Folder")
guide.Name = "TutorialGuide"
guide.Parent = workspace
local function neon(name, size, color)
	local p = Instance.new("Part")
	p.Name = name
	p.Size = size
	p.Color = color
	p.Material = Enum.Material.Neon
	p.Anchored = true
	p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = false, false, false, false
	p.Parent = guide
	return p
end
local targetPart = neon("Target", Vector3.one, YELLOW)
targetPart.Transparency = 1
local ring = {}
for i = 1, 4 do ring[i] = neon("Ring", Vector3.new(7, 0.25, 0.5), ORANGE) end
local arrowGui = Instance.new("BillboardGui")
arrowGui.Name = "TutorialArrow"
arrowGui.Size = UDim2.fromOffset(110, 110)
arrowGui.StudsOffsetWorldSpace = Vector3.new(0, 9, 0)
arrowGui.LightInfluence = 0
arrowGui.MaxDistance = 3000
arrowGui.Parent = targetPart
local arrow = label(arrowGui, "Arrow", UDim2.fromScale(0, 0), UDim2.fromScale(1, 1), YELLOW, 5)
arrow.Text = "▼"
TweenService:Create(arrowGui, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {StudsOffsetWorldSpace = Vector3.new(0, 12.5, 0)}):Play()
local focusOutline = Instance.new("Highlight")
focusOutline.Name = "TutorialOutline"
focusOutline.FillTransparency = 1
focusOutline.OutlineColor = YELLOW
focusOutline.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
focusOutline.Enabled = false
focusOutline.Parent = guide
-- les chevrons : des « V » lumineux posés au sol entre le joueur et la cible, qui avancent vers elle
local CHEVRONS, SPACING = 12, 7
local chevrons = {}
for i = 1, CHEVRONS do
	chevrons[i] = {neon("Chevron", Vector3.new(0.45, 0.14, 2.3), YELLOW), neon("Chevron", Vector3.new(0.45, 0.14, 2.3), YELLOW)}
end
local guideTarget -- position visée, ou nil
local function hideGuide()
	for _, pair in chevrons do pair[1].Transparency, pair[2].Transparency = 1, 1 end
	for _, bar in ring do bar.Transparency = 1 end
	arrowGui.Enabled = false
end
local travel = 0
local guideConnection = RunService.RenderStepped:Connect(function(dt)
	local root = rootPart()
	if not guideTarget or not root then hideGuide() return end
	travel = (travel + dt * 9) % SPACING
	local now = os.clock()
	-- anneau : quatre barres qui tournent autour de la cible, et qui respirent
	local pulse = 1 + 0.12 * math.sin(now * 5)
	for i, bar in ring do
		bar.Transparency = 0.15
		bar.CFrame = CFrame.new(guideTarget + Vector3.new(0, 0.3, 0)) * CFrame.Angles(0, now * 1.2 + i * math.pi / 2, 0) * CFrame.new(0, 0, 3.5 * pulse)
	end
	arrowGui.Enabled = true
	-- chevrons : du joueur vers la cible, à hauteur du sol
	local feet = root.Position - Vector3.new(0, 2.8, 0)
	local flat = Vector3.new(guideTarget.X - feet.X, 0, guideTarget.Z - feet.Z)
	local length = flat.Magnitude
	if length < 8 then
		for _, pair in chevrons do pair[1].Transparency, pair[2].Transparency = 1, 1 end
		return
	end
	local frame = CFrame.lookAt(feet, feet + flat.Unit) -- −Z vers la cible
	for i, pair in chevrons do
		local d = 4 + (i - 1) * SPACING + travel
		if d > length - 3 then
			pair[1].Transparency, pair[2].Transparency = 1, 1
		else
			local fade = math.clamp(math.min(d - 4, CHEVRONS * SPACING - d) / 10, 0, 1)
			local y = (guideTarget.Y - feet.Y) * (d / length) + 0.25
			local at = frame * CFrame.new(0, y, -d)
			for k, bar in pair do
				local side = k == 1 and 1 or -1
				bar.Transparency = 1 - 0.85 * fade
				bar.CFrame = at * CFrame.new(side * 0.72, 0, 0.5) * CFrame.Angles(0, side * math.rad(40), 0) -- les deux branches du « V », pointe vers la cible
			end
		end
	end
end)

-- flèche à l'écran vers le bouton des animaux (dernière étape)
local screenArrow = label(gui, "ScreenArrow", UDim2.new(1, -196, 0.45, 20), UDim2.fromOffset(90, 70), YELLOW, 5)
screenArrow.Text = "▶"
screenArrow.Visible = false
TweenService:Create(screenArrow, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Position = UDim2.new(1, -176, 0.45, 20)}):Play()

local stepSound = Instance.new("Sound")
stepSound.SoundId = "rbxassetid://135869563808171" -- le son « fenêtre qui s'ouvre » du jeu (UIEffects)
stepSound.Volume = 0.5
stepSound.Parent = SoundService

---------------------------------------------------------------- déroulé
local finished = false
local function finish(notifyServer)
	if finished then return end
	finished = true
	if notifyServer then completeRemote:FireServer() end
	guideConnection:Disconnect()
	guide:Destroy()
	stepSound:Destroy()
	gui:Destroy()
end
close.Activated:Connect(function() finish(true) end)

local function show(index, celebrate)
	number.Text = index .. "/" .. #STEPS
	TweenService:Create(progress, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale((index - 1) / #STEPS, 1)}):Play()
	pop.Scale = 0.8
	TweenService:Create(pop, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	if celebrate then SoundService:PlayLocalSound(stepSound) end
end

local index = 1
if STEPS[1].Enter then STEPS[1].Enter() end
show(1, false)
while not finished do
	local step = STEPS[index]
	message.Text = type(step.Text) == "function" and step.Text() or step.Text
	local target, focus = nil, nil
	if step.Target then target, focus = step.Target() end
	local root = rootPart()
	guideTarget = target
	focusOutline.Adornee = focus
	focusOutline.Enabled = focus ~= nil
	screenArrow.Visible = step.ScreenHint == true
	if target then
		targetPart.Position = target
		distance.Text = root and (math.floor((Vector3.new(target.X, root.Position.Y, target.Z) - root.Position).Magnitude) .. " studs away") or ""
	else
		distance.Text = ""
	end
	if step.Done() then
		index += 1
		if index > #STEPS then
			-- terminé : un mot de fin, puis le bandeau s'en va
			guideTarget = nil
			focusOutline.Enabled = false
			screenArrow.Visible = false
			number.Text = "✔"
			chipFill.Color = ColorSequence.new(rgb(170, 255, 120), rgb(40, 190, 70))
			message.Text = "Your pet earns money! Upgrade your treadmill and explore all the zones!"
			distance.Text = "Tutorial complete"
			TweenService:Create(progress, TweenInfo.new(0.4), {Size = UDim2.fromScale(1, 1)}):Play()
			pop.Scale = 0.8
			TweenService:Create(pop, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
			SoundService:PlayLocalSound(stepSound)
			completeRemote:FireServer()
			task.wait(7)
			finish(false)
			break
		end
		if STEPS[index].Enter then STEPS[index].Enter() end
		show(index, true)
	elseif step.Back and index > 1 and step.Back() then
		local here = rootPart()
		if not (here and inside(workspace:FindFirstChild("safe zone"), here.Position)) then
			index -= 1
			show(index, false)
		end
	end
	task.wait(0.25)
end

-- Tutoriel des nouveaux joueurs (attribut TutorialDone = false, posé par TutorialServer), après la cinématique d'arrivée.
-- En haut de l'écran, du texte seul (aucun panneau) : l'étape, ce qu'il faut faire, une ligne d'explication. Dans le monde :
-- des flèches jaunes à contour noir qui courent au sol vers la cible, un anneau et une grosse flèche qui rebondit dessus, la
-- cible entourée d'un contour. Pour la dernière étape, une flèche à l'écran montre le bouton des animaux.
-- Chaque étape se valide toute seule quand le joueur a fait ce qui est demandé :
--   1. courir sur son tapis        2. aller dans la première zone        3. casser un œuf au marteau et attraper l'animal
--   4. le ramener dans la safe zone        5. le poser dans son jardin
-- Le texte « SKIP TUTORIAL » ferme le tutoriel. À la fin (ou au X) le serveur retient que c'est fait (remote TutorialComplete).
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
-- étape « casser un œuf » : dès qu'un œuf est touché, la flèche reste dessus ; quand il éclot, elle montre l'animal qui en sort
local smash = {Egg = nil, Pos = nil, GoneAt = nil}
local function hatchedPetNear(position)
	local folder = workspace:FindFirstChild("ZoneEggs")
	if not folder or not position then return nil end
	local best, bestDistance
	for _, zone in folder:GetChildren() do
		for _, m in zone:GetChildren() do
			if m.Name == "HatchedPet" and m:IsA("Model") and not m:GetAttribute("Taken") then
				local d = (m:GetPivot().Position - position).Magnitude
				if d < 25 and (not bestDistance or d < bestDistance) then best, bestDistance = m, d end
			end
		end
	end
	return best
end
local function smashTarget()
	-- l'œuf suivi est cassé : l'animal sort (défilement de 3 s), puis on le montre jusqu'à ce qu'il soit pris
	if smash.Egg and (not smash.Egg.Parent or smash.Egg:GetAttribute("Hatching")) then
		smash.GoneAt = smash.GoneAt or os.clock()
		local pet = hatchedPetNear(smash.Pos)
		if pet then return pet:GetPivot().Position, pet, "pet" end
		if os.clock() - smash.GoneAt < 8 then return smash.Pos, nil, "hatching" end
		smash.Egg, smash.Pos, smash.GoneAt = nil, nil, nil -- personne ne l'a pris à temps : on repart sur un autre œuf
	end
	if smash.Egg and smash.Egg.Parent then
		smash.Pos = smash.Egg:GetPivot().Position
		return smash.Pos, smash.Egg, "egg"
	end
	-- un œuf que le joueur a commencé à frapper (ses PV ont baissé) : on le garde
	local root, folder = rootPart(), workspace:FindFirstChild("ZoneEggs")
	if root and folder then
		for _, zone in folder:GetChildren() do
			for _, egg in zone:GetChildren() do
				local maxHp = egg:IsA("Model") and egg:GetAttribute("MaxHp")
				if maxHp and (egg:GetAttribute("Hp") or maxHp) < maxHp and (egg:GetPivot().Position - root.Position).Magnitude < 25 then
					smash.Egg, smash.Pos, smash.GoneAt = egg, egg:GetPivot().Position, nil
					return smash.Pos, egg, "egg"
				end
			end
		end
	end
	local egg = nearestEgg()
	return egg and egg:GetPivot().Position, egg, "free"
end

local speedAtStart = 0
local STEPS = {
	{
		Title = "RUN ON YOUR TREADMILL",
		Text = "Walk onto it: you run by yourself and gain Speed!",
		Enter = function() speedAtStart = player:GetAttribute("Speed") or 0 end,
		Target = function()
			local base = myBase()
			local belt = base and base:FindFirstChild("Treadmill") and base.Treadmill:FindFirstChild("Belt")
			return belt and belt.Position + Vector3.new(0, belt.Size.Y / 2, 0), base and base:FindFirstChild("Treadmill") -- (position, objet à entourer)
		end,
		Done = function() return (player:GetAttribute("Speed") or 0) >= speedAtStart + 15 end,
	},
	{
		Title = "GO TO THE FOREST ZONE",
		Text = "Jump off the treadmill and follow the arrows!",
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
		Title = "SMASH AN EGG",
		Text = function()
			local _, _, phase = smashTarget()
			if phase == "pet" then return "GRAB THE ANIMAL that came out of your egg!" end
			if phase == "hatching" then return "It's hatching... get ready to grab it!" end
			if phase == "egg" then return "Keep hitting this egg until it breaks!" end
			return player:GetAttribute("HammerOut") and "Hit it until it breaks, then grab the animal!" or "Take out your hammer first (slot 1)!"
		end,
		Target = function()
			local position, focus = smashTarget()
			return position, focus
		end,
		Done = carrying,
	},
	{
		Title = "BRING IT HOME",
		Text = "Run back to the safe zone before the guardian catches you!",
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
		Title = "PLACE YOUR PET",
		Text = "Press the PAW button on the right, then EQUIP BEST!",
		ScreenHint = true, -- une flèche à l'écran montre le bouton
		Target = function()
			local base = myBase()
			return base and base:FindFirstChild("animaux") and base.animaux.Position
		end,
		Done = function() return (player:GetAttribute("Income") or 0) > 0 end,
	},
}

---------------------------------------------------------------- texte en haut de l'écran (aucun panneau)
local ITALIC = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic)
local YELLOW, ORANGE, BLACK = rgb(255, 226, 70), rgb(255, 150, 30), Color3.new(0, 0, 0)
local gui = Instance.new("ScreenGui")
gui.Name = "TutorialGui"
gui.DisplayOrder = -1 -- sous les fenêtres du jeu : une boutique ouverte passe devant le texte
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false
local top = Instance.new("Frame")
top.Name = "Top"
top.BackgroundTransparency = 1
top.AnchorPoint = Vector2.new(0.5, 0)
top.Position = UDim2.new(0.5, 0, 0, 60)
top.Size = UDim2.new(0.9, 0, 0, 124)
local limit = Instance.new("UISizeConstraint")
limit.MaxSize = Vector2.new(820, 124)
limit.Parent = top
local pop = Instance.new("UIScale")
pop.Parent = top
local function label(parent, name, position, size, color, thickness, font)
	local l = Instance.new("TextLabel")
	l.Name = name
	l.BackgroundTransparency = 1
	l.Position, l.Size = position, size
	l.FontFace = font or FONT
	l.Text = ""
	l.TextScaled = true
	l.TextColor3 = color
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = thickness
	stroke.Parent = l
	l.Parent = parent
	return l
end
local stepLabel = label(top, "Step", UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0, 20), YELLOW, 2.5, ITALIC)
local title = label(top, "Title", UDim2.new(0, 0, 0, 22), UDim2.new(1, 0, 0, 50), WHITE, 5)
local titleColor = Instance.new("UIGradient") -- (le script Text3D le recopie sur la face du texte)
titleColor.Rotation = 90
titleColor.Color = ColorSequence.new(rgb(255, 246, 150), ORANGE)
titleColor.Parent = title
local message = label(top, "Message", UDim2.new(0, 0, 0, 76), UDim2.new(1, 0, 0, 24), WHITE, 3)
-- « Skip » : un simple texte cliquable, pas de cadre
local skip = Instance.new("TextButton")
skip.Name = "Skip"
skip.BackgroundTransparency = 1
skip.AnchorPoint = Vector2.new(0.5, 0)
skip.Position, skip.Size = UDim2.new(0.5, 0, 0, 106), UDim2.fromOffset(170, 16)
skip.FontFace = ITALIC
skip.Text = "SKIP TUTORIAL  X"
skip.TextScaled = true
skip.TextColor3 = rgb(226, 230, 244)
skip.AutoButtonColor = false
local skipStroke = Instance.new("UIStroke")
skipStroke.Thickness = 2
skipStroke.Parent = skip
skip.Parent = top
top.Parent = gui
gui.Parent = playerGui

---------------------------------------------------------------- guidage dans le monde
-- Des flèches jaunes à contour noir courent au sol, du joueur vers la cible. Sur la cible : un anneau carré qui tourne et une
-- grosse flèche qui rebondit en tournant ; l'objet à atteindre est entouré d'un contour.
local guide = Instance.new("Folder")
guide.Name = "TutorialGuide"
guide.Parent = workspace
local function piece(class, size, color, material)
	local p = Instance.new(class)
	p.Size = size
	p.Color = color
	p.Material = material
	p.Anchored = true
	p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = false, false, false, false
	p.Transparency = 1
	p.Parent = guide
	return p
end
-- une flèche plate, pointe vers −Z : une tige et une pointe (deux coins), posées sur la même forme en noir, un peu plus grande
-- twoSided : la face jaune dépasse des deux côtés du contour (flèche dressée, vue de partout)
local function makeArrow(scale, thickness, twoSided)
	local arrow = {Face = {}, Edge = {}}
	local function shape(list, border, y, color, material, thickness)
		local headW = (4.4 + border * 4.1) * scale       -- largeur de la pointe
		local headL = (2.8 + border * 2.62) * scale      -- longueur de la pointe
		local base = border * scale                      -- la base de la pointe recule du bord
		local shaftW, shaftL = (1.9 + border * 2) * scale, (2.3 + border) * scale
		local function add(class, size, offset)
			table.insert(list, {Part = piece(class, size, color, material), Offset = offset})
		end
		add("Part", Vector3.new(shaftW, thickness, shaftL), CFrame.new(0, y, shaftL / 2))
		-- les deux moitiés de la pointe : des coins couchés à plat (leur angle droit au milieu de la base)
		local wedge = Vector3.new(thickness, headW / 2, headL)
		add("WedgePart", wedge, CFrame.fromMatrix(Vector3.new(headW / 4, y, base - headL / 2), Vector3.new(0, -1, 0), Vector3.new(1, 0, 0), Vector3.new(0, 0, 1)))
		add("WedgePart", wedge, CFrame.fromMatrix(Vector3.new(-headW / 4, y, base - headL / 2), Vector3.new(0, 1, 0), Vector3.new(-1, 0, 0), Vector3.new(0, 0, 1)))
	end
	shape(arrow.Edge, 0.3, twoSided and 0 or -0.05, BLACK, Enum.Material.SmoothPlastic, thickness)
	shape(arrow.Face, 0, 0, WHITE, Enum.Material.Neon, twoSided and thickness + 0.2 or thickness)
	return arrow
end
local function placeArrow(arrow, cf, visibility, color)
	for _, entry in arrow.Edge do
		entry.Part.CFrame = cf * entry.Offset
		entry.Part.Transparency = 1 - visibility
	end
	for _, entry in arrow.Face do
		entry.Part.CFrame = cf * entry.Offset
		entry.Part.Transparency = 1 - visibility
		if color then entry.Part.Color = color end
	end
end
local ARROWS, SPACING, FLOW = 14, 5, 13 -- nombre de flèches au sol, écart et vitesse (studs par seconde)
local ARROW_COLOR, ARROW_DIM = WHITE, rgb(205, 212, 228) -- flèches blanches (un léger éclat court le long de la file)
local trail = {}
for i = 1, ARROWS do trail[i] = makeArrow(0.55, 0.1) end -- fines
local marker = makeArrow(0.95, 0.5, true) -- la flèche au-dessus de la cible
local ring = {}
for i = 1, 4 do
	ring[i] = {Edge = piece("Part", Vector3.new(9.2, 0.16, 0.6), BLACK, Enum.Material.SmoothPlastic), Face = piece("Part", Vector3.new(8.8, 0.2, 0.3), WHITE, Enum.Material.Neon)}
end
local focusOutline = Instance.new("Highlight")
focusOutline.Name = "TutorialOutline"
focusOutline.FillTransparency = 1
focusOutline.OutlineColor = WHITE
focusOutline.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
focusOutline.Enabled = false
focusOutline.Parent = guide

local guideTarget -- position visée, ou nil
-- hauteur du sol sous un point (les flèches suivent le terrain : marches, jardin surélevé...)
local groundParams = RaycastParams.new()
groundParams.FilterType = Enum.RaycastFilterType.Exclude
local function groundAt(x, z, guess)
	groundParams.FilterDescendantsInstances = {guide, player.Character}
	local hit = workspace:Raycast(Vector3.new(x, guess + 4, z), Vector3.new(0, -12, 0), groundParams)
	return hit and hit.Position.Y or guess
end
local travel = 0
local guideConnection = RunService.RenderStepped:Connect(function(dt)
	local root = rootPart()
	local now = os.clock()
	if not guideTarget or not root then
		for _, arrow in trail do placeArrow(arrow, CFrame.new(), 0) end
		placeArrow(marker, CFrame.new(), 0)
		for _, bar in ring do bar.Edge.Transparency, bar.Face.Transparency = 1, 1 end
		return
	end
	-- cible : l'anneau tourne et respire, la grosse flèche rebondit en tournant sur elle-même
	local pulse = 1 + 0.1 * math.sin(now * 5)
	for i, bar in ring do
		local cf = CFrame.new(guideTarget + Vector3.new(0, 0.3, 0)) * CFrame.Angles(0, now * 1.1 + i * math.pi / 2, 0) * CFrame.new(0, 0, 4.05 * pulse)
		bar.Edge.CFrame, bar.Face.CFrame = cf, cf * CFrame.new(0, 0.03, 0)
		bar.Edge.Transparency, bar.Face.Transparency = 0, 0.05
	end
	local bounce = math.abs(math.sin(now * 3.2)) * 3
	placeArrow(marker, CFrame.new(guideTarget + Vector3.new(0, 9 + bounce, 0)) * CFrame.Angles(0, now * 2.2, 0) * CFrame.Angles(-math.pi / 2, 0, 0), 1,
		ARROW_DIM:Lerp(ARROW_COLOR, 0.5 + 0.5 * math.sin(now * 6)))
	-- flèches au sol : du joueur vers la cible, à hauteur du sol, avec un éclat blanc qui court le long de la file
	local feet = Vector3.new(root.Position.X, groundAt(root.Position.X, root.Position.Z, root.Position.Y - 3), root.Position.Z)
	local flat = Vector3.new(guideTarget.X - feet.X, 0, guideTarget.Z - feet.Z)
	local length = flat.Magnitude
	if length < 10 then
		for _, arrow in trail do placeArrow(arrow, CFrame.new(), 0) end
		return
	end
	travel = (travel + dt * FLOW) % SPACING
	local frame = CFrame.lookAt(feet, feet + flat.Unit) -- −Z vers la cible
	local span = ARROWS * SPACING
	for i, arrow in trail do
		local d = 4 + (i - 1) * SPACING + travel
		if d > length - 5 then
			placeArrow(arrow, CFrame.new(), 0)
		else
			local fade = math.clamp(math.min(d - 4, span - (d - 4), length - 5 - d) / 3, 0, 1)
			local at = frame * CFrame.new(0, 0, -d)
			local y = groundAt(at.X, at.Z, feet.Y + (guideTarget.Y - feet.Y) * (d / length)) - feet.Y + 0.2
			local glow = math.max(0, math.sin(now * 5 - d * 0.35)) ^ 3
			placeArrow(arrow, frame * CFrame.new(0, y, -d), fade, ARROW_DIM:Lerp(ARROW_COLOR, glow))
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
skip.Activated:Connect(function() finish(true) end)

local function bump(celebrate)
	pop.Scale = 0.7
	TweenService:Create(pop, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	if celebrate then SoundService:PlayLocalSound(stepSound) end
end

local index = 1
local lowered = false
if STEPS[1].Enter then STEPS[1].Enter() end
bump(false)
while not finished do
	local step = STEPS[index]
	title.Text = step.Title
	message.Text = type(step.Text) == "function" and step.Text() or step.Text
	local target, focus = nil, nil
	if step.Target then target, focus = step.Target() end
	local root = rootPart()
	guideTarget = target
	focusOutline.Adornee = focus
	focusOutline.Enabled = focus ~= nil
	screenArrow.Visible = step.ScreenHint == true
	local banner = playerGui:FindFirstChild("ZoneBannerGui") and playerGui.ZoneBannerGui:FindFirstChild("Banner")
	local low = banner ~= nil and banner.Visible -- le bandeau de zone est affiché : le texte passe dessous
	if low ~= lowered then
		lowered = low
		TweenService:Create(top, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0, low and 250 or 60)}):Play()
	end
	local away = target and root and math.floor((Vector3.new(target.X, root.Position.Y, target.Z) - root.Position).Magnitude)
	stepLabel.Text = "STEP " .. index .. "/" .. #STEPS .. (away and ("   -   " .. away .. " studs away") or "")
	if step.Done() then
		index += 1
		if index > #STEPS then
			-- terminé : un mot de fin, puis le texte s'en va
			guideTarget = nil
			focusOutline.Enabled = false
			screenArrow.Visible = false
			skip.Visible = false
			stepLabel.Text = "TUTORIAL COMPLETE"
			title.Text = "WELL DONE!"
			for _, g in title:GetDescendants() do
				if g:IsA("UIGradient") then g.Color = ColorSequence.new(rgb(190, 255, 120), rgb(50, 210, 70)) end
			end
			message.Text = "Your pet earns money! Upgrade your treadmill and explore all the zones!"
			bump(true)
			completeRemote:FireServer()
			task.wait(7)
			finish(false)
			break
		end
		if STEPS[index].Enter then STEPS[index].Enter() end
		bump(true)
	elseif step.Back and index > 1 and step.Back() then
		local here = rootPart()
		if not (here and inside(workspace:FindFirstChild("safe zone"), here.Position)) then
			index -= 1
			bump(false)
		end
	end
	task.wait(0.25)
end
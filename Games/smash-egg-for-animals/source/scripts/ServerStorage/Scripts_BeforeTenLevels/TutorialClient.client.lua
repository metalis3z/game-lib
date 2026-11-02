-- Tutoriel des nouveaux joueurs (attribut TutorialDone = false, posé par TutorialServer), après la cinématique d'arrivée.
-- Un bandeau en haut de l'écran donne l'étape en cours ; un ruban lumineux au sol et une flèche qui rebondit montrent où aller.
-- Chaque étape se valide toute seule quand le joueur a fait ce qui est demandé :
--   1. courir sur son tapis        2. aller dans la première zone        3. casser un œuf au marteau et attraper l'animal
--   4. le ramener dans la safe zone        5. le poser dans son jardin
-- Le bouton X ferme le tutoriel. À la fin (ou au X) le serveur retient que c'est fait (remote TutorialComplete).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
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
		Text = "Step on your TREADMILL and run to gain Speed!",
		Enter = function() speedAtStart = player:GetAttribute("Speed") or 0 end,
		Target = function()
			local base = myBase()
			local belt = base and base:FindFirstChild("Treadmill") and base.Treadmill:FindFirstChild("Belt")
			return belt and belt.Position
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
			return egg and egg:GetPivot().Position
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
		Text = "Open your ANIMALS (paw button) and place your pet in the garden!",
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
local distance = label(panel, "Distance", UDim2.new(0, 92, 0, 60), UDim2.new(1, -150, 0, 20), rgb(255, 226, 110), 2.5)
distance.TextXAlignment = Enum.TextXAlignment.Left
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

---------------------------------------------------------------- guidage dans le monde : ruban au sol et flèche sur la cible
local targetPart = Instance.new("Part")
targetPart.Name = "TutorialTarget"
targetPart.Size = Vector3.one
targetPart.Transparency = 1
targetPart.Anchored = true
targetPart.CanCollide, targetPart.CanQuery, targetPart.CanTouch = false, false, false
targetPart.Parent = workspace
local targetAttachment = Instance.new("Attachment")
targetAttachment.Parent = targetPart
local beam = Instance.new("Beam")
beam.Attachment1 = targetAttachment
beam.Width0, beam.Width1 = 1.6, 1.6
beam.FaceCamera = true
beam.Color = ColorSequence.new(rgb(255, 240, 120), rgb(255, 170, 40))
beam.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75), NumberSequenceKeypoint.new(0.15, 0.25), NumberSequenceKeypoint.new(1, 0.25)})
beam.LightEmission = 0.7
beam.Segments = 1
beam.Parent = targetPart
local arrowGui = Instance.new("BillboardGui")
arrowGui.Name = "TutorialArrow"
arrowGui.Size = UDim2.fromOffset(90, 90)
arrowGui.StudsOffsetWorldSpace = Vector3.new(0, 9, 0)
arrowGui.LightInfluence = 0
arrowGui.MaxDistance = 2000
arrowGui.Parent = targetPart
local arrow = label(arrowGui, "Arrow", UDim2.fromScale(0, 0), UDim2.fromScale(1, 1), rgb(255, 220, 70), 4)
arrow.Text = "▼"
TweenService:Create(arrowGui, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {StudsOffsetWorldSpace = Vector3.new(0, 12, 0)}):Play()

local function hookCharacter(character)
	local root = character:WaitForChild("HumanoidRootPart", 10)
	if not root then return end
	local a = Instance.new("Attachment")
	a.Name = "TutorialBeam"
	a.Position = Vector3.new(0, -2.4, 0)
	a.Parent = root
	beam.Attachment0 = a
end
if player.Character then task.spawn(hookCharacter, player.Character) end
player.CharacterAdded:Connect(hookCharacter)

---------------------------------------------------------------- déroulé
local finished = false
local function finish(notifyServer)
	if finished then return end
	finished = true
	if notifyServer then completeRemote:FireServer() end
	targetPart:Destroy()
	gui:Destroy()
end
close.Activated:Connect(function() finish(true) end)

local function show(index)
	number.Text = index .. "/" .. #STEPS
	pop.Scale = 0.8
	TweenService:Create(pop, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
end

local index = 1
if STEPS[1].Enter then STEPS[1].Enter() end
show(1)
while not finished do
	local step = STEPS[index]
	message.Text = type(step.Text) == "function" and step.Text() or step.Text
	local target = step.Target and step.Target()
	local root = rootPart()
	if target then
		targetPart.Position = target
		beam.Enabled, arrowGui.Enabled = true, true
		distance.Text = root and string.format("%d studs away", math.floor((Vector3.new(target.X, root.Position.Y, target.Z) - root.Position).Magnitude)) or ""
	else
		beam.Enabled, arrowGui.Enabled = false, false
		distance.Text = ""
	end
	if step.Done() then
		index += 1
		if index > #STEPS then
			-- terminé : un mot de fin, puis le bandeau s'en va
			beam.Enabled, arrowGui.Enabled = false, false
			number.Text = "✔"
			chipFill.Color = ColorSequence.new(rgb(170, 255, 120), rgb(40, 190, 70))
			message.Text = "Your pet earns money! Upgrade your treadmill and explore all the zones!"
			distance.Text = ""
			pop.Scale = 0.8
			TweenService:Create(pop, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
			completeRemote:FireServer()
			task.wait(7)
			finish(false)
			break
		end
		if STEPS[index].Enter then STEPS[index].Enter() end
		show(index)
	elseif step.Back and index > 1 and step.Back() then
		local root2 = rootPart()
		if not (root2 and inside(workspace:FindFirstChild("safe zone"), root2.Position)) then
			index -= 1
			show(index)
		end
	end
	task.wait(0.25)
end

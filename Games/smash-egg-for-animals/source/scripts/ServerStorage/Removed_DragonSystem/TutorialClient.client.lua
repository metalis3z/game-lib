-- Tutoriel des nouveaux joueurs (une seule fois : voir ServerScriptService.TutorialServer)
--   1. Monter sur son dragon        -> flèche vers le dragon
--   2. Voler jusqu'à un œuf        -> flèche vers un œuf au hasard de la zone Common (commandes de vol expliquées)
--   3. Brûler l'œuf                -> une fois tout près
--   4. Ramasser le pet éclos       -> flèche vers le pet
--   5. Le ramener en zone sûre     -> flèche vers sa base
--   6. Ouvrir l'inventaire          -> flèche vers le bouton Inventory
--   7. Placer le pet                -> flèche vers le pet dans l'inventaire
--   8. Ouvrir le stand Upgrades     -> flèche vers le stand (vitesse, endurance, puissance de feu)
-- Chaque étape a un titre, une consigne (Sub) et un conseil (Tip, en vert) qui explique le pourquoi.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local completeRemote = ReplicatedStorage:WaitForChild("TutorialSystem"):WaitForChild("TutorialComplete")
local eggRemotes = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes")

-- le serveur dit si le tutoriel a déjà été fait
local waited = 0
while player:GetAttribute("TutorialDone") == nil and waited < 30 do waited += task.wait(0.2) end
if player:GetAttribute("TutorialDone") ~= false then return end

---------------------------------------------------------------- Textes
local touch = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local STEPS = {
	Dragon = {N = 1, Title = "Call your dragon!", Label = "YOUR DRAGON",
		Sub = touch and "Your dragon sleeps on the tree next to your base. Tap the green RIDE button at the bottom of the screen."
			or "Your dragon sleeps on the tree next to your base. Click the green RIDE button at the bottom of the screen (or press [R]).",
		Tip = "It flies to you and you climb on it. It is how you travel and how you steal eggs. In the safe zone it goes back to sleep on its tree when you get off."},
	Fly = {N = 2, Title = "Fly to the egg!", Label = "FLY HERE",
		Sub = touch and "Move with the joystick. Hold the FLY button to go up, release it to come back down." or "Move with [W][A][S][D]. Hold [Space] to go up, release it to come back down.",
		Tip = "Flying uses the Stamina bar at the bottom. It refills when your dragon is on the ground."},
	Egg = {N = 3, Title = "Burn the egg!", Label = "BURN THIS EGG",
		Sub = touch and "Stay close, face the egg and hold your finger on the screen to breathe fire." or "Stay close, face the egg and hold [Left Click] (or [F]) to breathe fire.",
		Tip = "Keep the fire on it for about 3 seconds: the egg cracks and an animal comes out."},
	Pet = {N = 4, Title = "Grab your animal!", Label = "YOUR ANIMAL",
		Sub = touch and "The egg hatched! Land next to the animal and tap GRAB." or "The egg hatched! Land next to the animal and hold [E] to grab it.",
		Tip = "Your dragon carries it on its back. Rare eggs give animals that earn more."},
	Safe = {N = 5, Title = "Bring it home!", Label = "YOUR BASE",
		Sub = "Fly back to your base with the animal. The guardian of the zone is chasing you!",
		Tip = "If the guardian catches you, you lose the animal. Once you are home, it is yours."},
	Inventory = {N = 6, Title = "Open your inventory!",
		Sub = touch and "The animal is now in your inventory. Tap the Inventory button." or "The animal is now in your inventory. Click the Inventory button (or press [B]).",
		Tip = "Everything you bring home is stored there."},
	Place = {N = 7, Title = "Place your animal!",
		Sub = touch and "Tap your animal to hold it, then tap the ground of your garden to put it down." or "Click your animal to hold it, then click the ground of your garden to put it down.",
		Tip = "An animal in your garden earns money every second, even while you are away."},
	Upgrade = {N = 8, Title = "Upgrade your dragon!", Label = "UPGRADES",
		Sub = touch and "Go to the Upgrades stand and tap OPEN." or "Go to the Upgrades stand and hold [E] to open it.",
		Tip = "Spend your money there: Speed to fly faster, Stamina to fly longer, Burn to open the rarer egg zones."},
}
local TOTAL = 8
local BURN_RANGE = 34 -- à moins de cette distance de l'œuf, on passe de « vole » à « brûle »

---------------------------------------------------------------- Interface
local YELLOW = Color3.fromRGB(255, 221, 64)
local GREEN = Color3.fromRGB(150, 255, 150)
local INK = Color3.fromRGB(36, 23, 51)
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local FONT_SUB = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)

local function new(class, props, parent)
	local obj = Instance.new(class)
	for k, v in props do obj[k] = v end
	obj.Parent = parent
	return obj
end

local gui = new("ScreenGui", {Name = "TutorialGui", ResetOnSpawn = false, IgnoreGuiInset = false, ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets, DisplayOrder = 50, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, playerGui)
local function bannerScale() -- taille du bandeau selon l'écran (même base que UIScaler, un peu plus grand pour rester lisible sur mobile)
	local view = workspace.CurrentCamera.ViewportSize
	return math.clamp(math.min(view.X / 1280, view.Y / 760) * 1.3, 0.6, 1)
end

-- bandeau d'instructions en haut de l'écran
local banner = new("Frame", {Name = "Banner", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -64, 0.22, 0), Size = UDim2.new(0, 370, 0, 200), BackgroundTransparency = 1}, gui) -- pas de cadre : seulement du texte
local bannerLimit = new("UISizeConstraint", {MaxSize = Vector2.new(370, 200), MinSize = Vector2.new(240, 160)}, banner)
local pill = new("TextLabel", {Name = "Step", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 0), Size = UDim2.new(0, 150, 0, 30), BackgroundTransparency = 1, FontFace = FONT, TextColor3 = Color3.new(1, 1, 1), TextScaled = true, Text = "STEP 1/6", ZIndex = 3}, banner)
new("UIStroke", {Color = Color3.new(0, 0, 0), Thickness = 3}, pill)
new("UIPadding", {PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4)}, pill)
local title = new("TextLabel", {Name = "Title", BackgroundTransparency = 1, Position = UDim2.new(0, 18, 0, 18), Size = UDim2.new(1, -36, 0.2, 0), FontFace = FONT, TextColor3 = YELLOW, TextScaled = true, Text = ""}, banner)
new("UIStroke", {Color = Color3.new(0, 0, 0), Thickness = 4}, title)
local sub = new("TextLabel", {Name = "Sub", BackgroundTransparency = 1, Position = UDim2.new(0, 18, 0.2, 22), Size = UDim2.new(1, -36, 0.36, -10), FontFace = FONT_SUB, TextColor3 = Color3.new(1, 1, 1), TextScaled = true, TextWrapped = true, Text = ""}, banner)
new("UIStroke", {Color = Color3.new(0, 0, 0), Thickness = 3}, sub)
new("UITextSizeConstraint", {MaxTextSize = 22}, sub)
-- conseil : explique le pourquoi de l'étape
local tip = new("TextLabel", {Name = "Tip", BackgroundTransparency = 1, Position = UDim2.new(0, 18, 0.56, 16), Size = UDim2.new(1, -36, 0.44, -22), FontFace = FONT_SUB, TextColor3 = GREEN, TextScaled = true, TextWrapped = true, Text = ""}, banner)
new("UIStroke", {Color = Color3.new(0, 0, 0), Thickness = 3}, tip)
new("UITextSizeConstraint", {MaxTextSize = 19}, tip)
-- barre de progression sous le bandeau
local progressBack = new("Frame", {Name = "Progress", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 1, 8), Size = UDim2.new(0.6, 0, 0, 10), BackgroundColor3 = INK, Visible = false}, banner)
new("UICorner", {CornerRadius = UDim.new(1, 0)}, progressBack)
local progressFill = new("Frame", {Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = YELLOW}, progressBack)
new("UICorner", {CornerRadius = UDim.new(1, 0)}, progressFill)

-- flèche dessinée (pointe vers le haut quand Rotation = 0) : contour foncé + intérieur jaune
local function makeArrow(parent, size)
	local holder = new("CanvasGroup", {Name = "Arrow", AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(size, size), BackgroundTransparency = 1, Visible = false, ZIndex = 5}, parent)
	local function bars(color, grow)
		local function bar(pos, sz, rot, anchor)
			local f = new("Frame", {AnchorPoint = anchor or Vector2.new(0.5, 0.5), Position = pos, Size = UDim2.fromScale(sz.X + grow, sz.Y + grow), Rotation = rot, BackgroundColor3 = color, BorderSizePixel = 0}, holder)
			new("UICorner", {CornerRadius = UDim.new(0.5, 0)}, f)
		end
		bar(UDim2.fromScale(0.5, 0.96 + grow / 2), Vector2.new(0.2, 0.74), 0, Vector2.new(0.5, 1))
		bar(UDim2.fromScale(0.32, 0.28), Vector2.new(0.2, 0.58), 44)
		bar(UDim2.fromScale(0.68, 0.28), Vector2.new(0.2, 0.58), -44)
	end
	bars(Color3.new(0, 0, 0), 0.13) -- contour noir
	bars(Color3.new(1, 1, 1), 0)   -- flèche blanche
	return holder
end

local guiArrow = makeArrow(gui, 74)  -- montre un bouton de l'interface
local edgeArrow = makeArrow(gui, 64) -- au bord de l'écran quand la cible n'est pas visible

-- repère 3D au-dessus de la cible : texte + distance + flèche qui rebondit
local targetAttachment = new("Attachment", {Name = "TutorialTarget"}, workspace.Terrain)
local marker = new("BillboardGui", {Name = "TutorialMarker", Adornee = targetAttachment, AlwaysOnTop = true, LightInfluence = 0, Size = UDim2.fromOffset(170, 150), SizeOffset = Vector2.new(0, 0.5), MaxDistance = math.huge, Enabled = false, ResetOnSpawn = false}, playerGui)
local markerLabel = new("TextLabel", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 28), FontFace = FONT, TextColor3 = YELLOW, TextScaled = true, Text = ""}, marker)
new("UIStroke", {Color = Color3.new(0, 0, 0), Thickness = 3.5}, markerLabel)
local markerDist = new("TextLabel", {BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 28), Size = UDim2.new(1, 0, 0, 20), FontFace = FONT_SUB, TextColor3 = Color3.new(1, 1, 1), TextScaled = true, Text = ""}, marker)
new("UIStroke", {Color = Color3.new(0, 0, 0), Thickness = 3}, markerDist)
local markerArrow = makeArrow(marker, 80)
markerArrow.Rotation = 180
markerArrow.Visible = true

-- chemin de petites flèches blanches qui avancent du joueur vers la cible
local PATH_COUNT, PATH_SPACING = 9, 9
local pathArrows = {}
for i = 1, PATH_COUNT do pathArrows[i] = makeArrow(gui, 30) end
local function hidePath()
	for _, arrow in pathArrows do arrow.Visible = false end
end
local function drawPath(from, to, t, camera)
	local delta = to - from
	local distance = delta.Magnitude
	if distance < 12 then hidePath() return end
	local dir = delta.Unit
	local flow = (t * 10) % PATH_SPACING
	local inset = gui.AbsolutePosition
	for i, arrow in pathArrows do
		local along = 5 + (i - 1) * PATH_SPACING + flow
		local a, visible = camera:WorldToScreenPoint(from + dir * along)
		local b = camera:WorldToScreenPoint(from + dir * (along + 2))
		if along < distance - 4 and visible and a.Z > 0 and b.Z > 0 then
			local size = math.clamp(900 / a.Z, 16, 40)
			arrow.Size = UDim2.fromOffset(size, size)
			arrow.Position = UDim2.fromOffset(a.X - inset.X, a.Y - inset.Y)
			arrow.Rotation = math.deg(math.atan2(b.X - a.X, -(b.Y - a.Y)))
			arrow.GroupTransparency = math.clamp((i - 1 + flow / PATH_SPACING) / PATH_COUNT, 0, 1) ^ 2 * 0.85
			arrow.Visible = true
		else
			arrow.Visible = false
		end
	end
end

-- quand l'inventaire est ouvert, le bandeau se met sur le côté pour ne pas le cacher
local layout = "Top"
local function setLayout(mode, width)
	if mode == layout and mode ~= "Side" then return end
	layout = mode
	if mode == "Side" then
		bannerLimit.MinSize, bannerLimit.MaxSize = Vector2.new(180, 200), Vector2.new(340, 290)
		banner.AnchorPoint = Vector2.new(1, 0.5)
		banner.Position = UDim2.new(1, -12, 0.5, 0)
		banner.Size = UDim2.fromOffset(width, 270)
	elseif mode == "Bottom" then
		bannerLimit.MinSize, bannerLimit.MaxSize = Vector2.new(300, 130), Vector2.new(680, 150)
		banner.AnchorPoint = Vector2.new(0.5, 1)
		banner.Position = UDim2.new(0.5, 0, 1, -22)
		banner.Size = UDim2.new(0.66, 0, 0, 150)
	else
		bannerLimit.MinSize, bannerLimit.MaxSize = Vector2.new(240, 160), Vector2.new(370, 200)
		banner.AnchorPoint = Vector2.new(1, 0)
		banner.Position = UDim2.new(1, -64, 0.22, 0)
		banner.Size = UDim2.new(0, 370, 0, 200)
	end
end

---------------------------------------------------------------- Infos du jeu
local inventory -- reçu du serveur (InventoryUpdated)
local basePets, basePlaced -- au début du tutoriel
local function counts(inv)
	local pets, placed = 0, 0
	for _, pet in inv and inv.Pets or {} do
		pets += 1
		if pet.Placed then placed += 1 end
	end
	return pets, placed
end
eggRemotes:WaitForChild("InventoryUpdated").OnClientEvent:Connect(function(inv)
	inventory = inv
	if not basePets then basePets, basePlaced = counts(inv) end
end)
eggRemotes:WaitForChild("PetAction"):FireServer("Sync")

local function myDragon()
	local folder = workspace:FindFirstChild("Dragons")
	for _, dragon in folder and folder:GetChildren() or {} do
		if dragon:GetAttribute("Owner") == player.UserId then return dragon end
	end
end

local function commonEggFolder()
	local eggs = workspace:FindFirstChild("ZoneEggs")
	if not eggs then return nil end
	for _, f in eggs:GetChildren() do
		if string.sub(string.lower(f.Name), 1, 6) == "common" then return f end
	end
end

local function pickEgg()
	local folder = commonEggFolder()
	if not folder then return nil end
	local normal, all = {}, {}
	for _, egg in folder:GetChildren() do
		if egg:IsA("Model") and egg:GetAttribute("EggKey") and not egg:GetAttribute("Hatching") and egg.PrimaryPart then
			table.insert(all, egg)
			if (egg:GetAttribute("Height") or 3) <= 6 then table.insert(normal, egg) end
		end
	end
	local list = #normal > 0 and normal or all
	return list[math.random(math.max(#list, 1))]
end

local function findHatchedNear(position)
	local folder = commonEggFolder()
	if not folder or not position then return nil end
	local best, bestDist = nil, 40
	for _, child in folder:GetChildren() do
		if child.Name == "HatchedPet" and child:IsA("Model") and not child:GetAttribute("Taken") then
			local d = (child:GetPivot().Position - position).Magnitude
			if d < bestDist then best, bestDist = child, d end
		end
	end
	return best
end

local function safeTarget()
	local bases = workspace:FindFirstChild("all base")
	local base = bases and bases:FindFirstChild("base " .. tostring(player:GetAttribute("BaseNumber")))
	local spawnPart = base and base:FindFirstChild("Spawn")
	return spawnPart or workspace:FindFirstChild("safe zone")
end

-- haut d'un modèle ou d'une pièce (en décalage par rapport à son pivot, pour suivre la cible à chaque image)
local function topOffset(target)
	if target:IsA("Model") then
		local cf, size = target:GetBoundingBox()
		return cf.Position + Vector3.new(0, size.Y / 2 + 1, 0) - target:GetPivot().Position
	end
	return Vector3.new(0, target.Size.Y / 2 + 4, 0)
end

---------------------------------------------------------------- Déroulé
local current -- étape affichée
local worldTarget, worldOffset -- cible 3D
local guiTarget -- bouton visé dans l'interface
local targetEgg, eggLastPos, hatchWaitUntil, hatchedPet
local finished = false

local function showStep(id)
	if current == id then return end
	current = id
	local step = STEPS[id]
	title.Text = step.Title
	sub.Text = step.Sub
	tip.Text = step.Tip or ""
	pill.Text = "STEP " .. step.N .. "/" .. TOTAL
	markerLabel.Text = step.Label or ""
	TweenService:Create(progressFill, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Size = UDim2.new((step.N - 1) / TOTAL, 0, 1, 0)}):Play()
	-- petit "pop" du bandeau à chaque nouvelle étape
	local scale = banner:FindFirstChild("Pop") or new("UIScale", {Name = "Pop"}, banner)
	scale.Scale = 0.8 * bannerScale()
	TweenService:Create(scale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = bannerScale()}):Play()
end

local function setWorldTarget(target)
	if target ~= worldTarget then
		worldTarget = target
		worldOffset = target and topOffset(target) or nil
	end
	guiTarget = nil
end

local function setGuiTarget(button)
	worldTarget, worldOffset = nil, nil
	guiTarget = button
end

local function finish()
	finished = true
	worldTarget, guiTarget = nil, nil
	completeRemote:FireServer()
	title.Text = "TUTORIAL COMPLETE!"
	sub.Text = "Steal eggs, place the animals in your garden, then spend the money on your dragon."
	tip.Text = "Stronger fire opens rarer zones, and rarer animals earn more. Have fun!"
	pill.Text = "DONE"
	TweenService:Create(progressFill, TweenInfo.new(0.4), {Size = UDim2.new(1, 0, 1, 0)}):Play()
	local scale = banner:FindFirstChild("Pop") or new("UIScale", {Name = "Pop"}, banner)
	scale.Scale = 0.8 * bannerScale()
	TweenService:Create(scale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = bannerScale()}):Play()
	task.delay(5, function()
		TweenService:Create(scale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0}):Play()
		task.wait(0.35)
		gui:Destroy()
		marker:Destroy()
		targetAttachment:Destroy()
	end)
end

local function evaluate()
	if finished then return end
	local pets, placed = counts(inventory)
	local gotPet = basePets ~= nil and pets > basePets

	-- 5 / 6 : inventaire puis placement
	if gotPet then
		if placed > basePlaced then -- 8 : le stand Upgrades (terminé dès qu'il l'a ouvert une fois)
			local upgrades = playerGui:FindFirstChild("UpgradesGui")
			local upMain = upgrades and upgrades:FindFirstChild("Main")
			local stand = workspace:FindFirstChild("UPGRADE shop")
			if (upMain and upMain.Visible) or not stand then finish() return end
			showStep("Upgrade")
			setWorldTarget(stand)
			return
		end
		local invGui = playerGui:FindFirstChild("PetInventoryGui")
		local main = invGui and invGui:FindFirstChild("Main")
		if main and main.Visible then
			showStep("Place")
			local grid = main:FindFirstChild("Grid")
			local slot
			for _, child in grid and grid:GetChildren() or {} do
				if child:IsA("GuiButton") and child.Visible and child:GetAttribute("Kind") == "Pets" then
					local tag = child:FindFirstChild("Placed")
					if not (tag and tag.Visible) and (not slot or child.LayoutOrder < slot.LayoutOrder) then slot = child end
				end
			end
			if not slot then -- onglet Œufs ouvert : on montre l'onglet Animaux
				local tabs = main:FindFirstChild("Tabs")
				slot = tabs and tabs:FindFirstChild("PetsTab")
			end
			setGuiTarget(slot)
		else
			showStep("Inventory")
			local button = playerGui:FindFirstChild("InventoryButtonGui")
			setGuiTarget(button and button:FindFirstChild("IconButton"))
		end
		return
	end

	-- 4 : pet sur le dos du dragon -> zone sûre
	if (player:GetAttribute("Carrying") or 0) > 0 then
		hatchedPet, targetEgg = nil, nil
		showStep("Safe")
		setWorldTarget(safeTarget())
		return
	end

	-- 3 : pet éclos à ramasser
	if hatchedPet and (not hatchedPet.Parent or hatchedPet:GetAttribute("Taken")) then hatchedPet = nil end
	if hatchedPet then
		showStep("Pet")
		setWorldTarget(hatchedPet)
		return
	end

	-- l'œuf visé vient d'éclore (ou a disparu) : on cherche le pet qui en est sorti
	if targetEgg and (not targetEgg.Parent or targetEgg:GetAttribute("Hatching")) then
		hatchedPet = findHatchedNear(eggLastPos)
		if hatchedPet then
			targetEgg, hatchWaitUntil = nil, nil
			showStep("Pet")
			setWorldTarget(hatchedPet)
			return
		end
		hatchWaitUntil = hatchWaitUntil or (os.clock() + 2.5)
		if os.clock() < hatchWaitUntil then return end -- l'œuf est en train d'éclater
		targetEgg, hatchWaitUntil = nil, nil
	end

	-- le joueur a brûlé un autre œuf que celui montré : on suit le pet qui vient d'éclore à côté de lui
	local dragon = myDragon()
	if dragon and dragon:GetAttribute("Rider") == player.UserId then
		local near = findHatchedNear(dragon:GetPivot().Position)
		if near then
			hatchedPet, targetEgg = near, nil
			showStep("Pet")
			setWorldTarget(hatchedPet)
			return
		end
	end

	-- 1 : monter sur le dragon
	if not dragon or dragon:GetAttribute("Rider") ~= player.UserId then
		showStep("Dragon")
		-- on montre le bouton RIDE (RideButtonClient) ; s'il n'est pas encore là, le dragon lui-même
		local rideGui = playerGui:FindFirstChild("RideGui")
		local rideHolder = rideGui and rideGui:FindFirstChild("Holder")
		local rideButton = rideHolder and rideHolder.Visible and rideHolder:FindFirstChild("Ride")
		if rideButton then setGuiTarget(rideButton) else setWorldTarget(dragon) end
		return
	end

	-- 2 : brûler un œuf de la zone Common
	if not targetEgg then targetEgg = pickEgg() end
	if targetEgg and targetEgg.PrimaryPart then eggLastPos = targetEgg:GetPivot().Position end
	local near = eggLastPos and (dragon:GetPivot().Position - eggLastPos).Magnitude < BURN_RANGE + (current == "Egg" and 12 or 0) -- marge : pas d'aller-retour entre les deux étapes
	showStep(near and "Egg" or "Fly")
	setWorldTarget(targetEgg)
end

-- logique 6 fois par seconde, affichage à chaque image
local accumulated = 0
RunService.RenderStepped:Connect(function(dt)
	if not gui.Parent then return end
	accumulated += dt
	if accumulated >= 0.15 then
		accumulated = 0
		evaluate()
	end
	local t = os.clock()
	local camera = workspace.CurrentCamera
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")

	-- cible 3D
	local pos = worldTarget and worldTarget.Parent and worldOffset and (worldTarget:GetPivot().Position + worldOffset)
	if pos and not finished then
		targetAttachment.WorldPosition = pos
		marker.Enabled = true
		markerArrow.Position = UDim2.new(0.5, 0, 0, 100 + math.abs(math.sin(t * 4)) * 22)
		if hrp then
			drawPath(hrp.Position - Vector3.new(0, 1.5, 0), pos, t, camera)
			markerDist.Text = math.floor((pos - hrp.Position).Magnitude) .. " studs"
		else
			hidePath()
		end
		-- hors de l'écran : flèche sur le bord qui indique la direction
		local screen, onScreen = camera:WorldToScreenPoint(pos)
		local size = gui.AbsoluteSize
		if onScreen and screen.Z > 0 then
			edgeArrow.Visible = false
		else
			local center = size / 2
			local dir = Vector2.new(screen.X, screen.Y) - center
			if screen.Z < 0 then dir = -dir end
			if dir.Magnitude < 1 then dir = Vector2.new(0, 1) end
			local margin = Vector2.new(60, 60)
			local half = center - margin
			local k = math.min(half.X / math.max(math.abs(dir.X), 1e-3), half.Y / math.max(math.abs(dir.Y), 1e-3))
			local p = center + dir * k
			local pulse = 1 + math.sin(t * 6) * 0.08
			edgeArrow.Position = UDim2.fromOffset(p.X, p.Y)
			edgeArrow.Rotation = math.deg(math.atan2(dir.X, -dir.Y))
			edgeArrow.Size = UDim2.fromOffset(64 * pulse, 64 * pulse)
			edgeArrow.Visible = true
		end
	else
		marker.Enabled = false
		hidePath()
		edgeArrow.Visible = false
	end

	-- inventaire ouvert : bandeau à droite de la fenêtre s'il y a la place, sinon en bas
	local invGui = playerGui:FindFirstChild("PetInventoryGui")
	local invMain = invGui and invGui:FindFirstChild("Main")
	if invMain and invMain.Visible and not finished then
		local space = gui.AbsoluteSize.X - (invMain.AbsolutePosition.X + invMain.AbsoluteSize.X)
		if space >= 200 then setLayout("Side", math.min(space - 24, 340)) else setLayout("Bottom") end
	else
		setLayout("Top")
	end

	-- bouton de l'interface : flèche au-dessus qui pointe vers lui
	if guiTarget and guiTarget.Parent and guiTarget.AbsoluteSize.X > 0 and not finished then
		local p = guiTarget.AbsolutePosition + Vector2.new(guiTarget.AbsoluteSize.X / 2, 0)
		local bounce = math.abs(math.sin(t * 4)) * 18
		guiArrow.Position = UDim2.fromOffset(p.X, p.Y - 44 - bounce)
		guiArrow.Rotation = 180
		guiArrow.Visible = true
	else
		guiArrow.Visible = false
	end
end)

evaluate()

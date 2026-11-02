-- Panneau "My Base" : toujours disponible à droite de l'écran. La flèche le fait glisser depuis la droite.
--   onglet Pets              : animaux posés avec leur photo, mutation, niveau, barre d'XP, poids et revenu
--   onglet Egg & Seed Timers : oeufs posés et plantes en terre avec leur minuteur
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")

local eggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(eggSystem:WaitForChild("EggConfig"))
local eggRemotes = eggSystem:WaitForChild("Remotes")
local petTemplates = eggSystem:WaitForChild("Pets")

local player = Players.LocalPlayer
local gui = script.Parent
local panel = gui:WaitForChild("Panel")
local arrow = panel:WaitForChild("Arrow")
local body = panel:WaitForChild("Body")
local tabs = body:WaitForChild("Tabs")
local list = body:WaitForChild("List")
local emptyLabel = body:WaitForChild("Empty")
local petRowTemplate = script:WaitForChild("PetRow")
local timerRowTemplate = script:WaitForChild("TimerRow")

local placedEggs = workspace:WaitForChild("PlacedEggs")
local placedPlants = workspace:WaitForChild("PlacedPlants")

local REFRESH = 0.4
local EDGE_MARGIN = 12  -- distance entre le panneau ouvert et le bord droit de l'écran
local HEIGHT = 0.45     -- position verticale (0 = haut, 1 = bas)
local SLIDE = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local TAB_ON_COLOR = ColorSequence.new(Color3.fromRGB(150, 226, 96), Color3.fromRGB(66, 170, 70))
local TAB_OFF_COLOR = ColorSequence.new(Color3.fromRGB(232, 190, 132), Color3.fromRGB(176, 124, 72))
local READY_COLOR = Color3.fromRGB(110, 255, 130)

local currentTab = "Pets"
local open = false
local pets = {}       -- animaux posés (reçus du serveur)
local timerRows = {}  -- [modèle] = ligne

---------------------------------------------------------------- ouverture / fermeture en glissant
local autoScale = panel:WaitForChild("AutoScale") -- créé par UIScaler

-- fermé : le panneau est juste hors de l'écran, seule la flèche dépasse
local function targetPosition()
	if open then return UDim2.new(1, -EDGE_MARGIN, HEIGHT, 0) end
	return UDim2.new(1, panel.Size.X.Offset * autoScale.Scale, HEIGHT, 0)
end

local function setOpen(value, instant)
	open = value
	arrow.Text = open and ">" or "<"
	if instant then
		panel.Position = targetPosition()
	else
		TweenService:Create(panel, SLIDE, {Position = targetPosition()}):Play()
	end
end

arrow.Activated:Connect(function() setOpen(not open) end)
autoScale:GetPropertyChangedSignal("Scale"):Connect(function() setOpen(open, true) end)
setOpen(false, true)

---------------------------------------------------------------- contenu
local function styleMutation(label, mutationName)
	local mutation = mutationName and Config.GetMutation(mutationName)
	if not mutation then return end
	if mutation.Color then
		label.TextColor3 = mutation.Color
	else
		local gradient = Instance.new("UIGradient")
		gradient.Color = Config.Gradients[mutationName]
		gradient.Parent = label
		CollectionService:AddTag(gradient, "AnimatedGradient")
	end
end

-- petite photo de l'animal (avec la couleur de sa mutation)
local function fillPortrait(view, petName, mutationName)
	local template = petTemplates:FindFirstChild(petName)
	if not template then return end
	local model = template:Clone()
	Config.ApplyMutation(model, mutationName)
	model:PivotTo(CFrame.new())
	model.Parent = view
	local cf, size = model:GetBoundingBox()
	local camera = Instance.new("Camera")
	camera.FieldOfView = 40
	local distance = math.max(size.X, size.Y, size.Z) * 1.6
	camera.CFrame = CFrame.lookAt(cf.Position + Vector3.new(0.7, 0.35, 1).Unit * distance, cf.Position)
	camera.Parent = view
	view.CurrentCamera = camera
end

local function clearList()
	for _, child in list:GetChildren() do
		if child:IsA("Frame") then child:Destroy() end
	end
	table.clear(timerRows)
end

local function renderPets()
	clearList()
	for index, pet in pets do
		local info = Config.Pets[pet.Pet]
		if info then
			local level = pet.Level or 1
			local needed = Config.XpForLevel(level)
			local maxed = level >= Config.MaxLevel
			local row = petRowTemplate:Clone()
			row.LayoutOrder = index
			row.PetName.Text = pet.Mutation and (pet.Mutation .. " " .. info.Name) or info.Name
			-- ce que l'animal rapporte chaque seconde
			row.PetName.Position = UDim2.new(0, 74, 0, 8)
			row.Info.Position = UDim2.new(0, 74, 0, 40)
			row.Info.Size = UDim2.new(1, -82, 0, 22)
			row.Info.Visible = true
			row.Info.TextColor3 = Color3.fromRGB(150, 255, 130)
			row.Info.Text = Config.FormatMoney(Config.GetIncome(pet.Pet, pet.Kg, pet.Mutation, pet.Level)) .. "/s"
			styleMutation(row.PetName, pet.Mutation)
			row.Level.Visible = false -- plus de niveaux ni d'XP : juste la photo et le nom
			row.Bar.Visible = false
			fillPortrait(row.View, pet.Pet, pet.Mutation)
			-- bouton rouge : l'animal quitte le jardin et revient dans l'inventaire
			row.Info.Size = UDim2.new(1, -190, 0, 22)
			local unequip = Instance.new("TextButton")
			unequip.Name = "Unequip"
			unequip.AnchorPoint = Vector2.new(1, 0.5)
			unequip.Position = UDim2.new(1, -8, 0.5, 0)
			unequip.Size = UDim2.fromOffset(84, 28)
			row.PetName.Size = UDim2.new(1, -172, 0, row.PetName.Size.Y.Offset) -- le nom ne passe pas sous le bouton
			row.PetName.TextXAlignment = Enum.TextXAlignment.Left
			unequip.BackgroundColor3 = Color3.fromRGB(225, 45, 55) -- rouge uni (un dégradé colorerait aussi le texte)
			unequip.BorderSizePixel = 0
			unequip.AutoButtonColor = false
			unequip.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
			unequip.Text = "Unequip"
			unequip.TextSize = 14
			unequip.TextColor3 = Color3.new(1, 1, 1)
			unequip.ZIndex = row.ZIndex + 2
			local textStroke = Instance.new("UIStroke")
			textStroke.Thickness = 2
			textStroke.Color = Color3.new(0, 0, 0)
			textStroke.Parent = unequip
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 2)
			corner.Parent = unequip
			local border = Instance.new("UIStroke")
			border.Thickness = 2.5
			border.Color = Color3.new(0, 0, 0)
			border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			border.Parent = unequip
			local petId = pet.Id
			unequip.Activated:Connect(function() eggRemotes.PetAction:FireServer("PickUp", petId) end)
			unequip.Parent = row
			row.Parent = list
		end
	end
	emptyLabel.Text = "Place pets in your garden to see them here"
	emptyLabel.Visible = #pets == 0
end

-- nom affiché d'un oeuf posé ou d'une plante en terre
local function describe(model, isEgg)
	if isEgg then
		local info = Config.Eggs[model.Name]
		local name = info and info.Name or model.Name
		local mutation = model:GetAttribute("Mutation")
		return "Egg", mutation and (mutation .. " " .. name) or name, mutation
	end
	return "Plant", model:GetAttribute("Title") or model.Name, model:GetAttribute("Mutation")
end

local function refreshTimers()
	local now = workspace:GetServerTimeNow()
	local seen, count = {}, 0
	for _, entry in {{placedEggs, true}} do -- plus de plantes : seulement les oeufs
		for _, model in entry[1]:GetChildren() do
			local readyAt = model:GetAttribute("ReadyAt")
			if model:GetAttribute("Owner") == player.UserId and readyAt then
				seen[model] = true
				local row = timerRows[model]
				if not row then
					local kind, name, mutation = describe(model, entry[2])
					row = timerRowTemplate:Clone()
					row.Kind.Text = kind
					row.ItemName.Text = name
					styleMutation(row.ItemName, mutation)
					row.Parent = list
					timerRows[model] = row
				end
				local remaining = readyAt - now
				row.LayoutOrder = math.max(0, math.floor(remaining)) -- le plus proche d'être prêt en premier
				row.Time.Text = remaining > 0 and Config.FormatTime(remaining) or "Ready!"
				row.Time.TextColor3 = remaining > 0 and Color3.new(1, 1, 1) or READY_COLOR
				count += 1
			end
		end
	end
	for model, row in timerRows do
		if not seen[model] then
			row:Destroy()
			timerRows[model] = nil
		end
	end
	emptyLabel.Text = "Place an egg to see its timer"
	emptyLabel.Visible = count == 0
end

local function render()
	tabs.PetsTab.Shade.Color = currentTab == "Pets" and TAB_ON_COLOR or TAB_OFF_COLOR
	tabs.TimersTab.Shade.Color = currentTab == "Timers" and TAB_ON_COLOR or TAB_OFF_COLOR
	if currentTab == "Pets" then
		renderPets()
	else
		clearList()
		refreshTimers()
	end
end

tabs.PetsTab.Activated:Connect(function() currentTab = "Pets"; render() end)
tabs.TimersTab.Activated:Connect(function() currentTab = "Timers"; render() end)

eggRemotes:WaitForChild("InventoryUpdated").OnClientEvent:Connect(function(inventory)
	table.clear(pets)
	for _, pet in inventory.Pets do
		if pet.Placed then table.insert(pets, pet) end
	end
	table.sort(pets, function(a, b)
		return Config.GetIncome(a.Pet, a.Kg, a.Mutation, a.Level) > Config.GetIncome(b.Pet, b.Kg, b.Mutation, b.Level)
	end)
	if currentTab == "Pets" then renderPets() end
end)

render()
eggRemotes:WaitForChild("PetAction"):FireServer("Sync")

task.spawn(function()
	while true do
		if open and currentTab == "Timers" then refreshTimers() end
		task.wait(REFRESH)
	end
end)

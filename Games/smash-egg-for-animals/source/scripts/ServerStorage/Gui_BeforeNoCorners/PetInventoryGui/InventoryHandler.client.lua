-- Inventaire : onglets Animaux, Œufs, Graines, Plantes + mode Supprimer
--   Animaux : clic = poser dans le jardin / ranger        Œufs    : clic = prendre en main pour le poser
--   Graines : clic = prendre le sachet en main            Plantes : clic = prendre en main pour nourrir un animal
--   Supprimer : clic sur le bouton, clic sur les objets à jeter, puis reclic sur le bouton pour confirmer
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")

local system = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(system:WaitForChild("EggConfig"))
local remotes = system:WaitForChild("Remotes")
local petTemplates = system:WaitForChild("Pets")
local eggTemplates = system:WaitForChild("EggModels")

local plantSystem = ReplicatedStorage:WaitForChild("PlantSystem")
local PlantConfig = require(plantSystem:WaitForChild("PlantConfig"))
local plantRemotes = plantSystem:WaitForChild("Remotes")
local cropTemplates = plantSystem:WaitForChild("CropModels")

local player = Players.LocalPlayer
local gui = script.Parent
local main = gui:WaitForChild("Main")
local header = main:WaitForChild("Header")
local grid = main:WaitForChild("Grid")
local counter = header:WaitForChild("Counter")
local hint = main:WaitForChild("Hint")
local emptyLabel = main:WaitForChild("Empty")
local tabs = main:WaitForChild("Tabs")
local toast = gui:WaitForChild("Toast")
local slotTemplate = script:WaitForChild("SlotTemplate")
local placeBestButton = main:WaitForChild("PlaceBest")
local deleteButton = main:WaitForChild("Delete")

local TOGGLE_KEY = Enum.KeyCode.B
local PLACED_COLOR = Color3.fromRGB(124, 255, 138)
local INK_COLOR = Color3.fromRGB(0, 0, 0) -- contour noir des cartes
local SELECTED_COLOR = Color3.fromRGB(255, 60, 60)
local TAB_ON_COLOR = ColorSequence.new(Color3.fromRGB(255, 236, 120), Color3.fromRGB(245, 170, 40))
local TAB_OFF_COLOR = ColorSequence.new(Color3.fromRGB(104, 108, 120), Color3.fromRGB(56, 59, 68))
local DELETE_IDLE_COLOR = ColorSequence.new(Color3.fromRGB(255, 130, 120), Color3.fromRGB(214, 56, 66))
local DELETE_ARMED_COLOR = ColorSequence.new(Color3.fromRGB(190, 40, 50), Color3.fromRGB(110, 10, 24))
local TOAST_TIME = 3
local TAB_BUTTONS = {Pets = "PetsTab", Eggs = "EggsTab"} -- les graines et les plantes ont été retirées du jeu

local isOwner = table.find(Config.OwnerUserIds, player.UserId) ~= nil
local inventory = {Pets = {}, Eggs = {}, PlacedEggs = 0}
local plants = {Seeds = {}, Crops = {}, Planted = 0}
local currentTab = "Pets"
local deleteMode = false
local selected = {} -- [clé] = {Kind = "Pets" | "Eggs" | "Seeds" | "Crops", Value = id ou nom}

local render -- défini plus bas

local toastId = 0
local function showToast(text)
	toastId += 1
	local id = toastId
	toast.Text = text
	toast.Visible = true
	task.delay(TOAST_TIME, function()
		if toastId == id then toast.Visible = false end
	end)
end

local function countSelected()
	local n = 0
	for _ in selected do n += 1 end
	return n
end

local function refreshDeleteButton()
	local n = countSelected()
	deleteButton.Shade.Color = deleteMode and DELETE_ARMED_COLOR or DELETE_IDLE_COLOR
	if not deleteMode then
		deleteButton.Text = "Delete"
	elseif n == 0 then
		deleteButton.Text = "Cancel"
	else
		deleteButton.Text = "Confirm (" .. n .. ")"
	end
end

local function fillViewport(view, template, mutation)
	if not template then return end
	local model = template:Clone()
	Config.ApplyMutation(model, mutation)
	model:PivotTo(CFrame.new())
	model.Parent = view
	local cf, size = model:GetBoundingBox()
	local camera = Instance.new("Camera")
	camera.FieldOfView = 40
	local distance = math.max(size.X, size.Y, size.Z) * 1.7
	camera.CFrame = CFrame.lookAt(cf.Position + Vector3.new(0.7, 0.35, 1).Unit * distance, cf.Position)
	camera.Parent = view
	view.CurrentCamera = camera
end

-- nom coloré selon la mutation (couleur fixe ou arc-en-ciel animé)
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

local searchText = "" -- texte de la case Search, en minuscules
-- item = {Kind, Value, Title, Subtitle, Rarity, Detail, Template, Mutation, Placed, Action}
local function makeSlot(index, item)
	if searchText ~= "" and not string.find(string.lower(item.Title), searchText, 1, true) then return end
	local key = item.Kind .. ":" .. tostring(item.Value)
	local slot = slotTemplate:Clone()
	slot.Name = "Slot"
	slot.LayoutOrder = index
	slot:SetAttribute("Kind", item.Kind) -- lus par la barre de raccourcis pour le glisser-déposer
	slot:SetAttribute("ItemId", item.Value)
	slot.PetName.Text = item.Title
	slot.Rarity.Text = item.Subtitle
	slot.Kg.Text = item.Detail
	slot.Placed.Visible = item.Placed == true
	styleMutation(slot.PetName, item.Mutation)
	local gradientColor = Config.Gradients[item.Rarity]
	if gradientColor then
		slot.Rarity.UIGradient.Color = gradientColor
		slot.Rarity.UIGradient.Enabled = true
		CollectionService:AddTag(slot.Rarity.UIGradient, "AnimatedGradient")
	end

	local function refreshOutline()
		if selected[key] then
			slot.Outline.Color, slot.Outline.Thickness = SELECTED_COLOR, 5
		else
			slot.Outline.Color, slot.Outline.Thickness = item.Placed and PLACED_COLOR or INK_COLOR, item.Placed and 4 or 3
		end
	end
	refreshOutline()

	slot.Activated:Connect(function()
		if deleteMode then -- en mode Supprimer, un clic coche / décoche l'objet
			selected[key] = if selected[key] then nil else {Kind = item.Kind, Value = item.Value}
			refreshOutline()
			refreshDeleteButton()
		else
			item.Action()
		end
	end)

	fillViewport(slot.View, item.Template, item.Mutation)
	slot.Visible = true
	slot.Parent = grid
end

local function withMutation(mutationName, name)
	return mutationName and (mutationName .. " " .. name) or name
end

local function renderPets()
	local placed = 0
	for index, pet in inventory.Pets do
		local info = Config.Pets[pet.Pet]
		if pet.Placed then placed += 1 end
		if info and not pet.Placed then -- les animaux posés ne sont plus dans la liste : on les reprend depuis le panneau du jardin
			local income = Config.GetIncome(pet.Pet, pet.Kg, pet.Mutation, pet.Level)
			makeSlot(index, {
				Kind = "Pets", Value = pet.Id, Placed = pet.Placed,
				Title = (pet.Trait and (pet.Trait .. " ") or "") .. withMutation(pet.Mutation, info.Name),
				Subtitle = info.Rarity,
				Rarity = info.Rarity,
				Detail = Config.FormatKg(pet.Kg) .. " · " .. Config.FormatMoney(income) .. "/s",
				Template = petTemplates:FindFirstChild(pet.Pet), Mutation = pet.Mutation,
				Action = function() remotes.PetAction:FireServer(pet.Placed and "PickUp" or "EquipPet", pet.Id) end,
			})
		end
	end
	counter.Text = string.format("Pets: %d/%d   Placed: %d/%d", #inventory.Pets - placed, Config.MaxInventory, placed, ((Config.BasePlaced or 5) + (player:GetAttribute("GardenLevel") or 0)))
	hint.Text = "Click a pet to hold it, then click the ground of your garden to place it · placed pets leave the inventory: press Unequip in the garden panel (arrow on the right) to get them back"
	emptyLabel.Text = "Hatch an egg to get a pet!"
	emptyLabel.Visible = #inventory.Pets - placed <= 0
end

local function renderEggs()
	for index, egg in inventory.Eggs do
		local info = Config.Eggs[egg.Egg]
		if info then
			local cooldown = isOwner and Config.OwnerCooldown or info.Cooldown
			makeSlot(index, {
				Kind = "Eggs", Value = egg.Id,
				Title = info.Name, Subtitle = "Hatches in " .. Config.FormatTime(cooldown), Rarity = info.Rarity,
				Detail = Config.FormatKg(egg.Kg),
				Template = eggTemplates:FindFirstChild(egg.Egg),
				Action = function()
					remotes.PetAction:FireServer("EquipEgg", egg.Id)
					main.Visible = false -- on ferme pour choisir l'emplacement
				end,
			})
		end
	end
	counter.Text = string.format("Eggs: %d/%d   Placed: %d/%d", #inventory.Eggs, Config.MaxEggs, inventory.PlacedEggs, Config.MaxPlacedEggs)
	hint.Text = "Click an egg to hold it, then click in your garden to place it"
	emptyLabel.Text = "No eggs yet!"
	emptyLabel.Visible = #inventory.Eggs == 0
end

local function renderSeeds()
	local total = 0
	for index, entry in plants.Seeds do
		local info = PlantConfig.Seeds[entry.Seed]
		if info then
			total += entry.Count
			makeSlot(index, {
				Kind = "Seeds", Value = entry.Seed,
				Title = info.Name .. " Seed",
				-- le temps dépend du poids de la plante : on ne l'affiche que pour le créateur (toujours 5 s)
				Subtitle = isOwner and ("Grows in " .. Config.FormatTime(PlantConfig.OwnerGrowTime)) or info.Rarity,
				Rarity = info.Rarity, Detail = "x" .. entry.Count,
				Template = cropTemplates:FindFirstChild(entry.Seed),
				Action = function()
					plantRemotes.SeedAction:FireServer("Equip", entry.Seed)
					main.Visible = false -- on ferme pour aller planter
				end,
			})
		end
	end
	counter.Text = string.format("Seeds: %d/%d   Planted: %d/%d", total, PlantConfig.MaxSeeds, plants.Planted, PlantConfig.MaxPlanted)
	hint.Text = "Click a seed to hold it, then click in the plants area of your garden"
	emptyLabel.Text = "Buy seeds at the Seed Shop!"
	emptyLabel.Visible = #plants.Seeds == 0
end

local function renderCrops()
	for index, crop in plants.Crops do
		local info = PlantConfig.Seeds[crop.Crop]
		if info then
			makeSlot(index, {
				Kind = "Crops", Value = crop.Id,
				Title = withMutation(crop.Mutation, info.Name), Subtitle = info.Rarity, Rarity = info.Rarity,
				Detail = Config.FormatKg(crop.Kg) .. " · " .. PlantConfig.GetXp(crop.Crop, crop.Kg, crop.Mutation) .. " XP",
				Template = cropTemplates:FindFirstChild(crop.Crop), Mutation = crop.Mutation,
				Action = function()
					plantRemotes.SeedAction:FireServer("EquipCrop", crop.Id)
					main.Visible = false
					showToast("Walk up to one of your pets and feed it!")
				end,
			})
		end
	end
	counter.Text = string.format("Crops: %d/%d", #plants.Crops, PlantConfig.MaxCrops)
	hint.Text = "Click a crop to hold it, then feed one of your pets to give it XP"
	emptyLabel.Text = "Harvest plants in your garden!"
	emptyLabel.Visible = #plants.Crops == 0
end

local RENDERERS = {Pets = renderPets, Eggs = renderEggs, Seeds = renderSeeds, Crops = renderCrops}

function render()
	for _, child in grid:GetChildren() do
		if child:IsA("TextButton") then child:Destroy() end
	end
	for tab, buttonName in TAB_BUTTONS do
		tabs[buttonName].Shade.Color = currentTab == tab and TAB_ON_COLOR or TAB_OFF_COLOR
	end
	placeBestButton.Visible = currentTab == "Pets" and not deleteMode
	header.Title.Text = currentTab == "Pets" and "All Pets" or "All Eggs"
	RENDERERS[currentTab]()
	if deleteMode then hint.Text = "Click the items to delete, then press Confirm. Warning: this is permanent!" end
	refreshDeleteButton()
end

local function setDeleteMode(on)
	deleteMode = on
	table.clear(selected)
	render()
end

-- 1er clic : active le mode ; 2e clic : supprime ce qui est coché (ou annule si rien n'est coché)
local function onDeleteClicked()
	if not deleteMode then
		setDeleteMode(true)
		return
	end
	local pets, eggs, seeds, crops = {}, {}, {}, {}
	local lists = {Pets = pets, Eggs = eggs, Seeds = seeds, Crops = crops}
	for _, entry in selected do table.insert(lists[entry.Kind], entry.Value) end
	if #pets + #eggs > 0 then remotes.PetAction:FireServer("Delete", {Pets = pets, Eggs = eggs}) end
	if #seeds + #crops > 0 then plantRemotes.SeedAction:FireServer("Delete", {Seeds = seeds, Crops = crops}) end
	local n = #pets + #eggs + #seeds + #crops
	if n > 0 then showToast(n .. " item(s) deleted") end
	setDeleteMode(false)
end

local function setTab(tab)
	currentTab = tab
	render()
end

local function toggle()
	main.Visible = not main.Visible
	if not main.Visible and deleteMode then setDeleteMode(false) end
end

for tab, buttonName in TAB_BUTTONS do
	tabs:WaitForChild(buttonName).Activated:Connect(function() setTab(tab) end)
end
deleteButton.Activated:Connect(onDeleteClicked)
local searchBox = header:WaitForChild("Search")
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	searchText = string.lower(searchBox.Text)
	render()
end)
placeBestButton.Activated:Connect(function() remotes.PetAction:FireServer("PlaceBest") end)
header:WaitForChild("Close").Activated:Connect(toggle)
UserInputService.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == TOGGLE_KEY then toggle() end
end)

-- bouton d'ouverture : l'icône de InventoryButtonGui
local playerGui = player:WaitForChild("PlayerGui")
playerGui:WaitForChild("InventoryButtonGui"):WaitForChild("IconButton").Activated:Connect(toggle)
ReplicatedStorage:WaitForChild("UiSignals"):WaitForChild("ToggleInventory").Event:Connect(toggle) -- bouton de la barre du haut

remotes:WaitForChild("InventoryUpdated").OnClientEvent:Connect(function(newInventory)
	inventory = newInventory
	render()
end)
plantRemotes:WaitForChild("SeedsUpdated").OnClientEvent:Connect(function(state)
	plants = state
	render()
end)
remotes:WaitForChild("Notify").OnClientEvent:Connect(showToast)

render()
remotes:WaitForChild("PetAction"):FireServer("Sync")
plantRemotes:WaitForChild("SeedAction"):FireServer("Sync")

player:GetAttributeChangedSignal("GardenLevel"):Connect(function() render() end)

-- Barre d'objets en bas de l'écran : 10 cases (6 sur mobile) avec les graines puis les oeufs.
-- Clic ou touche 1-0 = prendre l'objet en main / le ranger.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local eggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(eggSystem:WaitForChild("EggConfig"))
local eggRemotes = eggSystem:WaitForChild("Remotes")
local eggTemplates = eggSystem:WaitForChild("EggModels")

local plantSystem = ReplicatedStorage:WaitForChild("PlantSystem")
local PlantConfig = require(plantSystem:WaitForChild("PlantConfig"))
local plantRemotes = plantSystem:WaitForChild("Remotes")
local cropTemplates = plantSystem:WaitForChild("CropModels")

local player = Players.LocalPlayer
local gui = script.Parent
local dock = gui:WaitForChild("Dock")
local bar = dock:WaitForChild("Bar")
local slotTemplate = script:WaitForChild("SlotTemplate")

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local SLOT_COUNT = isMobile and 6 or 10
local SLOT_SIZE = isMobile and 54 or 62
local SLOT_GAP = 6
local KEYS = {Enum.KeyCode.One, Enum.KeyCode.Two, Enum.KeyCode.Three, Enum.KeyCode.Four, Enum.KeyCode.Five,
	Enum.KeyCode.Six, Enum.KeyCode.Seven, Enum.KeyCode.Eight, Enum.KeyCode.Nine, Enum.KeyCode.Zero}
local EQUIPPED_COLOR = Color3.fromRGB(124, 255, 138)
local INK_COLOR = Color3.fromRGB(10, 10, 12)
local EMPTY_TRANSPARENCY = 0.55
local FILLED_TRANSPARENCY = 0.3
local EQUIPPED_SCALE = 1.14
local ICON_OFFSET = 58 -- distance entre la barre et l'icône d'inventaire
local ICON_WIDTH, ICON_HEIGHT = 80, 60
local READY_REFRESH = 0.5

-- la barre remplace le sac par défaut de Roblox
task.spawn(function()
	while true do
		pcall(function()
			if StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) then StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false) end
		end)
		task.wait(0.5)
	end
end)

local slots = {} -- {Button, Key, Item}
local eggs, seeds = {}, {}
local pets = {}      -- animaux de l'inventaire
local assigned = {}  -- [case] = Id de l'animal glissé dans cette case
local petTemplates = eggSystem:WaitForChild("Pets")
local hammerSystem = ReplicatedStorage:WaitForChild("HammerSystem")
local hammerModels = hammerSystem:WaitForChild("Models")

-- objet tenu en main : "E<id>" pour un oeuf, "S<nom>" pour un sachet de graines
local function getEquippedKey()
	local character = player.Character
	if not character then return nil end
	for _, child in character:GetChildren() do
		if child:IsA("Tool") then
			if child:GetAttribute("Hammer") then return "H" .. child:GetAttribute("Hammer") end
			if child:GetAttribute("Bat") then return "B" end
			if child:GetAttribute("PetId") then return "P" .. child:GetAttribute("PetId") end
			if child:GetAttribute("EggId") then return "E" .. child:GetAttribute("EggId") end
			if child:GetAttribute("SeedName") then return "S" .. child:GetAttribute("SeedName") end
		end
	end
	return nil
end

local function fillViewport(view, template)
	view:ClearAllChildren()
	if not template then return end
	local model = template:Clone()
	model:PivotTo(CFrame.new())
	model.Parent = view
	local cf, size = model:GetBoundingBox()
	local camera = Instance.new("Camera")
	camera.FieldOfView = 40
	local distance = math.max(size.X, size.Y, size.Z) * 1.5
	camera.CFrame = CFrame.lookAt(cf.Position + Vector3.new(0.5, 0.3, 1).Unit * distance, cf.Position)
	camera.Parent = view
	view.CurrentCamera = camera
end

local function refreshEquipped()
	local equipped = getEquippedKey()
	for _, slot in slots do
		local on = (slot.Key ~= nil and slot.Key == equipped) or (slot.Item ~= nil and slot.Item.Placed == true) -- vert = posé dans le jardin
		slot.Button.Outline.Color = on and EQUIPPED_COLOR or INK_COLOR
		TweenService:Create(slot.Button.UIScale, TweenInfo.new(0.12), {Scale = on and EQUIPPED_SCALE or 1}):Play()
	end
end

local function refresh()
	-- une case par sorte de graine d'abord (il y en a peu), puis les oeufs dans les cases restantes
	local items = {}
	for _, entry in {} do -- graines retirées du jeu
		table.insert(items, {Key = "S" .. entry.Seed, Kind = "Seed", Seed = entry.Seed, Template = cropTemplates:FindFirstChild(entry.Seed), Text = PlantConfig.Seeds[entry.Seed].Name, Count = "x" .. entry.Count})
	end
	-- les œufs ne vont plus dans l'inventaire : chaque case montre l'animal qu'on y a glissé
	local byId = {}
	for _, pet in pets do byId[pet.Id] = pet end
	-- case 1 : le marteau (clic ou touche 1 = le sortir / le ranger) ; les animaux vont dans les cases suivantes
	local hammer = player:GetAttribute("EquippedHammer") or player:GetAttribute("Hammer") or 1 -- le marteau tenu (pas forcément le meilleur)
	assigned[1] = nil
	items[1] = {Key = "H" .. hammer, Kind = "Hammer", Template = hammerModels:FindFirstChild("Tier" .. hammer), Text = "", Count = ""}
	-- case 2 : la batte
	assigned[2] = nil
	items[2] = {Key = "B", Kind = "Bat", Template = hammerModels:FindFirstChild("Bat"), Text = "", Count = ""}
	for index = 3, SLOT_COUNT do
		local pet = assigned[index] and byId[assigned[index] ]
		if assigned[index] and (not pet or pet.Placed) then assigned[index], pet = nil, nil end -- animal supprimé, ou posé dans le jardin : il quitte la barre (on le reprend avec Unequip dans le panneau du jardin)
		if pet then
			items[index] = {Key = "P" .. pet.Id .. (pet.Placed and "+" or ""), Kind = "Pet", Id = pet.Id, Placed = pet.Placed, Template = petTemplates:FindFirstChild(pet.Pet), Text = Config.FormatKg(pet.Kg), Count = ""}
		end
	end
	for index, slot in slots do
		local item = items[index]
		local key = item and item.Key
		if slot.Key ~= key then
			slot.Key = key
			fillViewport(slot.Button.View, item and item.Template)
		end
		slot.Item = item
		slot.Button.Kg.Text = item and item.Text or ""
		slot.Button.Count.Text = item and item.Count or ""
		slot.Button.BackgroundTransparency = item and FILLED_TRANSPARENCY or EMPTY_TRANSPARENCY
	end
	refreshEquipped()
end

local function activate(index)
	local slot = slots[index]
	local item = slot and slot.Item
	if not item then return end
	if item.Kind == "Hammer" or item.Kind == "Bat" then
		hammerSystem.Toggle:FireServer(item.Kind)
		return
	end
	if item.Kind == "Pet" then -- clic ou touche : pose l'animal dans le jardin / le reprend
		eggRemotes.PetAction:FireServer(item.Placed and "PickUp" or "EquipPet", item.Id) -- pas posé : on le prend en main
		return
	end
	local equipped = getEquippedKey() == item.Key
	if item.Kind == "Egg" then
		if equipped then eggRemotes.PetAction:FireServer("UnequipEgg") else eggRemotes.PetAction:FireServer("EquipEgg", item.Id) end
	else
		if equipped then plantRemotes.SeedAction:FireServer("Unequip") else plantRemotes.SeedAction:FireServer("Equip", item.Seed) end
	end
end

for index = 1, SLOT_COUNT do
	local button = slotTemplate:Clone()
	button.Name = "Slot" .. index
	button.LayoutOrder = index
	button.Size = UDim2.fromOffset(SLOT_SIZE, SLOT_SIZE)
	button.Key.Text = tostring(index % 10)
	button.Key.Visible = not isMobile
	button.Visible = true
	button.Parent = bar
	slots[index] = {Button = button}
	button.Activated:Connect(function() activate(index) end)
end

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	local index = table.find(KEYS, input.KeyCode)
	if index and index <= SLOT_COUNT then activate(index) end
end)

-- l'icône d'inventaire se place juste à gauche de la barre et suit sa mise à l'échelle (UIScaler)
task.spawn(function()
	local icon = player:WaitForChild("PlayerGui"):WaitForChild("InventoryButtonGui"):WaitForChild("IconButton")
	local dockScale = dock:WaitForChild("AutoScale")
	local width = SLOT_COUNT * SLOT_SIZE + (SLOT_COUNT - 1) * SLOT_GAP
	local function place()
		local s = dockScale.Scale
		icon.AnchorPoint = Vector2.new(0.5, 0.5)
		icon.Size = UDim2.fromOffset(ICON_WIDTH * s, ICON_HEIGHT * s)
		icon.Position = UDim2.new(0.5, -(width / 2 + ICON_OFFSET) * s, 1, -(10 + SLOT_SIZE / 2 * s + 6 * s))
	end
	dockScale:GetPropertyChangedSignal("Scale"):Connect(place)
	place()
end)

local function watchCharacter(character)
	character.ChildAdded:Connect(refreshEquipped)
	character.ChildRemoved:Connect(refreshEquipped)
	refreshEquipped()
end
player.CharacterAdded:Connect(watchCharacter)
if player.Character then watchCharacter(player.Character) end

-- un animal qu'on vient d'avoir (attrapé, acheté, donné...) va tout seul dans la barre : case 3, puis 4, 5... jusqu'à 0.
-- (Au premier chargement, les cases libres se remplissent aussi avec les animaux de l'inventaire, dans l'ordre.)
local knownPets
local function autoSlot(list)
	local fresh = {}
	for _, pet in list do
		if not pet.Placed and (not knownPets or not knownPets[pet.Id]) then table.insert(fresh, pet.Id) end
	end
	knownPets = {}
	for _, pet in list do knownPets[pet.Id] = true end
	for _, id in fresh do
		local already = false
		for index = 3, SLOT_COUNT do if assigned[index] == id then already = true break end end
		if not already then
			for index = 3, SLOT_COUNT do
				if not assigned[index] then assigned[index] = id break end
			end
		end
	end
end
eggRemotes:WaitForChild("InventoryUpdated").OnClientEvent:Connect(function(inventory)
	eggs = inventory.Eggs
	pets = inventory.Pets or {}
	autoSlot(pets)
	refresh()
end)
plantRemotes:WaitForChild("SeedsUpdated").OnClientEvent:Connect(function(state)
	seeds = state.Seeds
	refresh()
end)
refresh()
player:GetAttributeChangedSignal("Hammer"):Connect(refresh)
player:GetAttributeChangedSignal("EquippedHammer"):Connect(refresh)
eggRemotes:WaitForChild("PetAction"):FireServer("Sync")
plantRemotes:WaitForChild("SeedAction"):FireServer("Sync")

---------------------------------------------------------------- Boutons "Tout ouvrir" et "Tout récolter"
-- visibles dès qu'au moins un de mes oeufs / une de mes plantes est prêt
local hatchAllButton = dock:WaitForChild("HatchAll")
local harvestAllButton = dock:WaitForChild("HarvestAll")
local placedEggs = workspace:WaitForChild("PlacedEggs")
local placedPlants = workspace:WaitForChild("PlacedPlants")

hatchAllButton.Activated:Connect(function() eggRemotes.PetAction:FireServer("HatchAll") end)
harvestAllButton.Activated:Connect(function() plantRemotes.SeedAction:FireServer("HarvestAll") end)

local function countReady(folder, now)
	local ready = 0
	for _, item in folder:GetChildren() do
		local readyAt = item:GetAttribute("ReadyAt")
		if item:GetAttribute("Owner") == player.UserId and readyAt and readyAt <= now then ready += 1 end
	end
	return ready
end

task.spawn(function()
	while true do
		local now = workspace:GetServerTimeNow()
		local readyEggs, readyPlants = countReady(placedEggs, now), countReady(placedPlants, now)
		hatchAllButton.Visible = readyEggs > 0
		hatchAllButton.Text = "Open All (" .. readyEggs .. ")"
		harvestAllButton.Visible = false -- plantes retirées du jeu
		harvestAllButton.Text = "Harvest All (" .. readyPlants .. ")"
		task.wait(READY_REFRESH)
	end
end)

---------------------------------------------------------------- Glisser un animal de l'inventaire jusqu'à une case (1 à 0)
-- On reste appuyé sur une carte de l'inventaire : elle suit le pointeur, on la lâche sur la case voulue.
-- Clic droit sur une case = la vider.
do
	local GuiService = game:GetService("GuiService")
	local RunService = game:GetService("RunService")
	local playerGui = player:WaitForChild("PlayerGui")
	local grid = playerGui:WaitForChild("PetInventoryGui"):WaitForChild("Main"):WaitForChild("Grid")
	local dragGui = Instance.new("ScreenGui")
	dragGui.Name = "HotbarDragGui"
	dragGui.ResetOnSpawn = false
	dragGui.DisplayOrder = 60
	dragGui.IgnoreGuiInset = true
	dragGui.Parent = playerGui

	local dragging -- {Id, Ghost}
	local held     -- carte sur laquelle on appuie

	local function slotAt(point)
		local inset = GuiService:GetGuiInset()
		for index, slot in slots do
			local position, size = slot.Button.AbsolutePosition + inset, slot.Button.AbsoluteSize
			if point.X >= position.X - 6 and point.X <= position.X + size.X + 6 and point.Y >= position.Y - 14 and point.Y <= position.Y + size.Y + 14 then
				return index
			end
		end
		return nil
	end

	local function highlight(index)
		for i, slot in slots do
			slot.Button.Outline.Thickness = i == index and 6 or 3
		end
	end

	local function startDrag(card)
		local id = card:GetAttribute("ItemId")
		if dragging or card:GetAttribute("Kind") ~= "Pets" or not id then return end
		local ghost = Instance.new("Frame")
		ghost.AnchorPoint = Vector2.new(0.5, 0.5)
		ghost.Size = UDim2.fromOffset(74, 74)
		ghost.BackgroundColor3 = Color3.fromRGB(255, 236, 190)
		ghost.BorderSizePixel = 0
		ghost.Rotation = -8
		local outline = Instance.new("UIStroke")
		outline.Thickness = 4
		outline.Parent = ghost
		local view = card:FindFirstChild("View")
		if view then
			local copy = view:Clone()
			copy.Position, copy.Size = UDim2.fromScale(0, 0), UDim2.fromScale(1, 1)
			copy.CurrentCamera = copy:FindFirstChildOfClass("Camera")
			copy.Parent = ghost
		end
		ghost.Position = UDim2.fromOffset(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
		ghost.Parent = dragGui
		grid.ScrollingEnabled = false
		dragging = {Id = id, Ghost = ghost}
	end

	local function watch(card)
		if not card:IsA("GuiButton") then return end
		card.InputBegan:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
			held = card
			local start = UserInputService:GetMouseLocation()
			task.spawn(function() -- on prend la carte si on reste appuyé, ou dès qu'on la tire
				local t0 = os.clock()
				while held == card and not dragging do
					if os.clock() - t0 > 0.22 or (UserInputService:GetMouseLocation() - start).Magnitude > 12 then
						startDrag(card)
						break
					end
					task.wait()
				end
			end)
		end)
	end
	for _, card in grid:GetChildren() do watch(card) end
	grid.ChildAdded:Connect(watch)

	RunService.RenderStepped:Connect(function()
		if dragging then
			local point = UserInputService:GetMouseLocation()
			dragging.Ghost.Position = UDim2.fromOffset(point.X, point.Y)
			highlight(slotAt(point))
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
		held = nil
		if dragging then
			local index = slotAt(UserInputService:GetMouseLocation())
			if index and index <= 2 then index = nil end -- cases 1 et 2 : marteau et batte
			if index then
				for other, id in assigned do -- un animal n'occupe qu'une case
					if id == dragging.Id then assigned[other] = nil end
				end
				assigned[index] = dragging.Id
			end
			dragging.Ghost:Destroy()
			dragging = nil
			grid.ScrollingEnabled = true
			highlight(nil)
			refresh()
		end
	end)

	for index, slot in slots do
		slot.Button.MouseButton2Click:Connect(function()
			assigned[index] = nil
			refresh()
		end)
	end
end

-- Animal pris en main (clic dans l'inventaire) : s'il n'est dans aucune case de la barre, il va dans la première case libre
-- après le marteau et la batte : 3, 4, 5, 6, 7, 8, 9 puis 0 (toutes pleines : il remplace celui de la case 3)
local function onHeldPet(tool)
	if not tool:IsA("Tool") then return end
	local id = tool:GetAttribute("PetId")
	if id then
		local already, first = false, nil
		for index = 3, SLOT_COUNT do
			if assigned[index] == id then already = true break end
			if not first and not assigned[index] then first = index end
		end
		if not already then
			assigned[first or 3] = id
			refresh()
		end
	end
	task.defer(refreshEquipped)
	tool.AncestryChanged:Connect(function() task.defer(refreshEquipped) end)
end
local function watchHeld(character)
	character.ChildAdded:Connect(onHeldPet)
	for _, child in character:GetChildren() do onHeldPet(child) end
end
player.CharacterAdded:Connect(watchHeld)
if player.Character then watchHeld(player.Character) end

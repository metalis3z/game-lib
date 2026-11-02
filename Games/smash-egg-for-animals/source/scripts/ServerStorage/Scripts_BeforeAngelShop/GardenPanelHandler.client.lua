-- Deux boutons au bord droit de l'écran : œufs et animaux. Chacun ouvre son panneau.
--   Animaux : ceux qui sont dans le jardin (photo, nom, revenu, Unequip), « +1 Slot » (agrandit le jardin) et « Equip best ».
--   Œufs    : ceux qui couvent dans le jardin avec leur minuteur, et « Place all » (pose tous les œufs de l'inventaire).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")

local eggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(eggSystem:WaitForChild("EggConfig"))
local remotes = eggSystem:WaitForChild("Remotes")
local petTemplates = eggSystem:WaitForChild("Pets")
local eggTemplates = eggSystem:WaitForChild("EggModels")
local player = Players.LocalPlayer
local gui = script.Parent

local rgb = Color3.fromRGB
local BLACK, WHITE = Color3.new(0, 0, 0), Color3.new(1, 1, 1)
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local STUDS = "rbxassetid://7447638591"
local LATTICE = "rbxassetid://71475990158029"   -- losanges (image du jeu)
local EGG_ICON = "rbxassetid://126881998137257"
local PAW_ICON = "rbxthumb://type=Asset&id=128895446491384&w=150&h=150"
local GREEN, RED = rgb(74, 208, 84), rgb(226, 44, 54)
local THEME = {
	Pets = {Main = rgb(214, 132, 60), Dark = rgb(150, 84, 34), Row = rgb(232, 170, 104)},
	Eggs = {Main = rgb(226, 44, 54), Dark = rgb(150, 22, 34), Row = rgb(244, 138, 128)},
}

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function border(o, thickness)
	return new("UIStroke", {Thickness = thickness or 3, Color = BLACK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, o)
end
local function pattern(o, image, tile, transparency)
	return new("ImageLabel", {Name = "Pattern", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = image, ScaleType = Enum.ScaleType.Tile,
		TileSize = UDim2.fromOffset(tile, tile), ImageTransparency = transparency or 0, ZIndex = o.ZIndex}, o)
end
local function label(parent, props)
	local l = new("TextLabel", {BackgroundTransparency = 1, FontFace = FONT, TextColor3 = WHITE, TextScaled = true, ZIndex = parent.ZIndex + 1}, parent)
	for k, v in props do l[k] = v end
	new("UIStroke", {Thickness = 2.5, Color = BLACK}, l)
	return l
end
local function button(parent, text, color, props)
	local b = new("TextButton", {Text = "", AutoButtonColor = true, BackgroundColor3 = color, BorderSizePixel = 0, ZIndex = parent.ZIndex + 1}, parent)
	for k, v in props do b[k] = v end
	border(b, 3)
	pattern(b, STUDS, 30, 0.72)
	label(b, {Name = "Label", Text = text, Position = UDim2.fromScale(0.06, 0.16), Size = UDim2.fromScale(0.88, 0.68), ZIndex = b.ZIndex + 1})
	return b
end

---------------------------------------------------------------- les deux boutons du bord droit
local scale = new("UIScale", {}, gui)
local function fit()
	scale.Scale = math.clamp(workspace.CurrentCamera.ViewportSize.Y / 800, 0.6, 1.1)
end
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fit)
fit()

local dock = new("Frame", {Name = "Dock", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.45, 0), Size = UDim2.fromOffset(78, 168)}, gui)
local function dockButton(name, order, theme, icon)
	local b = new("ImageButton", {Name = name, BackgroundColor3 = theme.Main, BorderSizePixel = 0, AutoButtonColor = true, Image = "",
		Position = UDim2.fromOffset(0, (order - 1) * 90), Size = UDim2.fromOffset(78, 78), ZIndex = 2}, dock)
	border(b, 3.5)
	new("UIStroke", {Thickness = 3, Color = theme.Dark, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), ZIndex = 2}, b))
	pattern(b, LATTICE, 26, 0.25)
	new("ImageLabel", {Name = "Icon", BackgroundTransparency = 1, Image = icon, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.78, 0.78), ZIndex = 4}, b)
	return b
end
local eggButton = dockButton("Eggs", 1, THEME.Eggs, EGG_ICON)
local petButton = dockButton("Pets", 2, THEME.Pets, PAW_ICON)

---------------------------------------------------------------- panneau (un seul, son contenu change)
local panel = new("Frame", {Name = "Panel", BackgroundColor3 = rgb(52, 56, 66), BorderSizePixel = 0, AnchorPoint = Vector2.new(1, 0.5),
	Position = UDim2.new(1, 420, 0.45, 0), Size = UDim2.fromOffset(372, 452), Visible = false}, gui)
border(panel, 4)
pattern(panel, STUDS, 34, 0.86)
local header = new("Frame", {Name = "Header", BackgroundColor3 = THEME.Pets.Main, BorderSizePixel = 0, Position = UDim2.fromOffset(8, 8), Size = UDim2.new(1, -16, 0, 50), ZIndex = 2}, panel)
border(header, 3)
local headerPattern = pattern(header, LATTICE, 24, 0.35)
local countLabel = label(header, {Name = "Count", Text = "", TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(12, 9), Size = UDim2.new(0.5, -8, 1, -18)})
local slotButton = button(header, "+1 Slot", GREEN, {Name = "Slot", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.new(0.5, -8, 1, -14)})
local list = new("ScrollingFrame", {Name = "List", BackgroundColor3 = rgb(34, 36, 44), BorderSizePixel = 0, Position = UDim2.fromOffset(8, 66), Size = UDim2.new(1, -16, 1, -142),
	ScrollBarThickness = 6, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 2}, panel)
border(list, 3)
new("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center}, list)
new("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8)}, list)
local empty = label(panel, {Name = "Empty", Text = "", TextScaled = false, TextSize = 18, TextWrapped = true, Position = UDim2.fromOffset(30, 150), Size = UDim2.new(1, -60, 0, 80), ZIndex = 4})
local action = button(panel, "Equip best", GREEN, {Name = "Action", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -10), Size = UDim2.new(1, -16, 0, 56), ZIndex = 2})

local current -- "Pets", "Eggs" ou nil (fermé)
local pets, inventoryEggs = {}, 0
local rows = {}      -- lignes des œufs : [modèle] = ligne
local SLIDE = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

local function portrait(view, template, mutationName)
	view:ClearAllChildren()
	if not template then return end
	local model = template:Clone()
	Config.ApplyMutation(model, mutationName)
	model:PivotTo(CFrame.new())
	model.Parent = view
	local cf, size = model:GetBoundingBox()
	local camera = new("Camera", {FieldOfView = 40}, view)
	camera.CFrame = CFrame.lookAt(cf.Position + Vector3.new(0.7, 0.35, 1).Unit * math.max(size.X, size.Y, size.Z) * 1.5, cf.Position)
	view.CurrentCamera = camera
end
local function styleName(l, mutationName)
	local mutation = mutationName and Config.GetMutation(mutationName)
	if not mutation then return end
	if mutation.Color then l.TextColor3 = mutation.Color else
		CollectionService:AddTag(new("UIGradient", {Color = Config.Gradients[mutationName]}, l), "AnimatedGradient")
	end
end
local function row(theme, order)
	local r = new("Frame", {BackgroundColor3 = theme.Row, BorderSizePixel = 0, Size = UDim2.new(1, -16, 0, 68), LayoutOrder = order, ZIndex = 3}, list)
	border(r, 3)
	pattern(r, LATTICE, 22, 0.55)
	local view = new("ViewportFrame", {Name = "View", BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.fromOffset(60, 60), ZIndex = 4, Ambient = rgb(220, 220, 220), LightColor = WHITE}, r)
	local name = label(r, {Name = "Title", Text = "", TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(70, 8), Size = UDim2.new(1, -176, 0, 24), ZIndex = 4})
	local info = label(r, {Name = "Info", Text = "", TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = rgb(140, 255, 120), Position = UDim2.fromOffset(70, 36), Size = UDim2.new(1, -176, 0, 22), ZIndex = 4})
	return r, view, name, info
end
local function clear()
	for _, child in list:GetChildren() do if child:IsA("Frame") then child:Destroy() end end
	table.clear(rows)
end

local function maxPets()
	return math.min(Config.MaxPlaced, (Config.BasePlaced or 5) + (player:GetAttribute("GardenLevel") or 0))
end

local function renderPets()
	clear()
	for index, pet in pets do
		local info = Config.Pets[pet.Pet]
		if info then
			local r, view, name, income = row(THEME.Pets, index)
			name.Text = pet.Mutation and (pet.Mutation .. " " .. info.Name) or info.Name
			styleName(name, pet.Mutation)
			income.Text = "(" .. Config.FormatMoney(Config.GetIncome(pet.Pet, pet.Kg, pet.Mutation, pet.Level)) .. "/s)"
			portrait(view, petTemplates:FindFirstChild(pet.Pet), pet.Mutation)
			local unequip = button(r, "Unequip", RED, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(92, 40), ZIndex = 4})
			local id = pet.Id
			unequip.Activated:Connect(function() remotes.PetAction:FireServer("PickUp", id) end)
		end
	end
	countLabel.Text = #pets .. "/" .. maxPets() .. " Active"
	local cost = Config.GardenCosts[(player:GetAttribute("GardenLevel") or 0) + 1]
	slotButton.Visible = cost ~= nil and maxPets() < Config.MaxPlaced
	if cost then
		slotButton.Label.Text = "+1 Slot [" .. Config.FormatMoney(cost) .. "]"
		slotButton.BackgroundColor3 = (player:GetAttribute("Money") or 0) >= cost and GREEN or rgb(178, 180, 188)
	end
	action.Label.Text = "Equip best"
	empty.Text = "No pets in your garden yet.\nPress Equip best!"
	empty.Visible = #pets == 0
end

local placedEggs = workspace:WaitForChild("PlacedEggs")
local function renderEggs()
	local now = workspace:GetServerTimeNow()
	local seen, count = {}, 0
	for _, model in placedEggs:GetChildren() do
		local readyAt = model:GetAttribute("ReadyAt")
		if model:GetAttribute("Owner") == player.UserId and readyAt then
			seen[model] = true
			count += 1
			local entry = rows[model]
			if not entry then
				local r, view, name, info = row(THEME.Eggs, 0)
				local eggInfo = Config.Eggs[model.Name]
				local mutation = model:GetAttribute("Mutation")
				name.Text = (mutation and (mutation .. " ") or "") .. (eggInfo and eggInfo.Name or model.Name)
				styleName(name, mutation)
				name.Size = UDim2.new(1, -80, 0, 24)
				info.Size = UDim2.new(1, -80, 0, 22)
				portrait(view, eggTemplates:FindFirstChild(model.Name), mutation)
				entry = {Row = r, Info = info}
				rows[model] = entry
			end
			local remaining = readyAt - now
			entry.Row.LayoutOrder = math.max(0, math.floor(remaining)) -- le plus proche d'éclore en premier
			entry.Info.Text = remaining > 0 and ("Hatches in " .. Config.FormatTime(remaining)) or "Ready!"
			entry.Info.TextColor3 = remaining > 0 and WHITE or rgb(140, 255, 120)
		end
	end
	for model, entry in rows do
		if not seen[model] then entry.Row:Destroy() rows[model] = nil end
	end
	countLabel.Text = count .. "/" .. Config.MaxPlacedEggs .. " Eggs"
	slotButton.Visible = false
	action.Label.Text = inventoryEggs > 0 and ("Place all (" .. inventoryEggs .. ")") or "Place all"
	empty.Text = "No eggs in your garden.\nBring eggs back, then press Place all!"
	empty.Visible = count == 0
end

local function render()
	if current == "Pets" then renderPets() elseif current == "Eggs" then renderEggs() end
end
local function show(which)
	if current == which then which = nil end -- deuxième clic sur le même bouton : on ferme
	current = which
	if which then
		local theme = THEME[which]
		header.BackgroundColor3 = theme.Main
		clear()
		render()
		panel.Visible = true
		TweenService:Create(panel, SLIDE, {Position = UDim2.new(1, -98, 0.45, 0)}):Play()
	else
		local tween = TweenService:Create(panel, SLIDE, {Position = UDim2.new(1, 420, 0.45, 0)})
		tween.Completed:Once(function() if not current then panel.Visible = false end end)
		tween:Play()
	end
end
eggButton.Activated:Connect(function() show("Eggs") end)
petButton.Activated:Connect(function() show("Pets") end)
slotButton.Activated:Connect(function() remotes.PetAction:FireServer("UpgradeGarden") end)
action.Activated:Connect(function()
	remotes.PetAction:FireServer(current == "Eggs" and "PlaceAllEggs" or "PlaceBest")
end)

remotes:WaitForChild("InventoryUpdated").OnClientEvent:Connect(function(inventory)
	table.clear(pets)
	for _, pet in inventory.Pets do
		if pet.Placed then table.insert(pets, pet) end
	end
	table.sort(pets, function(a, b)
		return Config.GetIncome(a.Pet, a.Kg, a.Mutation, a.Level) > Config.GetIncome(b.Pet, b.Kg, b.Mutation, b.Level)
	end)
	inventoryEggs = #inventory.Eggs
	if current == "Pets" then renderPets() end
end)
for _, name in {"GardenLevel", "Money"} do
	player:GetAttributeChangedSignal(name):Connect(function() if current == "Pets" then
		-- seulement l'en-tête : la liste ne change pas
		countLabel.Text = #pets .. "/" .. maxPets() .. " Active"
		local cost = Config.GardenCosts[(player:GetAttribute("GardenLevel") or 0) + 1]
		slotButton.Visible = cost ~= nil and maxPets() < Config.MaxPlaced
		if cost then
			slotButton.Label.Text = "+1 Slot [" .. Config.FormatMoney(cost) .. "]"
			slotButton.BackgroundColor3 = (player:GetAttribute("Money") or 0) >= cost and GREEN or rgb(178, 180, 188)
		end
	end end)
end
remotes:WaitForChild("PetAction"):FireServer("Sync")

task.spawn(function()
	while true do
		if current == "Eggs" then renderEggs() end
		task.wait(0.4)
	end
end)

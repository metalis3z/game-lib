-- Fenêtre de la Fuse Machine (ouverte par l'invite devant la machine). Style des fenêtres du jeu (UIKit, comme Codes) ;
-- c'est un cadre « Main » posé dans son ScreenGui : UIEffects / UIPolish lui donnent le même son d'ouverture, les mêmes
-- effets de boutons et la règle « une seule fenêtre ouverte » que les autres.
--   à gauche : les pets de l'inventaire (clic = le mettre dans la machine)
--   à droite : les 3 cases, le pet obtenu (aperçu), le timer de 1 h, et le bouton FUSE puis CLAIM
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local UIKit = require(ReplicatedStorage:WaitForChild("UIKit"))
local eggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(eggSystem:WaitForChild("EggConfig"))
local Portrait = require(eggSystem:WaitForChild("PetPortrait"))
local petTemplates = eggSystem:WaitForChild("Pets")
local eggRemotes = eggSystem:WaitForChild("Remotes")
local fuseSystem = ReplicatedStorage:WaitForChild("FuseSystem")
local FuseConfig = require(fuseSystem:WaitForChild("FuseConfig"))
local remotes = fuseSystem:WaitForChild("Remotes")

local new = UIKit.new
local rgb = Color3.fromRGB
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local STUDS = "rbxassetid://7447638591"
local VIOLET = {rgb(214, 150, 255), rgb(128, 46, 226)}
local GREEN = {rgb(150, 226, 96), rgb(66, 170, 70)}
local GREY = {rgb(205, 208, 220), rgb(130, 134, 152)}
local EMPTY = {rgb(92, 96, 112), rgb(44, 46, 58)}

local function grad(o, colors, rot) return new("UIGradient", {Name = "Shade", Rotation = rot or 90, Color = ColorSequence.new(colors[1], colors[2])}, o) end
local function outline(o, t) return new("UIStroke", {Name = "Outline", Thickness = t or 3, Color = BLACK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, o) end
local function studs(o, t) return new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUDS, ScaleType = Enum.ScaleType.Tile,
	TileSize = UDim2.fromOffset(22, 22), ImageTransparency = t or 0.2, ZIndex = o.ZIndex}, o) end

---------------------------------------------------------------- fenêtre (même style que le Shop)
-- fond sombre à studs, bandeau en dégradé avec trois reflets en biais, grande croix rouge, titres de section dorés « ~ ... ~ »,
-- panneau bleu, bouton vert ; le script Text3D donne le relief aux textes à contour, UIScaler met la fenêtre à l'échelle.
local CollectionService = game:GetService("CollectionService")
local INK = BLACK
local gui = new("ScreenGui", {Name = "FuseGui", ResetOnSpawn = false, DisplayOrder = 10, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, player:WaitForChild("PlayerGui"))
local main = new("Frame", {Name = "Main", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromOffset(900, 560),
	BackgroundColor3 = rgb(44, 46, 54), BackgroundTransparency = 0.3, BorderSizePixel = 0, Visible = false}, gui)
outline(main, 4)
new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUDS, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(30, 30), ImageTransparency = 0.88, ZIndex = 1}, main)
CollectionService:AddTag(main, "AutoScale") -- même mise à l'échelle que le Shop

local header = new("Frame", {Name = "Header", Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 0, 78), BackgroundColor3 = WHITE, BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 2}, main)
new("UIGradient", {Rotation = 0, Color = ColorSequence.new(rgb(225, 150, 255), rgb(140, 60, 240))}, header)
outline(header, 3)
new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUDS, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(30, 30), ImageTransparency = 0.8, ZIndex = 2}, header)
for i = 0, 2 do -- reflets en biais
	new("Frame", {BackgroundColor3 = WHITE, BackgroundTransparency = 0.72, BorderSizePixel = 0, Rotation = 24, Position = UDim2.new(0.5 + i * 0.085, 0, -0.6, 0), Size = UDim2.new(0.035 + i * 0.012, 0, 2.2, 0), ZIndex = 2}, header)
end
local function label(parent, props, strokeT)
	local l = new("TextLabel", {BackgroundTransparency = 1, FontFace = UIKit.FONT, TextScaled = true, TextColor3 = WHITE, ZIndex = (parent.ZIndex or 1) + 1}, parent)
	for k, v in props do l[k] = v end
	new("UIStroke", {Thickness = strokeT or 3, Color = INK}, l)
	return l
end
label(header, {Name = "Title", Text = "Fuse Machine", TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(22, 10), Size = UDim2.new(0.5, -22, 1, -20), ZIndex = 4}, 4)
label(header, {Name = "Hint", Text = "Fuse 3 same pets into 1 egg!", TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -86, 0.5, 0),
	Size = UDim2.new(0.42, 0, 0, 30), ZIndex = 4}, 3)
local closeButton = new("TextButton", {Name = "Close", Text = "X", FontFace = UIKit.FONT, TextSize = 40, TextColor3 = WHITE, BackgroundColor3 = WHITE, BorderSizePixel = 0,
	AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(66, 60), ZIndex = 5}, header)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(255, 70, 70), rgb(190, 14, 30))}, closeButton)
outline(closeButton, 3)
new("UIStroke", {Thickness = 3, Color = INK}, closeButton)
closeButton.Activated:Connect(function() main.Visible = false end)

-- titre de section doré, comme « ~ Featured ~ » du Shop
local function sectionTitle(text, x, width)
	local l = label(main, {Text = "~ " .. text .. " ~", Position = UDim2.fromOffset(x, 92), Size = UDim2.fromOffset(width, 44), ZIndex = 3}, 3.5)
	new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(255, 240, 80), rgb(255, 176, 20))}, l)
	return l
end

local spinning = {} -- éclats de rayons qui tournent quand la fenêtre est ouverte

-- carte d'un pet (inventaire, case, résultat) : couleur de la rareté, rayons, photo, nom, poids
local function petCard(parent, props)
	local card = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = WHITE, BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 4}, parent)
	for k, v in props do card[k] = v end
	grad(card, EMPTY)
	outline(card, 3)
	studs(card)
	local rays = Portrait.rays(card, WHITE, 0.5, card.ZIndex)
	rays.Visible = false
	table.insert(spinning, rays)
	local view = new("ViewportFrame", {Name = "View", BackgroundTransparency = 1, Position = UDim2.fromScale(0.12, 0.16), Size = UDim2.fromScale(0.76, 0.6), ZIndex = card.ZIndex + 1}, card)
	local name = label(card, {Name = "PetName", Position = UDim2.new(0, 5, 0, 4), Size = UDim2.new(1, -10, 0.16, 0), Text = "", ZIndex = card.ZIndex + 2}, 2)
	local kg = label(card, {Name = "Kg", Position = UDim2.new(0, 5, 0.8, 0), Size = UDim2.new(1, -10, 0.15, 0), Text = "", ZIndex = card.ZIndex + 2}, 2)
	local plus = label(card, {Name = "Plus", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.5), Text = "+", ZIndex = card.ZIndex + 2}, 3)
	local shown
	local function set(rec, emptyText)
		local info = rec and Config.Pets[rec.Pet]
		plus.Visible = info == nil
		plus.Text = emptyText or "+"
		rays.Visible = info ~= nil
		name.Text = info and ((rec.Trait and (rec.Trait .. " ") or "") .. (rec.Mutation and (rec.Mutation .. " ") or "") .. info.Name) or ""
		kg.Text = info and Config.FormatKg(rec.Kg or info.Kg) or ""
		local colors = info and (Portrait.RarityColors[info.Rarity] or Portrait.RarityColors.Common) or EMPTY
		card.Shade.Color = ColorSequence.new(colors[1], colors[2])
		local key = info and (rec.Pet .. "|" .. tostring(rec.Mutation)) or nil
		if key ~= shown then
			shown = key
			view:ClearAllChildren()
			if info then
				Portrait.fill(view, petTemplates:FindFirstChild(rec.Pet), function(model) if Config.ApplyMutation then Config.ApplyMutation(model, rec.Mutation) end end)
			end
		end
	end
	return card, set
end

---------------------------------------------------------------- gauche : les pets de l'inventaire
sectionTitle("Your Pets", 14, 470)
local countLabel = label(main, {Name = "Count", Text = "", TextXAlignment = Enum.TextXAlignment.Right, Position = UDim2.fromOffset(364, 104), Size = UDim2.fromOffset(120, 22), ZIndex = 3}, 2.5)
local left = new("Frame", {Name = "Pets", Position = UDim2.fromOffset(14, 142), Size = UDim2.fromOffset(470, 404), BackgroundColor3 = rgb(26, 28, 36), BackgroundTransparency = 0.35, BorderSizePixel = 0, ZIndex = 2}, main)
outline(left, 3)
local grid = new("ScrollingFrame", {Name = "Grid", BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 1, -12),
	CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 6, ScrollBarImageColor3 = WHITE, ScrollingDirection = Enum.ScrollingDirection.Y, ZIndex = 3}, left)
new("UIGridLayout", {CellSize = UDim2.fromOffset(104, 120), CellPadding = UDim2.fromOffset(8, 8), SortOrder = Enum.SortOrder.LayoutOrder}, grid)
new("UIPadding", {PaddingTop = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingBottom = UDim.new(0, 8)}, grid)
local emptyLabel = label(left, {Name = "Empty", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -40, 0, 30), Text = "No pets in your inventory!", ZIndex = 5, Visible = false}, 3)
-- voile quand la machine travaille
local busy = new("Frame", {Name = "Busy", BackgroundColor3 = rgb(16, 12, 26), BackgroundTransparency = 0.18, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 8, Visible = false}, left)
label(busy, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -40, 0, 64), Text = "The machine is busy!\nCome back when the fusion is done.", ZIndex = 9}, 3)

---------------------------------------------------------------- droite : les cases, le résultat, le bouton (panneau bleu comme les lignes du Shop)
sectionTitle("Fuse", 498, 388)
local right = new("Frame", {Name = "Fuse", Position = UDim2.fromOffset(498, 142), Size = UDim2.fromOffset(388, 404), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 2}, main)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(81, 185, 255), rgb(43, 154, 210))}, right)
outline(right, 3)
local stepLabel = label(right, {Name = "Step", Position = UDim2.fromOffset(12, 8), Size = UDim2.new(1, -24, 0, 26), Text = "Put 3 pets in the machine", ZIndex = 3}, 2.5)
local slots = {}
for i = 1, FuseConfig.Slots do
	local card, set = petCard(right, {Name = "Slot" .. i, Position = UDim2.fromOffset(14 + (i - 1) * 124, 42), Size = UDim2.fromOffset(112, 112)})
	slots[i] = {Card = card, Set = set}
	set(nil)
	if i < FuseConfig.Slots then
		label(right, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(14 + i * 124 - 6, 98), Size = UDim2.fromOffset(22, 32), Text = "+", ZIndex = 5}, 3)
	end
end
-- bandeau RESULT (badge sombre, comme les icônes du Shop)
local arrow = new("Frame", {Name = "Arrow", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 164), Size = UDim2.fromOffset(150, 26), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 3}, right)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(69, 80, 96), rgb(40, 46, 56))}, arrow)
outline(arrow, 3)
label(arrow, {Position = UDim2.fromScale(0.05, 0.1), Size = UDim2.fromScale(0.9, 0.8), Text = "YOUR EGG", ZIndex = 4}, 2.5)
local resultCard, setResult = petCard(right, {Name = "Result", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 196), Size = UDim2.fromOffset(122, 112)})
setResult(nil, "?")
local info = label(right, {Name = "Info", Position = UDim2.fromOffset(12, 314), Size = UDim2.new(1, -24, 0, 18),
	Text = "Same pet x3 · weights added · egg hatches 1h after placing", ZIndex = 3}, 2)
-- timer (pendant la fusion)
local bar = new("Frame", {Name = "Timer", Position = UDim2.fromOffset(14, 338), Size = UDim2.new(1, -28, 0, 56), BackgroundColor3 = rgb(30, 32, 42), BorderSizePixel = 0, ZIndex = 3, Visible = false}, right)
outline(bar, 3.5)
local fill = new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 3}, bar)
grad(fill, VIOLET)
studs(fill)
local timerLabel = label(bar, {Name = "Time", Position = UDim2.fromScale(0.04, 0.16), Size = UDim2.fromScale(0.92, 0.68), Text = "", ZIndex = 5}, 3)
-- bouton FUSE / CLAIM (vert comme les boutons d'achat du Shop)
local action = new("TextButton", {Name = "Action", Text = "", AutoButtonColor = false, Position = UDim2.fromOffset(14, 338), Size = UDim2.new(1, -28, 0, 56), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 3}, right)
grad(action, GREY)
outline(action, 3.5)
local actionLabel = label(action, {Name = "Label", Position = UDim2.fromScale(0.05, 0.16), Size = UDim2.fromScale(0.9, 0.68), Text = "FUSE", ZIndex = 5}, 3.5)
local pulse = new("UIScale", {Scale = 1}, actionLabel)

---------------------------------------------------------------- données
local inventory = {}   -- pets rangés (pas posés dans le jardin)
local chosen = {}      -- [case] = fiche du pet (Id, Pet, Kg, Mutation, Trait)
local state = {Active = false}
local pending = false
local render

local messageId = 0
local DEFAULT_INFO = info.Text
local function say(text, bad)
	messageId += 1
	local id = messageId
	info.Text = text
	info.TextColor3 = bad and rgb(255, 120, 110) or rgb(170, 255, 140)
	task.delay(3, function()
		if messageId == id then info.Text, info.TextColor3 = DEFAULT_INFO, WHITE end
	end)
end

local function isChosen(id)
	for i = 1, FuseConfig.Slots do if chosen[i] and chosen[i].Id == id then return i end end
	return nil
end
local function chosenCount()
	local n = 0
	for i = 1, FuseConfig.Slots do if chosen[i] then n += 1 end end
	return n
end

-- cartes de l'inventaire
local cards = {}
local function renderInventory()
	for _, c in cards do c:Destroy() end
	table.clear(cards)
	-- dès qu'un pet est dans la machine, on ne montre plus que les pets du même animal
	local species
	for i = 1, FuseConfig.Slots do if chosen[i] then species = chosen[i].Pet break end end
	local list = {}
	for _, pet in inventory do
		if Config.Pets[pet.Pet] and (not species or pet.Pet == species) then table.insert(list, pet) end
	end
	-- les plus rares et les plus lourds en premier
	table.sort(list, function(a, b)
		local ra, rb = Config.RarityRank[Config.Pets[a.Pet].Rarity] or 0, Config.RarityRank[Config.Pets[b.Pet].Rarity] or 0
		if ra ~= rb then return ra > rb end
		return (a.Kg or 0) > (b.Kg or 0)
	end)
	for index, pet in list do
		local card, set = petCard(grid, {Name = "Pet", LayoutOrder = index})
		set(pet)
		local slot = isChosen(pet.Id)
		if slot then -- déjà dans la machine : carte grisée, cochée
			card.Outline.Color, card.Outline.Thickness = rgb(170, 90, 255), 5
			new("Frame", {BackgroundColor3 = BLACK, BackgroundTransparency = 0.45, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = card.ZIndex + 3}, card)
			label(card, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.3), Text = "IN SLOT " .. slot, ZIndex = card.ZIndex + 4}, 2.5)
		end
		card.Activated:Connect(function()
			if state.Active or pending then return end
			local already = isChosen(pet.Id)
			if already then
				chosen[already] = nil
			else
				local free
				for i = 1, FuseConfig.Slots do if not chosen[i] then free = i break end end
				if not free then say("The machine is full! Click a slot to take a pet out.", true) return end
				for i = 1, FuseConfig.Slots do
					if chosen[i] and chosen[i].Pet ~= pet.Pet then say("Only the same animal can go in!", true) return end
				end
				chosen[free] = pet
			end
			render()
		end)
		table.insert(cards, card)
	end
	countLabel.Text = #list .. " pets"
	emptyLabel.Text = species and "No other pet of this animal!" or "No pets in your inventory!"
	emptyLabel.Visible = #list == 0
end

local function setAction(text, colors, enabled)
	actionLabel.Text = text
	action.Shade.Color = ColorSequence.new(colors[1], colors[2])
	action.Active = enabled
	action.AutoButtonColor = false
end

function render()
	busy.Visible = state.Active
	if state.Active then
		-- la machine travaille : les 3 pets qu'on y a mis, le résultat, le timer
		for i = 1, FuseConfig.Slots do slots[i].Set(state.Pets and state.Pets[i]) end
		setResult(state.Result)
		stepLabel.Text = state.Ready and "Your pet is ready!" or "Fusing..."
	else
		local records = {}
		for i = 1, FuseConfig.Slots do
			slots[i].Set(chosen[i])
			if chosen[i] then table.insert(records, chosen[i]) end
		end
		-- le résultat s'affiche dès le 1er pet : poids total des pets déjà mis
		setResult(#records > 0 and FuseConfig.Result(records, Config) or nil, "?")
		if #records == 0 then
			stepLabel.Text = "Put a pet in the machine"
		elseif #records < FuseConfig.Slots then
			local petInfo = Config.Pets[records[1].Pet]
			stepLabel.Text = "Add " .. (FuseConfig.Slots - #records) .. " more " .. (petInfo and petInfo.Name or "pets") .. " (" .. #records .. "/" .. FuseConfig.Slots .. ")"
		else
			stepLabel.Text = "Ready to fuse!"
		end
	end
	renderInventory()
end

-- un clic sur une case pleine la vide
for i = 1, FuseConfig.Slots do
	slots[i].Card.Activated:Connect(function()
		if state.Active or pending or not chosen[i] then return end
		chosen[i] = nil
		render()
	end)
end

local function applyState(newState)
	if type(newState) ~= "table" then return end
	state = newState
	if state.Active then table.clear(chosen) end
	render()
end

-- les pets choisis existent-ils encore (vendus, posés dans le jardin, échangés...) ?
local function pruneChosen()
	local ids = {}
	for _, pet in inventory do ids[pet.Id] = pet end
	for i = 1, FuseConfig.Slots do
		if chosen[i] and not ids[chosen[i].Id] then chosen[i] = nil end
	end
end

eggRemotes:WaitForChild("InventoryUpdated").OnClientEvent:Connect(function(newInventory)
	inventory = {}
	for _, pet in newInventory.Pets or {} do
		if not pet.Placed then table.insert(inventory, pet) end
	end
	pruneChosen()
	if main.Visible then render() end
end)

local insideCircle = false   -- le joueur est sur le cercle magique de la Fuse Machine 2
local openedByCircle = false -- la fenêtre a été ouverte par ce cercle (elle se fermera en sortant)
remotes:WaitForChild("State").OnClientEvent:Connect(applyState)
remotes:WaitForChild("Open").OnClientEvent:Connect(function(newState)
	applyState(newState)
	openedByCircle = false
	main.Visible = true
	eggRemotes.PetAction:FireServer("Sync")
end)

action.Activated:Connect(function()
	if pending then return end
	local remaining = state.Active and (state.Ends or 0) - workspace:GetServerTimeNow() or 0
	local what
	if state.Active and (state.Ready or remaining <= 0) then
		what = "Claim"
	elseif not state.Active and chosenCount() == FuseConfig.Slots then
		what = "Start"
	elseif not state.Active then
		say("Put " .. FuseConfig.Slots .. " pets in the machine first!", true)
		return
	else
		return
	end
	pending = true
	setAction(what == "Claim" and "CLAIMING..." or "STARTING...", GREY, false)
	local ids = {}
	for i = 1, FuseConfig.Slots do if chosen[i] then table.insert(ids, chosen[i].Id) end end
	local ok, result, pet = remotes.Action:InvokeServer(what, ids)
	pending = false
	if ok then
		if what == "Start" then table.clear(chosen) end
		applyState(result)
		if what == "Claim" then
			local petInfo = type(pet) == "table" and Config.Pets[pet.Pet]
			say((petInfo and petInfo.Name or "Pet") .. " claimed!", false)
		else
			local petInfo = type(pet) == "table" and Config.Pets[pet.Pet]
			say("You got a Fused " .. (petInfo and petInfo.Name or "pet") .. " Egg! Place it in your garden.", false)
		end
	else
		say(tostring(result or "Something went wrong."), true)
	end
end)

---------------------------------------------------------------- chaque image : timer, bouton, rayons ; fermeture si on s'éloigne
local function clock(seconds)
	seconds = math.max(0, math.ceil(seconds))
	return string.format("%02d:%02d:%02d", seconds // 3600, seconds % 3600 // 60, seconds % 60)
end
RunService.RenderStepped:Connect(function()
	if not main.Visible then return end
	local now = os.clock()
	for _, rays in spinning do rays.Rotation = (now * 16) % 360 end
	if pending then return end
	if state.Active then
		local remaining = (state.Ends or 0) - workspace:GetServerTimeNow()
		local ready = state.Ready or remaining <= 0
		bar.Visible = not ready
		action.Visible = ready
		if ready then
			setAction("CLAIM", GREEN, true)
			pulse.Scale = 1 + math.sin(now * 5) * 0.06
			stepLabel.Text = "Your pet is ready!"
		else
			fill.Size = UDim2.fromScale(math.clamp(1 - remaining / FuseConfig.Duration, 0, 1), 1)
			timerLabel.Text = "Fusing... " .. clock(remaining)
		end
	else
		bar.Visible = false
		action.Visible = true
		pulse.Scale = 1
		local full = chosenCount() == FuseConfig.Slots
		setAction("FUSE", full and GREEN or GREY, full)
	end
end)

-- Fuse Machine 2 : marcher sur son cercle magique ouvre la fenêtre, en sortir la ferme
local CIRCLE_RADIUS = 4.2 -- un peu plus large que le cercle dessiné (3,6)
local function circleCenter()
	local machine2 = workspace:FindFirstChild("Fuse Machine 2")
	local circle = machine2 and machine2:FindFirstChild("MagicCircle", true)
	return circle and circle:GetPivot().Position
end
task.spawn(function()
	while true do
		task.wait(0.1)
		local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		local center = circleCenter()
		local inside = false
		if root and center and humanoid and humanoid.Health > 0 then
			local flat = Vector3.new(root.Position.X - center.X, 0, root.Position.Z - center.Z)
			inside = flat.Magnitude <= CIRCLE_RADIUS and math.abs(root.Position.Y - center.Y) < 8
		end
		if inside and not insideCircle then
			insideCircle = true
			openedByCircle = true
			task.spawn(function()
				local ok, result = pcall(function() return table.pack(remotes.Action:InvokeServer("State")) end)
				if ok and result[1] and type(result[2]) == "table" then applyState(result[2]) end
				if insideCircle then
					main.Visible = true
					eggRemotes.PetAction:FireServer("Sync")
				end
			end)
		elseif not inside and insideCircle then
			insideCircle = false
			if openedByCircle then main.Visible = false end
			openedByCircle = false
		end
	end
end)

-- ouverte par l'invite de la Fuse Machine : elle se ferme si on s'éloigne de la machine
task.spawn(function()
	while true do
		task.wait(0.5)
		if main.Visible and not openedByCircle then
			local machine = workspace:FindFirstChild("Fuse Machine")
			local spot = machine and machine:FindFirstChild("FusePrompt")
			local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if spot and root and (root.Position - spot.Position).Magnitude > FuseConfig.CloseDistance then main.Visible = false end
		end
	end
end)

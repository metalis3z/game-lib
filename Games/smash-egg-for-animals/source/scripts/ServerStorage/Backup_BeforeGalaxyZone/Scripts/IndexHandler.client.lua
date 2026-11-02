-- Index : une section par rareté (bannière + cartes carrées + barre de progression) ; panneau de droite = animal sélectionné.
-- Les animaux jamais obtenus restent en silhouette noire. Le serveur tient la liste dans l'attribut "PetIndex" du joueur.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local system = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(system:WaitForChild("EggConfig"))
local petTemplates = system:WaitForChild("Pets")

local player = Players.LocalPlayer
local gui = script.Parent
local main = gui:WaitForChild("Main")
local body = main:WaitForChild("Body")
local list = body:WaitForChild("List")
local detail = body:WaitForChild("Side"):WaitForChild("Detail")
local totalLabel = main:WaitForChild("Total")
local openButton = player:WaitForChild("PlayerGui"):WaitForChild("left bottom"):WaitForChild("Holder"):WaitForChild("IndexButton")

local rgb = Color3.fromRGB
local BLACK, WHITE = Color3.new(0, 0, 0), Color3.new(1, 1, 1)
local MONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local STUD = "rbxassetid://7447638591"
local CARD, GAP, BANNER, COLUMNS = 88, 8, 108, 4
local RARITY_ORDER = table.clone(Config.Rarities)
table.insert(RARITY_ORDER, "Exclusive") -- animaux de la boutique
local RARITY_COLORS = { -- {clair, foncé}
	Common = {rgb(190, 250, 40), rgb(120, 215, 0)},
	Uncommon = {rgb(40, 240, 150), rgb(0, 185, 110)},
	Rare = {rgb(40, 185, 255), rgb(0, 125, 235)},
	Epic = {rgb(190, 70, 255), rgb(130, 20, 215)},
	Legendary = {rgb(255, 225, 40), rgb(245, 170, 0)},
	Mythic = {rgb(255, 100, 140), rgb(225, 30, 80)},
	Secret = {rgb(90, 90, 110), rgb(30, 30, 44)},
	Ancient = {rgb(170, 230, 90), rgb(90, 150, 40)},
	OG = {rgb(255, 215, 80), rgb(235, 130, 20)},
	Divine = {rgb(255, 250, 210), rgb(240, 200, 90)},
	Prismatic = {rgb(255, 130, 220), rgb(110, 90, 255)},
	Exclusive = {rgb(255, 250, 220), rgb(255, 196, 60)},
}

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function stroke(o, t, border) return new("UIStroke", {Thickness = t, Color = BLACK, ApplyStrokeMode = border and Enum.ApplyStrokeMode.Border or Enum.ApplyStrokeMode.Contextual}, o) end
local function grad(o, colors, rot) return new("UIGradient", {Color = ColorSequence.new(colors[1], colors[2]), Rotation = rot or 90}, o) end
local function studs(o) return new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Image = STUD, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(22, 22), Size = UDim2.fromScale(1, 1), ImageTransparency = 0.2, ZIndex = 2}, o) end
local function text(parent, name, str, pos, size, strokeT, props)
	local l = new("TextLabel", {Name = name, BackgroundTransparency = 1, Text = str, Position = pos, Size = size, FontFace = MONT, TextScaled = true, TextColor3 = WHITE, ZIndex = 4}, parent)
	stroke(l, strokeT)
	for k, v in props or {} do l[k] = v end
	return l
end

local Portrait = require(system:WaitForChild("PetPortrait")) -- même cadrage que dans les autres fenêtres
local function fillViewport(view, petName)
	Portrait.fill(view, petTemplates:FindFirstChild(petName))
end

local eggs = {}
for _, egg in Config.Eggs do if not egg.ZoneEgg then table.insert(eggs, egg) end end -- les œufs de zone reprennent les mêmes animaux
table.sort(eggs, function(a, b) return a.Order < b.Order end)

local cards, sections, total = {}, {}, 0
local spinning = {} -- les éclats de rayons, qui tournent quand la fenêtre est ouverte
-- panneau de droite : rayons derrière l'animal choisi, et le panneau prend la couleur de sa rareté
local detailRays = Portrait.rays(detail, WHITE, 0.4, 2)
detailRays.Position, detailRays.Size, detailRays.Visible = UDim2.fromScale(0.5, 0.46), UDim2.fromScale(1.5, 1.5), false
table.insert(spinning, detailRays)
local detailShade = detail:FindFirstChildOfClass("UIGradient")
local DETAIL_IDLE = detailShade.Color
local discovered = {}
local selected

local function showDetail()
	local entry = selected and cards[selected]
	detail.Paw.Visible = entry == nil
	detail.View.Visible = entry ~= nil
	detailRays.Visible = entry ~= nil
	local tint = entry and (RARITY_COLORS[entry.Info.Rarity] or RARITY_COLORS.Common)
	detailShade.Color = tint and ColorSequence.new(tint[1], tint[2]:Lerp(BLACK, 0.3)) or DETAIL_IDLE
	if not entry then
		detail.FoundIn.Text = "Found in -"
		detail.Selected.Text = "Select an animal"
		detail.Info.Text = ""
		return
	end
	local found = discovered[selected] == true
	fillViewport(detail.View, selected)
	detail.View.ImageColor3 = found and WHITE or BLACK
	detail.FoundIn.Text = "Found in: " .. entry.Egg.Name
	detail.Selected.Text = found and entry.Info.Name or "???"
	detail.Info.Text = found and (entry.Info.Rarity .. " · " .. Config.FormatMoney(entry.Info.Income) .. "/s") or entry.Info.Rarity
end

for rarityOrder, rarity in RARITY_ORDER do
	local pets = {}
	for _, egg in eggs do
		for index, entry in egg.Pets do -- un œuf peut contenir plusieurs animaux (œuf de la boutique)
			local info = Config.Pets[entry.Pet]
			if info and info.Rarity == rarity then table.insert(pets, {Name = entry.Pet, Info = info, Egg = egg, Order = egg.Order * 10 + index}) end
		end
	end
	if #pets == 0 then continue end
	local colors = RARITY_COLORS[rarity] or RARITY_COLORS.Common
	local rows = math.ceil(#pets / COLUMNS)
	local gridHeight = rows * CARD + (rows - 1) * GAP
	local section = new("Frame", {Name = rarity, BackgroundTransparency = 1, LayoutOrder = rarityOrder, Size = UDim2.new(1, 0, 0, gridHeight + GAP + 36)}, list)
	-- bannière de la rareté
	local banner = new("Frame", {Name = "Banner", BackgroundColor3 = WHITE, BorderSizePixel = 0, Size = UDim2.new(0, BANNER, 1, 0), ZIndex = 2}, section)
	grad(banner, {colors[1], colors[2]:Lerp(BLACK, 0.35)}) stroke(banner, 3.5, true) studs(banner)
	text(banner, "RarityName", rarity, UDim2.new(0, 4, 0, 8), UDim2.new(1, -8, 0, 24), 3)
	new("ImageLabel", {Name = "Paw", BackgroundTransparency = 1, Image = "rbxthumb://type=Asset&id=128895446491384&w=150&h=150", ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -10), Size = UDim2.new(0.7, 0, 0.5, 0), ImageTransparency = 0.15, ZIndex = 3}, banner)
	-- cartes
	local grid = new("Frame", {Name = "Cards", BackgroundTransparency = 1, Position = UDim2.fromOffset(BANNER + 12, 0), Size = UDim2.new(1, -(BANNER + 12), 0, gridHeight)}, section)
	new("UIGridLayout", {CellSize = UDim2.fromOffset(CARD, CARD), CellPadding = UDim2.fromOffset(GAP, GAP), SortOrder = Enum.SortOrder.LayoutOrder}, grid)
	local names = {}
	for _, pet in pets do
		local card = new("TextButton", {Name = pet.Name, Text = "", AutoButtonColor = false, BackgroundColor3 = WHITE, BorderSizePixel = 0, LayoutOrder = pet.Order, ZIndex = 2}, grid)
		grad(card, colors) stroke(card, 3.5, true) studs(card)
		card.ClipsDescendants = true
		table.insert(spinning, Portrait.rays(card, WHITE, 0.45, 3)) -- éclat de lumière derrière l'animal
		local view = new("ViewportFrame", {Name = "View", BackgroundTransparency = 1, Position = UDim2.new(0.12, 0, 0.14, 0), Size = UDim2.fromScale(0.76, 0.76), ZIndex = 3, Ambient = rgb(220, 220, 220), LightColor = WHITE}, card)
		fillViewport(view, pet.Name)
		text(card, "Rarity", rarity, UDim2.fromOffset(5, 3), UDim2.new(1, -10, 0, 15), 2, {TextXAlignment = Enum.TextXAlignment.Left})
		text(card, "PetName", "???", UDim2.new(0, 4, 1, -19), UDim2.new(1, -8, 0, 16), 2, {TextXAlignment = Enum.TextXAlignment.Right})
		cards[pet.Name] = {Card = card, Info = pet.Info, Egg = pet.Egg}
		table.insert(names, pet.Name)
		total += 1
		card.Activated:Connect(function()
			selected = pet.Name
			showDetail()
		end)
	end
	-- barre de progression
	local bar = new("Frame", {Name = "Progress", BackgroundColor3 = rgb(24, 40, 20), BorderSizePixel = 0, Position = UDim2.fromOffset(BANNER + 12, gridHeight + GAP), Size = UDim2.new(1, -(BANNER + 12), 0, 32), ZIndex = 2}, section)
	stroke(bar, 3.5, true)
	local fill = new("Frame", {Name = "Fill", BackgroundColor3 = WHITE, BorderSizePixel = 0, Size = UDim2.fromScale(0, 1), ZIndex = 2}, bar)
	grad(fill, {rgb(160, 255, 60), rgb(60, 200, 20)}) studs(fill)
	text(bar, "Count", "0/" .. #names, UDim2.fromScale(0, 0.1), UDim2.fromScale(1, 0.8), 2.5)
	table.insert(sections, {Bar = bar, Pets = names})
end

local function refresh()
	discovered = {}
	for name in string.gmatch(player:GetAttribute("PetIndex") or "", "[^,]+") do discovered[name] = true end
	local count = 0
	for petName, entry in cards do
		local found = discovered[petName] == true
		if found then count += 1 end
		entry.Card.PetName.Text = found and entry.Info.Name or "???"
		entry.Card.View.ImageColor3 = found and WHITE or BLACK
	end
	for _, section in sections do
		local got = 0
		for _, petName in section.Pets do if discovered[petName] then got += 1 end end
		section.Bar.Count.Text = got .. "/" .. #section.Pets
		section.Bar.Fill.Size = UDim2.fromScale(got / #section.Pets, 1)
	end
	totalLabel.Text = count .. "/" .. total
	-- panneau Rewards : ce que rapporte chaque rareté terminée
	local claimed = {}
	for rarity in string.gmatch(player:GetAttribute("IndexRewards") or "", "[^,]+") do claimed[rarity] = true end
	local lines = {}
	for _, rarity in RARITY_ORDER do
		local reward = Config.IndexRewards and Config.IndexRewards[rarity]
		if reward then table.insert(lines, rarity .. ": " .. Config.FormatMoney(reward) .. (claimed[rarity] and "  (claimed)" or "")) end
	end
	body.Side.Rewards.Text.Text = "Finish a rarity to earn:\n" .. table.concat(lines, "\n")
	showDetail()
end

game:GetService("RunService").RenderStepped:Connect(function()
	if not main.Visible then return end
	local angle = (os.clock() * 16) % 360
	for _, rays in spinning do rays.Rotation = angle end
end)

player:GetAttributeChangedSignal("PetIndex"):Connect(refresh)
player:GetAttributeChangedSignal("IndexRewards"):Connect(refresh)
refresh()

openButton.Activated:Connect(function() main.Visible = not main.Visible end)
main:WaitForChild("Close").Activated:Connect(function() main.Visible = false end)

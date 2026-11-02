-- Panneau admin (touche F2 ou bouton "ADMIN" en haut à gauche). Réservé aux joueurs de ReplicatedStorage.AdminConfig.
-- Onglets : Announce, Give (argent / œufs), Spawn Egg, Events, Codes. Tout passe par ReplicatedStorage.AdminSystem.Remotes ;
-- le serveur revérifie que le joueur est admin à chaque commande.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
if not table.find(AdminConfig.AdminIds, player.UserId) then return end

local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local Config = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))

local rgb = Color3.fromRGB
local INK, WHITE, BLACK = rgb(30, 26, 44), Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local HEAVY = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local BOLD = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
local STUD = "rbxassetid://7447638591"
local ICE = {rgb(235, 250, 255), rgb(130, 215, 255), rgb(40, 125, 245), rgb(20, 60, 175)} -- bleu glacé -> ciel -> clair -> foncé
local GREEN, RED, GOLD, VIOLET = {rgb(140, 240, 90), rgb(40, 180, 50)}, {rgb(255, 110, 100), rgb(210, 24, 40)}, {rgb(255, 232, 110), rgb(245, 160, 20)}, {rgb(215, 150, 255), rgb(130, 50, 220)}
local RARITY_ORDER = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Ancient", "OG", "Divine", "Prismatic"}
local RARITY_TINT = {Common = rgb(214, 250, 170), Uncommon = rgb(170, 245, 215), Rare = rgb(175, 220, 255), Epic = rgb(225, 190, 255), Legendary = rgb(255, 236, 160), Mythic = rgb(255, 190, 205), Secret = rgb(205, 205, 220), Ancient = rgb(205, 240, 160), OG = rgb(255, 225, 150), Divine = rgb(255, 248, 205), Prismatic = rgb(255, 190, 240), Exclusive = rgb(255, 244, 200)}
local SELECTED = rgb(110, 210, 255)

---------------------------------------------------------------- petits outils d'interface
local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function border(o, thickness)
	return new("UIStroke", {Thickness = thickness or 3, Color = BLACK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, o)
end
local function gradient(o, colors, rotation)
	local points = {}
	for i, c in colors do points[i] = ColorSequenceKeypoint.new((i - 1) / (#colors - 1), c) end
	o.BackgroundColor3 = WHITE
	return new("UIGradient", {Color = ColorSequence.new(points), Rotation = rotation or 90}, o)
end
local function studs(o, tile)
	return new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Image = STUD, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(tile or 26, tile or 26), Size = UDim2.fromScale(1, 1), ImageTransparency = 0.2}, o)
end
-- texte blanc à contour noir (le script Text3D lui donne son relief)
local function title(parent, text, position, size, color, thickness, align)
	local l = new("TextLabel", {BackgroundTransparency = 1, Text = text, Position = position, Size = size, FontFace = HEAVY, TextScaled = true, TextColor3 = color or WHITE, ZIndex = 3,
		TextXAlignment = align or Enum.TextXAlignment.Left}, parent)
	new("UIStroke", {Thickness = thickness or 3, Color = BLACK}, l)
	return l
end
-- petit texte sombre, sans contour
local function note(parent, text, position, size, align)
	return new("TextLabel", {BackgroundTransparency = 1, Text = text, Position = position, Size = size, FontFace = BOLD, TextSize = 13, TextColor3 = INK, TextWrapped = true, ZIndex = 3,
		TextXAlignment = align or Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center}, parent)
end
local function button(parent, text, position, size, colors, onClick)
	local b = new("TextButton", {Text = "", AutoButtonColor = false, BorderSizePixel = 0, Position = position, Size = size, ZIndex = 3}, parent)
	gradient(b, colors)
	border(b, 3)
	studs(b, 22).ZIndex = 3
	local l = title(b, text, UDim2.fromScale(0.06, 0.16), UDim2.fromScale(0.88, 0.68), WHITE, 3, Enum.TextXAlignment.Center)
	l.ZIndex = 5
	if onClick then b.Activated:Connect(onClick) end
	return b, l
end
local function chip(parent, text, color, onClick)
	local b = new("TextButton", {Text = text, AutoButtonColor = false, BorderSizePixel = 0, BackgroundColor3 = color or rgb(236, 238, 246), FontFace = BOLD, TextSize = 13, TextColor3 = INK,
		TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 3}, parent)
	local s = border(b, 2)
	if onClick then b.Activated:Connect(function() onClick(b) end) end
	return b, s
end
local function input(parent, placeholder, position, size, default)
	local box = new("TextBox", {Text = default or "", PlaceholderText = placeholder, PlaceholderColor3 = rgb(140, 140, 160), ClearTextOnFocus = false, BorderSizePixel = 0, BackgroundColor3 = WHITE,
		Position = position, Size = size, FontFace = BOLD, TextSize = 15, TextColor3 = INK, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3}, parent)
	border(box, 2.5)
	new("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)}, box)
	return box
end
-- un seul choix à la fois parmi des chips
local function choice(onChange)
	local group = {Value = nil, Items = {}}
	function group.Add(value, button, strokeObject)
		table.insert(group.Items, {Value = value, Button = button, Stroke = strokeObject, Color = button.BackgroundColor3})
		button.Activated:Connect(function() group.Select(value) end)
	end
	function group.Select(value)
		group.Value = value
		for _, item in group.Items do
			local on = item.Value == value
			item.Button.BackgroundColor3 = on and SELECTED or item.Color
			item.Stroke.Thickness = on and 3.5 or 2
		end
		if onChange then onChange(value) end
	end
	return group
end

local function parseNumber(text) -- "1000", "1,000", "10k", "2.5m", "1b", "3t"
	text = string.lower(string.gsub(text or "", "[%s,]", ""))
	local number, suffix = string.match(text, "^(%-?[%d%.]+)([kmbt]?)$")
	number = tonumber(number)
	if not number then return nil end
	return number * (({k = 1e3, m = 1e6, b = 1e9, t = 1e12})[suffix] or 1)
end
local function parseDuration(text) -- "90s", "5m", "1h30m" ; un nombre seul = minutes
	text = string.lower(string.gsub(text or "", "%s", ""))
	if tonumber(text) then return tonumber(text) * 60 end
	local total, found = 0, false
	for amount, unit in string.gmatch(text, "([%d%.]+)([hms])") do
		total += tonumber(amount) * (({h = 3600, m = 60, s = 1})[unit])
		found = true
	end
	return found and total or nil
end
local function clock(seconds)
	seconds = math.max(0, math.floor(seconds))
	local h, m, s = seconds // 3600, seconds % 3600 // 60, seconds % 60
	return h > 0 and string.format("%d:%02d:%02d", h, m, s) or string.format("%02d:%02d", m, s)
end

---------------------------------------------------------------- fenêtre
local gui = new("ScreenGui", {Name = "AdminPanelGui", ResetOnSpawn = false, DisplayOrder = 50}, player:WaitForChild("PlayerGui"))

-- bouton d'ouverture : dégradé bleu glacé
local openButton = new("TextButton", {Name = "Open", Text = "", AutoButtonColor = false, BorderSizePixel = 0, Position = UDim2.fromOffset(12, 8), Size = UDim2.fromOffset(122, 42)}, gui)
gradient(openButton, ICE)
border(openButton, 3.5)
studs(openButton, 22)
new("Frame", {BackgroundColor3 = WHITE, BackgroundTransparency = 0.55, BorderSizePixel = 0, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 0, 8), ZIndex = 2}, openButton) -- reflet
title(openButton, "ADMIN", UDim2.fromScale(0.08, 0.14), UDim2.fromScale(0.84, 0.72), WHITE, 3, Enum.TextXAlignment.Center).ZIndex = 4

local main = new("Frame", {Name = "Main", Visible = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(840, 548), BorderSizePixel = 0}, gui)
gradient(main, {WHITE, rgb(224, 228, 240)})
border(main, 4)
studs(main, 30)
local fit = new("UIScale", {}, main)
local function refit()
	local view = workspace.CurrentCamera.ViewportSize
	if view.X > 200 and view.Y > 200 then fit.Scale = math.min(1, view.X / 880, view.Y / 600) end
end
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(refit)
refit()

local header = new("Frame", {Name = "Header", BorderSizePixel = 0, Position = UDim2.fromOffset(12, 12), Size = UDim2.new(1, -24, 0, 58), ZIndex = 2}, main)
gradient(header, {ICE[3], ICE[2], ICE[3]}, 0)
border(header, 3)
studs(header, 28).ZIndex = 2
title(header, "Admin Panel", UDim2.fromOffset(16, 8), UDim2.new(0, 320, 1, -16), WHITE, 4)
local status = title(header, "", UDim2.new(0, 340, 0, 18), UDim2.new(1, -420, 1, -36), rgb(255, 240, 150), 2.5, Enum.TextXAlignment.Right)
local close = button(header, "X", UDim2.new(1, -52, 0, 7), UDim2.fromOffset(44, 44), RED)

local statusId = 0
local function say(text, bad)
	statusId += 1
	local id = statusId
	status.Text = text
	status.TextColor3 = bad and rgb(255, 150, 140) or rgb(190, 255, 170)
	task.delay(4, function() if statusId == id then status.Text = "" end end)
end

local tabColumn = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 82), Size = UDim2.new(0, 168, 1, -94), ZIndex = 2}, main)
new("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, tabColumn)
local content = new("Frame", {BorderSizePixel = 0, Position = UDim2.fromOffset(192, 82), Size = UDim2.new(1, -204, 1, -94), ZIndex = 2}, main)
gradient(content, {rgb(236, 238, 246), rgb(204, 208, 222)})
border(content, 3)

local pages, tabs = {}, {}
local function showPage(name)
	for pageName, page in pages do page.Visible = pageName == name end
	for tabName, tab in tabs do
		local on = tabName == name
		tab.Shade.Color = ColorSequence.new(on and ICE[2] or rgb(250, 250, 255), on and ICE[3] or rgb(200, 204, 220))
		tab.Size = UDim2.new(1, on and 0 or -10, 0, 46)
	end
end
local function newPage(name, order)
	local tab = new("TextButton", {Name = name, Text = "", AutoButtonColor = false, BorderSizePixel = 0, BackgroundColor3 = WHITE, Size = UDim2.new(1, -10, 0, 46), LayoutOrder = order, ZIndex = 3}, tabColumn)
	new("UIGradient", {Name = "Shade", Rotation = 90}, tab)
	border(tab, 3)
	studs(tab, 24).ZIndex = 3
	title(tab, name, UDim2.fromScale(0.08, 0.2), UDim2.fromScale(0.84, 0.6), WHITE, 3, Enum.TextXAlignment.Center).ZIndex = 5
	local page = new("ScrollingFrame", {Name = name, Visible = false, BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(8, 8), Size = UDim2.new(1, -16, 1, -16), CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 5, ScrollBarImageColor3 = BLACK, ScrollingDirection = Enum.ScrollingDirection.Y, ZIndex = 2}, content)
	new("UIListLayout", {Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder}, page)
	new("UIPadding", {PaddingTop = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 6)}, page)
	pages[name], tabs[name] = page, tab
	tab.Activated:Connect(function() showPage(name) end)
	return page
end
local cardOrder = 0
local function card(page, text, height, colors)
	cardOrder += 1
	local frame = new("Frame", {BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, height), LayoutOrder = cardOrder, ZIndex = 2}, page)
	gradient(frame, {WHITE, rgb(232, 235, 245)})
	border(frame, 3)
	local band = new("Frame", {BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 30), ZIndex = 2}, frame)
	gradient(band, colors or {ICE[2], ICE[3]}, 0)
	studs(band, 22).ZIndex = 2
	new("Frame", {BackgroundColor3 = BLACK, BorderSizePixel = 0, Position = UDim2.new(0, 0, 1, 0), Size = UDim2.new(1, 0, 0, 3), ZIndex = 3}, band)
	title(band, text, UDim2.fromOffset(10, 4), UDim2.new(1, -20, 1, -8), WHITE, 2.5)
	return frame
end

-- grille d'œufs (ou d'animaux) à choisir, triés par rareté
local function eggPicker(parent, position, height, usePets, onPick, petNames) -- petNames : affiche le nom de l'animal au lieu de celui de l'œuf
	local frame = new("ScrollingFrame", {BorderSizePixel = 0, BackgroundColor3 = rgb(246, 247, 252), Position = position, Size = UDim2.new(1, -24, 0, height), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 5, ScrollBarImageColor3 = BLACK, ZIndex = 3}, parent)
	border(frame, 2.5)
	new("UIGridLayout", {CellSize = UDim2.fromOffset(134, 26), CellPadding = UDim2.fromOffset(6, 6), SortOrder = Enum.SortOrder.LayoutOrder}, frame)
	new("UIPadding", {PaddingTop = UDim.new(0, 6), PaddingLeft = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6)}, frame)
	local group = choice(onPick)
	local list = {}
	for key, egg in Config.Eggs do table.insert(list, {Key = key, Egg = egg}) end
	table.sort(list, function(a, b) return a.Egg.Order < b.Egg.Order end)
	for index, entry in list do
		local petKey = entry.Egg.Pets[1].Pet
		local value = usePets and petKey or entry.Key
		local text = (usePets or petNames) and (Config.Pets[petKey] and Config.Pets[petKey].Name or petKey) or entry.Egg.Name
		local b, s = chip(frame, text, RARITY_TINT[entry.Egg.Rarity])
		b.LayoutOrder = index
		if usePets then
			b.Activated:Connect(function() onPick(value) end)
		else
			group.Add(value, b, s)
		end
	end
	return group
end

---------------------------------------------------------------- ANNOUNCE
do
	local page = newPage("Announce", 1)
	local c = card(page, "Announcement", 236)
	local box = input(c, "Type your announcement...", UDim2.fromOffset(12, 42), UDim2.new(1, -24, 0, 74))
	box.TextWrapped, box.TextYAlignment, box.MultiLine = true, Enum.TextYAlignment.Top, false
	local counter = note(c, "0/100", UDim2.new(1, -92, 0, 118), UDim2.fromOffset(80, 18), Enum.TextXAlignment.Right)
	box:GetPropertyChangedSignal("Text"):Connect(function()
		if #box.Text > 100 then box.Text = string.sub(box.Text, 1, 100) end
		counter.Text = #box.Text .. "/100"
	end)
	note(c, "Quick messages:", UDim2.fromOffset(12, 118), UDim2.fromOffset(200, 18))
	local presets = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 140), Size = UDim2.new(1, -24, 0, 28), ZIndex = 3}, c)
	new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6)}, presets)
	for _, text in {"New code released!", "Event starting soon!", "2x Luck is live!", "Server restart in 5 min!"} do
		chip(presets, text, rgb(215, 240, 255), function() box.Text = text end).Size = UDim2.fromOffset(140, 28)
	end
	local function send(scope)
		if box.Text == "" then say("Write a message first", true) return end
		remotes.Announce:FireServer(box.Text, scope)
		say(scope == "server" and "Announcement sent to this server!" or "Announcement sent to ALL servers!")
		box.Text = ""
	end
	button(c, "Send Server", UDim2.new(1, -372, 0, 182), UDim2.fromOffset(176, 42), GREEN, function() send("server") end)
	button(c, "Send Global", UDim2.new(1, -188, 0, 182), UDim2.fromOffset(176, 42), {ICE[2], ICE[3]}, function() send("global") end)
	note(c, "Max 100 characters. Shown at the top of the screen.", UDim2.fromOffset(12, 182), UDim2.new(1, -396, 0, 42))
end

---------------------------------------------------------------- GIVE (argent + œufs)
local playerList = {}
local refreshPlayers
do
	local page = newPage("Give", 2)
	local c = card(page, "1 · Choose a player", 122)
	local chips = new("ScrollingFrame", {BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(12, 40), Size = UDim2.new(1, -24, 0, 34), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.X,
		ScrollingDirection = Enum.ScrollingDirection.X, ScrollBarThickness = 3, ZIndex = 3}, c)
	new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6)}, chips)
	new("UIPadding", {PaddingTop = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3)}, chips)
	local nameBox = input(c, "...or type a username", UDim2.fromOffset(12, 80), UDim2.fromOffset(260, 30), player.Name)
	note(c, "Any @username, on any server. Offline? They get it when they join.", UDim2.fromOffset(284, 80), UDim2.new(1, -296, 0, 30))
	refreshPlayers = function()
		for _, child in chips:GetChildren() do
			if child:IsA("TextButton") then child:Destroy() end
		end
		for _, entry in playerList do
			chip(chips, "@" .. entry.Name, rgb(215, 240, 255), function() nameBox.Text = entry.Name end).Size = UDim2.fromOffset(math.clamp(#entry.Name * 9 + 30, 80, 180), 26)
		end
	end
	local function target()
		local name = string.gsub(nameBox.Text, "^@", "")
		if name == "" then say("Choose a player first", true) return nil end
		return name
	end

	local m = card(page, "2 · Give money", 116, GOLD)
	local amountBox = input(m, "Amount (ex: 500, 10k, 2.5m, 1b)", UDim2.fromOffset(12, 42), UDim2.fromOffset(240, 30))
	local quick = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(262, 42), Size = UDim2.new(1, -274, 0, 30), ZIndex = 3}, m)
	new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6)}, quick)
	for _, text in {"1K", "100K", "1M", "100M", "1B"} do
		chip(quick, text, rgb(255, 240, 180), function() amountBox.Text = text end).Size = UDim2.fromOffset(52, 28)
	end
	local function money(sign)
		local name, amount = target(), parseNumber(amountBox.Text)
		if not name then return end
		if not amount or amount <= 0 then say("Invalid amount", true) return end
		remotes.GiveCoins:FireServer(name, math.floor(amount) * sign)
		say((sign > 0 and "Giving " or "Removing ") .. Config.FormatMoney(math.floor(amount)) .. (sign > 0 and " to " or " from ") .. name)
	end
	button(m, "Give", UDim2.fromOffset(12, 78), UDim2.fromOffset(150, 32), GREEN, function() money(1) end)
	button(m, "Remove", UDim2.fromOffset(170, 78), UDim2.fromOffset(150, 32), RED, function() money(-1) end)

	local e = card(page, "3 · Give an animal", 286, VIOLET)
	local picked
	eggPicker(e, UDim2.fromOffset(12, 40), 150, false, function(value) picked = value end, true)
	local kgBox = input(e, "Weight in kg (empty = random)", UDim2.fromOffset(12, 200), UDim2.fromOffset(250, 30))
	local countBox = input(e, "How many", UDim2.fromOffset(270, 200), UDim2.fromOffset(100, 30), "1")
	chip(e, "Random weight", rgb(235, 215, 255), function() kgBox.Text = "" end).Position = UDim2.fromOffset(378, 201)
	e:FindFirstChildWhichIsA("TextButton", false)
	for _, child in e:GetChildren() do
		if child:IsA("TextButton") and child.Text == "Random weight" then child.Size = UDim2.fromOffset(130, 28) end
	end
	button(e, "Give animal", UDim2.fromOffset(12, 240), UDim2.fromOffset(200, 36), GREEN, function()
		local name = target()
		if not name then return end
		if not picked then say("Choose an animal first", true) return end
		local kg = kgBox.Text ~= "" and parseNumber(kgBox.Text) or nil
		if kgBox.Text ~= "" and (not kg or kg <= 0) then say("Invalid weight", true) return end
		remotes.GiveEgg:FireServer(name, picked, kg, tonumber(countBox.Text) or 1)
		local petInfo = Config.Pets[Config.Eggs[picked].Pets[1].Pet]
		say("Giving " .. (petInfo and petInfo.Name or picked) .. " to " .. name)
	end)
	note(e, "Random weight = the normal weight of this animal. Max 20 at once.", UDim2.fromOffset(224, 240), UDim2.new(1, -236, 0, 36))
end

---------------------------------------------------------------- SPAWN EGG
do
	local page = newPage("Spawn Egg", 3)
	local c = card(page, "1 · Egg", 200, VIOLET)
	local picked
	eggPicker(c, UDim2.fromOffset(12, 40), 148, false, function(value) picked = value end)

	local z = card(page, "2 · Zone where it appears", 112)
	local zoneGrid = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 40), Size = UDim2.new(1, -24, 0, 64), ZIndex = 3}, z)
	new("UIGridLayout", {CellSize = UDim2.fromOffset(138, 28), CellPadding = UDim2.fromOffset(6, 6), SortOrder = Enum.SortOrder.LayoutOrder}, zoneGrid)
	local zone = choice()
	local zoneNames = {}
	for _, part in CollectionService:GetTagged("EggZoneArea") do
		if part:GetAttribute("ZoneRarity") then zoneNames[part:GetAttribute("ZoneRarity")] = part:GetAttribute("ZoneTitle") end
	end
	for index, rarity in RARITY_ORDER do
		local b, s = chip(zoneGrid, zoneNames[rarity] or (rarity .. " Zone"), RARITY_TINT[rarity])
		b.LayoutOrder = index
		zone.Add(rarity, b, s)
	end
	zone.Select("Common")

	local o = card(page, "3 · Options", 204, GOLD)
	note(o, "Weight", UDim2.fromOffset(12, 40), UDim2.fromOffset(120, 28))
	local kgBox = input(o, "kg (empty = random)", UDim2.fromOffset(110, 40), UDim2.fromOffset(190, 28))
	local randomChip = chip(o, "Random (classic chances)", rgb(255, 240, 180), function() kgBox.Text = "" end)
	randomChip.Position, randomChip.Size = UDim2.fromOffset(308, 40), UDim2.fromOffset(200, 28)
	note(o, "Stays for", UDim2.fromOffset(12, 76), UDim2.fromOffset(120, 28))
	local timerBox = input(o, "seconds", UDim2.fromOffset(110, 76), UDim2.fromOffset(100, 28), "60")
	note(o, "seconds (10 to 3600)", UDim2.fromOffset(218, 76), UDim2.fromOffset(220, 28))
	note(o, "Where", UDim2.fromOffset(12, 112), UDim2.fromOffset(120, 28))
	local mode = choice()
	local hereChip, hereStroke = chip(o, "This server", rgb(215, 240, 255))
	hereChip.Position, hereChip.Size = UDim2.fromOffset(110, 112), UDim2.fromOffset(110, 28)
	local allChip, allStroke = chip(o, "ALL servers", rgb(215, 240, 255))
	allChip.Position, allChip.Size = UDim2.fromOffset(226, 112), UDim2.fromOffset(110, 28)
	local someChip, someStroke = chip(o, "Random servers:", rgb(215, 240, 255))
	someChip.Position, someChip.Size = UDim2.fromOffset(342, 112), UDim2.fromOffset(140, 28)
	local countBox = input(o, "how many", UDim2.fromOffset(488, 112), UDim2.fromOffset(80, 28), "1")
	mode.Add("Here", hereChip, hereStroke)
	mode.Add("All", allChip, allStroke)
	mode.Add("Some", someChip, someStroke)
	mode.Select("Here")
	button(o, "Spawn egg", UDim2.fromOffset(12, 154), UDim2.fromOffset(200, 40), GREEN, function()
		if not picked then say("Choose an egg first", true) return end
		local kg = kgBox.Text ~= "" and parseNumber(kgBox.Text) or nil
		if kgBox.Text ~= "" and (not kg or kg <= 0) then say("Invalid weight", true) return end
		local timer = math.clamp(math.floor(tonumber(timerBox.Text) or 60), 10, 3600)
		if mode.Value == "Here" then
			remotes.SpawnLocalEgg:FireServer(picked, zone.Value, timer, kg)
		elseif mode.Value == "All" then
			remotes.SpawnGlobalEgg:FireServer(picked, zone.Value, timer, kg)
		else
			local count = math.floor(tonumber(countBox.Text) or 0)
			if count < 1 then say("Invalid number of servers", true) return end
			remotes.SpawnRandomServerEgg:FireServer(picked, zone.Value, timer, count, kg)
		end
		say(Config.Eggs[picked].Name .. " -> " .. (zoneNames[zone.Value] or (zone.Value .. " Zone")))
	end)
	note(o, "Random weight uses the normal egg chances (giant eggs stay very rare).", UDim2.fromOffset(224, 154), UDim2.new(1, -236, 0, 40))
end

---------------------------------------------------------------- EVENTS
local eventStatus = {}
do
	local page = newPage("Events", 4)
	local BLUE = {ICE[2], ICE[3]}
	local function stateLabel(c)
		local state = title(c, "OFF", UDim2.new(1, -170, 0, 5), UDim2.fromOffset(160, 20), WHITE, 2.5, Enum.TextXAlignment.Right)
		state.Parent = c:FindFirstChildWhichIsA("Frame")
		return state
	end
	-- chaque event : durée, puis "Start Server" (ce serveur), "Start Global" (tous les serveurs) et "Stop"
	local function eventCard(name, description, colors, default, endAttribute, useServerClock, onStart, onStop, extraBox)
		local c = card(page, name, 112, colors)
		note(c, description, UDim2.fromOffset(12, 36), UDim2.new(1, -24, 0, 30))
		local x = 12
		local durationBox = input(c, "Duration (10 = 10 min, 90s, 1h)", UDim2.fromOffset(x, 70), UDim2.fromOffset(extraBox and 110 or 170, 30), default)
		x += (extraBox and 110 or 170) + 8
		local extra
		if extraBox then
			extra = input(c, extraBox, UDim2.fromOffset(x, 70), UDim2.fromOffset(124, 30))
			x += 132
		end
		local width = (596 - x - 12) / 3
		local function start(scope)
			local seconds = parseDuration(durationBox.Text)
			if not seconds or seconds < 1 then say("Invalid duration", true) return end
			onStart(math.floor(seconds), extra and extra.Text or nil, scope)
			say(name .. (scope == "server" and " started on this server" or " started on ALL servers"))
		end
		button(c, "Start Server", UDim2.fromOffset(x, 68), UDim2.fromOffset(width, 34), GREEN, function() start("server") end)
		button(c, "Start Global", UDim2.fromOffset(x + width + 6, 68), UDim2.fromOffset(width, 34), BLUE, function() start("global") end)
		button(c, "Stop", UDim2.fromOffset(x + (width + 6) * 2, 68), UDim2.fromOffset(width, 34), RED, function()
			onStop()
			say(name .. " stopped")
		end)
		local state = stateLabel(c)
		table.insert(eventStatus, function()
			local finish = ReplicatedStorage:GetAttribute(endAttribute)
			local left = type(finish) == "number" and (finish - (useServerClock and workspace:GetServerTimeNow() or os.time())) or 0
			state.Text = left > 0 and ("ON · " .. clock(left)) or "OFF"
		end)
	end
	-- events du ciel (SkyEventsServer) : mutations x4 avec un effet autour de l'œuf et de l'animal
	local function skyCard(name, title, description, colors)
		eventCard(title, description, colors, "10", name .. "EventEnd", true,
			function(seconds, _, scope) remotes:WaitForChild("StartSkyEvent"):FireServer(name, "start", seconds, scope) end,
			function() local r = remotes:WaitForChild("StartSkyEvent") r:FireServer(name, "stop", nil, "server") r:FireServer(name, "stop") end)
	end
	skyCard("Meteor", "Meteor Shower", "Studs meteors fall on the egg zones (red circle before impact). Hit eggs: 50% chance of the x4 COSMIC trait.", {rgb(190, 150, 255), rgb(90, 50, 200)})
	skyCard("Storm", "Thunderstorm", "Storm clouds drift over the zones and lightning strikes eggs: 50% chance of the x4 STORM trait.", {rgb(140, 220, 255), rgb(40, 90, 170)})
	skyCard("Candy", "Candy Rain", "Cotton candy clouds drift over the zones and drop candies on eggs: 50% chance of the x4 CANDY trait.", {rgb(255, 160, 220), rgb(220, 70, 160)})
	skyCard("BloodMoon", "Blood Moon", "A giant red moon rises in the south and bats dive on eggs: 50% chance of the x4 BLOOD trait.", {rgb(255, 100, 100), rgb(120, 10, 30)})
	skyCard("Blizzard", "Blizzard", "Snow falls on the map and the Frost Spirit freezes 2-3 eggs per zone: 50% chance of the x4 FROZEN trait.", {rgb(200, 240, 255), rgb(80, 150, 220)})
	skyCard("Hacker", "Hacker Attack", "A hacker drone scans every zone: each zone has a 50% chance to get 3 eggs with the x5 HACKED trait. Green code screen + glitches.", {rgb(90, 255, 140), rgb(10, 90, 40)})
	skyCard("Ufo", "UFO Invasion", "A flying saucer goes from zone to zone and scans 2-3 eggs with its beam: 50% chance of the x4 ALIEN trait.", {rgb(150, 255, 140), rgb(30, 150, 70)})
	eventCard("Countdown", "A countdown at the top of the screen (with your own text).", GOLD, "10", "CountdownEnd", false,
		function(seconds, text, scope) remotes.UpdateTimer:FireServer(seconds, text or "", scope) end,
		function() remotes.UpdateTimer:FireServer(0, "", "server") remotes.UpdateTimer:FireServer(0, "") end, "Text (ex: UPDATE)")

	-- nuit : pas de durée à choisir (mur 25 s, œufs réinitialisés, nuit de 4 min 30)
	local n = card(page, "Night", 112, {rgb(150, 160, 255), rgb(50, 50, 150)})
	note(n, "Everyone goes back to spawn, the night wall appears for 25 s, then all the eggs are reset.", UDim2.fromOffset(12, 36), UDim2.new(1, -24, 0, 30))
	button(n, "Start Server", UDim2.fromOffset(12, 68), UDim2.fromOffset(180, 34), GREEN, function()
		remotes.StartNight:FireServer("server")
		say("Night started on this server")
	end)
	button(n, "Start Global", UDim2.fromOffset(198, 68), UDim2.fromOffset(180, 34), BLUE, function()
		remotes.StartNight:FireServer("global")
		say("Night started on ALL servers")
	end)
	local nightState = stateLabel(n)
	table.insert(eventStatus, function()
		local now = workspace:GetServerTimeNow()
		local finish, nextAt = ReplicatedStorage:GetAttribute("NightEnd"), ReplicatedStorage:GetAttribute("NightAt")
		if type(finish) == "number" and finish > now then nightState.Text = "ON · " .. clock(finish - now)
		elseif type(nextAt) == "number" then nightState.Text = "IN " .. clock(nextAt - now)
		else nightState.Text = "OFF" end
	end)

end

---------------------------------------------------------------- POLL (createglobalpoll : question OUI / NON dans tous les serveurs)
do
	local page = newPage("Poll", 7)
	local c = card(page, "Create a global poll", 262, {ICE[2], ICE[3]})
	local box = input(c, "Your question (ex: Do you want a new zone?)", UDim2.fromOffset(12, 42), UDim2.new(1, -24, 0, 60))
	box.TextWrapped, box.TextYAlignment = true, Enum.TextYAlignment.Top
	local counter = note(c, "0/120", UDim2.new(1, -92, 0, 104), UDim2.fromOffset(80, 18), Enum.TextXAlignment.Right)
	box:GetPropertyChangedSignal("Text"):Connect(function()
		if #box.Text > 120 then box.Text = string.sub(box.Text, 1, 120) end
		counter.Text = #box.Text .. "/120"
	end)
	note(c, "Ideas:", UDim2.fromOffset(12, 104), UDim2.fromOffset(200, 18))
	local presets = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 126), Size = UDim2.new(1, -24, 0, 28), ZIndex = 3}, c)
	new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6)}, presets)
	for _, text in {"Do you like the update?", "Admin abuse tonight?", "Do you want a new zone?", "Is the game too hard?"} do
		chip(presets, text, rgb(215, 240, 255), function() box.Text = text end).Size = UDim2.fromOffset(146, 28)
	end
	note(c, "Duration", UDim2.fromOffset(12, 164), UDim2.fromOffset(80, 30))
	local durationBox = input(c, "seconds", UDim2.fromOffset(90, 164), UDim2.fromOffset(150, 30), "120")
	note(c, "In SECONDS (10 to 3600). Players vote YES (left) or NO (right) and see the live score of every server.", UDim2.fromOffset(250, 160), UDim2.new(1, -262, 0, 38))
	button(c, "Start Global Poll", UDim2.fromOffset(12, 210), UDim2.fromOffset(260, 40), {ICE[2], ICE[3]}, function()
		if box.Text == "" then say("Write a question first", true) return end
		local seconds = tonumber(durationBox.Text) -- en secondes
		if not seconds or seconds < 10 then say("Invalid duration (min 10 s)", true) return end
		remotes.CreateGlobalPoll:FireServer("start", box.Text, math.floor(math.min(seconds, 3600)))
		say("Poll sent to ALL servers!")
		box.Text = ""
	end)
	button(c, "End Poll", UDim2.fromOffset(280, 210), UDim2.fromOffset(160, 40), RED, function()
		remotes.CreateGlobalPoll:FireServer("stop")
		say("Poll ended on all servers")
	end)

	local r = card(page, "Live results (all servers)", 126, GREEN)
	local qLabel = note(r, "No poll running.", UDim2.fromOffset(12, 36), UDim2.new(1, -24, 0, 30))
	local yesLabel = title(r, "YES  0", UDim2.fromOffset(12, 70), UDim2.fromOffset(180, 26), rgb(90, 220, 90), 2.5)
	local noLabel = title(r, "NO  0", UDim2.fromOffset(200, 70), UDim2.fromOffset(180, 26), rgb(255, 100, 100), 2.5)
	local pollState = title(r, "", UDim2.new(1, -170, 0, 70), UDim2.fromOffset(158, 26), WHITE, 2.5, Enum.TextXAlignment.Right)
	local last
	remotes.PollUpdate.OnClientEvent:Connect(function(s)
		if type(s) ~= "table" then return end
		last = s
		local total = s.Yes + s.No
		local pct = function(n) return total > 0 and math.floor(n / total * 100 + 0.5) or 0 end
		qLabel.Text = "\"" .. s.Question .. "\"  (by " .. tostring(s.By) .. ")"
		yesLabel.Text = "YES  " .. s.Yes .. "  (" .. pct(s.Yes) .. "%)"
		noLabel.Text = "NO  " .. s.No .. "  (" .. pct(s.No) .. "%)"
	end)
	table.insert(eventStatus, function()
		if not last then pollState.Text = "OFF" return end
		local left = last.EndsAt - workspace:GetServerTimeNow()
		pollState.Text = (last.Ended or left <= 0) and "ENDED" or ("ON · " .. clock(left))
	end)
end

---------------------------------------------------------------- TOOLS (reset des données, kick, ban)
local refreshToolPlayers
do
	local page = newPage("Tools", 6)
	local DARK_RED = {rgb(230, 60, 70), rgb(120, 10, 30)}
	-- bouton dangereux : il faut cliquer deux fois
	local function confirmButton(parent, text, position, size, colors, action)
		local armedUntil = 0
		local b, label
		b, label = button(parent, text, position, size, colors, function()
			if os.clock() < armedUntil then
				armedUntil = 0
				label.Text = text
				action()
			else
				armedUntil = os.clock() + 3
				label.Text = "Click again!"
				task.delay(3, function() if os.clock() >= armedUntil then label.Text = text end end)
			end
		end)
		return b
	end

	local c = card(page, "Player", 122)
	local chips = new("ScrollingFrame", {BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(12, 40), Size = UDim2.new(1, -24, 0, 34), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.X,
		ScrollingDirection = Enum.ScrollingDirection.X, ScrollBarThickness = 3, ZIndex = 3}, c)
	new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6)}, chips)
	new("UIPadding", {PaddingTop = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3)}, chips)
	local nameBox = input(c, "@username", UDim2.fromOffset(12, 80), UDim2.fromOffset(260, 30))
	note(c, "Players of this server are listed above. You can type any @username.", UDim2.fromOffset(284, 80), UDim2.new(1, -296, 0, 30))
	refreshToolPlayers = function()
		for _, child in chips:GetChildren() do
			if child:IsA("TextButton") then child:Destroy() end
		end
		for _, entry in playerList do
			chip(chips, "@" .. entry.Name, rgb(215, 240, 255), function() nameBox.Text = "@" .. entry.Name end).Size = UDim2.fromOffset(math.clamp(#entry.Name * 9 + 30, 80, 180), 26)
		end
	end
	local function target()
		local name = string.gsub(nameBox.Text, "^@", "")
		if name == "" then say("Choose a player first", true) return nil end
		return name
	end

	local r = card(page, "Reset data", 122, RED)
	note(r, "The player loses EVERYTHING (money, animals, eggs, upgrades, dragons, plants) and is sent back to their base.", UDim2.fromOffset(12, 36), UDim2.new(1, -24, 0, 32))
	confirmButton(r, "Reset Data", UDim2.fromOffset(12, 76), UDim2.fromOffset(200, 36), RED, function()
		local name = target()
		if not name then return end
		remotes.ResetData:FireServer(name)
		say("Resetting " .. name .. "...")
	end)
	confirmButton(r, "Reset Data Global", UDim2.fromOffset(220, 76), UDim2.fromOffset(240, 36), DARK_RED, function()
		remotes.ResetDataGlobal:FireServer()
		say("GLOBAL reset sent")
	end)
	note(r, "Global = EVERY player, every server.", UDim2.fromOffset(468, 76), UDim2.new(1, -480, 0, 36))

	local k = card(page, "Kick / Ban", 164, GOLD)
	local reasonBox = input(k, "Reason shown to the player (optional)", UDim2.fromOffset(12, 40), UDim2.new(1, -24, 0, 30))
	button(k, "Kick", UDim2.fromOffset(12, 78), UDim2.fromOffset(140, 34), GOLD, function()
		local name = target()
		if not name then return end
		remotes.KickPlayer:FireServer(name, reasonBox.Text)
		say("Kicking " .. name)
	end)
	confirmButton(k, "Kick All Server", UDim2.fromOffset(158, 78), UDim2.fromOffset(200, 34), RED, function()
		remotes.KickAll:FireServer("server", reasonBox.Text)
		say("Kicking everyone on this server")
	end)
	confirmButton(k, "Kick All Global", UDim2.fromOffset(364, 78), UDim2.fromOffset(200, 34), DARK_RED, function()
		remotes.KickAll:FireServer("global", reasonBox.Text)
		say("Kicking everyone on ALL servers")
	end)
	confirmButton(k, "Ban", UDim2.fromOffset(12, 120), UDim2.fromOffset(140, 34), DARK_RED, function()
		local name = target()
		if not name then return end
		remotes.BanPlayer:FireServer(name, reasonBox.Text)
		say("Banning " .. name)
	end)
	button(k, "Unban", UDim2.fromOffset(158, 120), UDim2.fromOffset(140, 34), GREEN, function()
		local name = target()
		if not name then return end
		remotes.UnbanPlayer:FireServer(name)
		say("Unbanning " .. name)
	end)
	note(k, "Ban is permanent and works even if the player is offline. Admins can never be kicked or banned.", UDim2.fromOffset(306, 120), UDim2.new(1, -318, 0, 34))

	-- Fuse Machine : termine d'un coup toutes les fusions en cours, dans tous les serveurs (même pour les joueurs hors ligne)
	local f = card(page, "Fuse Machine", 112, VIOLET)
	note(f, "GLOBALSKIPFUSE: every fusion started before now is finished instantly on ALL servers. Players can claim their pet right away.", UDim2.fromOffset(12, 36), UDim2.new(1, -24, 0, 30))
	confirmButton(f, "GLOBALSKIPFUSE", UDim2.fromOffset(12, 70), UDim2.fromOffset(240, 34), VIOLET, function()
		remotes:WaitForChild("GlobalSkipFuse"):FireServer()
		say("GLOBALSKIPFUSE sent to ALL servers")
	end)
end

---------------------------------------------------------------- ouverture / fermeture, synchronisation
local function setOpen(open)
	main.Visible = open
	if open then
		refit()
		remotes.RequestSync:FireServer()
		fit.Scale *= 0.85
		local target = fit.Scale / 0.85
		TweenService:Create(fit, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = target}):Play()
	end
end
openButton.Activated:Connect(function() setOpen(not main.Visible) end)
close.Activated:Connect(function() setOpen(false) end)
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.F2 then setOpen(not main.Visible) end
end)

remotes.SyncPlayers.OnClientEvent:Connect(function(list)
	playerList = type(list) == "table" and list or {}
	refreshPlayers()
	if refreshToolPlayers then refreshToolPlayers() end
end)

showPage("Announce")
while true do
	if main.Visible then
		for _, update in eventStatus do update() end
	end
	task.wait(0.5)
end

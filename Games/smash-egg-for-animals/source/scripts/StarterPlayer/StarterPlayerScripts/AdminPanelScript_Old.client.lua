-- AdminPanelScript v2 : panneau admin simplifié.  F2 (ou bouton ⚙) pour ouvrir/fermer, fenêtre déplaçable.
-- Accès réservé aux AdminConfig.AdminIds. Toutes les vérifications importantes restent côté serveur (AdminServer).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
if not table.find(AdminConfig.AdminIds, player.UserId) then
	return -- pas admin : rien du tout
end

local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local EggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local EggConfig = require(EggSystem:WaitForChild("EggConfig"))
local notifyRemote = EggSystem:WaitForChild("Remotes"):WaitForChild("Notify")

---------------------------------------------------------------- thème
local C = {
	bg = Color3.fromRGB(18, 18, 26),
	side = Color3.fromRGB(24, 24, 34),
	card = Color3.fromRGB(36, 36, 50),
	field = Color3.fromRGB(50, 50, 68),
	text = Color3.fromRGB(240, 240, 248),
	sub = Color3.fromRGB(165, 165, 185),
	blue = Color3.fromRGB(70, 130, 255),
	green = Color3.fromRGB(50, 180, 90),
	red = Color3.fromRGB(215, 65, 65),
	orange = Color3.fromRGB(240, 140, 40),
	gold = Color3.fromRGB(255, 205, 60),
	purple = Color3.fromRGB(140, 85, 225),
	dark = Color3.fromRGB(20, 20, 28),
}
local FONT = "rbxasset://fonts/families/Montserrat.json"
local function F(weight) return Font.new(FONT, weight or Enum.FontWeight.SemiBold) end

local RARITY_ORDER = {Common = 1, Uncommon = 2, Rare = 3, Epic = 4, Legendary = 5, Mythic = 6, Secret = 7}
local RARITY_COLOR = {
	Common = Color3.fromRGB(190, 190, 200), Uncommon = Color3.fromRGB(110, 220, 110), Rare = Color3.fromRGB(90, 165, 255),
	Epic = Color3.fromRGB(190, 110, 255), Legendary = Color3.fromRGB(255, 190, 50), Mythic = Color3.fromRGB(255, 90, 120),
	Secret = Color3.fromRGB(40, 230, 230),
}
local ZONES = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret"} -- zones acceptées par le serveur
local MIN_TIMER, MAX_TIMER = 10, 3600 -- secondes (oeuf spawné)

-- listes d'oeufs et de pets lues dans EggConfig (toujours à jour)
local eggItems, petItems, petNames = {}, {}, {}
for key, egg in EggConfig.Eggs do
	table.insert(eggItems, {key = key, text = egg.Name or key, rarity = egg.Rarity, color = RARITY_COLOR[egg.Rarity] or C.text, order = egg.Order or 999})
end
for key, pet in EggConfig.Pets do
	petNames[key] = pet.Name or key
	table.insert(petItems, {key = key, text = pet.Name or key, rarity = pet.Rarity, color = RARITY_COLOR[pet.Rarity] or C.text, order = RARITY_ORDER[pet.Rarity] or 99})
end
local function byOrder(a, b)
	if a.order ~= b.order then return a.order < b.order end
	return a.key < b.key
end
table.sort(eggItems, byOrder)
table.sort(petItems, byOrder)

local currentPlayers, currentStock, currentCodes = {}, {}, {}

---------------------------------------------------------------- utilitaires
local function parseNumber(str) -- "1000", "1,000", "10k", "2.5m", "1b"
	local s = string.lower(tostring(str or ""))
	s = s:gsub("[%s,_]", "")
	local num, suffix = s:match("^(%d*%.?%d+)([kmbt]?)$")
	if not num then return nil end
	local mult = ({k = 1e3, m = 1e6, b = 1e9, t = 1e12})[suffix] or 1
	return math.floor(tonumber(num) * mult)
end

local function parseDuration(str) -- "90s", "5m", "1h30m" ; un nombre seul = minutes
	local s = string.lower(tostring(str or ""))
	local total, found = 0, false
	for num, unit in string.gmatch(s, "(%d+%.?%d*)%s*([hms]?)") do
		local n = tonumber(num)
		if n then
			if unit == "h" then total += n * 3600 elseif unit == "s" then total += n else total += n * 60 end
			found = true
		end
	end
	return found and math.floor(total) or nil
end

local function fmt(n) -- 1234567 -> "1,234,567"
	local s = tostring(math.floor(math.abs(n)))
	local out = s:reverse():gsub("(%d%d%d)", "%1,")
	out = out:reverse()
	if out:sub(1, 1) == "," then out = out:sub(2) end
	return (n < 0 and "-" or "") .. out
end

local function formatTime(secs)
	secs = math.max(0, math.floor(secs))
	local h, m, s = secs // 3600, secs % 3600 // 60, secs % 60
	if h > 0 then return string.format("%d:%02d:%02d", h, m, s) end
	return string.format("%d:%02d", m, s)
end

local function groupNames(keys) -- {"Dragon","Dragon","Wolf"} -> "Dragon x2, Wolf"
	local counts, order = {}, {}
	for _, k in keys do
		if not counts[k] then counts[k] = 0 table.insert(order, k) end
		counts[k] += 1
	end
	local parts = {}
	for _, k in order do
		table.insert(parts, (petNames[k] or k) .. (counts[k] > 1 and (" x" .. counts[k]) or ""))
	end
	return table.concat(parts, ", ")
end

---------------------------------------------------------------- briques d'interface
local layoutCounter = 0
local function make(parent, className, props)
	local obj = Instance.new(className)
	if obj:IsA("GuiObject") then obj.BorderSizePixel = 0 end
	for k, v in props or {} do obj[k] = v end
	if obj:IsA("GuiObject") and not (props and props.LayoutOrder) then
		layoutCounter += 1
		obj.LayoutOrder = layoutCounter -- l'ordre de création = l'ordre d'affichage
	end
	obj.Parent = parent
	return obj
end

local function corner(obj, r) return make(obj, "UICorner", {CornerRadius = UDim.new(0, r or 8)}) end
local function padding(obj, l, t, r, b)
	return make(obj, "UIPadding", {
		PaddingLeft = UDim.new(0, l), PaddingTop = UDim.new(0, t or l),
		PaddingRight = UDim.new(0, r or l), PaddingBottom = UDim.new(0, b or t or l),
	})
end
local function listLayout(obj, gap, props)
	local l = make(obj, "UIListLayout", {Padding = UDim.new(0, gap or 8), SortOrder = Enum.SortOrder.LayoutOrder})
	for k, v in props or {} do l[k] = v end
	return l
end

local function text(parent, str, size, color, weight, props)
	local l = make(parent, "TextLabel", {
		Text = str, TextSize = size or 14, TextColor3 = color or C.text, FontFace = F(weight),
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	})
	for k, v in props or {} do l[k] = v end
	return l
end

local function button(parent, str, color, size, onClick, props)
	local b = make(parent, "TextButton", {
		Text = str, TextSize = 15, FontFace = F(Enum.FontWeight.Bold), TextColor3 = Color3.new(1, 1, 1),
		BackgroundColor3 = color, Size = size or UDim2.new(0, 160, 0, 40), AutoButtonColor = true,
		TextTruncate = Enum.TextTruncate.AtEnd,
	})
	corner(b, 8)
	if onClick then b.Activated:Connect(onClick) end
	for k, v in props or {} do b[k] = v end
	return b
end

local function textBox(parent, placeholder, size, default)
	local b = make(parent, "TextBox", {
		PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(125, 125, 145), Text = default or "",
		TextSize = 15, FontFace = F(), TextColor3 = C.text, BackgroundColor3 = C.field,
		Size = size or UDim2.new(1, 0, 0, 38), ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left,
	})
	corner(b, 8)
	padding(b, 10, 0)
	return b
end

-- zone de saisie avec son titre au-dessus ; width = UDim
local function field(parent, title, placeholder, width, default)
	local f = make(parent, "Frame", {Size = UDim2.new(width.Scale, width.Offset, 0, 60), BackgroundTransparency = 1})
	listLayout(f, 4)
	text(f, title, 12, C.sub, Enum.FontWeight.Bold, {Size = UDim2.new(1, 0, 0, 16), AutomaticSize = Enum.AutomaticSize.None})
	return textBox(f, placeholder, UDim2.new(1, 0, 0, 38), default), f
end

local function flow(parent, gap, valign) -- ligne qui passe à la ligne si elle manque de place
	local f = make(parent, "Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1})
	listLayout(f, gap or 8, {FillDirection = Enum.FillDirection.Horizontal, Wraps = true, VerticalAlignment = valign or Enum.VerticalAlignment.Top})
	return f
end

local function chip(parent, str, onClick, color)
	local b = make(parent, "TextButton", {
		Text = str, TextSize = 13, FontFace = F(Enum.FontWeight.Bold), TextColor3 = C.text,
		BackgroundColor3 = color or C.field, Size = UDim2.new(0, 0, 0, 30), AutomaticSize = Enum.AutomaticSize.X,
		AutoButtonColor = true,
	})
	corner(b, 15)
	padding(b, 12, 0)
	if onClick then b.Activated:Connect(onClick) end
	return b
end

local function card(parent, title, subtitle)
	local c = make(parent, "Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = C.card})
	corner(c, 10)
	padding(c, 14)
	listLayout(c, 10)
	if title then text(c, title, 16, C.text, Enum.FontWeight.Bold) end
	if subtitle then text(c, subtitle, 13, C.sub) end
	return c
end

-- bouton qui demande une seconde pression pour confirmer
local function confirmButton(parent, normalText, confirmText, color, size, action)
	local b = button(parent, normalText, color, size)
	local armed, token = false, 0
	b.Activated:Connect(function()
		if armed then
			armed = false
			b.Text = normalText
			action()
			return
		end
		armed = true
		token += 1
		local mine = token
		b.Text = confirmText
		task.delay(3, function()
			if armed and token == mine then armed = false b.Text = normalText end
		end)
	end)
	return b
end

-- liste de choix avec recherche ; items = {{key, text, color}} ; onPick(item)
local function picker(parent, items, height, onPick)
	local holder = make(parent, "Frame", {Size = UDim2.new(1, 0, 0, height), BackgroundColor3 = C.field})
	corner(holder, 8)
	local search = make(holder, "TextBox", {
		PlaceholderText = "🔍  Search...", PlaceholderColor3 = Color3.fromRGB(125, 125, 145), Text = "", TextSize = 14,
		FontFace = F(), TextColor3 = C.text, BackgroundColor3 = C.card, Size = UDim2.new(1, -16, 0, 30),
		Position = UDim2.new(0, 8, 0, 8), ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left,
	})
	corner(search, 6)
	padding(search, 8, 0)
	local scroll = make(holder, "ScrollingFrame", {
		Size = UDim2.new(1, -16, 1, -54), Position = UDim2.new(0, 8, 0, 46), BackgroundTransparency = 1,
		ScrollBarThickness = 4, AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(),
	})
	make(scroll, "UIGridLayout", {CellSize = UDim2.new(0, 150, 0, 32), CellPadding = UDim2.new(0, 6, 0, 6), SortOrder = Enum.SortOrder.LayoutOrder})
	local entries = {}
	for i, item in items do
		local b = make(scroll, "TextButton", {
			Text = item.text, TextSize = 13, FontFace = F(Enum.FontWeight.Bold), TextColor3 = item.color or C.text,
			BackgroundColor3 = C.card, AutoButtonColor = true, TextTruncate = Enum.TextTruncate.AtEnd, LayoutOrder = i,
		})
		corner(b, 6)
		local stroke = make(b, "UIStroke", {Color = C.gold, Thickness = 2, Enabled = false})
		b.Activated:Connect(function() onPick(item) end)
		entries[item.key] = {button = b, stroke = stroke, item = item}
	end
	search:GetPropertyChangedSignal("Text"):Connect(function()
		local q = string.lower(search.Text)
		for _, e in entries do
			e.button.Visible = q == "" or string.find(string.lower(e.item.text), q, 1, true) ~= nil
		end
	end)
	local api = {}
	function api.select(key)
		for k, e in entries do e.stroke.Enabled = (k == key) end
	end
	return api
end

---------------------------------------------------------------- fenêtre
local HEADER_H = 52
local screenGui = make(player:WaitForChild("PlayerGui"), "ScreenGui", {
	Name = "AdminPanelGui", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	IgnoreGuiInset = true, DisplayOrder = 100,
})

local mainFrame = make(screenGui, "Frame", {
	Size = UDim2.fromOffset(780, 520), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
	BackgroundColor3 = C.bg, Visible = false, ClipsDescendants = true,
})
corner(mainFrame, 12)
make(mainFrame, "UIStroke", {Color = Color3.fromRGB(80, 80, 110), Thickness = 2})

local header = make(mainFrame, "Frame", {Size = UDim2.new(1, 0, 0, HEADER_H), BackgroundColor3 = C.side})
make(header, "TextLabel", {
	Text = "⚡ ADMIN PANEL", FontFace = F(Enum.FontWeight.ExtraBold), TextSize = 20, TextColor3 = C.gold,
	BackgroundTransparency = 1, Size = UDim2.new(0, 220, 1, 0), Position = UDim2.new(0, 16, 0, 0), TextXAlignment = Enum.TextXAlignment.Left,
})
local hint = make(header, "TextLabel", {
	Text = "F2 open/close  •  drag here to move", FontFace = F(), TextSize = 12, TextColor3 = C.sub,
	BackgroundTransparency = 1, Size = UDim2.new(0, 260, 1, 0), AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -62, 0, 0), TextXAlignment = Enum.TextXAlignment.Right,
})
local closeBtn = button(header, "✕", Color3.fromRGB(70, 40, 45), UDim2.fromOffset(38, 34), function() mainFrame.Visible = false end, {
	AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), TextSize = 16, TextColor3 = Color3.fromRGB(255, 120, 120),
})

local sidebar = make(mainFrame, "Frame", {Size = UDim2.new(0, 180, 1, -HEADER_H), Position = UDim2.new(0, 0, 0, HEADER_H), BackgroundColor3 = C.side})
padding(sidebar, 10)
listLayout(sidebar, 6)

local content = make(mainFrame, "Frame", {Size = UDim2.new(1, -180, 1, -HEADER_H), Position = UDim2.new(0, 180, 0, HEADER_H), BackgroundTransparency = 1})

-- message d'état en bas de la fenêtre
local toastFrame = make(mainFrame, "Frame", {
	AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 90, 1, -14), Size = UDim2.new(0, 0, 0, 38),
	AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = C.dark, Visible = false, ZIndex = 50,
})
corner(toastFrame, 10)
local toastStroke = make(toastFrame, "UIStroke", {Color = C.green, Thickness = 2})
padding(toastFrame, 16, 0)
local toastLabel = make(toastFrame, "TextLabel", {
	Text = "", FontFace = F(Enum.FontWeight.Bold), TextSize = 14, TextColor3 = C.text, BackgroundTransparency = 1,
	Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X, ZIndex = 51,
})
local toastToken = 0
local function toast(str, color)
	toastToken += 1
	local mine = toastToken
	toastLabel.Text = str
	toastLabel.TextColor3 = color or C.text
	toastStroke.Color = color or C.green
	toastFrame.Visible = true
	task.delay(3.5, function()
		if toastToken == mine then toastFrame.Visible = false end
	end)
end
local OK, BAD, WARN = C.green, C.red, C.orange

local function fire(remoteName, ...)
	local r = remotes:FindFirstChild(remoteName)
	if r then r:FireServer(...) else toast("Missing remote: " .. remoteName, BAD) end
end

-- résultat renvoyé par le serveur (code créé, joueur introuvable, event lancé...)
notifyRemote.OnClientEvent:Connect(function(message)
	if mainFrame.Visible and type(message) == "string" then toast(message, C.text) end
end)

---------------------------------------------------------------- pages + onglets
local pages, tabs, tabInfo = {}, {}, {}
local currentPage = "Announce"
local compact = false

local function showPage(id)
	currentPage = id
	for pid, frame in pages do frame.Visible = (pid == id) end
	for tid, tab in tabs do
		local on = tid == id
		tab.BackgroundColor3 = on and C.blue or C.card
		tab.TextColor3 = on and Color3.new(1, 1, 1) or C.sub
	end
end

local function newPage(id, icon, label, title, desc)
	local sf = make(content, "ScrollingFrame", {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ScrollBarThickness = 5, Visible = false,
		AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(), ScrollBarImageColor3 = Color3.fromRGB(110, 110, 140),
	})
	padding(sf, 14, 12, 18, 16)
	listLayout(sf, 12)
	pages[id] = sf
	tabInfo[id] = {icon = icon, label = label}
	local tab = button(sidebar, icon .. "  " .. label, C.card, UDim2.new(1, 0, 0, 44), function() showPage(id) end, {
		TextColor3 = C.sub, TextXAlignment = Enum.TextXAlignment.Left,
	})
	padding(tab, 14, 0)
	tabs[id] = tab
	local h = make(sf, "Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1})
	listLayout(h, 2)
	text(h, title, 22, C.text, Enum.FontWeight.ExtraBold)
	text(h, desc, 13, C.sub)
	return sf
end

---------------------------------------------------------------- 📢 Announce
do
	local page = newPage("Announce", "📢", "Announce", "Announcement", "Sends a message that all players on all servers will see.")
	local c = card(page, "Your message")
	local box = textBox(c, "Type your announcement here...", UDim2.new(1, 0, 0, 44))
	local counter = text(c, "0 / 100", 12, C.sub, nil, {TextXAlignment = Enum.TextXAlignment.Right})
	box:GetPropertyChangedSignal("Text"):Connect(function()
		local cut = utf8.offset(box.Text, 101)
		if cut then box.Text = string.sub(box.Text, 1, cut - 1) return end
		counter.Text = (utf8.len(box.Text) or 0) .. " / 100"
	end)
	text(c, "Quick messages:", 12, C.sub, Enum.FontWeight.Bold)
	local chips = flow(c, 6)
	for _, msg in {"📢 Server update coming soon!", "🎉 An event is starting!", "🥚 A rare egg just spawned!", "🛒 New items in the shop!"} do
		chip(chips, msg, function() box.Text = msg end)
	end
	button(c, "📢  SEND TO EVERYONE", C.blue, UDim2.new(0, 240, 0, 44), function()
		if box.Text == "" then toast("Write a message first", WARN) return end
		fire("Announce", box.Text)
		box.Text = ""
		toast("Announcement sent ✅", OK)
	end)
end

---------------------------------------------------------------- 🎟️ Codes
do
	local page = newPage("Codes", "🎟️", "Codes", "Codes", "Create a redeemable code. Players type it in their code window (F5).")
	local selectedPets = {}

	local c = card(page, "Create a code")
	local nameRow = flow(c, 10, Enum.VerticalAlignment.Bottom)
	local nameBox = field(nameRow, "CODE NAME", "e.g. HALLOWEEN", UDim.new(0, 220))
	button(nameRow, "🎲 Random", C.field, UDim2.new(0, 110, 0, 38), function()
		local chars, out = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789", ""
		for _ = 1, 8 do
			local i = math.random(#chars)
			out ..= string.sub(chars, i, i)
		end
		nameBox.Text = out
	end)

	local usesBox = field(c, "HOW MANY PLAYERS CAN USE IT?", "e.g. 100", UDim.new(1, 0), "10")
	local usesChips = flow(c, 6)
	for _, n in {1, 10, 50, 100, 500, 1000} do
		chip(usesChips, tostring(n), function() usesBox.Text = tostring(n) end)
	end

	local moneyBox = field(c, "MONEY REWARD ($)  —  you can type 10k, 2.5m...", "0 = no money", UDim.new(1, 0), "0")
	local moneyChips = flow(c, 6)
	for _, m in {{"None", 0}, {"$1K", 1000}, {"$10K", 10000}, {"$100K", 100000}, {"$1M", 1000000}, {"$10M", 10000000}} do
		chip(moneyChips, m[1], function() moneyBox.Text = tostring(m[2]) end)
	end

	text(c, "PET REWARD  —  click a pet to add it (click again for more)", 12, C.sub, Enum.FontWeight.Bold)
	local summary
	local petChips
	local function updateSummary()
		local money = parseNumber(moneyBox.Text) or 0
		local uses = parseNumber(usesBox.Text) or 0
		local parts = {}
		if money > 0 then table.insert(parts, "$" .. fmt(money)) end
		if #selectedPets > 0 then table.insert(parts, groupNames(selectedPets)) end
		summary.Text = "Reward: " .. (#parts > 0 and table.concat(parts, " + ") or "none yet") .. "   •   " .. fmt(uses) .. " use(s)"
	end
	local function rebuildPetChips()
		for _, child in petChips:GetChildren() do
			if child:IsA("TextButton") or child:IsA("TextLabel") then child:Destroy() end
		end
		if #selectedPets == 0 then
			text(petChips, "No pet added yet.", 13, C.sub)
		else
			for i, key in selectedPets do
				chip(petChips, (petNames[key] or key) .. "  ✕", function()
					table.remove(selectedPets, i)
					rebuildPetChips()
					updateSummary()
				end, C.purple)
			end
		end
	end
	picker(c, petItems, 200, function(item)
		table.insert(selectedPets, item.key)
		rebuildPetChips()
		updateSummary()
	end)
	text(c, "Selected pets (click to remove):", 12, C.sub, Enum.FontWeight.Bold)
	petChips = flow(c, 6)
	summary = text(c, "", 14, C.gold, Enum.FontWeight.Bold)
	moneyBox:GetPropertyChangedSignal("Text"):Connect(updateSummary)
	usesBox:GetPropertyChangedSignal("Text"):Connect(updateSummary)
	rebuildPetChips()
	updateSummary()

	button(c, "✅  CREATE CODE", C.green, UDim2.new(0, 220, 0, 46), function()
		local name = string.upper((string.gsub(nameBox.Text, "^%s*(.-)%s*$", "%1")))
		if name == "" or #name > 30 or string.find(name, "[^%w_%-]") then
			toast("Code name: 1-30 letters, numbers, - or _", WARN)
			return
		end
		local uses = parseNumber(usesBox.Text)
		if not uses or uses < 1 then toast("Enter how many players can use it (1 or more)", WARN) return end
		local money = parseNumber(moneyBox.Text) or 0
		if money <= 0 and #selectedPets == 0 then toast("Add a reward: money and/or a pet", WARN) return end
		local pets = table.clone(selectedPets)
		fire("CreateCode", {Code = name, MaxUses = uses, Rewards = {Money = money, Eggs = {}, Pets = pets}})
		nameBox.Text = ""
		table.clear(selectedPets)
		rebuildPetChips()
		updateSummary()
	end)

	-- liste des codes existants
	local listCard = card(page, "Existing codes")
	local top = flow(listCard, 8)
	button(top, "🔄 Refresh", C.field, UDim2.new(0, 120, 0, 32), function() fire("RequestSync") end)
	local listFrame = make(listCard, "Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1})
	listLayout(listFrame, 6)

	function pages._refreshCodes()
		for _, child in listFrame:GetChildren() do
			if child:IsA("Frame") or child:IsA("TextLabel") then child:Destroy() end
		end
		local names = {}
		for code in currentCodes do table.insert(names, code) end
		table.sort(names, function(a, b)
			local da, db = currentCodes[a], currentCodes[b]
			local soldA, soldB = da.Uses >= da.MaxUses, db.Uses >= db.MaxUses
			if soldA ~= soldB then return not soldA end
			return a < b
		end)
		if #names == 0 then text(listFrame, "No codes yet.", 13, C.sub) return end
		for _, code in names do
			local data = currentCodes[code]
			local sold = data.Uses >= data.MaxUses
			local row = make(listFrame, "Frame", {Size = UDim2.new(1, 0, 0, 62), BackgroundColor3 = sold and Color3.fromRGB(60, 40, 44) or C.field})
			corner(row, 8)
			make(row, "TextLabel", {
				Text = code, FontFace = F(Enum.FontWeight.ExtraBold), TextSize = 16, TextColor3 = C.gold, BackgroundTransparency = 1,
				Size = UDim2.new(1, -150, 0, 22), Position = UDim2.new(0, 12, 0, 6), TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
			})
			local parts = {}
			local rewards = data.Rewards or {}
			if (rewards.Money or 0) > 0 then table.insert(parts, "$" .. fmt(rewards.Money)) end
			if rewards.Pets and #rewards.Pets > 0 then table.insert(parts, groupNames(rewards.Pets)) end
			make(row, "TextLabel", {
				Text = #parts > 0 and table.concat(parts, " + ") or "—", FontFace = F(), TextSize = 12, TextColor3 = C.sub,
				BackgroundTransparency = 1, Size = UDim2.new(1, -150, 0, 18), Position = UDim2.new(0, 12, 0, 28),
				TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
			})
			make(row, "TextLabel", {
				Text = sold and "SOLD OUT" or "ACTIVE", FontFace = F(Enum.FontWeight.ExtraBold), TextSize = 13,
				TextColor3 = sold and Color3.fromRGB(255, 110, 110) or Color3.fromRGB(100, 255, 130), BackgroundTransparency = 1,
				Size = UDim2.new(0, 130, 0, 20), AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 6), TextXAlignment = Enum.TextXAlignment.Right,
			})
			make(row, "TextLabel", {
				Text = fmt(data.Uses) .. " / " .. fmt(data.MaxUses) .. " used", FontFace = F(), TextSize = 12, TextColor3 = C.sub,
				BackgroundTransparency = 1, Size = UDim2.new(0, 130, 0, 18), AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 28),
				TextXAlignment = Enum.TextXAlignment.Right,
			})
			local bar = make(row, "Frame", {Size = UDim2.new(1, -24, 0, 4), Position = UDim2.new(0, 12, 1, -10), BackgroundColor3 = C.dark})
			corner(bar, 2)
			local fill = make(bar, "Frame", {
				Size = UDim2.fromScale(math.clamp(data.Uses / math.max(data.MaxUses, 1), 0, 1), 1),
				BackgroundColor3 = sold and C.red or C.green,
			})
			corner(fill, 2)
		end
	end
end

---------------------------------------------------------------- 🥚 Spawn Egg
do
	local page = newPage("SpawnEgg", "🥚", "Spawn Egg", "Spawn an egg", "Makes an egg appear in an egg zone for a limited time. Follow the 3 steps.")
	local selectedEgg, selectedZone = nil, nil
	local summary
	local zoneButtons = {}

	local function setZone(zone)
		selectedZone = zone
		for z, b in zoneButtons do
			local on = z == zone
			b.BackgroundColor3 = on and RARITY_COLOR[z] or C.field
			b.TextColor3 = on and C.dark or RARITY_COLOR[z]
		end
	end
	local timerBox, countBox
	local mode = "all" -- "all" ou "random"

	local function updateSummary()
		local secs = parseDuration(timerBox and timerBox.Text or "")
		local where = mode == "all" and "ALL servers" or ((parseNumber(countBox and countBox.Text or "") or 0) .. " random server(s)")
		summary.Text = string.format("%s  •  %s zone  •  %s  •  %s",
			selectedEgg and selectedEgg.text or "No egg picked", selectedZone or "no", secs and formatTime(secs) or "?", where)
	end

	local c1 = card(page, "1 · Pick an egg", "The zone is chosen automatically from the egg's rarity (you can change it in step 2).")
	local eggPicker = picker(c1, eggItems, 230, function(item)
		selectedEgg = item
		eggPicker_select(item)
	end)
	function eggPicker_select(item)
		eggPicker.select(item.key)
		if RARITY_COLOR[item.rarity] and table.find(ZONES, item.rarity) then setZone(item.rarity) end
		updateSummary()
	end

	local c2 = card(page, "2 · Zone")
	local zoneRow = flow(c2, 6)
	for _, z in ZONES do
		zoneButtons[z] = chip(zoneRow, z, function() setZone(z) updateSummary() end)
	end
	setZone("Common")

	local c3 = card(page, "3 · How long and where?")
	timerBox = field(c3, "TIMER (min 10s, max 1h)  —  e.g. 90s, 5m, 1h", "5m", UDim.new(1, 0), "5m")
	local timerChips = flow(c3, 6)
	for _, t in {"30s", "1m", "5m", "10m", "30m", "1h"} do
		chip(timerChips, t, function() timerBox.Text = t end)
	end
	text(c3, "SERVERS", 12, C.sub, Enum.FontWeight.Bold)
	local modeRow = flow(c3, 8, Enum.VerticalAlignment.Center)
	local allBtn, randBtn
	countBox = textBox(modeRow, "How many?", UDim2.new(0, 120, 0, 38), "3")
	local function setMode(m)
		mode = m
		allBtn.BackgroundColor3 = m == "all" and C.blue or C.field
		randBtn.BackgroundColor3 = m == "random" and C.blue or C.field
		countBox.Visible = m == "random"
		updateSummary()
	end
	allBtn = button(modeRow, "🌍 All servers", C.blue, UDim2.new(0, 150, 0, 38), function() setMode("all") end)
	randBtn = button(modeRow, "🎲 Random servers", C.field, UDim2.new(0, 180, 0, 38), function() setMode("random") end)
	countBox.LayoutOrder = 99999
	countBox.Visible = false
	timerBox:GetPropertyChangedSignal("Text"):Connect(updateSummary)
	countBox:GetPropertyChangedSignal("Text"):Connect(updateSummary)

	summary = text(page, "", 14, C.gold, Enum.FontWeight.Bold)
	updateSummary()
	button(page, "🚀  SPAWN THE EGG", C.orange, UDim2.new(0, 260, 0, 50), function()
		if not selectedEgg then toast("Pick an egg first (step 1)", WARN) return end
		local secs = parseDuration(timerBox.Text)
		if not secs then toast("Timer not understood — try 90s, 5m or 1h", WARN) return end
		secs = math.clamp(secs, MIN_TIMER, MAX_TIMER)
		if mode == "all" then
			fire("SpawnGlobalEgg", selectedEgg.key, selectedZone, secs)
		else
			local n = parseNumber(countBox.Text)
			if not n or n < 1 then toast("Enter how many servers (1 or more)", WARN) return end
			fire("SpawnRandomServerEgg", selectedEgg.key, selectedZone, secs, n)
		end
		toast("Spawn request sent…", OK)
	end)
end

---------------------------------------------------------------- 📦 Egg Stock
do
	local page = newPage("Stock", "📦", "Egg Stock", "Egg stock", "How many of each egg the shop can sell. ∞ = unlimited, 0 = sold out.")
	local top = card(page)
	local searchBox = textBox(top, "🔍  Search an egg...", UDim2.new(1, 0, 0, 38))
	local bulk = flow(top, 8)
	local rows = {}

	local function statusOf(eggKey)
		local s = currentStock[eggKey]
		if s == nil or s == -1 then return "∞ Unlimited", Color3.fromRGB(100, 255, 130) end
		if s <= 0 then return "SOLD OUT", Color3.fromRGB(255, 110, 110) end
		return fmt(s) .. " left", Color3.fromRGB(255, 215, 90)
	end
	local function refreshRow(eggKey)
		local r = rows[eggKey]
		if not r then return end
		r.status.Text, r.status.TextColor3 = statusOf(eggKey)
	end
	local function setStock(eggKey, amount)
		fire("SetStock", eggKey, amount)
		currentStock[eggKey] = amount
		refreshRow(eggKey)
	end
	function pages._refreshStock()
		for key in rows do refreshRow(key) end
	end

	confirmButton(bulk, "All ∞ (unlimited)", "Sure? click again", C.green, UDim2.new(0, 200, 0, 34), function()
		task.spawn(function()
			for _, item in eggItems do setStock(item.key, -1) task.wait(0.05) end
			toast("All eggs set to unlimited", OK)
		end)
	end)
	confirmButton(bulk, "All 0 (sold out)", "Sure? click again", C.red, UDim2.new(0, 200, 0, 34), function()
		task.spawn(function()
			for _, item in eggItems do setStock(item.key, 0) task.wait(0.05) end
			toast("All eggs set to sold out", OK)
		end)
	end)

	local list = make(page, "Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1})
	listLayout(list, 6)
	local CONTROLS_W, STATUS_W = 206, 100
	for _, item in eggItems do
		local row = make(list, "Frame", {Size = UDim2.new(1, 0, 0, 48), BackgroundColor3 = C.card})
		corner(row, 8)
		make(row, "TextLabel", {
			Text = item.text, FontFace = F(Enum.FontWeight.Bold), TextSize = 14, TextColor3 = item.color, BackgroundTransparency = 1,
			Size = UDim2.new(1, -(CONTROLS_W + STATUS_W + 28), 1, 0), Position = UDim2.new(0, 12, 0, 0),
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
		})
		local status = make(row, "TextLabel", {
			Text = "", FontFace = F(Enum.FontWeight.Bold), TextSize = 12, BackgroundTransparency = 1,
			Size = UDim2.new(0, STATUS_W, 1, 0), AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -(CONTROLS_W + 14), 0, 0),
			TextXAlignment = Enum.TextXAlignment.Right,
		})
		local controls = make(row, "Frame", {
			Size = UDim2.new(0, CONTROLS_W, 0, 32), AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), BackgroundTransparency = 1,
		})
		listLayout(controls, 6, {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center})
		local input = textBox(controls, "Qty", UDim2.new(0, 70, 0, 32))
		input.TextSize = 14
		button(controls, "Set", C.blue, UDim2.new(0, 48, 0, 32), function()
			local n = parseNumber(input.Text)
			if not n then toast("Type a quantity first (example: 50)", WARN) return end
			setStock(item.key, n)
			input.Text = ""
		end, {TextSize = 13})
		button(controls, "∞", C.green, UDim2.new(0, 36, 0, 32), function() setStock(item.key, -1) end, {TextSize = 15})
		button(controls, "0", C.red, UDim2.new(0, 36, 0, 32), function() setStock(item.key, 0) end, {TextSize = 14})
		rows[item.key] = {frame = row, status = status, text = item.text}
		refreshRow(item.key)
	end
	searchBox:GetPropertyChangedSignal("Text"):Connect(function()
		local q = string.lower(searchBox.Text)
		for _, r in rows do
			r.frame.Visible = q == "" or string.find(string.lower(r.text), q, 1, true) ~= nil
		end
	end)
end

---------------------------------------------------------------- 💰 Coins
do
	local page = newPage("Coins", "💰", "Coins", "Give or remove coins", "Works on players who are on THIS server right now.")
	local selectedName
	local summary

	local c1 = card(page, "1 · Choose a player")
	local top = flow(c1, 8, Enum.VerticalAlignment.Center)
	local searchBox = textBox(top, "🔍  Search a player...", UDim2.new(0, 250, 0, 36))
	button(top, "🔄 Refresh", C.field, UDim2.new(0, 110, 0, 36), function() fire("RequestSync") end)
	local listFrame = make(c1, "ScrollingFrame", {
		Size = UDim2.new(1, 0, 0, 190), BackgroundColor3 = C.field, ScrollBarThickness = 4,
		AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(),
	})
	corner(listFrame, 8)
	padding(listFrame, 6)
	listLayout(listFrame, 4)

	local amountBox
	local function updateSummary()
		local n = parseNumber(amountBox and amountBox.Text or "")
		if not selectedName then summary.Text = "Pick a player first." return end
		summary.Text = n and n > 0 and ("$" .. fmt(n) .. "  →  " .. selectedName) or ("Player: " .. selectedName .. "  —  now enter an amount")
	end

	local function refreshPlayers()
		local found = false
		for _, p in currentPlayers do
			if p.Name == selectedName then found = true end
		end
		if not found then
			selectedName = nil
			for _, p in currentPlayers do
				if p.Name == player.Name then selectedName = p.Name end
			end
		end
		for _, child in listFrame:GetChildren() do
			if child:IsA("TextButton") or child:IsA("TextLabel") then child:Destroy() end
		end
		local q = string.lower(searchBox.Text)
		table.sort(currentPlayers, function(a, b) return string.lower(a.Name) < string.lower(b.Name) end)
		local shown = 0
		for _, p in currentPlayers do
			local label = p.DisplayName .. "   @" .. p.Name .. (p.Name == player.Name and "   (you)" or "")
			if q == "" or string.find(string.lower(label), q, 1, true) then
				shown += 1
				local on = p.Name == selectedName
				local row = make(listFrame, "TextButton", {
					Text = label, FontFace = F(Enum.FontWeight.Bold), TextSize = 14, TextColor3 = on and Color3.new(1, 1, 1) or C.text,
					BackgroundColor3 = on and C.blue or C.card, Size = UDim2.new(1, 0, 0, 36), AutoButtonColor = true,
					TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
				})
				corner(row, 6)
				padding(row, 12, 0)
				row.Activated:Connect(function()
					selectedName = p.Name
					refreshPlayers()
				end)
			end
		end
		if shown == 0 then text(listFrame, "No player found. Press Refresh.", 13, C.sub) end
		updateSummary()
	end
	pages._refreshPlayers = refreshPlayers
	searchBox:GetPropertyChangedSignal("Text"):Connect(refreshPlayers)

	local c2 = card(page, "2 · Amount")
	amountBox = field(c2, "AMOUNT ($)  —  you can type 10k, 2.5m...", "e.g. 100000", UDim.new(1, 0), "10000")
	local amountChips = flow(c2, 6)
	for _, a in {{"$1K", 1000}, {"$10K", 10000}, {"$100K", 100000}, {"$1M", 1000000}, {"$10M", 10000000}, {"$1B", 1000000000}} do
		chip(amountChips, a[1], function() amountBox.Text = tostring(a[2]) end)
	end
	amountBox:GetPropertyChangedSignal("Text"):Connect(updateSummary)

	local c3 = card(page, "3 · Action")
	summary = text(c3, "", 14, C.gold, Enum.FontWeight.Bold)
	local function readAmount()
		local n = parseNumber(amountBox.Text)
		if not n or n <= 0 then toast("Enter an amount greater than 0", WARN) return nil end
		return n
	end
	local actions = flow(c3, 8)
	button(actions, "💰 GIVE", C.green, UDim2.new(0, 150, 0, 46), function()
		if not selectedName then toast("Pick a player first (step 1)", WARN) return end
		local n = readAmount()
		if n then fire("GiveCoins", selectedName, n) end
	end)
	button(actions, "➖ REMOVE", C.red, UDim2.new(0, 150, 0, 46), function()
		if not selectedName then toast("Pick a player first (step 1)", WARN) return end
		local n = readAmount()
		if n then fire("GiveCoins", selectedName, -n) end
	end)
	confirmButton(actions, "🎁 GIVE TO EVERYONE", "Sure? click again", C.purple, UDim2.new(0, 220, 0, 46), function()
		local n = readAmount()
		if not n then return end
		task.spawn(function()
			for _, p in currentPlayers do
				fire("GiveCoins", p.Name, n)
				task.wait(0.15)
			end
		end)
		toast("$" .. fmt(n) .. " sent to " .. #currentPlayers .. " player(s)", OK)
	end)
	updateSummary()
end

---------------------------------------------------------------- 🎉 Events
local luckStatus, witchStatus
do
	local page = newPage("Events", "🎉", "Events", "Events", "These events start on ALL servers.")

	local g = card(page, "🎉 Global event", "Starts the global event on every server.")
	confirmButton(g, "▶ START GLOBAL EVENT", "Sure? click again", C.orange, UDim2.new(0, 260, 0, 46), function()
		fire("StartGlobalEvent")
		toast("Global event sent ✅", OK)
	end)

	local function eventCard(title, subtitle, durations, defaultText, startColor, onStart, onStop)
		local c = card(page, title, subtitle)
		local status = text(c, "○ Not running", 14, C.sub, Enum.FontWeight.ExtraBold)
		local box = field(c, "DURATION  —  e.g. 30m, 1h, 1h30m  (a plain number = minutes)", defaultText, UDim.new(1, 0), defaultText)
		local chips = flow(c, 6)
		for _, d in durations do
			chip(chips, d, function() box.Text = d end)
		end
		local row = flow(c, 8)
		button(row, "▶ START", startColor, UDim2.new(0, 160, 0, 44), function()
			local secs = parseDuration(box.Text)
			if not secs or secs <= 0 then toast("Duration not understood — try 30m or 1h", WARN) return end
			onStart(secs)
		end)
		button(row, "■ STOP", C.red, UDim2.new(0, 120, 0, 44), onStop)
		return status
	end

	luckStatus = eventCard("🍀 LUCK x4", "Better eggs for every player while it lasts.", {"10m", "30m", "1h", "2h", "6h"}, "30m", C.green,
		function(secs) fire("StartLuckEvent", secs) end,
		function() fire("StartLuckEvent", 0) end)

	witchStatus = eventCard("🧙 WITCH TIME", "The witch flies over the egg zones.", {"5m", "10m", "20m", "30m", "1h"}, "10m", C.purple,
		function(secs) fire("StartWitchEvent", "start", secs) end,
		function() fire("StartWitchEvent", "stop") end)
end

local function setStatus(label, active, remaining)
	if active then
		label.Text = "● ACTIVE  —  " .. formatTime(remaining) .. " left"
		label.TextColor3 = Color3.fromRGB(100, 255, 130)
	else
		label.Text = "○ Not running"
		label.TextColor3 = C.sub
	end
end

-- états en direct des events (visibles via les attributs de ReplicatedStorage)
task.spawn(function()
	while true do
		task.wait(0.5)
		if mainFrame.Visible and pages.Events.Visible then
			local endLuck = ReplicatedStorage:GetAttribute("LuckEnd")
			local luckLeft = type(endLuck) == "number" and (endLuck - os.time()) or 0
			setStatus(luckStatus, ReplicatedStorage:GetAttribute("LuckMultiplier") ~= nil and luckLeft > 0, luckLeft)
			local endWitch = ReplicatedStorage:GetAttribute("WitchEventEnd")
			local witchLeft = type(endWitch) == "number" and (endWitch - Workspace:GetServerTimeNow()) or 0
			setStatus(witchStatus, ReplicatedStorage:GetAttribute("WitchTime") == true and witchLeft > 0, witchLeft)
		end
	end
end)

---------------------------------------------------------------- synchronisation serveur
remotes.SyncPlayers.OnClientEvent:Connect(function(list)
	currentPlayers = list or {}
	if pages._refreshPlayers then pages._refreshPlayers() end
end)
remotes.SyncData.OnClientEvent:Connect(function(stock, codes)
	currentStock = stock or {}
	currentCodes = codes or {}
	if pages._refreshStock then pages._refreshStock() end
	if pages._refreshCodes then pages._refreshCodes() end
end)

---------------------------------------------------------------- taille adaptée à l'écran + déplacement
local function applyLayout()
	local camera = Workspace.CurrentCamera
	local vp = camera and camera.ViewportSize or Vector2.new(1280, 720)
	local w = math.clamp(vp.X - 24, 300, 820)
	local h = math.clamp(vp.Y - 24, 280, 580)
	mainFrame.Size = UDim2.fromOffset(w, h)
	compact = w < 620
	local sw = compact and 60 or 180
	sidebar.Size = UDim2.new(0, sw, 1, -HEADER_H)
	content.Size = UDim2.new(1, -sw, 1, -HEADER_H)
	content.Position = UDim2.new(0, sw, 0, HEADER_H)
	for id, tab in tabs do
		tab.Text = compact and tabInfo[id].icon or (tabInfo[id].icon .. "  " .. tabInfo[id].label)
		tab.TextXAlignment = compact and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
	end
	hint.Visible = not compact
	toastFrame.Position = UDim2.new(0.5, sw / 2, 1, -14)
end

local function draggable(handle, target)
	local dragging, startMouse, startPos = false, nil, nil
	local state = {moved = false}
	handle.InputBegan:Connect(function(input)
		local t = input.UserInputType
		if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
			dragging, state.moved = true, false
			startMouse, startPos = input.Position, target.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end
		local t = input.UserInputType
		if t == Enum.UserInputType.MouseMovement or t == Enum.UserInputType.Touch then
			local d = input.Position - startMouse
			if d.Magnitude > 6 then state.moved = true end
			if state.moved then
				target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
			end
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		local t = input.UserInputType
		if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then dragging = false end
	end)
	return state
end
draggable(header, mainFrame)

-- bouton ⚙ (déplaçable) pour ouvrir le panneau sans clavier
local toggleBtn = make(screenGui, "TextButton", {
	Text = "⚙", TextSize = 26, FontFace = F(Enum.FontWeight.Bold), TextColor3 = C.gold, BackgroundColor3 = C.bg,
	Size = UDim2.fromOffset(46, 46), Position = UDim2.new(0, 14, 0.4, 0), AutoButtonColor = true, BackgroundTransparency = 0.15,
})
corner(toggleBtn, 23)
make(toggleBtn, "UIStroke", {Color = C.gold, Thickness = 2})
local toggleDrag = draggable(toggleBtn, toggleBtn)

local function setOpen(open)
	mainFrame.Visible = open
	if open then
		applyLayout()
		showPage(currentPage)
		fire("RequestSync")
	end
end
toggleBtn.Activated:Connect(function()
	if toggleDrag.moved then return end
	setOpen(not mainFrame.Visible)
end)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.F2 then setOpen(not mainFrame.Visible) end
end)

local camera = Workspace.CurrentCamera
if camera then camera:GetPropertyChangedSignal("ViewportSize"):Connect(applyLayout) end
applyLayout()
showPage("Announce")

-- Game: smash-egg-for-animals
-- Original: StarterPlayer/StarterPlayerScripts/TradeClient.client.lua  (594 lines)
-- What it does: Client trade window built entirely in code (no prebuilt GUI): lobby with player list and search, stacked incoming request cards with timer bars, 3x3 offer grids, edit-cooldown bar, READY/CONFIRM with countdown and tween animations. Comments in French.

-- TradeClient : la fenêtre de la Trade Machine (le serveur, TradeServer, décide de tout).
--   accueil : barre de recherche en haut (on tape le @ du joueur : s'il n'est pas dans le serveur -> "not online"),
--             puis tous les joueurs EN LIGNE dans ce serveur (bouton SEND, ou BUSY s'il échange déjà)
--   demandes reçues : petites cartes en bas à droite, juste à gauche du HUD Huge Egg ; plusieurs = elles s'empilent
--             vers le haut. ✓ accepte, X refuse, une barre montre le temps restant (même fenêtre fermée)
--   échange : ton offre et la sienne (3 x 3) avec le total de revenu, tous tes animaux en bas (clic = ajouter,
--             clic sur ton offre = retirer), barre d'attente de 2 s entre deux changements, READY, puis CONFIRM
--             3 s après que les deux sont prêts, CANCEL. Animations : ouverture, cartes qui apparaissent, panneau
--             qui s'illumine quand un joueur est prêt, flèches d'échange qui tournent, bouton CONFIRM qui pulse.
-- Fond du panneau transparent à 50 %, contours noirs, dégradés et motif à studs comme les autres fenêtres du jeu.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local system = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(system:WaitForChild("EggConfig"))
local Portrait = require(system:WaitForChild("PetPortrait"))
local petTemplates = system:WaitForChild("Pets")
local GuiScale = require(ReplicatedStorage:WaitForChild("GuiScale"))
local tradeSystem = ReplicatedStorage:WaitForChild("TradeSystem")
local actionRemote = tradeSystem:WaitForChild("TradeAction")
local updateRemote = tradeSystem:WaitForChild("TradeUpdate")

local rgb = Color3.fromRGB
local HEAVY = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local BOLD = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
local FREDOKA = Font.new("rbxasset://fonts/families/FredokaOne.json")
local STUDS = "rbxassetid://82096270344702"
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local CYAN, PINK, GREEN, RED, YELLOW, GREY = rgb(70, 220, 255), rgb(255, 100, 215), rgb(80, 220, 110), rgb(240, 70, 80), rgb(255, 205, 60), rgb(120, 120, 140)
local RARITY = Portrait.RarityColors or {}

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function tween(o, time, props, style, dir)
	local t = TweenService:Create(o, TweenInfo.new(time, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
	t:Play()
	return t
end
local function stroke(o, t, color) return new("UIStroke", {Thickness = t, Color = color or BLACK, ApplyStrokeMode = o:IsA("TextLabel") and Enum.ApplyStrokeMode.Contextual or Enum.ApplyStrokeMode.Border}, o) end
local function round(o, r) return new("UICorner", {CornerRadius = UDim.new(0, r)}, o) end
local function gradient(o, c1, c2, rot) return new("UIGradient", {Color = ColorSequence.new(c1, c2), Rotation = rot or 90}, o) end
local function studs(o, size, transparency)
	return new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Image = STUDS, ImageTransparency = transparency or 0.88, ScaleType = Enum.ScaleType.Tile,
		TileSize = UDim2.fromOffset(size or 32, size or 32), Size = UDim2.fromScale(1, 1), ZIndex = o.ZIndex}, o)
end
local function text(parent, props)
	local l = new("TextLabel", {BackgroundTransparency = 1, FontFace = HEAVY, TextColor3 = WHITE, TextScaled = true}, parent)
	for k, v in props do if k ~= "StrokeThickness" then l[k] = v end end
	new("UIStroke", {Thickness = props.StrokeThickness or 2, Color = BLACK}, l)
	return l
end
local function button(parent, label, color, props)
	local b = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = WHITE, BorderSizePixel = 0}, parent)
	for k, v in props do b[k] = v end
	round(b, 10)
	stroke(b, 2.5)
	b:SetAttribute("Base", color)
	gradient(b, color:Lerp(WHITE, 0.25), color:Lerp(BLACK, 0.15))
	studs(b, 28, 0.82)
	local t = text(b, {Name = "Label", Text = label, Size = UDim2.fromScale(0.9, 0.62), Position = UDim2.fromScale(0.05, 0.19), ZIndex = b.ZIndex + 1})
	local scale = new("UIScale", {Name = "Hover"}, b)
	b.MouseEnter:Connect(function() tween(scale, 0.12, {Scale = 1.06}) end)
	b.MouseLeave:Connect(function() tween(scale, 0.12, {Scale = 1}) end)
	b.MouseButton1Down:Connect(function() tween(scale, 0.06, {Scale = 0.94}) end)
	b.MouseButton1Up:Connect(function() tween(scale, 0.12, {Scale = 1.06}, Enum.EasingStyle.Back) end)
	return b, t
end
local function setButton(b, label, color, enabled)
	b.Label.Text = label
	local g = b:FindFirstChildOfClass("UIGradient")
	g.Color = ColorSequence.new(color:Lerp(WHITE, 0.25), color:Lerp(BLACK, 0.15))
	b.Active = enabled
	b.Label.TextTransparency = enabled and 0 or 0.35
end
local function headshot(parent, userId, size, pos)
	local h = new("ImageLabel", {BackgroundColor3 = rgb(230, 235, 255), Position = pos, Size = UDim2.fromOffset(size, size),
		Image = "rbxthumb://type=AvatarHeadShot&id=" .. userId .. "&w=150&h=150"}, parent)
	round(h, size / 2)
	stroke(h, 2.5)
	return h
end

---------------------------------------------------------------- fenêtre
local gui = new("ScreenGui", {Name = "TradeGui", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 20, IgnoreGuiInset = false}, playerGui)
local main = new("Frame", {Name = "Main", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromOffset(900, 580),
	BackgroundColor3 = rgb(14, 12, 34), BackgroundTransparency = 0.5, Visible = false}, gui)
main:SetAttribute("SolidWindow", true) -- (UIPolish ne touche pas à cette fenêtre)
round(main, 20)
stroke(main, 4)
gradient(main, rgb(255, 255, 255), rgb(170, 160, 230), 90)
studs(main, 40, 0.9)
local uiScale = new("UIScale", {}, main)
local baseScale = 1
local function rescale()
	baseScale = math.min(GuiScale.get(), (workspace.CurrentCamera.ViewportSize.Y - 40) / 600, (workspace.CurrentCamera.ViewportSize.X - 20) / 920)
	uiScale.Scale = baseScale
end
rescale()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(rescale)

local header = new("Frame", {Name = "Header", Size = UDim2.new(1, 0, 0, 64), BackgroundColor3 = WHITE, BorderSizePixel = 0}, main)
round(header, 20)
local headerGradient = gradient(header, rgb(40, 190, 255), rgb(200, 70, 220), 0)
local headerFlat = new("Frame", {Size = UDim2.new(1, 0, 0, 20), Position = UDim2.new(0, 0, 1, -20), BackgroundColor3 = WHITE, BorderSizePixel = 0}, header)
local flatGradient = gradient(headerFlat, rgb(40, 190, 255), rgb(200, 70, 220), 0)
stroke(header, 3)
studs(header, 30, 0.85)
local title = text(header, {Name = "Title", Text = "TRADE MACHINE", FontFace = FREDOKA, Size = UDim2.new(0.75, 0, 0, 44), Position = UDim2.new(0.03, 0, 0, 10), TextXAlignment = Enum.TextXAlignment.Left, StrokeThickness = 3, ZIndex = 2})
local close = button(header, "X", RED, {Name = "Close", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(46, 46), ZIndex = 3})

local status = text(main, {Name = "Status", Text = "", Size = UDim2.new(1, -40, 0, 24), Position = UDim2.new(0, 20, 1, -34), TextXAlignment = Enum.TextXAlignment.Center, FontFace = BOLD})

local function panel(parent, name, titleText, color, pos, size)
	local p = new("Frame", {Name = name, Position = pos, Size = size, BackgroundColor3 = rgb(24, 22, 52), BackgroundTransparency = 0.25}, parent)
	round(p, 14)
	local s = stroke(p, 3)
	s.Name = "Edge"
	local bar = new("Frame", {Name = "Bar", Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = WHITE, BorderSizePixel = 0}, p)
	round(bar, 14)
	gradient(bar, color:Lerp(WHITE, 0.2), color:Lerp(BLACK, 0.25))
	studs(bar, 24, 0.85)
	local t = text(bar, {Name = "Title", Text = titleText, Size = UDim2.new(1, -20, 0, 24), Position = UDim2.fromOffset(10, 5), TextXAlignment = Enum.TextXAlignment.Left})
	return p, t
end

-- ouverture / fermeture animées
local opened = false
local function openWindow()
	if opened then return end
	opened = true
	main.Visible = true
	uiScale.Scale = baseScale * 0.85
	main.BackgroundTransparency = 1
	tween(uiScale, 0.28, {Scale = baseScale}, Enum.EasingStyle.Back)
	tween(main, 0.2, {BackgroundTransparency = 0.5})
end
local function closeWindow()
	if not opened then return end
	opened = false
	local t = tween(uiScale, 0.16, {Scale = baseScale * 0.88}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	t.Completed:Connect(function() if not opened then main.Visible = false uiScale.Scale = baseScale end end)
end

---------------------------------------------------------------- page d'accueil : recherche + joueurs en ligne
local lobby = new("Frame", {Name = "Lobby", BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 76), Size = UDim2.new(1, -32, 1, -120)}, main)
-- barre de recherche
local searchBox = new("Frame", {Name = "Search", Size = UDim2.new(1, 0, 0, 52), BackgroundColor3 = rgb(30, 28, 64), BackgroundTransparency = 0.1}, lobby)
round(searchBox, 14)
local searchEdge = stroke(searchBox, 3)
text(searchBox, {Text = "🔍", Position = UDim2.fromOffset(10, 9), Size = UDim2.fromOffset(34, 34), TextColor3 = WHITE})
text(searchBox, {Text = "@", Position = UDim2.fromOffset(46, 10), Size = UDim2.fromOffset(26, 32), TextColor3 = CYAN})
local searchInput = new("TextBox", {Name = "Input", BackgroundTransparency = 1, Position = UDim2.fromOffset(74, 6), Size = UDim2.new(1, -230, 1, -12), FontFace = BOLD, TextSize = 24,
	TextColor3 = WHITE, PlaceholderText = "type a player's @username...", PlaceholderColor3 = rgb(150, 150, 190), Text = "", ClearTextOnFocus = false,
	TextXAlignment = Enum.TextXAlignment.Left}, searchBox)
local searchSend = button(searchBox, "SEND", GREEN, {Name = "Send", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(130, 40)})

local playersPanel, playersTitle = panel(lobby, "Players", "ONLINE PLAYERS", CYAN, UDim2.fromOffset(0, 64), UDim2.new(1, 0, 1, -64))
local onlineCount = text(playersPanel.Bar, {Name = "Count", Text = "", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 6), Size = UDim2.fromOffset(200, 22),
	TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = rgb(200, 255, 200)})
local playerList = new("ScrollingFrame", {Name = "List", BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 44), Size = UDim2.new(1, -20, 1, -52), CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 6, BorderSizePixel = 0}, playersPanel)
new("UIGridLayout", {CellSize = UDim2.new(0.5, -6, 0, 72), CellPadding = UDim2.fromOffset(10, 10), SortOrder = Enum.SortOrder.LayoutOrder}, playerList)
new("UIPadding", {PaddingTop = UDim.new(0, 4), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 8)}, playerList)
local emptyLabel = text(playersPanel, {Name = "Empty", Text = "", Position = UDim2.fromOffset(20, 60), Size = UDim2.new(1, -40, 0, 30), FontFace = BOLD, TextColor3 = rgb(200, 200, 230), Visible = false})

---------------------------------------------------------------- page d'échange
local tradePage = new("Frame", {Name = "Trade", BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 76), Size = UDim2.new(1, -32, 1, -120), Visible = false}, main)
local myPanel, myTitle = panel(tradePage, "MyOffer", "YOUR OFFER", CYAN, UDim2.fromOffset(0, 0), UDim2.new(0.5, -34, 0, 240))
local theirPanel, theirTitle = panel(tradePage, "TheirOffer", "THEIR OFFER", PINK, UDim2.new(0.5, 34, 0, 0), UDim2.new(0.5, -34, 0, 240))
local function badge(p)
	return text(p.Bar, {Name = "Badge", Text = "", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 6), Size = UDim2.fromOffset(130, 22), TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = GREEN})
end
local myBadge, theirBadge = badge(myPanel), badge(theirPanel)
local function footer(p)
	return text(p, {Name = "Total", Text = "", Position = UDim2.new(0, 12, 1, -28), Size = UDim2.new(1, -24, 0, 20), FontFace = BOLD, TextColor3 = rgb(170, 255, 140), TextXAlignment = Enum.TextXAlignment.Left, StrokeThickness = 1.5})
end
local myTotal, theirTotal = footer(myPanel), footer(theirPanel)
local function offerGrid(p)
	local g = new("Frame", {Name = "Grid", BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 42), Size = UDim2.new(1, -20, 1, -74)}, p)
	new("UIGridLayout", {CellSize = UDim2.new(1 / 3, -6, 1 / 3, -6), CellPadding = UDim2.fromOffset(6, 6), SortOrder = Enum.SortOrder.LayoutOrder}, g)
	return g
end
local myGrid, theirGrid = offerGrid(myPanel), offerGrid(theirPanel)
-- milieu : flèches d'échange qui tournent
local swap = new("Frame", {Name = "Swap", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 120), Size = UDim2.fromOffset(56, 56), BackgroundColor3 = WHITE}, tradePage)
round(swap, 28)
stroke(swap, 3)
local swapGradient = gradient(swap, CYAN, PINK, 0)
local swapIcon = text(swap, {Text = "⇄", Size = UDim2.fromScale(0.8, 0.8), Position = UDim2.fromScale(0.1, 0.08), StrokeThickness = 2.5})
local swapScale = new("UIScale", {}, swap)

local invPanel = panel(tradePage, "Inventory", "YOUR PETS  ·  click to add  ·  click your offer to remove", YELLOW, UDim2.fromOffset(0, 250), UDim2.new(1, 0, 0, 150))
local invList = new("ScrollingFrame", {Name = "List", BackgroundTransparency = 1, Position = UDim2.fromOffset(8, 40), Size = UDim2.new(1, -16, 1, -46), CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.X, ScrollingDirection = Enum.ScrollingDirection.X, ScrollBarThickness = 6, BorderSizePixel = 0}, invPanel)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, invList)
new("UIPadding", {PaddingLeft = UDim.new(0, 4), PaddingTop = UDim.new(0, 2)}, invList)
-- barre d'attente (2 s entre deux changements)
local cooldown = new("Frame", {Name = "Cooldown", Position = UDim2.fromOffset(0, 408), Size = UDim2.new(1, 0, 0, 8), BackgroundColor3 = rgb(30, 28, 60)}, tradePage)
round(cooldown, 4)
stroke(cooldown, 2)
local cooldownFill = new("Frame", {Size = UDim2.fromScale(0, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0}, cooldown)
round(cooldownFill, 4)
gradient(cooldownFill, YELLOW, rgb(255, 140, 40), 0)
local readyButton = button(tradePage, "READY", YELLOW, {Name = "Ready", Position = UDim2.new(0, 0, 0, 424), Size = UDim2.new(0.33, -6, 0, 44)})
local confirmButton = button(tradePage, "CONFIRM", GREY, {Name = "Confirm", Position = UDim2.new(0.335, 0, 0, 424), Size = UDim2.new(0.33, -6, 0, 44)})
local cancelButton = button(tradePage, "CANCEL", RED, {Name = "Cancel", Position = UDim2.new(0.67, 0, 0, 424), Size = UDim2.new(0.33, 0, 0, 44)})

-- carte d'un animal. wide = carte des grilles d'offre (cases larges et basses) : portrait à gauche, texte à droite
local function petCard(parent, pet, order, onClick, wide, pop)
	local c = new("TextButton", {Name = tostring(pet.Id), Text = "", AutoButtonColor = false, BackgroundColor3 = WHITE, LayoutOrder = order, Size = UDim2.fromOffset(96, 100)}, parent)
	round(c, 12)
	local edge = stroke(c, 2.5)
	local colors = RARITY[pet.Rarity] or {rgb(170, 230, 120), rgb(70, 160, 60)}
	gradient(c, colors[1], colors[2])
	local view = new("ViewportFrame", {BackgroundTransparency = 1, Position = wide and UDim2.fromScale(0.04, 0.06) or UDim2.fromScale(0.08, 0.12),
		Size = wide and UDim2.fromScale(0.88, 0.88) or UDim2.fromScale(0.84, 0.58), SizeConstraint = wide and Enum.SizeConstraint.RelativeYY or Enum.SizeConstraint.RelativeXY}, c)
	pcall(function() Portrait.fill(view, petTemplates:FindFirstChild(pet.Pet), function(model) Config.ApplyMutation(model, pet.Mutation) end) end)
	local name = ((pet.Trait and (pet.Trait .. " ")) or "") .. (Config.MutationText(pet.Mutation) and (Config.MutationText(pet.Mutation) .. " ") or "") .. pet.Name
	local stats = Config.FormatKg(pet.Kg or 0) .. " · " .. Config.FormatMoney(pet.Income or 0) .. "/s"
	local hasIcons = #Config.MutationIconList(pet.Mutation) > 0
	if wide then
		text(c, {Text = name, Position = UDim2.fromScale(0.45, 0.08), Size = UDim2.fromScale(0.52, 0.34), TextXAlignment = Enum.TextXAlignment.Left, StrokeThickness = 1.5})
		text(c, {Text = stats, FontFace = BOLD, Position = UDim2.fromScale(0.45, hasIcons and 0.7 or 0.5), Size = UDim2.fromScale(0.52, 0.24), TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = rgb(170, 255, 140), StrokeThickness = 1.5})
	else
		text(c, {Text = name, Position = UDim2.fromScale(0.04, 0.02), Size = UDim2.fromScale(0.92, 0.16), StrokeThickness = 1.5})
		text(c, {Text = stats, FontFace = BOLD, Position = UDim2.fromScale(0.04, 0.8), Size = UDim2.fromScale(0.92, 0.16),
			TextColor3 = rgb(170, 255, 140), StrokeThickness = 1.5})
	end
	if hasIcons then
		local icons = new("Frame", {BackgroundTransparency = 1, Position = wide and UDim2.fromScale(0.45, 0.44) or UDim2.fromScale(0.05, 0.18), Size = UDim2.new(wide and 0.52 or 0.9, 0, 0, 16),
			AutomaticSize = Enum.AutomaticSize.Y, ZIndex = c.ZIndex + 1}, c)
		Config.FillMutationIcons(icons, pet.Mutation, wide and 14 or 16)
	end
	local scale = new("UIScale", {}, c)
	if pop then
		scale.Scale = 0.2
		tween(scale, 0.3, {Scale = 1}, Enum.EasingStyle.Back)
	end
	c.MouseEnter:Connect(function() tween(scale, 0.1, {Scale = 1.06}) edge.Color = WHITE end)
	c.MouseLeave:Connect(function() tween(scale, 0.1, {Scale = 1}) edge.Color = BLACK end)
	if onClick then c.Activated:Connect(onClick) end
	return c
end

---------------------------------------------------------------- état
local state = nil       -- dernier paquet "trade"
local lobbyPlayers = {} -- dernier paquet "lobby" : joueurs en ligne
local editReadyAt = 0   -- os.clock() à partir duquel on peut de nouveau ajouter / retirer
local editCooldown = 2
local shownIds = {mine = {}, theirs = {}} -- animaux déjà affichés dans chaque offre (les nouveaux "popent")
local function say(msg, bad)
	status.Text = msg or ""
	status.TextColor3 = bad and rgb(255, 130, 130) or WHITE
end
local function clear(frame) for _, c in frame:GetChildren() do if c:IsA("GuiObject") then c:Destroy() end end end
local function canEdit()
	if os.clock() < editReadyAt then
		say(string.format("Wait %.1fs before changing your offer again", editReadyAt - os.clock()), true)
		return false
	end
	return true
end
local function flashSearch(color)
	searchEdge.Color, searchEdge.Thickness = color, 4
	task.delay(0.6, function() searchEdge.Color, searchEdge.Thickness = BLACK, 3 end)
end
local function sendRequest(info)
	if info.Busy then say(info.Display .. " (@" .. info.Name .. ") is already trading.", true) return end
	actionRemote:FireServer("Request", info.Id)
	say("Trade request sent to " .. info.Display .. " (@" .. info.Name .. ")!")
end

-- filtre de la liste : @username (ou une partie). Le "@" est déjà affiché devant : s'il est tapé, on l'enlève.
local function typed() return (searchInput.Text:gsub("^%s*@?", ""):gsub("%s+$", "")) end
local function query() return string.lower(typed()) end
local function applyFilter()
	if string.find(searchInput.Text, "^%s*@") then searchInput.Text = (searchInput.Text:gsub("^%s*@+", "")) return end
	local q = query()
	local shown = 0
	for _, row in playerList:GetChildren() do
		if row:IsA("GuiObject") then
			local name, display = row:GetAttribute("UserName") or "", row:GetAttribute("Display") or ""
			local match = q == "" or string.find(string.lower(name), q, 1, true) ~= nil or string.find(string.lower(display), q, 1, true) ~= nil
			row.Visible = match
			if match then shown += 1 end
		end
	end
	emptyLabel.Visible = shown == 0
	if #lobbyPlayers == 0 then
		emptyLabel.Text = "Nobody else is online in this server right now."
	elseif shown == 0 then
		emptyLabel.Text = "@" .. typed() .. " is not online in this server."
	end
end
searchInput:GetPropertyChangedSignal("Text"):Connect(applyFilter)
local function searchAndSend()
	local q = query()
	if q == "" then say("Type the @username of the player you want to trade with.", true) flashSearch(RED) return end
	if q == string.lower(player.Name) then say("That's you! Pick another player.", true) flashSearch(RED) return end
	for _, info in lobbyPlayers do
		if string.lower(info.Name) == q then
			flashSearch(GREEN)
			sendRequest(info)
			return
		end
	end
	say("@" .. typed() .. " is not online — player not found in this server.", true)
	flashSearch(RED)
end
searchSend.Activated:Connect(searchAndSend)
searchInput.FocusLost:Connect(function(enter) if enter then searchAndSend() end end)

local function playerCard(info, order)
	local row = new("Frame", {Name = info.Name, BackgroundColor3 = WHITE, LayoutOrder = order}, playerList)
	row:SetAttribute("UserName", info.Name)
	row:SetAttribute("Display", info.Display)
	round(row, 14)
	stroke(row, 2.5)
	gradient(row, rgb(60, 54, 120), rgb(34, 30, 74))
	studs(row, 26, 0.9)
	local head = headshot(row, info.Id, 54, UDim2.fromOffset(9, 9))
	-- pastille verte "en ligne"
	local dot = new("Frame", {AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 2, 1, 2), Size = UDim2.fromOffset(16, 16), BackgroundColor3 = info.Busy and YELLOW or GREEN}, head)
	round(dot, 8)
	stroke(dot, 2)
	text(row, {Text = info.Display, Position = UDim2.fromOffset(72, 10), Size = UDim2.new(1, -200, 0, 26), TextXAlignment = Enum.TextXAlignment.Left})
	text(row, {Text = "@" .. info.Name .. (info.Busy and "  ·  trading" or "  ·  online"), FontFace = BOLD, TextColor3 = info.Busy and rgb(255, 220, 120) or rgb(150, 240, 170),
		Position = UDim2.fromOffset(72, 40), Size = UDim2.new(1, -200, 0, 18), TextXAlignment = Enum.TextXAlignment.Left, StrokeThickness = 1.5})
	local b = button(row, info.Busy and "BUSY" or "SEND", info.Busy and GREY or GREEN, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(104, 44)})
	b.Activated:Connect(function() sendRequest(info) end)
	local scale = new("UIScale", {Scale = 0.6}, row)
	task.delay(0.03 * order, function() tween(scale, 0.25, {Scale = 1}, Enum.EasingStyle.Back) end)
end

local function showLobby(packet)
	state = nil
	lobbyPlayers = packet.Players or {}
	title.Text = "TRADE MACHINE"
	tradePage.Visible, lobby.Visible = false, true
	clear(playerList)
	table.sort(lobbyPlayers, function(a, b) return string.lower(a.Display) < string.lower(b.Display) end)
	for i, info in lobbyPlayers do playerCard(info, i) end
	onlineCount.Text = #lobbyPlayers .. " online"
	applyFilter()
	say("Search a player by @username, or press SEND next to them.")
	openWindow()
end
-- joueurs qui arrivent / partent : la liste se met à jour si l'accueil est ouvert
local function refreshLobby() if main.Visible and lobby.Visible and not state then actionRemote:FireServer("Lobby") end end
Players.PlayerAdded:Connect(function() task.delay(1, refreshLobby) end)
Players.PlayerRemoving:Connect(function() task.delay(0.2, refreshLobby) end)

local function setReadyGlow(p, ready)
	local edge = p:FindFirstChild("Edge")
	edge.Color = ready and GREEN or BLACK
	edge.Thickness = ready and 4 or 3
end

local function fillOffer(grid, list, key, onClick)
	clear(grid)
	local now = {}
	for i, pet in list do
		now[pet.Id] = true
		petCard(grid, pet, i, onClick and function() onClick(pet) end or nil, true, not shownIds[key][pet.Id])
	end
	shownIds[key] = now
	local total = 0
	for _, pet in list do total += pet.Income or 0 end
	return #list, total
end

local function showTrade(packet)
	local first = state == nil
	state = packet
	editCooldown = packet.EditCooldown or 2
	editReadyAt = os.clock() + (packet.EditWait or 0)
	if first then
		shownIds = {mine = {}, theirs = {}}
		tradePage.Position = UDim2.fromOffset(16, 96)
		tween(tradePage, 0.3, {Position = UDim2.fromOffset(16, 76)}, Enum.EasingStyle.Back)
	end
	lobby.Visible, tradePage.Visible = false, true
	title.Text = "TRADING WITH " .. string.upper(packet.Other.Display)
	theirTitle.Text = string.upper(packet.Other.Display) .. "'S OFFER"
	local max = packet.MaxOffer or 9
	local n1, t1 = fillOffer(myGrid, packet.MyOffer, "mine", function(pet) if canEdit() then actionRemote:FireServer("Remove", pet.Id) end end)
	local n2, t2 = fillOffer(theirGrid, packet.TheirOffer, "theirs")
	myTitle.Text = "YOUR OFFER  " .. n1 .. "/" .. max
	theirTitle.Text = string.upper(packet.Other.Display) .. "  " .. n2 .. "/" .. max
	myTotal.Text = "Total: " .. Config.FormatMoney(t1) .. "/s"
	theirTotal.Text = "Total: " .. Config.FormatMoney(t2) .. "/s"
	myBadge.Text = packet.MyConfirm and "CONFIRMED" or packet.MyReady and "READY ✓" or ""
	theirBadge.Text = packet.TheirConfirm and "CONFIRMED" or packet.TheirReady and "READY ✓" or ""
	setReadyGlow(myPanel, packet.MyReady)
	setReadyGlow(theirPanel, packet.TheirReady)
	clear(invList)
	for i, pet in packet.Inventory do
		petCard(invList, pet, i, function()
			if #state.MyOffer >= max then say("Your offer is full (" .. max .. " pets max)", true) return end
			if canEdit() then actionRemote:FireServer("Add", pet.Id) end
		end)
	end
	if #packet.Inventory == 0 then
		text(invList, {Text = "No pets in your inventory (placed pets can't be traded).", Size = UDim2.fromOffset(560, 30), FontFace = BOLD, TextColor3 = rgb(220, 220, 240)})
	end
	setButton(readyButton, packet.MyReady and "UNREADY" or "READY", packet.MyReady and GREEN or YELLOW, true)
	tween(swapScale, 0.12, {Scale = 1.25}).Completed:Connect(function() tween(swapScale, 0.25, {Scale = 1}, Enum.EasingStyle.Back) end)
	openWindow()
end

---------------------------------------------------------------- demandes reçues : en bas à droite, à gauche du HUD Huge Egg
local inviteGui = new("ScreenGui", {Name = "TradeInvites", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 21, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, playerGui)
local inviteHolder = new("Frame", {Name = "Invites", AnchorPoint = Vector2.new(1, 1), BackgroundTransparency = 1, Size = UDim2.fromOffset(330, 420),
	Position = UDim2.new(1, -180, 1, -96)}, inviteGui)
new("UIListLayout", {VerticalAlignment = Enum.VerticalAlignment.Bottom, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, inviteHolder)
local inviteScale = new("UIScale", {Scale = GuiScale.get()}, inviteHolder)
local invites = {} -- [userId] = carte
local inviteOrder = 0
-- suit le HUD des events (pile Huge Egg en bas à droite) : les cartes se posent juste à sa gauche, au-dessus de la barre d'objets
task.spawn(function()
	while true do
		inviteScale.Scale = GuiScale.get()
		local stackGui = playerGui:FindFirstChild("EventStackGui")
		local stack = stackGui and stackGui:FindFirstChild("Stack")
		local view = workspace.CurrentCamera.ViewportSize
		local right = stack and stack.AbsolutePosition.X - 12 or view.X - 180
		inviteHolder.Position = UDim2.fromOffset(right, view.Y - 96 * inviteScale.Scale)
		task.wait(0.5)
	end
end)

local function removeInvite(id)
	local card = invites[id]
	if not card then return end
	invites[id] = nil
	local inner = card:FindFirstChild("Inner")
	if inner then tween(inner, 0.2, {Position = UDim2.fromOffset(360, 0)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In) end
	task.delay(0.2, function() card:Destroy() end)
end

local function addInvite(from, expires)
	removeInvite(from.Id)
	inviteOrder += 1
	-- (le conteneur garde la place dans la pile ; la carte glisse depuis la droite à l'intérieur)
	local card = new("Frame", {Name = "Invite_" .. from.Id, BackgroundTransparency = 1, Size = UDim2.fromOffset(330, 78), LayoutOrder = inviteOrder, ClipsDescendants = false}, inviteHolder)
	invites[from.Id] = card
	local inner = new("Frame", {Name = "Inner", Size = UDim2.fromScale(1, 1), Position = UDim2.fromOffset(360, 0), BackgroundColor3 = WHITE}, card)
	round(inner, 16)
	stroke(inner, 3)
	gradient(inner, rgb(40, 34, 92), rgb(18, 16, 44))
	studs(inner, 26, 0.9)
	local accent = new("Frame", {Size = UDim2.new(0, 8, 1, -16), Position = UDim2.fromOffset(6, 8), BackgroundColor3 = WHITE, BorderSizePixel = 0}, inner)
	round(accent, 4)
	gradient(accent, CYAN, PINK, 90)
	headshot(inner, from.Id, 52, UDim2.fromOffset(20, 10))
	text(inner, {Text = from.Display, Position = UDim2.fromOffset(80, 9), Size = UDim2.new(1, -196, 0, 26), TextXAlignment = Enum.TextXAlignment.Left})
	text(inner, {Text = "@" .. from.Name, FontFace = BOLD, TextColor3 = rgb(190, 200, 235), Position = UDim2.fromOffset(80, 36), Size = UDim2.new(1, -196, 0, 15), TextXAlignment = Enum.TextXAlignment.Left, StrokeThickness = 1.5})
	text(inner, {Text = "wants to trade!", FontFace = BOLD, TextColor3 = rgb(255, 210, 120), Position = UDim2.fromOffset(80, 51), Size = UDim2.new(1, -196, 0, 14), TextXAlignment = Enum.TextXAlignment.Left, StrokeThickness = 1.5})
	local yes = button(inner, "✓", GREEN, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -62, 0.5, -4), Size = UDim2.fromOffset(48, 46)})
	local no = button(inner, "X", RED, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, -4), Size = UDim2.fromOffset(48, 46)})
	-- temps restant
	local bar = new("Frame", {Position = UDim2.new(0, 20, 1, -10), Size = UDim2.new(1, -32, 0, 5), BackgroundColor3 = rgb(20, 18, 40), BorderSizePixel = 0}, inner)
	round(bar, 3)
	local fill = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0}, bar)
	round(fill, 3)
	gradient(fill, CYAN, PINK, 0)
	local left = math.max(1, (expires or 0) - workspace:GetServerTimeNow())
	tween(fill, left, {Size = UDim2.fromScale(0, 1)}, Enum.EasingStyle.Linear)
	tween(inner, 0.35, {Position = UDim2.fromOffset(0, 0)}, Enum.EasingStyle.Back)
	yes.Activated:Connect(function() actionRemote:FireServer("Accept", from.Id) removeInvite(from.Id) end)
	no.Activated:Connect(function() actionRemote:FireServer("Decline", from.Id) removeInvite(from.Id) end)
	task.delay(left, function() if invites[from.Id] == card then removeInvite(from.Id) end end)
end

---------------------------------------------------------------- paquets du serveur
local function toast(titleText, line, color)
	local f = new("Frame", {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, -90), Size = UDim2.fromOffset(480, 66), BackgroundColor3 = WHITE}, gui)
	round(f, 16)
	stroke(f, 3)
	gradient(f, color:Lerp(BLACK, 0.35), color:Lerp(BLACK, 0.7))
	studs(f, 26, 0.88)
	new("UIScale", {Scale = GuiScale.get()}, f)
	text(f, {Text = titleText, Position = UDim2.fromOffset(14, 7), Size = UDim2.new(1, -28, 0, 26), TextColor3 = color:Lerp(WHITE, 0.5)})
	text(f, {Text = line, FontFace = BOLD, Position = UDim2.fromOffset(14, 38), Size = UDim2.new(1, -28, 0, 20), StrokeThickness = 1.5})
	tween(f, 0.4, {Position = UDim2.new(0.5, 0, 0, 70)}, Enum.EasingStyle.Back)
	task.delay(5, function()
		tween(f, 0.3, {Position = UDim2.new(0.5, 0, 0, -90)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		task.delay(0.3, function() f:Destroy() end)
	end)
end

updateRemote.OnClientEvent:Connect(function(packet)
	if type(packet) ~= "table" then return end
	if packet.k == "lobby" then
		showLobby(packet)
	elseif packet.k == "trade" then
		for id in invites do removeInvite(id) end
		showTrade(packet)
	elseif packet.k == "request" then
		if type(packet.From) == "table" then addInvite(packet.From, packet.Expires) end
	elseif packet.k == "unrequest" then
		removeInvite(packet.Id)
	elseif packet.k == "done" then
		state = nil
		local names = {}
		for _, pet in packet.Got or {} do table.insert(names, pet.Name) end
		closeWindow()
		toast("TRADE COMPLETE with " .. tostring(packet.Other) .. "!", #names > 0 and ("You got: " .. table.concat(names, ", ")) or "You gave your pets as a gift.", GREEN)
	elseif packet.k == "closed" then
		state = nil
		closeWindow()
	end
end)

readyButton.Activated:Connect(function()
	if state then actionRemote:FireServer("Ready", not state.MyReady) end
end)
confirmButton.Activated:Connect(function()
	if state and confirmButton.Active then actionRemote:FireServer("Confirm") end
end)
cancelButton.Activated:Connect(function() actionRemote:FireServer("Cancel") end)
close.Activated:Connect(function()
	if state then actionRemote:FireServer("Cancel") end
	closeWindow()
end)

---------------------------------------------------------------- chaque image : barre d'attente, compte à rebours du CONFIRM, animations
local arrows = workspace:WaitForChild("Trade Machine"):WaitForChild("SwapArrows")
local arrowPivot = arrows:GetPivot()
local eggs = {}
for _, d in arrows.Parent:GetChildren() do if d.Name == "FloatEgg" then table.insert(eggs, {Part = d, Base = d.CFrame}) end end
local confirmHover = confirmButton:FindFirstChild("Hover")
RunService.RenderStepped:Connect(function()
	local t = os.clock()
	local cam = workspace.CurrentCamera
	if cam and (cam.CFrame.Position - arrowPivot.Position).Magnitude < 250 then
		arrows:PivotTo(arrowPivot * CFrame.new(0, math.sin(t * 2) * 0.3, 0) * CFrame.Angles(0, t * 1.2, 0))
		for i, e in eggs do e.Part.CFrame = e.Base * CFrame.new(0, math.sin(t * 2 + i) * 0.4, 0) * CFrame.Angles(0, t * (i == 1 and 1 or -1), 0) end
	end
	if not main.Visible then return end
	-- dégradé de l'en-tête qui défile doucement
	local off = math.sin(t * 0.8) * 0.25
	headerGradient.Offset, flatGradient.Offset = Vector2.new(off, 0), Vector2.new(off, 0)
	if not state then return end
	swapIcon.Rotation = math.sin(t * 2) * 12
	swapGradient.Rotation = (t * 60) % 360
	local left = editReadyAt - t
	cooldownFill.Size = UDim2.fromScale(left > 0 and math.clamp(1 - left / editCooldown, 0, 1) or 1, 1)
	local bothReady = state.MyReady and state.TheirReady and state.ConfirmAt
	local pulse = false
	if bothReady then
		local wait = state.ConfirmAt - workspace:GetServerTimeNow()
		if state.MyConfirm then
			setButton(confirmButton, "CONFIRMED", GREEN, false)
			say("Waiting for " .. state.Other.Display .. " to confirm...")
		elseif wait > 0 then
			setButton(confirmButton, "CONFIRM IN " .. math.ceil(wait), GREY, false)
			say("Both players are ready: check the offers carefully!")
		else
			setButton(confirmButton, "CONFIRM", GREEN, true)
			pulse = true
			say(state.TheirConfirm and (state.Other.Display .. " confirmed: press CONFIRM to trade!") or "Press CONFIRM to trade!")
		end
	else
		setButton(confirmButton, "CONFIRM", GREY, false)
		if left > 0 then
			say(string.format("Wait %.1fs before changing your offer again", left), true)
		elseif state.MyReady then
			say("Waiting for " .. state.Other.Display .. " to be ready...")
		else
			say("Add your pets, then press READY.")
		end
	end
	if pulse and confirmHover then confirmHover.Scale = 1 + 0.04 * math.sin(t * 8) end
end)

-- on s'éloigne beaucoup de la machine pendant l'accueil : la fenêtre se ferme (un échange en cours reste ouvert)
task.spawn(function()
	local spot = workspace["Trade Machine"]:WaitForChild("TradePrompt")
	while true do
		task.wait(0.5)
		local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if main.Visible and not state and root and (root.Position - spot.Position).Magnitude > 40 then closeWindow() end
	end
end)

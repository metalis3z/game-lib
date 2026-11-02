-- TradeClient : la fenêtre de la Trade Machine (le serveur, TradeServer, décide de tout).
--   accueil : joueurs du serveur (bouton SEND) et demandes reçues (ACCEPT / DECLINE)
--   échange : ton offre et la sienne (3 x 3), tous tes animaux en bas (clic = ajouter, clic sur ton offre = retirer),
--             barre d'attente de 2 s entre deux changements, READY, puis CONFIRM 3 s après que les deux sont prêts, CANCEL
--   une demande reçue s'affiche aussi en petit en haut de l'écran, même fenêtre fermée
-- Fond du panneau transparent à 50 %, contours noirs, dégradés et motif à studs comme les autres fenêtres du jeu.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
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
local function stroke(o, t, color) return new("UIStroke", {Thickness = t, Color = color or BLACK, ApplyStrokeMode = o:IsA("TextLabel") and Enum.ApplyStrokeMode.Contextual or Enum.ApplyStrokeMode.Border}, o) end
local function round(o, r) return new("UICorner", {CornerRadius = UDim.new(0, r)}, o) end
local function gradient(o, c1, c2, rot) return new("UIGradient", {Color = ColorSequence.new(c1, c2), Rotation = rot or 90}, o) end
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
	new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Image = STUDS, ImageTransparency = 0.82, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(28, 28), Size = UDim2.fromScale(1, 1), ZIndex = b.ZIndex}, b)
	local t = text(b, {Name = "Label", Text = label, Size = UDim2.fromScale(0.9, 0.62), Position = UDim2.fromScale(0.05, 0.19), ZIndex = b.ZIndex + 1})
	local scale = new("UIScale", {}, b)
	b.MouseEnter:Connect(function() TweenService:Create(scale, TweenInfo.new(0.12), {Scale = 1.05}):Play() end)
	b.MouseLeave:Connect(function() TweenService:Create(scale, TweenInfo.new(0.12), {Scale = 1}):Play() end)
	b.MouseButton1Down:Connect(function() TweenService:Create(scale, TweenInfo.new(0.06), {Scale = 0.95}):Play() end)
	b.MouseButton1Up:Connect(function() TweenService:Create(scale, TweenInfo.new(0.1), {Scale = 1.05}):Play() end)
	return b, t
end
local function setButton(b, label, color, enabled)
	b.Label.Text = label
	local g = b:FindFirstChildOfClass("UIGradient")
	g.Color = ColorSequence.new(color:Lerp(WHITE, 0.25), color:Lerp(BLACK, 0.15))
	b.Active = enabled
	b.AutoButtonColor = false
	b.Label.TextTransparency = enabled and 0 or 0.35
end

---------------------------------------------------------------- fenêtre
local gui = new("ScreenGui", {Name = "TradeGui", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 20, IgnoreGuiInset = false}, player:WaitForChild("PlayerGui"))
local main = new("Frame", {Name = "Main", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromOffset(900, 580),
	BackgroundColor3 = rgb(14, 12, 34), BackgroundTransparency = 0.5, Visible = false}, gui)
main:SetAttribute("SolidWindow", true) -- (UIPolish ne touche pas à cette fenêtre)
round(main, 20)
stroke(main, 4)
new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Image = STUDS, ImageTransparency = 0.9, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(40, 40), Size = UDim2.fromScale(1, 1)}, main)
local uiScale = new("UIScale", {}, main)
local function rescale() uiScale.Scale = math.min(GuiScale.get(), (workspace.CurrentCamera.ViewportSize.Y - 40) / 600, (workspace.CurrentCamera.ViewportSize.X - 20) / 920) end
rescale()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(rescale)

local header = new("Frame", {Name = "Header", Size = UDim2.new(1, 0, 0, 64), BackgroundColor3 = WHITE, BorderSizePixel = 0}, main)
round(header, 20)
gradient(header, rgb(40, 190, 255), rgb(200, 70, 220), 0)
new("Frame", {Size = UDim2.new(1, 0, 0, 20), Position = UDim2.new(0, 0, 1, -20), BackgroundColor3 = WHITE, BorderSizePixel = 0}, header):SetAttribute("Flat", true)
gradient(header:FindFirstChildOfClass("Frame"), rgb(40, 190, 255), rgb(200, 70, 220), 0)
stroke(header, 3)
local title = text(header, {Name = "Title", Text = "TRADE MACHINE", FontFace = FREDOKA, Size = UDim2.new(0.6, 0, 0, 44), Position = UDim2.new(0.03, 0, 0, 10), TextXAlignment = Enum.TextXAlignment.Left, StrokeThickness = 3, ZIndex = 2})
local close = button(header, "X", RED, {Name = "Close", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(46, 46), ZIndex = 3})

local status = text(main, {Name = "Status", Text = "", Size = UDim2.new(1, -40, 0, 24), Position = UDim2.new(0, 20, 1, -34), TextXAlignment = Enum.TextXAlignment.Center, FontFace = BOLD})

---------------------------------------------------------------- page d'accueil : joueurs et demandes
local lobby = new("Frame", {Name = "Lobby", BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 76), Size = UDim2.new(1, -32, 1, -120)}, main)
local function panel(parent, name, titleText, color, pos, size)
	local p = new("Frame", {Name = name, Position = pos, Size = size, BackgroundColor3 = rgb(24, 22, 52), BackgroundTransparency = 0.25}, parent)
	round(p, 14)
	stroke(p, 3)
	local bar = new("Frame", {Name = "Bar", Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = WHITE, BorderSizePixel = 0}, p)
	round(bar, 14)
	gradient(bar, color:Lerp(WHITE, 0.2), color:Lerp(BLACK, 0.25))
	local t = text(bar, {Name = "Title", Text = titleText, Size = UDim2.new(1, -20, 0, 24), Position = UDim2.fromOffset(10, 5)})
	return p, t
end
local playersPanel = panel(lobby, "Players", "PLAYERS", CYAN, UDim2.fromOffset(0, 0), UDim2.new(0.58, -8, 1, 0))
local playerList = new("ScrollingFrame", {Name = "List", BackgroundTransparency = 1, Position = UDim2.fromOffset(8, 42), Size = UDim2.new(1, -16, 1, -50), CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 6, BorderSizePixel = 0}, playersPanel)
new("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, playerList)
local requestsPanel = panel(lobby, "Requests", "REQUESTS", PINK, UDim2.new(0.58, 8, 0, 0), UDim2.new(0.42, -8, 1, 0))
local requestList = new("ScrollingFrame", {Name = "List", BackgroundTransparency = 1, Position = UDim2.fromOffset(8, 42), Size = UDim2.new(1, -16, 1, -50), CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 6, BorderSizePixel = 0}, requestsPanel)
new("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, requestList)

local function personRow(parent, info, order)
	local row = new("Frame", {Size = UDim2.new(1, -6, 0, 62), BackgroundColor3 = rgb(40, 36, 80), BackgroundTransparency = 0.15, LayoutOrder = order}, parent)
	round(row, 12)
	stroke(row, 2)
	local head = new("ImageLabel", {BackgroundColor3 = rgb(230, 235, 255), Position = UDim2.fromOffset(8, 7), Size = UDim2.fromOffset(48, 48),
		Image = "rbxthumb://type=AvatarHeadShot&id=" .. info.Id .. "&w=150&h=150"}, row)
	round(head, 24)
	stroke(head, 2)
	text(row, {Text = info.Display, Position = UDim2.fromOffset(66, 8), Size = UDim2.new(1, -200, 0, 24), TextXAlignment = Enum.TextXAlignment.Left})
	text(row, {Text = "@" .. info.Name, FontFace = BOLD, TextColor3 = rgb(190, 200, 230), Position = UDim2.fromOffset(66, 34), Size = UDim2.new(1, -200, 0, 18), TextXAlignment = Enum.TextXAlignment.Left, StrokeThickness = 1.5})
	return row
end

---------------------------------------------------------------- page d'échange
local tradePage = new("Frame", {Name = "Trade", BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 76), Size = UDim2.new(1, -32, 1, -120), Visible = false}, main)
local myPanel, myTitle = panel(tradePage, "MyOffer", "YOUR OFFER", CYAN, UDim2.fromOffset(0, 0), UDim2.new(0.5, -6, 0, 236))
local theirPanel, theirTitle = panel(tradePage, "TheirOffer", "THEIR OFFER", PINK, UDim2.new(0.5, 6, 0, 0), UDim2.new(0.5, -6, 0, 236))
local function badge(p)
	local b = text(p.Bar, {Name = "Badge", Text = "", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 6), Size = UDim2.fromOffset(120, 22), TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = GREEN})
	return b
end
local myBadge, theirBadge = badge(myPanel), badge(theirPanel)
local function offerGrid(p)
	local g = new("Frame", {Name = "Grid", BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 42), Size = UDim2.new(1, -20, 1, -50)}, p)
	new("UIGridLayout", {CellSize = UDim2.new(1 / 3, -6, 1 / 3, -6), CellPadding = UDim2.fromOffset(6, 6), SortOrder = Enum.SortOrder.LayoutOrder}, g)
	return g
end
local myGrid, theirGrid = offerGrid(myPanel), offerGrid(theirPanel)
local invPanel = panel(tradePage, "Inventory", "YOUR PETS  (click to add, click your offer to remove)", YELLOW, UDim2.fromOffset(0, 246), UDim2.new(1, 0, 0, 150))
local invList = new("ScrollingFrame", {Name = "List", BackgroundTransparency = 1, Position = UDim2.fromOffset(8, 40), Size = UDim2.new(1, -16, 1, -46), CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.X, ScrollingDirection = Enum.ScrollingDirection.X, ScrollBarThickness = 6, BorderSizePixel = 0}, invPanel)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, invList)
-- barre d'attente (2 s entre deux changements)
local cooldown = new("Frame", {Name = "Cooldown", Position = UDim2.fromOffset(0, 404), Size = UDim2.new(1, 0, 0, 10), BackgroundColor3 = rgb(30, 28, 60)}, tradePage)
round(cooldown, 5)
stroke(cooldown, 2)
local cooldownFill = new("Frame", {Size = UDim2.fromScale(0, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0}, cooldown)
round(cooldownFill, 5)
gradient(cooldownFill, YELLOW, rgb(255, 140, 40), 0)
local readyButton = button(tradePage, "READY", YELLOW, {Name = "Ready", Position = UDim2.new(0, 0, 0, 420), Size = UDim2.new(0.33, -6, 0, 44)})
local confirmButton = button(tradePage, "CONFIRM", GREY, {Name = "Confirm", Position = UDim2.new(0.335, 0, 0, 420), Size = UDim2.new(0.33, -6, 0, 44)})
local cancelButton = button(tradePage, "CANCEL", RED, {Name = "Cancel", Position = UDim2.new(0.67, 0, 0, 420), Size = UDim2.new(0.33, 0, 0, 44)})

-- wide = carte des grilles d'offre (cases larges et basses) : portrait à gauche, texte à droite
local function petCard(parent, pet, order, onClick, wide)
	local c = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = WHITE, LayoutOrder = order, Size = UDim2.fromOffset(96, 100)}, parent)
	round(c, 12)
	stroke(c, 2.5)
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
	c.MouseEnter:Connect(function() TweenService:Create(scale, TweenInfo.new(0.1), {Scale = 1.05}):Play() end)
	c.MouseLeave:Connect(function() TweenService:Create(scale, TweenInfo.new(0.1), {Scale = 1}):Play() end)
	if onClick then c.Activated:Connect(onClick) end
	return c
end

---------------------------------------------------------------- état
local state = nil       -- dernier paquet "trade"
local editReadyAt = 0   -- os.clock() à partir duquel on peut de nouveau ajouter / retirer
local editCooldown = 2
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

local function showLobby(packet)
	state = nil
	title.Text = "TRADE MACHINE"
	tradePage.Visible, lobby.Visible = false, true
	clear(playerList)
	if #packet.Players == 0 then
		text(playerList, {Text = "Nobody else is in this server yet.", Size = UDim2.new(1, -6, 0, 30), FontFace = BOLD, TextColor3 = rgb(200, 200, 230)})
	end
	for i, info in packet.Players do
		local row = personRow(playerList, info, i)
		local b = button(row, info.Busy and "BUSY" or "SEND", info.Busy and GREY or GREEN, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(110, 42)})
		if not info.Busy then b.Activated:Connect(function() actionRemote:FireServer("Request", info.Id) end) end
	end
	clear(requestList)
	if #packet.Requests == 0 then
		text(requestList, {Text = "No requests yet.", Size = UDim2.new(1, -6, 0, 30), FontFace = BOLD, TextColor3 = rgb(200, 200, 230)})
	end
	for i, info in packet.Requests do
		local row = personRow(requestList, info, i)
		local yes = button(row, "✓", GREEN, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -62, 0.5, 0), Size = UDim2.fromOffset(46, 42)})
		local no = button(row, "X", RED, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(46, 42)})
		yes.Activated:Connect(function() actionRemote:FireServer("Accept", info.Id) end)
		no.Activated:Connect(function() actionRemote:FireServer("Decline", info.Id) end)
	end
	say("Send a trade request to a player, or accept one of yours.")
	main.Visible = true
end

local function showTrade(packet)
	state = packet
	editCooldown = packet.EditCooldown or 2
	editReadyAt = os.clock() + (packet.EditWait or 0)
	lobby.Visible, tradePage.Visible = false, true
	title.Text = "TRADING WITH " .. string.upper(packet.Other.Display)
	theirTitle.Text = string.upper(packet.Other.Display) .. "'S OFFER"
	myBadge.Text = packet.MyConfirm and "CONFIRMED" or packet.MyReady and "READY ✓" or ""
	theirBadge.Text = packet.TheirConfirm and "CONFIRMED" or packet.TheirReady and "READY ✓" or ""
	clear(myGrid)
	for i, pet in packet.MyOffer do
		petCard(myGrid, pet, i, function()
			if canEdit() then actionRemote:FireServer("Remove", pet.Id) end
		end, true)
	end
	clear(theirGrid)
	for i, pet in packet.TheirOffer do petCard(theirGrid, pet, i, nil, true) end
	clear(invList)
	for i, pet in packet.Inventory do
		petCard(invList, pet, i, function()
			if #state.MyOffer >= (state.MaxOffer or 9) then say("Your offer is full (" .. (state.MaxOffer or 9) .. " pets max)", true) return end
			if canEdit() then actionRemote:FireServer("Add", pet.Id) end
		end)
	end
	if #packet.Inventory == 0 then
		text(invList, {Text = "No pets in your inventory (placed pets can't be traded).", Size = UDim2.fromOffset(520, 30), FontFace = BOLD, TextColor3 = rgb(220, 220, 240)})
	end
	setButton(readyButton, packet.MyReady and "UNREADY" or "READY", packet.MyReady and GREEN or YELLOW, true)
	main.Visible = true
end

updateRemote.OnClientEvent:Connect(function(packet)
	if type(packet) ~= "table" then return end
	if packet.k == "lobby" then
		showLobby(packet)
	elseif packet.k == "trade" then
		showTrade(packet)
	elseif packet.k == "request" then
		-- petite demande en haut de l'écran (même fenêtre fermée)
		local toast = gui:FindFirstChild("RequestToast")
		if toast then toast:Destroy() end
		toast = new("Frame", {Name = "RequestToast", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 70), Size = UDim2.fromOffset(420, 70),
			BackgroundColor3 = rgb(14, 12, 34), BackgroundTransparency = 0.25}, gui)
		round(toast, 14)
		stroke(toast, 3)
		new("UIScale", {Scale = GuiScale.get()}, toast)
		text(toast, {Text = packet.From.Display .. " wants to trade!", Position = UDim2.fromOffset(12, 8), Size = UDim2.new(1, -140, 0, 26), TextXAlignment = Enum.TextXAlignment.Left})
		text(toast, {Text = "@" .. packet.From.Name, FontFace = BOLD, TextColor3 = rgb(190, 200, 230), Position = UDim2.fromOffset(12, 38), Size = UDim2.new(1, -140, 0, 20), TextXAlignment = Enum.TextXAlignment.Left, StrokeThickness = 1.5})
		local yes = button(toast, "✓", GREEN, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -66, 0.5, 0), Size = UDim2.fromOffset(50, 46)})
		local no = button(toast, "X", RED, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(50, 46)})
		yes.Activated:Connect(function() actionRemote:FireServer("Accept", packet.From.Id) toast:Destroy() end)
		no.Activated:Connect(function() actionRemote:FireServer("Decline", packet.From.Id) toast:Destroy() end)
		task.delay(math.max(1, (packet.Expires or 0) - workspace:GetServerTimeNow()), function() if toast.Parent then toast:Destroy() end end)
		if lobby.Visible and main.Visible then actionRemote:FireServer("Lobby") end
	elseif packet.k == "done" then
		state = nil
		local names = {}
		for _, pet in packet.Got or {} do table.insert(names, pet.Name) end
		main.Visible = false
		local toast = new("Frame", {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 70), Size = UDim2.fromOffset(460, 64), BackgroundColor3 = rgb(20, 60, 30), BackgroundTransparency = 0.2}, gui)
		round(toast, 14)
		stroke(toast, 3)
		new("UIScale", {Scale = GuiScale.get()}, toast)
		text(toast, {Text = "TRADE COMPLETE with " .. tostring(packet.Other) .. "!", Position = UDim2.fromOffset(12, 6), Size = UDim2.new(1, -24, 0, 26), TextColor3 = rgb(150, 255, 150)})
		text(toast, {Text = #names > 0 and ("You got: " .. table.concat(names, ", ")) or "You gave your pets as a gift.", FontFace = BOLD, Position = UDim2.fromOffset(12, 36), Size = UDim2.new(1, -24, 0, 20), StrokeThickness = 1.5})
		task.delay(5, function() toast:Destroy() end)
	elseif packet.k == "closed" then
		state = nil
		main.Visible = false
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
	main.Visible = false
end)

---------------------------------------------------------------- chaque image : barre d'attente, compte à rebours du CONFIRM, flèches de la machine
local arrows = workspace:WaitForChild("Trade Machine"):WaitForChild("SwapArrows")
local arrowPivot = arrows:GetPivot()
local eggs = {}
for _, d in arrows.Parent:GetChildren() do if d.Name == "FloatEgg" then table.insert(eggs, {Part = d, Base = d.CFrame}) end end
RunService.RenderStepped:Connect(function()
	local t = os.clock()
	local cam = workspace.CurrentCamera
	if cam and (cam.CFrame.Position - arrowPivot.Position).Magnitude < 250 then
		arrows:PivotTo(arrowPivot * CFrame.new(0, math.sin(t * 2) * 0.3, 0) * CFrame.Angles(0, t * 1.2, 0))
		for i, e in eggs do e.Part.CFrame = e.Base * CFrame.new(0, math.sin(t * 2 + i) * 0.4, 0) * CFrame.Angles(0, t * (i == 1 and 1 or -1), 0) end
	end
	if not main.Visible or not state then return end
	local left = editReadyAt - t
	cooldownFill.Size = UDim2.fromScale(left > 0 and math.clamp(1 - left / editCooldown, 0, 1) or 1, 1)
	local bothReady = state.MyReady and state.TheirReady and state.ConfirmAt
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
end)

-- on s'éloigne beaucoup de la machine pendant l'accueil : la fenêtre se ferme (un échange en cours reste ouvert)
task.spawn(function()
	local spot = workspace["Trade Machine"]:WaitForChild("TradePrompt")
	while true do
		task.wait(0.5)
		local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if main.Visible and not state and root and (root.Position - spot.Position).Magnitude > 40 then main.Visible = false end
	end
end)

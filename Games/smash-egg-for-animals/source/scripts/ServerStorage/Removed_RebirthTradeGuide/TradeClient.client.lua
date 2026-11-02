-- TradeClient : interfaces des échanges de pets (logique serveur : ServerScriptService.TradeServer)
-- Même style que les autres fenêtres du jeu (ReplicatedStorage.UIKit)
--  * bouton Trade (colonne de gauche) -> fenêtre de recherche : on tape un pseudo et on envoie une invitation
--    (marche même si le joueur est dans un autre serveur)
--  * invitation reçue -> carte en bas à droite "<Name> invited you to trade!" avec Accept / Close
--  * fenêtre d'échange : on clique sur ses pets pour les poser (9 max), on voit l'offre de l'autre,
--    Ready des deux côtés -> 3 s -> échange fait
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local UI = require(ReplicatedStorage:WaitForChild("UIKit"))
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local system = ReplicatedStorage:WaitForChild("TradeSystem")
local request = system:WaitForChild("TradeRequest")
local update = system:WaitForChild("TradeUpdate")
local EggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(EggSystem:WaitForChild("EggConfig"))
local petModels = EggSystem:WaitForChild("Pets")

local new = UI.new
local MAX_OFFER = 9
local YELLOW = Color3.fromRGB(255, 221, 64)
local LIGHT_GREEN = Color3.fromRGB(150, 255, 150)
local LIGHT_RED = Color3.fromRGB(255, 120, 120)
local RARITY_COLORS = {
	Common = Color3.fromRGB(200, 200, 200), Uncommon = Color3.fromRGB(110, 230, 120), Rare = Color3.fromRGB(90, 170, 255),
	Epic = Color3.fromRGB(190, 110, 255), Legendary = Color3.fromRGB(255, 200, 60), Mythic = Color3.fromRGB(255, 110, 210),
	Secret = Color3.fromRGB(255, 60, 80), Halloween = Color3.fromRGB(255, 140, 30),
}

local gui = new("ScreenGui", {Name = "TradeGui", ResetOnSpawn = false, DisplayOrder = 70, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, playerGui)

---------------------------------------------------------------- petit message en haut de l'écran
local toast = UI.text(gui, {Name = "Toast", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 120), Size = UDim2.fromOffset(560, 34), Text = "", TextColor3 = YELLOW, Visible = false})
local toastId = 0
local function notify(msg, color)
	toastId += 1
	local id = toastId
	toast.Text = msg
	toast.TextColor3 = color or YELLOW
	toast.Visible = true
	task.delay(3.5, function() if toastId == id then toast.Visible = false end end)
end

---------------------------------------------------------------- image d'un pet (ViewportFrame)
local function petView(parent, petName, mutation)
	local view = new("ViewportFrame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Ambient = Color3.fromRGB(200, 200, 200), LightDirection = Vector3.new(-0.5, -1, -0.6), ZIndex = parent.ZIndex + 1}, parent)
	local template = petModels:FindFirstChild(petName)
	if template then
		local m = template:Clone()
		if mutation then pcall(Config.ApplyMutation, m, mutation) end
		m:PivotTo(CFrame.new())
		m.Parent = view
		local cf, size = m:GetBoundingBox()
		local r = size.Magnitude * 0.62
		local cam = new("Camera", {FieldOfView = 40}, view)
		cam.CFrame = CFrame.lookAt(cf.Position + Vector3.new(r * 0.7, r * 0.35, -r * 1.25), cf.Position)
		view.CurrentCamera = cam
	end
	return view
end

-- carte d'un pet : image + nom + poids, contour de la couleur de sa rareté
local function petCard(parent, pet, order, onClick)
	local info = Config.Pets[pet.p] or {Name = pet.p, Rarity = "Common"}
	local rarityColor = RARITY_COLORS[info.Rarity] or Color3.new(1, 1, 1)
	local card = new("TextButton", {Name = "Pet", LayoutOrder = order, AutoButtonColor = onClick ~= nil, Text = "", Size = UDim2.fromOffset(92, 110), ZIndex = 3}, parent)
	UI.surface(card, 22)
	new("UIStroke", {Thickness = 3.5, Color = rarityColor, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, card)
	local holder = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 3), Size = UDim2.new(1, -8, 0, 64), ZIndex = 3}, card)
	petView(holder, pet.p, pet.m)
	local prefix = (pet.m and (pet.m .. " ") or "") .. (pet.t and (pet.t .. " ") or "")
	UI.text(card, {Position = UDim2.fromOffset(4, 68), Size = UDim2.new(1, -8, 0, 18), Text = prefix .. info.Name, TextColor3 = rarityColor, ZIndex = 4, Stroke = 2.5})
	UI.text(card, {Position = UDim2.fromOffset(4, 87), Size = UDim2.new(1, -8, 0, 17), Text = Config.FormatKg(pet.k or 0), ZIndex = 4, Stroke = 2.5})
	if onClick then card.Activated:Connect(onClick) end
	return card
end

local function clear(frame)
	for _, c in frame:GetChildren() do if c:IsA("GuiObject") then c:Destroy() end end
end

---------------------------------------------------------------- 1. RECHERCHE + INVITATION
local search, _, _, searchClose = UI.window(gui, "TradeSearch", UDim2.fromOffset(500, 330), "Trade", "orange")
local sub = UI.text(search, {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 80), Size = UDim2.new(1, -40, 0, 30), Text = "~ Trade pets with anyone, even in another server ~"})
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(Color3.fromRGB(235, 59, 59), Color3.fromRGB(255, 159, 0))}, sub)
local box = UI.input(search, {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 124), Size = UDim2.new(1, -40, 0, 56), PlaceholderText = "Enter a username...", Text = "",
	PlaceholderColor3 = Color3.fromRGB(150, 150, 170)})
local sendButton = UI.button(search, "Send Invite", "green", {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 200), Size = UDim2.fromOffset(240, 56)})
local searchStatus = UI.text(search, {AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -16), Size = UDim2.new(1, -40, 0, 32), Text = ""})

local sending = false
local function sendInvite()
	if sending then return end
	local name = box.Text
	if #name < 3 then searchStatus.Text = "Enter a username." searchStatus.TextColor3 = LIGHT_RED return end
	sending = true
	sendButton.Text = "Sending..."
	searchStatus.Text = "Looking for " .. name .. "..."
	searchStatus.TextColor3 = Color3.new(1, 1, 1)
	local ok, success, msg = pcall(function() return request:InvokeServer("Invite", name) end)
	if not ok then success, msg = false, "Server error, try again." end
	searchStatus.Text = msg or ""
	searchStatus.TextColor3 = success and LIGHT_GREEN or LIGHT_RED
	sendButton.Text = "Send Invite"
	sending = false
end
sendButton.Activated:Connect(sendInvite)
box.FocusLost:Connect(function(enter) if enter then sendInvite() end end)
searchClose.Activated:Connect(function() search.Visible = false end)

---------------------------------------------------------------- 2. INVITATIONS REÇUES (en bas à droite)
local invites = new("Frame", {Name = "Invites", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -16, 1, -190), Size = UDim2.fromOffset(340, 420)}, gui)
new("UIListLayout", {VerticalAlignment = Enum.VerticalAlignment.Bottom, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, invites)
local inviteCards = {}
local CARD_H = 132

local function removeInvite(id)
	local card = inviteCards[id]
	inviteCards[id] = nil
	if card then
		TweenService:Create(card, TweenInfo.new(0.2), {Size = UDim2.fromOffset(340, 0)}):Play()
		task.delay(0.2, function() card:Destroy() end)
	end
end

local function showInvite(id, fromName)
	local card = new("Frame", {Name = "Invite", Size = UDim2.fromOffset(340, 0), ClipsDescendants = true, LayoutOrder = -math.floor(os.clock() * 10)}, invites)
	UI.surface(card, 28)
	new("UIStroke", {Thickness = 4, Color = UI.INK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, card)
	-- bandeau de titre orange (comme les fenêtres)
	local head = new("Frame", {Position = UDim2.fromOffset(8, 8), Size = UDim2.new(1, -16, 0, 34), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 2}, card)
	UI.corner(head)
	UI.outline(head, 3)
	local hc = UI.HEADERS.orange
	new("UIGradient", {Rotation = 0, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, hc[1]), ColorSequenceKeypoint.new(0.5, hc[2]), ColorSequenceKeypoint.new(1, hc[1])})}, head)
	UI.studs(head, 24)
	UI.text(head, {Position = UDim2.fromOffset(10, 5), Size = UDim2.new(1, -20, 1, -10), Text = "Trade Request", ZIndex = 3, Stroke = 3.5})
	UI.text(card, {Position = UDim2.fromOffset(12, 48), Size = UDim2.new(1, -24, 0, 26), Text = fromName .. " invited you to trade!", ZIndex = 2})
	local accept = UI.button(card, "Accept", "green", {Position = UDim2.new(0, 12, 0, 80), Size = UDim2.new(0.5, -18, 0, 40), ZIndex = 2})
	local close = UI.button(card, "Close", "red", {Position = UDim2.new(0.5, 6, 0, 80), Size = UDim2.new(0.5, -18, 0, 40), ZIndex = 2})
	local bar = new("Frame", {Position = UDim2.new(0, 12, 1, -7), Size = UDim2.new(1, -24, 0, 4), BackgroundColor3 = Color3.fromRGB(255, 160, 40), BorderSizePixel = 0, ZIndex = 2}, card)
	TweenService:Create(bar, TweenInfo.new(30, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 4)}):Play()
	TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(340, CARD_H)}):Play()
	inviteCards[id] = card
	accept.Activated:Connect(function()
		removeInvite(id)
		local ok, success, msg = pcall(function() return request:InvokeServer("Respond", id, true) end)
		if ok and not success and msg then notify(msg, LIGHT_RED) end
	end)
	close.Activated:Connect(function()
		removeInvite(id)
		pcall(function() request:InvokeServer("Respond", id, false) end)
	end)
	task.delay(30, function() removeInvite(id) end)
end

---------------------------------------------------------------- 3. FENÊTRE D'ÉCHANGE
local trade, _, tradeTitle, tradeClose = UI.window(gui, "TradeWindow", UDim2.fromOffset(840, 600), "Trading", "blue")

local function offerPanel(x, title)
	local panel = UI.box(trade, {Position = UDim2.new(x, x == 0 and 10 or 5, 0, 78), Size = UDim2.new(0.5, -15, 0, 280)})
	local head = UI.text(panel, {Position = UDim2.fromOffset(10, 6), Size = UDim2.new(0.62, -10, 0, 28), Text = title, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2})
	local status = UI.text(panel, {AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 8), Size = UDim2.new(0.38, 0, 0, 24), Text = "", TextColor3 = LIGHT_GREEN,
		TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 2})
	local grid = new("Frame", {Position = UDim2.fromOffset(8, 40), Size = UDim2.new(1, -16, 1, -48), BackgroundTransparency = 1, ZIndex = 2}, panel)
	new("UIGridLayout", {CellSize = UDim2.fromOffset(92, 110), CellPadding = UDim2.fromOffset(6, 6), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder}, grid)
	return panel, head, status, grid
end
local myPanel, myHead, myStatus, myGrid = offerPanel(0, "Your Offer")
local theirPanel, theirHead, theirStatus, theirGrid = offerPanel(0.5, "Their Offer")
local myCheck = new("UIGradient", {Name = "ReadyShade", Rotation = 90, Enabled = false, Color = ColorSequence.new(Color3.fromRGB(215, 255, 215), Color3.fromRGB(160, 235, 160))}, myPanel)
local theirCheck = new("UIGradient", {Name = "ReadyShade", Rotation = 90, Enabled = false, Color = ColorSequence.new(Color3.fromRGB(215, 255, 215), Color3.fromRGB(160, 235, 160))}, theirPanel)

-- inventaire (on clique pour ajouter)
local invPanel = UI.box(trade, {Position = UDim2.fromOffset(10, 366), Size = UDim2.new(1, -20, 0, 146)})
UI.text(invPanel, {Position = UDim2.fromOffset(10, 4), Size = UDim2.new(1, -20, 0, 24), Text = "Your pets (click to add / remove)", TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2})
local invScroll = new("ScrollingFrame", {Position = UDim2.fromOffset(6, 30), Size = UDim2.new(1, -12, 1, -34), BackgroundTransparency = 1, ScrollBarThickness = 8, ZIndex = 2,
	ScrollingDirection = Enum.ScrollingDirection.X, AutomaticCanvasSize = Enum.AutomaticSize.X, CanvasSize = UDim2.new(), ScrollBarImageColor3 = UI.INK}, invPanel)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center}, invScroll)
new("UIPadding", {PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4)}, invScroll)
local emptyInv = UI.text(invPanel, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.6), Size = UDim2.new(0.85, 0, 0, 26),
	Text = "No pets in your inventory (placed pets can't be traded).", Visible = false, ZIndex = 2})

local cancelButton = UI.button(trade, "Cancel", "red", {AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 14, 1, -14), Size = UDim2.fromOffset(190, 60)})
local readyButton = UI.button(trade, "Ready", "green", {AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -14, 1, -14), Size = UDim2.fromOffset(230, 60)})
local tradeStatus = UI.text(trade, {AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -28), Size = UDim2.new(0, 330, 0, 30), Text = ""})

local state -- dernier état envoyé par le serveur
local tradable = {}
local busy = false

local function setOffer(ids)
	if busy then return end
	busy = true
	pcall(function() request:InvokeServer("SetOffer", ids) end)
	busy = false
end

local function refreshInventory()
	local ok, list = pcall(function() return request:InvokeServer("GetTradable") end)
	tradable = ok and list or {}
	table.sort(tradable, function(a, b)
		local ia, ib = Config.Pets[a.Pet], Config.Pets[b.Pet]
		return (ia and ia.Income or 0) > (ib and ib.Income or 0)
	end)
end

local function render()
	if not state then return end
	tradeTitle.Text = "Trading with " .. (state.PartnerName or "?")
	theirHead.Text = (state.PartnerName or "Their") .. "'s Offer"
	-- mon offre
	clear(myGrid)
	local offered = {}
	for _, id in state.MyIds or {} do offered[id] = true end
	for i, pet in state.MyPets or {} do
		local id = state.MyIds[i]
		petCard(myGrid, pet, i, function()
			local ids = {}
			for _, other in state.MyIds do if other ~= id then table.insert(ids, other) end end
			setOffer(ids)
		end)
	end
	-- son offre
	clear(theirGrid)
	for i, pet in state.TheirPets or {} do petCard(theirGrid, pet, i) end
	-- inventaire
	clear(invScroll)
	local shown = 0
	for i, rec in tradable do
		if not offered[rec.Id] then
			shown += 1
			petCard(invScroll, {p = rec.Pet, k = rec.Kg, m = rec.Mutation, t = rec.Trait}, i, function()
				if #state.MyIds >= MAX_OFFER then notify("You can offer " .. MAX_OFFER .. " pets max.", LIGHT_RED) return end
				local ids = table.clone(state.MyIds)
				table.insert(ids, rec.Id)
				setOffer(ids)
			end)
		end
	end
	emptyInv.Visible = shown == 0
	-- prêt ?
	myStatus.Text = state.MyReady and "Ready ✔" or ""
	theirStatus.Text = state.TheirReady and "Ready ✔" or ""
	myPanel.Shade.Enabled = not state.MyReady
	myCheck.Enabled = state.MyReady == true
	theirPanel.Shade.Enabled = not state.TheirReady
	theirCheck.Enabled = state.TheirReady == true
	readyButton.Text = state.MyReady and "Unready" or "Ready"
	UI.recolor(readyButton, state.MyReady and "orange" or "green")
	local locked = state.Phase == "locking"
	readyButton.Visible = not locked
	cancelButton.Visible = not locked
	tradeClose.Visible = not locked
end

-- compte à rebours / statut en bas
RunService.RenderStepped:Connect(function()
	if not trade.Visible or not state then return end
	if state.Phase == "countdown" and state.CountdownEnd then
		local left = math.max(0, math.ceil(state.CountdownEnd - workspace:GetServerTimeNow()))
		tradeStatus.Text = "Trading in " .. left .. "..."
		tradeStatus.TextColor3 = YELLOW
	elseif state.Phase == "locking" then
		tradeStatus.Text = "Trading..."
		tradeStatus.TextColor3 = YELLOW
	elseif state.MyReady and not state.TheirReady then
		tradeStatus.Text = "Waiting for " .. (state.PartnerName or "them") .. "..."
		tradeStatus.TextColor3 = Color3.new(1, 1, 1)
	else
		tradeStatus.Text = "Add pets, then press Ready"
		tradeStatus.TextColor3 = Color3.new(1, 1, 1)
	end
end)

readyButton.Activated:Connect(function()
	if not state then return end
	pcall(function() request:InvokeServer("Ready", not state.MyReady) end)
end)
local function cancel()
	local ok, success, msg = pcall(function() return request:InvokeServer("Cancel") end)
	if ok and success == false and msg then notify(msg, LIGHT_RED) end
end
cancelButton.Activated:Connect(cancel)
tradeClose.Activated:Connect(cancel)

---------------------------------------------------------------- messages du serveur
update.OnClientEvent:Connect(function(p)
	if p.Type == "Invite" then
		showInvite(p.Id, p.FromName or "Someone")
	elseif p.Type == "InviteGone" then
		removeInvite(p.Id)
	elseif p.Type == "Open" then
		search.Visible = false
		state = {PartnerName = p.PartnerName, MyIds = {}, MyPets = {}, TheirPets = {}}
		refreshInventory()
		trade.Visible = true
		render()
	elseif p.Type == "State" then
		state = p
		if trade.Visible then render() end
	elseif p.Type == "Closed" then
		trade.Visible = false
		state = nil
		notify(p.Reason or "Trade closed.", p.Success and LIGHT_GREEN or LIGHT_RED)
	elseif p.Type == "Notify" then
		notify(p.Text)
	end
end)

---------------------------------------------------------------- bouton Trade (colonne de gauche)
task.spawn(function()
	local holder = playerGui:WaitForChild("left bottom", 30)
	holder = holder and holder:WaitForChild("Holder", 10)
	local tradeButton = holder and holder:WaitForChild("TradeButton", 10)
	if tradeButton then
		tradeButton.Activated:Connect(function()
			if trade.Visible then return end
			search.Visible = not search.Visible
			searchStatus.Text = ""
		end)
	end
end)

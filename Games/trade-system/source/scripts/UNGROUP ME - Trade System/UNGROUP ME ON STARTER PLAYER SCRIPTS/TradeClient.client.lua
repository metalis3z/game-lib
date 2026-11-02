local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ItemsCatalog = require(ReplicatedStorage:WaitForChild("FeatureConfigs"):WaitForChild("Items"))

local RARITY_COLORS = {
	Common = Color3.fromRGB(190, 190, 190),
	Uncommon = Color3.fromRGB(90, 220, 100),
	Rare = Color3.fromRGB(90, 160, 255),
	Epic = Color3.fromRGB(200, 90, 255),
	Legendary = Color3.fromRGB(255, 200, 60),
	Mythic = Color3.fromRGB(255, 60, 60),
	Secret = Color3.fromRGB(255, 255, 255),
}

local gui = playerGui:WaitForChild("TradeGui")
local openButton = gui:WaitForChild("OpenTradeButton")
local searchFrame = gui:WaitForChild("SearchFrame")
local searchBox = searchFrame:WaitForChild("SearchBox")
local resultsList = searchFrame:WaitForChild("ResultsList")
local rowTemplate = resultsList:WaitForChild("PlayerRowTemplate")
local searchCloseButton = searchFrame:WaitForChild("CloseButton")

local requestPopup = gui:WaitForChild("RequestPopup")
local requestLabel = requestPopup:WaitForChild("MessageLabel")
local acceptButton = requestPopup:WaitForChild("AcceptButton")
local declineButton = requestPopup:WaitForChild("DeclineButton")

local tradeWindow = gui:WaitForChild("TradeWindow")
local twTitle = tradeWindow:WaitForChild("TitleLabel")
local twCloseButton = tradeWindow:WaitForChild("CloseButton")
local yourOfferGrid = tradeWindow:WaitForChild("YourOfferPanel"):WaitForChild("ItemsGrid")
local theirOfferGrid = tradeWindow:WaitForChild("TheirOfferPanel"):WaitForChild("ItemsGrid")
local inventoryGrid = tradeWindow:WaitForChild("InventoryPanel"):WaitForChild("ItemsGrid")
local statusPanel = tradeWindow:WaitForChild("StatusPanel")
local statusLabel = statusPanel:WaitForChild("StatusLabel")
local readyButton = statusPanel:WaitForChild("ReadyButton")
local cancelButton = statusPanel:WaitForChild("CancelButton")

local itemSlotTemplate = gui:WaitForChild("Templates"):WaitForChild("ItemSlotTemplate")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local searchFn = Remotes:WaitForChild("TradeSearchPlayers")
local inventoryFn = Remotes:WaitForChild("TradeGetInventory")
local sendRequestEvent = Remotes:WaitForChild("TradeSendRequest")
local respondEvent = Remotes:WaitForChild("TradeRespondRequest")
local addItemEvent = Remotes:WaitForChild("TradeAddItem")
local removeItemEvent = Remotes:WaitForChild("TradeRemoveItem")
local readyEvent = Remotes:WaitForChild("TradeSetReady")
local cancelEvent = Remotes:WaitForChild("TradeCancel")

local tradeRequestResult = Remotes:WaitForChild("TradeRequestResult")
local tradeRequestReceived = Remotes:WaitForChild("TradeRequestReceived")
local tradeStarted = Remotes:WaitForChild("TradeStarted")
local tradeUpdate = Remotes:WaitForChild("TradeUpdate")
local tradeCancelled = Remotes:WaitForChild("TradeCancelled")
local tradeCompleted = Remotes:WaitForChild("TradeCompleted")

local myInventory = {} -- key -> {name, icon, rarity, count}
local iAmReady = false

-- ===================== BÚSQUEDA =====================

local function clearResults()
	for _, child in ipairs(resultsList:GetChildren()) do
		if child ~= rowTemplate and child.Name ~= "EmptyLabel" and child:IsA("GuiObject") then
			child:Destroy()
		end
	end
end

local resultsListRef = resultsList
local emptyLabelRef
local searchToken = 0 -- para ignorar respuestas viejas si el usuario sigue escribiendo

local showToast -- forward declare (se define más abajo, pero addRow ya la necesita)

local function addRow(userId, displayName, username, isOnline)
	local row = rowTemplate:Clone()
	row.Name = "Row_" .. tostring(userId)
	row.Visible = true

	local nameLabel = row:FindFirstChild("NameLabel")
	if nameLabel then
		nameLabel.Text = displayName .. " (@" .. username .. ")"
	end

	local onlineDot = row:FindFirstChild("OnlineDot")
	if onlineDot then
		onlineDot.Visible = true
		onlineDot.BackgroundColor3 = isOnline and Color3.fromRGB(80, 220, 100) or Color3.fromRGB(140, 140, 140)
	end

	local tradeButton = row:FindFirstChild("SendTradeButton")
	if tradeButton then
		if isOnline then
			tradeButton.Text = "Trade"
			tradeButton.BackgroundColor3 = Color3.fromRGB(80, 170, 255)
			tradeButton.AutoButtonColor = true
			tradeButton.MouseButton1Click:Connect(function()
				sendRequestEvent:FireServer(username)
				searchFrame.Visible = false
			end)
		else
			tradeButton.Text = "Desconectado"
			tradeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 78)
			tradeButton.AutoButtonColor = false
			tradeButton.MouseButton1Click:Connect(function()
				showToast(false, displayName .. " no está conectado ahora mismo")
			end)
		end
	end

	row.Parent = resultsList
end

local function refreshSearch()
	emptyLabelRef = emptyLabelRef or resultsList:FindFirstChild("EmptyLabel")
	local query = searchBox.Text:lower():gsub("^%s+", ""):gsub("%s+$", "")

	searchToken += 1
	local myToken = searchToken

	-- 1) Resultado inmediato: jugadores de ESTE mismo servidor (siempre disponible al toque)
	clearResults()
	local shownIds = {}
	local shown = 0

	for _, targetPlayer in ipairs(Players:GetPlayers()) do
		if targetPlayer ~= player then
			local username = targetPlayer.Name:lower()
			local displayName = targetPlayer.DisplayName:lower()
			local matches = query == "" or username:find(query, 1, true) or displayName:find(query, 1, true)
			if matches then
				addRow(targetPlayer.UserId, targetPlayer.DisplayName, targetPlayer.Name, true)
				shownIds[targetPlayer.UserId] = true
				shown += 1
			end
		end
	end

	if emptyLabelRef then
		emptyLabelRef.Visible = (shown == 0)
		emptyLabelRef.Text = "Buscando en otros servidores..."
	end

	-- 2) Búsqueda real en el servidor (encuentra gente en CUALQUIER servidor del juego)
	task.spawn(function()
		local ok, results = pcall(function()
			return searchFn:InvokeServer(searchBox.Text)
		end)

		if myToken ~= searchToken then return end -- el usuario ya escribió otra cosa, ignorar esta respuesta vieja

		if ok and results then
			for _, entry in ipairs(results) do
				if not shownIds[entry.userId] then
					addRow(entry.userId, entry.displayName, entry.name, entry.online ~= false)
					shownIds[entry.userId] = true
					shown += 1
				end
			end
		end

		if emptyLabelRef then
			emptyLabelRef.Visible = (shown == 0)
			emptyLabelRef.Text = (query ~= "" and shown == 0)
				and ("No se encontró a nadie llamado \"" .. searchBox.Text .. "\"")
				or "No hay otros jugadores conectados"
		end
	end)
end

-- Abrir búsqueda
openButton.MouseButton1Click:Connect(function()
	searchFrame.Visible = true
	searchBox.Text = ""
	refreshSearch()
end)

-- Cerrar búsqueda
searchCloseButton.MouseButton1Click:Connect(function()
	searchFrame.Visible = false
end)

-- Buscar mientras escribís (en vivo) y también al presionar Enter
searchBox:GetPropertyChangedSignal("Text"):Connect(refreshSearch)
searchBox.FocusLost:Connect(function(enterPressed)
	refreshSearch()
end)

-- Actualizar si entra o sale un jugador
Players.PlayerAdded:Connect(function()
	if searchFrame.Visible then
		refreshSearch()
	end
end)

Players.PlayerRemoving:Connect(function()
	if searchFrame.Visible then
		task.defer(refreshSearch)
	end
end)

-- ===================== PEDIDOS DE TRADE =====================
local pendingFromPlayer = nil

tradeRequestReceived.OnClientEvent:Connect(function(fromPlayerName)
	pendingFromPlayer = fromPlayerName
	requestLabel.Text = fromPlayerName .. " te quiere tradear"
	requestPopup.Visible = true
end)

acceptButton.MouseButton1Click:Connect(function()
	requestPopup.Visible = false
	respondEvent:FireServer(true)
end)

declineButton.MouseButton1Click:Connect(function()
	requestPopup.Visible = false
	respondEvent:FireServer(false)
end)

-- Feedback visible en pantalla al mandar un pedido (antes solo se imprimía en consola)
-- NOTA: antes este script esperaba (WaitForChild sin timeout) un "ToastGui" que nunca
-- existía en StarterGui.TradeGui. Eso colgaba el script para siempre y por eso nunca se
-- llegaba a conectar tradeStarted.OnClientEvent: al aceptar un trade no pasaba nada.
-- Ahora el toast se crea por código, así no depende de un objeto pre-armado en el GUI.
local toastGui = Instance.new("Frame")
toastGui.Name = "ToastGui"
toastGui.AnchorPoint = Vector2.new(0.5, 0)
toastGui.Position = UDim2.new(0.5, 0, 0, 20)
toastGui.Size = UDim2.new(0, 360, 0, 46)
toastGui.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
toastGui.BackgroundTransparency = 0.05
toastGui.Visible = false
toastGui.ZIndex = 50
toastGui.Parent = gui

local toastCorner = Instance.new("UICorner")
toastCorner.CornerRadius = UDim.new(0, 8)
toastCorner.Parent = toastGui

local toastStroke = Instance.new("UIStroke")
toastStroke.Name = "BorderStroke"
toastStroke.Thickness = 2
toastStroke.Color = Color3.fromRGB(90, 220, 120)
toastStroke.Parent = toastGui

local toastLabel = Instance.new("TextLabel")
toastLabel.Name = "MessageLabel"
toastLabel.BackgroundTransparency = 1
toastLabel.Size = UDim2.new(1, -16, 1, 0)
toastLabel.Position = UDim2.new(0, 8, 0, 0)
toastLabel.Font = Enum.Font.GothamMedium
toastLabel.TextSize = 16
toastLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
toastLabel.TextWrapped = true
toastLabel.Text = ""
toastLabel.ZIndex = 51
toastLabel.Parent = toastGui

local toastThread = nil

function showToast(success, message)
	if toastThread then
		task.cancel(toastThread)
	end
	toastLabel.Text = tostring(message)
	toastStroke.Color = success and Color3.fromRGB(90, 220, 120) or Color3.fromRGB(220, 80, 80)
	toastGui.Visible = true
	toastThread = task.spawn(function()
		task.wait(3.5)
		toastGui.Visible = false
	end)
end

tradeRequestResult.OnClientEvent:Connect(function(success, message)
	print("[Trade] " .. tostring(message))
	showToast(success, message)
end)

-- ===================== VENTANA DE TRADE =====================
local function clearGrid(grid)
	for _, child in ipairs(grid:GetChildren()) do
		if child:IsA("ImageButton") then
			child:Destroy()
		end
	end
end

local function addSlot(grid, itemKey, count, onClick)
	local def = ItemsCatalog.ITEMS[itemKey]
	if not def then return end

	local slot = itemSlotTemplate:Clone()
	slot.Name = itemKey
	slot.Icon.Image = def.icon or ""
	slot.CountLabel.Text = "x" .. tostring(count)
	slot.RarityStroke.Color = RARITY_COLORS[def.rarity] or Color3.fromRGB(150, 150, 150)
	slot.Visible = true
	slot.Parent = grid

	if onClick then
		slot.MouseButton1Click:Connect(function()
			onClick(itemKey)
		end)
	end
end

local function refreshInventoryGrid()
	clearGrid(inventoryGrid)
	local counts = {}
	for _, item in ipairs(myInventory) do
		counts[item.key] = item.count
	end
	for key, count in pairs(counts) do
		if count > 0 then
			addSlot(inventoryGrid, key, count, function(k)
				addItemEvent:FireServer(k)
			end)
		end
	end
end

local function loadMyInventory()
	local ok, result = pcall(function()
		return inventoryFn:InvokeServer()
	end)
	if ok and result then
		myInventory = result
		refreshInventoryGrid()
	end
end

local function countKeys(list)
	local counts = {}
	for _, key in ipairs(list) do
		counts[key] = (counts[key] or 0) + 1
	end
	return counts
end

local function refreshOfferGrid(grid, offerList, clickable)
	clearGrid(grid)
	local counts = countKeys(offerList or {})
	for key, count in pairs(counts) do
		addSlot(grid, key, count, clickable and function(k)
			removeItemEvent:FireServer(k)
		end or nil)
	end
end

tradeStarted.OnClientEvent:Connect(function(otherName)
	searchFrame.Visible = false
	requestPopup.Visible = false
	twTitle.Text = "Trading con: " .. otherName
	iAmReady = false
	readyButton.Text = "LISTO"
	readyButton.BackgroundColor3 = Color3.fromRGB(70, 200, 100)
	statusLabel.Text = "Agregá items y marcá LISTO cuando termines."
	tradeWindow.Visible = true
	loadMyInventory()
	clearGrid(yourOfferGrid)
	clearGrid(theirOfferGrid)
end)

tradeUpdate.OnClientEvent:Connect(function(state)
	refreshOfferGrid(yourOfferGrid, state.myOffer, true)
	refreshOfferGrid(theirOfferGrid, state.theirOffer, false)
	refreshInventoryGrid()

	iAmReady = state.myReady
	readyButton.Text = state.myReady and "ESPERANDO..." or "LISTO"
	readyButton.BackgroundColor3 = state.myReady and Color3.fromRGB(150, 150, 60) or Color3.fromRGB(70, 200, 100)

	if state.myReady and state.theirReady then
		statusLabel.Text = "¡Ambos listos! Confirmando..."
	elseif state.myReady then
		statusLabel.Text = "Esperando a " .. state.otherPlayerName .. "..."
	elseif state.theirReady then
		statusLabel.Text = state.otherPlayerName .. " ya está listo. ¡Confirmá vos!"
	else
		statusLabel.Text = "Agregá items y marcá LISTO cuando termines."
	end
end)

readyButton.MouseButton1Click:Connect(function()
	iAmReady = not iAmReady
	readyEvent:FireServer(iAmReady)
end)

local function closeTradeWindow()
	tradeWindow.Visible = false
	clearGrid(yourOfferGrid)
	clearGrid(theirOfferGrid)
	clearGrid(inventoryGrid)
end

cancelButton.MouseButton1Click:Connect(function()
	cancelEvent:FireServer()
	closeTradeWindow()
end)

twCloseButton.MouseButton1Click:Connect(function()
	cancelEvent:FireServer()
	closeTradeWindow()
end)

tradeCancelled.OnClientEvent:Connect(function(reason)
	print("[Trade] " .. tostring(reason))
	showToast(false, tostring(reason))
	closeTradeWindow()
end)

tradeCompleted.OnClientEvent:Connect(function()
	print("[Trade] ¡Trade completado con éxito!")
	showToast(true, "¡Trade completado con éxito!")
	closeTradeWindow()
end)

-- Game: brainrot-lab
-- Original: StarterPlayer/StarterPlayerScripts/TradeClient.client.lua  (669 lines)
-- What it does: Client half of the brainrot-lab trade: incoming request toasts with countdown, trade machine player list, offer slots with ViewportFrame item previews. Uses prebuilt GUIs (some names in Portuguese).

--!strict
-- LOCATION: StarterPlayer/StarterPlayerScripts/TradeClient
-- Client-side Trade System handling all three UIs

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- [ EVENTS ]
local TradeEvents = ReplicatedStorage:WaitForChild("TradeSystem", 10):WaitForChild("TradeEvents", 10)

-- [ UI REFERENCES ]
local tradeMachineGui = playerGui:WaitForChild("UI Trade machine", 10)
local notificationGui = playerGui:WaitForChild("NotificaçãodeTrade", 10)
local tradeGui = playerGui:WaitForChild("Trade", 10)

local tradeMachineFrame = tradeMachineGui and tradeMachineGui:FindFirstChild("Ui TRadeMachine", true)
local tradeMachineTrade = tradeMachineFrame and tradeMachineFrame:FindFirstChild("Trade")
local notificationFrame = notificationGui and notificationGui:FindFirstChild("Frame")
local tradeSelecao = tradeGui and tradeGui:FindFirstChild("TradeSeleção", true)
local tradingFrame = tradeSelecao and tradeSelecao:FindFirstChild("Trading")

-- [ CONSTANTS ]
local REQUEST_TIMEOUT = 15

local RARITY_TEMPLATE_MAP = {
	Common = "Common",
	Uncommon = "Uncommon",
	Rare = "Rare",
	Epic = "Epic",
	Legendary = "Legendary",
	Mythical = "Mythic",
	Secret = "Secret",
	Especial = "Stellar",
}

local ITEMS_FOLDER = ReplicatedStorage:WaitForChild("Items", 10)
local NotificationManager = require(ReplicatedStorage:WaitForChild("Modules", 10):WaitForChild("NotificationManager", 10))

-- [ STATE ]
local currentSessionPartner = nil
local activeNotifications = {} -- { [requesterName] = { template, expireTime } }
local tradeMachineOpen = false

-- [ HELPER: Setup ViewportFrame with item model ]
local function setupViewport(viewport: ViewportFrame, itemName: string, mutation: string)
	if not viewport then return end
	-- Clear existing content
	for _, child in ipairs(viewport:GetChildren()) do
		if child:IsA("Camera") or child:IsA("Model") then
			child:Destroy()
		end
	end
	local worldModel = viewport:FindFirstChildOfClass("WorldModel")
	if worldModel then
		for _, child in ipairs(worldModel:GetChildren()) do
			child:Destroy()
		end
	end

	local mutationFolder = ITEMS_FOLDER:FindFirstChild(mutation) or ITEMS_FOLDER:FindFirstChild("Normal")
	local itemFolder = mutationFolder and (mutationFolder:FindFirstChild(itemName) or ITEMS_FOLDER.Normal:FindFirstChild(itemName))
	if not itemFolder then return end

	local modelTemplate = itemFolder:FindFirstChild("Model")
	if not modelTemplate then return end

	local model = modelTemplate:Clone()
	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = true
			part.CanCollide = false
		end
	end

	-- Apply mutation texture
	local textures = itemFolder:FindFirstChild("Textures")
	local brainrot = model:FindFirstChild("Brainrot")
	local mesh = brainrot and brainrot:FindFirstChild("Mesh")
	if mesh and mesh:IsA("MeshPart") and textures then
		local tex = textures:FindFirstChild(mutation)
		if tex then
			if tex:IsA("StringValue") and tex.Value ~= "" then
				mesh.TextureID = tex.Value
			elseif tex:IsA("SurfaceAppearance") then
				for _, sa in ipairs(mesh:GetChildren()) do
					if sa:IsA("SurfaceAppearance") then sa:Destroy() end
				end
				tex:Clone().Parent = mesh
			end
		end
	end

	model.Parent = worldModel or viewport

	-- Setup camera
	local camera = Instance.new("Camera")
	camera.Parent = viewport
	viewport.CurrentCamera = camera

	local cf, size = model:GetBoundingBox()
	local maxDim = math.max(size.X, size.Y, size.Z)
	local distance = maxDim * 1.9
	camera.CFrame = CFrame.lookAt(cf.Position + Vector3.new(0, 0, distance), cf.Position)
end

-- [ HELPER: Create item card from rarity template ]
local function createItemCard(templateFolder: Folder, itemData: any, clickCallback: any?): Frame
	local rarityName = itemData.rarity or "Common"
	local templateName = RARITY_TEMPLATE_MAP[rarityName] or "Common"
	local template = templateFolder:FindFirstChild(templateName) or templateFolder:FindFirstChild("Common")
	if not template then return nil end

	local card = template:Clone()
	card.Name = itemData.name or "Item"
	card.Visible = true

	local frame = card:FindFirstChild("Frame")
	if frame then
		local title = frame:FindFirstChild("Title")
		if title and title:IsA("TextLabel") then
			title.Text = itemData.name or "Unknown"
		end
		local value = frame:FindFirstChild("Value")
		if value and value:IsA("TextLabel") then
			value.Text = "Lv. " .. tostring(itemData.level or 1)
		end
		local viewport = frame:FindFirstChild("ViewportFrame")
		if viewport and viewport:IsA("ViewportFrame") then
			setupViewport(viewport, itemData.name, itemData.mutation or "Normal")
		end
		if clickCallback and frame:IsA("ImageButton") then
			frame.MouseButton1Click:Connect(function()
				clickCallback(itemData)
			end)
		end
	end

	return card
end

-- [ HELPER: Clear scrolling frame (keep templates and structural elements) ]
local function clearScrollingFrame(sf: ScrollingFrame, keepNames: { [string]: boolean })
	for _, child in ipairs(sf:GetChildren()) do
		if not keepNames[child.Name] and child:IsA("Frame") then
			child:Destroy()
		end
	end
end

-- [ HELPER: Get player's tools ]
local function getPlayerTools(): { Tool }
	local tools = {}
	local backpack = player:FindFirstChild("Backpack")
	if backpack then
		for _, child in ipairs(backpack:GetChildren()) do
			if child:IsA("Tool") and child:GetAttribute("IsTemporary") ~= true then
				table.insert(tools, child)
			end
		end
	end
	local character = player.Character
	if character then
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("Tool") and child:GetAttribute("IsTemporary") ~= true then
				table.insert(tools, child)
			end
		end
	end
	return tools
end

-- [ HELPER: Serialize tool for display ]
local function serializeTool(tool: Tool)
	return {
		name = tool:GetAttribute("OriginalName") or tool.Name,
		mutation = tool:GetAttribute("Mutation") or "Normal",
		rarity = tool:GetAttribute("Rarity") or "Common",
		level = tool:GetAttribute("Level") or 1,
		tool = tool,
	}
end

-- ==========================================
-- TRADE MACHINE UI
-- ==========================================

local tradeMachineList = tradeMachineTrade and tradeMachineTrade:FindFirstChild("List")
local tradeMachineTemplate = tradeMachineList and tradeMachineList:FindFirstChild("Template")
-- Ensure the Template is always hidden (it's only a clone source)
if tradeMachineTemplate then tradeMachineTemplate.Visible = false end
local tradeMachineSearchBox = tradeMachineTrade and tradeMachineTrade:FindFirstChild("SearchTrade") and tradeMachineTrade.SearchTrade:FindFirstChild("Box")
local tradeMachineCloseBtn = tradeMachineTrade and tradeMachineTrade:FindFirstChild("Top") and tradeMachineTrade.Top:FindFirstChild("Main") and tradeMachineTrade.Top.Main:FindFirstChild("Close")

-- Forward declaration so populateTradeMachineList can reference it
local closeTradeMachine

local function populateTradeMachineList(searchQuery: string?)
	if not tradeMachineList or not tradeMachineTemplate then return end

	-- Clear existing entries (keep Template)
	for _, child in ipairs(tradeMachineList:GetChildren()) do
		if child.Name ~= "Template" and child.Name ~= "NoPlayersLabel" and child:IsA("Frame") then
			child:Destroy()
		elseif child.Name == "NoPlayersLabel" and child:IsA("TextLabel") then
			child:Destroy()
		end
	end

	local query = searchQuery and string.lower(searchQuery) or ""
	local foundAny = false

	for _, otherPlayer in ipairs(Players:GetPlayers()) do
		if otherPlayer ~= player then
			local name = otherPlayer.Name
			if query == "" or string.find(string.lower(name), query, 1, true) then
				foundAny = true
				local entry = tradeMachineTemplate:Clone()
				entry.Name = name
				entry.Visible = true

				local content = entry:FindFirstChild("Frame") and entry.Frame:FindFirstChild("Content")
				if content then
					local title = content:FindFirstChild("Title")
					if title and title:IsA("TextLabel") then
						title.Text = name
					end
					local subTitle = content:FindFirstChild("SubTitle")
					if subTitle and subTitle:IsA("TextLabel") then
						subTitle.Text = "Click to trade"
					end
				end

				-- Set player thumbnail
				local placeholder = entry:FindFirstChild("Frame") and entry.Frame:FindFirstChild("PlaceHolder")
				local viewport = placeholder and placeholder:FindFirstChild("ViewportFrame")
				local icon = viewport and viewport:FindFirstChild("Icon")
				if icon and icon:IsA("ImageLabel") then
					task.spawn(function()
						local ok, thumb = pcall(function()
							return Players:GetUserThumbnailAsync(otherPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
						end)
						if ok and thumb and icon.Parent then
							icon.Image = thumb
						end
					end)
				end

				-- Click handler
				local btn = entry:FindFirstChild("Frame")
				if btn and btn:IsA("ImageButton") then
					-- Disable the nested ImageButton so it doesn't intercept clicks
					local nestedBtn = btn:FindFirstChild("ImageButton")
					if nestedBtn and nestedBtn:IsA("ImageButton") then
						nestedBtn.Active = false
						nestedBtn.Interactable = false
					end
					btn.MouseButton1Click:Connect(function()
						print("[TradeClient] Click detected, sending trade request to", otherPlayer.Name)
						TradeEvents.RequestTrade:FireServer(otherPlayer)
						-- Close trade machine after sending request
						if closeTradeMachine then closeTradeMachine() end
					end)
				end

				entry.Parent = tradeMachineList
			end
		end
	end

	-- Show "No players online" message if no other players found
	if not foundAny then
		local noPlayersLabel = Instance.new("TextLabel")
		noPlayersLabel.Name = "NoPlayersLabel"
		noPlayersLabel.Text = "No players online"
		noPlayersLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
		noPlayersLabel.BackgroundTransparency = 1
		noPlayersLabel.Size = UDim2.new(1, 0, 0, 40)
		noPlayersLabel.TextScaled = true
		noPlayersLabel.Font = Enum.Font.GothamMedium
		noPlayersLabel.Parent = tradeMachineList
	end
end

local function openTradeMachine()
	if not tradeMachineGui then return end
	tradeMachineGui.Enabled = true
	if tradeMachineFrame then
		tradeMachineFrame.Visible = true
	end
	tradeMachineOpen = true
	populateTradeMachineList("")
end

closeTradeMachine = function()
	if not tradeMachineGui then return end
	tradeMachineGui.Enabled = false
	if tradeMachineFrame then
		tradeMachineFrame.Visible = false
	end
	tradeMachineOpen = false
end

-- Connect Trade Machine UI events
if tradeMachineCloseBtn and tradeMachineCloseBtn:IsA("TextButton") then
	tradeMachineCloseBtn.MouseButton1Click:Connect(closeTradeMachine)
end

if tradeMachineSearchBox and tradeMachineSearchBox:IsA("TextBox") then
	tradeMachineSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		populateTradeMachineList(tradeMachineSearchBox.Text)
	end)
end

-- Connect ProximityPrompt (StreamingEnabled-aware)
local function connectProximityPrompt()
	local tradeMachineModel = Workspace:FindFirstChild("Maquinas/Interação")
	if not tradeMachineModel then return false end
	local assets = tradeMachineModel:FindFirstChild("Assets")
	local tradeMachine = assets and assets:FindFirstChild("TradeMachine")
	local mainTrade = tradeMachine and tradeMachine:FindFirstChild("MainTrade")
	local prompt = mainTrade and mainTrade:FindFirstChild("TradeOpenPrompt")
	if prompt then
		prompt.Triggered:Connect(openTradeMachine)
		return true
	end
	return false
end

-- Try to connect immediately
local promptConnected = connectProximityPrompt()

-- If not connected yet (likely due to StreamingEnabled), retry when descendants are added
if not promptConnected then
	task.spawn(function()
		local attempts = 0
		while not promptConnected and attempts < 60 do
			task.wait(1)
			promptConnected = connectProximityPrompt()
			attempts += 1
		end
	end)
	
	-- Also listen for the model being streamed in
	Workspace.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("ProximityPrompt") and descendant.Name == "TradeOpenPrompt" then
			connectProximityPrompt()
		end
	end)
end

-- ==========================================
-- NOTIFICATION UI
-- ==========================================

local notificationTemplate = notificationFrame and notificationFrame:FindFirstChild("request_template")

local function showTradeRequest(requesterName: string, requesterUserId: number)
	if not notificationFrame or not notificationTemplate then return end

	-- Ensure the notification container is visible
	notificationFrame.Visible = true

	-- Remove existing notification from same requester
	if activeNotifications[requesterName] then
		activeNotifications[requesterName].template:Destroy()
		activeNotifications[requesterName] = nil
	end

	local notif = notificationTemplate:Clone()
	notif.Name = requesterName
	notif.Visible = true
	notif.Parent = notificationFrame

	-- Set title and subtitle
	local container = notif:FindFirstChild("Frame") and notif.Frame:FindFirstChild("Container")
	local innerContainer = container and container:FindFirstChild("Container")
	if innerContainer then
		local title = innerContainer:FindFirstChild("Title")
		if title and title:IsA("TextLabel") then
			title.Text = "Trade Request"
		end
		local subTitle = innerContainer:FindFirstChild("SubTitle")
		if subTitle and subTitle:IsA("TextLabel") then
			subTitle.Text = requesterName .. " wants to trade!"
		end
		-- Set profile icon
		local profile = innerContainer:FindFirstChild("Profile")
		local icon = profile and profile:FindFirstChild("Icon")
		if icon and icon:IsA("ImageLabel") then
			task.spawn(function()
				local ok, thumb = pcall(function()
					return Players:GetUserThumbnailAsync(requesterUserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
				end)
				if ok and thumb and icon.Parent then
					icon.Image = thumb
				end
			end)
		end
	end

	-- Setup buttons
	local buttons = notif:FindFirstChild("Buttons")
	local acceptBtn = buttons and buttons:FindFirstChild("Accept")
	local refuseBtn = buttons and buttons:FindFirstChild("Refuse")

	local requester = Players:FindFirstChild(requesterName)
	local expired = false

	local function closeNotification()
		if expired then return end
		expired = true
		notif:Destroy()
		activeNotifications[requesterName] = nil
	end

	if acceptBtn then
		local btnFrame = acceptBtn:FindFirstChild("Frame")
		if btnFrame and btnFrame:IsA("ImageButton") then
			btnFrame.MouseButton1Click:Connect(function()
				if requester then
					TradeEvents.RespondTradeRequest:FireServer(requester, true)
				end
				closeNotification()
			end)
		end
	end

	if refuseBtn then
		local btnFrame = refuseBtn:FindFirstChild("Frame")
		if btnFrame and btnFrame:IsA("ImageButton") then
			btnFrame.MouseButton1Click:Connect(function()
				if requester then
					TradeEvents.RespondTradeRequest:FireServer(requester, false)
				end
				closeNotification()
			end)
		end
	end

	-- Countdown timer
	local bar = innerContainer and innerContainer:FindFirstChild("Bar")
	local slider = bar and bar:FindFirstChild("Slider")

	activeNotifications[requesterName] = { template = notif, expireTime = os.clock() + REQUEST_TIMEOUT }

	task.spawn(function()
		local startTime = os.clock()
		while not expired and os.clock() - startTime < REQUEST_TIMEOUT do
			local progress = 1 - (os.clock() - startTime) / REQUEST_TIMEOUT
			if slider and slider:IsA("Frame") then
				slider.Size = UDim2.new(progress, 0, 1, 0)
			end
			task.wait(0.05)
		end
		if not expired then
			closeNotification()
		end
	end)
end

-- ==========================================
-- MAIN TRADE UI
-- ==========================================

local leftFrame = tradingFrame and tradingFrame:FindFirstChild("Frame") and tradingFrame.Frame:FindFirstChild("Left")
local rightFrame = tradingFrame and tradingFrame:FindFirstChild("Frame") and tradingFrame.Frame:FindFirstChild("Right")
local buttonsFrame = tradingFrame and tradingFrame:FindFirstChild("Buttons")

local leftPlayer = leftFrame and leftFrame:FindFirstChild("Player")
local leftHolder = leftFrame and leftFrame:FindFirstChild("Holder")
local leftAccepted = leftHolder and leftHolder:FindFirstChild("Accepted")
local leftAcceptedTitle = leftAccepted and leftAccepted:FindFirstChild("Title")
local leftOffer = leftHolder and leftHolder:FindFirstChild("Offer")
local leftInventory = leftHolder and leftHolder:FindFirstChild("Inventory")
local leftInventoryTemplates = leftInventory and leftInventory:FindFirstChild("Templates")

local rightPlayer = rightFrame and rightFrame:FindFirstChild("Player")
local rightHolder = rightFrame and rightFrame:FindFirstChild("Holder")
local rightAccepted = rightHolder and rightHolder:FindFirstChild("Accepted")
local rightAcceptedTitle = rightAccepted and rightAccepted:FindFirstChild("Title")
local rightOffer = rightHolder and rightHolder:FindFirstChild("Offer")

local acceptBtn = buttonsFrame and buttonsFrame:FindFirstChild("Accept")
local declineBtn = buttonsFrame and buttonsFrame:FindFirstChild("Decline")
local cancelBtn = buttonsFrame and buttonsFrame:FindFirstChild("Cancel")
local processingBtn = buttonsFrame and buttonsFrame:FindFirstChild("Processing")

local function setAcceptedIndicator(titleLabel: TextLabel?, accepted: boolean)
	if not titleLabel then return end
	if accepted then
		titleLabel.Text = "✓ ACCEPTED"
		titleLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
	else
		titleLabel.Text = "WAITING..."
		titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	end
end

local function updateTradeUI(state: any)
	if not tradingFrame then return end

	-- Set player names
	if leftPlayer then
		local title = leftPlayer:FindFirstChild("Title")
		if title and title:IsA("TextLabel") then
			title.Text = player.Name
		end
	end
	if rightPlayer then
		local title = rightPlayer:FindFirstChild("Title")
		if title and title:IsA("TextLabel") then
			title.Text = state.partnerName or "Player"
		end
	end

	-- Update accepted indicators
	setAcceptedIndicator(leftAcceptedTitle, state.myAccepted or false)
	setAcceptedIndicator(rightAcceptedTitle, state.partnerAccepted or false)

	-- Update my offer (left side)
	if leftOffer then
		clearScrollingFrame(leftOffer, { ["Add"] = true, ["UIGridLayout"] = true, ["UIAspectRatioConstraint"] = true })
		for _, itemData in ipairs(state.myOffer or {}) do
			local card = createItemCard(leftInventoryTemplates, itemData, function(data)
				if data.tool then
					TradeEvents.RemoveItem:FireServer(data.tool)
				end
			end)
			if card then
				card.Parent = leftOffer
			end
		end
	end

	-- Update inventory (left side) - show tools not in trade
	if leftInventory then
		clearScrollingFrame(leftInventory, { ["Return"] = true, ["Templates"] = true, ["UIGridLayout"] = true, ["UIAspectRatioConstraint"] = true })
		local offeredTools = {}
		for _, itemData in ipairs(state.myOffer or {}) do
			if itemData.tool then
				offeredTools[itemData.tool] = true
			end
		end
		for _, tool in ipairs(getPlayerTools()) do
			if not offeredTools[tool] and tool:GetAttribute("InTrade") ~= true then
				local itemData = serializeTool(tool)
				local card = createItemCard(leftInventoryTemplates, itemData, function(data)
					if data.tool then
						TradeEvents.AddItem:FireServer(data.tool)
					end
				end)
				if card then
					card.Parent = leftInventory
				end
				end
			end
	end

	-- Update partner's offer (right side)
	if rightOffer then
		clearScrollingFrame(rightOffer, { ["UIGridLayout"] = true, ["UIAspectRatioConstraint"] = true })
		for _, itemData in ipairs(state.partnerOffer or {}) do
			local card = createItemCard(leftInventoryTemplates, itemData, nil)
			if card then
				card.Parent = rightOffer
			end
		end
	end
end

local function openTradeUI()
	if not tradeGui then return end
	tradeGui.Enabled = true
	if tradeSelecao then
		tradeSelecao.Visible = true
	end
	if tradingFrame then
		tradingFrame.Visible = true
	end
end

local function closeTradeUI()
	if not tradeGui then return end
	tradeGui.Enabled = false
	if tradeSelecao then
		tradeSelecao.Visible = false
	end
	currentSessionPartner = nil
end

-- Connect trade buttons
if acceptBtn and acceptBtn:IsA("TextButton") then
	acceptBtn.MouseButton1Click:Connect(function()
		TradeEvents.AcceptTrade:FireServer()
	end)
end

if declineBtn and declineBtn:IsA("TextButton") then
	declineBtn.MouseButton1Click:Connect(function()
		TradeEvents.CancelTrade:FireServer()
	end)
end

if cancelBtn and cancelBtn:IsA("TextButton") then
	cancelBtn.MouseButton1Click:Connect(function()
		TradeEvents.CancelTrade:FireServer()
	end)
end

-- Show/hide processing button
local function setProcessingState(isProcessing: boolean)
	if processingBtn then processingBtn.Visible = isProcessing end
	if acceptBtn then acceptBtn.Visible = not isProcessing end
	if declineBtn then declineBtn.Visible = not isProcessing end
	if cancelBtn then cancelBtn.Visible = not isProcessing end
end

-- ==========================================
-- SERVER EVENT CONNECTIONS
-- ==========================================

TradeEvents.TradeRequestReceived.OnClientEvent:Connect(function(requesterName: string, requesterUserId: number)
	showTradeRequest(requesterName, requesterUserId)
end)

TradeEvents.TradeRequestResult.OnClientEvent:Connect(function(accepted: boolean, partnerName: string)
	if accepted then
		currentSessionPartner = partnerName
		openTradeUI()
	else
		-- Show a notification that the trade was declined/failed
		NotificationManager.show(partnerName, "Warning")
	end
end)

TradeEvents.UpdateTradeState.OnClientEvent:Connect(function(state: any)
	updateTradeUI(state)
end)

TradeEvents.TradeComplete.OnClientEvent:Connect(function()
	closeTradeUI()
	NotificationManager.show("Trade completed successfully!", "Success")
end)

TradeEvents.TradeCancelled.OnClientEvent:Connect(function(reason: string)
	closeTradeUI()
	NotificationManager.show(reason or "Trade cancelled", "Warning")
end)

-- ==========================================
-- INITIALIZATION
-- ==========================================

-- Make sure all UIs start hidden
if tradeMachineGui then tradeMachineGui.Enabled = false end
if tradeMachineFrame then tradeMachineFrame.Visible = false end
if tradeGui then tradeGui.Enabled = false end
if tradeSelecao then tradeSelecao.Visible = false end
-- The notification Frame is a transparent container (BackgroundTransparency = 1)
-- It must be Visible = true so cloned notification templates can appear on screen
if notificationFrame then notificationFrame.Visible = true end
-- Hide notification template so it doesn't show as a placeholder
if notificationTemplate then notificationTemplate.Visible = false end

print("[TradeClient] Loaded")

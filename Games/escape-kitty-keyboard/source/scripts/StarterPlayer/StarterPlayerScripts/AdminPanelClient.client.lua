-- ============================================
-- ADMIN PANEL CLIENT - COMPLET (Dark + Onglets)
-- À placer dans StarterPlayer > StarterPlayerScripts
-- ============================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local CmdrClient = require(ReplicatedStorage:WaitForChild("CmdrClient"))

local checkAdminRemote = ReplicatedStorage:WaitForChild("CheckAdminAccess")
local getPlayersRemote = ReplicatedStorage:WaitForChild("GetServerPlayers")
local moderationRemote = ReplicatedStorage:WaitForChild("AdminModerationAction")
local trollRemote = ReplicatedStorage:WaitForChild("AdminTrollAction")
local announceEffectRemote = ReplicatedStorage:WaitForChild("AnnounceEffect")

local isAdmin = checkAdminRemote:InvokeServer()
if not isAdmin then return end

-- ============================
-- THEME FULL BLACK
-- ============================
local COLORS = {
	background = Color3.fromRGB(10, 10, 12),
	panel = Color3.fromRGB(16, 16, 19),
	sidebar = Color3.fromRGB(6, 6, 8),
	card = Color3.fromRGB(18, 18, 22),
	accent = Color3.fromRGB(120, 90, 255),
	accentHover = Color3.fromRGB(140, 110, 255),
	tabActive = Color3.fromRGB(26, 26, 32),
	text = Color3.fromRGB(240, 240, 245),
	textDim = Color3.fromRGB(120, 120, 130),
	inputBg = Color3.fromRGB(24, 24, 28),
	success = Color3.fromRGB(80, 200, 120),
	danger = Color3.fromRGB(230, 70, 70),
	warning = Color3.fromRGB(240, 180, 60),
}

-- ============================
-- COMMANDES CMDR PAR ONGLET
-- ============================
local cmdrTabs = {
	{
		name = "General", icon = "📢",
		commands = {
			{ name = "announce", label = "📢 Announce", desc = "Annonce à tout le serveur",
				args = { { name = "message", type = "string", placeholder = "Message" } } },
		},
	},
	{
		name = "Joueurs", icon = "👤",
		commands = {
			{ name = "givewins", label = "🏆 Give Wins", desc = "Donner des wins",
				args = { { name = "target", type = "player", placeholder = "Joueur" }, { name = "amount", type = "number", placeholder = "Montant" } } },
			{ name = "givexp", label = "⭐ Give XP", desc = "Donner de l'XP",
				args = { { name = "target", type = "player", placeholder = "Joueur" }, { name = "amount", type = "number", placeholder = "Montant" } } },
			{ name = "setlevel", label = "📊 Set Level", desc = "Définir le niveau",
				args = { { name = "target", type = "player", placeholder = "Joueur" }, { name = "level", type = "number", placeholder = "Niveau" } } },
			{ name = "setrebirths", label = "🔄 Set Rebirths", desc = "Définir les rebirths",
				args = { { name = "target", type = "player", placeholder = "Joueur" }, { name = "count", type = "number", placeholder = "Nombre" } } },
		},
	},
	{
		name = "Cosmetiques", icon = "✨",
		commands = {
			{ name = "settrail", label = "✨ Set Trail", desc = "Donner un trail",
				args = { { name = "target", type = "player", placeholder = "Joueur" }, { name = "trailName", type = "string", placeholder = "Nom du trail" }, { name = "equip", type = "boolean", placeholder = "true/false", optional = true } } },
			{ name = "settreadmill", label = "🏃 Set Treadmill", desc = "Accès tapis",
				args = { { name = "target", type = "player", placeholder = "Joueur" }, { name = "treadmillType", type = "string", placeholder = "gold/diamond/candy/admin/remove" } } },
		},
	},
	{
		name = "Boosts", icon = "🚀",
		commands = {
			{ name = "startwins", label = "▶️ Start Wins", desc = "Active le multiplicateur de wins",
				args = { { name = "multiplier", type = "number", placeholder = "x2, x3..." }, { name = "duration", type = "number", placeholder = "Secondes (0=permanent)", optional = true } } },
			{ name = "stopwins", label = "⏹️ Stop Wins", desc = "Désactive le multiplicateur", args = {} },
			{ name = "startxp", label = "▶️ Start XP", desc = "Active le multiplicateur d'XP",
				args = { { name = "multiplier", type = "number", placeholder = "x2, x3..." }, { name = "duration", type = "number", placeholder = "Secondes (0=permanent)", optional = true } } },
			{ name = "stopxp", label = "⏹️ Stop XP", desc = "Désactive le multiplicateur", args = {} },
		},
	},
}

-- ============================
-- SCREENGUI
-- ============================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdminPanel"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 48, 0, 48)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.BackgroundColor3 = COLORS.accent
toggleButton.Text = "⚙️"
toggleButton.TextSize = 20
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextColor3 = COLORS.text
toggleButton.BorderSizePixel = 0
toggleButton.AutoButtonColor = false
toggleButton.Parent = screenGui
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 680, 0, 500)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = COLORS.background
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(35, 35, 40)
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

-- Sidebar (onglets)
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 150, 1, 0)
sidebar.BackgroundColor3 = COLORS.sidebar
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 14)

local sidebarFix = Instance.new("Frame")
sidebarFix.Size = UDim2.new(0, 14, 1, 0)
sidebarFix.Position = UDim2.new(1, -14, 0, 0)
sidebarFix.BackgroundColor3 = COLORS.sidebar
sidebarFix.BorderSizePixel = 0
sidebarFix.ZIndex = 0
sidebarFix.Parent = sidebar

local sidebarTitle = Instance.new("TextLabel")
sidebarTitle.Size = UDim2.new(1, -20, 0, 40)
sidebarTitle.Position = UDim2.new(0, 14, 0, 12)
sidebarTitle.BackgroundTransparency = 1
sidebarTitle.Text = "ADMIN"
sidebarTitle.Font = Enum.Font.GothamBlack
sidebarTitle.TextSize = 16
sidebarTitle.TextColor3 = COLORS.accent
sidebarTitle.TextXAlignment = Enum.TextXAlignment.Left
sidebarTitle.Parent = sidebar

local tabButtonsHolder = Instance.new("Frame")
tabButtonsHolder.Size = UDim2.new(1, -20, 1, -70)
tabButtonsHolder.Position = UDim2.new(0, 10, 0, 55)
tabButtonsHolder.BackgroundTransparency = 1
tabButtonsHolder.Parent = sidebar

local tabButtonsLayout = Instance.new("UIListLayout")
tabButtonsLayout.Padding = UDim.new(0, 4)
tabButtonsLayout.Parent = tabButtonsHolder

-- Zone de contenu
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -160, 1, -20)
contentArea.Position = UDim2.new(0, 160, 0, 10)
contentArea.BackgroundTransparency = 1
contentArea.Parent = mainFrame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 28, 0, 28)
closeButton.Position = UDim2.new(1, -34, 0, 0)
closeButton.BackgroundColor3 = COLORS.inputBg
closeButton.Text = "✕"
closeButton.TextColor3 = COLORS.textDim
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 12
closeButton.BorderSizePixel = 0
closeButton.AutoButtonColor = false
closeButton.ZIndex = 5
closeButton.Parent = mainFrame
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 8)

-- Status
local statusLabel = Instance.new("TextLabel")
statusLabel.AnchorPoint = Vector2.new(0.5, 0)
statusLabel.Size = UDim2.new(0, 400, 0, 44)
statusLabel.Position = UDim2.new(0.5, 0, 1, -70)
statusLabel.BackgroundColor3 = COLORS.panel
statusLabel.TextColor3 = COLORS.text
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextSize = 13
statusLabel.Text = ""
statusLabel.Visible = false
statusLabel.TextWrapped = true
statusLabel.ZIndex = 10
statusLabel.Parent = screenGui
Instance.new("UICorner", statusLabel).CornerRadius = UDim.new(0, 8)

local function showStatus(message, kind)
	local color = COLORS.success
	if kind == "error" then color = COLORS.danger
	elseif kind == "warning" then color = COLORS.warning end

	statusLabel.Text = message
	statusLabel.BackgroundColor3 = color
	statusLabel.Visible = true
	task.delay(3, function()
		statusLabel.Visible = false
	end)
end

-- ============================
-- ANTI DOUBLE-CLIC (protection client, par bouton)
-- ============================
local function debounceButton(button, callback)
	local processing = false
	button.MouseButton1Click:Connect(function()
		if processing then return end
		processing = true
		button.AutoButtonColor = false
		local originalColor = button.BackgroundColor3
		button.BackgroundColor3 = COLORS.textDim

		local ok, err = pcall(callback)
		if not ok then
			warn("Erreur bouton : " .. tostring(err))
		end

		task.wait(0.6)
		button.BackgroundColor3 = originalColor
		processing = false
	end)
end

-- ============================
-- EXECUTION D'UNE COMMANDE CMDR
-- ============================
local function executeCommand(cmd, inputValues)
	local parts = { cmd.name }
	for _, argDef in ipairs(cmd.args) do
		local value = inputValues[argDef.name]
		if (value == nil or value == "") and not argDef.optional then
			showStatus("⚠️ Champ requis : " .. argDef.name, "warning")
			return
		end
		if value ~= nil and value ~= "" then
			table.insert(parts, tostring(value))
		end
	end

	local commandString = table.concat(parts, " ")
	local success, result = pcall(function()
		return CmdrClient:Run(commandString)
	end)

	if success then
		showStatus("✅ Exécuté : /" .. commandString, "success")
	else
		showStatus("❌ Erreur : " .. tostring(result), "error")
	end
end

-- ============================
-- CARTE DE COMMANDE
-- ============================
local function createCommandCard(cmd, parent, layoutOrder)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, 0)
	card.AutomaticSize = Enum.AutomaticSize.Y
	card.BackgroundColor3 = COLORS.card
	card.BorderSizePixel = 0
	card.LayoutOrder = layoutOrder
	card.Parent = parent
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)

	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0, 10)
	padding.PaddingBottom = UDim.new(0, 10)
	padding.PaddingLeft = UDim.new(0, 12)
	padding.PaddingRight = UDim.new(0, 12)
	padding.Parent = card

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 6)
	layout.Parent = card

	local cardTitle = Instance.new("TextLabel")
	cardTitle.Size = UDim2.new(1, 0, 0, 18)
	cardTitle.BackgroundTransparency = 1
	cardTitle.Text = cmd.label
	cardTitle.Font = Enum.Font.GothamBold
	cardTitle.TextSize = 14
	cardTitle.TextColor3 = COLORS.text
	cardTitle.TextXAlignment = Enum.TextXAlignment.Left
	cardTitle.LayoutOrder = 1
	cardTitle.Parent = card

	local cardDesc = Instance.new("TextLabel")
	cardDesc.Size = UDim2.new(1, 0, 0, 14)
	cardDesc.BackgroundTransparency = 1
	cardDesc.Text = cmd.desc
	cardDesc.Font = Enum.Font.Gotham
	cardDesc.TextSize = 11
	cardDesc.TextColor3 = COLORS.textDim
	cardDesc.TextXAlignment = Enum.TextXAlignment.Left
	cardDesc.LayoutOrder = 2
	cardDesc.Parent = card

	local inputValues = {}
	for i, argDef in ipairs(cmd.args) do
		local inputBox = Instance.new("TextBox")
		inputBox.Size = UDim2.new(1, 0, 0, 28)
		inputBox.BackgroundColor3 = COLORS.inputBg
		inputBox.PlaceholderText = argDef.placeholder .. (argDef.optional and " (optionnel)" or "")
		inputBox.Text = ""
		inputBox.TextColor3 = COLORS.text
		inputBox.PlaceholderColor3 = COLORS.textDim
		inputBox.Font = Enum.Font.Gotham
		inputBox.TextSize = 12
		inputBox.ClearTextOnFocus = false
		inputBox.BorderSizePixel = 0
		inputBox.LayoutOrder = 2 + i
		inputBox.Parent = card
		Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 6)
		local pad = Instance.new("UIPadding")
		pad.PaddingLeft = UDim.new(0, 8)
		pad.Parent = inputBox

		inputBox:GetPropertyChangedSignal("Text"):Connect(function()
			inputValues[argDef.name] = inputBox.Text
		end)
	end

	local execButton = Instance.new("TextButton")
	execButton.Size = UDim2.new(1, 0, 0, 30)
	execButton.BackgroundColor3 = COLORS.accent
	execButton.Text = "Exécuter"
	execButton.Font = Enum.Font.GothamBold
	execButton.TextSize = 12
	execButton.TextColor3 = COLORS.text
	execButton.BorderSizePixel = 0
	execButton.LayoutOrder = 3 + #cmd.args
	execButton.Parent = card
	Instance.new("UICorner", execButton).CornerRadius = UDim.new(0, 6)

	debounceButton(execButton, function()
		executeCommand(cmd, inputValues)
	end)

	return card
end

-- ============================
-- FONCTION PARTAGEE : LISTE DE JOUEURS (utilisée par Moderation ET Troll)
-- ============================
local function createPlayerListFrame(parent, onSelect)
	local playerListFrame = Instance.new("ScrollingFrame")
	playerListFrame.Size = UDim2.new(0, 180, 1, 0)
	playerListFrame.BackgroundColor3 = COLORS.card
	playerListFrame.BorderSizePixel = 0
	playerListFrame.ScrollBarThickness = 4
	playerListFrame.ScrollBarImageColor3 = COLORS.accent
	playerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	playerListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	playerListFrame.Parent = parent
	Instance.new("UICorner", playerListFrame).CornerRadius = UDim.new(0, 10)

	local plPadding = Instance.new("UIPadding")
	plPadding.PaddingTop = UDim.new(0, 8)
	plPadding.PaddingLeft = UDim.new(0, 8)
	plPadding.PaddingRight = UDim.new(0, 8)
	plPadding.Parent = playerListFrame

	local plLayout = Instance.new("UIListLayout")
	plLayout.Padding = UDim.new(0, 6)
	plLayout.Parent = playerListFrame

	local function refreshPlayerList()
		for _, child in pairs(playerListFrame:GetChildren()) do
			if child:IsA("TextButton") then child:Destroy() end
		end
		local success, list = pcall(function()
			return getPlayersRemote:InvokeServer()
		end)
		if not success or not list then return end

		for i, entry in ipairs(list) do
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, 0, 0, 34)
			btn.BackgroundColor3 = COLORS.inputBg
			btn.Text = "👤 " .. entry.name
			btn.Font = Enum.Font.Gotham
			btn.TextSize = 12
			btn.TextColor3 = COLORS.text
			btn.BorderSizePixel = 0
			btn.AutoButtonColor = false
			btn.LayoutOrder = i
			btn.Parent = playerListFrame
			Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

			btn.MouseButton1Click:Connect(function()
				onSelect(entry)
				for _, other in pairs(playerListFrame:GetChildren()) do
					if other:IsA("TextButton") then
						other.BackgroundColor3 = COLORS.inputBg
					end
				end
				btn.BackgroundColor3 = COLORS.accent
			end)
		end
	end

	refreshPlayerList()

	local refreshBtn = Instance.new("TextButton")
	refreshBtn.Size = UDim2.new(1, 0, 0, 26)
	refreshBtn.Position = UDim2.new(0, 0, 1, -30)
	refreshBtn.BackgroundColor3 = COLORS.accent
	refreshBtn.Text = "🔄 Rafraîchir"
	refreshBtn.Font = Enum.Font.GothamBold
	refreshBtn.TextSize = 11
	refreshBtn.TextColor3 = COLORS.text
	refreshBtn.BorderSizePixel = 0
	refreshBtn.Parent = parent
	Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0, 6)
	debounceButton(refreshBtn, refreshPlayerList)

	return playerListFrame
end

-- ============================
-- ONGLET : MODERATION
-- ============================
local function createModerationTab(parent)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 1, 0)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local selectedTarget = nil

	local actionsFrame = Instance.new("Frame")
	actionsFrame.Size = UDim2.new(1, -192, 1, 0)
	actionsFrame.Position = UDim2.new(0, 192, 0, 0)
	actionsFrame.BackgroundColor3 = COLORS.card
	actionsFrame.BorderSizePixel = 0
	actionsFrame.Parent = container
	Instance.new("UICorner", actionsFrame).CornerRadius = UDim.new(0, 10)

	local actionsPadding = Instance.new("UIPadding")
	actionsPadding.PaddingTop = UDim.new(0, 16)
	actionsPadding.PaddingLeft = UDim.new(0, 16)
	actionsPadding.PaddingRight = UDim.new(0, 16)
	actionsPadding.Parent = actionsFrame

	local selectedLabel = Instance.new("TextLabel")
	selectedLabel.Size = UDim2.new(1, 0, 0, 30)
	selectedLabel.BackgroundTransparency = 1
	selectedLabel.Text = "Aucun joueur sélectionné"
	selectedLabel.Font = Enum.Font.GothamBold
	selectedLabel.TextSize = 16
	selectedLabel.TextColor3 = COLORS.text
	selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
	selectedLabel.Parent = actionsFrame

	local reasonBox = Instance.new("TextBox")
	reasonBox.Size = UDim2.new(1, 0, 0, 32)
	reasonBox.Position = UDim2.new(0, 0, 0, 40)
	reasonBox.BackgroundColor3 = COLORS.inputBg
	reasonBox.PlaceholderText = "Raison (optionnel)"
	reasonBox.Text = ""
	reasonBox.TextColor3 = COLORS.text
	reasonBox.PlaceholderColor3 = COLORS.textDim
	reasonBox.Font = Enum.Font.Gotham
	reasonBox.TextSize = 12
	reasonBox.ClearTextOnFocus = false
	reasonBox.BorderSizePixel = 0
	reasonBox.Parent = actionsFrame
	Instance.new("UICorner", reasonBox).CornerRadius = UDim.new(0, 6)
	local reasonPad = Instance.new("UIPadding")
	reasonPad.PaddingLeft = UDim.new(0, 8)
	reasonPad.Parent = reasonBox

	local buttonsHolder = Instance.new("Frame")
	buttonsHolder.Size = UDim2.new(1, 0, 0, 100)
	buttonsHolder.Position = UDim2.new(0, 0, 0, 84)
	buttonsHolder.BackgroundTransparency = 1
	buttonsHolder.Parent = actionsFrame

	local btnLayout = Instance.new("UIGridLayout")
	btnLayout.CellSize = UDim2.new(0.5, -6, 0, 44)
	btnLayout.CellPadding = UDim2.new(0, 12, 0, 12)
	btnLayout.Parent = buttonsHolder

	local function callModeration(action)
		if not selectedTarget then
			showStatus("⚠️ Sélectionne d'abord un joueur.", "warning")
			return
		end
		local reason = reasonBox.Text
		local success, ok, msg = pcall(function()
			return moderationRemote:InvokeServer(action, selectedTarget.userId, reason)
		end)
		if success then
			showStatus(msg, ok and "success" or "error")
		else
			showStatus("❌ Erreur communication serveur.", "error")
		end
	end

	local function makeActionButton(text, color, action)
		local btn = Instance.new("TextButton")
		btn.BackgroundColor3 = color
		btn.Text = text
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 13
		btn.TextColor3 = COLORS.text
		btn.BorderSizePixel = 0
		btn.Parent = buttonsHolder
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
		debounceButton(btn, function() callModeration(action) end)
	end

	makeActionButton("👢 Kick", COLORS.warning, "kick")
	makeActionButton("🔨 Ban", COLORS.danger, "ban")
	makeActionButton("❄️ Freeze", COLORS.accent, "freeze")
	makeActionButton("🔥 Unfreeze", COLORS.success, "unfreeze")

	local unbanLabel = Instance.new("TextLabel")
	unbanLabel.Size = UDim2.new(1, 0, 0, 20)
	unbanLabel.Position = UDim2.new(0, 0, 0, 196)
	unbanLabel.BackgroundTransparency = 1
	unbanLabel.Text = "Débannir par UserId :"
	unbanLabel.Font = Enum.Font.GothamBold
	unbanLabel.TextSize = 12
	unbanLabel.TextColor3 = COLORS.textDim
	unbanLabel.TextXAlignment = Enum.TextXAlignment.Left
	unbanLabel.Parent = actionsFrame

	local unbanBox = Instance.new("TextBox")
	unbanBox.Size = UDim2.new(0.6, -6, 0, 32)
	unbanBox.Position = UDim2.new(0, 0, 0, 220)
	unbanBox.BackgroundColor3 = COLORS.inputBg
	unbanBox.PlaceholderText = "UserId"
	unbanBox.Text = ""
	unbanBox.TextColor3 = COLORS.text
	unbanBox.PlaceholderColor3 = COLORS.textDim
	unbanBox.Font = Enum.Font.Gotham
	unbanBox.TextSize = 12
	unbanBox.ClearTextOnFocus = false
	unbanBox.BorderSizePixel = 0
	unbanBox.Parent = actionsFrame
	Instance.new("UICorner", unbanBox).CornerRadius = UDim.new(0, 6)

	local unbanBtn = Instance.new("TextButton")
	unbanBtn.Size = UDim2.new(0.4, -6, 0, 32)
	unbanBtn.Position = UDim2.new(0.6, 6, 0, 220)
	unbanBtn.BackgroundColor3 = COLORS.success
	unbanBtn.Text = "Unban"
	unbanBtn.Font = Enum.Font.GothamBold
	unbanBtn.TextSize = 12
	unbanBtn.TextColor3 = COLORS.text
	unbanBtn.BorderSizePixel = 0
	unbanBtn.Parent = actionsFrame
	Instance.new("UICorner", unbanBtn).CornerRadius = UDim.new(0, 6)

	debounceButton(unbanBtn, function()
		local userId = tonumber(unbanBox.Text)
		if not userId then
			showStatus("⚠️ UserId invalide.", "warning")
			return
		end
		local success, ok, msg = pcall(function()
			return moderationRemote:InvokeServer("unban", userId, "")
		end)
		if success then
			showStatus(msg, ok and "success" or "error")
		end
	end)

	createPlayerListFrame(container, function(entry)
		selectedTarget = { name = entry.name, userId = entry.userId }
		selectedLabel.Text = "🎯 " .. entry.name
	end)

	return container
end

-- ============================
-- ONGLET : TROLL
-- ============================
local function createTrollTab(parent)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 1, 0)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local trollSelectedTarget = nil

	local actionsScroll = Instance.new("ScrollingFrame")
	actionsScroll.Size = UDim2.new(1, -192, 1, 0)
	actionsScroll.Position = UDim2.new(0, 192, 0, 0)
	actionsScroll.BackgroundColor3 = COLORS.card
	actionsScroll.BorderSizePixel = 0
	actionsScroll.ScrollBarThickness = 4
	actionsScroll.ScrollBarImageColor3 = COLORS.accent
	actionsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	actionsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	actionsScroll.Parent = container
	Instance.new("UICorner", actionsScroll).CornerRadius = UDim.new(0, 10)

	local actionsPad = Instance.new("UIPadding")
	actionsPad.PaddingTop = UDim.new(0, 16)
	actionsPad.PaddingLeft = UDim.new(0, 16)
	actionsPad.PaddingRight = UDim.new(0, 16)
	actionsPad.PaddingBottom = UDim.new(0, 16)
	actionsPad.Parent = actionsScroll

	local actionsLayout = Instance.new("UIListLayout")
	actionsLayout.Padding = UDim.new(0, 10)
	actionsLayout.Parent = actionsScroll

	local selectedLabel = Instance.new("TextLabel")
	selectedLabel.Size = UDim2.new(1, 0, 0, 30)
	selectedLabel.BackgroundTransparency = 1
	selectedLabel.Text = "Aucun joueur sélectionné"
	selectedLabel.Font = Enum.Font.GothamBold
	selectedLabel.TextSize = 16
	selectedLabel.TextColor3 = COLORS.text
	selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
	selectedLabel.LayoutOrder = 1
	selectedLabel.Parent = actionsScroll

	local btnHolder = Instance.new("Frame")
	btnHolder.Size = UDim2.new(1, 0, 0, 340)
	btnHolder.BackgroundTransparency = 1
	btnHolder.LayoutOrder = 2
	btnHolder.Parent = actionsScroll

	local btnGrid = Instance.new("UIGridLayout")
	btnGrid.CellSize = UDim2.new(0.5, -6, 0, 42)
	btnGrid.CellPadding = UDim2.new(0, 12, 0, 10)
	btnGrid.Parent = btnHolder

	local function callTroll(action)
		if not trollSelectedTarget then
			showStatus("⚠️ Sélectionne d'abord un joueur.", "warning")
			return
		end
		local success, ok, msg = pcall(function()
			return trollRemote:InvokeServer(action, trollSelectedTarget.userId)
		end)
		if success then
			showStatus(msg, ok and "success" or "error")
		else
			showStatus("❌ Erreur communication.", "error")
		end
	end

	local function makeTrollButton(text, color, action)
		local btn = Instance.new("TextButton")
		btn.BackgroundColor3 = color
		btn.Text = text
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 12
		btn.TextColor3 = COLORS.text
		btn.BorderSizePixel = 0
		btn.Parent = btnHolder
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
		debounceButton(btn, function() callTroll(action) end)
	end

	makeTrollButton("👁️ Spectate", COLORS.accent, "spectate")
	makeTrollButton("👁️ Unspectate", COLORS.textDim, "unspectate")
	makeTrollButton("🦴 Ragdoll", COLORS.danger, "ragdoll")
	makeTrollButton("🦴 Unragdoll", COLORS.success, "unragdoll")
	makeTrollButton("💀 Kill", COLORS.danger, "kill")
	makeTrollButton("👻 Invisible", COLORS.accent, "invisible")
	makeTrollButton("👤 Visible", COLORS.success, "visible")
	makeTrollButton("🗿 Giant", COLORS.warning, "giant")
	makeTrollButton("🐜 Tiny", COLORS.warning, "tiny")
	makeTrollButton("↩️ Taille normale", COLORS.textDim, "normalsize")
	makeTrollButton("🌀 Spin", COLORS.accent, "spin")
	makeTrollButton("🌀 Unspin", COLORS.textDim, "unspin")
	makeTrollButton("🎈 Low Gravity", COLORS.accent, "lowgravity")
	makeTrollButton("↩️ Gravité normale", COLORS.textDim, "normalgravity")
	makeTrollButton("🌈 Rainbow", COLORS.accent, "rainbow")
	makeTrollButton("↩️ Unrainbow", COLORS.textDim, "unrainbow")

	createPlayerListFrame(container, function(entry)
		trollSelectedTarget = { name = entry.name, userId = entry.userId }
		selectedLabel.Text = "🎯 " .. entry.name
	end)

	return container
end

-- ============================
-- CONSTRUCTION DES ONGLETS
-- ============================
local allTabsData = {}
for _, t in ipairs(cmdrTabs) do table.insert(allTabsData, t) end
table.insert(allTabsData, { name = "Moderation", icon = "🛡️", isModeration = true })
table.insert(allTabsData, { name = "Troll", icon = "🃏", isTroll = true })

local tabContents = {}
local tabButtons = {}

local function selectTab(tabName)
	for name, content in pairs(tabContents) do
		content.Visible = (name == tabName)
	end
	for name, btn in pairs(tabButtons) do
		btn.BackgroundColor3 = (name == tabName) and COLORS.tabActive or COLORS.sidebar
	end
end

for i, tabData in ipairs(allTabsData) do
	local tabBtn = Instance.new("TextButton")
	tabBtn.Size = UDim2.new(1, 0, 0, 36)
	tabBtn.BackgroundColor3 = COLORS.sidebar
	tabBtn.Text = tabData.icon .. "  " .. tabData.name
	tabBtn.Font = Enum.Font.Gotham
	tabBtn.TextSize = 13
	tabBtn.TextColor3 = COLORS.text
	tabBtn.TextXAlignment = Enum.TextXAlignment.Left
	tabBtn.BorderSizePixel = 0
	tabBtn.AutoButtonColor = false
	tabBtn.LayoutOrder = i
	tabBtn.Parent = tabButtonsHolder
	Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 8)
	local tabBtnPad = Instance.new("UIPadding")
	tabBtnPad.PaddingLeft = UDim.new(0, 10)
	tabBtnPad.Parent = tabBtn

	tabButtons[tabData.name] = tabBtn
	tabBtn.MouseButton1Click:Connect(function()
		selectTab(tabData.name)
	end)

	if tabData.isModeration then
		local modContent = Instance.new("Frame")
		modContent.Size = UDim2.new(1, 0, 1, 0)
		modContent.BackgroundTransparency = 1
		modContent.Visible = false
		modContent.Parent = contentArea
		createModerationTab(modContent)
		tabContents[tabData.name] = modContent

	elseif tabData.isTroll then
		local trollContent = Instance.new("Frame")
		trollContent.Size = UDim2.new(1, 0, 1, 0)
		trollContent.BackgroundTransparency = 1
		trollContent.Visible = false
		trollContent.Parent = contentArea
		createTrollTab(trollContent)
		tabContents[tabData.name] = trollContent

	else
		local scrollFrame = Instance.new("ScrollingFrame")
		scrollFrame.Size = UDim2.new(1, 0, 1, 0)
		scrollFrame.BackgroundTransparency = 1
		scrollFrame.BorderSizePixel = 0
		scrollFrame.ScrollBarThickness = 4
		scrollFrame.ScrollBarImageColor3 = COLORS.accent
		scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		scrollFrame.Visible = false
		scrollFrame.Parent = contentArea

		local scrollLayout = Instance.new("UIListLayout")
		scrollLayout.Padding = UDim.new(0, 8)
		scrollLayout.Parent = scrollFrame

		for j, cmd in ipairs(tabData.commands) do
			createCommandCard(cmd, scrollFrame, j)
		end

		tabContents[tabData.name] = scrollFrame
	end
end

selectTab(allTabsData[1].name)

-- ============================
-- OUVERTURE / FERMETURE (anti double-clic dédié)
-- ============================
local isOpen = false
local toggleProcessing = false

toggleButton.MouseButton1Click:Connect(function()
	if toggleProcessing then return end
	toggleProcessing = true
	isOpen = not isOpen
	mainFrame.Visible = isOpen
	task.wait(0.3)
	toggleProcessing = false
end)

closeButton.MouseButton1Click:Connect(function()
	isOpen = false
	mainFrame.Visible = false
end)

-- ============================
-- EFFET SPECTACLE POUR LES ANNONCES
-- ============================
announceEffectRemote.OnClientEvent:Connect(function(message)
	local effectGui = Instance.new("ScreenGui")
	effectGui.Name = "AnnounceEffect"
	effectGui.ResetOnSpawn = false
	effectGui.DisplayOrder = 100
	effectGui.Parent = player.PlayerGui

	local overlay = Instance.new("Frame")
	overlay.Size = UDim2.new(1, 0, 1, 0)
	overlay.BackgroundColor3 = Color3.new(0, 0, 0)
	overlay.BackgroundTransparency = 1
	overlay.Parent = effectGui

	local banner = Instance.new("Frame")
	banner.Size = UDim2.new(1, 0, 0, 120)
	banner.Position = UDim2.new(0, 0, 0.5, -60)
	banner.BackgroundColor3 = COLORS.accent
	banner.BackgroundTransparency = 1
	banner.Parent = effectGui

	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 90, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 100, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 90, 255)),
	})
	gradient.Parent = banner

	local text = Instance.new("TextLabel")
	text.Size = UDim2.new(1, -40, 1, 0)
	text.Position = UDim2.new(0, 20, 0, 0)
	text.BackgroundTransparency = 1
	text.Text = "📢 " .. message
	text.Font = Enum.Font.GothamBlack
	text.TextSize = 32
	text.TextColor3 = Color3.new(1, 1, 1)
	text.TextWrapped = true
	text.TextTransparency = 1
	text.Parent = banner

	TweenService:Create(overlay, TweenInfo.new(0.3), { BackgroundTransparency = 0.6 }):Play()
	TweenService:Create(banner, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { BackgroundTransparency = 0.15 }):Play()
	TweenService:Create(text, TweenInfo.new(0.4), { TextTransparency = 0 }):Play()

	task.wait(3)

	TweenService:Create(overlay, TweenInfo.new(0.4), { BackgroundTransparency = 1 }):Play()
	TweenService:Create(banner, TweenInfo.new(0.4), { BackgroundTransparency = 1 }):Play()
	TweenService:Create(text, TweenInfo.new(0.4), { TextTransparency = 1 }):Play()

	task.wait(0.5)
	effectGui:Destroy()
end)

print("✅ Admin Panel Client chargé")
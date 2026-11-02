-- ============================================
-- LEADERBOARD PANEL CLIENT - Style blanc/rose
-- LocalScript, dans StarterPlayerScripts
-- ============================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local checkAccessRemote = Remotes:WaitForChild("CheckLeaderboardPanelAccess")
local getLeaderboardRemote = Remotes:WaitForChild("GetLeaderboardPanelData")

local hasAccess = checkAccessRemote:InvokeServer()
if not hasAccess then return end

-- ============================
-- THEME BLANC / ROSE
-- ============================
local COLORS = {
	background = Color3.fromRGB(255, 255, 255),
	panel = Color3.fromRGB(255, 250, 252),
	pinkPrimary = Color3.fromRGB(255, 105, 165),
	pinkSoft = Color3.fromRGB(255, 200, 222),
	pinkPale = Color3.fromRGB(255, 235, 243),
	text = Color3.fromRGB(60, 30, 45),
	textDim = Color3.fromRGB(160, 110, 130),
	gold = Color3.fromRGB(255, 200, 60),
	silver = Color3.fromRGB(190, 195, 205),
	bronze = Color3.fromRGB(210, 150, 100),
}

local CATEGORIES = {
	{ key = "Wins", label = "🏆 Wins", icon = "🏆" },
	{ key = "TotalXP", label = "⚡ Speed", icon = "⚡" },
}

-- ============================
-- SCREENGUI
-- ============================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LeaderboardPanel"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- ============================
-- RECHERCHE DU BOUTON EXISTANT "LeaderboardsButton"
-- (pas de bouton auto-créé : on utilise celui déjà présent dans ton UI)
-- ============================
local function findLeaderboardsButton()
	-- Cherche d'abord dans le PlayerGui (le plus probable)
	local found = playerGui:FindFirstChild("LeaderboardsButton", true)
	if found then return found end

	-- Sécurité : cherche aussi dans StarterGui au cas où pas encore répliqué
	local starterGui = game:GetService("StarterGui")
	found = starterGui:FindFirstChild("LeaderboardsButton", true)
	return found
end

local toggleButton = findLeaderboardsButton()

-- Si pas trouvé tout de suite, on retente pendant quelques secondes
-- (le PlayerGui peut encore être en train de se charger au moment où ce script tourne)
if not toggleButton then
	local attempts = 0
	while not toggleButton and attempts < 20 do
		task.wait(0.5)
		toggleButton = findLeaderboardsButton()
		attempts += 1
	end
end

if not toggleButton then
	warn("⚠️ [LeaderboardPanel] Bouton 'LeaderboardsButton' introuvable dans PlayerGui après 10s. Vérifie le nom exact de ton bouton.")
end

-- Panel principal, centré, blanc, un peu plus étroit
local mainFrame = Instance.new("Frame")
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Size = UDim2.new(0, 380, 0, 540)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = COLORS.background
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 20)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = COLORS.pinkSoft
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

-- Header rose
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 90)
header.BackgroundColor3 = COLORS.pinkPrimary
header.BorderSizePixel = 0
header.Parent = mainFrame
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 20)

local headerFix = Instance.new("Frame")
headerFix.Size = UDim2.new(1, 0, 0, 20)
headerFix.Position = UDim2.new(0, 0, 1, -20)
headerFix.BackgroundColor3 = COLORS.pinkPrimary
headerFix.BorderSizePixel = 0
headerFix.ZIndex = 0
headerFix.Parent = header

local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 190)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 90, 155)),
})
headerGradient.Rotation = 90
headerGradient.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 12)
title.BackgroundTransparency = 1
title.Text = "✨ CLASSEMENT ✨"
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
title.TextColor3 = Color3.new(1, 1, 1)
title.Parent = header

-- Bouton fermer : une VRAIE croix dessinée (2 barres croisées), pas un carré avec un glyphe
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -38, 0, 10)
closeButton.BackgroundTransparency = 1
closeButton.Text = ""
closeButton.AutoButtonColor = false
closeButton.Parent = header

local closeBar1 = Instance.new("Frame")
closeBar1.Size = UDim2.new(0, 16, 0, 2.5)
closeBar1.AnchorPoint = Vector2.new(0.5, 0.5)
closeBar1.Position = UDim2.new(0.5, 0, 0.5, 0)
closeBar1.Rotation = 45
closeBar1.BackgroundColor3 = Color3.new(1, 1, 1)
closeBar1.BorderSizePixel = 0
closeBar1.Parent = closeButton
Instance.new("UICorner", closeBar1).CornerRadius = UDim.new(1, 0)

local closeBar2 = closeBar1:Clone()
closeBar2.Rotation = -45
closeBar2.Parent = closeButton

-- Onglets (Wins / Speed)
local tabsHolder = Instance.new("Frame")
tabsHolder.Size = UDim2.new(1, -20, 0, 42)
tabsHolder.Position = UDim2.new(0, 10, 0, 52)
tabsHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tabsHolder.BackgroundTransparency = 0.15
tabsHolder.BorderSizePixel = 0
tabsHolder.Parent = header
Instance.new("UICorner", tabsHolder).CornerRadius = UDim.new(0, 12)

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.FillDirection = Enum.FillDirection.Horizontal
tabsLayout.Padding = UDim.new(0, 4)
tabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabsLayout.Parent = tabsHolder

local tabsPadding = Instance.new("UIPadding")
tabsPadding.PaddingLeft = UDim.new(0, 4)
tabsPadding.PaddingRight = UDim.new(0, 4)
tabsPadding.Parent = tabsHolder

-- Liste scrollable
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -105)
scrollFrame.Position = UDim2.new(0, 10, 0, 100)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 5
scrollFrame.ScrollBarImageColor3 = COLORS.pinkPrimary
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.Parent = mainFrame

local scrollLayout = Instance.new("UIListLayout")
scrollLayout.Padding = UDim.new(0, 7)
scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
scrollLayout.Parent = scrollFrame

-- ============================
-- COULEUR DE RANG (Top 3 en couleur spéciale)
-- ============================
local function getRankColor(rank)
	if rank == 1 then return COLORS.gold end
	if rank == 2 then return COLORS.silver end
	if rank == 3 then return COLORS.bronze end
	return COLORS.pinkPrimary
end

-- Paliers du plus grand au plus petit. Sous 10x le palier -> 1 décimale (3.5qa),
-- entre 10x et 1000x -> nombre entier (35qa, 350qa), puis ça bascule au palier suivant.
local NUMBER_SUFFIXES = {
	{ 1e33, "Dd" },
	{ 1e30, "Dc" },
	{ 1e27, "Oc" },
	{ 1e24, "Sp" },
	{ 1e21, "Sx" },
	{ 1e18, "Qi" },
	{ 1e15, "Qa" },
	{ 1e12, "T" },
	{ 1e9, "B" },
	{ 1e6, "M" },
	{ 1e3, "K" },
}

local function formatNumber(num)
	for _, pair in ipairs(NUMBER_SUFFIXES) do
		local threshold, suffix = pair[1], pair[2]
		if num >= threshold then
			local scaled = num / threshold
			if scaled < 10 then
				return string.format("%.1f%s", scaled, suffix)
			else
				return string.format("%d%s", math.floor(scaled), suffix)
			end
		end
	end
	return tostring(math.floor(num))
end

-- ============================
-- CREE UNE LIGNE DE CLASSEMENT (resserrée)
-- ============================
local function createRow(entry, layoutOrder)
	local row = Instance.new("Frame")
	row.Name = "Row"
	row.Size = UDim2.new(1, 0, 0, 42)
	row.BackgroundColor3 = COLORS.pinkPale
	row.BorderSizePixel = 0
	row.LayoutOrder = layoutOrder
	row.Parent = scrollFrame
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)

	local rankColor = getRankColor(entry.rank)
	local rankBadge = Instance.new("Frame")
	rankBadge.Size = UDim2.new(0, 22, 0, 22)
	rankBadge.Position = UDim2.new(0, 6, 0.5, 0)
	rankBadge.AnchorPoint = Vector2.new(0, 0.5)
	rankBadge.BackgroundColor3 = rankColor
	rankBadge.BorderSizePixel = 0
	rankBadge.Parent = row
	Instance.new("UICorner", rankBadge).CornerRadius = UDim.new(1, 0)

	local rankLabel = Instance.new("TextLabel")
	rankLabel.Size = UDim2.new(1, 0, 1, 0)
	rankLabel.BackgroundTransparency = 1
	rankLabel.Text = tostring(entry.rank)
	rankLabel.Font = Enum.Font.GothamBlack
	rankLabel.TextSize = 10
	rankLabel.TextColor3 = Color3.new(1, 1, 1)
	rankLabel.Parent = rankBadge

	local avatarFrame = Instance.new("ImageLabel")
	avatarFrame.Size = UDim2.new(0, 28, 0, 28)
	avatarFrame.Position = UDim2.new(0, 34, 0.5, 0)
	avatarFrame.AnchorPoint = Vector2.new(0, 0.5)
	avatarFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	avatarFrame.Parent = row
	Instance.new("UICorner", avatarFrame).CornerRadius = UDim.new(1, 0)

	local avatarStroke = Instance.new("UIStroke")
	avatarStroke.Color = COLORS.pinkPrimary
	avatarStroke.Thickness = 1.5
	avatarStroke.Parent = avatarFrame

	task.spawn(function()
		local success, content = pcall(function()
			return Players:GetUserThumbnailAsync(entry.userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
		end)
		if success then
			avatarFrame.Image = content
		end
	end)

	local nameBadge = Instance.new("TextLabel")
	nameBadge.Size = UDim2.new(0, 0, 0, 18)
	nameBadge.AutomaticSize = Enum.AutomaticSize.X
	nameBadge.Position = UDim2.new(0, 70, 0.5, 0)
	nameBadge.AnchorPoint = Vector2.new(0, 0.5)
	nameBadge.BackgroundColor3 = COLORS.pinkSoft
	nameBadge.BorderSizePixel = 0
	nameBadge.Font = Enum.Font.GothamBold
	nameBadge.TextSize = 11
	nameBadge.TextColor3 = COLORS.text
	nameBadge.Text = entry.username
	nameBadge.Parent = row
	Instance.new("UICorner", nameBadge).CornerRadius = UDim.new(1, 0)

	local namePadding = Instance.new("UIPadding")
	namePadding.PaddingLeft = UDim.new(0, 8)
	namePadding.PaddingRight = UDim.new(0, 8)
	namePadding.Parent = nameBadge

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.new(0, 70, 0, 18)
	valueLabel.Position = UDim2.new(1, -8, 0.5, 0)
	valueLabel.AnchorPoint = Vector2.new(1, 0.5)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Font = Enum.Font.GothamBold
	valueLabel.TextSize = 11
	valueLabel.TextColor3 = COLORS.pinkPrimary
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.Text = formatNumber(entry.value)
	valueLabel.Parent = row

	if entry.userId == player.UserId then
		local highlightStroke = Instance.new("UIStroke")
		highlightStroke.Color = COLORS.pinkPrimary
		highlightStroke.Thickness = 2
		highlightStroke.Parent = row
	end

	return row
end

-- ============================
-- CHARGEMENT DU CLASSEMENT
-- ============================
local currentCategory = "Wins"

local function loadLeaderboard(category)
	currentCategory = category

	for _, child in pairs(scrollFrame:GetChildren()) do
		if child:IsA("Frame") or child:IsA("TextLabel") then
			child:Destroy()
		end
	end

	local loading = Instance.new("TextLabel")
	loading.Size = UDim2.new(1, 0, 0, 40)
	loading.BackgroundTransparency = 1
	loading.Text = "Chargement..."
	loading.Font = Enum.Font.GothamBold
	loading.TextSize = 14
	loading.TextColor3 = COLORS.textDim
	loading.Parent = scrollFrame

	task.spawn(function()
		local success, entries = pcall(function()
			return getLeaderboardRemote:InvokeServer(category)
		end)

		loading:Destroy()

		if not success or not entries or #entries == 0 then
			local emptyLabel = Instance.new("TextLabel")
			emptyLabel.Size = UDim2.new(1, 0, 0, 40)
			emptyLabel.BackgroundTransparency = 1
			emptyLabel.Text = "Aucune donnée pour le moment 🌸"
			emptyLabel.Font = Enum.Font.GothamBold
			emptyLabel.TextSize = 14
			emptyLabel.TextColor3 = COLORS.textDim
			emptyLabel.Parent = scrollFrame
			return
		end

		for i, entry in ipairs(entries) do
			if i > 50 then break end
			createRow(entry, i)
		end
	end)
end

-- ============================
-- CREATION DES BOUTONS D'ONGLETS
-- ============================
for _, cat in ipairs(CATEGORIES) do
	local tabBtn = Instance.new("TextButton")
	tabBtn.Size = UDim2.new(0.5, -4, 1, -8)
	tabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tabBtn.Text = cat.label
	tabBtn.Font = Enum.Font.GothamBold
	tabBtn.TextSize = 13
	tabBtn.TextColor3 = COLORS.pinkPrimary
	tabBtn.BorderSizePixel = 0
	tabBtn.AutoButtonColor = false
	tabBtn.Parent = tabsHolder
	Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 10)

	tabBtn.MouseButton1Click:Connect(function()
		for _, other in pairs(tabsHolder:GetChildren()) do
			if other:IsA("TextButton") then
				other.BackgroundTransparency = 0.7
			end
		end
		tabBtn.BackgroundTransparency = 0
		loadLeaderboard(cat.key)
	end)

	if cat.key == "Wins" then
		tabBtn.BackgroundTransparency = 0
	else
		tabBtn.BackgroundTransparency = 0.7
	end
end

-- ============================
-- OUVERTURE / FERMETURE
-- ============================
local isOpen = false
local processing = false

toggleButton.MouseButton1Click:Connect(function()
	if processing then return end
	processing = true
	isOpen = not isOpen
	mainFrame.Visible = isOpen

	if isOpen then
		loadLeaderboard(currentCategory)
	end

	task.wait(0.3)
	processing = false
end)

closeButton.MouseButton1Click:Connect(function()
	isOpen = false
	mainFrame.Visible = false
end)

print("✅ Leaderboard Panel Client chargé")
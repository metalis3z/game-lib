--[[
	AdminPanelClient.client.lua
	Place dans: StarterPlayer > StarterPlayerScripts

	Panel admin avec onglet Fly (vol) – version robuste.
	Le remote "AdminPanel/ToggleFly" est chargé avec pcall pour ne pas planter si absent.
]]

print("[AdminPanelClient] Script démarré.")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local okNet, Net = pcall(function()
	return require(ReplicatedStorage.Packages.Net)
end)
if not okNet then
	warn("[AdminPanelClient] ÉCHEC require Net:", Net)
	return
end

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

print("[AdminPanelClient] Net chargé, LocalPlayer =", LocalPlayer.Name)

-- ============================================================
-- REMOTES (sécurisés)
-- ============================================================
local CheckAdminRF = Net:RemoteFunction("AdminPanel/CheckAdmin")
local GetAnimalListRF = Net:RemoteFunction("AdminPanel/GetAnimalList")
local GetEventListRF = Net:RemoteFunction("AdminPanel/GetEventList")
local GetActiveEventsRF = Net:RemoteFunction("AdminPanel/GetActiveEvents")
local SpawnAnimalRF = Net:RemoteFunction("AdminPanel/SpawnAnimal")
local ExecuteEventRF = Net:RemoteFunction("AdminPanel/ExecuteEvent")
local CancelEventRF = Net:RemoteFunction("AdminPanel/CancelEvent")
local StartMutationRainRF = Net:RemoteFunction("AdminPanel/StartMutationRain")
local StopMutationRainRF = Net:RemoteFunction("AdminPanel/StopMutationRain")

-- ToggleFly : chargé avec pcall pour éviter une erreur si le serveur ne l'a pas encore défini
local ToggleFlyRF = nil
local okFly, flyRemote = pcall(function()
	return Net:RemoteFunction("AdminPanel/ToggleFly")
end)
if okFly then
	ToggleFlyRF = flyRemote
	print("[AdminPanelClient] ToggleFlyRF disponible")
else
	warn("[AdminPanelClient] ToggleFlyRF non disponible sur le serveur :", flyRemote)
end

-- ============================================================
-- THEME & UI HELPERS
-- ============================================================
local COLORS = {
	Background = Color3.fromRGB(18, 18, 24),
	Panel = Color3.fromRGB(28, 28, 38),
	PanelLight = Color3.fromRGB(40, 40, 54),
	Accent = Color3.fromRGB(124, 110, 255),
	AccentDark = Color3.fromRGB(90, 78, 200),
	Success = Color3.fromRGB(86, 214, 134),
	Danger = Color3.fromRGB(235, 90, 90),
	Text = Color3.fromRGB(240, 240, 245),
	SubText = Color3.fromRGB(170, 170, 185),
	Stroke = Color3.fromRGB(70, 70, 90),
}

local function corner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = parent
	return c
end

local function stroke(parent, color, thickness, transparency)
	local s = Instance.new("UIStroke")
	s.Color = color or COLORS.Stroke
	s.Thickness = thickness or 1
	s.Transparency = transparency or 0.4
	s.Parent = parent
	return s
end

local function padding(parent, all)
	local p = Instance.new("UIPadding")
	p.PaddingTop = UDim.new(0, all)
	p.PaddingBottom = UDim.new(0, all)
	p.PaddingLeft = UDim.new(0, all)
	p.PaddingRight = UDim.new(0, all)
	p.Parent = parent
	return p
end

-- ============================================================
-- ROOT GUI
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdminPanelGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 1000
ScreenGui.Enabled = false
ScreenGui.Parent = PlayerGui

print("[AdminPanelClient] ScreenGui créé.")

local Overlay = Instance.new("TextButton")
Overlay.Name = "Overlay"
Overlay.Size = UDim2.fromScale(1, 1)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.55
Overlay.BorderSizePixel = 0
Overlay.Text = ""
Overlay.AutoButtonColor = false
Overlay.ZIndex = 1
Overlay.Parent = ScreenGui

local MainPanel = Instance.new("Frame")
MainPanel.Name = "MainPanel"
MainPanel.Size = UDim2.fromOffset(640, 500)
MainPanel.Position = UDim2.fromScale(0.5, 0.5)
MainPanel.AnchorPoint = Vector2.new(0.5, 0.5)
MainPanel.BackgroundColor3 = COLORS.Background
MainPanel.BackgroundTransparency = 0.12
MainPanel.BorderSizePixel = 0
MainPanel.ClipsDescendants = false
MainPanel.ZIndex = 2
MainPanel.Parent = ScreenGui
corner(MainPanel, 16)
stroke(MainPanel, COLORS.Accent, 1, 0.55)

-- Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 56)
Header.BackgroundColor3 = COLORS.PanelLight
Header.BackgroundTransparency = 0.25
Header.BorderSizePixel = 0
Header.ZIndex = 2
Header.Parent = MainPanel
corner(Header, 16)

local HeaderMask = Instance.new("Frame")
HeaderMask.Size = UDim2.new(1, 0, 0, 16)
HeaderMask.Position = UDim2.new(0, 0, 1, -16)
HeaderMask.BackgroundColor3 = COLORS.PanelLight
HeaderMask.BackgroundTransparency = 0.25
HeaderMask.BorderSizePixel = 0
HeaderMask.ZIndex = 2
HeaderMask.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.BackgroundTransparency = 1
TitleLabel.Size = UDim2.new(1, -130, 0, 24)
TitleLabel.Position = UDim2.fromOffset(20, 8)
TitleLabel.Text = "⚙ Admin Panel"
TitleLabel.TextColor3 = COLORS.Text
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 3
TitleLabel.Parent = Header

local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Name = "Subtitle"
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Size = UDim2.new(1, -130, 0, 16)
SubtitleLabel.Position = UDim2.fromOffset(20, 32)
SubtitleLabel.Text = "F3 pour ouvrir/fermer"
SubtitleLabel.TextColor3 = COLORS.SubText
SubtitleLabel.TextSize = 12
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubtitleLabel.ZIndex = 3
SubtitleLabel.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.fromOffset(36, 36)
CloseButton.Position = UDim2.new(1, -46, 0.5, -18)
CloseButton.BackgroundColor3 = COLORS.Danger
CloseButton.BackgroundTransparency = 0.2
CloseButton.Text = "✕"
CloseButton.TextColor3 = COLORS.Text
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.ZIndex = 3
CloseButton.Parent = Header
corner(CloseButton, 8)

-- Tab bar
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, -32, 0, 38)
TabBar.Position = UDim2.fromOffset(16, 68)
TabBar.BackgroundTransparency = 1
TabBar.ZIndex = 2
TabBar.Parent = MainPanel

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 8)
TabLayout.Parent = TabBar

local function makeTabButton(name)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.fromOffset(160, 38)
	btn.BackgroundColor3 = COLORS.PanelLight
	btn.BackgroundTransparency = 0.3
	btn.Text = name
	btn.TextColor3 = COLORS.SubText
	btn.TextSize = 14
	btn.Font = Enum.Font.GothamMedium
	btn.ZIndex = 2
	btn.Parent = TabBar
	corner(btn, 8)
	return btn
end

local TabSpawn = makeTabButton("🐾 Spawn Animal")
local TabEvents = makeTabButton("🌍 Events")
local TabRain = makeTabButton("🌧 ")
local TabFly   = makeTabButton("✈ Fly")

-- Content area
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -32, 1, -180)
ContentArea.Position = UDim2.fromOffset(16, 118)
ContentArea.BackgroundTransparency = 1
ContentArea.ClipsDescendants = false
ContentArea.ZIndex = 2
ContentArea.Parent = MainPanel

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, -32, 0, 24)
StatusLabel.Position = UDim2.new(0, 16, 1, -32)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = COLORS.SubText
StatusLabel.TextSize = 13
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.ZIndex = 2
StatusLabel.Parent = MainPanel

local statusFadeToken = 0
local function setStatus(text, isError)
	statusFadeToken += 1
	local myToken = statusFadeToken
	StatusLabel.TextColor3 = isError and COLORS.Danger or COLORS.Success
	StatusLabel.Text = text
	task.delay(3.5, function()
		if myToken == statusFadeToken then
			StatusLabel.Text = ""
		end
	end)
end

-- Dropdown layer
local DropdownLayer = Instance.new("Frame")
DropdownLayer.Name = "DropdownLayer"
DropdownLayer.Size = UDim2.fromScale(1, 1)
DropdownLayer.BackgroundTransparency = 1
DropdownLayer.ZIndex = 50
DropdownLayer.Parent = MainPanel

-- ============================================================
-- HELPERS UI (boutons, textes, dropdowns)
-- ============================================================
local function makeScrollFrame(parentFrame)
	local sf = Instance.new("ScrollingFrame")
	sf.Size = UDim2.fromScale(1, 1)
	sf.BackgroundTransparency = 1
	sf.BorderSizePixel = 0
	sf.ScrollBarThickness = 5
	sf.ScrollBarImageColor3 = COLORS.Accent
	sf.CanvasSize = UDim2.new(0, 0, 0, 0)
	sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
	sf.ZIndex = 2
	sf.Parent = parentFrame

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 8)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = sf

	return sf
end

local function makeButton(parentFrame, text, color, size, position)
	local btn = Instance.new("TextButton")
	btn.Size = size or UDim2.new(1, 0, 0, 40)
	if position then btn.Position = position end
	btn.BackgroundColor3 = color or COLORS.Accent
	btn.BackgroundTransparency = 0.1
	btn.Text = text
	btn.TextColor3 = COLORS.Text
	btn.TextSize = 14
	btn.Font = Enum.Font.GothamMedium
	btn.ZIndex = 3
	btn.AutoButtonColor = true
	btn.Parent = parentFrame
	corner(btn, 8)
	return btn
end

local function makeTextBox(parentFrame, placeholder, size, position)
	local box = Instance.new("TextBox")
	box.Size = size or UDim2.new(1, 0, 0, 38)
	if position then box.Position = position end
	box.BackgroundColor3 = COLORS.PanelLight
	box.BackgroundTransparency = 0.25
	box.PlaceholderText = placeholder
	box.PlaceholderColor3 = COLORS.SubText
	box.Text = ""
	box.TextColor3 = COLORS.Text
	box.TextSize = 14
	box.Font = Enum.Font.Gotham
	box.ClearTextOnFocus = false
	box.ZIndex = 3
	box.Parent = parentFrame
	corner(box, 8)
	padding(box, 8)
	return box
end

local function makeSectionLabel(parentFrame, text, position)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 0, 18)
	lbl.Position = position
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = COLORS.SubText
	lbl.TextSize = 12
	lbl.Font = Enum.Font.GothamBold
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.ZIndex = 3
	lbl.Parent = parentFrame
	return lbl
end

local activeDropdownCloseFns = {}

local function closeAllDropdowns()
	for _, fn in ipairs(activeDropdownCloseFns) do
		fn()
	end
end

local function makeDropdown(parentFrame, placeholder, options, onSelect, size, position)
	local mainBtn = Instance.new("TextButton")
	mainBtn.Size = size or UDim2.new(1, 0, 0, 38)
	if position then mainBtn.Position = position end
	mainBtn.BackgroundColor3 = COLORS.PanelLight
	mainBtn.BackgroundTransparency = 0.25
	mainBtn.Text = "  " .. placeholder .. "  ▾"
	mainBtn.TextColor3 = COLORS.Text
	mainBtn.TextSize = 14
	mainBtn.Font = Enum.Font.Gotham
	mainBtn.TextXAlignment = Enum.TextXAlignment.Left
	mainBtn.ZIndex = 3
	mainBtn.Parent = parentFrame
	corner(mainBtn, 8)
	stroke(mainBtn, COLORS.Stroke, 1, 0.5)

	local listFrame = Instance.new("Frame")
	listFrame.Size = UDim2.fromOffset(0, 220)
	listFrame.BackgroundColor3 = COLORS.Panel
	listFrame.BackgroundTransparency = 0.03
	listFrame.Visible = false
	listFrame.ZIndex = 50
	listFrame.Parent = DropdownLayer
	corner(listFrame, 8)
	stroke(listFrame, COLORS.Accent, 1, 0.3)

	local searchBox = makeTextBox(listFrame, "Rechercher...", UDim2.new(1, -8, 0, 30), UDim2.fromOffset(4, 4))
	searchBox.ZIndex = 51

	local listScroll = Instance.new("ScrollingFrame")
	listScroll.Size = UDim2.new(1, -8, 1, -42)
	listScroll.Position = UDim2.fromOffset(4, 38)
	listScroll.BackgroundTransparency = 1
	listScroll.BorderSizePixel = 0
	listScroll.ScrollBarThickness = 4
	listScroll.ScrollBarImageColor3 = COLORS.Accent
	listScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	listScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	listScroll.ZIndex = 51
	listScroll.Parent = listFrame

	local listLayout = Instance.new("UIListLayout")
	listLayout.Padding = UDim.new(0, 2)
	listLayout.Parent = listScroll

	local optionButtons = {}

	local function rebuildOptions(filter)
		for _, b in ipairs(optionButtons) do
			b:Destroy()
		end
		table.clear(optionButtons)

		local lowerFilter = filter and filter:lower() or nil
		for _, opt in ipairs(options) do
			if not lowerFilter or lowerFilter == "" or opt:lower():find(lowerFilter, 1, true) then
				local optBtn = Instance.new("TextButton")
				optBtn.Size = UDim2.new(1, 0, 0, 28)
				optBtn.BackgroundColor3 = COLORS.PanelLight
				optBtn.BackgroundTransparency = 0.5
				optBtn.Text = "  " .. opt
				optBtn.TextColor3 = COLORS.Text
				optBtn.TextSize = 13
				optBtn.Font = Enum.Font.Gotham
				optBtn.TextXAlignment = Enum.TextXAlignment.Left
				optBtn.ZIndex = 51
				optBtn.Parent = listScroll
				corner(optBtn, 6)

				optBtn.MouseButton1Click:Connect(function()
					mainBtn.Text = "  " .. opt .. "  ▾"
					listFrame.Visible = false
					onSelect(opt)
				end)

				table.insert(optionButtons, optBtn)
			end
		end
	end

	rebuildOptions(nil)

	searchBox:GetPropertyChangedSignal("Text"):Connect(function()
		rebuildOptions(searchBox.Text)
	end)

	local function closeThis()
		listFrame.Visible = false
	end
	table.insert(activeDropdownCloseFns, closeThis)

	mainBtn.MouseButton1Click:Connect(function()
		local willOpen = not listFrame.Visible
		closeAllDropdowns()
		if willOpen then
			local absPos = mainBtn.AbsolutePosition
			local absSize = mainBtn.AbsoluteSize
			local panelAbsPos = MainPanel.AbsolutePosition
			listFrame.Position = UDim2.fromOffset(
				absPos.X - panelAbsPos.X,
				absPos.Y - panelAbsPos.Y + absSize.Y + 4
			)
			listFrame.Size = UDim2.fromOffset(absSize.X, 220)
			listFrame.Visible = true
		end
	end)

	return mainBtn, function(newOptions)
		options = newOptions
		rebuildOptions(searchBox.Text)
	end
end

Overlay.MouseButton1Click:Connect(closeAllDropdowns)
MainPanel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		-- rien
	end
end)

-- ============================================================
-- TAB SPAWN ANIMAL
-- ============================================================
local SpawnPage = Instance.new("Frame")
SpawnPage.Size = UDim2.fromScale(1, 1)
SpawnPage.BackgroundTransparency = 1
SpawnPage.ZIndex = 2
SpawnPage.Parent = ContentArea

makeSectionLabel(SpawnPage, "ANIMAL", UDim2.fromOffset(0, 0))
local animalLookup = {}
local selectedAnimal = nil

local animalDropdownBtn, refreshAnimalOptions = makeDropdown(
	SpawnPage, "Choisir un animal...", {},
	function(displayText)
		for key, info in pairs(animalLookup) do
			if (info.Rarity .. " — " .. info.DisplayName) == displayText then
				selectedAnimal = key
				break
			end
		end
	end,
	UDim2.new(1, 0, 0, 38),
	UDim2.fromOffset(0, 22)
)

makeSectionLabel(SpawnPage, "MUTATION (optionnel)", UDim2.fromOffset(0, 74))
local mutationBox = makeTextBox(
	SpawnPage, "Ex: Divine, Rainbow, Galaxy... (laisser vide = aucune)",
	UDim2.new(1, 0, 0, 38), UDim2.fromOffset(0, 96)
)

local SpawnLocalBtn = makeButton(
	SpawnPage, "Spawn (route normale)", COLORS.Accent,
	UDim2.new(0.5, -6, 0, 40), UDim2.fromOffset(0, 148)
)
local SpawnGlobalBtn = makeButton(
	SpawnPage, "Spawn (forcé instant)", COLORS.AccentDark,
	UDim2.new(0.5, -6, 0, 40), UDim2.new(0.5, 6, 0, 148)
)

local function doSpawn(isGlobal)
	if not selectedAnimal then
		setStatus("Sélectionne un animal d'abord", true)
		return
	end
	local mutationText = mutationBox.Text
	local ok, success, msg = pcall(function()
		return SpawnAnimalRF:InvokeServer(selectedAnimal, mutationText, isGlobal)
	end)
	if not ok then
		setStatus("Erreur réseau", true)
		warn("[AdminPanelClient] Erreur SpawnAnimalRF:", success)
		return
	end
	setStatus(msg or (success and "OK" or "Échec"), not success)
end

SpawnLocalBtn.MouseButton1Click:Connect(function() doSpawn(false) end)
SpawnGlobalBtn.MouseButton1Click:Connect(function() doSpawn(true) end)

-- ============================================================
-- TAB EVENTS
-- ============================================================
local EventsPage = Instance.new("Frame")
EventsPage.Size = UDim2.fromScale(1, 1)
EventsPage.BackgroundTransparency = 1
EventsPage.Visible = false
EventsPage.ZIndex = 2
EventsPage.Parent = ContentArea

makeSectionLabel(EventsPage, "EVENT", UDim2.fromOffset(0, 0))
local selectedEvent = nil
local eventDropdownBtn, refreshEventOptions = makeDropdown(
	EventsPage, "Choisir un event...", {},
	function(opt) selectedEvent = opt end,
	UDim2.new(1, 0, 0, 38),
	UDim2.fromOffset(0, 22)
)

makeSectionLabel(EventsPage, "DURÉE EN SECONDES (optionnel)", UDim2.fromOffset(0, 74))
local durationBox = makeTextBox(
	EventsPage, "Ex: 300",
	UDim2.new(1, 0, 0, 38), UDim2.fromOffset(0, 96)
)

local StartEventBtn = makeButton(
	EventsPage, "▶ Lancer l'event", COLORS.Success,
	UDim2.new(0.5, -6, 0, 40), UDim2.fromOffset(0, 148)
)
local StopEventBtn = makeButton(
	EventsPage, "■ Annuler l'event", COLORS.Danger,
	UDim2.new(0.5, -6, 0, 40), UDim2.new(0.5, 6, 0, 148)
)

makeSectionLabel(EventsPage, "EVENTS ACTIFS", UDim2.fromOffset(0, 202))
local ActiveEventsFrame = Instance.new("Frame")
ActiveEventsFrame.Size = UDim2.new(1, 0, 1, -228)
ActiveEventsFrame.Position = UDim2.fromOffset(0, 224)
ActiveEventsFrame.BackgroundColor3 = COLORS.PanelLight
ActiveEventsFrame.BackgroundTransparency = 0.4
ActiveEventsFrame.ZIndex = 2
ActiveEventsFrame.Parent = EventsPage
corner(ActiveEventsFrame, 8)
padding(ActiveEventsFrame, 6)

local ActiveEventsScroll = makeScrollFrame(ActiveEventsFrame)

local function refreshActiveEvents()
	local ok, list = pcall(function()
		return GetActiveEventsRF:InvokeServer()
	end)
	if not ok or type(list) ~= "table" then return end

	for _, child in ipairs(ActiveEventsScroll:GetChildren()) do
		if child:IsA("Frame") then child:Destroy() end
	end

	if #list == 0 then
		local empty = Instance.new("TextLabel")
		empty.Size = UDim2.new(1, 0, 0, 24)
		empty.BackgroundTransparency = 1
		empty.Text = "Aucun event actif"
		empty.TextColor3 = COLORS.SubText
		empty.TextSize = 12
		empty.Font = Enum.Font.Gotham
		empty.ZIndex = 3
		empty.Parent = ActiveEventsScroll
		return
	end

	for _, entry in ipairs(list) do
		local row = Instance.new("Frame")
		row.Size = UDim2.new(1, 0, 0, 26)
		row.BackgroundTransparency = 1
		row.ZIndex = 3
		row.Parent = ActiveEventsScroll

		local nameLbl = Instance.new("TextLabel")
		nameLbl.Size = UDim2.new(0.7, 0, 1, 0)
		nameLbl.BackgroundTransparency = 1
		nameLbl.Text = "• " .. entry.EventName
		nameLbl.TextColor3 = COLORS.Text
		nameLbl.TextSize = 13
		nameLbl.Font = Enum.Font.GothamMedium
		nameLbl.TextXAlignment = Enum.TextXAlignment.Left
		nameLbl.ZIndex = 3
		nameLbl.Parent = row

		local timeLbl = Instance.new("TextLabel")
		timeLbl.Size = UDim2.new(0.3, 0, 1, 0)
		timeLbl.Position = UDim2.new(0.7, 0, 0, 0)
		timeLbl.BackgroundTransparency = 1
		timeLbl.Text = entry.Remaining and (entry.Remaining .. "s") or "∞"
		timeLbl.TextColor3 = COLORS.SubText
		timeLbl.TextSize = 12
		timeLbl.Font = Enum.Font.Gotham
		timeLbl.TextXAlignment = Enum.TextXAlignment.Right
		timeLbl.ZIndex = 3
		timeLbl.Parent = row
	end
end

StartEventBtn.MouseButton1Click:Connect(function()
	if not selectedEvent then
		setStatus("Sélectionne un event d'abord", true)
		return
	end
	local dur = tonumber(durationBox.Text)
	local ok, success, msg = pcall(function()
		return ExecuteEventRF:InvokeServer(selectedEvent, dur)
	end)
	if not ok then
		setStatus("Erreur réseau", true)
		return
	end
	setStatus(msg or (success and "OK" or "Échec"), not success)
	task.delay(0.3, refreshActiveEvents)
end)

StopEventBtn.MouseButton1Click:Connect(function()
	if not selectedEvent then
		setStatus("Sélectionne un event d'abord", true)
		return
	end
	local ok, success, msg = pcall(function()
		return CancelEventRF:InvokeServer(selectedEvent)
	end)
	if not ok then
		setStatus("Erreur réseau", true)
		return
	end
	setStatus(msg or (success and "OK" or "Échec"), not success)
	task.delay(0.3, refreshActiveEvents)
end)

-- ============================================================
-- TAB 
-- ============================================================
local RainPage = Instance.new("Frame")
RainPage.Size = UDim2.fromScale(1, 1)
RainPage.BackgroundTransparency = 1
RainPage.Visible = false
RainPage.ZIndex = 2
RainPage.Parent = ContentArea

makeSectionLabel(RainPage, "MUTATION (laisser vide = aléatoire)", UDim2.fromOffset(0, 0))
local rainMutationBox = makeTextBox(
	RainPage, "Ex: Divine, Rainbow, Galaxy...",
	UDim2.new(1, 0, 0, 38), UDim2.fromOffset(0, 22)
)

makeSectionLabel(RainPage, "QUANTITÉ D'ANIMAUX", UDim2.fromOffset(0, 74))
local rainAmountBox = makeTextBox(
	RainPage, "Ex: 10",
	UDim2.new(1, 0, 0, 38), UDim2.fromOffset(0, 96)
)

local StartRainLocalBtn = makeButton(
	RainPage, "▶ Démarrer (ce serveur)", COLORS.Success,
	UDim2.new(0.5, -6, 0, 40), UDim2.fromOffset(0, 148)
)
local StopRainLocalBtn = makeButton(
	RainPage, "■ Arrêter (ce serveur)", COLORS.Danger,
	UDim2.new(0.5, -6, 0, 40), UDim2.new(0.5, 6, 0, 148)
)

local StartRainGlobalBtn = makeButton(
	RainPage, "🌍 Démarrer (TOUS serveurs)", COLORS.AccentDark,
	UDim2.new(0.5, -6, 0, 40), UDim2.fromOffset(0, 198)
)
local StopRainGlobalBtn = makeButton(
	RainPage, "🌍 Arrêter (TOUS serveurs)", Color3.fromRGB(150, 60, 60),
	UDim2.new(0.5, -6, 0, 40), UDim2.new(0.5, 6, 0, 198)
)

local function doStartRain(isGlobal)
	local amount = tonumber(rainAmountBox.Text)
	if not amount or amount <= 0 then
		setStatus("Quantité invalide", true)
		return
	end
	local ok, success, msg = pcall(function()
		return StartMutationRainRF:InvokeServer(rainMutationBox.Text, amount, isGlobal)
	end)
	if not ok then
		setStatus("Erreur réseau", true)
		return
	end
	setStatus(msg or (success and "OK" or "Échec"), not success)
end

local function doStopRain(isGlobal)
	local ok, success, msg = pcall(function()
		return StopMutationRainRF:InvokeServer(rainMutationBox.Text, isGlobal)
	end)
	if not ok then
		setStatus("Erreur réseau", true)
		return
	end
	setStatus(msg or (success and "OK" or "Échec"), not success)
end

StartRainLocalBtn.MouseButton1Click:Connect(function() doStartRain(false) end)
StopRainLocalBtn.MouseButton1Click:Connect(function() doStopRain(false) end)
StartRainGlobalBtn.MouseButton1Click:Connect(function() doStartRain(true) end)
StopRainGlobalBtn.MouseButton1Click:Connect(function() doStopRain(true) end)

-- ============================================================
-- TAB FLY (VOL)
-- ============================================================
local FlyPage = Instance.new("Frame")
FlyPage.Size = UDim2.fromScale(1, 1)
FlyPage.BackgroundTransparency = 1
FlyPage.Visible = false
FlyPage.ZIndex = 2
FlyPage.Parent = ContentArea

makeSectionLabel(FlyPage, "JOUEUR", UDim2.fromOffset(0, 0))
local selectedFlyPlayer = nil

local function refreshPlayerList()
	local playerNames = {}
	for _, plr in ipairs(Players:GetPlayers()) do
		table.insert(playerNames, plr.Name)
	end
	table.sort(playerNames)
	return playerNames
end

local flyPlayerDropdownBtn, refreshFlyPlayerOptions = makeDropdown(
	FlyPage, "Choisir un joueur...", refreshPlayerList(),
	function(name)
		selectedFlyPlayer = name
	end,
	UDim2.new(1, 0, 0, 38),
	UDim2.fromOffset(0, 22)
)

local ToggleFlyBtn = makeButton(
	FlyPage, "🔄 Activer/Désactiver le vol", COLORS.Accent,
	UDim2.new(0.6, 0, 0, 44), UDim2.new(0.2, 0, 0, 80)
)

ToggleFlyBtn.MouseButton1Click:Connect(function()
	if not selectedFlyPlayer then
		setStatus("Sélectionne un joueur d'abord", true)
		return
	end

	if not ToggleFlyRF then
		setStatus("Fonction de vol non disponible sur le serveur", true)
		return
	end

	local ok, success, msg = pcall(function()
		return ToggleFlyRF:InvokeServer(selectedFlyPlayer)
	end)

	if not ok then
		setStatus("Erreur réseau", true)
		warn("[AdminPanelClient] Erreur ToggleFlyRF:", success)
		return
	end

	setStatus(msg or (success and "Vol basculé" or "Échec du basculement"), not success)
end)

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -20, 0, 20)
infoLabel.Position = UDim2.new(0, 10, 0, 140)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Cliquez sur le bouton pour activer/désactiver le vol pour le joueur sélectionné."
infoLabel.TextColor3 = COLORS.SubText
infoLabel.TextSize = 12
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextWrapped = true
infoLabel.ZIndex = 3
infoLabel.Parent = FlyPage

-- ============================================================
-- TAB SWITCHING
-- ============================================================
local pages = {
	[TabSpawn] = SpawnPage,
	[TabEvents] = EventsPage,
	[TabRain] = RainPage,
	[TabFly] = FlyPage,
}

local function selectTab(activeBtn)
	closeAllDropdowns()
	for btn, page in pairs(pages) do
		local isActive = btn == activeBtn
		page.Visible = isActive
		btn.BackgroundColor3 = isActive and COLORS.Accent or COLORS.PanelLight
		btn.BackgroundTransparency = isActive and 0.1 or 0.3
		btn.TextColor3 = isActive and COLORS.Text or COLORS.SubText
	end

	if activeBtn == TabFly then
		local players = refreshPlayerList()
		refreshFlyPlayerOptions(players)
		if selectedFlyPlayer and not table.find(players, selectedFlyPlayer) then
			selectedFlyPlayer = nil
			flyPlayerDropdownBtn.Text = "  Choisir un joueur...  ▾"
		end
	end
end

TabSpawn.MouseButton1Click:Connect(function() selectTab(TabSpawn) end)
TabEvents.MouseButton1Click:Connect(function()
	selectTab(TabEvents)
	refreshActiveEvents()
end)
TabRain.MouseButton1Click:Connect(function() selectTab(TabRain) end)
TabFly.MouseButton1Click:Connect(function() selectTab(TabFly) end)

selectTab(TabSpawn)

-- ============================================================
-- DATA LOADING
-- ============================================================
local dataLoaded = false
local function loadData()
	if dataLoaded then return end

	local okA, animalList = pcall(function() return GetAnimalListRF:InvokeServer() end)
	if okA and type(animalList) == "table" then
		local displayOptions = {}
		for _, info in ipairs(animalList) do
			animalLookup[info.Name] = info
			table.insert(displayOptions, info.Rarity .. " — " .. info.DisplayName)
		end
		refreshAnimalOptions(displayOptions)
		print("[AdminPanelClient] Animaux chargés:", #displayOptions)
	else
		warn("[AdminPanelClient] Échec chargement liste animaux:", animalList)
	end

	local okE, eventList = pcall(function() return GetEventListRF:InvokeServer() end)
	if okE and type(eventList) == "table" then
		refreshEventOptions(eventList)
		print("[AdminPanelClient] Events chargés:", #eventList)
	else
		warn("[AdminPanelClient] Échec chargement liste events:", eventList)
	end

	dataLoaded = true
end

-- ============================================================
-- OPEN / CLOSE LOGIC
-- ============================================================
local isOpen = false

local function openPanel()
	print("[AdminPanelClient] openPanel() appelé.")
	ScreenGui.Enabled = true
	isOpen = true
	MainPanel.Size = UDim2.fromOffset(600, 470)
	MainPanel.BackgroundTransparency = 1
	local tween = TweenService:Create(MainPanel, TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Size = UDim2.fromOffset(640, 500),
		BackgroundTransparency = 0.12,
	})
	tween:Play()

	loadData()
	refreshActiveEvents()

	local players = refreshPlayerList()
	refreshFlyPlayerOptions(players)
	if selectedFlyPlayer and not table.find(players, selectedFlyPlayer) then
		selectedFlyPlayer = nil
		flyPlayerDropdownBtn.Text = "  Choisir un joueur...  ▾"
	end

	task.spawn(function()
		local ok, result = pcall(function() return CheckAdminRF:InvokeServer() end)
		if ok and result == true then
			SubtitleLabel.Text = "F3 pour ouvrir/fermer · Admin ✓"
			SubtitleLabel.TextColor3 = COLORS.Success
		else
			SubtitleLabel.Text = "F3 pour ouvrir/fermer · Accès limité (non-admin)"
			SubtitleLabel.TextColor3 = COLORS.Danger
		end
	end)
end

local function closePanel()
	print("[AdminPanelClient] closePanel() appelé.")
	isOpen = false
	closeAllDropdowns()
	ScreenGui.Enabled = false
end

local function togglePanel()
	print("[AdminPanelClient] togglePanel() -> isOpen actuel =", isOpen)
	if isOpen then
		closePanel()
	else
		openPanel()
	end
end

CloseButton.MouseButton1Click:Connect(closePanel)
Overlay.MouseButton1Click:Connect(closePanel)

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if input.KeyCode == Enum.KeyCode.F3 then
		print("[AdminPanelClient] F3 détecté.")
		togglePanel()
	end
end)

print("[AdminPanelClient] Initialisation terminée. En attente de F3.")
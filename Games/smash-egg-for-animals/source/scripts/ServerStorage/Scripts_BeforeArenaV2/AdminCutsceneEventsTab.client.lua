-- Ajoute l'onglet "Cutscene-Event" au panneau admin : des cinématiques qui lancent un event ou un mini-jeu quand elles finissent.
-- Le serveur (CutsceneEventServer) joue la cinématique puis lance l'event. Même style que l'onglet "Cutscenes" (AdminCutscenesTab).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
-- accès donné par le serveur (AdminAccessServer : attribut "IsAdmin") ; on attend s'il le reçoit plus tard
while player:GetAttribute("IsAdmin") ~= true do player:GetAttributeChangedSignal("IsAdmin"):Wait() end
local startRemote = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes"):WaitForChild("StartCutsceneEvent")

local rgb = Color3.fromRGB
local HEAVY = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local BOLD = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
local STUDS = "rbxassetid://7447638591"
-- {id serveur, titre, ce qui se passe, ce que ça lance, couleur, couleur 2}
local COMBOS = {
	{"HackerInfiltration", "Hacker Infiltration  >  HACKER ATTACK",
		"The hooded hacker breaks into the server room and hacks the system (about 35 s)... then the HACKER ATTACK event starts: every minute a hacker wave sweeps all the zones and hacks 3 eggs per zone (x5).",
		rgb(60, 255, 120), rgb(10, 40, 20)},
}
local DURATIONS = {{"5 min", 300}, {"10 min", 600}, {"20 min", 1200}}

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function label(parent, text, position, size, font, textSize, color, stroke)
	local l = new("TextLabel", {BackgroundTransparency = 1, Text = text, Position = position, Size = size, FontFace = font, TextColor3 = color, TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true, ZIndex = 4}, parent)
	if textSize then l.TextSize = textSize else l.TextScaled = true end
	if stroke then new("UIStroke", {Thickness = stroke, Color = Color3.new(0, 0, 0)}, l) end
	return l
end
local function button(parent, text, color, position, size)
	local b = new("TextButton", {Text = "", AutoButtonColor = false, BorderSizePixel = 0, BackgroundColor3 = color, Position = position, Size = size, ZIndex = 3}, parent)
	new("UIStroke", {Thickness = 3, Color = Color3.new(0, 0, 0), ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, b)
	new("ImageLabel", {BackgroundTransparency = 1, Image = STUDS, ImageTransparency = 0.2, ImageColor3 = color, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(22, 22), Size = UDim2.fromScale(1, 1), ZIndex = 3}, b)
	local t = label(b, text, UDim2.fromScale(0.06, 0.16), UDim2.fromScale(0.88, 0.68), HEAVY, nil, Color3.new(1, 1, 1), 3)
	t.TextXAlignment = Enum.TextXAlignment.Center
	t.ZIndex = 5
	return b, t
end

local function install(gui)
	local main = gui:WaitForChild("Main", 20)
	if not main then return end
	task.wait(0.5)
	local tabColumn, content
	for _, child in main:GetChildren() do
		if child:IsA("Frame") then
			local probe = child:FindFirstChild("Events")
			if probe and probe:IsA("TextButton") then tabColumn = child end
			if probe and probe:IsA("ScrollingFrame") then content = child end
		end
	end
	if not tabColumn or not content or content:FindFirstChild("CutsceneEvent") then return end
	tabColumn:WaitForChild("Cutscenes", 5) -- l'onglet "Cutscenes" d'abord : le nôtre se range juste après

	local page = new("ScrollingFrame", {Name = "CutsceneEvent", Visible = false, BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(8, 8), Size = UDim2.new(1, -16, 1, -16),
		CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 5, ScrollBarImageColor3 = Color3.new(0, 0, 0), ZIndex = 2}, content)
	new("UIListLayout", {Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder}, page)
	new("UIPadding", {PaddingTop = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 6)}, page)
	label(page, "Cutscenes that start an event or a mini-game when they end.", UDim2.new(), UDim2.new(1, 0, 0, 18), BOLD, 14, rgb(30, 26, 44)).LayoutOrder = 0
	for index, combo in COMBOS do
		local card = new("Frame", {BackgroundColor3 = rgb(244, 246, 252), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 170), LayoutOrder = index, ZIndex = 2}, page)
		new("UIStroke", {Thickness = 3, Color = Color3.new(0, 0, 0)}, card)
		local band = new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 30), ZIndex = 3}, card)
		new("UIGradient", {Color = ColorSequence.new(combo[4], combo[5])}, band)
		new("ImageLabel", {BackgroundTransparency = 1, Image = STUDS, ImageTransparency = 0.2, ImageColor3 = combo[4], ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(22, 22), Size = UDim2.fromScale(1, 1), ZIndex = 3}, band)
		new("Frame", {BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, 0, 1, 0), Size = UDim2.new(1, 0, 0, 3), ZIndex = 4}, band)
		label(band, combo[2], UDim2.fromOffset(10, 4), UDim2.new(1, -20, 1, -8), HEAVY, nil, Color3.new(1, 1, 1), 2.5)
		label(card, combo[3], UDim2.fromOffset(12, 36), UDim2.new(1, -24, 0, 46), BOLD, 13, rgb(30, 26, 44))
		-- durée de l'event
		label(card, "Event length:", UDim2.fromOffset(12, 88), UDim2.fromOffset(110, 26), HEAVY, 14, rgb(30, 26, 44))
		local chosen = 2
		local durationButtons = {}
		local function refresh()
			for i, b in durationButtons do b.BackgroundColor3 = i == chosen and rgb(255, 170, 40) or rgb(150, 154, 170) end
		end
		for i, d in DURATIONS do
			local b = button(card, d[1], rgb(150, 154, 170), UDim2.fromOffset(122 + (i - 1) * 84, 86), UDim2.fromOffset(78, 28))
			durationButtons[i] = b
			b.Activated:Connect(function() chosen = i refresh() end)
		end
		refresh()
		for i, spec in {{"Start Server", "server", rgb(60, 190, 60)}, {"Start Global", "global", rgb(50, 130, 240)}} do
			local b, text = button(card, spec[1], spec[3], UDim2.fromOffset(12 + (i - 1) * 186, 124), UDim2.fromOffset(180, 34))
			b.Activated:Connect(function()
				startRemote:FireServer(combo[1], spec[2], DURATIONS[chosen][2])
				text.Text = "Started!"
				task.delay(1.5, function() text.Text = spec[1] end)
			end)
		end
	end

	-- l'onglet : copie d'un onglet existant
	local template = tabColumn:FindFirstChild("Events")
	local tabButton = template:Clone()
	tabButton.Name = "CutsceneEvent"
	tabButton.LayoutOrder = 100
	for _, d in tabButton:GetDescendants() do
		if d:IsA("TextLabel") and d.Text == "Events" then d.Text = "Cutscene-Event" end
	end
	tabButton.Parent = tabColumn
	-- un onglet de plus : on réduit toute la colonne pour qu'ils tiennent tous (même échelle que l'onglet Cutscenes)
	local count = 0
	for _, child in tabColumn:GetChildren() do if child:IsA("TextButton") then count += 1 end end
	local scale = math.min(1, 454 / (count * 58))
	local uiScale = tabColumn:FindFirstChildOfClass("UIScale") or new("UIScale", {}, tabColumn)
	uiScale.Scale = scale
	tabColumn.Size = UDim2.fromOffset(168 / scale, 454 / scale)

	local OFF = ColorSequence.new(rgb(250, 250, 255), rgb(200, 204, 220))
	local ON = ColorSequence.new(rgb(130, 215, 255), rgb(40, 125, 245))
	local function setTab(on)
		local shade = tabButton:FindFirstChild("Shade")
		if shade then shade.Color = on and ON or OFF end
	end
	setTab(false)
	tabButton.Activated:Connect(function()
		for _, other in content:GetChildren() do
			if other:IsA("ScrollingFrame") then other.Visible = other == page end
		end
		for _, other in tabColumn:GetChildren() do
			local shade = other:IsA("TextButton") and other:FindFirstChild("Shade")
			if shade then shade.Color = OFF end
		end
		setTab(true)
	end)
	for _, other in tabColumn:GetChildren() do
		if other:IsA("TextButton") and other ~= tabButton then
			other.Activated:Connect(function() page.Visible = false setTab(false) end)
		end
	end
end

local playerGui = player:WaitForChild("PlayerGui")
playerGui.ChildAdded:Connect(function(child) if child.Name == "AdminPanelGui" then install(child) end end)
local existing = playerGui:FindFirstChild("AdminPanelGui")
if existing then install(existing) end

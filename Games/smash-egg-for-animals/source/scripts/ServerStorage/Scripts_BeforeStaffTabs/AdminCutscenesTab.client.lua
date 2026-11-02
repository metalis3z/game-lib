-- Ajoute l'onglet "Cutscenes" au panneau admin (AdminPanelClient) : toutes les cinématiques au même endroit.
-- Script séparé exprès : l'onglet ne disparaît pas quand le script du panneau est modifié ou remplacé.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
-- accès donné par le serveur (AdminAccessServer : attribut "IsAdmin") ; on attend s'il le reçoit plus tard
while player:GetAttribute("IsAdmin") ~= true do player:GetAttributeChangedSignal("IsAdmin"):Wait() end
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")

local rgb = Color3.fromRGB
local HEAVY = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local BOLD = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
local CUTSCENES = {
	{"Samurai vs The Horde", "Phone call in the forest, a purple portal opens and the Headless comes out: katana duel and a mega fireball. Then EVERYONE is pulled into the arena to fight the giant Headless (10,000 HP, bat). About 45 s + the fight.", rgb(255, 140, 40), rgb(40, 20, 60),
		function(scope) remotes:WaitForChild("StartSamuraiFilm"):FireServer(scope) end},
	{"The Hollow Reaper", "Campfire at night, kinoshi112 is dragged underground, then the katana boss fight against the giant Reaper. About 2 min.", rgb(120, 90, 200), rgb(20, 16, 40),
		function(scope) remotes:WaitForChild("StartReaperCutscene"):FireServer(scope) end},
	{"Point Zero", "The sphere, the sword and the slap. About 1 min.", rgb(140, 200, 255), rgb(110, 60, 230),
		function(scope) remotes:WaitForChild("StartPointZero"):FireServer("play", scope) end},
	{"Dev Studio", "Coffee spilled on the keyboards, PCs on fire, then the whole map. About 1 min.", rgb(255, 160, 70), rgb(210, 70, 30),
		function(scope) remotes:WaitForChild("StartCutscene"):FireServer(scope) end},
	{"Halloween Talk", "The 3 devs sit in the safe zone, drink water and agree on a Halloween update. About 35 s.", rgb(255, 150, 40), rgb(120, 40, 160),
		function(scope) remotes:WaitForChild("StartCutscene"):FireServer(scope, "safe") end},
	{"Hacker Infiltration", "A hooded hacker enters a server room, takes out his laptop, hacks the system (SYSTEM HACKED !!!!!) and leaves. About 30 s.", rgb(60, 255, 120), rgb(10, 40, 20),
		function(scope) remotes:WaitForChild("StartHackerCutscene"):FireServer(scope) end},
}

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

local function install(gui)
	local main = gui:WaitForChild("Main", 20)
	if not main then return end
	task.wait(0.5) -- laisse le panneau finir de se construire
	local tabColumn, content
	for _, child in main:GetChildren() do
		if child:IsA("Frame") then
			local probe = child:FindFirstChild("Events")
			if probe and probe:IsA("TextButton") then tabColumn = child end
			if probe and probe:IsA("ScrollingFrame") then content = child end
		end
	end
	if not tabColumn or not content or content:FindFirstChild("Cutscenes") then return end

	-- la page
	local page = new("ScrollingFrame", {Name = "Cutscenes", Visible = false, BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(8, 8), Size = UDim2.new(1, -16, 1, -16),
		CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 5, ScrollBarImageColor3 = Color3.new(0, 0, 0), ZIndex = 2}, content)
	new("UIListLayout", {Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder}, page)
	new("UIPadding", {PaddingTop = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 6)}, page)
	for index, cs in CUTSCENES do
		local card = new("Frame", {BackgroundColor3 = rgb(244, 246, 252), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 112), LayoutOrder = index, ZIndex = 2}, page)
		new("UIStroke", {Thickness = 3, Color = Color3.new(0, 0, 0)}, card)
		local band = new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 30), ZIndex = 3}, card)
		new("UIGradient", {Color = ColorSequence.new(cs[3], cs[4])}, band)
		new("ImageLabel", {BackgroundTransparency = 1, Image = "rbxassetid://7447638591", ImageTransparency = 0.2, ImageColor3 = cs[3], ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(22, 22), Size = UDim2.fromScale(1, 1), ZIndex = 3}, band)
		new("Frame", {BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, 0, 1, 0), Size = UDim2.new(1, 0, 0, 3), ZIndex = 4}, band)
		label(band, cs[1], UDim2.fromOffset(10, 4), UDim2.new(1, -20, 1, -8), HEAVY, nil, Color3.new(1, 1, 1), 2.5)
		label(card, cs[2], UDim2.fromOffset(12, 36), UDim2.new(1, -24, 0, 30), BOLD, 13, rgb(30, 26, 44))
		for i, spec in {{"Start Server", "server", rgb(60, 190, 60)}, {"Start Global", "global", rgb(50, 130, 240)}} do
			local b = new("TextButton", {Text = "", AutoButtonColor = false, BorderSizePixel = 0, BackgroundColor3 = spec[3], Position = UDim2.fromOffset(12 + (i - 1) * 186, 68), Size = UDim2.fromOffset(180, 34), ZIndex = 3}, card)
			new("UIStroke", {Thickness = 3, Color = Color3.new(0, 0, 0), ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, b)
			new("ImageLabel", {BackgroundTransparency = 1, Image = "rbxassetid://7447638591", ImageTransparency = 0.2, ImageColor3 = spec[3], ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(22, 22), Size = UDim2.fromScale(1, 1), ZIndex = 3}, b)
			local text = label(b, spec[1], UDim2.fromScale(0.06, 0.16), UDim2.fromScale(0.88, 0.68), HEAVY, nil, Color3.new(1, 1, 1), 3)
			text.TextXAlignment = Enum.TextXAlignment.Center
			text.ZIndex = 5
			b.Activated:Connect(function()
				cs[5](spec[2])
				text.Text = "Started!"
				task.delay(1.5, function() text.Text = spec[1] end)
			end)
		end
	end

	-- l'onglet : copie d'un onglet existant pour avoir exactement le même style
	local template = tabColumn:FindFirstChild("Events")
	local tabButton = template:Clone()
	tabButton.Name = "Cutscenes"
	tabButton.LayoutOrder = 99
	for _, d in tabButton:GetDescendants() do
		if d:IsA("TextLabel") and d.Text == "Events" then d.Text = "Cutscenes" end
	end
	tabButton.Parent = tabColumn
	-- un onglet de plus : on réduit un peu toute la colonne pour qu'ils tiennent tous
	local count = 0
	for _, child in tabColumn:GetChildren() do if child:IsA("TextButton") then count += 1 end end
	local scale = math.min(1, 454 / (count * 58))
	new("UIScale", {Scale = scale}, tabColumn)
	tabColumn.Size = UDim2.fromOffset(168 / scale, 454 / scale)

	local function setTab(on)
		local shade = tabButton:FindFirstChild("Shade")
		if shade then shade.Color = on and ColorSequence.new(rgb(130, 215, 255), rgb(40, 125, 245)) or ColorSequence.new(rgb(250, 250, 255), rgb(200, 204, 220)) end
	end
	setTab(false)
	tabButton.Activated:Connect(function()
		for _, other in content:GetChildren() do
			if other:IsA("ScrollingFrame") then other.Visible = other == page end
		end
		for _, other in tabColumn:GetChildren() do
			local shade = other:IsA("TextButton") and other:FindFirstChild("Shade")
			if shade then shade.Color = ColorSequence.new(rgb(250, 250, 255), rgb(200, 204, 220)) end
		end
		setTab(true)
	end)
	for _, other in tabColumn:GetChildren() do -- un autre onglet est choisi : notre page se cache
		if other:IsA("TextButton") and other ~= tabButton then
			other.Activated:Connect(function() page.Visible = false setTab(false) end)
		end
	end
end

local playerGui = player:WaitForChild("PlayerGui")
playerGui.ChildAdded:Connect(function(child) if child.Name == "AdminPanelGui" then install(child) end end)
local existing = playerGui:FindFirstChild("AdminPanelGui")
if existing then install(existing) end

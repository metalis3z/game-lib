-- Agrandissement du jardin : le panneau "UpgradeSign" de chaque base affiche le niveau et le prix ; son ProximityPrompt achète.
-- Chaque niveau allonge le jardin vers l'arrière d'une travée de clôture (une barrière de plus de chaque côté) = +1 animal posé.
-- Le niveau du joueur (attribut GardenLevel) est géré et sauvegardé par PetServer.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local CollectionService = game:GetService("CollectionService")

local eggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(eggSystem:WaitForChild("EggConfig"))
local notify = eggSystem:WaitForChild("Remotes"):WaitForChild("Notify")
local upgrade = ServerStorage:WaitForChild("GameBindables"):WaitForChild("UpgradeGarden")
local bases = workspace:WaitForChild("all base")

local MONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local STUD = "rbxassetid://7447638591"
local MAX = #Config.GardenCosts

local function baseOf(player)
	local number = player:GetAttribute("BaseNumber")
	return number and bases:FindFirstChild("base " .. number) or nil
end

---------------------------------------------------------------- géométrie
local geometry = {} -- [base] = mesures prises au niveau 0
local function measure(base)
	if geometry[base] then return geometry[base] end
	local front, back, left = base:FindFirstChild("Front"), base:FindFirstChild("Back"), base:FindFirstChild("Left")
	if not (front and back and left and base:FindFirstChild("Right")) then return nil end
	local dir = (back:GetPivot().Position - front:GetPivot().Position) * Vector3.new(1, 0, 1)
	dir = dir.Unit
	-- une travée = l'écart entre deux poteaux d'une clôture latérale
	local along = {}
	for _, part in left:GetChildren() do
		if part.Name == "Post" then table.insert(along, part.Position:Dot(dir)) end
	end
	table.sort(along)
	local step = #along >= 2 and (along[#along] - along[1]) / (#along - 1) or 13.7
	local g = {Dir = dir, Step = step, BackPivot = back:GetPivot(), Level = 0, Parts = {}}
	for _, name in {"animaux", "Floor"} do
		local part = base:FindFirstChild(name)
		if part then g.Parts[part] = {CFrame = part.CFrame, Size = part.Size} end
	end
	geometry[base] = g
	return g
end

local function resize(base, level)
	local g = measure(base)
	if not g or g.Level == level then return end
	g.Level = level
	local length = g.Step * level
	base.Back:PivotTo(g.BackPivot + g.Dir * length)
	-- le sol du jardin et la zone des animaux s'allongent
	for part, original in g.Parts do
		local axis = original.CFrame:VectorToObjectSpace(g.Dir)
		local grow = Vector3.new(math.abs(axis.X) > 0.5 and 1 or 0, math.abs(axis.Y) > 0.5 and 1 or 0, math.abs(axis.Z) > 0.5 and 1 or 0)
		part.Size = original.Size + grow * length
		part.CFrame = original.CFrame + g.Dir * length / 2
	end
	-- une travée de clôture de plus de chaque côté par niveau
	local extension = base:FindFirstChild("GardenExtension")
	if extension then extension:Destroy() end
	if level == 0 then return end
	extension = Instance.new("Folder")
	extension.Name = "GardenExtension"
	local backAlong = g.BackPivot.Position:Dot(g.Dir)
	for _, sideName in {"Left", "Right"} do
		local rails, post = {}, nil
		for _, part in base[sideName]:GetChildren() do
			if part.Name == "Rail" then table.insert(rails, part) elseif part.Name == "Post" then post = part end
		end
		for i = 1, level do
			for _, rail in rails do
				local copy = rail:Clone()
				local size = rail.Size
				local longest = math.max(size.X, size.Y, size.Z)
				copy.Size = Vector3.new(size.X == longest and g.Step or size.X, size.Y == longest and g.Step or size.Y, size.Z == longest and g.Step or size.Z)
				local position = rail.Position + g.Dir * (backAlong + (i - 0.5) * g.Step - rail.Position:Dot(g.Dir))
				copy.CFrame = CFrame.new(position) * rail.CFrame.Rotation
				copy.Parent = extension
			end
			if post then
				local copy = post:Clone()
				copy.Position = post.Position + g.Dir * (backAlong + (i - 1) * g.Step - post.Position:Dot(g.Dir))
				copy.Parent = extension
			end
		end
	end
	extension.Parent = base
end

---------------------------------------------------------------- panneau
local signs = {} -- [base] = {labels des deux faces}
local function label(parent, name, text, position, size, color, thickness)
	local l = Instance.new("TextLabel")
	l.Name = name
	l.BackgroundTransparency = 1
	l.Position, l.Size = position, size
	l.FontFace = MONT
	l.Text = text
	l.TextScaled = true
	l.TextColor3 = color
	l.ZIndex = 3
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = thickness
	stroke.Parent = l
	CollectionService:AddTag(l, "Text3D") -- texte en relief (script client Text3D)
	l.Parent = parent
	return l
end

local function buildSign(base)
	local sign = base:FindFirstChild("UpgradeSign")
	local display = sign and sign:FindFirstChild("Display")
	if not display then return end
	local thin = math.min(display.Size.X, display.Size.Z)
	local faces = display.Size.X == thin and {Enum.NormalId.Right, Enum.NormalId.Left} or {Enum.NormalId.Front, Enum.NormalId.Back}
	local entries = {}
	for _, face in faces do
		local gui = Instance.new("SurfaceGui")
		gui.Name = "GardenSign"
		gui.Face = face
		gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
		gui.PixelsPerStud = 50
		gui.LightInfluence = 0
		local frame = Instance.new("Frame")
		frame.Size = UDim2.fromScale(1, 1)
		frame.BackgroundColor3 = Color3.new(1, 1, 1)
		frame.BorderSizePixel = 0
		local gradient = Instance.new("UIGradient")
		gradient.Rotation = 90
		gradient.Color = ColorSequence.new(Color3.fromRGB(130, 235, 90), Color3.fromRGB(40, 160, 60))
		gradient.Parent = frame
		local studs = Instance.new("ImageLabel")
		studs.BackgroundTransparency = 1
		studs.Size = UDim2.fromScale(1, 1)
		studs.Image = STUD
		studs.ScaleType = Enum.ScaleType.Tile
		studs.TileSize = UDim2.fromOffset(44, 44)
		studs.ImageTransparency = 0.2
		studs.ImageColor3 = Color3.fromRGB(90, 200, 80)
		studs.Parent = frame
		local border = Instance.new("UIStroke")
		border.Thickness = 8
		border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		border.Parent = frame
		local inset = Instance.new("Frame") -- la bordure reste dans la face
		inset.BackgroundTransparency = 1
		inset.Position = UDim2.fromOffset(10, 10)
		inset.Size = UDim2.new(1, -20, 1, -20)
		inset.Parent = frame
		local entry = {
			Title = label(inset, "Title", "GARDEN", UDim2.fromScale(0.05, 0.03), UDim2.fromScale(0.9, 0.24), Color3.new(1, 1, 1), 5),
			Level = label(inset, "Level", "Level 0/" .. MAX, UDim2.fromScale(0.1, 0.28), UDim2.fromScale(0.8, 0.16), Color3.fromRGB(255, 235, 110), 4),
			Slots = label(inset, "Slots", "5 pets", UDim2.fromScale(0.1, 0.45), UDim2.fromScale(0.8, 0.13), Color3.new(1, 1, 1), 3.5),
			Price = label(inset, "Price", "$1K", UDim2.fromScale(0.05, 0.6), UDim2.fromScale(0.9, 0.25), Color3.fromRGB(150, 255, 130), 5),
			Hint = label(inset, "Hint", "+1 pet slot", UDim2.fromScale(0.1, 0.86), UDim2.fromScale(0.8, 0.11), Color3.new(1, 1, 1), 3),
		}
		frame.Parent = gui
		gui.Parent = display
		table.insert(entries, entry)
	end
	signs[base] = entries
	local prompt = Instance.new("ProximityPrompt")
	prompt.Name = "UpgradeGardenPrompt"
	prompt.ActionText = "Upgrade"
	prompt.ObjectText = "Garden"
	prompt.HoldDuration = 0.4
	prompt.MaxActivationDistance = 14
	prompt.RequiresLineOfSight = false
	prompt.Parent = display
	prompt.Triggered:Connect(function(player)
		if baseOf(player) ~= base then
			notify:FireClient(player, "This is not your garden!")
			return
		end
		upgrade:Invoke(player)
	end)
end

local function refresh(base, owner)
	if not base then return end
	local level = owner and (owner:GetAttribute("GardenLevel") or 0) or 0
	resize(base, level)
	local cost = Config.GardenCosts[level + 1]
	for _, entry in signs[base] or {} do
		entry.Level.Text = "Level " .. level .. "/" .. MAX
		entry.Slots.Text = ((Config.BasePlaced or 5) + level) .. " pets"
		entry.Price.Text = cost and Config.FormatMoney(cost) or "MAX"
		entry.Hint.Text = cost and "+1 pet slot" or "Biggest garden!"
	end
end

for _, base in bases:GetChildren() do
	if base:IsA("Model") or base:IsA("Folder") then
		buildSign(base)
		refresh(base, nil)
	end
end

local function onPlayer(player)
	local current
	local function update()
		local base = baseOf(player)
		if current and current ~= base then refresh(current, nil) end
		current = base
		refresh(base, player)
	end
	player:GetAttributeChangedSignal("BaseNumber"):Connect(update)
	player:GetAttributeChangedSignal("GardenLevel"):Connect(update)
	update()
end
Players.PlayerAdded:Connect(onPlayer)
for _, player in Players:GetPlayers() do onPlayer(player) end
Players.PlayerRemoving:Connect(function(player)
	refresh(baseOf(player), nil) -- la base redevient un jardin de départ
end)

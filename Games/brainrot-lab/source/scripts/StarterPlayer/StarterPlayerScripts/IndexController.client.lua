--!strict
-- LOCATION: StarterPlayerScripts/IndexController

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
local RarityConfigurations = require(ReplicatedStorage.Modules.RarityConfigurations)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Assets
local Events = ReplicatedStorage:WaitForChild("Events")
local ItemsFolder = ReplicatedStorage:WaitForChild("Items"):WaitForChild("Normal")

-- UI References
local mainGui = playerGui:WaitForChild("GUI")
local frames = mainGui:WaitForChild("Frames")
local indexFrame = frames:WaitForChild("Index")
local frameFolder = indexFrame:WaitForChild("Frame")
local buttonsFolder = indexFrame:WaitForChild("Buttons")

-- Mutation tabs (must match the new index buttons & item textures)
local MUTATION_COLORS = {
	Normal = Color3.fromRGB(255, 255, 255),
	Gold = Color3.fromRGB(255, 200, 0),
	Diamond = Color3.fromRGB(150, 210, 255),
	Rainbow = Color3.fromRGB(255, 120, 220),
	Lava = Color3.fromRGB(255, 90, 0),
	Galaxy = Color3.fromRGB(160, 90, 255),
}

-- State
local currentMutation = "Normal"
local discoveredCache = {}
local searchQuery = ""

local GetIndexDataFunction = Events:WaitForChild("GetIndexData", 10)

-- [ VIEWPORT: Render a 3D brainrot inside a card ]
local function setupViewport(card: Frame, itemName: string, mutation: string, isUnlocked: boolean)
	local viewport = card:FindFirstChild("Viewport")
	if not viewport or not viewport:IsA("ViewportFrame") then return end

	local itemFolder = ItemsFolder:FindFirstChild(itemName)
	if not itemFolder then return end

	local modelTemplate = itemFolder:FindFirstChild("Model")
	if not modelTemplate then return end

	local model = modelTemplate:Clone()
	model.Parent = viewport

	-- Anchor everything so it stays put inside the viewport
	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = true
			part.CanCollide = false
		end
	end

	-- Apply the mutation texture to the brainrot mesh
	local textures = itemFolder:FindFirstChild("Textures")
	local brainrot = model:FindFirstChild("Brainrot")
	local mesh = brainrot and brainrot:FindFirstChild("Mesh")
	if mesh and mesh:IsA("MeshPart") and textures then
		local tex = textures:FindFirstChild(mutation)
		if tex then
			if tex:IsA("StringValue") and tex.Value ~= "" then
				mesh.TextureID = tex.Value
			elseif tex:IsA("SurfaceAppearance") then
				-- Replace any existing surface appearance with the mutation one
				for _, sa in ipairs(mesh:GetChildren()) do
					if sa:IsA("SurfaceAppearance") then sa:Destroy() end
				end
				tex:Clone().Parent = mesh
			end
		end
	end

	-- Dark silhouette for unowned items
	if not isUnlocked then
		for _, part in ipairs(model:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Color = Color3.new(0.1, 0.1, 0.1)
				part.Material = Enum.Material.Plastic
				if part:IsA("MeshPart") then
					part.TextureID = ""
					for _, sa in ipairs(part:GetChildren()) do
						if sa:IsA("SurfaceAppearance") then sa:Destroy() end
					end
				end
			end
		end
	end

	-- Camera to frame the model
	local camera = Instance.new("Camera")
	camera.Parent = viewport
	viewport.CurrentCamera = camera

	local cf, size = model:GetBoundingBox()
	local maxDim = math.max(size.X, size.Y, size.Z)
	local distance = maxDim * 1.9
	camera.CFrame = CFrame.lookAt(cf.Position + Vector3.new(0, 0, distance), cf.Position)

	-- Spin the model continuously around its own Y axis
	task.spawn(function()
		local spinSpeed = 0.03 -- radians per tick (very slow spin)
		while model and model.Parent do
			local pivot = model:GetPivot()
			model:PivotTo(pivot * CFrame.Angles(0, spinSpeed, 0))
			task.wait()
		end
	end)
end

-- [ HELPER: Apply rarity styling ]
local function applyRarityStyle(label: TextLabel, rarityName: string)
	local rc = RarityConfigurations[rarityName]
	if not rc then return end
	label.TextColor3 = rc.TextColor
	local stroke = label:FindFirstChildOfClass("UIStroke")
	if stroke then stroke.Color = rc.StrokeColor end
end

-- [ RENDER ]
local function RenderList()
	local currentScrolling = frameFolder:FindFirstChild(currentMutation)
	if not currentScrolling then return end

	-- Show only the active tab
	for _, sf in ipairs(frameFolder:GetChildren()) do
		if sf:IsA("ScrollingFrame") then sf.Visible = false end
	end
	currentScrolling.Visible = true

	-- Clear old cards (keep the Template)
	for _, child in ipairs(currentScrolling:GetChildren()) do
		if child:IsA("Frame") and child.Name ~= "Template" then
			child:Destroy()
		end
	end

	local template = currentScrolling:FindFirstChild("Template") or frameFolder.Normal:FindFirstChild("Template")
	if not template then return end

	-- Prepare & sort items
	local itemsToShow = {}
	for itemName, data in pairs(ItemConfigurations.Items) do
		if searchQuery == "" or string.find(string.lower(itemName), string.lower(searchQuery), 1, true) then
			table.insert(itemsToShow, { Name = itemName, Data = data })
		end
	end
	table.sort(itemsToShow, function(a, b)
		local incomeA = a.Data.Income or 0
		local incomeB = b.Data.Income or 0
		if incomeA == incomeB then return a.Name < b.Name end
		return incomeA < incomeB
	end)

	-- Populate
	local unlockedCount = 0
	for _, entry in ipairs(itemsToShow) do
		local itemName = entry.Name
		local itemData = entry.Data
		local key = currentMutation .. "_" .. itemName
		local isUnlocked = discoveredCache[key] == true
		if isUnlocked then unlockedCount += 1 end

		local card = template:Clone()
		card.Name = itemName
		card.Parent = currentScrolling
		card.Visible = true

		local nameLabel = card:FindFirstChild("Name", true)
		if nameLabel and nameLabel:IsA("TextLabel") then
			nameLabel.Text = isUnlocked and itemName or "???"
		end

		local rarityLabel = card:FindFirstChild("Rarity", true)
		if rarityLabel and rarityLabel:IsA("TextLabel") then
			rarityLabel.Text = itemData.Rarity
			applyRarityStyle(rarityLabel, itemData.Rarity)
		end

		local mutationLabel = card:FindFirstChild("Mutation", true)
		if mutationLabel and mutationLabel:IsA("TextLabel") then
			mutationLabel.Text = currentMutation
			mutationLabel.TextColor3 = MUTATION_COLORS[currentMutation] or Color3.new(1, 1, 1)
		end

		setupViewport(card, itemName, currentMutation, isUnlocked)
	end

	-- Update the unlocked counter in the Top bar
	local topFrame = indexFrame:FindFirstChild("Top", true)
	local mainFrame = topFrame and topFrame:FindFirstChild("Main", true)
	local unlockedLabel = mainFrame and mainFrame:FindFirstChild("Unlocked", true)
	if unlockedLabel and unlockedLabel:IsA("TextLabel") then
		unlockedLabel.Text = tostring(unlockedCount) .. " / " .. tostring(#itemsToShow)
	end
end

-- [ DATA FETCHING ]
local function UpdateIndexUI(forceFetch: boolean)
	RenderList()
	if GetIndexDataFunction and (forceFetch or not next(discoveredCache)) then
		task.spawn(function()
			local success, data = pcall(function()
				return GetIndexDataFunction:InvokeServer()
			end)
			if success and data then
				discoveredCache = data
				RenderList()
			else
				warn("[IndexController] Failed to fetch data.")
			end
		end)
	end
end

-- [ BUTTONS ]
local function updateButtonVisuals()
	for _, btn in ipairs(buttonsFolder:GetChildren()) do
		if btn:IsA("GuiButton") then
			if btn.Name == currentMutation then
				btn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
			else
				btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			end
		end
	end
end

local function setupTabButtons()
	for _, btn in ipairs(buttonsFolder:GetChildren()) do
		if btn:IsA("GuiButton") then
			btn.MouseButton1Click:Connect(function()
				currentMutation = btn.Name
				updateButtonVisuals()
				RenderList()
			end)
		end
	end
	updateButtonVisuals()
end

-- [ SEARCH ]
local searchFrame = indexFrame:FindFirstChild("Search", true)
local searchBox = searchFrame and searchFrame:FindFirstChild("Box", true)
if searchBox and searchBox:IsA("TextBox") then
	searchBox:GetPropertyChangedSignal("Text"):Connect(function()
		searchQuery = searchBox.Text
		RenderList()
	end)
end

-- [ INIT ]
setupTabButtons()

local refreshEvent = Events:FindFirstChild("RefreshIndex")
if refreshEvent then
	refreshEvent.OnClientEvent:Connect(function()
		UpdateIndexUI(true)
	end)
end

UpdateIndexUI(true)
print("[IndexController] Loaded (3D Index)")
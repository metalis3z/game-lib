--!strict
-- LOCATION: ServerScriptService/Modules/ItemManager

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")

-- [ MODULES ]
local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
local RarityConfigurations = require(ReplicatedStorage.Modules.RarityConfigurations)
local MutationConfigurations = require(ReplicatedStorage.Modules.MutationConfigurations)
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)

-- [ LAZY DEPENDENCIES ]
local CarrySystem 

-- [ ASSETS ]
local ItemsFolder = ReplicatedStorage:WaitForChild("Items")
local SpawnersFolder = Workspace:WaitForChild("ItemSpawners")
local Templates = ReplicatedStorage:WaitForChild("Templates")
local InfoGUI_Template = Templates:WaitForChild("InfoGUI")

-- [ CONFIGURATION ]
local ITEMS_PER_SPAWNER = 6
local MAX_RETRIES = 50 
local OVERLAP_PADDING = 1.5
local MIN_ITEM_RADIUS = 2
local INCOME_SCALING = 1.125 

-- ## RECYCLING CONFIG ##
local RECYCLE_MIN_TIME = 30
local RECYCLE_MAX_TIME = 90

local MUTATIONS = {
	{Name = "Neon", Chance = 100},
	{Name = "Ruby", Chance = 50},
	{Name = "Diamond", Chance = 25},
	{Name = "Golden", Chance = 10},
}

local MUTATION_MULTIPLIERS = {
	["Normal"] = 1,
	["Golden"] = 2,
	["Diamond"] = 3,
	["Ruby"] = 4,
	["Neon"] = 5,
}

local ItemManager = {}

-- [ HELPERS ]

local function getMutation(): string
	for _, mutation in ipairs(MUTATIONS) do
		local roll = math.random(1, mutation.Chance)
		if roll == 1 then return mutation.Name end
	end
	return "Normal"
end

local function getItemRadius(model: Model): number
	local size = model:GetExtentsSize()
	local maxSide = math.max(size.X, size.Z)
	return math.max(maxSide / 2, MIN_ITEM_RADIUS)
end

-- [ VISUALS & GUI ]

local function setupItemGUI(target: Instance, level: number?)
	local rootPart: BasePart?

	if target:IsA("Model") then
		if not target.PrimaryPart then
			local found = target:FindFirstChild("Handle") or target:FindFirstChildWhichIsA("BasePart")
			if found then target.PrimaryPart = found else return end
		end
		rootPart = target.PrimaryPart
	elseif target:IsA("Tool") then
		rootPart = target:FindFirstChild("Handle") :: BasePart
	end

	if not rootPart then return end

	if target:FindFirstChild("InfoGUI") then target.InfoGUI:Destroy() end

	local infoGui = InfoGUI_Template:Clone()
	infoGui.Name = "InfoGUI"
	local labelsFrame = infoGui:WaitForChild("TextLabels")

	local lblEarnings = labelsFrame:WaitForChild("Earnings") :: TextLabel
	local lblRarity = labelsFrame:WaitForChild("Rarity") :: TextLabel
	local lblName = labelsFrame:WaitForChild("Name") :: TextLabel
	local lblMutation = labelsFrame:WaitForChild("Mutation") :: TextLabel

	local lblTimer = labelsFrame:FindFirstChild("Timer") :: TextLabel
	if lblTimer then
		if target:GetAttribute("IsSpawnedItem") == true then
			lblTimer.Visible = true
			lblTimer.Text = "--:--"
		else
			lblTimer.Visible = false
		end
	end

	local itemName = target:GetAttribute("OriginalName") :: string
	local rarityName = target:GetAttribute("Rarity") :: string
	local mutationName = target:GetAttribute("Mutation") :: string

	lblName.Text = itemName

	local itemData = ItemConfigurations.GetItemData(itemName)
	local baseIncome = itemData and itemData.Income or 0
	local mutationMult = MUTATION_MULTIPLIERS[mutationName] or 1
	local currentLevel = level or 1

	local totalIncome = baseIncome * mutationMult * (INCOME_SCALING ^ (currentLevel - 1))

	lblEarnings.Text = "+" .. NumberFormatter.Format(totalIncome) .. "/s"

	local rarityConfig = RarityConfigurations[rarityName]
	if rarityConfig then
		lblRarity.Text = rarityConfig.DisplayName
		lblRarity.TextColor3 = rarityConfig.TextColor
		local s = lblRarity:FindFirstChild("Stroke") :: UIStroke; if s then s.Color = rarityConfig.StrokeColor; s.Thickness = rarityConfig.StrokeThickness end
		local g = lblRarity:FindFirstChild("Gradient") :: UIGradient; if g then g.Enabled = (rarityConfig.GradientColor ~= nil); if g.Enabled then g.Color = rarityConfig.GradientColor end end
	end

	local mutationConfig = MutationConfigurations[mutationName]
	if mutationConfig then
		lblMutation.Text = mutationConfig.DisplayName
		lblMutation.TextColor3 = mutationConfig.TextColor
		local s = lblMutation:FindFirstChild("Stroke") :: UIStroke; if s then s.Color = mutationConfig.StrokeColor; s.Thickness = mutationConfig.StrokeThickness end
		local g = lblMutation:FindFirstChild("Gradient") :: UIGradient; if g then g.Enabled = (mutationConfig.GradientColor ~= nil); if g.Enabled then g.Color = mutationConfig.GradientColor end end
	end

	infoGui.Adornee = rootPart
	infoGui.Parent = target
end

-- [ TOOL CREATION ]

function ItemManager.GiveItemToPlayer(player: Player, itemName: string, mutation: string, rarity: string, level: number?)
	local mutationFolder = ItemsFolder:FindFirstChild(mutation)
	if not mutationFolder then mutationFolder = ItemsFolder:FindFirstChild("Normal") end

	local itemTemplate = mutationFolder and mutationFolder:FindFirstChild(itemName)
	if not itemTemplate and mutation ~= "Normal" then
		local normalFolder = ItemsFolder:FindFirstChild("Normal")
		itemTemplate = normalFolder and normalFolder:FindFirstChild(itemName)
	end

	if not itemTemplate then return end

	local newTool = Instance.new("Tool")
	if mutation ~= "Normal" then
		newTool.Name = mutation .. " " .. itemName
	else
		newTool.Name = itemName
	end

	local actualLevel = level or 1

	newTool:SetAttribute("OriginalName", itemName)
	newTool:SetAttribute("Mutation", mutation)
	newTool:SetAttribute("Rarity", rarity)
	newTool:SetAttribute("Level", actualLevel) 

	-- ## FIX: Prevent Dropping to reduce clutter ##
	newTool.CanBeDropped = false

	local cloneModel = itemTemplate:Clone() :: Model
	newTool.Grip = CFrame.Angles(0, math.rad(180), 0)

	local handle = cloneModel.PrimaryPart or cloneModel:FindFirstChildWhichIsA("BasePart")
	if not handle then
		handle = Instance.new("Part"); handle.Size = Vector3.new(1,1,1); handle.Transparency = 1; handle.Parent = cloneModel
	end
	handle.Name = "Handle"

	for _, part in ipairs(cloneModel:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Massless = true; part.CanCollide = false; part.Anchored = false
			if part ~= handle then
				local weld = Instance.new("WeldConstraint"); weld.Part0 = handle; weld.Part1 = part; weld.Parent = handle
			end
		end
	end

	for _, child in ipairs(cloneModel:GetChildren()) do child.Parent = newTool end

	-- [DISCOVERY LOGIC]
	local PlayerController = require(ServerScriptService.Controllers.PlayerController)
	local profile = PlayerController:GetProfile(player)

	if profile then
		local key = mutation .. "_" .. itemName

		if not profile.Data.DiscoveredItems then
			profile.Data.DiscoveredItems = {}
		end

		if not profile.Data.DiscoveredItems[key] then
			profile.Data.DiscoveredItems[key] = true
			local Events = ReplicatedStorage:FindFirstChild("Events")
			local refresh = Events and Events:FindFirstChild("RefreshIndex")
			if refresh then refresh:FireClient(player) end
		end
	end

	setupItemGUI(newTool, actualLevel)
	newTool.Parent = player:WaitForChild("Backpack")
end

-- [ PICKUP LOGIC ] -----------------------------------------------------------

local function onItemPickedUp(player: Player, itemModel: Model)
	if not CarrySystem then
		CarrySystem = require(ServerScriptService.Modules.CarrySystem)
	end

	if not itemModel or not itemModel.Parent then return end
	local name = itemModel:GetAttribute("OriginalName")
	local mutation = itemModel:GetAttribute("Mutation")
	local rarity = itemModel:GetAttribute("Rarity")
	local level = itemModel:GetAttribute("Level") or 1 

	if name and mutation and rarity then

		if CarrySystem.IsPlayerInZone(player) then
			-- Player is in the Collection Zone
			if CarrySystem.CanCarryMore(player) then
				local success = CarrySystem.AddItemToCarry(player, name, mutation, rarity)
				if success then
					itemModel:Destroy() -- Destroy world model, added to virtual inventory
				end
			else
				local Events = ReplicatedStorage:FindFirstChild("Events")
				local notif = Events and Events:FindFirstChild("ShowNotification")
				if notif then 
					notif:FireClient(player, "Carry limit reached!", "Error") 
				end
			end
		else
			-- Player is OUTSIDE zone
			ItemManager.GiveItemToPlayer(player, name, mutation, rarity, level)
			itemModel:Destroy()
		end
	end
end

-- [ SPAWNING LOGIC ]

function ItemManager.SpawnVisualItem(parentPart: BasePart, itemName: string, mutation: string, rarity: string, level: number)
	local mutationFolder = ItemsFolder:FindFirstChild(mutation) or ItemsFolder:FindFirstChild("Normal")
	local itemTemplate = mutationFolder and mutationFolder:FindFirstChild(itemName)

	if not itemTemplate and mutation ~= "Normal" then
		itemTemplate = ItemsFolder.Normal:FindFirstChild(itemName)
	end

	if not itemTemplate then return end

	local model = itemTemplate:Clone() :: Model
	model.Name = "VisualItem"
	model:SetAttribute("OriginalName", itemName)
	model:SetAttribute("Mutation", mutation)
	model:SetAttribute("Rarity", rarity)
	model:SetAttribute("Level", level)

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = true; part.CanCollide = false
		end
	end

	local extents = model:GetExtentsSize()
	local offset = Vector3.new(0, extents.Y/2, 0)
	model:PivotTo(parentPart.CFrame + offset)
	model.Parent = parentPart

	setupItemGUI(model, level)
end

function ItemManager.SpawnForPart(spawnerPart: BasePart)
	local rarityCategory = spawnerPart.Name
	local possibleItems = ItemConfigurations.GetItemsByRarity(rarityCategory)
	if #possibleItems == 0 then return end

	local existingPositions = {}
	local currentItemCount = 0

	for _, child in ipairs(spawnerPart:GetChildren()) do
		if child:GetAttribute("IsSpawnedItem") == true and child:IsA("Model") then
			currentItemCount += 1
			local origin = child:GetPivot().Position
			table.insert(existingPositions, {Pos = origin, Radius = getItemRadius(child)})
		end
	end

	local itemsToSpawn = ITEMS_PER_SPAWNER - currentItemCount
	if itemsToSpawn <= 0 then return end

	local spawnerSize = spawnerPart.Size
	local spawnerCFrame = spawnerPart.CFrame

	for i = 1, itemsToSpawn do
		local randomItemName = possibleItems[math.random(1, #possibleItems)]
		local mutationName = getMutation()
		local mutationFolder = ItemsFolder:FindFirstChild(mutationName)
		if not mutationFolder then continue end
		local itemTemplate = mutationFolder:FindFirstChild(randomItemName)
		if not itemTemplate and mutationName ~= "Normal" then
			local normalFolder = ItemsFolder:FindFirstChild("Normal")
			if normalFolder then itemTemplate = normalFolder:FindFirstChild(randomItemName) end
		end
		if not itemTemplate then continue end

		local tempTemplate = itemTemplate:Clone() :: Model
		local newItemRadius = getItemRadius(tempTemplate)
		local itemExtents = tempTemplate:GetExtentsSize()
		local distToBottom = tempTemplate:GetPivot().Position.Y - (tempTemplate:GetBoundingBox().Position.Y - (itemExtents.Y / 2))
		tempTemplate:Destroy()

		local success = false
		local finalCFrame: CFrame? = nil
		local attempts = 0

		while not success and attempts < MAX_RETRIES do
			attempts += 1
			local xLimit = (spawnerSize.X / 2) - newItemRadius
			local zLimit = (spawnerSize.Z / 2) - newItemRadius
			local randX = math.random(-xLimit * 10, xLimit * 10) / 10
			local randZ = math.random(-zLimit * 10, zLimit * 10) / 10
			local topSurfaceY = (spawnerSize.Y / 2)
			local testPos = spawnerCFrame:PointToWorldSpace(Vector3.new(randX, topSurfaceY, randZ))

			local overlapping = false
			for _, entry in ipairs(existingPositions) do
				local flatDistance = (Vector3.new(testPos.X, 0, testPos.Z) - Vector3.new(entry.Pos.X, 0, entry.Pos.Z)).Magnitude
				if flatDistance < (newItemRadius + entry.Radius + OVERLAP_PADDING) then
					overlapping = true; break
				end
			end

			if not overlapping then
				local randomRot = CFrame.Angles(0, math.rad(math.random(0, 360)), 0)
				finalCFrame = CFrame.new(testPos) * spawnerCFrame.Rotation * randomRot
				success = true
			end
		end

		if success and finalCFrame then
			local newItem = itemTemplate:Clone() :: Model
			newItem.Name = "SpawnedItem"
			newItem:SetAttribute("IsSpawnedItem", true)
			newItem:SetAttribute("OriginalName", randomItemName)
			newItem:SetAttribute("Rarity", rarityCategory)
			newItem:SetAttribute("Mutation", mutationName)
			newItem:SetAttribute("Level", 1) 
			newItem.Parent = spawnerPart

			local pivotAdjustment = Vector3.new(0, distToBottom, 0)
			newItem:PivotTo(finalCFrame + pivotAdjustment)

			table.insert(existingPositions, {Pos = finalCFrame.Position, Radius = newItemRadius})

			setupItemGUI(newItem, 1)

			local lifeTime = math.random(RECYCLE_MIN_TIME, RECYCLE_MAX_TIME)
			local expiresAt = Workspace:GetServerTimeNow() + lifeTime
			newItem:SetAttribute("ExpiresAt", expiresAt)

			task.delay(lifeTime, function()
				if newItem and newItem.Parent then
					newItem:Destroy()
					ItemManager.SpawnForPart(spawnerPart)
				end
			end)

			if newItem.PrimaryPart then
				local prompt = Instance.new("ProximityPrompt")
				prompt.ObjectText = randomItemName
				prompt.ActionText = "Pick Up"
				prompt.KeyboardKeyCode = Enum.KeyCode.E
				prompt.RequiresLineOfSight = false 
				prompt.HoldDuration = 0
				prompt.MaxActivationDistance = 8
				prompt.Style = Enum.ProximityPromptStyle.Custom
				prompt.Parent = newItem.PrimaryPart

				prompt.Triggered:Connect(function(player)
					onItemPickedUp(player, newItem)
				end)
			end
		end
	end
end

function ItemManager.SpawnAllItems()
	for _, spawner in ipairs(SpawnersFolder:GetChildren()) do
		if spawner:IsA("BasePart") then
			ItemManager.SpawnForPart(spawner)
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	ItemManager.SpawnAllItems()
end)

return ItemManager
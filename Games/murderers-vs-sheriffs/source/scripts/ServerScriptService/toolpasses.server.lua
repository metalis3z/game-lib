local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local toolpasses = {
	SpeedCoil = {
		gamePassId = 1951035080,
		npcName = "SpeedCoil",
		promptName = "Speed Coil",
	},
	GravityCoil = {
		gamePassId = 1949007070,
		npcName = "GravityCoil",
		promptName = "Gravity Coil",
	},
	SuperCoil = {
		gamePassId = 1947543117,
		npcName = "SuperCoil",
		promptName = "Super Coil",
	},
	Jetpack = {
		gamePassId = 1947999038,
		npcName = "Jetpack",
		promptName = "Jetpack",
	},
}

local passToTool = {}
for toolName, info in pairs(toolpasses) do
	passToTool[info.gamePassId] = toolName
end

local templates = ServerStorage:WaitForChild("ToolTemplates")
local toolNPCS = workspace:WaitForChild("Lobby"):WaitForChild("ToolNPCS")
local hookedPrompts = setmetatable({}, { __mode = "k" })
local watchedContainers = setmetatable({}, { __mode = "k" })

local signals = ReplicatedStorage:FindFirstChild("Signals")
if not signals then
	signals = Instance.new("Folder")
	signals.Name = "Signals"
	signals.Parent = ReplicatedStorage
end

local remoteEvents = signals:FindFirstChild("RemoteEvents")
if not remoteEvents then
	remoteEvents = Instance.new("Folder")
	remoteEvents.Name = "RemoteEvents"
	remoteEvents.Parent = signals
end

if not remoteEvents:FindFirstChild("JetpackControl") then
	local remote = Instance.new("RemoteEvent")
	remote.Name = "JetpackControl"
	remote.Parent = remoteEvents
end

local function getProductsFolder(player)
	local products = player:FindFirstChild("Products")
	if not products then
		products = Instance.new("Folder")
		products.Name = "Products"
		products.Parent = player
	end
	return products
end

local function getProductValue(player, toolName)
	local products = getProductsFolder(player)
	local value = products:FindFirstChild(toolName)
	if not value then
		value = Instance.new("BoolValue")
		value.Name = toolName
		value.Value = false
		value.Parent = products
	end
	return value
end

local function ownsStoredTool(player, toolName)
	local products = player:FindFirstChild("Products")
	local value = products and products:FindFirstChild(toolName)
	return value and value:IsA("BoolValue") and value.Value == true
end

local function ownsGamePass(player, gamePassId)
	local ok, result = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePassId)
	end)
	if not ok then
		warn(("[toolpasses] Could not check pass %d for %s: %s"):format(gamePassId, player.Name, tostring(result)))
		return false
	end
	return result == true
end

local function isPermanentTool(instance, toolName)
	return instance:IsA("Tool")
		and instance.Name == toolName
		and instance:GetAttribute("TemporarySpinReward") ~= true
end

local function collectTools(container, toolName, output)
	if not container then
		return output
	end
	for _, child in ipairs(container:GetChildren()) do
		if isPermanentTool(child, toolName) then
			table.insert(output, child)
		end
	end
	return output
end

local function destroyExtras(tools, keep)
	for _, tool in ipairs(tools) do
		if tool ~= keep and tool.Parent then
			tool:Destroy()
		end
	end
end

local function cloneTool(container, toolName)
	if not container then
		return nil
	end
	local template = templates:FindFirstChild(toolName)
	if not template or not template:IsA("Tool") then
		warn("[toolpasses] Missing tool template:", toolName)
		return nil
	end
	local clone = template:Clone()
	clone.CanBeDropped = false
	clone:SetAttribute("GamepassTool", true)
	clone.Parent = container
	return clone
end

local function normalizeTool(player, toolName)
	if not player or not player.Parent or not toolpasses[toolName] then
		return
	end

	local backpack = player:FindFirstChildOfClass("Backpack")
	local starterGear = player:FindFirstChild("StarterGear")
	local character = player.Character
	local owned = ownsStoredTool(player, toolName)

	local activeTools = {}
	collectTools(character, toolName, activeTools)
	collectTools(backpack, toolName, activeTools)

	local starterTools = {}
	collectTools(starterGear, toolName, starterTools)

	if not owned then
		destroyExtras(activeTools, nil)
		destroyExtras(starterTools, nil)
		return
	end

	local activeKeep = activeTools[1]
	if not activeKeep then
		activeKeep = cloneTool(backpack, toolName)
	end
	destroyExtras(activeTools, activeKeep)

	local starterKeep = starterTools[1]
	if not starterKeep then
		starterKeep = cloneTool(starterGear, toolName)
	end
	destroyExtras(starterTools, starterKeep)
end

local function normalizeAllTools(player)
	for toolName in pairs(toolpasses) do
		normalizeTool(player, toolName)
	end
end

local function setOwned(player, toolName, owned)
	local value = getProductValue(player, toolName)
	if value.Value ~= owned then
		value.Value = owned
	end
	normalizeTool(player, toolName)
end

local function syncToolOwnership(player, toolName)
	local info = toolpasses[toolName]
	if not info then
		return
	end
	setOwned(player, toolName, ownsGamePass(player, info.gamePassId))
end

local function syncAllOwnership(player)
	getProductsFolder(player)
	for toolName in pairs(toolpasses) do
		task.spawn(syncToolOwnership, player, toolName)
	end
end

local function watchContainer(player, container)
	if not container or watchedContainers[container] then
		return
	end
	watchedContainers[container] = true
	container.ChildAdded:Connect(function(child)
		if child:IsA("Tool") and toolpasses[child.Name] and child:GetAttribute("TemporarySpinReward") ~= true then
			task.defer(normalizeTool, player, child.Name)
		end
	end)
end

local function watchProducts(player)
	local products = getProductsFolder(player)
	for toolName in pairs(toolpasses) do
		local value = getProductValue(player, toolName)
		value.Changed:Connect(function()
			normalizeTool(player, toolName)
		end)
	end
	products.ChildAdded:Connect(function(child)
		if child:IsA("BoolValue") and toolpasses[child.Name] then
			child.Changed:Connect(function()
				normalizeTool(player, child.Name)
			end)
			normalizeTool(player, child.Name)
		end
	end)
end

local function promptTool(player, toolName)
	local info = toolpasses[toolName]
	if not info then
		return
	end

	if ownsStoredTool(player, toolName) or ownsGamePass(player, info.gamePassId) then
		setOwned(player, toolName, true)
		return
	end

	MarketplaceService:PromptGamePassPurchase(player, info.gamePassId)
end

local function setupPrompt(toolName, info)
	local npc = toolNPCS:FindFirstChild(info.npcName)
	if not npc then
		warn("[toolpasses] Missing ToolNPC:", info.npcName)
		return
	end

	local root = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
	if not root then
		warn("[toolpasses] Missing prompt part for:", info.npcName)
		return
	end

	local prompt = root:FindFirstChildOfClass("ProximityPrompt")
	if not prompt then
		prompt = Instance.new("ProximityPrompt")
		prompt.Parent = root
	end

	prompt.Enabled = true
	prompt.ActionText = "Buy"
	prompt.ObjectText = info.promptName
	prompt.HoldDuration = 0
	prompt.RequiresLineOfSight = false
	prompt.MaxActivationDistance = math.max(prompt.MaxActivationDistance, 10)
	prompt:SetAttribute("ToolGamepass", toolName)
	prompt:SetAttribute("GamePassId", info.gamePassId)

	if not hookedPrompts[prompt] then
		hookedPrompts[prompt] = true
		prompt.Triggered:Connect(function(player)
			promptTool(player, toolName)
		end)
	end
end

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamePassId, wasPurchased)
	local toolName = passToTool[gamePassId]
	if not player or not toolName then
		return
	end
	if wasPurchased or ownsGamePass(player, gamePassId) then
		setOwned(player, toolName, true)
	end
end)

local function setupPlayer(player)
	watchProducts(player)
	watchContainer(player, player:FindFirstChildOfClass("Backpack"))
	watchContainer(player, player:FindFirstChild("StarterGear"))

	player.ChildAdded:Connect(function(child)
		if child:IsA("Backpack") or child.Name == "StarterGear" then
			watchContainer(player, child)
			task.defer(normalizeAllTools, player)
		end
	end)

	player.CharacterAdded:Connect(function(character)
		watchContainer(player, character)
		task.wait(0.25)
		normalizeAllTools(player)
	end)

	if player.Character then
		watchContainer(player, player.Character)
	end

	syncAllOwnership(player)
	task.defer(normalizeAllTools, player)
end

for toolName, info in pairs(toolpasses) do
	setupPrompt(toolName, info)
end

Players.PlayerAdded:Connect(setupPlayer)
for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(setupPlayer, player)
end
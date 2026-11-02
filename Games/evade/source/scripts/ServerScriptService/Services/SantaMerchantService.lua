local SantaMerchantService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")

local Net = require(ReplicatedStorage.Packages.Net)
local Animals = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local ElfService = require(ServerScriptService.Services.ElfService)
local PlotService = require(ServerScriptService.Services.PlotService)

local Buy = Net:RemoteFunction("SantaMerchantService/Buy")
local AnimationEvent = Net:RemoteEvent("SantaMerchantService/Animation")
local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PREFIX = "SantaMerchant_"
local MESSAGING_TOPIC = "SantaMerchantRestock"

local function cleanName(name)
	return string.gsub(name, "%s", "_")
end

local function applychanges(itemName, amount)
	local attr = PREFIX .. cleanName(itemName)
	local current = ReplicatedStorage:GetAttribute(attr) or 0
	ReplicatedStorage:SetAttribute(attr, current + amount)
end

MessagingService:SubscribeAsync(MESSAGING_TOPIC, function(message)
	local data = message.Data

	if data.global then
		local brainrots = {"Los Jolly Combinasionas", "Money Money Reindeer", "Jolly Jolly Sahur", "Ginger Cerat"}
		for _, nombre in ipairs(brainrots) do
			applychanges(nombre, data.amount)
		end
	else
		applychanges(data.itemName, data.amount)
	end
end)

_G.RestockLocal = applychanges

local BRAINROTS = {
	{Name = "Los Jolly Combinasionas", Price = 15}, 
	{Name = "Money Money Reindeer", Price = 20},
	{Name = "Jolly Jolly Sahur", Price = 50},
	{Name = "Ginger Cerat", Price = 100}
}

local STOCK_ATTRIBUTE_PREFIX = "SantaMerchant_"
local INITIAL_STOCK = 50000
local RESTOCK_INTERVAL = 3600


local function initializeStock()
	for _, data in ipairs(BRAINROTS) do
		local attr = STOCK_ATTRIBUTE_PREFIX .. cleanName(data.Name)
		if ReplicatedStorage:GetAttribute(attr) == nil then
			ReplicatedStorage:SetAttribute(attr, INITIAL_STOCK)
		end
	end
end

local function getStock(name)
	return ReplicatedStorage:GetAttribute(STOCK_ATTRIBUTE_PREFIX .. cleanName(name)) or 0
end

local function setStock(name, amount)
	ReplicatedStorage:SetAttribute(STOCK_ATTRIBUTE_PREFIX .. cleanName(name), amount)
end

local function spawnAnimalFromSanta(player, animalName)
	local AnimalData = Animals[animalName]
	if not AnimalData then
		return false
	end

	local plot = PlotService.getPlot(player)
	if not plot then
		return false
	end

	local santaModel = Workspace:FindFirstChild("Santa Merchant")
	local spawnPart = santaModel and santaModel:FindFirstChild("SpawnPart")
	if not spawnPart then
		return false
	end

	local marker = Instance.new("Part")
	marker.Name = "Haveyouguysevergoonedto67whilewatchingscpwishIknewlowkeuinelydevouryou'reentirefamilywhilecharliekirkiswithesptienandkhabylamemechanismplaystheapplenotifacicationsoundeffectwhichtehnspawnsjefferyepsteintostopwishIknewfromeatingyou'rentirefamily"
	marker.Anchored = true
	marker.CanCollide = false
	marker.Transparency = 1
	marker.Size = Vector3.new(1, 1, 1)
	marker.CFrame = spawnPart.CFrame
	marker.Parent = Workspace

	local customSpawnConfig = {
		Start = marker,
		End = plot.AnimalTarget,
		Owner = player
	}

	AnimalService.spawnAnimalCustom(
		AnimalData,
		nil,
		nil,
		nil,
		customSpawnConfig,
		nil
	)

	task.delay(0.1, function()
		marker:Destroy()
	end)

	return true
end

Buy.OnServerInvoke = function(player, fixedString, itemIndex)
	if typeof(itemIndex) ~= "number" then
		return false
	end

	local item = BRAINROTS[itemIndex]
	if not item then
		return false
	end

	local canAfford = ElfService:CanAfford(player, item.Price)
	if not canAfford then
		return false
	end

	if getStock(item.Name) <= 0 then
		return false
	end

	ElfService:Add(player, -item.Price)
	setStock(item.Name, getStock(item.Name) - 1)

	local success = spawnAnimalFromSanta(player, item.Name)
	if not success then
		ElfService:Add(player, item.Price)
		setStock(item.Name, getStock(item.Name) + 1)
		return false
	end

	return true
end

local function startRestockTimer()
	local now = os.time()
	local nextRestock = math.ceil(now / RESTOCK_INTERVAL) * RESTOCK_INTERVAL
	ReplicatedStorage:SetAttribute("SantaMerchantNextStockId", nextRestock)
	ReplicatedStorage:SetAttribute("SantaMerchantStockId", now)
	ReplicatedStorage:SetAttribute(
		"SantaMerchantService/LeavingTimestamp",
		nextRestock + RESTOCK_INTERVAL
	)

	task.spawn(function()
		while true do
			local currentTime = os.time()
			local target = ReplicatedStorage:GetAttribute("SantaMerchantNextStockId")
			if target and currentTime >= target then
				for _, data in ipairs(BRAINROTS) do
					setStock(data.Name, INITIAL_STOCK)
				end
				target += RESTOCK_INTERVAL
				ReplicatedStorage:SetAttribute("SantaMerchantNextStockId", target)
				ReplicatedStorage:SetAttribute("SantaMerchantStockId", currentTime)
				ReplicatedStorage:SetAttribute(
					"SantaMerchantService/LeavingTimestamp",
					target + RESTOCK_INTERVAL
				)
			end
			task.wait(1)
		end
	end)
end

function SantaMerchantService:Start()
	initializeStock()
	startRestockTimer()
end

return SantaMerchantService
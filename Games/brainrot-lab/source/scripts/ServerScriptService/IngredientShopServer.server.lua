--!strict
-- LOCATION: ServerScriptService/IngredientShopServer
-- Simple ingredient shop: 20-min refresh, rarity-based stock, purchase handling.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local IngredientShopConfig = require(ReplicatedStorage.Modules.IngredientShopConfig)
local PlayerController = require(ServerScriptService.Controllers.PlayerController)

local IngredientsFolder = ReplicatedStorage:WaitForChild("Ingredients")
local Events = ReplicatedStorage:WaitForChild("Events")

-- [ REMOTES ]
local getStockRemote = Events:FindFirstChild("GetIngredientShopStock")
if not getStockRemote then
	getStockRemote = Instance.new("RemoteFunction")
	getStockRemote.Name = "GetIngredientShopStock"
	getStockRemote.Parent = Events
end

local buyRemote = Events:FindFirstChild("BuyIngredient")
if not buyRemote then
	buyRemote = Instance.new("RemoteEvent")
	buyRemote.Name = "BuyIngredient"
	buyRemote.Parent = Events
end

-- [ STATE ]
local currentStock = {} -- array of { Name, Rarity, Price }

-- [ HELPERS ]
local function pickRandomIngredient()
	-- Weighted rarity roll
	local totalWeight = 0
	for _, weight in pairs(IngredientShopConfig.RarityWeights) do
		totalWeight += weight
	end

	local roll = math.random() * totalWeight
	local chosenRarity = "Common"
	for rarity, weight in pairs(IngredientShopConfig.RarityWeights) do
		roll -= weight
		if roll <= 0 then
			chosenRarity = rarity
			break
		end
	end

	-- Gather ingredients of the chosen rarity
	local pool = {}
	for name, data in pairs(IngredientShopConfig.Ingredients) do
		if data.Rarity == chosenRarity then
			table.insert(pool, name)
		end
	end

	-- Fallback: if rarity has no ingredients, use any
	if #pool == 0 then
		for name in pairs(IngredientShopConfig.Ingredients) do
			table.insert(pool, name)
		end
	end

	local name = pool[math.random(#pool)]
	local data = IngredientShopConfig.Ingredients[name]
	return {
		Name = name,
		Rarity = data.Rarity,
		Price = data.Price,
		RobuxPrice = data.RobuxPrice or 0,
		ProductId = data.ProductId or 0,
	}
end

local function refreshStock()
	currentStock = {}

	-- Build a pool of all ingredient names
	local pool = {}
	for name in pairs(IngredientShopConfig.Ingredients) do
		table.insert(pool, name)
	end

	-- Shuffle the pool so the order is random each refresh
	for i = #pool, 2, -1 do
		local j = math.random(i)
		pool[i], pool[j] = pool[j], pool[i]
	end

	-- Take the first Slots distinct ingredients
	local count = math.min(IngredientShopConfig.Slots, #pool)
	for i = 1, count do
		local name = pool[i]
		local data = IngredientShopConfig.Ingredients[name]
		table.insert(currentStock, {
			Name = name,
			Rarity = data.Rarity,
			Price = data.Price,
			RobuxPrice = data.RobuxPrice or 0,
			ProductId = data.ProductId or 0,
		})
	end
end

-- [ REMOTE HANDLERS ]
getStockRemote.OnServerInvoke = function()
	return currentStock
end

buyRemote.OnServerEvent:Connect(function(player, itemName)
	if type(itemName) ~= "string" then return end

	-- Find the item in the current stock
	local item = nil
	for _, stockItem in ipairs(currentStock) do
		if stockItem.Name == itemName then
			item = stockItem
			break
		end
	end
	if not item then return end

	-- Validate money
	if not PlayerController:DeductMoney(player, item.Price) then
		local notif = Events:FindFirstChild("ShowNotification")
		if notif then notif:FireClient(player, "Not enough money!", "Error") end
		return
	end

	-- Give the ingredient tool
	local template = IngredientsFolder:FindFirstChild(item.Name)
	if template then
		local tool = template:Clone()
		tool.Parent = player:WaitForChild("Backpack")
	end

	local notif = Events:FindFirstChild("ShowNotification")
	if notif then notif:FireClient(player, "Bought " .. item.Name .. "!", "Success") end
end)

-- [ INIT ]
refreshStock()

-- Refresh every 20 minutes
while true do
	task.wait(IngredientShopConfig.RefreshInterval)
	refreshStock()
end

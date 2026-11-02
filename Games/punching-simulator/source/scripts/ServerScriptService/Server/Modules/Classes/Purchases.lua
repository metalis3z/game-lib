--> Variables
local _L = _G._L

local TableUtility
local Services
local Promise
local Signal
local User
local Gamepasses
local Settings

--> Constants
	
------------->
local Purchases = {_objects = {}}
Purchases.__index = Purchases

function Purchases.Await(player, dontYield)
	local purchases = Purchases._objects[player]

	if purchases then
		return purchases
	elseif not dontYield then
		local newTrove = Trove.new()

		return Promise.new(function(resolve, reject)
			local purchases = Purchases._objects[player]

			if purchases then
				resolve(purchases)
				return
			end
			
			newTrove:Connect(Purchases.Added, function(addedPurchases)
				if addedPurchases._player == player then
					resolve(addedPurchases)
				end
			end)

			newTrove:Connect(User.Removed, function(removedUser)
				if removedUser._player == player then
					reject()
				end
			end)
		end):finally(function()
			newTrove:Destroy()
		end):catch(warn):expect()
	end
end

function Purchases.GetProductInfoFromId(productId)
	local _, productInfo = TableUtility.match(Products, function(k, v)
		return typeof(v) == "table" and v.id == productId
	end)
	
	return productInfo
end

function Purchases.GetGamepassInfoFromId(gamepassId)
	local _, gamepassInfo = TableUtility.match(Gamepasses, function(k, v)
		return typeof(v) == "table" and v.id == gamepassId
	end)

	return gamepassInfo
end

function Purchases.GetProductInfoFromName(productName)
	local _, productInfo = TableUtility.match(Products, function(k, v)
		return typeof(v) == "table" and v.name == productName
	end)

	return productInfo
end

function Purchases.GetGamepassInfoFromName(gamepassName)
	local _, gamepassInfo = TableUtility.match(Gamepasses, function(k, v)
		return typeof(v) == "table" and v.name == gamepassName
	end)

	return gamepassInfo
end

function Purchases.Add(user)
	local player = user._player
	local purchases = Purchases._objects[player]

	if not purchases then
		local newPurchases = Purchases.new(user)
		purchases = newPurchases
	end

	return purchases
end

function Purchases.Remove(player)
	local purchases = Purchases._objects[player]

	if purchases then
		Purchases._objects[player] = nil
		purchases:Destroy()
	end
end

function Purchases.new(user)
	local self = setmetatable({}, Purchases)

	self._user = user

	self._player = self._user._player
	self._active_gamepasses = {}
	
	self._trove = Trove.new()

	self:_construct()

	return self
end

function Purchases:_construct()
	local promises = {}
	
	for _, gamepassInfo in pairs(Gamepasses) do
		if typeof(gamepassInfo) == "table" then
			local gamepassName = gamepassInfo.name
			local gamepassId = gamepassInfo.id

			table.insert(promises, Promise.new(function(resolve, reject)
				local success, result = pcall(function()
					return Services.MarketplaceService:UserOwnsGamePassAsync(self._player.UserId, gamepassId)
				end)

				if result then
					self:GiveGamepass(gamepassName)
				end

				resolve()
			end))
		end
	end
	
	Promise.all(promises):andThen(function()
		Purchases._objects[self._player] = self
		Purchases.Added:Fire(self)
	end)
end

function Purchases:PromptProduct(productName)
	local _, productInfo = TableUtility.match(Products, function(k, v)
		return typeof(v) == "table" and v.name == productName
	end)

	if productInfo then
		Services.MarketplaceService:PromptProduct(self._player, productInfo.id)
	end
end

function Purchases:PromptGamepass(gamepassName)
	local _, gamepassInfo = TableUtility.match(Gamepasses, function(k, v)
		return typeof(v) == "table" and v.name == gamepassName
	end)

	if gamepassInfo then
		Services.MarketplaceService:PromptGamePassPurchase(self._player, gamepassInfo.id)
	end
end

function Purchases:OwnsGamepass(gamepassName)
	local gamepassInfo = Purchases.GetGamepassInfoFromName(gamepassName)
	local gamepassId = gamepassInfo.id
	
	return table.find(self._user._data:Get("gamepasses"), gamepassId) ~= nil
end

function Purchases:GiveGamepass(gamepassName)
	local gamepassInfo = Purchases.GetGamepassInfoFromName(gamepassName)
	local gamepassId = gamepassInfo.id
	local gamepassesData = self._user._data:Get("gamepasses")
	
	if not self:OwnsGamepass(gamepassName) then
		local newGamepassesData = TableUtility.deep.clone(gamepassesData)
		
		table.insert(newGamepassesData, gamepassId)

		self._user._data:Set("gamepasses", newGamepassesData)
	end
	
	if not table.find(self._active_gamepasses, gamepassId) then
		table.insert(self._active_gamepasses, gamepassId)
		
		task.spawn(function()
			gamepassInfo.callback(self._user)
		end)
	end
end

function Purchases:GiveProduct(productName)
	local productInfo = Purchases.GetProductInfoFromName(productName)
	local productId = productInfo.id

	productInfo.callback(self._user)
end

function Purchases:Destroy()
	self._trove:Destroy()
end

function Purchases._init()
	TableUtility = _L.Get {"Common", "Library", "Utilities", "TableUtility"}
	Services = _L.Get {"Common", "Library", "Services"}
	Trove = _L.Get {"Common", "Library", "Classes", "Trove"}
	Promise = _L.Get {"Common", "Library", "Classes", "Promise"}
	Signal = _L.Get {"Common", "Library", "Classes", "Signal"}
	User = _L.Get {"Server", "Modules", "Classes", "User"}
	Gamepasses = _L.Get {"Common", "Modules", "Databases", "Gamepasses"}
	Products = _L.Get {"Common", "Modules", "Databases", "Products"}
	Settings = _L.Get {"Common", "Modules", "Settings"}
	
	Purchases.Added = Signal.new()
end

function Purchases._start()
	local PurchaseIdCache = {}
	
	Services.MarketplaceService.ProcessReceipt = function(receiptInfo)
		local productId = receiptInfo.ProductId
		local purchaseId = receiptInfo.PurchaseId
		
		if PurchaseIdCache[purchaseId] then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
		
		PurchaseIdCache[purchaseId] = true
		
		local userId = receiptInfo.PlayerId
		
		local player = Services.Players:GetPlayerByUserId(userId)
		
		if player then
			local productInfo = Purchases.GetProductInfoFromId(productId)
			local productName = productInfo.name
			
			local user = User.Await(player)
			
			if productInfo and user then
				task.spawn(function()
					user._purchases:GiveProduct(productName)
				end)
				
				return Enum.ProductPurchaseDecision.PurchaseGranted
			end
		end
		
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	
	Services.MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamepassId, wasPurchased)
		if wasPurchased then
			local user = User.Await(player)
			
			if user then
				local gamepassInfo = Purchases.GetGamepassInfoFromId(gamepassId)
				local gamepassName = gamepassInfo.name
				
				user._purchases:GiveGamepass(gamepassName)
			end
		end
	end)
end

return Purchases
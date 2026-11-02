-- Cadeaux entre joueurs (fenêtre GiftClient) : le joueur choisit un ami / un @pseudo, puis un pass ou un lot d'œufs, puis paie.
-- Paiement : produit développeur de cadeau (ShopConfig.GiftProducts). Une fois payé, le cadeau est livré par AdminServer (DeliverGift) :
-- tout de suite si le joueur est en ligne sur ce serveur, sinon sur son serveur ou à sa prochaine connexion.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")
local DataStoreService = game:GetService("DataStoreService")

local shopSystem = ReplicatedStorage:WaitForChild("ShopSystem")
local ShopConfig = require(shopSystem:WaitForChild("ShopConfig"))
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local remotes = shopSystem:WaitForChild("Remotes")
local requestRemote = remotes:WaitForChild("GiftRequest")
local resultRemote = remotes:WaitForChild("GiftResult")
local deliver = ServerStorage:WaitForChild("GameBindables"):WaitForChild("DeliverGift")
local Purchases = require(ServerScriptService:WaitForChild("Purchases"))

-- cadeau en attente de paiement, par acheteur (gardé aussi dans le DataStore : si l'acheteur quitte pendant le paiement,
-- Roblox redonne le reçu à sa prochaine connexion et le cadeau part quand même)
local pendingStore
pcall(function() pendingStore = DataStoreService:GetDataStore("GiftPending_v1") end)
local pending = {} -- [player] = {UserId, Name, Item}

local function result(player, ok, text) resultRemote:FireClient(player, ok, text) end

local function giftOf(item)
	if item.Kind == "Pass" then return {Kind = "Pass", Key = item.Key} end
	return {Kind = "FeaturedEggs", Count = item.Count}
end

local function send(buyer, entry)
	local item = ShopConfig.GetGiftItem(entry.Item)
	if not item then return false end
	local ok, done = pcall(function() return deliver:Invoke(buyer.Name, entry.UserId, giftOf(item)) end)
	if ok and done then
		result(buyer, true, "Gift sent! @" .. entry.Name .. " got " .. item.Name .. ".")
		return true
	end
	return false
end

local busy = {}
requestRemote.OnServerEvent:Connect(function(player, targetName, itemKey)
	if busy[player] or type(targetName) ~= "string" or type(itemKey) ~= "string" then return end
	local item = ShopConfig.GetGiftItem(itemKey)
	if not item then return end
	busy[player] = true
	targetName = string.gsub(string.gsub(targetName, "^%s*@", ""), "%s", "")
	local userId, name
	for _, p in Players:GetPlayers() do
		if string.lower(p.Name) == string.lower(targetName) then userId, name = p.UserId, p.Name end
	end
	if not userId then
		local ok, id = pcall(function() return Players:GetUserIdFromNameAsync(targetName) end)
		if ok and id then
			userId = id
			local okName, real = pcall(function() return Players:GetNameFromUserIdAsync(id) end)
			name = okName and real or targetName
		end
	end
	busy[player] = nil
	if not userId then return result(player, false, "Player @" .. targetName .. " not found") end
	if userId == player.UserId then return result(player, false, "You can't gift yourself!") end
	-- le joueur (en ligne ici) a déjà ce pass : inutile de payer
	local target = Players:GetPlayerByUserId(userId)
	if item.Kind == "Pass" and target and ShopConfig.HasPass(target, item.Key) then
		return result(player, false, "@" .. name .. " already owns " .. item.Name)
	end
	local entry = {UserId = userId, Name = name, Item = item.Key}
	if item.ProductId == 0 then
		-- produit de cadeau pas encore créé : seul le créateur du jeu peut l'essayer (gratuit)
		if table.find(EggConfig.OwnerUserIds or {}, player.UserId) then
			if not send(player, entry) then result(player, false, "Gift failed, try again") end
		else
			result(player, false, "Gifting " .. item.Name .. " is coming soon!")
		end
		return
	end
	pending[player] = entry
	if pendingStore then pcall(function() pendingStore:SetAsync("u_" .. player.UserId, entry) end) end
	MarketplaceService:PromptProductPurchase(player, item.ProductId)
end)

-- paiement reçu : on livre le cadeau en attente qui correspond à ce produit
local function onPaid(player, receipt)
	local entry = pending[player]
	if not entry and pendingStore then
		local ok, saved = pcall(function() return pendingStore:GetAsync("u_" .. player.UserId) end)
		if ok and type(saved) == "table" then entry = saved end
	end
	local item = entry and ShopConfig.GetGiftItem(entry.Item)
	if not item or item.ProductId ~= receipt.ProductId then return false end
	if not send(player, entry) then return false end -- Roblox réessaiera
	pending[player] = nil
	if pendingStore then pcall(function() pendingStore:RemoveAsync("u_" .. player.UserId) end) end
	return true
end
for _, item in ShopConfig.GiftItems() do
	Purchases.register(item.ProductId, onPaid)
end

Players.PlayerRemoving:Connect(function(player) pending[player], busy[player] = nil, nil end)

-- Œuf en vedette de la boutique (ShopConfig.Featured) : achat d'un lot d'œufs en Robux.
-- Les œufs achetés vont dans l'inventaire d'œufs du joueur (bouton œuf à droite de l'écran > Place all).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")

local shopSystem = ReplicatedStorage:WaitForChild("ShopSystem")
local ShopConfig = require(shopSystem:WaitForChild("ShopConfig"))
local buyRemote = shopSystem:WaitForChild("Remotes"):WaitForChild("BuyFeatured")
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local notifyRemote = ReplicatedStorage.EggSystem:WaitForChild("Remotes"):WaitForChild("Notify")
local bridge = ServerScriptService:WaitForChild("TradeBridge") -- répondu par PetServer (GiveEggs)
local Purchases = require(ServerScriptService:WaitForChild("Purchases"))

local featured = ShopConfig.Featured
if not featured or not EggConfig.Eggs[featured.Egg] then return end
local eggName = EggConfig.Eggs[featured.Egg].Name

local function notify(player, text) notifyRemote:FireClient(player, text) end

local function grant(player, pack)
	if not bridge:Invoke("GiveEggs", player, featured.Egg, nil, pack.Count) then return false end
	notify(player, "+" .. pack.Count .. " " .. eggName .. (pack.Count > 1 and "s" or "") .. "! Open the egg panel and press Place all.")
	return true
end
for _, pack in featured.Packs do
	if (pack.ProductId or 0) ~= 0 then Purchases.register(pack.ProductId, function(player) return grant(player, pack) end) end
end

-- GAMEPASS : chaque lot ne se donne qu'une fois par joueur. On retient les gamepass déjà donnés (DataStore), pour donner les œufs
-- à l'achat, ou à la connexion si le gamepass a été acheté ailleurs (site Roblox, autre serveur, déconnexion pendant l'achat).
local DataStoreService = game:GetService("DataStoreService")
local grantStore
pcall(function() grantStore = DataStoreService:GetDataStore("FeaturedPassGrants_v1") end)
local granted = {} -- [player] = {[passId] = true}
local busy = {}
local function loadGranted(player)
	if granted[player] then return granted[player] end
	local set = {}
	if grantStore then
		local ok, list = pcall(function() return grantStore:GetAsync("u_" .. player.UserId) end)
		if not ok then return nil end -- on ne sait pas : on ne donne rien (pas de doublon)
		for _, id in type(list) == "table" and list or {} do set[id] = true end
	end
	granted[player] = set
	return set
end
local function givePass(player, pack)
	if not pack.PassId or busy[player] then return end
	busy[player] = true
	local set = loadGranted(player)
	if set and not set[pack.PassId] and grant(player, pack) then
		set[pack.PassId] = true
		local list = {}
		for id in set do table.insert(list, id) end
		if grantStore then pcall(function() grantStore:SetAsync("u_" .. player.UserId, list) end) end
	end
	busy[player] = nil
end
local function packOfPass(passId)
	for _, pack in featured.Packs do if pack.PassId == passId then return pack end end
end
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, passId, purchased)
	local pack = purchased and packOfPass(passId)
	if pack then givePass(player, pack) end
end)
local function checkOwned(player)
	task.wait(8) -- les données (inventaire d'œufs) du joueur doivent être chargées par PetServer
	for _, pack in featured.Packs do
		if not player.Parent then return end
		if pack.PassId then
			local ok, owns = pcall(function() return MarketplaceService:UserOwnsGamePassAsync(player.UserId, pack.PassId) end)
			if ok and owns then givePass(player, pack) end
		end
	end
end
Players.PlayerAdded:Connect(checkOwned)
for _, player in Players:GetPlayers() do task.spawn(checkOwned, player) end
Players.PlayerRemoving:Connect(function(player) granted[player], busy[player] = nil, nil end)

local lastClick = {}
Players.PlayerRemoving:Connect(function(player) lastClick[player] = nil end)
buyRemote.OnServerEvent:Connect(function(player, index, gift)
	local pack = type(index) == "number" and featured.Packs[index]
	if not pack then return end
	if os.clock() - (lastClick[player] or 0) < 0.6 then return end
	lastClick[player] = os.clock()
	if os.time() >= (featured.EndsAt or math.huge) then
		notify(player, "This egg is no longer available!")
		return
	end
	if gift == true then
		notify(player, "Gifting is coming soon!")
		return
	end
	if (pack.ProductId or 0) ~= 0 then
		-- produit développeur : rachetable autant de fois qu'on veut (prioritaire sur le gamepass)
		MarketplaceService:PromptProductPurchase(player, pack.ProductId)
	elseif pack.PassId then
		-- gamepass : Roblox ne permet de l'acheter qu'une fois
		local ok, owns = pcall(function() return MarketplaceService:UserOwnsGamePassAsync(player.UserId, pack.PassId) end)
		if ok and owns then
			notify(player, "You already bought this pack!")
			givePass(player, pack) -- au cas où il n'a pas encore été donné
		else
			MarketplaceService:PromptGamePassPurchase(player, pack.PassId)
		end
	elseif featured.OwnerFree and table.find(EggConfig.OwnerUserIds, player.UserId) then
		grant(player, pack) -- le créateur du jeu essaie la boutique sans produit Robux (ShopConfig.Featured.OwnerFree)
	else
		notify(player, "The " .. eggName .. " is coming soon!")
	end
end)

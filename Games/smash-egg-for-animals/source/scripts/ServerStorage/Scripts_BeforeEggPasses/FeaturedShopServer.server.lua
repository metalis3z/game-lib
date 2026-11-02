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
	Purchases.register(pack.ProductId, function(player) return grant(player, pack) end)
end

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
	if pack.ProductId ~= 0 then
		MarketplaceService:PromptProductPurchase(player, pack.ProductId)
	elseif featured.OwnerFree and table.find(EggConfig.OwnerUserIds, player.UserId) then
		grant(player, pack) -- le créateur du jeu essaie la boutique sans produit Robux (ShopConfig.Featured.OwnerFree)
	else
		notify(player, "The " .. eggName .. " is coming soon!")
	end
end)

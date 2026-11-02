-- Achats en Robux (produits développeur) : Roblox n'accepte qu'UNE fonction ProcessReceipt pour tout le jeu.
-- Chaque système inscrit ici ce que donne son produit :
--   Purchases.register(productId, function(player, receipt) ... return true end)   -- true = donné, l'achat est validé
-- Un id à 0 (produit pas encore créé) est ignoré. Si la fonction renvoie faux ou échoue, Roblox réessaiera plus tard.
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local Purchases = {}
local handlers = {}

function Purchases.register(productId, handler)
	if type(productId) == "number" and productId ~= 0 then handlers[productId] = handler end
end

MarketplaceService.ProcessReceipt = function(receipt)
	local handler = handlers[receipt.ProductId]
	local player = Players:GetPlayerByUserId(receipt.PlayerId)
	if not handler or not player then return Enum.ProductPurchaseDecision.NotProcessedYet end
	local ok, granted = pcall(handler, player, receipt)
	if not ok then warn("[Purchases] product " .. receipt.ProductId .. " : " .. tostring(granted)) end
	return ok and granted and Enum.ProductPurchaseDecision.PurchaseGranted or Enum.ProductPurchaseDecision.NotProcessedYet
end

return Purchases

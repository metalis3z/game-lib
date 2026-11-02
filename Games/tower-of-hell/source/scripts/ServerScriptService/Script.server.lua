local MPS = game:GetService("MarketplaceService")

MPS.ProcessReceipt = function(receiptInfo)
	if receiptInfo.ProductId == 1116179484 then -- replace with your ID here
		local player = game.Players:GetPlayerByUserId(receiptInfo.PlayerId)
		player.leaderstats.Coins.Value = player.leaderstats.Coins.Value + 200
		return Enum.ProductPurchaseDecision.PurchaseGranted
		
	elseif receiptInfo.ProductId == 1116180282 then 
		local player = game.Players:GetPlayerByUserId(receiptInfo.PlayerId)
		player.leaderstats.Coins.Value = player.leaderstats.Coins.Value + 500
		return Enum.ProductPurchaseDecision.PurchaseGranted
		
	elseif receiptInfo.ProductId == 1116180320 then 
		local player = game.Players:GetPlayerByUserId(receiptInfo.PlayerId)
		player.leaderstats.Coins.Value = player.leaderstats.Coins.Value + 2000
		return Enum.ProductPurchaseDecision.PurchaseGranted
		
	elseif receiptInfo.ProductId == 1116180382 then 
		local player = game.Players:GetPlayerByUserId(receiptInfo.PlayerId)
		player.leaderstats.Coins.Value = player.leaderstats.Coins.Value + 10000
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
end
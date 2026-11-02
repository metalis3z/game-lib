-- Reference copy for study. Game: Work at a Pizza Place (work-at-a-pizza-place)
-- Original: ServerScriptService/PurchaseService.server.lua  (576 lines)
-- What it does: The classic pattern: a PurchaseHistory DataStore keyed 'userId:purchaseId' checked before granting, a handler table keyed by product id, pcall'd handlers, and the purchase recorded after success.
-- Excerpt of lines 327-454 (only the relevant part of a bigger script).

	print(userId,purchaseId)
	local playerProductKey = userId .. ":" .. purchaseId
	local cancelPetKey = userId .. ":" .. purchaseId  .. "err"
	
	
	if PurchaseHistory and PurchaseHistory:GetAsync(playerProductKey) then
        return Enum.ProductPurchaseDecision.PurchaseGranted --We already granted it.
	
	elseif receiptInfo.ProductId == Enums.PetProductId and PurchaseHistory and PurchaseHistory:GetAsync(cancelPetKey) then --if pet errors then give refund
		--[[local seconds = PurchaseHistory:GetAsync(cancelPetKey)
		local daysLeft = 3 - math.floor((tick() - seconds) / 86400)
		workspace.MessageService.Dialog:InvokeClient(player,"You will automatically get a refund for your pet in " ..  " days.","Ok","")]]
		print("Pet purchase was already canceled")
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	
	
	local player = game.Players:GetPlayerByUserId(userId)
	
	if not player then 
		print("Player = nil")
		script.PurchaseFinished:Fire(false)
		if receiptInfo.ProductId == Enums.PetProductId and PurchaseHistory then
			PurchaseHistory:SetAsync(cancelPetKey,true)
		end
		return Enum.ProductPurchaseDecision.NotProcessedYet 
	end
	
	
	
	local playerData = Players[player]
	
	if not playerData then 
		warn("PURCHASE ERROR Data data doesnt exist")
		Dialog:ShowMessage(player,"ERROR!", "There was an error. If you don't get your item within 3 days, you will automatically be refunded.")
		script.PurchaseFinished:Fire(false)
		if receiptInfo.ProductId == Enums.PetProductId and PurchaseHistory then
			PurchaseHistory:SetAsync(cancelPetKey,true)
		end
		return Enum.ProductPurchaseDecision.NotProcessedYet 
	end
	
	--get ahold of funtion
	local action
	for product_id,func in pairs(Products) do
		if product_id == receiptInfo.ProductId then
			action = func
			break
		end
	end
	
	--if gamepass
	if not action then return Enum.ProductPurchaseDecision.PurchaseGranted end
	
	
	
	
	--call it safely with pcall, to catch any error
	local success,result = pcall(action,receiptInfo,player,playerData,Products)
	
	

	if not success then
		warn("An error occured while processing a product purchase")
		print("\t ProductId:",receiptInfo.ProductId,"\n","Player:",player)
		print("\t Error message:",result) -- log it to the output
		
		if receiptInfo.ProductId ~= Enums.PetProductId then
			Dialog:ShowMessage(player,"ERROR!","There was an error. If you don't get your item within 3 days, you will automatically be refunded.")
		else
			Dialog:ShowMessage(player,"ERROR!","There was an error. You will automatically get a refund in 3 days.")
			PurchaseHistory:SetAsync(cancelPetKey,true)
		end
		script.PurchaseFinished:Fire(false)
		return Enum.ProductPurchaseDecision.NotProcessedYet
		
	end
	
	-- if the function didn't error, 'err' will be whatever the function returned
	-- if our handler didn't return anything (or it returned false/nil), it means
	-- that the purchase failed for some reason, so we have to cancel it
	if not result then
		warn("Funtion retuned false/nil")
		if receiptInfo.ProductId ~= Enums.PetProductId then 
			Dialog:ShowMessage(player,"ERROR!","There was an error. If you don't get your item within 3 days, you will automatically be refunded.","Ok")
		else
			Dialog:ShowMessage(player,"ERROR!","There was an error. You will automatically get a refund in 3 days.","Ok")
			PurchaseHistory:SetAsync(cancelPetKey,true)
		end
		script.PurchaseFinished:Fire(false)
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	
	--record purchase history
	if PurchaseHistory then
		print("saving purchase")
		success,result = pcall(function()
	        PurchaseHistory:SetAsync(playerProductKey, true)
		end)
	end
	
	
	if not success then
        print("An error occured while saving a product purchase")
		print("\t ProductId:",receiptInfo.ProductId,"\n","Player:",player)
		print("\t Error message:",error) -- log it to the output
		print("\t Handler worked fine") -- add a small note that the actual purchase has succeed
	end
	
	
	print("Purchase Completed")
	
	local nameId,_ = GetProductData(receiptInfo.ProductId)
	workspace.Main.ProductPurchaseComplete:FireClient(player,nameId)
	script.PurchaseFinished:Fire(true)
	


	return Enum.ProductPurchaseDecision.PurchaseGranted		

	
end

MarketplaceService.ProcessReceipt = ProcessReceipt



----\-\-\-\-\-\-\-\-\-BUYING WITH MONEYZ-\-\-\-\-\-\-\-\-\--\-\-\-\-

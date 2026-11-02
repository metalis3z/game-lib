local ServerScriptService = script.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Players = Global.Players
local Paycheck = Global.Paycheck
local AssetLibraryManager = Global.AssetLibraryManager

local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))






--\-\-\-\-\-\--\-\BUYING WITH ROBUX--\-\-\-\-\-\-\-\-\-\-\\-
local MarketplaceService = game:GetService("MarketplaceService")



--get dev product data with a product id
function GetProductData(productId)
	local function find(products)
		for nameId, data in pairs(products) do
			if data.ProductId == productId then
				print("found")
				return nameId,data
			end
		end
		return nil
	end
	local nameId,data = find(Enums.GamePasses)
	if nameId == nil then
		nameId,data = find(Enums.Moneyz)
	end
	return nameId,data
end



function giveMoney(receipt,player,playerData,self)
	print("Giving money")
	local productId = receipt.ProductId
	local nameId,productData = GetProductData(productId)
	
	

	
	
	--if couldnt save, take back money and cancel purchase
	local suc,result = pcall(function()
		--make sure player saving works before giving the check
		if not playerData:SaveData(true) then
			print("saving failed")
			return false
		else
			playerData.PaycheckName = nameId
			Paycheck:GiveCheck(player,"Moneyz Purchase Check") --data is saved once the check is cashed
		end
		return true
	end)
	if not suc or not result then return false end

	return true
end




function giveGamePassGear(receipt,player,playerData,self)

	local productId = receipt.ProductId
	local nameId,productData = GetProductData(productId)
		print(nameId,productData)

	local gearAssetId = productData.GearAssetId
	local suc,result


	if productId == Enums.Moneyz.MoneyBag.ProductId then
		
		playerData.Coins = playerData.Coins + Enums.Moneyz.MoneyBag.Amount

		
		suc,result = pcall(function()
			if not playerData:SaveData(true) then
				
				playerData.Coins = playerData.Coins - Enums.Moneyz.MoneyBag.Amount
				
				return false
			end
			return true
		end)
		
		if not suc or not result then return false end

	end
		
		
	--give gear to player
	suc,result = pcall(function()
		if not playerData:GetInventoryItemById(gearAssetId) then
			playerData:IncrementItemQuantity(gearAssetId,1)
			game.Workspace.Main.LoadRobloxItem.LoadRobloxItem:Fire(player,gearAssetId,"Gear")
			playerData:SaveBackpackItem(gearAssetId,"Gear")
			playerData:SaveGamePass(nameId)
		end
	end)
		
	--go though with purchase but throw and error message
	if not suc then 
		Dialog:ShowMessage(player,"Error","There was an error. Leave the game and come back to get your item.") 
		if result then warn("Error:" .. result) end
	end

	return true

end

local Products = {
	
	[Enums.PetProductId] = function(receipt,player,playerData,self)
		local success
		local result
		--if error then sucess = nil
		success,result = pcall(function() 
			return script.Parent.PetController.ProcessPurchase:Invoke(player)
		end)
		if success and result then
			print("Success!")
			return true
		else 				--if nil or false
			if result then
				spawn(function()
					error(result)
				end)
			end
			return false
		end
		
	end,
	

	[Enums.GamePasses.GarageUpgrade.ProductId] = function(receipt,player,playerData,self)
		local success
		local result
		--if error then sucess = nil
		success,result = pcall(function()
			playerData.House.GarageEnabled = true
			playerData:SaveGamePass("GarageUpgrade")
			workspace.Main.StartUpgradeCutscene:FireClient(player,playerData.House.UpgradeModel,true)
			if not playerData:SaveData(true) then
				return false
			end
			return true
		end)
		if success and result then
			print("Success!")
			return true
		else 				--if nil or false
			warn(result)
			return false
		end
		
	end,
	
	
	[Enums.GamePasses.FullyUpgradedHouse.ProductId] = function(receipt,player,playerData,self)
		local success
		local result
		--if error then sucess = nil
		success,result = pcall(function()
			playerData.House:SetUpgrade("Hotel")
			playerData:SaveGamePass("FullyUpgradedHouse")
			playerData.UpgradePayments = 0
			pcall(function() Dialog:ShowMessage(player,"Upgrade","Your house is now fully upgraded!") end)
			if not playerData:SaveData(true) then
				return false
			end
			return true
		end)
		if success and result then
			print("Success!")
			return true
		else 				--if nil or false
			warn(result)
			return false
		end
		
	end,
	
	
	
	[Enums.BasementProductId] = function(receipt,player,playerData,self)
		local success
		local result

		success,result = pcall(function()
			playerData.House:SetUpgrade("Basement")
			playerData.UpgradePayments = 0
			workspace.Main.SetWindowVisible:FireClient(player,"Upgrade",false)
			pcall(function()
				Dialog:ShowMessage(player,"Basement","You now have a basement!") 
				local markerCFrame = playerData.House.UpgradeModel.Marker.CFrame
				local pos
				--delete any walls blocking the staircase UPDATECHANGE
				for _,furniture in ipairs(playerData.House.Object.Furniture:GetChildren()) do
					if furniture.Name == "Small Wall" or furniture.Name == "Large Wall" then
						pos = markerCFrame:toObjectSpace(furniture.Wall.CFrame)
						if math.floor(pos.X) == -39 and math.floor(pos.Y) == 6 and math.floor(pos.Z) == 34 then
							playerData.House:DeleteFurniture(furniture)
						end
					end
				end
			end)
			if not playerData:SaveData(true) then
				return false
			end
			return true
		end)
		if success and result then
			print("Success!")
			return true
		else 				--if nil or false
			warn(result)
			return false
		end
		
	end,
	
	
	
	
	[Enums.GamePasses.PontoonBoat.ProductId] = function(receipt,player,playerData,self)
		local success
		local result
		--if error then sucess = nil
		success,result = pcall(function()
			playerData:SaveGamePass("PontoonBoat")
			playerData:Teleport(workspace.Dock["Spawn Boat"].Head.Position) --teleport to boat
			workspace.Main.ShowBoatButton:FireClient(player)
			workspace.Main.SetWindowVisible:FireClient(player,"Catalog",false) --close catalog
			
			if not playerData.Settings.WaterEnabled then --open settings menu if player doesnt have detailed water
				workspace.Main.SetWindowVisible:FireClient(player,"Settings",true)
			end
			
			if not playerData:SaveData(true) then
				return false
			end
			
			return true
		end)
		if success and result then
			print("Success!")
			return true
		else 				--if nil or false
			warn("Error:" .. result)
			return false
		end
		
	end,
	
	
	[Enums.GamePasses.ManagerTeleport.ProductId] = function(receipt,player,playerData,self)
		playerData:SaveGamePass("ManagerTeleport")
		pcall(function() Dialog:ShowMessage(player,"Manager Teleporter","You are now able to teleport to the manager's chair when the manager job is open.") end)
		if not playerData:SaveData(true) then
			return false
		end
		return true
	end,
	
	

	
	[Enums.Moneyz.MoneyBag.ProductId] = giveGamePassGear,
	[Enums.GamePasses.HangGlider.ProductId] = giveGamePassGear,
	[Enums.GamePasses.DeliveryBike.ProductId] = giveGamePassGear,

	
	
	
	--buy moneyz
	[Enums.Moneyz.CoinsSmall.ProductId] = giveMoney,
	[Enums.Moneyz.CoinsMedium.ProductId] = giveMoney,
	[Enums.Moneyz.CoinsLarge.ProductId] = giveMoney,
	[Enums.Moneyz.CoinsXL.ProductId] = giveMoney,
	[Enums.Moneyz.CoinsChest.ProductId] = giveMoney,
	[Enums.Moneyz.CoinsDoubleChest.ProductId] = giveMoney,
	
	
	
	
	
	--[[--////Testing\\\\--

	--bag of money - testing place
	[19762535] = function(receipt,player,playerData,self) return self[bag_of_moneyz](receipt,player,playerData,self) end,
	
	--backyard - testing place
	[21007466] = function(receipt,player,playerData,self) return self[backyard_id](receipt,player,playerData,self) end,
	
	--buy moneyz - testing place
	[18938283] = giveMoney,
	[18938295] = giveMoney,
	[18938289] = giveMoney,
	[18938299] = giveMoney,
	
	--pets
	[30393855] = function(receipt,player,playerData,self) return self[pet_product_id](receipt,player,playerData,self) end,]]
}

	
	
	
	
	
	---/////Process Product Purchased\\\\\\--- 

local PurchaseHistory = (game.PlaceId ~= 0 and game:GetService("DataStoreService"):GetDataStore("PurchaseHistory"))

function ProcessReceipt (receiptInfo)
	print("Process stared")
	local userId = receiptInfo.PlayerId
	local purchaseId = receiptInfo.PurchaseId
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



--buying pet with moneyz
function game.Workspace.Main.BuyPetWithMoneyz.OnInvoke(player)
	local playerData = Players[player]
	if playerData and playerData.Moneyz >= Enums.PetPrice then
		
		playerData:RemoveMoneyz(Enums.PetPrice)
		
		
		if not playerData:SaveData(true) then
			playerData:AddMoneyz(Enums.PetPrice)
			return false
		end 
		
		return true
		
	else
		return false
	end
end


function FreeProducts(player,productId)
	if Enums.FreeMode and Products[productId] and Players[player] then
		math.randomseed(tick())
		math.random(1,5)
		local random = math.random(1,2000000000)
		ProcessReceipt({ProductId = productId, PlayerId = player.userId,PurchaseId = random})
	end
end

workspace.Main.FreeProducts.OnServerEvent:connect(FreeProducts)
workspace.Main.FreeProducts.FreeProducts.Event:connect(FreeProducts)



workspace.Main.CheckIfPlayerBoughtGamePass.Event:connect(function(player)
		
	local playerData = Players[player]
	
	while not playerData.StartedPlaying do
		wait(1)
	end

	spawn(function()
		--these are gamepass ids, not dev products
		--if player.Name == "Dued1" then return end
		--see if player has not been given the pass,
		for gamepassName,gamepassData in pairs(Enums.GamePasses) do
			--print(gamepassName,Player.GamePasses[gamepassName])
			if not playerData.GamePasses[gamepassName] and gamepassData.LegacyGamePassId and game:GetService("GamePassService"):PlayerHasPass(player, gamepassData.LegacyGamePassId) then
				local devProductId = gamepassData.ProductId
				local success,result = pcall(Products[devProductId],{ProductId = devProductId},player,playerData,Products)
				if success then
					wait(5)
				else
					Dialog:ShowMessage("Gamepass Error","There an error when giving your " .. gamepassName)
				end
			end
			
		end
	end)
end)


function game.Workspace.Main.BuyCatalogItem.OnServerInvoke(player,assetId)
	
	local playerData = Players[player]
	if not playerData then return false end
	
	local asset = AssetLibraryManager:GetAssetById(assetId)
		
	if Enums.CategoryToType[asset.Category] ~= "Furniture" and playerData:GetInventoryItemById(assetId) then
		Dialog:ShowMessage(player,"Can't buy again","You already own this item.")
		return false
	end
	
	local hasEnough = playerData:HasEnoughMoneyz(asset.Price)

	
	if playerData and asset and hasEnough then
		playerData:RemoveMoneyz(asset.Price)
		playerData:IncrementItemQuantity(assetId,1) 
		
		--Dialog:ShowMessage(player,"Purchase Complete!","Open your inventory to find your item.")

		
		return true
		
	elseif not hasEnough then
		
		if not _G.GamepadEnabled then
			workspace.MessageService.CoinIconVisible:FireClient(player,true)
		end
		
		local get = (_G.GamepadEnabled and "Get Moneyz") or "Get     "
		if Dialog:GetChoice(player,"Not enough Moneyz","You need " .. asset.Price - playerData.Moneyz .. " more Moneyz to buy this item.","Ok",get) then
			workspace.MessageService.CoinIconVisible:FireClient(player,false)
		else
			workspace.MessageService.CoinIconVisible:FireClient(player,false)
			workspace.Main.OpenCatalogTab:FireClient(player,"Moneyz") --promps player to buy moneyz
		end
		
		return false

		
	
	else
		Dialog:ShowMessage(player,"Purchase error","There was an error when buying your item. Try again later.")
		return false
	
	end

	return false
		
end





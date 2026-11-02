local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local Remote = game:FindService('ReplicatedStorage'):FindFirstChild('Gifting')
local Passes = require(game:FindService('ReplicatedStorage'):FindFirstChild('Giftable'))

local PlayerGifted = {}

local Cash = {
	--// CASH
	1897020993, -- 1K Cash
	1897024605, -- 2K Cash
	1896736515, -- 5K Cash
	1896744959 , -- 10K Cash
}

local LevelsList = {
	1896711055, -- 5 Levels
	1896720384, -- 10 Levels
	1896707824, -- 15 Levels
	1896708551, -- 20 Levels
}

local OneTime = {
	1897070383, -- 1911
	1896744724, -- FN 5.7
	1896765014, -- Glock17
	1896765936, -- Mac
	1896736723, -- ARP
	1896759694, -- Draco
}

local Spawns = {
	1891649550, -- Draco
	1891648185, -- HoneyBadger
	1891646284, -- GlockSwitch
	1891661296, -- Knife
	1891654265, -- Mac
	1891657563, -- Glock17
}

Remote.OnServerEvent:Connect(function(plr, pass, userId)
	if not game.Players:GetNameFromUserIdAsync(userId) then return end
	for _, v in next, Passes do
		if v == pass then
			if plr.UserId ~= userId then
				PlayerGifted[plr.UserId] = userId
				game:FindService('MarketplaceService'):PromptProductPurchase(plr, v)
			end
		end
	end
end)


local IDs = {
	['1911'] = 1819589020,
	['Glock17'] = 1819588819,
	['FN 5.7'] = 1819589245,
	['Mac'] = 1819589817,
	['ARPDrum'] = 1819589455,
	['Draco'] = 1819589657
}

local C_1000 = 1819590191
local C_2000 = 1819590388
local C_5000 = 1819590588
local C_10000 = 1819590764

local L_5 = 1819591082
local L_10 = 1819591289
local L_15 = 1819591468
local L_20 = 1819591629

local TimerIncrease = 1830195396
local GymAll = 1854901363

local productFunctions = {}
productFunctions[C_1000] = function(receipt, player)
	if player then
		player.stored.Money.Value += 1000
		return true
	end
end

productFunctions[C_2000] = function(receipt, player)
	if player then
		player.stored.Money.Value += 2000
		return true
	end
end

productFunctions[C_5000] = function(receipt, player)
	if player then
		player.stored.Money.Value += 5000
		return true
	end
end

productFunctions[C_10000] = function(receipt, player)
	if player then
		player.stored.Money.Value += 10000
		return true
	end
end

productFunctions[L_5] = function(receipt, player)
	if player then
		player.stored.Level.Value += 5
		return true
	end
end

productFunctions[L_10] = function(receipt, player)
	if player then
		player.stored.Level.Value += 10
		return true
	end
end

productFunctions[L_15] = function(receipt, player)
	if player then
		player.stored.Level.Value += 15
		return true
	end
end

productFunctions[L_20] = function(receipt, player)
	if player then
		player.stored.Level.Value += 20
		return true
	end
end

productFunctions[TimerIncrease] = function(receipt, player)
	if player then
		player.Extra.PlayTime.Value = 100000
		return true
	end
end

productFunctions[GymAll] = function(receipt, player)
	if player then
		player.stored.GymStrength.Value = 100
		player.stored.GymStamina.Value = 100
		return true
	end
end

for _,v in next, IDs do
	productFunctions[v] = function(receipt, player)
		if player then
			if player.Character then
				if game:FindService('ServerStorage'):FindFirstChild(_) then
					game:FindService('ServerStorage'):FindFirstChild(_):Clone().Parent = player.Backpack
					return true
				end
			end
		end
	end
end

game:FindService('MarketplaceService').ProcessReceipt = function(receiptInfo)
	local userId = receiptInfo.PlayerId
	local productId = receiptInfo.ProductId

	local player = Players:GetPlayerByUserId(userId)
	local Gifting = false
	if player then
		print('Bought', productId)
		if not table.find(Cash, productId) and not table.find(LevelsList, productId) and not table.find(OneTime, productId) and not table.find(Spawns, productId) then
			local handler = productFunctions[productId]
			local success, result = pcall(handler, receiptInfo, player)
			if success then
				return Enum.ProductPurchaseDecision.PurchaseGranted
			else
				warn("Failed to process receipt:", receiptInfo, result)
			end
		else
			for _, v in pairs(Passes) do
				if productId == v then
					local giftUserId = PlayerGifted[userId]
					if giftUserId then
						PlayerGifted[userId] = nil
						local success, err = pcall(function()
							local Player_Received = game:FindService('Players'):GetPlayerByUserId(giftUserId)
							if v == 1897020993 then -- 1K Cash
								Player_Received:FindFirstChild('stored'):FindFirstChild('Money').Value += 1000
							elseif v == 1897024605 then -- 2K Cash
								Player_Received:FindFirstChild('stored'):FindFirstChild('Money').Value += 2000
							elseif v == 1896736515 then -- 5K Cash
								Player_Received:FindFirstChild('stored'):FindFirstChild('Money').Value += 5000
							elseif v == 1896744959 then -- 10K Cash
								Player_Received:FindFirstChild('stored'):FindFirstChild('Money').Value += 10000
							elseif v == 1896711055 then -- 5 Levels
								Player_Received:FindFirstChild('stored'):FindFirstChild('Level').Value += 5
							elseif v == 1896720384 then -- 10 Levels
								Player_Received:FindFirstChild('stored'):FindFirstChild('Level').Value += 10
							elseif v == 1896707824 then -- 15 Levels
								Player_Received:FindFirstChild('stored'):FindFirstChild('Level').Value += 15
							elseif v == 1896708551 then -- 20 Levels
								Player_Received:FindFirstChild('stored'):FindFirstChild('Level').Value += 20
							elseif v == 1897070383 then -- 1911
								game:FindService('ServerStorage'):FindFirstChild('1911'):Clone().Parent = Player_Received:FindFirstChild('Backpack')
							elseif v == 1896765014 then -- Glock17
								game:FindService('ServerStorage'):FindFirstChild('Glock17'):Clone().Parent = Player_Received:FindFirstChild('Backpack')
							elseif v == 1896744724 then -- FN 5.7
								game:FindService('ServerStorage'):FindFirstChild('FN 5.7'):Clone().Parent = Player_Received:FindFirstChild('Backpack')
							elseif v == 1896765936 then -- Mac
								game:FindService('ServerStorage'):FindFirstChild('Mac'):Clone().Parent = Player_Received:FindFirstChild('Backpack')
							elseif v == 1896736723 then -- ARP
								game:FindService('ServerStorage'):FindFirstChild('ARPDrum'):Clone().Parent = Player_Received:FindFirstChild('Backpack')
							elseif v == 1896759694 then -- Draco
								game:FindService('ServerStorage'):FindFirstChild('Draco'):Clone().Parent = Player_Received:FindFirstChild('Backpack')
							elseif v == 1891649550 then -- Draco SPAWNER
								if Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value == '' then
									Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value = 'Draco'
								else
									Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value = Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value + ' Draco'
								end
							elseif v == 1891648185 then -- HoneyBadger SPAWNER
								if Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value == '' then
									Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value = 'HoneyBadger'
								else
									Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value = Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value + ' HoneyBadger'
								end
							elseif v == 1891646284 then -- GlockSwitch SPAWNER
								if Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value == '' then
									Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value = 'GlockSwitch'
								else
									Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value = Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value + ' GlockSwitch'
								end
							elseif v == 1891661296 then -- Knife SPAWNER
								if Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value == '' then
									Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value = 'Knife'
								else
									Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value = Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value + ' Knife'
								end
							elseif v == 1891654265 then -- Mac SPAWNER
								if Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value == '' then
									Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value = 'Mac'
								else
									Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value = Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value + ' Mac'
								end
							elseif v == 1891657563 then -- Glock17 SPAWNER
								if Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value == '' then
									Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value = 'Glock17'
								else
									Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value = Player_Received:FindFirstChild('stored'):FindFirstChild('Spawners').Value + ' Glock17'
								end
							else
								print('RARE ERROR! ID:', tostring(v))
							end
							game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(game:FindService('Players'):GetPlayerByUserId(giftUserId), 'YOU GOT GIFTED A GAMEPASS/PRODUCT BY ' .. game:FindService('Players'):GetNameFromUserIdAsync(userId) .. '!' , 10)
						end)
						if success then return Enum.ProductPurchaseDecision.PurchaseGranted	else return Enum.ProductPurchaseDecision.NotProcessedYet end
					else return Enum.ProductPurchaseDecision.NotProcessedYet end
				end
			end
		end
	else
		print('RARE ERROR PLAYER NOT FOUND!')
	end
	return Enum.ProductPurchaseDecision.NotProcessedYet
end
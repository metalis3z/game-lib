local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataHandler = require(game.ServerScriptService.DataService.DataHandler)
local Config = require(ReplicatedStorage:WaitForChild("Config"))

local function processReceipt(receiptInfo)
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	
	local data = DataHandler.Get(player)
	if not data then return Enum.ProductPurchaseDecision.NotProcessedYet end
	
	local productId = receiptInfo.ProductId
	
	if productId == Config.DEV_PRODUCTS.SPEED_150K then
		data.TotalXP = data.TotalXP + 150000
	elseif productId == Config.DEV_PRODUCTS.SPEED_1M then
		data.TotalXP = data.TotalXP + 1000000
	elseif productId == Config.DEV_PRODUCTS.SPEED_10M then
		data.TotalXP = data.TotalXP + 10000000
	elseif productId == Config.DEV_PRODUCTS.SPEED_50M then
		data.TotalXP = data.TotalXP + 50000000
	elseif productId == Config.DEV_PRODUCTS.SPEED_500M then
		data.TotalXP = data.TotalXP + 500000000
	elseif productId == Config.DEV_PRODUCTS.SPEED_1B then
		data.TotalXP = data.TotalXP + 1000000000
	end
	
	if productId == Config.DEV_PRODUCTS.INSTANT_REBIRTH_T1 or 
	   productId == Config.DEV_PRODUCTS.INSTANT_REBIRTH_T2 or 
	   productId == Config.DEV_PRODUCTS.INSTANT_REBIRTH_T3 then
		data.Rebirths = data.Rebirths + 1
		local tier = Config.REBIRTH_TIERS[data.Rebirths]
		if tier then
			data.Multiplier = tier.multiplier
		end
	end
	
	for _, checkpoint in ipairs(Config.CHECKPOINTS) do
		if productId == checkpoint.RobuxProductId then
			data.Checkpoint = _ 
			local stagePart = workspace:FindFirstChild("Stages") and workspace.Stages:FindFirstChild(checkpoint.Name)
			if stagePart then
				player.Character:MoveTo(stagePart.Position + Vector3.new(0, 5, 0))
			end
			break
		end
	end
	
	ReplicatedStorage.Remotes.UpdateUI:FireClient(player, data)
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		if leaderstats:FindFirstChild("Speed") then leaderstats.Speed.Value = tostring(data.TotalXP) end
		if leaderstats:FindFirstChild("Wins") then leaderstats.Wins.Value = data.Wins end
		if leaderstats:FindFirstChild("Rebirths") then leaderstats.Rebirths.Value = data.Rebirths end
	end
	
	return Enum.ProductPurchaseDecision.PurchaseGranted
end

MarketplaceService.ProcessReceipt = processReceipt

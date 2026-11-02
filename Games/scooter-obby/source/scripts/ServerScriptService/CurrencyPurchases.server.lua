local rs = game:GetService("ReplicatedStorage")
local sss = game:GetService("ServerScriptService")
local sh = require(sss.SkipHandler)
local ih = require(game.ServerScriptService.InventoryHandler)
local ch = sss.StageUpdater.CoinTake
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local CollectionService = game:GetService("CollectionService")

local stageObjects = {}

local stageDebounce = false

for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do
	local stage = cp:GetAttribute("Stage")

	if not stageObjects[stage] then
		stageObjects[stage] = {}
	end

	table.insert(stageObjects[stage], cp)
end

local productFunctions = {}

-- nuke all servers

-- kill all

productFunctions[1668829119] = function(receipt, player)
	game.ServerScriptService.Nuke.AddToQueue:Fire()
end

-- premium box

productFunctions[1683568989] = function(receipt, player)
	local currentTime = tick()
	
	local item, duplicate = ih.SpinPremiumBox(player)
	local rarity = ih.GetItemRarity(item)
	if duplicate then
		game.ServerScriptService.StageUpdater.CoinTake:Fire(player, 7500)
		rs.RemoteEvents.cashNotification:FireClient(player, "7500")
	end
	rs.RemoteEvents.crateRequest:FireClient(player, item, rarity, duplicate)
	wait(1.5)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying a premium box 🥳",Color3.new(0,1,0), false)
end

-- neon premium box

productFunctions[1710739663] = function(receipt, player)
	local currentTime = tick()

	local item, duplicate = ih.SpinPremiumNeonBox(player)
	local rarity = ih.GetItemRarity(item)
	if duplicate then
		game.ServerScriptService.StageUpdater.CoinTake:Fire(player, 7500)
		rs.RemoteEvents.cashNotification:FireClient(player, "7500")
	end
	rs.RemoteEvents.crateRequest:FireClient(player, item, rarity, duplicate)
	wait(1.5)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying a premium box 🥳",Color3.new(0,1,0), false)
end

-- UGC box

productFunctions[1694624645] = function(receipt, player)
	local currentTime = tick()
	game.ReplicatedStorage.RemoteEvents.ugcCrateRequest:Fire(player)
	wait(1.5)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying a UGC box 🥳",Color3.new(0,1,0), false)
end

-- coins

productFunctions[1684541416] = function(receipt, player)
	ch:Fire(player, 5000)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying 5,000 coins! 🥳",Color3.new(0,1,0), true)
end

productFunctions[1684541442] = function(receipt, player)
	ch:Fire(player, 10000)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying 10,000 coins! 🥳",Color3.new(0,1,0), true)
end

productFunctions[1684541513] = function(receipt, player)
	ch:Fire(player, 25000)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, [[Thank you for buying 25,000 coins! 🥳]],Color3.new(0,1,0), true)
end

productFunctions[1684542284] = function(receipt, player)
	ch:Fire(player, 25000)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying 50,000 coins! 🥳",Color3.new(0,1,0), true)
end

productFunctions[1684541559] = function(receipt, player)
	ch:Fire(player, 100000)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying 100,000 coins! 🥳",Color3.new(0,1,0), true)
end

productFunctions[1684542814] = function(receipt, player)
	ch:Fire(player, 250000)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying 250,000 coins! 🥳",Color3.new(0,1,0), true)
end

-- skips

productFunctions[1684487921] = function(receipt, player)
	sh.AddSkips(player,1)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying 1 skip! 🥳",Color3.new(0,1,0), true)
end

productFunctions[1684488016] = function(receipt, player)
	sh.AddSkips(player,5)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying 5 skips! 🥳",Color3.new(0,1,0), true)
end

productFunctions[1684487957] = function(receipt, player)
	sh.AddSkips(player,10)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying 10 skips! 🥳",Color3.new(0,1,0), true)
end

productFunctions[1694696047] = function(receipt, player)
	sss.SpinScript.GiveSkips:Fire(player, 1)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying 1 spin! 🥳",Color3.new(0,1,0), true)
end

productFunctions[1694696318] = function(receipt, player)
	sss.SpinScript.GiveSkips:Fire(player, 10)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying 10 spins! 🥳",Color3.new(0,1,0), true)
end

productFunctions[1694696770] = function(receipt, player)
	sss.SpinScript.GiveSkips:Fire(player, 100)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying 100 spins! 🥳",Color3.new(0,1,0), true)
end

productFunctions[1684487881] = function(receipt, player)
	sh.AddSkips(player,25)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying 25 skips! 🥳",Color3.new(0,1,0), true)
end

productFunctions[1684498660] = function(receipt, player)
	sh.AddSkips(player,50)
	rs.SpecialFX.TriggerConfetti:FireClient(player)
	player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "Thank you for buying 50 skips! 🥳",Color3.new(0,1,0), true)
end

local function processReceipt(receiptInfo)
	local userId = receiptInfo.PlayerId
	local productId = receiptInfo.ProductId

	local player = Players:GetPlayerByUserId(userId)
	if player then
		local handler = productFunctions[productId]
		local success, result = pcall(handler, receiptInfo, player)
		if success then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			warn("Failed to process receipt:", receiptInfo, result)
		end
	end

	return Enum.ProductPurchaseDecision.NotProcessedYet
end

MarketplaceService.ProcessReceipt = processReceipt
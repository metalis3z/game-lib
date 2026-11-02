local ShopService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")

local ModdedShopService = require(ServerScriptService.Services.ModdedShopService)
local MerchShopService = require(ServerScriptService.Services["MerchShopService "])

local EventService = require(ServerScriptService.Services.EventService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local PlotService = require(ServerScriptService.Services.PlotService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local LuckService = require(ServerScriptService.Services.LuckService)

local Net = require(ReplicatedStorage.Packages.Net)
local Shop = require(ReplicatedStorage.Datas.Shop)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local SharedGame = require(ReplicatedStorage.Shared.Game)
local UnlockBase = require(ReplicatedStorage.Datas.UnlockBase)
local SantaData = require(ReplicatedStorage.Datas.SantaMerchantData)

local PurchaseRemote = Net:RemoteEvent("ShopService/Purchase")
local PurchaseRemote2 = Net:RemoteEvent("ModdedShopService/Purchase")

local PendingUnlocks = {} :: {[number]: {player: Player, targetUserId: number, productId: number, floor: number}}
local PendingModded = {} :: {[number]: {player: Player, brainrot: string, purchaseType: string}}

local LastPurchaseAttempt = {}
local SuspiciousActivity = {}
local PURCHASE_COOLDOWN = 1.0
local SUSPICION_THRESHOLD = 5
local BAN_DURATION = 86400

local function logSuspiciousActivity(player, reason)
	local userId = player.UserId
	SuspiciousActivity[userId] = (SuspiciousActivity[userId] or 0) + 1
	warn("[ANTI-DUPE] Activité suspecte: " .. player.Name .. " - " .. reason .. " (Score: " .. SuspiciousActivity[userId] .. ")")
	-- Ban désactivé : juste logger l'activité suspecte
	if SuspiciousActivity[userId] >= SUSPICION_THRESHOLD then
		warn("[ANTI-DUPE] Seuil atteint pour " .. player.Name .. " mais kick désactivé")
		SuspiciousActivity[userId] = 0 -- Reset pour éviter accumulation
	end
end

local LuckyBlocksAmount = {
	[3559686937] = 1,
	[3559687278] = 3,
	[3555794274] = 10
}

local PotOfGoldBaseProducts = {
	[3559685461] = true,
	[3559685691] = true
}

local PREMIUM_LEPRECHAUN_LUCKY_BLOCK_ID = 3559686937

local function santaStockAttribute(name)
	return "SantaMerchant_" .. name:gsub("%s", "_")
end

local function getSantaItemByProductId(productId)
	for _, item in ipairs(SantaData.Brainrots) do
		if item.ProductId == productId then
			return item
		end
	end
end

function ShopService:ProcessPurchase(player: Player, productId: number)
	print("[PROCESS] ProcessPurchase appelé -", player.Name, "| productId:", productId)

	-- Bloquer l'achat de l'Admin Panel
	if productId == 1800820512 then
		print("[PROCESS] Achat Admin Panel bloqué pour", player.Name)
		return
	end

	-- RNGMachine products
	local RNGMachineData = require(ReplicatedStorage.Datas.RNGMachineData)
	if productId == RNGMachineData.SkipProductId then
		local RNGMachineService = ServerScriptService.Services:FindFirstChild("RNGMachineService")
		if RNGMachineService then
			local svc = require(RNGMachineService)
			if svc.SkipCooldown then
				svc:SkipCooldown(player)
			end
		end
		return
	end
	if productId == RNGMachineData.LuckProductId then
		local RNGMachineService = ServerScriptService.Services:FindFirstChild("RNGMachineService")
		if RNGMachineService then
			local svc = require(RNGMachineService)
			if svc.ActivateLuck then
				svc:ActivateLuck(player)
			end
		end
		return
	end

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		warn("[PROCESS] Pas de playerChannel pour", player.Name)
		return
	end

	if PendingModded[productId] then
		local moddedData = PendingModded[productId]
		print("[PROCESS] PendingModded trouvé pour productId:", productId)
		if moddedData.player == player then
			ModdedShopService.Process(player, moddedData.brainrot, moddedData.purchaseType)
			PendingModded[productId] = nil
		end
		return
	end

	local productInfo = Shop[productId]
	if not productInfo then
		warn("[PROCESS] productInfo NIL pour productId:", productId)
		return
	end

	print("[PROCESS] productInfo trouvé - Type:", productInfo.Type, "| Display:", productInfo.Display)

	if PendingUnlocks[productId] then
		local unlockData = PendingUnlocks[productId]
		print("[PROCESS] PendingUnlocks trouvé pour productId:", productId)
		if unlockData.player == player then
			local targetPlayer = Players:GetPlayerByUserId(unlockData.targetUserId)
			if targetPlayer then
				local targetPlot = PlotService.getPlot(targetPlayer)
				if targetPlot then
					local targetPlotChannel = Synchronizer:Get(targetPlot.Name)
					local blockTimeKey = "BlockEndTimeFirstFloor"
					if targetPlotChannel then
						if unlockData.floor == 2 then
							blockTimeKey = "BlockEndTimeSecondFloor"
						elseif unlockData.floor == 3 then
							blockTimeKey = "BlockEndTimeThirdFloor"
						end
						targetPlotChannel:Set(blockTimeKey, nil)
						targetPlotChannel:Set("BlockedDelayTime", workspace:GetServerTimeNow() + 10)
						if targetPlot:FindFirstChild("LaserHitbox") then
							for _, laser in pairs(targetPlot.LaserHitbox:GetChildren()) do
								if laser:GetAttribute("Floor") == unlockData.floor and laser:IsA("BasePart") then
									laser.CanCollide = false
								end
							end
						end
						if targetPlot:FindFirstChild("Laser") then
							for _, laser in pairs(targetPlot.Laser:GetDescendants()) do
								if laser:GetAttribute("Floor") == unlockData.floor and laser:IsA("BasePart") then
									laser.Transparency = 1
								end
							end
						end
						if targetPlot:FindFirstChild("Unlock") then
							for _, unlockModel in pairs(targetPlot.Unlock:GetChildren()) do
								local unlockBase = unlockModel:FindFirstChild("Main")
								if unlockBase and unlockBase:FindFirstChild("UnlockBase") then
									if unlockBase.UnlockBase:GetAttribute("Floor") == unlockData.floor then
										unlockBase.UnlockBase.Enabled = false
									end
								end
							end
						end
						NotificationService.Notify(targetPlayer, string.format("%s broke into your base!", player.DisplayName), 5, "Sounds.Sfx.Unlock")
						NotificationService.Success(player, string.format("you successfully broke into %s base!", targetPlayer.DisplayName))
						task.delay(10, function()
							if targetPlotChannel and getmetatable(targetPlotChannel) then
								targetPlotChannel:Set("BlockedDelayTime", nil)
							end
						end)
					end
				end
			end
			PendingUnlocks[productId] = nil
		end
		return
	end

	if productInfo.Type == "Coins" then
		print("[PROCESS] Type Coins - ajout de", productInfo.Value)
		local baseAmount = productInfo.Value or 0
		local rebirthMultiplier = playerChannel:Get("Rebirth") or 0
		if rebirthMultiplier > 0 then
			baseAmount = baseAmount * (rebirthMultiplier <= 1 and 1.5 or rebirthMultiplier)
		end
		MoneyService:Add(player, baseAmount)
		print("[PROCESS] Coins ajoutés:", baseAmount)

	elseif productInfo.Type == "Gamepass" or productInfo.Type == "GamepassProduct" then
		print("[PROCESS] Type Gamepass/GamepassProduct - Display:", productInfo.Display)
		playerChannel:InsertOnDictionary("Gamepass", productInfo.Display, true)
		if productInfo.Display == "Admin Commands" then
			player:SetAttribute("AdminCommands", true)
		end

	elseif productInfo.Type == "Item" then
		print("[PROCESS] Type Item - Display:", productInfo.Display)
		playerChannel:InsertOnDictionary("Items", productInfo.Display, true)
		playerChannel:InsertOnDictionary("Gamepass", productInfo.Display, true)

	elseif productInfo.Type == "StarterPack" then
		print("[PROCESS] Type StarterPack")
		playerChannel:InsertOnDictionary("Gamepass", productInfo.Type, true)
		for _, item in pairs(productInfo.Rewards.Items) do
			playerChannel:InsertOnDictionary("Items", item, true)
		end
		for _, animal in pairs(productInfo.Rewards.Animals) do
			AnimalService.spawnAnimalInBase(player, animal)
		end
		playerChannel:Increase("Coins", productInfo.Rewards.Coins)

	elseif productInfo.Type == "Brainrot" then
		print("[PROCESS] Type Brainrot - animal:", productInfo.Value)
		AnimalService.spawnAnimalInBase(player, productInfo.Value)
		print("[PROCESS] Brainrot spawné:", productInfo.Value)

	elseif productInfo.Type == "LuckyBlock" then
		local amount = LuckyBlocksAmount[productId] or 1
		print("[PROCESS] Type LuckyBlock - animal:", productInfo.Value, "| amount:", amount)
		for i = 1, amount do
			AnimalService.spawnAnimalInBase(player, productInfo.Value)
		end
		print("[PROCESS] LuckyBlock(s) spawné(s)")

	elseif PotOfGoldBaseProducts[productId] then
		print("[PROCESS] PotOfGoldBase - productId:", productId)
		local unlocked = playerChannel:Get("UnlockedBaseSkins")
		if type(unlocked) ~= "table" then
			unlocked = {}
		end
		unlocked["Pot of Gold"] = true
		playerChannel:Set("UnlockedBaseSkins", unlocked)
		local premiumLB = Shop[PREMIUM_LEPRECHAUN_LUCKY_BLOCK_ID]
		if premiumLB and premiumLB.Type == "LuckyBlock" then
			AnimalService.spawnAnimalInBase(player, premiumLB.Value)
		end

	-- 🔓 Achat Robux d'une base skin (Teykx, Cursed, Divine, Galaxy, YinYang, etc.)
	-- Debloque la base DE FACON PERMANENTE (sauvegardee dans UnlockedBaseSkins, persiste via DataService)
	-- ET l'equipe direct sur le joueur (Settings.Base Skin), applique visuellement, et la garde pour toujours meme apres avoir quitte/rejoint
	elseif productInfo.Type == "Base" and productInfo.Value then
		print("[PROCESS] BaseSkin achete - productId:", productId, "| skin:", productInfo.Value)
		local unlocked = playerChannel:Get("UnlockedBaseSkins")
		if type(unlocked) ~= "table" then
			unlocked = {}
		end
		unlocked[productInfo.Value] = true
		playerChannel:Set("UnlockedBaseSkins", unlocked)

		-- Equipe direct la base achetee
		playerChannel:Set("Settings.Base Skin", productInfo.Value)

		local success, err = pcall(function()
			PlotService:RebuildBase(player)
		end)
		if not success then
			warn("[PROCESS] Erreur RebuildBase apres achat BaseSkin:", err)
		end

		NotificationService.Success(player, string.format("You permanently unlocked and equipped the %s base!", productInfo.Value))

	elseif productInfo.Type == "RainbowMachine" then
		NotificationService.Error(player, "nil")

	elseif productInfo.Type == "FuseMachineRevealNow" then
		if productInfo.Callback then productInfo.Callback(player) end

	elseif productInfo.Type == "CraftingMachineClaimNow" then
		if productInfo.Callback then productInfo.Callback(player) end

	elseif productInfo.Type == "CupidsMachineSkip" then
		if productInfo.Callback then productInfo.Callback(player) end

	elseif productInfo.Display == "2x Server Luck" then
		print("[PROCESS] 2x Server Luck")
		local endTime = LuckService:GetEndTime()
		if endTime ~= 0 then
			endTime += 900
		else
			endTime = workspace:GetServerTimeNow() + 900
		end
		LuckService:StartLuck(1, endTime)
		print("[PROCESS] 2x Luck démarré, endTime:", endTime)

	elseif productInfo.Display == "4x Server Luck" then
		print("[PROCESS] 4x Server Luck")
		local endTime = LuckService:GetEndTime()
		if endTime ~= 0 then
			endTime += 900
		else
			endTime = workspace:GetServerTimeNow() + 900
		end
		LuckService:StartLuck(2, endTime)
		print("[PROCESS] 4x Luck démarré, endTime:", endTime)

	elseif productInfo.Display == "8x Server Luck" then
		print("[PROCESS] 8x Server Luck")
		local endTime = LuckService:GetEndTime()
		if endTime ~= 0 then
			endTime += 900
		else
			endTime = workspace:GetServerTimeNow() + 900
		end
		LuckService:StartLuck(3, endTime)
		print("[PROCESS] 8x Luck démarré, endTime:", endTime)

	elseif productInfo.Type == "YinYangWheelSpin" then
		print("[PROCESS] YinYangWheelSpin")
		playerChannel:Increase("YinYangSpinWheel.Spins", productInfo.Value)
		playerChannel:Increase(string.format("YinYangSpinWheel.PaidSpins.%*", productInfo.Identifier), 1)

	elseif productInfo.Type == "RadioactiveWheelSpin" then
		print("[PROCESS] RadioactiveWheelSpin")
		playerChannel:Increase("RadioactiveSpinWheel.Spins", productInfo.Value)
		playerChannel:Increase(string.format("RadioactiveSpinWheel.PaidSpins.%*", productInfo.Identifier), 1)

	elseif productInfo.Type == "CursedWheelSpin" then
		print("[PROCESS] CursedWheelSpin")
		playerChannel:Increase("CursedSpinWheel.Spins", productInfo.Value)
		playerChannel:Increase(string.format("CursedSpinWheel.PaidSpins.%*", productInfo.Identifier), 1)

	elseif productInfo.Type == "DivineWheelSpin" then
		print("[PROCESS] DivineWheelSpin")
		playerChannel:Increase("DivineSpinWheel.Spins", productInfo.Value)
		playerChannel:Increase(string.format("DivineSpinWheel.PaidSpins.%*", productInfo.Identifier), 1)

	else
		warn("[PROCESS] Aucun type reconnu pour:", productInfo.Type, "| Display:", productInfo.Display)
	end
end

PurchaseRemote.OnServerEvent:Connect(function(player: Player, productId: number, Userid)
	print("[REMOTE] OnServerEvent reçu -", player.Name, "| productId:", productId, "| Userid:", Userid)

	if type(productId) ~= "number" then
		logSuspiciousActivity(player, "ProductId invalide: " .. type(productId))
		return
	end

	local now = os.time()
	local lastAttempt = LastPurchaseAttempt[player]
	if lastAttempt and now - lastAttempt < PURCHASE_COOLDOWN then
		logSuspiciousActivity(player, "Tentative d'achat trop rapide")
		return
	end
	LastPurchaseAttempt[player] = now

	local santaItem = getSantaItemByProductId(productId)
	if santaItem then
		local stock = ReplicatedStorage:GetAttribute(santaStockAttribute(santaItem.Brainrot)) or 0
		if stock <= 0 then
			NotificationService.Error(player, "Out of stock!")
			return
		end
	end

	local productInfo = Shop[productId]
	if not productInfo then
		warn("[REMOTE] productInfo NIL pour productId:", productId)
		NotificationService.Error(player, "Product not found!")
		return
	end

	print("[REMOTE] productInfo trouvé - Type:", productInfo.Type, "| Display:", productInfo.Display)

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		warn("[REMOTE] Pas de playerChannel pour", player.Name)
		return
	end

	if Userid and type(Userid) == "number" then
		print("[REMOTE] Gifting détecté pour UserId:", Userid)
		if player.Name == "Abderrlol" then
			local floorToUnlock = nil
			for floor, data in pairs(UnlockBase) do
				if data.ProductId == productId then
					floorToUnlock = floor
					break
				end
			end
			if floorToUnlock then
				local targetPlayer = Players:GetPlayerByUserId(Userid)
				if not targetPlayer then
					NotificationService.Error(player, "Target player not found!")
					return
				end
				local targetPlot = PlotService.getPlot(targetPlayer)
				if not targetPlot then
					NotificationService.Error(player, "Target player's base not found!")
					return
				end
				local targetPlotChannel = Synchronizer:Get(targetPlot.Name)
				if not targetPlotChannel then
					NotificationService.Error(player, "Could not access target base!")
					return
				end
				local blockTimeKey = "BlockEndTimeFirstFloor"
				if floorToUnlock == 2 then
					blockTimeKey = "BlockEndTimeSecondFloor"
				elseif floorToUnlock == 3 then
					blockTimeKey = "BlockEndTimeThirdFloor"
				end
				local endTime = workspace:GetServerTimeNow() + 10
				targetPlotChannel:Set(blockTimeKey, endTime)
				targetPlotChannel:Set("BlockedDelayTime", endTime)
				PendingUnlocks[productId] = {
					player = player,
					targetUserId = Userid,
					productId = productId,
					floor = floorToUnlock
				}
				task.defer(function()
					ShopService:ProcessPurchase(player, productId)
				end)
				task.delay(10, function()
					if targetPlotChannel and getmetatable(targetPlotChannel) then
						targetPlotChannel:Set("BlockedDelayTime", nil)
					end
				end)
				return
			end
		end

		local floorToUnlock = nil
		for floor, data in pairs(UnlockBase) do
			if data.ProductId == productId then
				floorToUnlock = floor
				break
			end
		end
		if floorToUnlock then
			local targetPlayer = Players:GetPlayerByUserId(Userid)
			if not targetPlayer then
				NotificationService.Error(player, "Target player not found!")
				return
			end
			local targetPlot = PlotService.getPlot(targetPlayer)
			if not targetPlot then
				NotificationService.Error(player, "Target player's base not found!")
				return
			end
			local targetPlotChannel = Synchronizer:Get(targetPlot.Name)
			if not targetPlotChannel then
				NotificationService.Error(player, "Could not access target base!")
				return
			end
			PendingUnlocks[productId] = {
				player = player,
				targetUserId = Userid,
				productId = productId,
				floor = floorToUnlock
			}
			if productInfo.Type == "Gamepass" or productInfo.Type == "GamepassProduct" then
				MarketplaceService:PromptGamePassPurchase(player, productId)
			else
				MarketplaceService:PromptProductPurchase(player, productId)
			end
			return
		end
	end

	if productInfo.Type == "Gamepass" or productInfo.Type == "GamepassProduct" or productInfo.Type == "Item" then
		local ownsGamepass = playerChannel:Get(string.format("Gamepass.%s", productInfo.Display))
		if ownsGamepass then
			print("[REMOTE] Produit déjà owned:", productInfo.Display)
			NotificationService.Error(player, "You can't purchase this product!")
			return
		end
	end

	if productInfo.Type == "StarterPack" then
		if PlotService:IsBaseFull(player) then
			NotificationService.Error(player, "You can't purchase this product!")
			return
		end
	elseif productInfo.Type == "LuckyBlock" then
		if PlotService:IsBaseFull(player) then
			NotificationService.Error(player, "You can't purchase this product, base is full!")
			return
		end
	end

	print("[REMOTE] Envoi du prompt achat pour productId:", productId, "| Type:", productInfo.Type)

	if productInfo.Type == "Gamepass" or productInfo.Type == "GamepassProduct" then
		MarketplaceService:PromptGamePassPurchase(player, productId)
	else
		MarketplaceService:PromptProductPurchase(player, productId)
	end
end)

PurchaseRemote2.OnServerEvent:Connect(function(player: Player, productId: number, brainrot: string, typeA: string)
	print("[REMOTE2] OnServerEvent reçu -", player.Name, "| productId:", productId, "| brainrot:", brainrot, "| type:", typeA)

	if type(productId) ~= "number" then
		logSuspiciousActivity(player, "ModdedShop productId invalide")
		return
	end
	if type(brainrot) ~= "string" or #brainrot > 100 then
		logSuspiciousActivity(player, "ModdedShop brainrot invalide")
		return
	end
	if type(typeA) ~= "string" then
		logSuspiciousActivity(player, "ModdedShop typeA invalide")
		return
	end

	local now = os.time()
	local lastAttempt = LastPurchaseAttempt[player]
	if lastAttempt and now - lastAttempt < PURCHASE_COOLDOWN then
		logSuspiciousActivity(player, "Tentative d'achat modded trop rapide")
		return
	end
	LastPurchaseAttempt[player] = now

	if PlotService:IsBaseFull(player) and typeA == "Base" or PlotService:IsBaseFull(player) and typeA == "3b8ebc3e-a3a0-11f0-8de9-0242ac120002" then
		NotificationService.Error(player, "You can't purchase this product, base is full!")
		return
	end

	PendingModded[productId] = {
		player = player,
		brainrot = brainrot,
		purchaseType = typeA,
	}

	MarketplaceService:PromptProductPurchase(player, productId)
end)

local started = false
function ShopService:Start()
	if started then
		warn("[START] Déjà démarré, ignoré!")
		return
	end
	started = true
	print("[START] ShopService:Start() appelé !")

	MarketplaceService.ProcessReceipt = function(receiptInfo)
		print("[RECEIPT] Déclenché! PlayerId:", receiptInfo.PlayerId, "| ProductId:", receiptInfo.ProductId)
		local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
		if not player then
			warn("[RECEIPT] Joueur introuvable pour UserId:", receiptInfo.PlayerId)
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end
		local merchResult = MerchShopService:ProcessReceipt(receiptInfo)
		if merchResult == Enum.ProductPurchaseDecision.PurchaseGranted then
			print("[RECEIPT] Géré par MerchShopService")
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
		local success, err = pcall(function()
			ShopService:ProcessPurchase(player, receiptInfo.ProductId)
		end)
		if success then
			print("[RECEIPT] ProcessPurchase réussi pour", player.Name, "| productId:", receiptInfo.ProductId)
			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			warn("[RECEIPT] ERREUR dans ProcessPurchase:", err)
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end
	end

	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player: Player, gamepassId: number, wasPurchased: boolean)
		print("[GAMEPASS] PromptGamePassPurchaseFinished -", player.Name, "| gamepassId:", gamepassId, "| wasPurchased:", wasPurchased)
		if wasPurchased then
			local success, err = pcall(function()
				ShopService:ProcessPurchase(player, gamepassId)
			end)
			if not success then
				warn("[GAMEPASS] ERREUR:", err)
			end
		end
	end)
end

Players.PlayerAdded:Connect(function(player: Player)
	local playerChannel = Synchronizer:Wait(player)
	if not playerChannel then return end

	-- 🔓 Sync des bases (Game Passes) deja possedees par le joueur, meme si l'evenement d'achat n'a pas ete recu dans cette session
	task.spawn(function()
		local ok, unlocked = pcall(function()
			return playerChannel:Get("UnlockedBaseSkins")
		end)
		if not ok or type(unlocked) ~= "table" then
			unlocked = {}
		end
		local changed = false
		for productId, productInfo in pairs(Shop) do
			if type(productInfo) == "table" and productInfo.Type == "Base" and productInfo.Value then
				if not unlocked[productInfo.Value] then
					local owns = false
					pcall(function()
						owns = MarketplaceService:UserOwnsGamePassAsync(player.UserId, productId)
					end)
					if owns then
						unlocked[productInfo.Value] = true
						changed = true
					end
				end
			end
		end
		if changed then
			playerChannel:Set("UnlockedBaseSkins", unlocked)
		end
	end)

	local ownsAdminCommands = playerChannel:Get("Gamepass.Admin Commands")
	if ownsAdminCommands then
		player:SetAttribute("AdminCommands", true)
	end

	local ownsVIP = playerChannel:Get("Gamepass.VIP")
	if ownsVIP then
		player:SetAttribute("VIP", true)
	end
end)

Players.PlayerRemoving:Connect(function(player)
	LastPurchaseAttempt[player] = nil
	SuspiciousActivity[player.UserId] = nil
end)

ShopService:Start()
return ShopService
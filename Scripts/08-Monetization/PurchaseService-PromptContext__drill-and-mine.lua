-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: ServerScriptService/Source/Services/PurchaseService.lua  (404 lines)
-- What it does: Server-side prompt that remembers a pending purchase and context string, routes the grant by context, checks the client context against the configured product id, logs Robux spent and posts a rich-text 'X bought Y' message with verified/premium glyphs.

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local LuckyBlockService = require(ServerScriptService.Source.Services.LuckyBlockService)
local LostBrainrotService = require(ServerScriptService.Source.Services.LostBrainrotService)
local GlobalMessageService = require(ServerScriptService.Source.Services.GlobalMessageService)

local PurchaseService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local PurchaseRemotes = Remotes:WaitForChild("PurchaseService")
local PromptPurchaseFunc = PurchaseRemotes:WaitForChild("PromptPurchase")
local PurchaseResultEvent = PurchaseRemotes:WaitForChild("PurchaseResult")

local pendingPurchases = {}
local randomBrainrotResultEvent = nil
local playerDataUpdateEvent = nil

local NAME_COLORS = {
	"#FF4D6D",
	"#FFB703",
	"#00D4FF",
	"#7CFF6B",
	"#B967FF",
	"#FF7A00",
	"#00FFC6",
}

local function escapeRichText(value)
	return tostring(value or ""):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"):gsub("'", "&apos;")
end

local function getProductInfo(id, infoType)
	local ok, info = pcall(function()
		return MarketplaceService:GetProductInfo(id, infoType)
	end)
	if ok then
		return info
	end
	return nil
end

-- Roblox font private-use glyphs (same trick as the U+E002 Robux sign):
-- U+E000 = verified badge, U+E001 = Premium logo. Both are real glyphs in
-- the chat font, so buyers' platform badges render as the official icons
-- right next to their name in the announcement.
local VERIFIED_GLYPH = utf8.char(0xE000)
local PREMIUM_GLYPH = utf8.char(0xE001)

local function getBadgeGlyphs(player)
	local badges = ""
	if player.HasVerifiedBadge then
		badges = badges .. VERIFIED_GLYPH
	end
	if player.MembershipType == Enum.MembershipType.Premium then
		badges = badges .. PREMIUM_GLYPH
	end
	return badges
end

local function sendPurchaseMessage(player, info)
	if not player or not info then return end

	local nameColor = NAME_COLORS[math.random(1, #NAME_COLORS)]
	local playerName = escapeRichText(player.Name)
	local productName = escapeRichText(info.Name or "Unknown Item")
	local price = tonumber(info.PriceInRobux) or 0
	-- badges sit OUTSIDE the name's color tag: the icons stay white like the
	-- platform draws them instead of inheriting the random name color
	local badges = getBadgeGlyphs(player)

	GlobalMessageService.Send(
		'<font color="' .. nameColor .. '"><b>' .. playerName .. '</b></font>'
			.. (badges ~= "" and '<font color="#FFFFFF">' .. badges .. '</font>' or "")
			.. ' <font color="#FFFFFF">has purchased the <b>' .. productName .. '</b> for </font>'
			.. '<font color="#00FF66"><b>' .. price .. ' Robux</b></font>'
			.. '<font color="#FFFFFF"><b>!</b></font>'
	)
end

local function recordPurchase(player, id, infoType, info)
	task.spawn(function()
		info = info or getProductInfo(id, infoType)
		if not info then return end
		local price = info.PriceInRobux or 0
		local data = PlayerDataService.GetPlayerData(player)
		if data then
			data.TotalRobuxSpent = (data.TotalRobuxSpent or 0) + price
			table.insert(data.PurchaseHistory, { Id = id, Price = price, Playtime = data.TotalPlaytime or 0 })
		end
		sendPurchaseMessage(player, info)
	end)
end

-- Server-initiated gamepass prompt (training ore pads). Fires the same
-- "Prompting" PurchaseResult the product path uses so the client
-- BuyTransition overlay opens; success/cancel resolve client-side via
-- PromptGamePassPurchaseFinished (BuyTransitionController closes the
-- overlay, GamepassService mirrors ownership, and the handler below
-- records + announces the purchase).
function PurchaseService.PromptGamePass(player, gamepassId, context)
	if not player or not gamepassId or gamepassId == 0 then return end
	PurchaseResultEvent:FireClient(player, "Prompting", context or "Gamepass")
	MarketplaceService:PromptGamePassPurchase(player, gamepassId)
end

function PurchaseService.PromptProduct(player, productId, context, callback)
	if not player or not productId or productId == 0 then
		if callback then callback(false) end
		return
	end

	pendingPurchases[player] = {
		ProductId = productId,
		Callback = callback,
		Context = context or "Unknown",
	}

	PurchaseResultEvent:FireClient(player, "Prompting", context)
	MarketplaceService:PromptProductPurchase(player, productId)
end

local function processReceipt(receiptInfo)
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local pending = pendingPurchases[player]

	if pending and pending.ProductId == receiptInfo.ProductId then
		pendingPurchases[player] = nil

		PurchaseResultEvent:FireClient(player, "Success", pending.Context)

		if pending.Callback then
			local ok, err = pcall(pending.Callback, true)
			if not ok then
				warn("[PurchaseService] Callback error:", err)
			end
		end

		recordPurchase(player, receiptInfo.ProductId, Enum.InfoType.Product)
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	warn("[PurchaseService] Unhandled product:", receiptInfo.ProductId, "for", player.Name)
	return Enum.ProductPurchaseDecision.NotProcessedYet
end

local function onPromptFinished(userId, productId, isPurchased)
	local player = Players:GetPlayerByUserId(userId)
	if not player then return end

	if not isPurchased then
		local pending = pendingPurchases[player]
		if pending and pending.ProductId == productId then
			pendingPurchases[player] = nil

			PurchaseResultEvent:FireClient(player, "Cancelled", pending.Context)

			if pending.Callback then
				pcall(pending.Callback, false)
			end
		end
	end
end

function PurchaseService.Init()
	randomBrainrotResultEvent = PurchaseRemotes:FindFirstChild("RandomBrainrotResult")
	if not randomBrainrotResultEvent then
		randomBrainrotResultEvent = Instance.new("RemoteEvent")
		randomBrainrotResultEvent.Name = "RandomBrainrotResult"
		randomBrainrotResultEvent.Parent = PurchaseRemotes
	end
	playerDataUpdateEvent = Remotes:WaitForChild("PlayerDataService"):FindFirstChild("DataUpdate")

	MarketplaceService.ProcessReceipt = processReceipt
	MarketplaceService.PromptProductPurchaseFinished:Connect(onPromptFinished)
	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(purchasePlayer, gamePassId, wasPurchased)
		if wasPurchased then
			recordPurchase(purchasePlayer, gamePassId, Enum.InfoType.GamePass)
		end
	end)

	PromptPurchaseFunc.OnServerInvoke = function(player, productId, context)
		if type(productId) ~= "number" or productId == 0 then return false end
		if type(context) ~= "string" then context = "Unknown" end

		local done = false
		local result = false

		local wrappedCallback = function(success)
			if success and context:sub(1, 5) == "Pack_" then
				local packName = context:sub(6)
				local StoreService = require(ServerScriptService.Source.Services.StoreService)
				StoreService.ProcessPackPurchase(player, packName)
			end

			if success and context:sub(1, 7) == "ShopLB_" then
				local key = context:sub(8)
				local shopCfg = GameConfig.Shop and GameConfig.Shop.LuckyBlock
				local tier = shopCfg and shopCfg.Tiers and shopCfg.Tiers[key]
				if tier and tier.Amount then
					LuckyBlockService.InstantOpenForShop(player, "Exclusive", tier.Amount)
				end
			end

			-- Store lucky-block tier cards: context is "ShopLBR_<key>". Same
			-- product-id guard as BuyDrill/BuyStrength; grants ONE instant-open
			-- of the configured block model (fixes the loot rarity pool).
			if success and context:sub(1, 8) == "ShopLBR_" then
				local key = context:sub(9)
				local cfg = GameConfig.Shop and GameConfig.Shop.LuckyBlockStore and GameConfig.Shop.LuckyBlockStore[key]
				if cfg and cfg.ProductId ~= 0 and cfg.ProductId == productId then
					LuckyBlockService.InstantOpenForShop(player, cfg.BlockId, 1)
				else
					warn("[PurchaseService] ShopLBR context/product mismatch:", context, productId, "from", player.Name)
				end
			end

			-- Store lucky-block cards (dev products, repeatable): context is
			-- "LootBlock_<key>" -- every purchase grants ONE GrantBlockId block
			-- into the inventory. Same client-context/product-id guard.
			if success and context:sub(1, 10) == "LootBlock_" then
				local key = context:sub(11)
				local cfg = GameConfig.Shop and GameConfig.Shop.LuckyBlockStore and GameConfig.Shop.LuckyBlockStore[key]
				if cfg and cfg.ProductId ~= 0 and cfg.ProductId == productId then
					local LootBlockService = require(ServerScriptService.Source.Services.LootBlockService)
					LootBlockService.GrantStoreBlock(player, key)
				else
					warn("[PurchaseService] LootBlock context/product mismatch:", context, productId, "from", player.Name)
				end
			end

			-- Drill shop Robux purchases: context is "BuyDrill_<modelName>"
			-- (drill names contain spaces + dashes, which is fine in a context
			-- string). The context comes from the CLIENT, so require that the
			-- purchased product id is exactly the one configured for that drill
			-- -- otherwise a cheap product + spoofed context would grant an
			-- endgame drill. Grant + auto-equip through DrillShopService.
			if success and context:sub(1, 9) == "BuyDrill_" then
				local drillName = context:sub(10)
				local drillCfg = GameConfig.Drills and GameConfig.Drills[drillName]
				if drillCfg and drillCfg.ProductId ~= 0 and drillCfg.ProductId == productId then
					local DrillShopService = require(ServerScriptService.Source.Services.DrillShopService)
					DrillShopService.GrantDrill(player, drillName)
				else
					warn("[PurchaseService] BuyDrill context/product mismatch:", context, productId, "from", player.Name)
				end
			end

			-- Trail shop Robux purchases: context is "BuyTrail_<name>". Same
			-- product-id guard as BuyDrill (client-supplied context must match
			-- the configured product). Grant + auto-equip through TrailShopService.
			if success and context:sub(1, 9) == "BuyTrail_" then
				local trailName = context:sub(10)
				local trailCfg = GameConfig.Trails and GameConfig.Trails[trailName]
				if trailCfg and trailCfg.ProductId ~= 0 and trailCfg.ProductId == productId then
					local TrailShopService = require(ServerScriptService.Source.Services.TrailShopService)
					TrailShopService.GrantTrail(player, trailName)
				else
					warn("[PurchaseService] BuyTrail context/product mismatch:", context, productId, "from", player.Name)
				end
			end

			if success and context:sub(1, 9) == "ShopCash_" then
				local key = context:sub(10)
				local StoreService = require(ServerScriptService.Source.Services.StoreService)
				StoreService.ProcessShopCashPurchase(player, key)
			end

			-- Strength shop: context is "BuyStrength_<key>". The context comes
			-- from the CLIENT, so require that the purchased product id is exactly
			-- the one configured for that offer (same guard as BuyDrill). Grant
			-- goes through StrengthClickServer's bindable so XP/levels follow.
			if success and context:sub(1, 12) == "BuyStrength_" then
				local key = context:sub(13)
				local cfg = GameConfig.StrengthShop and GameConfig.StrengthShop[key]
				if cfg and cfg.ProductId ~= 0 and cfg.ProductId == productId then
					local clickServer = ServerScriptService:FindFirstChild("StrengthClickServer")
					local grant = clickServer and clickServer:FindFirstChild("GrantStrength")
					if grant then
						grant:Fire(player, cfg.Amount)
					else
						warn("[PurchaseService] GrantStrength bindable not found for", context)
					end
				else
					warn("[PurchaseService] BuyStrength context/product mismatch:", context, productId, "from", player.Name)
				end
			end

			if success and context == "RandomBrainrot" then
				local pool = {}
				for brainrotId, cfg in pairs(GameConfig.Items) do
					if not cfg.IsPercentBrainrot then
						table.insert(pool, brainrotId)
					end
				end
				if #pool > 0 then
					local chosenId = pool[math.random(1, #pool)]
					local mutationId = GameConfig.RollIslandMutation and GameConfig.RollIslandMutation() or nil
					local playerData = PlayerDataService.GetPlayerData(player)
					if playerData then
						local brainrotInv = playerData.BrainrotInventory
						if not brainrotInv then
							playerData.BrainrotInventory = {}
							brainrotInv = playerData.BrainrotInventory
						end
						local ts = os.time()
						local uniqueId = chosenId .. "_" .. tostring(ts) .. "_" .. tostring(math.random(1000, 9999))
						brainrotInv[uniqueId] = {
							BrainrotId = chosenId,
							Mutation = mutationId,
							Timestamp = ts,
						}
						playerData.BrainrotUnlocked[chosenId] = true
						PlayerDataService.DataChanged:Fire(player, "BrainrotInventory", brainrotInv)
						PlayerDataService.DataChanged:Fire(player, "BrainrotUnlocked", playerData.BrainrotUnlocked)
						if playerDataUpdateEvent then
							playerDataUpdateEvent:FireClient(player, "BrainrotInventory", brainrotInv)
							playerDataUpdateEvent:FireClient(player, "BrainrotUnlocked", playerData.BrainrotUnlocked)
						end
						PlayerDataService.ScheduleSave(player)
						if randomBrainrotResultEvent then
							randomBrainrotResultEvent:FireClient(player, chosenId, chosenId, mutationId)
						end
					end
				end
			end

			-- LostBrainrots recovery: context is "LostBrainrotsRecover_<token>" where
			-- the token is the one issued by LostBrainrotService.RegisterLoss and sent
			-- to the client via the Show RemoteEvent. The token guard prevents a stale
			-- prompt from a previous loss from re-granting blocks if the player has
			-- since fallen again with a different set of carried blocks.
			if success and context:sub(1, 21) == "LostBrainrotsRecover_" then
				local token = context:sub(22)
				LostBrainrotService.OnRecoveryPurchase(player, token)
			end

			if success and context == "MaterialProduct" then
				local materialCfg = GameConfig.MaterialProduct
				local amount = materialCfg and materialCfg.Amount
				if amount and amount > 0 then
					local MaterialService = require(ServerScriptService.Source.Services.MaterialService)
					MaterialService.AddMaterialOverfill(player, amount)
				end
			end

			-- PickUpButtons "Home" -- ProductId 3595863792. Drains the player's
			-- carried lucky blocks into their inventory (mirror of walking onto
			-- MainIsland) and teleports them to their plot's SpawnLocation. The
			-- two side effects are independent: a player with nothing carried
			-- still gets the teleport.
			if success and context == "HomeTeleport" then
				local IslandBrainrotSpawnerScript = ServerScriptService:FindFirstChild("IslandBrainrotSpawner")
				local DepositCarryBindable = IslandBrainrotSpawnerScript
					and IslandBrainrotSpawnerScript:FindFirstChild("DepositCarry")
				if DepositCarryBindable then
					pcall(function() DepositCarryBindable:Invoke(player) end)
				end

				local plotsFolder = workspace:FindFirstChild("Assets") and workspace.Assets:FindFirstChild("Plots")
				if plotsFolder then
					local targetPlot
					for _, plot in ipairs(plotsFolder:GetChildren()) do
						if plot:GetAttribute("OwnerUserId") == player.UserId then
							targetPlot = plot; break
						end
					end
					local spawnPart = targetPlot and targetPlot:FindFirstChild("SpawnLocation")
					local char = player.Character
					local hrp = char and char:FindFirstChild("HumanoidRootPart")
					if spawnPart and hrp then
						hrp.CFrame = spawnPart.CFrame + Vector3.new(0, 3, 0)
					end
				end
			end

			result = success
			done = true
		end

		PurchaseService.PromptProduct(player, productId, context, wrappedCallback)

		local startTime = os.clock()
		while not done and (os.clock() - startTime) < 60 do
			task.wait(0.1)
		end

		return result
	end

	Players.PlayerRemoving:Connect(function(player)
		pendingPurchases[player] = nil
	end)
end

return PurchaseService

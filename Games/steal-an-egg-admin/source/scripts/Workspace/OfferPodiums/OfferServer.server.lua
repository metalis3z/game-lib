--!nonstrict
-- OfferServer
-- Server-side plumbing for the storefront: the Storefront remotes
-- (AskServerProbe / AskPurchaseOffer / AskFreeGamepass) and developer-product
-- receipt processing with a ProductCredits fallback.
--
-- Treadmill upgrades are bought from the plot's TreadmillUpgrade sign:
--  - cash purchases go through Remotes.Treadmill.AskTierRaise (TreadmillService)
--  - Robux purchases go through PromptPurchase -> the product receipt pipeline
--    below (Products/Builders/Treadmill -> TreadmillService.UpgradeTreadmill)

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Products = require(ReplicatedStorage.Data.Products)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local FreePurchases = require(ReplicatedStorage.Shared.FreePurchases)

local DataService = require(ServerScriptService.DataService)
local AdminPanelService = require(ServerScriptService.AdminPanelService)

local Storefront = Remotes.Storefront

-- ---------------------------------------------------------------------
-- Helpers
-- ---------------------------------------------------------------------

-- Runs a product ServerTest/Callback-style function. A missing function
-- counts as "passes with no error".
local function runTest(fn, player)
	if type(fn) ~= "function" then
		return true, nil
	end
	local ok, passed, err = pcall(fn, player)
	if not ok then
		return false, tostring(passed)
	end
	if passed == true then
		return true, nil
	end
	return false, tostring(err or "Purchase not available right now")
end

local function settle(player, productId)
	local profile = DataService.Get(player)
	if profile and type(profile.Products) == "table" then
		profile.Products[tostring(productId)] = true
		DataService.SyncChange(player, "Products", profile.Products)
	end
	Storefront.PurchaseSettled:FireClient(player, nil, { ProductId = productId })
	print(("[OfferServer] Settled product %s for %s"):format(tostring(productId), player.Name))
end

local function creditProduct(player, productId)
	local profile = DataService.Get(player)
	if not profile then
		return
	end
	local credits = profile.ProductCredits
	if type(credits) ~= "table" then
		credits = {}
		profile.ProductCredits = credits
	end
	local key = tostring(productId)
	credits[key] = (type(credits[key]) == "number" and credits[key] or 0) + 1
	DataService.SyncChange(player, "ProductCredits", credits)
	print(("[OfferServer] Credited product %s for %s"):format(key, player.Name))
end

-- Redeems any stored ProductCredits whose product the player can now receive.
local function redeemCredits(player)
	local profile = DataService.Get(player)
	if not profile or type(profile.ProductCredits) ~= "table" then
		return
	end
	for key, count in pairs(profile.ProductCredits) do
		if type(count) == "number" and count > 0 then
			local productId = tonumber(key)
			local product = productId and Products.ByProductId[productId] or nil
			if product == nil then
				profile.ProductCredits[key] = nil -- product retired; drop the credit
			else
				local testOk, _ = runTest(product.ServerTest, player)
				if testOk then
					local callOk, granted = pcall(product.Callback, player)
					if callOk and granted == true then
						local remaining = count - 1
						if remaining <= 0 then
							profile.ProductCredits[key] = nil
						else
							profile.ProductCredits[key] = remaining
						end
						DataService.SyncChange(player, "ProductCredits", profile.ProductCredits)
						settle(player, productId)
					end
				end
			end
		end
	end
end

-- ---------------------------------------------------------------------
-- Storefront remotes
-- ---------------------------------------------------------------------

Storefront.AskServerProbe.OnServerInvoke = function(player, productId)
	if type(productId) ~= "number" then
		return false, "Invalid request"
	end
	local product = Products.ByProductId[productId]
	if product == nil then
		return false, "Unknown product"
	end
	if not GameFlags.Purchases:Get() then
		return false, "Purchases are temporarily disabled"
	end
	if not DataService.WaitForProfile(player, 15) then
		return false, "Data still loading"
	end
	redeemCredits(player)

	local ok, err = runTest(product.ServerTest, player)
	if ok then
		return true, nil
	end
	return false, err
end

Storefront.AskPurchaseOffer.OnServerInvoke = function(player, productId)
	if type(productId) ~= "number" then
		return false, "Invalid request"
	end
	if not GameFlags.Purchases:Get() then
		return false, "Purchases are temporarily disabled"
	end
	local product = Products.ByProductId[productId]
	if product == nil then
		return false, "Unknown product"
	end

	local ok, err = pcall(MarketplaceService.PromptProductPurchase, MarketplaceService, player, productId)
	if not ok then
		warn(("[OfferServer] PromptProductPurchase failed for %s (%s): %s"):format(player.Name, tostring(productId), tostring(err)))
		return false, "Could not open the purchase prompt"
	end
	return true
end

Storefront.AskFreeGamepass.OnServerInvoke = function(player, gamepassId)
	if type(gamepassId) ~= "number" then
		return false, "Invalid request"
	end
	if not GameFlags.Purchases:Get() then
		return false
	end

	local owns = false
	pcall(function()
		owns = MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
	end)
	if owns then
		return true
	end
	if FreePurchases.AllowsUserId(player.UserId) then
		return true -- studio free-purchase simulation
	end

	local ok = pcall(MarketplaceService.PromptGamePassPurchase, MarketplaceService, player, gamepassId)
	if not ok then
		warn(("[OfferServer] PromptGamePassPurchase failed for %s (%s)"):format(player.Name, tostring(gamepassId)))
		return false
	end
	return true
end

-- ---------------------------------------------------------------------
-- Receipt processing
-- ---------------------------------------------------------------------

local function processProductReceipt(receiptInfo)
	local productId = receiptInfo.ProductId
	local product = Products.ByProductId[productId]
	if product == nil then
		warn(("[OfferServer] Receipt for unknown product %s"):format(tostring(productId)))
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if player == nil then
		return Enum.ProductPurchaseDecision.NotProcessedYet -- re-delivered when they rejoin
	end
	if not DataService.WaitForProfile(player, 15) then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local failureReason
	local testOk, testErr = runTest(product.ServerTest, player)
	if testOk then
		local callOk, granted, grantErr = pcall(product.Callback, player)
		if callOk and granted == true then
			settle(player, productId)
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
		failureReason = tostring(grantErr or "Grant failed")
	else
		failureReason = testErr
	end

	local decision = "Retry"
	if type(product.ResolveFailedReceipt) == "function" then
		local ok, result = pcall(product.ResolveFailedReceipt, player, productId, failureReason)
		if ok and type(result) == "string" then
			decision = result
		end
	end

	if decision == "Satisfied" then
		-- Already owned; consume the receipt without granting again.
		settle(player, productId)
		return Enum.ProductPurchaseDecision.PurchaseGranted
	elseif decision == "Credit" then
		-- Stash a redeemable credit; redeemCredits grants it once eligible.
		creditProduct(player, productId)
		settle(player, productId)
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	Storefront.PurchaseRejected:FireClient(player, { ProductId = productId, Reason = failureReason })
	return Enum.ProductPurchaseDecision.NotProcessedYet
end

local receiptHandler = Instance.new("BindableFunction")
receiptHandler.Name = "InvokeReceipt"
receiptHandler.Parent = script
receiptHandler.OnInvoke = function(receiptInfo)
	local adminDecision = AdminPanelService.HandleReceipt(receiptInfo)
	if adminDecision ~= nil then
		return adminDecision
	end
	return processProductReceipt(receiptInfo)
end

-- The BindableFunction keeps the full pipeline callable/testable from the server;
-- MarketplaceService owns the single receipt callback.
MarketplaceService.ProcessReceipt = function(receiptInfo)
	return receiptHandler:Invoke(receiptInfo)
end

-- ---------------------------------------------------------------------
-- Startup
-- ---------------------------------------------------------------------

local function watchPlayer(player)
	task.spawn(function()
		if DataService.WaitForProfile(player, 30) then
			redeemCredits(player)
		end
	end)
end

Players.PlayerAdded:Connect(watchPlayer)
for _, player in Players:GetPlayers() do
	watchPlayer(player)
end

print("[OfferServer] Storefront remotes wired and receipt processing active")
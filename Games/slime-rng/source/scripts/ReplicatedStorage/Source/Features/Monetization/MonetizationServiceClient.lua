-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: MonetizationServiceClient, time of decompilation: Sun May  3 10:12:03 2026 ]]
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local client = require(ReplicatedStorage.Packages.DataService).client
local Networker = require(ReplicatedStorage.Packages.Networker)
local Signal = require(ReplicatedStorage.Packages.Signal)
local FormatTime = require(ReplicatedStorage.Source.Core.UI.FormatTime)

require(script.Parent.MonetizationServiceUtils)

local LocalPlayer = Players.LocalPlayer
local t1 = {
	giftReceived = Signal.new(),
	purchaseCompleted = Signal.new(),
	policyInfoChanged = Signal.new(),
	policyInfo = {
		AreAdsAllowed = false,
		ArePaidRandomItemsRestricted = true,
		IsContentSharingAllowed = false,
		IsEligibleToPurchaseCommerceProduct = false,
		IsEligibleToPurchaseSubscription = false,
		IsPaidItemTradingAllowed = false,
		IsSubjectToChinaPolicies = true,
		AllowedExternalLinkReferences = {}
	}
}
local t2 = {
	Name = "Loading",
	Description = "Loading",
	PriceInRobux = 0,
	CostText = "Loading"
}
local t3 = {
	Name = "Unknown",
	Description = "Unknown",
	PriceInRobux = -1,
	CostText = "Unknown"
}

local function getProductInfo(p1, n1: number?) -- line: 80
	-- upvalues: RunService (copy), t3 (copy), MarketplaceService (copy), getProductInfo (copy)
	if not RunService:IsRunning() then
		return table.clone(t3)
	end

	local v17 = if not p1.isPass then Enum.InfoType.Product else Enum.InfoType.GamePass
	local ok, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, p1.id, v17)

	if not ok then
		if not n1 or n1 < 5 then
			task.wait(5)

			local v20 = (n1 or 0) + 1

			warn("Failed to get product info for product", p1.key, "retrying...", result, "attempt", v20)

			return getProductInfo(p1, v20)
		end

		warn("Failed to get product info for product", p1.key, "giving up:", result)

		return table.clone(t3)
	end

	return result
end

function t1._initProduct(p2, s1: string, p3) -- line: 101
	-- upvalues: Signal (copy), t2 (copy), getProductInfo (copy), FormatTime (copy), client (copy)
	p3.key = s1
	p3._infoUpdated = Signal.new()
	p3._productInfo = table.clone(t2)
	p3._productInfo = getProductInfo(p3)

	local function update() -- line: 111
		-- upvalues: p3 (copy), p2 (copy), FormatTime (copy)
		if p3.isPass and p2:ownsGamepass(p3) or p3.oneTimePurchase and p2:ownsOneTimePurchase(p3) then
			p3._productInfo.CostText = "Owned"
		elseif p3.purchaseCooldown and p2:isProductOnCooldown(p3) then
			local v67 = p2:getProductCooldownRemaining(p3)

			p3._productInfo.CostText = "Cooldown: " .. FormatTime(v67)
		elseif p3.disabled then
			p3._productInfo.CostText = "Disabled"
		elseif p3.random and p2.policyInfo.ArePaidRandomItemsRestricted then
			p3._productInfo.CostText = "Locked"
		else
			p3._productInfo.CostText = "\238\128\130" .. tostring(p3._productInfo.PriceInRobux)
		end

		p3._infoUpdated:Fire()
	end

	update()
	p2.policyInfoChanged:Connect(update)

	if p3.isPass then
		client:getChangedSignal({
			"__gamepasses",
			(tostring(p3.id))
		}):Connect(update)
	end

	client:getChangedSignal("__oneTimePurchases"):Connect(update)
	client:getChangedSignal("__purchaseCooldowns"):Connect(update)

	if p3.purchaseCooldown and p3.purchaseCooldown > 0 then
		task.spawn(function() -- line: 140
			-- upvalues: update (copy)
			while true do
				update()
				task.wait(1)
			end
		end)
	end
end
function t1._initProducts(p4, t4: {[any]: any}) -- line: 149
	for v27, v28 in t4 do
		task.spawn(function() -- line: 154
			-- upvalues: p4 (copy), v27 (copy), v28 (copy)
			p4:_initProduct(v27, v28)
		end)
	end
end
function t1.init(p5, t5: {[any]: any}) -- line: 160
	-- upvalues: Networker (copy), RunService (copy), PolicyService (copy), LocalPlayer (copy)
	p5.products = t5
	p5.networker = Networker.client.new("MonetizationService", p5)
	p5:_initProducts(t5)
	task.spawn(function() -- line: 165
		-- upvalues: RunService (copy), PolicyService (copy), LocalPlayer (copy), p5 (copy)
		if not RunService:IsRunning() then
			return
		end

		local ok, result = pcall(PolicyService.GetPolicyInfoForPlayerAsync, PolicyService, LocalPlayer)

		while not ok do
			warn("Failed to get policy info for player:", result)
			task.wait(10)
			ok, result = pcall(PolicyService.GetPolicyInfoForPlayerAsync, PolicyService, LocalPlayer)
		end

		p5.policyInfo = result
		p5.policyInfoChanged:Fire()
	end)
end
function t1._receivedGift(p6, p7) -- line: 181
	local v33 = p6.products[p7.productKey]

	p6.giftReceived:Fire(v33, p7)
end
function t1._purchaseCompleted(p8, p9) -- line: 186
	local v36 = p8.products[p9.productKey]

	if not v36 then
		warn("Received purchase completion for unknown product:", p9.productKey)

		return
	end

	p8.purchaseCompleted:Fire(v36, p9)
end
function t1.getProductInfoChangedSignal(_, p11) -- line: 199
	return p11._infoUpdated
end
function t1.getProductInfo(p12, p13) -- line: 203
	return ((if typeof(p13) ~= "number" then p13 else p12:getProductFromId(p13)))._productInfo
end
function t1.getProductCostString(_, p15) -- line: 213
	return p15._productInfo.CostText
end
function t1.getProductFromId(p16, n2: number) -- line: 217
	for _, v46 in p16.products do
		if n2 == v46.id or n2 == v46.giftId then
			return v46
		end
	end

	error("No product for product id " .. n2)
end
function t1.ownsOneTimePurchase(_, p18) -- line: 229
	-- upvalues: client (copy)
	if not p18.oneTimePurchase then
		warn("Product is not a one-time purchase:", p18.key)

		return false
	end

	local v49 = client:get("__oneTimePurchases")

	return v49 ~= nil and v49[tostring(p18.id)]
end
function t1.isProductOnCooldown(p19, p20) -- line: 239
	return p19:getProductCooldownRemaining(p20) > 0
end
function t1.getProductCooldownRemaining(_, p22) -- line: 243
	-- upvalues: client (copy)
	if not p22.purchaseCooldown then
		warn("Product does not have a cooldown:", p22.key)

		return 0
	end

	local v54 = client:get("__purchaseCooldowns")

	if not v54 then
		return 0
	end

	local v55 = v54[tostring(p22.id)]

	if not v55 then
		return 0
	end

	local v56 = workspace:GetServerTimeNow() - v55

	return (math.max(0, p22.purchaseCooldown - v56))
end
function t1.ownsGamepass(_, p24) -- line: 264
	-- upvalues: client (copy)
	local v59 = client:get("__gamepasses")

	return v59 ~= nil and v59[tostring(p24.id)]
end
function t1.promptProduct(p25, p26) -- line: 269
	-- upvalues: MarketplaceService (copy), LocalPlayer (copy)
	if p26.disabled then
		warn("Product is disabled:", p26.key)

		return
	end

	if p26.random and p25.policyInfo.ArePaidRandomItemsRestricted then
		warn("Cannot purchase random items due to policy restrictions")

		return
	end

	if p26.oneTimePurchase and p25:ownsOneTimePurchase(p26) then
		return
	end

	if p26.purchaseCooldown and p25:isProductOnCooldown(p26) then
		return
	end

	if p26.isPass then
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, p26.id)

		return
	end

	MarketplaceService:PromptProductPurchase(LocalPlayer, p26.id)
end
function t1.promptGift(p27, n3: number, p28) -- line: 295
	local v65, v66 = p27.networker:fetch("promptGift", n3, p28.giftId)

	return v65, v66
end

return t1

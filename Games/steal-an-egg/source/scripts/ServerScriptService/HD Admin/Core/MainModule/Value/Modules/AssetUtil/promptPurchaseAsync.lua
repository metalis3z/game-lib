--!strict
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LogService = game:GetService("LogService")
local isClient = RunService:IsClient()
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local products = require(modules.References.products)
local promptProduct: any? = nil
local thirdPartyLogConnection: RBXScriptConnection? = nil

-- The 'AllowThirdPartySales has blocked the purchase prompt' warning only reaches
-- the client that tried to prompt, never the server that invokes it, so we listen
-- here on the buyer's client around the request. If it fires we tell them why
-- nothing appeared, then disconnect
local function watchForThirdPartyBlock()
	if thirdPartyLogConnection then
		thirdPartyLogConnection:Disconnect()
		thirdPartyLogConnection = nil
	end
	thirdPartyLogConnection = LogService.MessageOut:Connect(function(message, messageType)
		if messageType ~= Enum.MessageType.MessageWarning then
			return
		end
		if not tostring(message):match("AllowThirdPartySales") then
			return
		end
		require(modules.Prompt).warn("ThirdPartySales must be enabled by the game owner to prompt this item")
		if thirdPartyLogConnection then
			thirdPartyLogConnection:Disconnect()
			thirdPartyLogConnection = nil
		end
	end)
	task.delay(5, function()
		if thirdPartyLogConnection then
			thirdPartyLogConnection:Disconnect()
			thirdPartyLogConnection = nil
		end
	end)
end

return function(assetIdOrProductName: number | products.ProductName, player: Player?, infoType: Enum.InfoType?)
	if typeof(assetIdOrProductName) ~= "number" then
		local productInfo = products[assetIdOrProductName]
		if not productInfo then
			return false, `Invalid product name: {assetIdOrProductName}`
		end
		assetIdOrProductName = productInfo.id
	end
	local assetId = assetIdOrProductName :: number
	if isClient then
		if not promptProduct then
			local Remote = require(modules.Objects.Remote)
			promptProduct = Remote.get("PromptProduct")
		end
		watchForThirdPartyBlock()
		local infoTypeName: string? = if typeof(infoType) == "EnumItem" then (infoType :: any).Name else nil
		local success, warning = promptProduct:invokeServerAsync(assetId, infoTypeName)
		return success, warning
	end
	if typeof(player) ~= "Instance" or not player:IsA("Player") then
		return false, "Player must be specified on server"
	end
	local resolvedInfoType: Enum.InfoType? = infoType
	local isAccessory: boolean? = nil
	if typeof(resolvedInfoType) ~= "EnumItem" then
		for _, product in products do
			if product.id == assetId then
				resolvedInfoType = product.infoType
				isAccessory = product.infoType == Enum.InfoType.Asset
				break
			end
		end
	end
	if resolvedInfoType == Enum.InfoType.Asset and isAccessory == nil then
		local success, productInfo = pcall(function()
			return MarketplaceService:GetProductInfo(assetId, Enum.InfoType.Asset)
		end)
		if success and productInfo and productInfo.CollectibleItemId then
			isAccessory = true
		end
	end
	local isBundle = resolvedInfoType == Enum.InfoType.Bundle
	if isAccessory or isBundle then
		-- Accessories must be prompted via BulkPurchase
		local promptBulkPurchaseAsync = require(modules.AssetUtil.promptBulkPurchaseAsync)
		local bulkType = if isBundle then Enum.MarketplaceProductType.AvatarBundle else Enum.MarketplaceProductType.AvatarAsset
		return promptBulkPurchaseAsync(assetId, player, bulkType)
	end
	-- tell the buyer's client to expect this HD purchase
	local expectRemote = require(modules.Objects.Remote).find("ExpectPurchase")
	if expectRemote then
		expectRemote:fireClient(player, assetId)
	end
	local success, warning = pcall(function()
		if resolvedInfoType == Enum.InfoType.Asset then
			return MarketplaceService:PromptPurchase(player, assetId)
		elseif resolvedInfoType == Enum.InfoType.Bundle then
			return MarketplaceService:PromptBundlePurchase(player, assetId)
		elseif resolvedInfoType == Enum.InfoType.Product then
			return MarketplaceService:PromptProductPurchase(player, assetId)
		end
		return MarketplaceService:PromptGamePassPurchase(player, assetId)
	end)
	return success, tostring(warning)
end
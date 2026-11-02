local IDs = require(game:GetService("ReplicatedStorage").Shared.List.Shop.IDs)
local MarketplaceService = game:GetService("MarketplaceService")

return function(itemName)
	local item = IDs[itemName]
	if not item then
		warn(":GetProductInfo() - unknown item: " .. tostring(itemName))
		return { Name = "?"; Description = "?"; PriceInRobux = 0 }
	end

	local id, infoType
	if item.gamePassId then
		id = item.gamePassId
		infoType = Enum.InfoType.GamePass
	else
		id = item.productId
		infoType = Enum.InfoType.Product
	end

	if not id then
		warn(":GetProductInfo() - no id for item: " .. tostring(itemName))
		return { Name = "?"; Description = "?"; PriceInRobux = 0 }
	end

	local ok, result = pcall(function()
		return MarketplaceService:GetProductInfo(id, infoType)
	end)
	if not ok then
		warn(":GetProductInfo() error: " .. tostring(result))
		return { Name = "?"; Description = "?"; PriceInRobux = 0 }
	end
	return result
end
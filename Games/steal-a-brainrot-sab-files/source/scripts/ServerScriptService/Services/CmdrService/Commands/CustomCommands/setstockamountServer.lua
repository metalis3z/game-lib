local ServerScriptService = game:GetService("ServerScriptService")
local ShopService = require(ServerScriptService.Services.ShopService)

return function(context, productId, stockAmount)
	local success = ShopService:SetStockAmount(productId, stockAmount)
	if success then
		return string.format("Set stock of product %d to %d.", productId, math.floor(stockAmount))
	else
		return string.format("Failed to set stock of product %d to %d. Check that the product ID is valid and the stock amount is >= 0.", productId, math.floor(stockAmount))
	end
end
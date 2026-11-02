local ServerScriptService = game:GetService("ServerScriptService")

return function(context, productId)
	if context.Executor.UserId ~= 0 and context.Executor.UserId ~= 1215597321 then
		return "Unauthorized."
	end

	productId = tonumber(productId)
	if not productId then
		return "Invalid productId. Must be a number."
	end

	local ShopService = require(ServerScriptService.Services.ShopService)

	if not ShopService.StopFlashSale then
		return "ShopService:StopFlashSale() not available. Please add the method to ShopService first."
	end

	local success, err = pcall(function()
		ShopService:StopFlashSale(productId)
	end)

	if success then
		return string.format("Flash sale stopped for product %d.", productId)
	else
		return "Failed to stop flash sale: " .. tostring(err)
	end
end
local ServerScriptService = game:GetService("ServerScriptService")

return function(context)
	if context.Executor.UserId ~= 0 and context.Executor.UserId ~= 1215597321 then
		return "Unauthorized."
	end

	local ShopService = require(ServerScriptService.Services.ShopService)



	if ShopService.ListFlashSales then
		local sales = ShopService:ListFlashSales()
		if not sales or #sales == 0 then
			return "No active flash sales."
		end

		local lines = {}
		for _, sale in ipairs(sales) do
			local remaining = math.max(0, math.ceil(sale.expiration - workspace:GetServerTimeNow()))
			table.insert(lines, string.format(
				"  Product %d | %s | Stock: %d | Remaining: %ds | Animal: %s",
				sale.productId,
				sale.displayName or "Unknown",
				sale.stock or 0,
				remaining,
				sale.animalName or "N/A"
			))
		end
		return "Active Flash Sales:\n" .. table.concat(lines, "\n")
	else
		return "ShopService:ListFlashSales() not available. Please add the method to ShopService first."
	end
end
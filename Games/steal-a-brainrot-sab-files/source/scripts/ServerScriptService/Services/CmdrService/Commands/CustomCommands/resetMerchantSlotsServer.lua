local ServerScriptService = game:GetService("ServerScriptService")

return function(context)
	if context.Executor.UserId ~= 0 and context.Executor.UserId ~= 1215597321 then
		return "Unauthorized."
	end

	local SantaMerchantService = require(ServerScriptService.Services.SantaMerchantService)

	local ok, err = pcall(function()
		SantaMerchantService:ClearSlotOverrides()
	end)

	if not ok then
		return "Failed to reset merchant slots: " .. tostring(err)
	end

	return "All merchant slot overrides cleared. Reverting to default stock across all servers."
end
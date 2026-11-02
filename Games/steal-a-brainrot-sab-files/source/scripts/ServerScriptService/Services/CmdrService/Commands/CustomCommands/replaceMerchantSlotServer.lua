local ServerScriptService = game:GetService("ServerScriptService")
local NotificationService = require(ServerScriptService.Services.NotificationService)
return function(context, animalName, cost, slot, currency, stockCount)
	if context.Executor.UserId ~= 0 and context.Executor.UserId ~= 1215597321 then
		return "Unauthorized."
	end

	cost = tonumber(cost)
	slot = tonumber(slot)

	if not cost or not slot then
		return "Invalid arguments: cost and slot must be numbers."
	end

	if currency == nil or currency == "" then
		currency = "elf"
	end

	if stockCount == nil or stockCount == "" then
		stockCount = nil
	else
		stockCount = tonumber(stockCount)
		if not stockCount then
			return "Invalid arguments: stockCount must be a number (or blank for unlimited)."
		end
	end

	local SantaMerchantService = require(ServerScriptService.Services.SantaMerchantService)

	local ok, successBool, msg = pcall(function()
		return SantaMerchantService:ReplaceSlot(animalName, cost, slot, currency, stockCount)
	end)

	if not ok then
		return "Failed to override slot: " .. tostring(successBool)
	end

	if successBool == false then
		return "Failed to override slot: " .. tostring(msg)
	end
	local ReplicatedStorage   = game:GetService("ReplicatedStorage")
	local AnimalsDB           = require(ReplicatedStorage.Datas.Animals)
	local Rarities            = require(ReplicatedStorage.Datas.Rarities)
	local function FormatAnimalName(name)
		local animalData = AnimalsDB[name]
		if not animalData then return name end
		local rarityData = Rarities[animalData.Rarity]
		if not rarityData then return animalData.DisplayName or name end
		local displayName = animalData.DisplayName or name
		if rarityData.GradientPreset then
			local gradientMap = { Rainbow="rainbow", Zebra="zebra", OG="og", YellowRed="yellowred", Greenred="greenred" }
			local tag = gradientMap[rarityData.GradientPreset]
			if tag then return string.format("<%s>%s</%s>", tag, displayName, tag) end
		end
		local color = rarityData.Color and rarityData.Color:ToHex() or "FFFFFF"
		return string.format('<font color="#%s">%s</font>', color, displayName)
	end
	local robuxShopName = '<font color="#FF0000"><b>Santa Merchant</b></font>'
	local formattedOutput = FormatAnimalName(animalName)
	return string.format(
		"Merchant slot %d overridden with %s for %d %s (stock: %s). Replicated to all servers.",
		slot, tostring(animalName), cost, tostring(currency),
		stockCount and tostring(stockCount) or "unlimited"
	)
end
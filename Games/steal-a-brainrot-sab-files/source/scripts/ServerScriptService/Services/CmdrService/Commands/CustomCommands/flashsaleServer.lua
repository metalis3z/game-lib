local ServerScriptService = game:GetService("ServerScriptService")

return function(context, productId, amount, duration, displayName, animalName)
	if context.Executor.UserId ~= 0 and context.Executor.UserId ~= 1215597321 then
		return "Unauthorized."
	end

	productId = tonumber(productId)
	amount    = tonumber(amount)
	duration  = tonumber(duration)

	if not productId or not amount or not duration then
		return "Invalid arguments: productId, amount, and duration must be numbers."
	end

	if amount <= 0 then
		return "Amount must be a positive number."
	end

	if duration <= 0 then
		return "Duration must be a positive number of seconds."
	end

	local ShopService = require(ServerScriptService.Services.ShopService)

	local success, err = pcall(function()
		ShopService:CreateFlashSale(productId, amount, duration, displayName, animalName)
	end)
	local NotificationService = require(game.ServerScriptService.Services.NotificationService)
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
	local robuxShopName = '<font color="#FF9222"><b>Robux Shop</b></font>'
	local formattedOutput = FormatAnimalName(animalName)
	NotificationService.Broadcast(
		string.format("cook45 added %s to the %s!", formattedOutput, robuxShopName),
		5, "Sounds.Sfx.Success"
	)
	if success then
		local namePart = displayName and (" (" .. displayName .. ")") or ""
		local animalPart = animalName and (" | Animal: " .. animalName) or ""
		return string.format(
			"Flash sale created! Product %d%s | %d units | %ds duration%s",
			productId, namePart, amount, duration, animalPart
		)
	else
		return "Failed to create flash sale: " .. tostring(err)
	end
end
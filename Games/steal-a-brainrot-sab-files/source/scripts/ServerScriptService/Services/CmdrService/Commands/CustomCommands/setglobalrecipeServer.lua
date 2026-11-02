return function(context, key, rarity, output, recipeStr, cost, craftTime, stock, jobid)
	if not (context.Executor.UserId == 0 or context.Executor.UserId == 1215597321) then
		return "Unauthorized."
	end

	if not key or key == "" then
		return "Missing key."
	end
	if not rarity or rarity == "" then
		return "Missing rarity."
	end
	if not output or output == "" then
		return "Missing output brainrot name."
	end
	if not recipeStr or recipeStr == "" then
		return "Missing recipe."
	end

	local recipe = {}
	for ingredient in recipeStr:gmatch("[^,]+") do
		local trimmed = ingredient:match("^%s*(.-)%s*$")
		if trimmed ~= "" then
			table.insert(recipe, trimmed)
		end
	end

	if #recipe == 0 then
		return "Recipe must have at least one ingredient."
	end

	local CraftingMachineService = require(game.ServerScriptService.Services.CraftingMachineService)

	local ok, err = CraftingMachineService:SetGlobalRecipe(
		key,
		rarity,
		output,
		recipe,
		tonumber(cost)     or 1000000000,
		tonumber(craftTime) or nil,
		tonumber(stock) or nil,
		(jobid and jobid ~= "") and jobid or nil
	)

	if not ok then
		return "Failed: " .. tostring(err)
	end

	local Players             = game:GetService("Players")
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

	return string.format("Global recipe set: key=%s  output=%s  rarity=%s  ingredients=%d", 
		key, output, rarity, #recipe)
end
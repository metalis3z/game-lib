local CodeService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DataStoreService = game:GetService("DataStoreService")
local LimitedCodesStore = DataStoreService:GetDataStore("LimitedCodes")
local CustomCodesStore = DataStoreService:GetDataStore("CustomGeneratedCodes")

local NotificationService = require(ServerScriptService.Services.NotificationService)
local PlotService = require(ServerScriptService.Services.PlotService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(ServerScriptService.Services.AnimalService)

local Net = require(ReplicatedStorage.Packages.Net)
-- Handled via Net:Handle for RequestRedemption RemoteFunction

local RedeemedCodes = {}
local LimitedCodeRedemptions = {}

local CODES = {
	["FAYPLESTUDIOS1"] = {
		Reward = "Coins",
		Amount = 1000,
		Message = "You received 1K Coins!",
	},
	["FAYPLESTUDIOS2"] = {
		Reward = "Coins",
		Amount = 5000,
		Message = "You received 5K Coins!",
	},
	["FAYPLESTUDIOS3"] = {
		Reward = "LuckyBlock",
		Name = "Secret Lucky Block",
		Message = "You received a Secret Lucky Block!",
		Mutations = {
			Normal = 35,
			Gold = 30,
			Diamond = 15,
			Rainbow = 3,
		},
	},
	["FAYPLESTUDIOS4"] = {
		Reward = "LuckyBlock",
		Name = "Mythic Lucky Block",
		Message = "You received a Mythic Lucky Block!",
		Mutations = {
			Normal = 35,
			Gold = 30,
			Diamond = 15,
			Rainbow = 3,
		},
	},
	["FAYPLESTUDIOS5"] = {
		Reward = "LuckyBlock",
		Name = "Secret Lucky Block",
		Message = "You received a Secret Lucky Block!",
		Mutations = {
			Normal = 35,
			Gold = 30,
			Diamond = 15,
			Rainbow = 3,
		},
	},
	["FAYPLESTUDIOS6"] = {
		Reward = "Coins",
		Amount = 10000,
		Message = "Thank you for playing! Here's 10K Coins!",
	},
	["FAYPLESTUDIOS7"] = {
		Reward = "LuckyBlock",
		Name = "Secret Lucky Block",
		Message = "You received a Secret Lucky Block!",
		Mutations = {
			Normal = 35,
			Gold = 30,
			Diamond = 15,
			Rainbow = 3,
		},
	},
	["FAYPLESTUDIOS8"] = {
		Reward = "LuckyBlock",
		Name = "Premium Festive Lucky Block",
		Message = "You received a Premium FestiveLucky Block!",
		Mutations = {
			Normal = 35,
			Cyber = 2,
			Gold = 30,
			Diamond = 15,
			Rainbow = 3,
		},
	},
	["FAYPLESTUDIOS9"] = {
		Reward = "Coins",
		Amount = 500000000000000,
		Message = "Thank you for playing! Here's 500T Coins!",
	},
	["FAYPLESTUDIOS10"] = {
		Reward = "Brainrot",
		Name = "Strawberry Elephant",
		Message = "You received a Strawberry Elephant!",
		Limited = 1,
		Mutations = {
			Normal = 65,
			Gold = 25,
			Diamond = 8,
			Rainbow = 2,
		},
	},
	["FAYPLESTUDIOS11"] = {
		Reward = "Brainrot",
		Name = "Tictac Sahur",
		Message = "You received a Tictac Sahur!",
		Limited = 3,
		Mutations = {
			Normal = 65,
			Gold = 35,
			Diamond = 15,
			Rainbow = 5,
		},
	},
}

local function getPlayerRedeemedCodes(player)
	if not RedeemedCodes[player.UserId] then
		RedeemedCodes[player.UserId] = {}
	end
	return RedeemedCodes[player.UserId]
end

local function normalizeCode(code)
	return string.upper(string.gsub(tostring(code or ""), "^%s*(.-)%s*$", "%1"))
end

local function resolveBrainrotName(brainrotName)
	local text = tostring(brainrotName or "")
	local normalized = string.lower(text)

	for animalName, animalData in pairs(AnimalsData) do
		if string.lower(tostring(animalName)) == normalized then
			return animalName
		end

		if typeof(animalData) == "table" then
			if string.lower(tostring(animalData.Name or "")) == normalized then
				return animalName
			end
			if string.lower(tostring(animalData.DisplayName or "")) == normalized then
				return animalName
			end
		end
	end

	return nil
end

local function loadCustomCode(normalizedCode)
	local success, storedCodeData = pcall(function()
		return CustomCodesStore:GetAsync(normalizedCode)
	end)

	if not success or typeof(storedCodeData) ~= "table" then
		return nil
	end

	if typeof(storedCodeData.Name) ~= "string" and storedCodeData.Reward ~= "Coins" then
		return nil
	end

	CODES[normalizedCode] = storedCodeData
	return storedCodeData
end

local function getCodeData(code)
	local normalizedCode = normalizeCode(code)
	for codeName, codeData in pairs(CODES) do
		if normalizeCode(codeName) == normalizedCode then
			return codeName, codeData
		end
	end

	local customCodeData = loadCustomCode(normalizedCode)
	if customCodeData then
		return normalizedCode, customCodeData
	end

	return nil, nil
end

function CodeService.AddCustomCode(codeName, rewardType, rewardData)
	local normalizedCode = normalizeCode(codeName)
	if normalizedCode == "" then
		return false, "Code name cannot be empty."
	end

	if rewardType ~= "Brainrot" and rewardType ~= "LuckyBlock" and rewardType ~= "Coins" then
		return false, "Invalid reward type: " .. tostring(rewardType)
	end

	if typeof(rewardData) ~= "table" then
		return false, "Reward data must be a table."
	end

	if not rewardData.Name or rewardData.Name == "" then
		return false, "Reward data must include a Name."
	end

	-- Resolve brainrot name case-insensitively for Brainrot/LuckyBlock rewards
	if rewardType == "Brainrot" or rewardType == "LuckyBlock" then
		local resolved = resolveBrainrotName(rewardData.Name)
		if not resolved then
			return false, ("Brainrot %q was not found."):format(tostring(rewardData.Name))
		end
		rewardData.Name = resolved
	end

	rewardData.Reward = rewardType
	rewardData.CustomGenerated = true
	rewardData.CreatedAt = os.time()

	-- Ensure Amount is set (default 1)
	rewardData.Amount = tonumber(rewardData.Amount) or 1
	if rewardData.Amount < 1 then rewardData.Amount = 1 end

	CODES[normalizedCode] = rewardData

	local success, err = pcall(function()
		CustomCodesStore:SetAsync(normalizedCode, rewardData)
	end)

	if not success then
		warn("[CodeService] Custom code saved in current server only:", normalizedCode, err)
		return true, ("Code %s created in this server only (DataStore save failed: %s)."):format(normalizedCode, tostring(err))
	end

	return true, ("Code %s created successfully."):format(normalizedCode)
end

function CodeService.RemoveCode(codeName)
	local normalizedCode = normalizeCode(codeName)
	if normalizedCode == "" then
		return false, "Code name cannot be empty."
	end

	if CODES[normalizedCode] then
		CODES[normalizedCode] = nil
	else
		return false, "Code '" .. normalizedCode .. "' not found."
	end

	-- Also try to remove from DataStore if it was a custom code
	pcall(function()
		CustomCodesStore:RemoveAsync(normalizedCode)
	end)

	pcall(function()
		LimitedCodesStore:RemoveAsync(normalizedCode)
	end)

	return true, "Code '" .. normalizedCode .. "' has been deleted."
end

function CodeService.GetCodesTable()
	return CODES
end

function CodeService.GenerateCustomBrainrotCode(code, brainrotName)
	local normalizedCode = normalizeCode(code)
	if normalizedCode == "" then
		return false, "Code name cannot be empty."
	end

	local resolvedBrainrot = resolveBrainrotName(brainrotName)
	if not resolvedBrainrot then
		return false, ("Brainrot %q was not found."):format(tostring(brainrotName))
	end

	local codeData = {
		Reward = "Brainrot",
		Name = resolvedBrainrot,
		Message = ("You received a %s!"):format(resolvedBrainrot),
		CustomGenerated = true,
		CreatedAt = os.time(),
	}

	CODES[normalizedCode] = codeData

	local success, err = pcall(function()
		CustomCodesStore:SetAsync(normalizedCode, codeData)
	end)

	if not success then
		warn("[CodeService] Custom code saved in current server only:", normalizedCode, err)
		return true, ("Generated code %s for %s in this server. DataStore save failed, so remake it after restart."):format(normalizedCode, resolvedBrainrot)
	end

	return true, ("Generated code %s for %s."):format(normalizedCode, resolvedBrainrot)
end

function CodeService.GenerateLimitedBrainrotCode(code, brainrotName, quantity)
	local normalizedCode = normalizeCode(code)
	if normalizedCode == "" then
		return false, "Code name cannot be empty."
	end

	local resolvedBrainrot = resolveBrainrotName(brainrotName)
	if not resolvedBrainrot then
		return false, ("Brainrot %q was not found."):format(tostring(brainrotName))
	end

	local limit = tonumber(quantity)
	if not limit or limit <= 0 then
		return false, "Quantity must be a positive number."
	end

	local codeData = {
		Reward = "Brainrot",
		Name = resolvedBrainrot,
		Message = ("You received a %s!"):format(resolvedBrainrot),
		Limited = limit,
		CustomGenerated = true,
		CreatedAt = os.time(),
	}

	CODES[normalizedCode] = codeData

	local success, err = pcall(function()
		CustomCodesStore:SetAsync(normalizedCode, codeData)
	end)

	if not success then
		warn("[CodeService] Limited custom code saved in current server only:", normalizedCode, err)
		return true, ("Generated code %s for %s (%d uses) in this server. DataStore save failed."):format(normalizedCode, resolvedBrainrot, limit)
	end

	return true, ("Generated limited code %s for %s (%d uses)."):format(normalizedCode, resolvedBrainrot, limit)
end

function CodeService.RedeemCode(player, code)
	if not player or not code then
		return false, "Invalid request"
	end

	local codeName, codeData = getCodeData(code)
	if not codeData then
		return false, "Invalid code!"
	end

	code = codeName

	if codeData.Expires and os.time() > codeData.Expires then
		return false, "This code has expired!"
	end

	local finalMessage = codeData.Message

	local playerCodes = getPlayerRedeemedCodes(player)
	if playerCodes[code] then
		return false, "You already redeemed this code!"
	end

	if codeData.Limited then
		local currentCount = LimitedCodesStore:GetAsync(code) or 0
		if currentCount >= codeData.Limited then
			return false, "Code Was Already Redeemed"
		end
		LimitedCodesStore:SetAsync(code, currentCount + 1)
	end

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		return false, "Please wait and try again"
	end

	if codeData.Reward == "Coins" then
		MoneyService:Add(player, codeData.Amount)

	elseif codeData.Reward == "LuckyBlock" then
		if PlotService:IsBaseFull(player) then
			return false, "Your base is full! Make room first."
		end
		local codeAnimalData = AnimalsData[codeData.Name]
		if codeAnimalData then
			AnimalService.spawnAnimalCustom(codeAnimalData, nil, nil, nil, nil, nil)
		else
			warn("[CodeService] Animal introuvable pour le code brainrot:", codeData.Name)
		end

	elseif codeData.Reward == "Item" then
		playerChannel:InsertOnDictionary("Items", codeData.Name, true)
		playerChannel:InsertOnDictionary("Gamepass", codeData.Name, true)

	elseif codeData.Reward == "Brainrot" then
		if PlotService:IsBaseFull(player) then
			return false, "Your base is full! Make room first."
		end

		local mutation = nil
		if codeData.Mutations then
			local totalWeight = 0
			for _, weight in pairs(codeData.Mutations) do
				totalWeight = totalWeight + weight
			end

			local roll = math.random() * totalWeight

			if roll < codeData.Mutations.Rainbow then
				mutation = "Rainbow"
			elseif roll < codeData.Mutations.Rainbow + codeData.Mutations.Diamond then
				mutation = "Diamond"
			elseif roll < codeData.Mutations.Rainbow + codeData.Mutations.Diamond + codeData.Mutations.Gold then
				mutation = "Gold"
			else
				mutation = nil
			end
		end

		local limitedCodeAnimalData = AnimalsData[codeData.Name]
		if limitedCodeAnimalData then
			local spawnAmount = tonumber(codeData.Amount) or 1
			for i = 1, spawnAmount do
				-- Re-roll mutation for each animal if multiple
				local useMutation = mutation
				if spawnAmount > 1 and codeData.Mutations then
					local totalWeight = 0
					for _, weight in pairs(codeData.Mutations) do
						totalWeight = totalWeight + weight
					end
					local roll = math.random() * totalWeight
					if roll < (codeData.Mutations.Rainbow or 0) then
						useMutation = "Rainbow"
					elseif roll < (codeData.Mutations.Rainbow or 0) + (codeData.Mutations.Diamond or 0) then
						useMutation = "Diamond"
					elseif roll < (codeData.Mutations.Rainbow or 0) + (codeData.Mutations.Diamond or 0) + (codeData.Mutations.Gold or 0) then
						useMutation = "Gold"
					else
						useMutation = nil
					end
				end
				-- Check base full before each spawn
				if PlotService:IsBaseFull(player) then
					break
				end
				AnimalService.spawnAnimalCustom(limitedCodeAnimalData, useMutation, nil, nil, nil, nil)
			end
		else
			warn("[CodeService] Animal introuvable pour le code brainrot limité:", codeData.Name)
		end
	end

	playerCodes[code] = true

	NotificationService.Success(player, finalMessage)
	return true, finalMessage
end

function CodeService:Start()
	Net:Handle("RequestRedemption", function(player, code)
		local success, message = self.RedeemCode(player, code)
		if not success then
			NotificationService.Error(player, message)
		end
		return success, message
	end)
end

return CodeService
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local BrainrotTraderData = require(ServerStorage.Modules.BrainrotTraderData)
local AnimalData = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local PlotService = require(ServerScriptService.Services.PlotService)
local StealService = require(ServerScriptService.Services.StealService)

local BrainrotTraderService = {}

local Animation = Net:RemoteEvent("BrainrotTraderService/Animation")
local Update    = Net:RemoteEvent("BrainrotTraderService/Update")
local Return    = Net:RemoteEvent("BrainrotTraderService/Return")
local Trade     = Net:RemoteEvent("BrainrotTraderService/Trade")
local Delivery  = Net:RemoteFunction("BrainrotTraderService/Delivery")
local Fetch     = Net:RemoteFunction("BrainrotTraderService/Fetch")
local SetRecipeRemote = Net:RemoteFunction("BrainrotTraderService/SetRecipe")
local RemoveRecipeRemote = Net:RemoteFunction("BrainrotTraderService/RemoveRecipe")
local REFRESH_INTERVAL = 1800

local CurrentTrader = { Refresh = 0, List = {} }
local RefreshTime   = 0
local PlayerPodiums = {}

local function BroadcastTrader()
	for _, plr in Players:GetPlayers() do
		Update:FireClient(plr, CurrentTrader)
	end
end

local function GenerateRecipes()
	local rarityOrder = { "Rare", "Epic", "Legendary", "Mythic", "Brainrot God", "Secret" }

	local brainrotInfo = {}
	local rarityBuckets = {}
	for _, entry in ipairs(BrainrotTraderData.Groups.Brainrots.Brainrots) do
		brainrotInfo[entry.Name] = entry
		rarityBuckets[entry.Rarity] = rarityBuckets[entry.Rarity] or {}
		table.insert(rarityBuckets[entry.Rarity], entry.Name)
	end

	local recipesByName = {}
	for _, entry in ipairs(BrainrotTraderData.Groups.Requirements.Brainrots) do
		recipesByName[entry.Name] = entry.Requirements
	end

	local function getValidRecipes(brainrotName)
		local options = recipesByName[brainrotName]
		if not options then return nil end
		local valid = {}
		for _, recipe in ipairs(options) do
			if #recipe > 0 then
				local allOk = true
				for _, animalName in ipairs(recipe) do
					if not AnimalData[animalName] then
						allOk = false
						warn(string.format(
							"[BrainrotTraderService] Recipe for %q references missing animal %q; skipping that recipe option",
							brainrotName, animalName
							))
						break
					end
				end
				if allOk then
					table.insert(valid, recipe)
				end
			end
		end
		return valid
	end

	CurrentTrader = {
		Refresh = Workspace:GetServerTimeNow() + REFRESH_INTERVAL,
		List = {},
	}
	RefreshTime = CurrentTrader.Refresh

	local slotIndex = 1

	for _, rarity in ipairs(rarityOrder) do
		if rarityBuckets[rarity] and slotIndex <= 7 then
			local candidates = {}
			for _, name in ipairs(rarityBuckets[rarity]) do
				if AnimalData[name] then
					local validRecipes = getValidRecipes(name)
					if validRecipes and #validRecipes > 0 then
						table.insert(candidates, { name = name, recipes = validRecipes })
					end
				else
					warn("Missing animal definition: " .. name .. " in rarity: " .. rarity)
				end
			end

			if #candidates > 0 then
				local chosen = candidates[math.random(1, #candidates)]
				local recipe = chosen.recipes[math.random(1, #chosen.recipes)]

				local recipeCopy = {}
				for i, animalName in ipairs(recipe) do
					recipeCopy[i] = animalName
				end

				local info = brainrotInfo[chosen.name]
				CurrentTrader.List[tostring(slotIndex)] = {
					Name = chosen.name,
					Template = (info and info.Template) or "Normal",
					Recipe = recipeCopy,
				}

				slotIndex = slotIndex + 1
			end
		end
	end
end

function BrainrotTraderService.RefreshTrader()
	GenerateRecipes()
	BroadcastTrader()
end

function BrainrotTraderService:SetCustomRecipe(animalName, recipe)
	if animalName == nil or type(recipe) ~= "table" then
		warn("[BrainrotTraderService:SetCustomRecipe] slotId, animalName and recipe (table) are required")
		return false
	end

	if not AnimalData[animalName] then
		warn(string.format(
			"[BrainrotTraderService:SetCustomRecipe] reward animal %q is not in AnimalData",
			tostring(animalName)
			))
		return false
	end

	if #recipe == 0 then
		warn("[BrainrotTraderService:SetCustomRecipe] recipe must contain at least one animal")
		return false
	end

	local normalizedRecipe = {}
	for i, recipeAnimal in ipairs(recipe) do
		if type(recipeAnimal) ~= "string" then
			warn(string.format(
				"[BrainrotTraderService:SetCustomRecipe] recipe entry #%d must be a string", i
				))
			return false
		end
		if not AnimalData[recipeAnimal] then
			warn(string.format(
				"[BrainrotTraderService:SetCustomRecipe] recipe animal %q (slot %d) is not in AnimalData",
				recipeAnimal, i
				))
			return false
		end
		normalizedRecipe[i] = recipeAnimal
	end

	local resolvedTemplate = nil
	if not resolvedTemplate then
		for _, entry in ipairs(BrainrotTraderData.Groups.Brainrots.Brainrots) do
			if entry.Name == animalName then
				resolvedTemplate = entry.Template
				break
			end
		end
	end
	resolvedTemplate = resolvedTemplate or "Normal"

	local highestSlot = 0
	for key in CurrentTrader.List do
		local num = tonumber(string.match(tostring(key), "%d+"))
		if num and num > highestSlot then
			highestSlot = num
		end
	end

	local newSlotId = tostring(highestSlot + 1)

	CurrentTrader.List[newSlotId] = {
		Name = animalName,
		Template = resolvedTemplate,
		Recipe = normalizedRecipe,
	}

	BroadcastTrader()
	return true
end
function BrainrotTraderService:RemoveRecipe(animalName)
	if animalName == nil or type(animalName) ~= "string" then
		warn("[BrainrotTraderService:RemoveRecipe] animalName (string) is required")
		return false
	end

	local found = false
	local slotsToRemove = {}

	for slotId, slotData in pairs(CurrentTrader.List) do
		if slotData.Name == animalName then
			table.insert(slotsToRemove, slotId)
			found = true
		end
	end

	if not found then
		warn(string.format(
			"[BrainrotTraderService:RemoveRecipe] No recipe found with reward animal %q",
			animalName
			))
		return false
	end

	for _, slotId in ipairs(slotsToRemove) do
		CurrentTrader.List[slotId] = nil
	end

	BroadcastTrader()
	return true
end
GenerateRecipes()

Fetch.OnServerInvoke = function(_player)
	return CurrentTrader
end

Update.OnServerEvent:Connect(function(player, newData)
	if player and newData and newData.List then
		CurrentTrader = newData
		RefreshTime = newData.Refresh or RefreshTime
		BroadcastTrader()
	end
end)

Trade.OnServerEvent:Connect(function(player, slotId, animalName)
	if not (player and slotId and animalName and CurrentTrader.List[slotId]) then return end
	local traderSlot = CurrentTrader.List[slotId]
	if traderSlot.Name ~= animalName then return end

	local playerData = Synchronizer:Get(player)
	if not playerData then return end

	local podiums = playerData:Get("AnimalPodiums") or {}
	local availableBrainrots = {}
	for _, podiumData in podiums do
		if type(podiumData) == "table"
			and podiumData.Machine
			and podiumData.Machine.Type == "BrainrotTrader"
			and not podiumData.Machine.Active
		then
			availableBrainrots[podiumData.Index] = (availableBrainrots[podiumData.Index] or 0) + 1
		end
	end

	local requiredCounts = {}
	for _, animal in traderSlot.Recipe do
		requiredCounts[animal] = (requiredCounts[animal] or 0) + 1
	end

	local hasAll = true
	for animal, need in requiredCounts do
		if (availableBrainrots[animal] or 0) < need then
			hasAll = false
			break
		end
	end

	if not hasAll then
		NotificationService.Error(player, "You don't have the required brainrots for this trade!")
		return
	end

	local toConsume = {}
	for animal, need in requiredCounts do
		for _ = 1, need do
			table.insert(toConsume, animal)
		end
	end

	for podiumId, podiumData in podiums do
		if type(podiumData) == "table"
			and podiumData.Machine
			and podiumData.Machine.Type == "BrainrotTrader"
			and not podiumData.Machine.Active
		then
			local idx = table.find(toConsume, podiumData.Index)
			if idx then
				podiums[podiumId] = nil
				table.remove(toConsume, idx)
				if #toConsume == 0 then break end
			end
		end
	end

	playerData:Set("AnimalPodiums", podiums)
	playerData:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

	local rarity = AnimalData[animalName].Rarity
	Animation:FireAllClients(player, rarity)

	task.spawn(function()
		task.wait(3)
		local animalData = AnimalData[animalName]
		if not animalData then return end

		local plot = PlotService.getPlot(player)
		if not plot then return end

		local trader = Workspace:FindFirstChild("BrainrotTrader")
		local spawnZonePart = trader and trader:FindFirstChild("SpawnZone")
		if not spawnZonePart then
			warn("[BrainrotTraderService] BrainrotTrader.SpawnZone not found")
			return
		end

		local spawnCFrame = plot.AnimalTarget and plot.AnimalTarget.CFrame or Workspace.Road.Start.CFrame

		local UniqueAnimalId = HttpService:GenerateGUID(false)
		local spawnedId      = nil
		local maxAttempts    = 3

		for attempt = 1, maxAttempts do
			local ok, result = pcall(function()
				return AnimalService.spawnAnimalCustom(animalData, nil, nil, nil, {
					Start    = spawnZonePart,
					End      = spawnCFrame,
					Owner    = player,
					AnimalId = UniqueAnimalId,
				},nil, true)
			end)
			if ok and result then
				spawnedId = result
				break
			else
				warn(string.format(
					"[BrainrotTraderService] Spawn attempt %d/%d failed for %s: %s",
					attempt, maxAttempts, animalName, tostring(result)
					))
				if attempt < maxAttempts then
					task.wait(1)
					UniqueAnimalId = HttpService:GenerateGUID(false)
				end
			end
		end

		if not spawnedId then
			warn("[BrainrotTraderService] All spawn attempts failed for: " .. tostring(animalName))
			return
		end

		RunService.Heartbeat:Wait()
		local animalModel = nil
		local waitStart   = os.clock()
		repeat
			animalModel = Workspace:FindFirstChild(spawnedId)
			if not animalModel then
				RunService.Heartbeat:Wait()
			end
		until animalModel or (os.clock() - waitStart) >= 8

		if animalModel and animalModel:IsA("Model") then
			animalModel:SetAttribute("ForceIdle", true)
			pcall(function() animalModel:PivotTo(spawnZonePart.CFrame) end)

			local startCFrame = spawnZonePart.CFrame
			local endCFrame   = startCFrame * CFrame.new(0, -5, 0)

			local cframeValue = Instance.new("CFrameValue")
			cframeValue.Value = startCFrame

			local pivotConn
			pivotConn = cframeValue:GetPropertyChangedSignal("Value"):Connect(function()
				if animalModel and animalModel.Parent then
					pcall(function() animalModel:PivotTo(cframeValue.Value) end)
				else
					if pivotConn then pivotConn:Disconnect(); pivotConn = nil end
				end
			end)

			local tween = TweenService:Create(
				cframeValue,
				TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Value = endCFrame }
			)
			tween:Play()

			task.delay(2, function()
				if pivotConn then pivotConn:Disconnect(); pivotConn = nil end
				if cframeValue then cframeValue:Destroy() end
				if animalModel and animalModel.Parent then
					animalModel:SetAttribute("ForceIdle", false)
				end
			end)
		else
			warn("[BrainrotTraderService] Animal model never appeared: " .. tostring(spawnedId))
		end
	end)
	BroadcastTrader()
end)

Return.OnServerEvent:Connect(function(player, podiumId)
	if player and podiumId then
		print(player.Name .. " returned podium " .. podiumId)
		if PlayerPodiums[player.UserId] then
			PlayerPodiums[player.UserId][podiumId] = nil
		end

		local playerData = Synchronizer:Get(player)
		if playerData then
			local podiums = playerData:Get("AnimalPodiums") or {}
			if podiums[podiumId]
				and podiums[podiumId].Machine
				and podiums[podiumId].Machine.Type == "BrainrotTrader"
			then
				podiums[podiumId].Machine = nil
				playerData:Set("AnimalPodiums", podiums)
				playerData:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
			end
		end
	end
end)

Delivery.OnServerInvoke = function(player, _hitbox)
	local playerData = Synchronizer:Get(player)
	if not playerData then return false end

	local stealData = StealService:GetStealData(player)
	if not stealData then return false end

	local stolenAnimalData = stealData.StolenAnimalData
	if not stolenAnimalData then return false end

	local animalName = stolenAnimalData.Index or "Noobini Pizzanini"

	local isRequired = false
	for _, slotData in pairs(CurrentTrader.List) do
		if slotData.Recipe then
			for _, recipeAnimal in ipairs(slotData.Recipe) do
				if recipeAnimal == animalName then
					isRequired = true
					break
				end
			end
		end
		if isRequired then break end
	end

	if not isRequired then
		NotificationService.Error(player, "This brainrot is not required for any current trade!")
		StealService:CancelSteal(player)
		return false
	end

	local podiums = playerData:Get("AnimalPodiums") or {}
	local availableSlot = nil

	for i = 1, 50 do
		if not podiums[i] then
			availableSlot = i
			break
		end
	end

	if not availableSlot then
		NotificationService.Error(player, "No available podium slots")
		StealService:CancelSteal(player)
		return false
	end

	local Traits = stolenAnimalData.Traits
	if Traits and #Traits == 0 then
		Traits = nil
	end

	local OriginalPodiumIndex = stealData.PodiumIndex

	if OriginalPodiumIndex and podiums[OriginalPodiumIndex] then
		local ExistingPodium = podiums[OriginalPodiumIndex]
		ExistingPodium.Machine = {
			Type = "BrainrotTrader",
			Active = false,
		}
		podiums[OriginalPodiumIndex] = ExistingPodium
	else
		podiums[availableSlot] = {
			IndexOnPlot = OriginalPodiumIndex or availableSlot,
			Index = animalName,
			LastCollect = stolenAnimalData.LastCollect or workspace:GetServerTimeNow(),
			OfflineGain = stolenAnimalData.OfflineGain or nil,
			Traits = Traits,
			Machine = {
				Type = "BrainrotTrader",
				Active = false,
			},
		}
	end

	playerData:Set("AnimalPodiums", podiums)
	playerData:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

	StealService:CancelSteal(player)
	NotificationService.Notify(player, "You gave a Brainrot to the Brainrot Trader!", 5, "Sounds.Sfx.Success")
	return true
end

function BrainrotTraderService:Start()
	task.spawn(function()
		Players.PlayerAdded:Connect(function(player)
			PlayerPodiums[player.UserId] = {}
			Update:FireClient(player, CurrentTrader)
		end)

		Players.PlayerRemoving:Connect(function(player)
			PlayerPodiums[player.UserId] = nil
		end)

		for _, player in Players:GetPlayers() do
			PlayerPodiums[player.UserId] = {}
			Update:FireClient(player, CurrentTrader)
		end

	end)
	task.spawn(function()
		while true do
			if Workspace:GetServerTimeNow() >= RefreshTime then
				BrainrotTraderService.RefreshTrader()
			end
			task.wait(1)
		end
	end)
	task.spawn(function()
		SetRecipeRemote.OnServerInvoke = function(player, result, recipeName)
			return BrainrotTraderService:SetCustomRecipe(result, recipeName)
		end
		RemoveRecipeRemote.OnServerInvoke = function(player, result, recipeName)
			return BrainrotTraderService:RemoveRecipe(result, recipeName)
		end
	end)
end

return BrainrotTraderService
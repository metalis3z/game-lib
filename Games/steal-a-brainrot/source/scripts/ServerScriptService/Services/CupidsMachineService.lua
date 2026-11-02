local CupidsMachineService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local PlotService = require(ServerScriptService.Services.PlotService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local StealService = require(ServerScriptService.Services.StealService)
local NotificationService = require(ServerScriptService.Services.NotificationService)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)

local CupidsMachineData = require(ServerStorage.Modules.CupidsMachineData)
local AnimalsDB = require(ReplicatedStorage.Datas.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)

local CraftDone = Net:RemoteEvent("CupidsMachineService/CraftDone")
local Update = Net:RemoteEvent("CupidsMachineService/Update")
local Return = Net:RemoteEvent("CupidsMachineService/Return")
local Claim = Net:RemoteEvent("CupidsMachineService/Claim")
local Skip = Net:RemoteEvent("CupidsMachineService/Skip")
local Delivery = Net:RemoteFunction("CupidsMachineService/Delivery")
local Start = Net:RemoteFunction("CupidsMachineService/Start")
local Fetch = Net:RemoteFunction("CupidsMachineService/Fetch")

local currentRecipe = nil

local function buildRecipe()
	local now = workspace:GetServerTimeNow()
	local interval = 1800
	local seed = math.floor(now / interval) + 1
	local rng = Random.new(seed)

	if not CupidsMachineData 
		or not CupidsMachineData.Recipes 
		or #CupidsMachineData.Recipes == 0 then
		return { Recipe = nil, Outputs = {}, Refresh = seed * interval }
	end

	local recipes = CupidsMachineData.Recipes
	local chosen = recipes[rng:NextInteger(1, #recipes)]

	local outputs = {}
	for name, chance in pairs(chosen.Outputs) do
		table.insert(outputs, {
			Name = name,
			Chance = chance
		})
	end

	return {
		Recipe = {
			Name = chosen.Name,
			Recipe = chosen.Recipe,
			Cost = chosen.Cost
		},
		Outputs = outputs,
		Refresh = seed * interval
	}
end

local function refreshAll()
	currentRecipe = buildRecipe()
	Update:FireAllClients(currentRecipe)
end

Fetch.OnServerInvoke = function(player)
	if currentRecipe then return currentRecipe end
	currentRecipe = buildRecipe()
	return currentRecipe
end

Start.OnServerInvoke = function(player, recipeName)
	local data = Synchronizer:Get(player)
	if not data then return false end

	local recipe = currentRecipe or buildRecipe()
	local item = recipe.Recipe
	if not item or item.Name ~= recipeName then return false end

	local coins = data:Get("Coins") or 0
	if coins < item.Cost then return false end

	local podiums = data:Get("AnimalPodiums") or {}
	local available = {}
	for i, p in pairs(podiums) do
		if type(p) == "table" and p.Machine and p.Machine.Type == "Cupids" and not p.Machine.Active then
			available[p.Index] = (available[p.Index] or 0) + 1
		end
	end

	local required = {}
	for _, a in ipairs(item.Recipe) do required[a] = (required[a] or 0) + 1 end
	for a, c in pairs(required) do
		if (available[a] or 0) < c then 
			return false 
		end
	end

	local current = data:Get("CupidsMachine")
	if current and current.StartTime and current.FinishTime and workspace:GetServerTimeNow() < current.FinishTime then return false end

	local toConsume = {}
	for _, a in ipairs(item.Recipe) do table.insert(toConsume, a) end
	for i, p in pairs(podiums) do
		if type(p) == "table" and p.Machine and p.Machine.Type == "Cupids" and not p.Machine.Active then
			local idx = table.find(toConsume, p.Index)
			if idx then
				p.Machine.Active = true
				table.remove(toConsume, idx)
				podiums[i] = p
				if #toConsume == 0 then break end
			end
		end
	end

	if #toConsume ~= 0 then return false end

	data:Set("Coins", coins - item.Cost)
	data:Set("AnimalPodiums", podiums)

	local now = workspace:GetServerTimeNow()
	data:Set("CupidsMachine", {
		Brainrot = recipeName,
		StartTime = now,
		FinishTime = now + 300,
		InstantSkips = data:Get("CupidsMachine.InstantSkips") or 0
	})

	NotificationService.Notify(player, "Matching started!", 5, "Sounds.Sfx.Success")
	return true
end

Delivery.OnServerInvoke = function(player, hitbox)
	local data = Synchronizer:Get(player)
	if not data then return false end

	local steal = StealService:GetStealData(player)
	if not steal or not steal.StolenAnimalData then return false end

	local name = steal.StolenAnimalData.Index or "Noobini Pizzanini"
	local podiums = data:Get("AnimalPodiums") or {}

	local orig = steal.PodiumIndex
	if not orig then
		return false
	end

	local podiumData = podiums[orig]
	if not podiumData or type(podiumData) ~= "table" then
		return false
	end

	if podiumData.Index ~= name then
		NotificationService.Error(player, "You must own the brainrot to use it in Cupid's Machine!")
		return false
	end

	local recipe = currentRecipe or buildRecipe()
	local needed = false
	if recipe.Recipe and recipe.Recipe.Recipe then
		for _, r in ipairs(recipe.Recipe.Recipe) do
			if r == name then 
				needed = true 
				break 
			end
		end
	end

	if not needed then
		NotificationService.Error(player, "This brainrot is not required in the recipe")
		StealService:CancelSteal(player)
		return false
	end

	local traits = steal.StolenAnimalData.Traits
	if traits and #traits == 0 then traits = nil end

	local orig = steal.PodiumIndex
	if orig and podiums[orig] then
		podiums[orig].Machine = { Type = "Cupids", Active = false }
	else
		local slot = nil
		for i = 1, 50 do
			if not podiums[i] then slot = i break end
		end
		if not slot then return false end
		podiums[slot] = {
			IndexOnPlot = orig or slot,
			Index = name,
			LastCollect = steal.StolenAnimalData.LastCollect or workspace:GetServerTimeNow(),
			OfflineGain = steal.StolenAnimalData.OfflineGain or nil,
			Mutation = steal.StolenAnimalData.Mutation,
			Traits = traits,
			Machine = { Type = "Cupids", Active = false }
		}
	end

	data:Set("AnimalPodiums", podiums)
	data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
	StealService:CancelSteal(player)

	local a = AnimalsDB[name]
	local r = a and a.Rarity
	local rd = r and Rarities[r]
	local c = rd and rd.Color
	local colored = name
	if c and typeof(c) == "Color3" then
		local hex = string.format("#%02X%02X%02X", math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
		colored = string.format('<font color="%s">%s</font>', hex, (a and a.DisplayName) or name)
	end

	NotificationService.Notify(player, string.format("You have added %s to Cupid's Machine!", colored), 5, "Sounds.Sfx.Success")
	return true
end

Return.OnServerEvent:Connect(function(player, podiumIndex)
	local data = Synchronizer:Get(player)
	if not data then return end

	local podiums = data:Get("AnimalPodiums") or {}
	local p = podiums[podiumIndex]
	if p and p.Machine and p.Machine.Type == "Cupids" and not p.Machine.Active then
		p.Machine = nil
		podiums[podiumIndex] = p
		data:Set("AnimalPodiums", podiums)
		data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
	end
end)

Claim.OnServerEvent:Connect(function(player)
	local data = Synchronizer:Get(player)
	if not data then return end

	local c = data:Get("CupidsMachine")
	if not c or not c.FinishTime then return end
	if workspace:GetServerTimeNow() < c.FinishTime then return end

	local plot = PlotService.getPlot(player)
	if not plot then return end

	local recipe = currentRecipe or buildRecipe()
	local success = true
	local resultBrainrot = nil

	if c.RiggedBrainrot then
		resultBrainrot = c.RiggedBrainrot
		success = true
	elseif recipe.Outputs and #recipe.Outputs > 0 then
		local lastReward = data:Get("CupidsMachine.LastReward")
		local cumulative = 0

		if lastReward == "Lovin Rose" then
			local roll = math.random() * 100
			if roll <= 0.06 then
				resultBrainrot = "Love Love Bear"
			else
				local adjustedRoll = math.random() * 100
				cumulative = 0
				for _, output in ipairs(recipe.Outputs) do
					if output.Name ~= "Lovin Rose" then
						cumulative = cumulative + output.Chance
						if adjustedRoll <= cumulative then
							if output.Name ~= "Nothing" then
								resultBrainrot = output.Name
							else
								success = false
							end
							break
						end
					end
				end
			end
		else
			local normalRoll = math.random() * 100
			for _, output in ipairs(recipe.Outputs) do
				cumulative = cumulative + output.Chance
				if normalRoll <= cumulative then
					if output.Name ~= "Nothing" then
						resultBrainrot = output.Name
					else
						success = false
					end
					break
				end
			end
		end
	end

	if resultBrainrot then
		data:Set("CupidsMachine.LastReward", resultBrainrot)
	else
		data:Set("CupidsMachine.LastReward", nil)
	end

	local nextLastReward = resultBrainrot or nil
	for _, p in Players:GetPlayers() do
		local hasLovinRoseBuff = (p == player and resultBrainrot == "Lovin Rose")
		CraftDone:FireClient(p, success, recipe.Recipe and recipe.Recipe.Recipe or {}, hasLovinRoseBuff)
	end

	if success and resultBrainrot then
		task.delay(6.5, function()
			if not player or not player.Parent then return end

			AnimalService.spawnAnimalCustom(AnimalsDB[resultBrainrot], nil, nil, nil, {
				Start = ReplicatedStorage.CupidsMachine.SpawnZone,
				End = plot.AnimalTarget,
				Owner = player
			}, 1.5)
		end)
	end

	data:Set("CupidsMachine", {})

	local podiums = data:Get("AnimalPodiums") or {}
	for i, p in pairs(podiums) do
		if type(p) == "table" 
			and p.Machine 
			and p.Machine.Type == "Cupids" 
			and p.Machine.Active then

			podiums[i] = nil
		end
	end
	data:Set("AnimalPodiums", podiums)
	data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
end)

Skip.OnServerEvent:Connect(function(player)
	local data = Synchronizer:Get(player)
	if not data then return end

	local c = data:Get("CupidsMachine")
	if not c or not c.StartTime or not c.FinishTime then return end

	local skips = c.InstantSkips or 0
	if skips <= 0 then return end

	local now = workspace:GetServerTimeNow()
	if now >= c.FinishTime then return end

	c.FinishTime = now
	c.InstantSkips = skips - 1
	data:Set("CupidsMachine", c)

	NotificationService.Notify(player, "Matching skipped!", 5, "Sounds.Sfx.Success")
end)

function CupidsMachineService:Start()
	refreshAll()

	task.spawn(function()
		while true do
			local now = workspace:GetServerTimeNow()
			local nextRefresh = (math.floor(now / 1800) + 1) * 1800
			task.wait(nextRefresh - now)
			refreshAll()
		end
	end)

	for _, p in Players:GetChildren() do
		local d = Synchronizer:Wait(p)
		if d then
			if not d:Get("CupidsMachine") then d:Set("CupidsMachine", {}) end
			task.wait(1)
			Update:FireClient(p, currentRecipe)
		end
	end

	Players.PlayerAdded:Connect(function(p)
		local d = Synchronizer:Wait(p)
		if d then
			if not d:Get("CupidsMachine") then d:Set("CupidsMachine", {}) end
			task.wait(1)
			Update:FireClient(p, currentRecipe)
		end
	end)
end

function CupidsMachineService:ChangeMachineRequirements(recipeName)
	if not CupidsMachineData or not CupidsMachineData.Recipes then return end

	for _, recipe in ipairs(CupidsMachineData.Recipes) do
		if recipe.Name == recipeName then
			local outputs = {}
			for name, chance in pairs(recipe.Outputs) do
				table.insert(outputs, {
					Name = name,
					Chance = chance
				})
			end

			currentRecipe = {
				Recipe = {
					Name = recipe.Name,
					Recipe = recipe.Recipe,
					Cost = recipe.Cost
				},
				Outputs = outputs,
				Refresh = workspace:GetServerTimeNow() + 1800
			}

			Update:FireAllClients(currentRecipe)
			break
		end
	end
end

function CupidsMachineService:PurchaseSkip(player)
	local data = Synchronizer:Get(player)
	if not data then return end

	local c = data:Get("CupidsMachine")
	if not c or not c.StartTime or not c.FinishTime then return end
	if c.FinishTime <= workspace:GetServerTimeNow() then return end

	data:Set("CupidsMachine.FinishTime", workspace:GetServerTimeNow())

	task.spawn(function()
		Claim:FireClient(player)
	end)
end

function CupidsMachineService:RigCupidsMachine(player, brainrotName)
	local data = Synchronizer:Get(player)
	if not data then return false end

	if not AnimalsDB[brainrotName] then return false end

	local c = data:Get("CupidsMachine")
	if not c or not c.StartTime or not c.FinishTime then return false end

	local now = workspace:GetServerTimeNow()
	if now >= c.FinishTime then return false end

	c.RiggedBrainrot = brainrotName
	data:Set("CupidsMachine", c)

	return true
end

return CupidsMachineService
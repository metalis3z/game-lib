local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local TweenService = game:GetService("TweenService")
local Observers = require(ReplicatedStorage.Packages.Observers)

local Net = require(ReplicatedStorage.Packages.Net)

local SpawnCoinRemote    = Net:RemoteEvent("EventService/EggrotHunt/SpawnCoin")
local ClaimCoinRemote    = Net:RemoteEvent("EventService/EggrotHunt/ClaimCoin")
local DestroyCoinRemote  = Net:RemoteEvent("EventService/EggrotHunt/DestroyCoin")
local BuyJumpRemote      = Net:RemoteFunction("EggrotHunt/JumpShop/Buy")
local BuyCandyRemote     = Net:RemoteFunction("EggrotHunt/CandyMerchant/Buy")
local NoFlyRemote        = Net:RemoteEvent("EventService/EggrotHunt/NoFly")
local PoofRemote         = Net:RemoteEvent("SpawnFakeBrainrot/Poof")
local GoldEggRewardRemote = Net:RemoteEvent("EventService/EggrotHunt/GoldEggReward")

local EggrotHunt = {}
local isActive = false
local runningTasks = {}
local islandsFolder = nil
local jumpShopModel  = nil
local ufosFolder     = nil

local coinSpawnPoints = {}
local occupiedCoins   = {}
local partToCoinsMap  = {}
local partCooldowns   = {}
local noFlyZoneParts  = {}

local POOL_ID            = "EggrotHunt/Brainrots"
local COINS_PER_TICK     = 2
local COIN_TICK_INTERVAL = 1
local COIN_RESPAWN_DELAY = 30
local NO_FLY_TOOLS = {
	["Flying Carpet"] = true,
	["Cupid's Wings"] = true,
	["Santa's Sleigh"] = true,
	["Witch's Broom"] = true,
}
local BUY_JUMP_COOLDOWN  = 1
local buyJumpCooldowns   = {}
local candyPurchasedThisCycle = {}

local EGG_SPAWN_INTERVAL = 10
local EGG_DESPAWN_TIME   = 60
local activeEggs         = {}

local GOLD_EGG_INTERVAL  = 30
local activeGoldEggs     = {}

local EGG_ENTRIES = {
	{name = "Eggdin Egg Egg Dun Egg",            weight = 75},
	{name = "Easter Easter Easter Sahur Egg",     weight = 75},
	{name = "Buntteo Egg",                        weight = 75},
	{name = "Bunny Bunny Bunny Sahur Egg",        weight = 20},
	{name = "Churrito Bunnito Egg",               weight = 20},
	{name = "Quackini Snackini Egg",              weight = 20},
	{name = "Baskito Egg",                        weight = 20},
	{name = "Hydra Bunny Egg",                    weight = 20},
	{name = "Los Bunitos Egg",                    weight = 20},
	{name = "Hopilikalika Hopilikalako Egg",       weight = 20},
	{name = "Noo my Eggs Egg",                    weight = 20},
	{name = "Bunny Tralala Egg",                  weight = 20},
}
local EGG_TOTAL_WEIGHT = 0
for _, e in ipairs(EGG_ENTRIES) do EGG_TOTAL_WEIGHT += e.weight end

local UFO_PATROL_RADIUS   = 100
local UFO_SPEED           = 16
local UFO_ABDUCT_RANGE    = 25
local UFO_ABDUCT_COOLDOWN = 20

local function getSynchronizer()         return require(ReplicatedStorage.Packages.Synchronizer) end
local function getAnimalService()        return require(ServerScriptService.Services.AnimalService) end
local function getWorldBrainrotService() return require(ServerScriptService.Services.WorldBrainrotService) end
local function getBunnyCoinsService()    return require(ServerScriptService.Services.BunnyCoinsService) end
local function getMoneyService()         return require(ServerScriptService.Services.MoneyService) end
local function getCandyData()            return require(ReplicatedStorage.Datas.CandyMerchantData) end
local function getJumpData()             return require(ReplicatedStorage.Datas.JumpShopData) end

local function toSafeName(id) return id:gsub("[/\\%s]", "_") end

local function findEventAsset(name)
	return script:FindFirstChild(name)
end

local function getPlayerJumpLevel(player)
	local data = getSynchronizer():Get(player)
	if not data then return 0 end
	return data:Get({"EasterEvent", "JumpShop"}) or 0
end

local function setExtraJumps(player, jumps)
	player:SetAttribute("ExtraJumps", jumps)
end

local function loadPlayerJumps(player)
	if not isActive then return end
	setExtraJumps(player, getPlayerJumpLevel(player) + 1)
end

local function markZone(player, zoneName)
	local data = getSynchronizer():Get(player)
	if not data then return end
	local visited = data:Get({"EasterEvent", "VisitedZones"}) or {}
	if visited[zoneName] then return end
	visited[zoneName] = true
	data:Set({"EasterEvent", "VisitedZones"}, visited)
end

local function pickEgg()
	local roll = math.random() * EGG_TOTAL_WEIGHT
	local cum = 0
	for _, e in ipairs(EGG_ENTRIES) do
		cum += e.weight
		if roll <= cum then return e.name end
	end
	return EGG_ENTRIES[1].name
end

local function spawnCoinAt(part)
	if partToCoinsMap[part] or partCooldowns[part] then return end
	local coinId = HttpService:GenerateGUID(false)
	occupiedCoins[coinId] = part
	partToCoinsMap[part] = coinId
	SpawnCoinRemote:FireAllClients(coinId, part.Position + Vector3.new(0, 30, 0), part.Position, Workspace:GetServerTimeNow(), 0, false)
end

local function onCoinClaimed(part)
	partCooldowns[part] = true
	task.delay(COIN_RESPAWN_DELAY, function()
		if isActive then partCooldowns[part] = nil end
	end)
end

local SECTION_TO_ZONE = {
	NormalSection = "Normal",
	CandySection  = "Candy",
	LavaSection   = "Lava",
	GalaxySection = "Galaxy",
	DivineSection = "Divine",
}

local function setupZoneDetection(folder)
	local function tryConnect(part, zoneName)
		part.Touched:Connect(function(hit)
			if not hit or not hit.Parent then return end
			local player = Players:GetPlayerFromCharacter(hit.Parent)
			if not player then return end
			markZone(player, zoneName)
		end)
	end

	for _, desc in ipairs(folder:GetDescendants()) do
		if not desc:IsA("BasePart") then continue end

		local zoneName = nil

		for _, tag in ipairs(CollectionService:GetTags(desc)) do
			local z = tag:match("^EggrotZone_(.+)$")
			if z then zoneName = z break end
		end

		if not zoneName then
			zoneName = desc.Name:match("^(.+) Zone$")
		end

		if not zoneName then
			local ancestor = desc.Parent
			while ancestor and ancestor ~= folder do
				local mapped = SECTION_TO_ZONE[ancestor.Name]
				if mapped then
					zoneName = mapped
					break
				end
				ancestor = ancestor.Parent
			end
		end

		if zoneName then
			tryConnect(desc, zoneName)
		end
	end
end

local function isInNoFlyZone(character)
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return false end
	local pos = hrp.Position
	for _, part in ipairs(noFlyZoneParts) do
		if not part or not part.Parent then continue end
		local half = part.Size * 0.5
		local rel = part.CFrame:PointToObjectSpace(pos)
		if math.abs(rel.X) <= half.X and math.abs(rel.Y) <= half.Y and math.abs(rel.Z) <= half.Z then
			return true
		end
	end
	return false
end

local function pickCandyStock()
	local CandyData = getCandyData()
	local names = {}
	for name in pairs(CandyData) do table.insert(names, name) end
	if #names < 2 then return table.concat(names, "|") end
	local i1 = math.random(1, #names)
	local item1 = table.remove(names, i1)
	local item2 = names[math.random(1, #names)]
	return item1 .. "|" .. item2
end

local function setupGalaxyPads()
	local padPlayers = {}
	local function updateDoors()
		local any = false
		for _, v in pairs(padPlayers) do if v then any = true break end end
		for _, door in ipairs(CollectionService:GetTagged("EggrotGalaxyDoor")) do
			door:SetAttribute("GalaxyDoorOpen", any)
		end
	end
	for _, pad in ipairs(CollectionService:GetTagged("EggrotGalaxyPad")) do
		if not pad:IsA("BasePart") then continue end
		local debounce = {}
		table.insert(runningTasks, pad.Touched:Connect(function(hit)
			if not hit or not hit.Parent then return end
			local player = Players:GetPlayerFromCharacter(hit.Parent)
			if not player or debounce[player] then return end
			debounce[player] = true
			padPlayers[player] = true
			pad:SetAttribute("GalaxyPadOccupied", true)
			updateDoors()
		end))
		table.insert(runningTasks, pad.TouchEnded:Connect(function(hit)
			if not hit or not hit.Parent then return end
			local player = Players:GetPlayerFromCharacter(hit.Parent)
			if not player then return end
			debounce[player] = nil
			padPlayers[player] = nil
			local any = false
			for _, v in pairs(padPlayers) do if v then any = true break end end
			if not any then pad:SetAttribute("GalaxyPadOccupied", false) end
			updateDoors()
		end))
	end
end

local function getEggsNearPosition(pos, folder)
	local result = {}
	for id in pairs(activeEggs) do
		local p = folder:FindFirstChild(id)
		if p and (p.Position - pos).Magnitude <= UFO_ABDUCT_RANGE then
			table.insert(result, {id = id, part = p})
		end
	end
	return result
end

local function setupUFOPatrol()
	if not ufosFolder then return end
	for _, part in ipairs(ufosFolder:GetChildren()) do
		if not part:IsA("BasePart") then continue end
		CollectionService:AddTag(part, "EggrotUFO")
		local origin = part.Position
		task.spawn(function()
			task.wait(math.random(0, 8))
			local lastAbduct = 0
			while isActive do
				local angle = math.random() * math.pi * 2
				local radius = math.random(20, UFO_PATROL_RADIUS)
				local targetPos = Vector3.new(
					origin.X + math.cos(angle) * radius,
					origin.Y + math.random(-5, 5),
					origin.Z + math.sin(angle) * radius
				)
				local dur = math.max((targetPos - part.Position).Magnitude / UFO_SPEED, 0.5)
				TweenService:Create(part, TweenInfo.new(dur, Enum.EasingStyle.Sine), {CFrame = CFrame.new(targetPos)}):Play()
				task.wait(dur + math.random(2, 6))
				if not isActive then break end
				local now = Workspace:GetServerTimeNow()
				if now - lastAbduct >= UFO_ABDUCT_COOLDOWN then
					local pr = workspace:FindFirstChild("WBPools")
					local pf = pr and pr:FindFirstChild(toSafeName(POOL_ID))
					if pf then
						local nearby = getEggsNearPosition(part.Position, pf)
						if #nearby > 0 then
							local target = nearby[math.random(1, #nearby)]
							if target and target.part and target.part.Parent then
								lastAbduct = now
								part:SetAttribute("BeamState", "down")
								task.wait(1.5)
								part:SetAttribute("BeamState", "off")
								if activeEggs[target.id] and target.part.Parent then
									local current = target.part:GetAttribute("BTr") or ""
									local traits = {}
									if current ~= "" then
										local ok, decoded = pcall(HttpService.JSONDecode, HttpService, current)
										if ok and type(decoded) == "table" then traits = decoded end
									end
									local hasTie = false
									for _, t in ipairs(traits) do if t == "Tie" then hasTie = true break end end
									if not hasTie then
										table.insert(traits, "Tie")
										local ok2, encoded = pcall(HttpService.JSONEncode, HttpService, traits)
										if ok2 then target.part:SetAttribute("BTr", encoded) end
									end
								end
							end
						end
					end
				end
			end
		end)
	end
end

local function spawnWorldEgg(eggSpawnParts)
	if not isActive or #eggSpawnParts == 0 then return end
	local spawnPart = eggSpawnParts[math.random(1, #eggSpawnParts)]
	if not spawnPart or not spawnPart.Parent then return end

	local eggName = pickEgg()
	local WorldBrainrotService = getWorldBrainrotService()
	local brainrotId = WorldBrainrotService:SpawnBrainrot(POOL_ID, {
		brainrot = eggName,
		cframe = spawnPart.CFrame,
		timer = -1,
		despawnTimer = EGG_DESPAWN_TIME,
	})
	if not brainrotId then return end
	activeEggs[brainrotId] = {name = eggName}
	local poolsRoot = workspace:FindFirstChild("WBPools")
	if not poolsRoot then return end
	local folder = poolsRoot:FindFirstChild(toSafeName(POOL_ID))
	if not folder then return end
	local part = folder:FindFirstChild(brainrotId)
	if not part then return end

	local despawnTask   = nil

	local function removeEgg(reason)
		if despawnTask then pcall(task.cancel, despawnTask) despawnTask = nil end
		if not activeEggs[brainrotId] then return end
		activeEggs[brainrotId] = nil
		WorldBrainrotService:RemoveBrainrot(POOL_ID, brainrotId)
	end

	despawnTask = task.delay(EGG_DESPAWN_TIME, function()
		if (part:GetAttribute("BG") or 0) ~= 0 then
			task.delay(30, function() removeEgg("despawn_carried") end)
		else
			removeEgg("despawn_timeout")
		end
	end)
	table.insert(runningTasks, despawnTask)
end

local function spawnGoldEgg(goldEggParts)
	if not isActive or #goldEggParts == 0 then return end
	local spawnPart = goldEggParts[math.random(1, #goldEggParts)]
	if not spawnPart or not spawnPart.Parent then return end

	local WorldBrainrotService = getWorldBrainrotService()
	local brainrotId = WorldBrainrotService:SpawnBrainrot(POOL_ID, {
		brainrot = "Gold Egg",
		cframe = spawnPart.CFrame,
		timer = -1,
		despawnTimer = 60,
	})
	if not brainrotId then return end
	activeGoldEggs[brainrotId] = true
	local poolsRoot = workspace:FindFirstChild("WBPools")
	if not poolsRoot then return end
	local folder = poolsRoot:FindFirstChild(toSafeName(POOL_ID))
	if not folder then return end
	local part = folder:FindFirstChild(brainrotId)
	if not part then return end

	local collectConn = nil
	local despawnTask = nil

	local function removeGold(reason)
		if collectConn then collectConn:Disconnect() collectConn = nil end
		if despawnTask then pcall(task.cancel, despawnTask) despawnTask = nil end
		if not activeGoldEggs[brainrotId] then return end
		activeGoldEggs[brainrotId] = nil
		WorldBrainrotService:RemoveBrainrot(POOL_ID, brainrotId)
	end

	collectConn = part:GetAttributeChangedSignal("BG"):Connect(function()
		local userId = part:GetAttribute("BG")
		if not userId or userId == 0 then return end
		local collectPos = part.Position
		part:SetAttribute("BG", 0)
		removeGold("collected")
		PoofRemote:FireAllClients(CFrame.new(collectPos))
		local player = Players:GetPlayerByUserId(userId)
		if not player then return end
		getBunnyCoinsService():Add(player, 10)
		GoldEggRewardRemote:FireClient(player, 10)
	end)

	despawnTask = task.delay(60, function() removeGold("despawn_timeout") end)
	table.insert(runningTasks, despawnTask)
end

function EggrotHunt.OnStart()
	if isActive then return end
	isActive = true
	table.insert(runningTasks, Observers.observeTag("HideInEggrotHuntServer", function(obj)
		if obj:IsA("BasePart") then
			local previousCollision = obj.CanCollide
			obj.CanCollide = false
			return function()
				obj.CanCollide = previousCollision
			end
		end
	end))
	local WorldBrainrotService = getWorldBrainrotService()
	WorldBrainrotService:CreatePool(POOL_ID)

	ReplicatedStorage:SetAttribute("EggrotHuntActive", true)
	ReplicatedStorage:SetAttribute("EggrotHuntEvent", true)
	ReplicatedStorage:SetAttribute("EggrotHuntStart", Workspace:GetServerTimeNow())

	local jumpShopAsset = findEventAsset("JumpShop")
	if jumpShopAsset then jumpShopModel = jumpShopAsset:Clone() jumpShopModel.Parent = Workspace end

	local islandsAsset = findEventAsset("Islands")
	if islandsAsset then
		islandsFolder = islandsAsset:Clone()
		islandsFolder.Parent = Workspace
		setupZoneDetection(islandsFolder)
	end

	local ufosAsset = findEventAsset("UFOS")
	if ufosAsset then
		ufosFolder = ufosAsset:Clone()
		ufosFolder.Parent = Workspace
	end

	coinSpawnPoints = {}
	if islandsFolder then
		local coinsFolder = islandsFolder:FindFirstChild("Coins")
		if coinsFolder then
			for _, child in ipairs(coinsFolder:GetDescendants()) do
				if child:IsA("BasePart") and CollectionService:HasTag(child, "EggrotCoinSpawn") then
					table.insert(coinSpawnPoints, child)
				end
			end
		end
	end

	local eggSpawnParts = {}
	local eggSpawnAsset = findEventAsset("EggSpawn")
	if eggSpawnAsset then
		for _, desc in ipairs(eggSpawnAsset:GetDescendants()) do
			if desc:IsA("BasePart") and CollectionService:HasTag(desc, "EggrotEggsSpawn") then
				table.insert(eggSpawnParts, desc)
			end
		end
	end

	local goldEggParts = {}
	local goldEggAsset = findEventAsset("EggGold")
	if goldEggAsset then
		for _, desc in ipairs(goldEggAsset:GetDescendants()) do
			if desc:IsA("BasePart") and CollectionService:HasTag(desc, "EggrotEggsGoldSpawn") then
				table.insert(goldEggParts, desc)
			end
		end
	end

	noFlyZoneParts = {}
	for _, part in ipairs(CollectionService:GetTagged("EggrotNoFlyZone")) do
		if part:IsA("BasePart") then table.insert(noFlyZoneParts, part) end
	end

	setupGalaxyPads()

	for _, player in ipairs(Players:GetPlayers()) do
		task.defer(function() markZone(player, "Spawn") loadPlayerJumps(player) end)
	end
	table.insert(runningTasks, Players.PlayerAdded:Connect(function(player)
		task.delay(2, function() if isActive then markZone(player, "Spawn") loadPlayerJumps(player) end end)
	end))

	local function watchJumps(player)
		table.insert(runningTasks, player:GetAttributeChangedSignal("ExtraJumps"):Connect(function()
			if not isActive then return end
			local allowed = getPlayerJumpLevel(player) + 1
			if (player:GetAttribute("ExtraJumps") or 0) ~= allowed then setExtraJumps(player, allowed) end
		end))
	end
	for _, player in ipairs(Players:GetPlayers()) do watchJumps(player) end
	table.insert(runningTasks, Players.PlayerAdded:Connect(function(player)
		task.delay(1, function() if isActive then watchJumps(player) end end)
	end))

	table.insert(runningTasks, ClaimCoinRemote.OnServerEvent:Connect(function(player, coinId)
		if typeof(coinId) ~= "string" then return end
		local part = occupiedCoins[coinId]
		if not part then return end
		local char = player.Character
		if not char or not char.PrimaryPart then return end
		if (char.PrimaryPart.Position - part.Position).Magnitude > 25 then return end
		partToCoinsMap[part] = nil
		occupiedCoins[coinId] = nil
		onCoinClaimed(part)
		getBunnyCoinsService():Add(player, 1)
		ClaimCoinRemote:FireAllClients(coinId, player, 1)
	end))

	table.insert(runningTasks, task.spawn(function()
		while isActive do
			if #coinSpawnPoints > 0 then
				local available = {}
				for _, part in ipairs(coinSpawnPoints) do
					if not partToCoinsMap[part] and not partCooldowns[part] then table.insert(available, part) end
				end
				local spawned = 0
				while spawned < COINS_PER_TICK and #available > 0 do
					local idx = math.random(1, #available)
					spawnCoinAt(available[idx])
					table.remove(available, idx)
					spawned += 1
				end
			end
			task.wait(COIN_TICK_INTERVAL)
		end
	end))

	table.insert(runningTasks, task.spawn(function()
		while isActive do
			task.wait(EGG_SPAWN_INTERVAL)
			if isActive and #eggSpawnParts > 0 then spawnWorldEgg(eggSpawnParts) end
		end
	end))

	table.insert(runningTasks, task.spawn(function()
		while isActive do
			task.wait(GOLD_EGG_INTERVAL)
			if isActive and #goldEggParts > 0 then spawnGoldEgg(goldEggParts) end
		end
	end))

	table.insert(runningTasks, task.spawn(function()
		while isActive do
			task.wait(1)
			local pr = workspace:FindFirstChild("WBPools")
			if not pr then continue end
			local folder = pr:FindFirstChild(toSafeName(POOL_ID))
			if not folder then continue end
			for id in pairs(table.clone(activeEggs)) do
				local part = folder:FindFirstChild(id)
				if not part then activeEggs[id] = nil continue end
				if (part:GetAttribute("BG") or 0) ~= 0 then continue end
				local bdt = part:GetAttribute("BDT")
				if bdt ~= nil and bdt > 0 then part:SetAttribute("BDT", bdt - 1) end
			end
		end
	end))

	table.insert(runningTasks, task.spawn(function()
		while isActive do
			local stock = pickCandyStock()
			ReplicatedStorage:SetAttribute("EggrotCandyStock", stock)
			candyPurchasedThisCycle = {}
			local nextRefresh = 300 - Workspace:GetServerTimeNow() % 300
			if nextRefresh < 1 then nextRefresh = 300 end
			task.wait(nextRefresh)
		end
	end))

	table.insert(runningTasks, task.spawn(function()
		while isActive do
			if #noFlyZoneParts > 0 then
				for _, player in ipairs(Players:GetPlayers()) do
					local char = player.Character
					if not char then continue end
					if not isInNoFlyZone(char) then continue end
					for _, item in ipairs(char:GetChildren()) do
						if item:IsA("Tool") and NO_FLY_TOOLS[item.Name] then
							local hum = char:FindFirstChildOfClass("Humanoid")
							if hum then hum:UnequipTools() end
							NoFlyRemote:FireClient(player)
							break
						end
					end
				end
			end
			task.wait(0.5)
		end
	end))

	task.defer(function() if isActive and ufosFolder then setupUFOPatrol() end end)

	BuyJumpRemote.OnServerInvoke = function(player)
		if not isActive then return false, "Event not active" end
		local now = Workspace:GetServerTimeNow()
		if buyJumpCooldowns[player.UserId] and now - buyJumpCooldowns[player.UserId] < BUY_JUMP_COOLDOWN then
			return false, "Too fast!"
		end
		local data = getSynchronizer():Get(player)
		if not data then return false, "Data error" end
		local currentLevel = data:Get({"EasterEvent", "JumpShop"}) or 0
		local nextTier = currentLevel + 1
		local tierData = getJumpData()[nextTier]
		if not tierData then return false, "Max level reached" end
		if tierData.Zone then
			local visited = data:Get({"EasterEvent", "VisitedZones"}) or {}
			if not visited[tierData.Zone] then return false, "Visit the required island first" end
		end
		local coins = data:Get({"EasterEvent", "BunnyCoins"}) or 0
		if coins < tierData.Price then return false, "Not enough Bunny Coins." end
		buyJumpCooldowns[player.UserId] = now
		getBunnyCoinsService():Add(player, -tierData.Price)
		data:Set({"EasterEvent", "JumpShop"}, nextTier)
		setExtraJumps(player, nextTier + 1)
		return true, "Jump upgraded!"
	end

	BuyCandyRemote.OnServerInvoke = function(player, itemName)
		if not isActive then return false, "Event not active" end
		if typeof(itemName) ~= "string" then return false, "Invalid item" end
		local CandyData = getCandyData()
		local itemData = CandyData[itemName]
		if not itemData then return false, "Unknown item" end
		local currentStock = ReplicatedStorage:GetAttribute("EggrotCandyStock") or ""
		local inStock = false
		for _, name in ipairs(string.split(currentStock, "|")) do
			if name == itemName then inStock = true break end
		end
		if not inStock then return false, "Not in stock right now" end
		local uid = player.UserId
		if not candyPurchasedThisCycle[uid] then candyPurchasedThisCycle[uid] = {} end
		if (candyPurchasedThisCycle[uid][itemName] or 0) >= (itemData.MaxOwned or 1) then
			return false, "Already purchased this item this cycle."
		end
		local canAfford, _ = getMoneyService():CanAfford(player, itemData.Price)
		if not canAfford then return false, "Not enough coins." end
		candyPurchasedThisCycle[uid][itemName] = (candyPurchasedThisCycle[uid][itemName] or 0) + 1
		getMoneyService():Add(player, -itemData.Price)
		local itemsFolder = ReplicatedStorage:FindFirstChild("Items")
		if itemsFolder then
			local gear = itemsFolder:FindFirstChild(itemName)
			if gear then
				local backpack = player:FindFirstChild("Backpack")
				if backpack then gear:Clone().Parent = backpack end
			end
		end
		return true, "Purchased " .. itemName .. "!"
	end

	Players.PlayerRemoving:Connect(function(player)
		buyJumpCooldowns[player.UserId] = nil
		candyPurchasedThisCycle[player.UserId] = nil
	end)

	local AnimalService = getAnimalService()
	AnimalService:PauseSpawning()
	table.insert(runningTasks, task.delay(10, function()
		if isActive then AnimalService:UnpauseSpawning() end
	end))
end

function EggrotHunt.OnStop()
	if not isActive then return end
	isActive = false
	getAnimalService():UnpauseSpawning()
	BuyJumpRemote.OnServerInvoke = nil
	BuyCandyRemote.OnServerInvoke = nil
	for _, t in ipairs(runningTasks) do
		if typeof(t) == "RBXScriptConnection" then t:Disconnect()
		elseif t then pcall(task.cancel, t) end
	end
	runningTasks = {}
	for coinId in pairs(table.clone(occupiedCoins)) do
		DestroyCoinRemote:FireAllClients(coinId)
	end
	occupiedCoins = {}; partToCoinsMap = {}; partCooldowns = {}
	coinSpawnPoints = {}; noFlyZoneParts = {}
	activeEggs = {}; activeGoldEggs = {}
	buyJumpCooldowns = {}; candyPurchasedThisCycle = {}
	for _, player in ipairs(Players:GetPlayers()) do setExtraJumps(player, 0) end
	if jumpShopModel and jumpShopModel.Parent then jumpShopModel:Destroy() jumpShopModel = nil end
	if islandsFolder and islandsFolder.Parent then islandsFolder:Destroy() islandsFolder = nil end
	if ufosFolder and ufosFolder.Parent then ufosFolder:Destroy() ufosFolder = nil end
	getWorldBrainrotService():DestroyPool(POOL_ID)
	ReplicatedStorage:SetAttribute("EggrotHuntActive", nil)
	ReplicatedStorage:SetAttribute("EggrotHuntStart", nil)
	ReplicatedStorage:SetAttribute("EggrotCandyStock", nil)
	ReplicatedStorage:SetAttribute("EggrotHuntEvent", nil)
end

return EggrotHunt
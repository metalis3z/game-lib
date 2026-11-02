
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")
local HttpService       = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local RunService        = game:GetService("RunService")

local Net         = require(ReplicatedStorage.Packages.Net)
local ServerData  = require(ReplicatedStorage.Datas.ServerData)
local Trove       = require(ReplicatedStorage.Packages.Trove)

local DestroyGoldCoin = Net:RemoteEvent("EventService/St Patricks/DestroyGoldCoin")
local SpawnGoldCoin   = Net:RemoteEvent("EventService/St Patricks/SpawnGoldCoin")
local ClaimGoldCoin   = Net:RemoteEvent("EventService/St Patricks/ClaimGoldCoin")
local HitRemote       = Net:RemoteEvent("EventService/St Patricks/Hit")

local GoldCoinService = require(game.ServerScriptService.Services.BunnyCoinsService)

local StPatricks = {}

local trove       = Trove.new()
local isActive    = false
local startTime   = nil
local loopTask    = nil

local activeCoins = {}
local coinCounter = 0

local recentlyTargeted = {}

local COIN_REWARD_BASE   = 1
local COIN_REWARD_RANGE  = 3
local LUCKY_TRAIT_NAME   = "Lucky"
local LUCKY_COOLDOWN     = 20
local COIN_FLIGHT_TIME   = 1.2

local COIN_WAVE_MIN = 4
local COIN_WAVE_MAX = 7

local EARLY_WINDOW_START  = 6
local EVENT_INITIAL_DELAY = 5

local POT_TEMPLATE_NAME   = "StPatricksPotTemplate"
local POT_SPAWN_CFRAME = CFrame.new(-442.252, -5.211, 17.608) * CFrame.Angles(0, math.rad(90), 0)

local function hasLucky(animalTemplate)
	if not animalTemplate or not animalTemplate.Parent then return false end
	local json = animalTemplate:GetAttribute("Traits")
	if not json then return false end
	local ok, traits = pcall(function() return HttpService:JSONDecode(json) end)
	if not ok or type(traits) ~= "table" then return false end
	for _, t in ipairs(traits) do
		if t == LUCKY_TRAIT_NAME then return true end
	end
	return false
end

local function applyLucky(animalTemplate)
	if not animalTemplate or not animalTemplate.Parent then return end
	if hasLucky(animalTemplate) then return end

	local json = animalTemplate:GetAttribute("Traits")
	local traits = {}
	if json then
		local ok, decoded = pcall(function() return HttpService:JSONDecode(json) end)
		if ok and type(decoded) == "table" then
			traits = decoded
		end
	end

	table.insert(traits, LUCKY_TRAIT_NAME)
	animalTemplate:SetAttribute("Traits", HttpService:JSONEncode(traits))
end

local function pickLuckyTarget()
	local animals     = CollectionService:GetTagged("Animal")
	local currentTime = workspace:GetServerTimeNow()

	for id, t in pairs(recentlyTargeted) do
		if (currentTime - t) > LUCKY_COOLDOWN then
			recentlyTargeted[id] = nil
		end
	end

	local candidates = {}
	for _, animal in ipairs(animals) do
		if animal.PrimaryPart then
			local id = animal.Name
			if not recentlyTargeted[id] and not hasLucky(animal) then
				table.insert(candidates, animal)
			end
		end
	end

	if #candidates == 0 then return nil end
	return candidates[math.random(1, #candidates)]
end

local function grantLucky(targetAnimal)
	if not targetAnimal or not targetAnimal.PrimaryPart then return end

	task.delay(1, function()
		local animalId  = targetAnimal.Name
		local pos       = targetAnimal.PrimaryPart.Position
		recentlyTargeted[animalId] = workspace:GetServerTimeNow()
		HitRemote:FireAllClients(pos)
		applyLucky(targetAnimal)
	end)
end


local function newCoinId()
	coinCounter += 1
	return ("coin_%d_%d"):format(os.time(), coinCounter)
end

local function getCoinSpawnData()
	local pot = workspace:FindFirstChild("StPatricksPot")
	local originPos = Vector3.new(0, 5, 0)
	if pot then
		local root = pot:FindFirstChild("Pot") and pot.Pot:FindFirstChild("RootPart")
		if root then
			originPos = root.Position + Vector3.new(0, 2, 0)
		end
	end

	local wanderModel = workspace:FindFirstChild("Events")
		and workspace.Events:FindFirstChild("Wander")
	local wanderParts = {}
	if wanderModel then
		for _, child in ipairs(wanderModel:GetDescendants()) do
			if child:IsA("BasePart") then
				table.insert(wanderParts, child)
			end
		end
	end

	local landPos

	if #wanderParts > 0 then
		local part = wanderParts[math.random(1, #wanderParts)]
		local cf   = part.CFrame
		local size = part.Size

		local randX = (math.random() - 0.5) * size.X
		local randZ = (math.random() - 0.5) * size.Z

		local topFaceWorld = cf:PointToWorldSpace(Vector3.new(randX, size.Y / 2, randZ))

		local ray = workspace:Raycast(
			topFaceWorld + Vector3.new(0, 10, 0),
			Vector3.new(0, -30, 0),
			RaycastParams.new()
		)

		landPos = ray and ray.Position or topFaceWorld
	else
		warn("StPatricks getCoinSpawnData: workspace.Events.Wander has no BaseParts — falling back to radius spawn.")
		local angle    = math.random() * math.pi * 2
		local radius   = math.random(15, 40)
		local targetXZ = Vector3.new(
			originPos.X + math.cos(angle) * radius,
			originPos.Y + 20,
			originPos.Z + math.sin(angle) * radius
		)

		local ray = workspace:Raycast(
			targetXZ,
			Vector3.new(0, -40, 0),
			RaycastParams.new()
		)

		landPos = ray and ray.Position or (targetXZ - Vector3.new(0, 20, 0))
	end

	return landPos, originPos
end

local function spawnCoinWave(count)
	for _ = 1, count do
		local coinId          = newCoinId()
		local landPos, origin = getCoinSpawnData()
		local spawnTime       = workspace:GetServerTimeNow()

		activeCoins[coinId] = {
			owner     = nil,
			position  = landPos,
			spawnTime = spawnTime,
		}

		SpawnGoldCoin:FireAllClients(coinId, origin, landPos, spawnTime, COIN_FLIGHT_TIME)
	end
end

local function destroyCoin(coinId)
	activeCoins[coinId] = nil
	DestroyGoldCoin:FireAllClients(coinId)
end


local function setupWorldObjects()
	local potTemplate = ReplicatedStorage:FindFirstChild(POT_TEMPLATE_NAME)
		or workspace:FindFirstChild(POT_TEMPLATE_NAME)

	if not potTemplate then
		warn("StPatricks: Could not find pot template named '" .. POT_TEMPLATE_NAME .. "'")
	else
		local potClone = potTemplate:Clone()
		potClone.Name  = "StPatricksPot"
		potClone.Parent = workspace
		potClone:PivotTo(POT_SPAWN_CFRAME)
		trove:Add(potClone)
	end

	local ADMINBOARD_EVENT_CFRAME = CFrame.new(-444.2, 0.374, -7.964)
		* CFrame.Angles(0, math.rad(-90), 0)

	local board = workspace:FindFirstChild("EventBoard")

	if board and board.Parent then
		local originalCFrame = board:GetPivot()

		board:PivotTo(ADMINBOARD_EVENT_CFRAME)

		trove:Add(function()
			if board and board.Parent then
				board:PivotTo(originalCFrame)
			end
		end)
	end
end


ClaimGoldCoin.OnServerEvent:Connect(function(player, coinId)
	if not isActive then return end

	local coin = activeCoins[coinId]
	if not coin then return end
	if coin.owner then return end

	coin.owner = player

	local reward = COIN_REWARD_BASE

	task.delay(0.4, function()
		GoldCoinService:Add(player, reward)
	end)

	ClaimGoldCoin:FireAllClients(coinId, player, reward)
	activeCoins[coinId] = nil
end)


local function runEventLoop()
	task.wait(EVENT_INITIAL_DELAY)

	while isActive do
		local coinCount = math.random(COIN_WAVE_MIN, COIN_WAVE_MAX)
		spawnCoinWave(coinCount)

		task.delay(30, function()
			for id, data in pairs(activeCoins) do
				if data.spawnTime and (workspace:GetServerTimeNow() - data.spawnTime) >= 30 then
					destroyCoin(id)
				end
			end
		end)

		local luckyTarget = pickLuckyTarget()
		if luckyTarget then
			grantLucky(luckyTarget)
		end

		task.wait(math.random(400, 700) / 100)
	end
end


function StPatricks.OnStart()
	if isActive then return end
	isActive  = true
	startTime = workspace:GetServerTimeNow()

	setupWorldObjects()

	ReplicatedStorage:SetAttribute("StPatricksEvent", true)
	ReplicatedStorage:SetAttribute("StPatricksEventLastTime", os.time())

	loopTask = task.spawn(runEventLoop)

end

function StPatricks.OnStop()
	if not isActive then return end
	isActive = false

	if loopTask then
		task.cancel(loopTask)
		loopTask = nil
	end

	for coinId in pairs(activeCoins) do
		destroyCoin(coinId)
	end
	activeCoins = {}

	recentlyTargeted = {}

	ReplicatedStorage:SetAttribute("StPatricksEvent", nil)

	trove:Clean()

end

return StPatricks
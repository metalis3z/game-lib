local StPatricks = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)

local ServerScriptService = game:GetService("ServerScriptService")
local GoldPotService = require(ServerScriptService.Services.GoldPotService)

local DestroyGoldCoin = Net:RemoteEvent("EventService/St Patricks/DestroyGoldCoin")
local SpawnGoldCoin = Net:RemoteEvent("EventService/St Patricks/SpawnGoldCoin")
local ClaimGoldCoin = Net:RemoteEvent("EventService/St Patricks/ClaimGoldCoin")
local Hit = Net:RemoteEvent("EventService/St Patricks/Hit")

local COIN_VALUE = 1
local COIN_LIFETIME = 30
local SPAWN_INTERVAL = 3
local CLAIM_COOLDOWN = 0.2

local ActiveCoins = {}
local PlayerClaimCooldowns = {}

local IsRunning = false
local SpawnLoopRunning = false

local function getTimer()

	local pot = workspace:FindFirstChild("StPatricksPot")
	if not pot then return end

	local gui = pot.Overhead.BillboardGui
	if not gui then return end

	return gui.Timer

end

local function getRandomSpawnPosition()

	local map = workspace:FindFirstChild("Map")
	if not map then
		return Vector3.new(0,5,0)
	end

	local parts = {}

	for _,p in ipairs(map:GetDescendants()) do
		if p:IsA("BasePart") then
			table.insert(parts,p)
		end
	end

	if #parts == 0 then
		return Vector3.new(0,5,0)
	end

	local part = parts[math.random(1,#parts)]

	return part.Position + Vector3.new(
		math.random(-20,20),
		5,
		math.random(-20,20)
	)

end

local function getPotPosition()

	local pot = workspace:FindFirstChild("StPatricksPot")
	if not pot then
		return Vector3.new(0,5,0)
	end

	local potModel = pot:FindFirstChild("Pot")
	local rootPart = potModel and potModel:FindFirstChild("RootPart")
	local bone = rootPart and rootPart:FindFirstChild("Bone")

	if bone then
		return bone.WorldPosition + Vector3.new(0,2,0)
	end

	return Vector3.new(0,5,0)

end

local function spawnCoin()

	local coinId = HttpService:GenerateGUID(false)

	local potPos = getPotPosition()
	local targetPos = getRandomSpawnPosition()

	local spawnTime = workspace:GetServerTimeNow()
	local travelDuration = 1.5

	ActiveCoins[coinId] = {
		Claimed = false
	}

	SpawnGoldCoin:FireAllClients(
		coinId,
		potPos,
		targetPos,
		spawnTime,
		travelDuration
	)

	task.delay(COIN_LIFETIME,function()

		if ActiveCoins[coinId] then
			ActiveCoins[coinId] = nil
			DestroyGoldCoin:FireAllClients(coinId)
		end

	end)

end

local function clearCoins()

	for coinId in pairs(ActiveCoins) do
		DestroyGoldCoin:FireAllClients(coinId)
	end

	table.clear(ActiveCoins)
	table.clear(PlayerClaimCooldowns)

end

ClaimGoldCoin.OnServerEvent:Connect(function(player,coinId)

	if not IsRunning then return end

	local coin = ActiveCoins[coinId]
	if not coin then return end

	local now = tick()
	local lastClaim = PlayerClaimCooldowns[player.UserId]

	if lastClaim and (now-lastClaim) < CLAIM_COOLDOWN then
		return
	end

	PlayerClaimCooldowns[player.UserId] = now

	ActiveCoins[coinId] = nil

	local playerChannel = Synchronizer:Get(player)

	if playerChannel then
		playerChannel:Increase("StPatricksEvent.GoldCoins",COIN_VALUE)
	end

	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

	Hit:FireAllClients(hrp and hrp.Position or Vector3.new())

	ClaimGoldCoin:FireAllClients(
		coinId,
		player,
		COIN_VALUE
	)

end)

task.spawn(function()

	while true do

		local timer = getTimer()

		if timer then

			if IsRunning then
				timer.Text = "Rainbow Active!"
			else
				timer.Text = "Next Rainbow in "..TimeUtils:E(
					GoldPotService:GetTimeUntilRainbow()
				)
			end

		end

		task.wait(1)

	end

end)

function StPatricks.OnStart()

	if IsRunning then return end

	IsRunning = true

	if SpawnLoopRunning then return end

	SpawnLoopRunning = true

	task.spawn(function()

		while IsRunning do
			spawnCoin()
			task.wait(SPAWN_INTERVAL)
		end

		SpawnLoopRunning = false

	end)

end

function StPatricks.OnStop()

	if not IsRunning then return end

	IsRunning = false

	clearCoins()

end

return StPatricks
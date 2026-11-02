local PinataService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local Animals = require(ReplicatedStorage.Datas.Animals)

local HitEvent = Net:RemoteEvent("PinataService/Hit")
local BurstEvent = Net:RemoteEvent("PinataService/Burst")
local SpawnGearEvent = Net:RemoteEvent("PinataService/SpawnGear")
local DestroyGearEvent = Net:RemoteEvent("PinataService/DestroyGear")
local PickGearEvent = Net:RemoteEvent("PinataService/PickGear")
local BlinkEvent = Net:RemoteEvent("PinataService/Blink")

local HitCount = 0
local MaxHits = 10
local IsActive = false
local GearConnections = {}
local ActiveGears = {}
local GearCounter = 0

local function FireAllClients(event, ...)
	for _, player in ipairs(Players:GetPlayers()) do
		event:FireClient(player, ...)
	end
end

local function SpawnGear(position)
	GearCounter += 1
	local gearId = tostring(GearCounter)
	local spawnPos = position or workspace.Pinata and workspace.Pinata.PrimaryPart and workspace.Pinata.PrimaryPart.Position or Vector3.new(0, 5, 0)
	local landPos = spawnPos + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
	local gearTypes = {"Candy Cane", "Cake Trap", "Candy Bomb", "Candy Coils", "Candy Launcher", "Candy Slap"}
	local gearType = gearTypes[math.random(1, #gearTypes)]
	local travelTime = 1.5

	ActiveGears[gearId] = {
		Position = landPos,
		Type = gearType
	}

	FireAllClients(SpawnGearEvent, gearId, gearType, spawnPos, landPos, workspace:GetServerTimeNow(), travelTime)

	return gearId
end

local function DestroyGear(gearId)
	if not ActiveGears[gearId] then return end
	ActiveGears[gearId] = nil
	FireAllClients(DestroyGearEvent, gearId)
end

function PinataService:OnStop()
	IsActive = false
	HitCount = 0

	for gearId in pairs(ActiveGears) do
		FireAllClients(DestroyGearEvent, gearId)
	end
	ActiveGears = {}

	for _, conn in ipairs(GearConnections) do
		conn:Disconnect()
	end
	GearConnections = {}

	local pinata = workspace:FindFirstChild("Pinata")
	if pinata then
		pinata:Destroy()
	end
end

function PinataService:OnStart()
	if IsActive then return end
	IsActive = true
	HitCount = 0

	local pinataClone = script.Pinata:Clone()
	pinataClone.Name = "Pinata"
	pinataClone.Parent = workspace

	local primaryPart = pinataClone.PrimaryPart or pinataClone:FindFirstChildWhichIsA("BasePart")

	local hitConn = HitEvent.OnServerEvent:Connect(function(player)
		if not IsActive then return end

		HitCount += 1

		local hitPos = primaryPart and primaryPart.Position or Vector3.new(0, 5, 0)
		FireAllClients(HitEvent, hitPos)
		FireAllClients(BlinkEvent)

		if HitCount >= MaxHits then
			FireAllClients(BurstEvent, hitPos)

			local spawnedGears = {}
			for i = 1, math.random(3, 6) do
				local gearId = SpawnGear(hitPos)
				table.insert(spawnedGears, gearId)
			end

			local pickConn
			pickConn = PickGearEvent.OnServerEvent:Connect(function(pickPlayer, gearId)
				if not ActiveGears[gearId] then return end
				DestroyGear(gearId)

				if math.random(1, 3) == 1 then
					AnimalService:CustomAnimalSpawnOnQueue(Animals["Mariachi Corazoni"], nil, nil, nil, {
						Start = workspace.MapCenter,
						End = workspace.Road.End,
						Owner = nil
					}, 1)
				end
			end)

			table.insert(GearConnections, pickConn)

			task.delay(10, function()
				for _, gearId in ipairs(spawnedGears) do
					DestroyGear(gearId)
				end
				PinataService:OnStop()
			end)

			return
		end

		SpawnGear(hitPos)
	end)

	table.insert(GearConnections, hitConn)
end

return PinataService
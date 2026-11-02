local Eid = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")

local Net          = require(ReplicatedStorage.Packages.Net)
local Trove        = require(ReplicatedStorage.Packages.Trove)
local AnimalService = require(ServerScriptService.Services.AnimalService)

local RE_Burst = Net:RemoteEvent("EventService/Eid/Burst")

local BALLOON_TRAITS = {
	"Orange Balloon",
	"Green Balloon",
	"Blue Balloon",
	"Red Balloon",
	"Pink Balloon",
	"Rainbow Balloon",
}

local CONFIG = {
	BurstInterval = 6,
}

local trove
local running = false
local playerCooldowns = {}

local function randomBalloon()
	return BALLOON_TRAITS[math.random(1, #BALLOON_TRAITS)]
end

local function getAnimalsOnRoad()
	local animals = {}
	for _, model in CollectionService:GetTagged("Animal") do
		if model.PrimaryPart then
			table.insert(animals, model)
		end
	end
	return animals
end

local function burstAnimal()
	local animals = getAnimalsOnRoad()
	if #animals == 0 then return end

	local target = animals[math.random(1, #animals)]
	local primary = target.PrimaryPart
	if not primary then return end

	local trait = randomBalloon()
	AnimalService:AddTraits(target, { trait })

	RE_Burst:FireAllClients(primary.Position, nil)
end

local function spawnBalloons()
	local map = workspace:FindFirstChild("EidMap")
		or workspace:FindFirstChild("BiggerEidMap")
	if not map then
		warn("[EidService] EidMap not found")
		return
	end

	local mapCenter = map:GetPivot().Position
	local POSITIONS = {
		Vector3.new(10, 0, 10), Vector3.new(-10, 0, 10),
		Vector3.new(10, 0, -10), Vector3.new(-10, 0, -10),
		Vector3.new(20, 0, 0), Vector3.new(-20, 0, 0),
		Vector3.new(0, 0, 20), Vector3.new(0, 0, -20),
	}

	for i, pos in POSITIONS do
		local part = Instance.new("Part")
		part.Name = "Balloon_" .. i
		part.Anchored = true
		part.CanCollide = false
		part.Transparency = 1
		part.Size = Vector3.new(2, 2, 2)
		part.Position = mapCenter + pos + Vector3.new(0, 5, 0)
		part:SetAttribute("BalloonColor", randomBalloon():gsub(" Balloon", ""))
		CollectionService:AddTag(part, "EidBalloon")
		part.Parent = workspace
		trove:Add(part)
	end
end

function Eid.OnStart(eventData)
	warn("[EidService] OnStart called!")
	trove = Trove.new()
	playerCooldowns = {}
	running = true

	trove:Add(RE_Burst.OnServerEvent:Connect(function(player, position)
		if typeof(position) ~= "Vector3" then return end
		local now = os.clock()
		if now - (playerCooldowns[player] or 0) < 0.5 then return end
		playerCooldowns[player] = now
		RE_Burst:FireAllClients(position, player)
	end))

	trove:Add(Players.PlayerRemoving:Connect(function(player)
		playerCooldowns[player] = nil
	end))

	task.delay(2, function()
		if running then spawnBalloons() end
	end)

	task.spawn(function()
		task.wait(3)
		while running do
			task.spawn(burstAnimal)
			task.wait(CONFIG.BurstInterval)
		end
	end)
end

function Eid.OnStop(eventData)
	warn("[EidService] OnStop called!")
	running = false
	playerCooldowns = {}

	for _, part in CollectionService:GetTagged("EidBalloon") do
		if part.Parent == workspace then part:Destroy() end
	end

	if trove then
		trove:Destroy()
		trove = nil
	end
end

return Eid
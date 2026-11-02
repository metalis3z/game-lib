-- PoleEventController (Server Script in ServerScriptService)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)

-- ⭐ Import the Indonesia Server Module
-- ⭐ ENSURE THE PATH TO THE INDONESIA MODULE IS CORRECT
local Indonesia = require(ReplicatedStorage.Controllers.EventController.Events.Indonesia) 

-- Define the RemoteEvents used by the client module
local FireBlink = Net:RemoteEvent("PoleGameService/Blink")
local FireBurst = Net:RemoteEvent("PoleGameService/Burst")
-- Listen for the client picking up gear (fires from the ProximityPrompt inside Indonesia module)
local OnPickGear = Net:RemoteEvent("PoleGameService/PickGear") 

-- Data store to track active gears on the server
local activeGears = {}
local gearCount = 0

-- Configuration
local GEAR_TYPES = {"TypeA", "TypeB", "TypeC"} -- Example gear types for the client's visual logic
local GEAR_LIFESPAN = 15 -- seconds
local GEAR_SPAWN_INTERVAL = 10 -- seconds

-- --- Helper Functions ---

local function spawnNewGear()
	gearCount = gearCount + 1
	local gearId = "Gear_" .. gearCount
	local gearType = GEAR_TYPES[math.random(1, #GEAR_TYPES)]

	-- Example: Define a random spawn position (relative to the center)
	local spawnPosition = Vector3.new(math.random(-50, 50), 15, math.random(-50, 50))
	local endPosition = Vector3.new(spawnPosition.X, 0.5, spawnPosition.Z) -- Raycast will find the final resting spot

	local spawnTime = workspace:GetServerTimeNow()

	-- Store gear info on the server
	activeGears[gearId] = {
		Id = gearId,
		Type = gearType,
		SpawnTime = spawnTime,
		Lifespan = GEAR_LIFESPAN,
		DestroyTask = nil
	}

	print("Spawning new gear:", gearId, "Type:", gearType)

	-- Call the Indonesia module's function to handle physical spawning and client events
	Indonesia.SpawnGear(
		gearId,
		gearType, 
		spawnPosition,
		endPosition,
		spawnTime,
		GEAR_LIFESPAN
	)

	-- Set a task to destroy the gear after its lifespan
	local destroyTask = task.delay(GEAR_LIFESPAN, function()
		if activeGears[gearId] then
			print("Destroying gear due to timeout:", gearId)
			-- Call the Indonesia module to destroy the physical gear and notify clients
			Indonesia.DestroyGear(gearId)
			activeGears[gearId] = nil
		end
	end)
	activeGears[gearId].DestroyTask = destroyTask
end

local function destroyGear(gearId)
	local gear = activeGears[gearId]
	if gear then
		-- Cancel the delayed destroy task if it hasn't run yet
		if gear.DestroyTask then
			task.cancel(gear.DestroyTask)
		end

		-- Call the Indonesia module to destroy the physical gear and notify clients
		Indonesia.DestroyGear(gearId)

		activeGears[gearId] = nil
		print("Destroyed gear:", gearId)
		return true
	end
	return false
end

-- --- Event Handlers ---

-- Handles a player picking up a gear (The actual game logic happens here)
OnPickGear.OnServerEvent:Connect(function(player, gearId)
	if activeGears[gearId] then
		print(player.Name, "picked up gear:", gearId, activeGears[gearId].Type)

		-- ⭐ TODO: Implement your game logic here
		-- Example: player:FindFirstChild("leaderstats").Points.Value = player:FindFirstChild("leaderstats").Points.Value + 10

		-- Remove the gear from the world (sends destroy event to all clients via destroyGear)
		destroyGear(gearId)

		-- Fire a burst effect at the last known position (requires getting position before destruction)
		-- FireBurst:FireAllClients(gear.LastKnownPosition or Vector3.new(0, 5, 0)) 
	else
		warn(player.Name, "tried to pick up an invalid or already picked up gear:", gearId)
	end
end)

-- --- Event Controller Initialization ---

local function startEventController()
	-- Initialize the Pole map and module-level event listeners
	Indonesia.OnStart() 

	-- Start the recurring task to spawn new gear
	task.spawn(function()
		while task.wait(GEAR_SPAWN_INTERVAL) do
			spawnNewGear()
		end
	end)

	print("Pole Game Event Controller Started.")
end

startEventController()
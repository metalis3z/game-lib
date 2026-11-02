--!strict
-- LOCATION: ServerScriptService/CollisionController

local Players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")
local Workspace = game:GetService("Workspace")

local GROUP_CHAR = "PlayerCharacters"
local GROUP_ZONES = "ZoneParts"
local GROUP_LUCKY_BLOCKS = "LuckyBlocks"
local GROUP_BRAINROT_PETS = "BrainrotPets"

-- 1. Create the Collision Groups
local function setupCollisionGroups()
	pcall(function()
		-- Register the groups
		PhysicsService:RegisterCollisionGroup(GROUP_CHAR)
		PhysicsService:RegisterCollisionGroup(GROUP_ZONES)
		PhysicsService:RegisterCollisionGroup(GROUP_LUCKY_BLOCKS)

		-- Disable self-collisions (Players ignore Players)
		PhysicsService:CollisionGroupSetCollidable(GROUP_CHAR, GROUP_CHAR, false)

		-- Ensure Players CAN collide with Zones (Solid)
		PhysicsService:CollisionGroupSetCollidable(GROUP_CHAR, GROUP_ZONES, true)

		-- Make Lucky Blocks ignore Players and Zones (but they will still hit the normal floor)
		PhysicsService:CollisionGroupSetCollidable(GROUP_LUCKY_BLOCKS, GROUP_CHAR, false)
		PhysicsService:CollisionGroupSetCollidable(GROUP_LUCKY_BLOCKS, GROUP_ZONES, false)

		-- Brainrot pets (conveyor + slot items) never collide with players
		PhysicsService:RegisterCollisionGroup(GROUP_BRAINROT_PETS)
		PhysicsService:CollisionGroupSetCollidable(GROUP_BRAINROT_PETS, GROUP_CHAR, false)
		PhysicsService:CollisionGroupSetCollidable(GROUP_BRAINROT_PETS, "Players", false)
	end)
end

-- 2. Function to apply the group to character parts
local function setCharacterCollisionGroup(object: Instance)
	if object:IsA("BasePart") then
		pcall(function()
			object.CollisionGroup = GROUP_CHAR
		end)
	end
end

-- 3. Handler for when a character loads
local function onCharacterAdded(character: Model)
	-- Apply to existing parts (Head, Torso, Legs)
	for _, descendant in ipairs(character:GetDescendants()) do
		setCharacterCollisionGroup(descendant)
	end

	-- Listen for new parts (Tools, Hats/Accessories loaded after spawn)
	character.DescendantAdded:Connect(setCharacterCollisionGroup)
end

local function onPlayerAdded(player: Player)
	player.CharacterAdded:Connect(onCharacterAdded)

	-- If character already exists (edge case)
	if player.Character then
		onCharacterAdded(player.Character)
	end
end

-- Initialize Player Collisions
setupCollisionGroups()

Players.PlayerAdded:Connect(onPlayerAdded)

for _, player in ipairs(Players:GetPlayers()) do
	onPlayerAdded(player)
end

-- 4. ZONE PARTS SETUP
local zonesFolder = Workspace:FindFirstChild("Zones")
if zonesFolder then
	local function setZoneSolid(object: Instance)
		if object:IsA("BasePart") then
			object.CanCollide = true
			object.CollisionGroup = GROUP_ZONES
		end
	end

	-- Apply to existing zone parts
	for _, descendant in ipairs(zonesFolder:GetDescendants()) do
		setZoneSolid(descendant)
	end

	-- Listen for new zone parts being added later
	zonesFolder.DescendantAdded:Connect(setZoneSolid)
end

print("[CollisionController] Collisions mapped: Lucky Blocks ignore Players and Zones.")
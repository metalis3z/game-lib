-- JardinAssignment: assigns each player to a jardin (1-8) based on join order
-- Player 1 -> Jardin 1, Player 2 -> Jardin 2, etc.
-- When their character spawns, they are teleported to their assigned jardin.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Maximum number of jardins
local MAX_JARDINS = 8

-- Find the JardinBases folder in ReplicatedStorage
local jardinBases = ReplicatedStorage:FindFirstChild("JardinBases")
if not jardinBases then
	jardinBases = Instance.new("Folder")
	jardinBases.Name = "JardinBases"
	jardinBases.Parent = ReplicatedStorage
	for i = 1, MAX_JARDINS do
		local val = Instance.new("IntValue")
		val.Name = tostring(i)
		val.Value = 0
		val.Parent = jardinBases
	end
end

-- Collect all jardin models by searching for the JardinNumber attribute
local jardinModels = {}

local function collectJardins()
	table.clear(jardinModels)
	local touteLesJardin = workspace:FindFirstChild("toute les jardin")
	if not touteLesJardin then return end
	for _, clotureAnimals in ipairs(touteLesJardin:GetChildren()) do
		if clotureAnimals.Name == "cloture animals" then
			for _, child in ipairs(clotureAnimals:GetChildren()) do
				local num = child:GetAttribute("JardinNumber")
				if num and type(num) == "number" then
					jardinModels[num] = child
				end
			end
		end
	end
end

collectJardins()

-- Track which jardins are assigned
local assignedJardins = {} -- jardinNumber -> PlayerId
local playerJardin = {} -- PlayerId -> jardinNumber

-- Find the next available jardin
local function getNextAvailableJardin()
	for i = 1, MAX_JARDINS do
		if not assignedJardins[i] then
			return i
			end
	end
	return nil -- all taken
end

-- Get the spawn position for a jardin (center, on the ground)
local function getJardinSpawnPos(jardinNum)
	local model = jardinModels[jardinNum]
	if not model then return nil end
	local cf, size = model:GetBoundingBox()
	-- Place the player on top of the ground (Y = bottom of box + 3 for character height)
	return cf.Position + Vector3.new(0, size.Y / 2 + 3, 0)
end

-- Assign a player to a jardin
local function assignPlayer(player)
	local jardinNum = getNextAvailableJardin()
	if not jardinNum then
		warn("No available jardin for player " .. player.Name .. " (all " .. MAX_JARDINS .. " taken)")
		return
	end

	assignedJardins[jardinNum] = player.UserId
	playerJardin[player.UserId] = jardinNum

	-- Store on the player as attributes for other systems to read
	player:SetAttribute("JardinNumber", jardinNum)

	-- Update the ReplicatedStorage value
	local baseVal = jardinBases:FindFirstChild(tostring(jardinNum))
	if baseVal then
		baseVal.Value = player.UserId
	end

	-- Store a reference to the jardin model on the player
	local jardinRef = Instance.new("ObjectValue")
	jardinRef.Name = "JardinModel"
	jardinRef.Value = jardinModels[jardinNum]
	jardinRef.Parent = player

	print(player.Name .. " assigned to Jardin " .. jardinNum)
end

-- Teleport the player's character to their jardin
local function teleportToJardin(character, jardinNum)
	local pos = getJardinSpawnPos(jardinNum)
	if not pos then return end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if hrp then
		-- Teleport using PivotTo so the whole character moves
		character:PivotTo(CFrame.new(pos))
	end
end

local function onPlayerAdded(player)
	assignPlayer(player)

	player.CharacterAdded:Connect(function(character)
		-- Wait a moment for the character to fully load
		task.wait(0.1)
		local jardinNum = playerJardin[player.UserId]
		if jardinNum then
			teleportToJardin(character, jardinNum)
		end
	end)
end

local function onPlayerRemoving(player)
	-- Free up the jardin
	local jardinNum = playerJardin[player.UserId]
	if jardinNum then
		assignedJardins[jardinNum] = nil
		playerJardin[player.UserId] = nil

		-- Update ReplicatedStorage
		local baseVal = jardinBases:FindFirstChild(tostring(jardinNum))
		if baseVal then
			baseVal.Value = 0
		end
	end
end

-- Connect events
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

-- Handle players already in the game
for _, player in ipairs(Players:GetPlayers()) do
	onPlayerAdded(player)
end

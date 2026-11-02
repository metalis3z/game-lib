local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local PartsFolder = ReplicatedStorage:WaitForChild("Parts")
local Level0 = PartsFolder:WaitForChild("Level_0")
local LevelArcade = PartsFolder:WaitForChild("Level_Arcade")
local LevelPoolrooms = PartsFolder:WaitForChild("Level_Poolrooms")
local PartSpawn = Level0:WaitForChild("Part_Spawn")

local CHUNK_SIZE = 60
local RENDER_DISTANCE = 7
local SPAWN_HEIGHT = 1

local spawnedChunks = {}

local function getChunkKey(x, z)
	return x .. "," .. z
end

local function getRoomList(folder)
	local rooms = {}

	for _, child in ipairs(folder:GetChildren()) do
		if child ~= PartSpawn and (child:IsA("Model") or child:IsA("BasePart")) then
			table.insert(rooms, child)
		end
	end

	return rooms
end

local function getBiomeFolder(x, z)
	local noise = math.noise(x * 0.03, z * 0.03)

	if noise > 0.4 then
		return LevelArcade
	elseif noise > 0.2 then
		return LevelPoolrooms
	end

	return Level0
end

local function setupChunk(chunk)
	for _, light in ipairs(chunk:GetDescendants()) do
		if light:IsA("BasePart") and light.Name == "Light" then
			local sfxFolder = light:FindFirstChild("Sfx")

			if sfxFolder then
				for _, sound in ipairs(sfxFolder:GetDescendants()) do
					if sound:IsA("Sound") then
						sound.Looped = true
						sound.Volume = 0.5
						sound:Play()
					end
				end
			end

			if math.random(1, 100) == 1 then
				light.Material = Enum.Material.Plastic
				light.Color = Color3.fromRGB(116, 116, 116)

				local attachment = light:FindFirstChild("Attachment")

				if attachment then
					local pointLight = attachment:FindFirstChildWhichIsA("PointLight")

					if pointLight then
						pointLight.Enabled = false
					end
				end
			end
		end
	end
end

local function getChunkTemplate(x, z)
	if x == 0 and z == 0 then
		return PartSpawn
	end

	local biomeFolder = getBiomeFolder(x, z)
	local rooms = getRoomList(biomeFolder)

	if #rooms == 0 then
		local fallbackRooms = getRoomList(Level0)

		if #fallbackRooms == 0 then
			return nil
		end

		return fallbackRooms[math.random(1, #fallbackRooms)]
	end

	return rooms[math.random(1, #rooms)]
end

local function spawnChunk(x, z)
	local key = getChunkKey(x, z)

	if spawnedChunks[key] then
		return
	end

	local chunkTemplate = getChunkTemplate(x, z)

	if not chunkTemplate then
		return
	end

	local clone = chunkTemplate:Clone()
	local targetCFrame = CFrame.new(x * CHUNK_SIZE, 0, z * CHUNK_SIZE)

	if not (x == 0 and z == 0) then
		targetCFrame *= CFrame.Angles(0, math.rad(math.random(0, 3) * 90), 0)
	end

	if clone:IsA("Model") then
		clone:PivotTo(targetCFrame)
	elseif clone:IsA("BasePart") then
		clone.CFrame = targetCFrame
	else
		return
	end

	clone.Parent = workspace
	setupChunk(clone)
	spawnedChunks[key] = clone
end

local function getSpawnCFrame()
	local spawnChunk = spawnedChunks["0,0"]

	if not spawnChunk then
		return CFrame.new(0, SPAWN_HEIGHT, 0)
	end

	local spawnPart = spawnChunk:FindFirstChild("Spawn", true)
		or spawnChunk:FindFirstChild("SpawnPoint", true)
		or spawnChunk:FindFirstChild("Part_Spawn", true)

	if spawnPart and spawnPart:IsA("BasePart") then
		return spawnPart.CFrame * CFrame.new(0, 3, 0)
	end

	if spawnChunk:IsA("Model") then
		return spawnChunk:GetPivot() * CFrame.new(0, SPAWN_HEIGHT, 0)
	end

	if spawnChunk:IsA("BasePart") then
		return spawnChunk.CFrame * CFrame.new(0, SPAWN_HEIGHT, 0)
	end

	return CFrame.new(0, SPAWN_HEIGHT, 0)
end

local function updateMap()
	local activeKeys = {}

	for _, player in ipairs(Players:GetPlayers()) do
		local character = player.Character

		if character and character:FindFirstChild("HumanoidRootPart") then
			local pos = character.HumanoidRootPart.Position

			local currentGridX = math.round(pos.X / CHUNK_SIZE)
			local currentGridZ = math.round(pos.Z / CHUNK_SIZE)

			for x = -RENDER_DISTANCE, RENDER_DISTANCE do
				for z = -RENDER_DISTANCE, RENDER_DISTANCE do
					local targetX = currentGridX + x
					local targetZ = currentGridZ + z

					spawnChunk(targetX, targetZ)
					activeKeys[getChunkKey(targetX, targetZ)] = true
				end
			end
		end
	end

	for key, chunk in pairs(spawnedChunks) do
		if not activeKeys[key] and key ~= "0,0" then
			chunk:Destroy()
			spawnedChunks[key] = nil
		end
	end
end

local function spawnPlayer(player, character)
	local hrp = character:WaitForChild("HumanoidRootPart")

	task.wait(0.25)

	local spawnCFrame = getSpawnCFrame()
	character:PivotTo(spawnCFrame)
	hrp.AssemblyLinearVelocity = Vector3.zero
	hrp.AssemblyAngularVelocity = Vector3.zero
end

local function setupPlayer(player)
	if player.Character then
		task.spawn(spawnPlayer, player, player.Character)
	end

	player.CharacterAdded:Connect(function(character)
		spawnPlayer(player, character)
	end)
end

spawnChunk(0, 0)
updateMap()

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

Players.PlayerAdded:Connect(setupPlayer)

task.spawn(function()
	task.wait(1)
	local entityTemplate = ReplicatedStorage:FindFirstChild("Entity")
	if entityTemplate then
		local spawnCFrame = getSpawnCFrame()
		local spawnPosition = spawnCFrame.Position + Vector3.new(15, 0, 15)

		local entityClone = entityTemplate:Clone()
		if entityClone:IsA("Model") then
			entityClone:PivotTo(CFrame.new(spawnPosition))
		elseif entityClone:IsA("BasePart") then
			entityClone.CFrame = CFrame.new(spawnPosition)
		end
		entityClone.Parent = workspace
	end
end)

while true do
	updateMap()
	task.wait(1)
end
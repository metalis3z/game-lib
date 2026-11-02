local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")
local WorldBrainrotService = require(ServerScriptService.Services.WorldBrainrotService)

local POOL_ID = "Admin/Spawned"

local function toSafeName(poolId)
	return poolId:gsub("[/\\%s]", "_")
end

return function(context, player, brainrotName, despawnTimer, mutation, fakeMode, showTimer, showDropButton)
	local AnimalsData = require(ReplicatedStorage.Datas.Animals)
	if not AnimalsData[brainrotName] then
		return "Error: Brainrot '" .. brainrotName .. "' not found in AnimalsData"
	end

	local character = player.Character
	if not character or not character.PrimaryPart then
		return "Error: Player " .. player.Name .. " has no valid character"
	end

	local rootPart = character.PrimaryPart

	local rayOrigin = rootPart.Position
	local rayDirection = Vector3.new(0, -100, 0)

	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = { character }

	local rayResult = Workspace:Raycast(rayOrigin, rayDirection, raycastParams)

	local spawnPosition
	if rayResult then
		spawnPosition = rayResult.Position + Vector3.new(0, 1, 0)
	else
		spawnPosition = rootPart.Position
	end

	local spawnCFrame = CFrame.new(spawnPosition)

	WorldBrainrotService:CreatePool(POOL_ID)

	local poolsRoot = Workspace:FindFirstChild("WBPools")
	if poolsRoot then
		local poolFolder = poolsRoot:FindFirstChild(toSafeName(POOL_ID))
		if poolFolder then
			poolFolder:SetAttribute("ShowTimer", showTimer)
			poolFolder:SetAttribute("ShowDropButton", showDropButton)
		end
	end

	mutation = mutation or ""
	despawnTimer = despawnTimer or 60
	fakeMode = fakeMode or ""

	if mutation == "Default" then
		mutation = ""
	end

	local spawnData = {
		brainrot = brainrotName,
		cframe = spawnCFrame,
		despawnTimer = despawnTimer,
		timer = -1,
		mutation = mutation,
		traits = {},
		caged = false,
		requiresLineOfSight = false
	}

	if fakeMode == "Grab" or fakeMode == "Purchase" or fakeMode == "Base" then
		spawnData.FakeMode = fakeMode
	end

	local brainrotId = WorldBrainrotService:SpawnBrainrot(POOL_ID, spawnData)

	if brainrotId then
		return string.format(
			"Spawned %s at %s's position (Pool: %s, ID: %s, Despawn: %ds%s%s, Timer: %s, DropBtn: %s)",
			brainrotName,
			player.Name,
			POOL_ID,
			brainrotId:sub(1, 8) .. "...",
			despawnTimer,
			mutation ~= "" and ", Mutation: " .. mutation or "",
			fakeMode ~= "" and ", FakeMode: " .. fakeMode or "",
			showTimer and "Yes" or "No",
			showDropButton and "Yes" or "No"
		)
	else
		return "Error: Failed to spawn brainrot"
	end
end
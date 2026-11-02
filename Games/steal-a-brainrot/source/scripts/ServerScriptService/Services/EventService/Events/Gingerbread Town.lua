local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Net = require(ReplicatedStorage.Packages.Net)

local Burst = Net:RemoteEvent("EventService/Gingerbread Town/Burst")

local GingerbreadEvent = {}

local isActive = false
local attackTask = nil
local wanderTask = nil
local recentlyTargeted = {}
local spawnedGingerbreads = {}

-- FIX: TOTAL_ENTITIES recalculé à chaque OnStart, pas au module load
local TOTAL_ENTITIES = 0
local WALK_SPEED = 22

-- FIX: RaycastParams.Blacklist est déprécié → Exclude
local RAY_PARAMS = RaycastParams.new()
RAY_PARAMS.FilterType = Enum.RaycastFilterType.Include
RAY_PARAMS.FilterDescendantsInstances = {workspace:FindFirstChild("Map") or workspace, workspace.Terrain}

local function stickToGround(position)
	local origin = position + Vector3.new(0, 10, 0)
	local direction = Vector3.new(0, -20, 0)
	local result = workspace:Raycast(origin, direction, RAY_PARAMS)
	if result then
		return result.Position + Vector3.new(0, 1, 0)
	end
	-- FIX: Exclude au lieu de Blacklist (déprécié)
	local backupParams = RaycastParams.new()
	backupParams.FilterType = Enum.RaycastFilterType.Exclude
	backupParams.FilterDescendantsInstances = {}
	local backupResult = workspace:Raycast(origin, direction, backupParams)
	if backupResult then
		return backupResult.Position + Vector3.new(0, 1, 0)
	end
	return position
end

local function getRandomWanderPosition(wanderPart)
	local size = wanderPart.Size
	local cf = wanderPart.CFrame
	local randomX = math.random(-size.X/2, size.X/2)
	local randomZ = math.random(-size.Z/2, size.Z/2)
	local rayOrigin = (cf * CFrame.new(randomX, size.Y/2 + 10, randomZ)).Position
	local rayDirection = Vector3.new(0, -200, 0)
	-- FIX: Exclude au lieu de Blacklist (déprécié)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = {}
	local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
	if result then
		return result.Position + Vector3.new(0, 1, 0)
	else
		return (cf * CFrame.new(randomX, -size.Y/2, randomZ)).Position + Vector3.new(0, 1, 0)
	end
end

local function createGingerbread(position)
	local model = Instance.new("Model")
	model.Name = "GingerbreadReindeer"

	local rootPart = Instance.new("Part")
	rootPart.Name = "HumanoidRootPart"
	rootPart.Size = Vector3.new(2, 2, 2)
	rootPart.Transparency = 1
	rootPart.CanCollide = true
	rootPart.Anchored = true
	rootPart.CFrame = CFrame.new(position)
	rootPart.Parent = model

	model.PrimaryPart = rootPart
	CollectionService:AddTag(rootPart, "GingerbreadTownEventReindeer")

	return model
end

local function spawnGingerbread()
	local WANDER_FOLDER = workspace.Events:FindFirstChild("Wander")
	if not WANDER_FOLDER then
		warn("[GingerbreadTown] Dossier Wander introuvable dans workspace.Events")
		return
	end

	local wanderParts = {}
	for _, part in ipairs(WANDER_FOLDER:GetChildren()) do
		if part:IsA("BasePart") then
			table.insert(wanderParts, part)
		end
	end

	if #wanderParts == 0 then
		warn("[GingerbreadTown] Aucune BasePart dans le dossier Wander")
		return
	end

	local randomWander = wanderParts[math.random(1, #wanderParts)]
	local spawnPos = getRandomWanderPosition(randomWander)
	spawnPos = stickToGround(spawnPos)

	local gingerbread = createGingerbread(spawnPos)
	gingerbread.Parent = workspace

	table.insert(spawnedGingerbreads, {
		Model = gingerbread,
		WanderPart = randomWander,
		LastWander = 0,
		IsMoving = false,
		CurrentTask = nil
	})
end

local function spawnGingerbreads()
	spawnedGingerbreads = {}
	for _ = 1, TOTAL_ENTITIES do
		spawnGingerbread()
	end
end

local function stopMovement(data)
	if data.CurrentTask then
		task.cancel(data.CurrentTask)
		data.CurrentTask = nil
	end
	data.IsMoving = false
	local model = data.Model
	if model and model.Parent then
		model:SetAttribute("IsRunning", false)
	end
end

local function moveToPosition(data, targetPosition, onComplete)
	local model = data.Model
	if not model or not model.Parent or not model.PrimaryPart then return false end

	stopMovement(data)
	data.IsMoving = true
	model:SetAttribute("IsRunning", true)

	data.CurrentTask = task.spawn(function()
		local lastTime = os.clock()
		while data.IsMoving and model.Parent and model.PrimaryPart do
			local currentTime = os.clock()
			local deltaTime = currentTime - lastTime
			lastTime = currentTime

			local currentPos = model.PrimaryPart.Position
			local targetPos = typeof(targetPosition) == "function" and targetPosition() or targetPosition
			if not targetPos then break end

			local direction = (targetPos - currentPos).Unit
			local distance = (targetPos - currentPos).Magnitude

			if distance < 0.5 then break end

			local moveAmount = math.min(WALK_SPEED * deltaTime, distance)
			local newPos = currentPos + direction * moveAmount
			newPos = stickToGround(newPos)

			model:PivotTo(CFrame.new(newPos, newPos + direction))
			RunService.Heartbeat:Wait()
		end

		data.IsMoving = false
		if model and model.Parent then
			model:SetAttribute("IsRunning", false)
		end
		if onComplete then onComplete() end
	end)
end

local function followAndGiveTrait(data, targetAnimal)
	local model = data.Model
	if not model or not model.Parent or not model.PrimaryPart then return end
	if not targetAnimal or not targetAnimal.Parent or not targetAnimal.PrimaryPart then return end

	stopMovement(data)
	data.IsMoving = true
	model:SetAttribute("IsRunning", true)

	data.CurrentTask = task.spawn(function()
		local lastTime = os.clock()
		local attackDistance = 5
		local maxFollowTime = 10
		local startTime = os.clock()

		while data.IsMoving and model.Parent and model.PrimaryPart do
			if not targetAnimal or not targetAnimal.Parent or not targetAnimal.PrimaryPart then break end
			if os.clock() - startTime > maxFollowTime then break end

			local currentTime = os.clock()
			local deltaTime = currentTime - lastTime
			lastTime = currentTime

			local currentPos = model.PrimaryPart.Position
			local targetPos = targetAnimal.PrimaryPart.Position
			local distance = (targetPos - currentPos).Magnitude

			if distance < attackDistance then
				data.IsMoving = false
				model:SetAttribute("IsRunning", false)

				task.wait(0.1)

				if model.PrimaryPart and targetAnimal.PrimaryPart then
					local lookDir = (targetAnimal.PrimaryPart.Position - model.PrimaryPart.Position).Unit
					model:PivotTo(CFrame.new(model.PrimaryPart.Position, model.PrimaryPart.Position + lookDir))
				end

				local currentTraitsJson = targetAnimal:GetAttribute("Traits")
				local currentTraits = {}
				if currentTraitsJson then
					local success, decoded = pcall(function()
						return HttpService:JSONDecode(currentTraitsJson)
					end)
					if success and type(decoded) == "table" then
						currentTraits = decoded
					end
				end

				local hasReindeer = false
				for _, trait in ipairs(currentTraits) do
					if trait == "Reindeer Pet" then
						hasReindeer = true
						break
					end
				end

				if not hasReindeer then
					table.insert(currentTraits, "Reindeer Pet")
					targetAnimal:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end

				Burst:FireAllClients(targetAnimal.Name)

				-- FIX: nil-check avant table.find pour éviter crash si data déjà supprimé
				local idx = table.find(spawnedGingerbreads, data)
				model:Destroy()
				if idx then
					table.remove(spawnedGingerbreads, idx)
				end

				-- Respawn seulement si l'event est encore actif
				if isActive then
					spawnGingerbread()
				end
				return
			end

			local direction = (targetPos - currentPos).Unit
			local moveAmount = math.min(WALK_SPEED * deltaTime, distance)
			local newPos = currentPos + direction * moveAmount
			newPos = stickToGround(newPos)

			model:PivotTo(CFrame.new(newPos, newPos + direction))
			RunService.Heartbeat:Wait()
		end

		data.IsMoving = false
		if model and model.Parent then
			model:SetAttribute("IsRunning", false)
		end
	end)
end

local function wanderGingerbread(data)
	if data.IsMoving then return end
	local wanderPos = getRandomWanderPosition(data.WanderPart)
	moveToPosition(data, wanderPos)
	data.LastWander = os.clock()
end

function GingerbreadEvent.OnStart()
	if isActive then return end
	isActive = true

	-- FIX: TOTAL_ENTITIES recalculé à chaque activation
	TOTAL_ENTITIES = math.random(6, 10)
	ReplicatedStorage:SetAttribute("GingerbreadTownEvent", true)

	spawnGingerbreads()

	wanderTask = task.spawn(function()
		while isActive do
			task.wait(1)
			for _, data in ipairs(spawnedGingerbreads) do
				local model = data.Model
				if model and model.Parent and not data.IsMoving then
					if (os.clock() - data.LastWander) > math.random(8, 15) then
						wanderGingerbread(data)
					end
				end
			end
		end
	end)

	attackTask = task.spawn(function()
		while isActive do
			task.wait(math.random(8, 15))
			if not isActive or #spawnedGingerbreads == 0 then break end

			local animals = CollectionService:GetTagged("Animal")
			local currentTime = workspace:GetServerTimeNow()

			for animalName, lastTime in pairs(recentlyTargeted) do
				if (currentTime - lastTime) > 15 then
					recentlyTargeted[animalName] = nil
				end
			end

			local candidates = {}
			for _, animal in ipairs(animals) do
				if animal.PrimaryPart then
					local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
					local hasReindeer = false
					local traitsJson = animal:GetAttribute("Traits")
					if traitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(traitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Reindeer Pet" then
									hasReindeer = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasReindeer then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local available = {}
				for _, data in ipairs(spawnedGingerbreads) do
					if data.Model and data.Model.Parent and not data.IsMoving then
						table.insert(available, data)
					end
				end
				if #available > 0 then
					local gingerbreadData = available[math.random(1, #available)]
					followAndGiveTrait(gingerbreadData, selected)
					recentlyTargeted[selected.Name] = currentTime
				end
			end
		end
	end)
end

function GingerbreadEvent.OnStop()
	if not isActive then return end
	isActive = false

	-- FIX: nil au lieu de false, cohérent avec OnStart
	ReplicatedStorage:SetAttribute("GingerbreadTownEvent", nil)

	-- FIX: vérification avant task.cancel
	if attackTask then
		task.cancel(attackTask)
		attackTask = nil
	end
	if wanderTask then
		task.cancel(wanderTask)
		wanderTask = nil
	end

	for _, data in ipairs(spawnedGingerbreads) do
		stopMovement(data)
		if data.Model and data.Model.Parent then
			data.Model:Destroy()
		end
	end

	spawnedGingerbreads = {}
	recentlyTargeted = {}
end

return GingerbreadEvent

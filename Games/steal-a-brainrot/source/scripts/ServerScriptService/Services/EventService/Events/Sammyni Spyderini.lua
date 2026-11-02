local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/Sammyni Spyderini/Burst")

local SammyniSpyderini = {}

local isActive = false
local attackTask = nil
local wanderTask = nil
local recentlyTargeted = {}
local spawnedSpiders = {}

local WANDER_FOLDER = workspace.Events:FindFirstChild("Wander")
local TOTAL_SPIDERS = math.random(3, 4)
local WALK_SPEED = 20

local RAY_PARAMS = RaycastParams.new()
RAY_PARAMS.FilterType = Enum.RaycastFilterType.Include
RAY_PARAMS.FilterDescendantsInstances = {workspace.Map, workspace.Terrain}

local function stickToGround(Position)
	local Origin = Position + Vector3.new(0, 10, 0)
	local Direction = Vector3.new(0, -20, 0)

	local Result = workspace:Raycast(Origin, Direction, RAY_PARAMS)

	if Result then
		return Result.Position + Vector3.new(0, 1, 0)
	end

	local BackupParams = RaycastParams.new()
	BackupParams.FilterType = Enum.RaycastFilterType.Blacklist
	BackupParams.FilterDescendantsInstances = {}

	local BackupResult = workspace:Raycast(Origin, Direction, BackupParams)
	if BackupResult then
		return BackupResult.Position + Vector3.new(0, 1, 0)
	end

	return Position
end

local function getRandomWanderPosition(wanderPart)
	local size = wanderPart.Size
	local cf = wanderPart.CFrame

	local randomX = math.random(-size.X/2, size.X/2)
	local randomZ = math.random(-size.Z/2, size.Z/2)

	local rayOrigin = (cf * CFrame.new(randomX, size.Y/2 + 10, randomZ)).Position
	local rayDirection = Vector3.new(0, -200, 0)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {}

	local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

	if result then
		return result.Position + Vector3.new(0, 1, 0)
	else
		return (cf * CFrame.new(randomX, -size.Y/2, randomZ)).Position + Vector3.new(0, 1, 0)
	end
end

local function createSpider(position)
	local spider = Instance.new("Model")
	spider.Name = "SammyniSpyderini"

	local rootPart = Instance.new("Part")
	rootPart.Name = "HumanoidRootPart"
	rootPart.Size = Vector3.new(2, 2, 2)
	rootPart.Transparency = 1
	rootPart.CanCollide = true
	rootPart.Anchored = true
	rootPart.CFrame = CFrame.new(position)
	rootPart.Parent = spider

	spider.PrimaryPart = rootPart

	CollectionService:AddTag(spider, "SammyniSpyderini")

	return spider
end

local function spawnSpiders()
	if not WANDER_FOLDER then
		warn("Wander folder not found at workspace.Events.Wander")
		return
	end

	local wanderParts = {}
	for _, wanderPart in ipairs(WANDER_FOLDER:GetChildren()) do
		if wanderPart:IsA("BasePart") then
			table.insert(wanderParts, wanderPart)
		end
	end

	if #wanderParts == 0 then
		warn("No wander parts found")
		return
	end

	for i = 1, TOTAL_SPIDERS do
		local randomWander = wanderParts[math.random(1, #wanderParts)]
		local spawnPos = getRandomWanderPosition(randomWander)
		spawnPos = stickToGround(spawnPos)
		local spider = createSpider(spawnPos)
		spider.Parent = workspace

		spider:SetAttribute("IsRunning", false)
		spider:SetAttribute("Ground", false)
		spider:SetAttribute("InitialGround", false)
		spider:SetAttribute("AttackAnimation", false)

		table.insert(spawnedSpiders, {
			Model = spider,
			WanderPart = randomWander,
			LastWander = 0,
			IsMoving = false,
			CurrentTask = nil
		})
	end
end

local function stopSpiderMovement(spiderData)
	if spiderData.CurrentTask then
		task.cancel(spiderData.CurrentTask)
		spiderData.CurrentTask = nil
	end
	spiderData.IsMoving = false

	local spider = spiderData.Model
	if spider and spider.Parent then
		spider:SetAttribute("IsRunning", false)
	end
end

local function moveSpiderToPosition(spiderData, targetPosition, onComplete)
	local spider = spiderData.Model
	if not spider or not spider.Parent or not spider.PrimaryPart then
		return false
	end

	stopSpiderMovement(spiderData)

	spiderData.IsMoving = true
	spider:SetAttribute("IsRunning", true)
	spider:SetAttribute("Ground", false)
	spider:SetAttribute("AttackAnimation", false)

	spiderData.CurrentTask = task.spawn(function()
		local lastTime = os.clock()

		while spiderData.IsMoving and spider.Parent and spider.PrimaryPart do
			local currentTime = os.clock()
			local deltaTime = currentTime - lastTime
			lastTime = currentTime

			local currentPos = spider.PrimaryPart.Position
			local targetPos = typeof(targetPosition) == "function" and targetPosition() or targetPosition

			if not targetPos then
				break
			end

			local direction = (targetPos - currentPos).Unit
			local distance = (targetPos - currentPos).Magnitude

			if distance < 0.5 then
				break
			end

			local moveAmount = math.min(WALK_SPEED * deltaTime, distance)
			local newPos = currentPos + direction * moveAmount

			newPos = stickToGround(newPos)

			local lookDir = Vector3.new(direction.X, 0, direction.Z).Unit
			local cf = CFrame.lookAt(newPos, newPos + lookDir, Vector3.yAxis)
			spider:PivotTo(cf)

			RunService.Heartbeat:Wait()
		end

		spiderData.IsMoving = false
		spider:SetAttribute("IsRunning", false)

		if onComplete then
			onComplete()
		end
	end)

	return true
end

local function followAndAttackAnimal(spiderData, targetAnimal)
	local spider = spiderData.Model
	if not spider or not spider.Parent or not spider.PrimaryPart then
		return
	end

	if not targetAnimal or not targetAnimal.Parent or not targetAnimal.PrimaryPart then
		return
	end

	stopSpiderMovement(spiderData)

	spiderData.IsMoving = true
	spider:SetAttribute("IsRunning", true)
	spider:SetAttribute("Ground", false)
	spider:SetAttribute("AttackAnimation", false)

	spiderData.CurrentTask = task.spawn(function()
		local lastTime = os.clock()
		local attackDistance = 5
		local maxFollowTime = 10
		local startTime = os.clock()

		while spiderData.IsMoving and spider.Parent and spider.PrimaryPart do
			if not targetAnimal or not targetAnimal.Parent or not targetAnimal.PrimaryPart then
				break
			end

			if os.clock() - startTime > maxFollowTime then
				break
			end

			local currentTime = os.clock()
			local deltaTime = currentTime - lastTime
			lastTime = currentTime

			local currentPos = spider.PrimaryPart.Position
			local targetPos = targetAnimal.PrimaryPart.Position
			local distance = (targetPos - currentPos).Magnitude

			if distance < attackDistance then
				spiderData.IsMoving = false
				spider:SetAttribute("IsRunning", false)
				spider:SetAttribute("Ground", true)

				task.wait(0.1)

				if spider.PrimaryPart and targetAnimal.PrimaryPart then
					local lookDir = (targetAnimal.PrimaryPart.Position - spider.PrimaryPart.Position).Unit
					spider:PivotTo(CFrame.new(spider.PrimaryPart.Position, spider.PrimaryPart.Position + lookDir))
				end

				spider:SetAttribute("AttackAnimation", true)

				task.wait(0.5)

				Burst:FireAllClients(targetAnimal.Name)

				task.wait(0.5)

				spider:SetAttribute("AttackAnimation", false)

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

				local hasSpider = false
				for _, trait in ipairs(currentTraits) do
					if trait == "Spider" then
						hasSpider = true
						break
					end
				end

				if not hasSpider then
					table.insert(currentTraits, "Spider")
					targetAnimal:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end

				task.wait(1)
				spider:SetAttribute("Ground", false)

				return
			end

			local direction = (targetPos - currentPos).Unit
			local moveAmount = math.min(WALK_SPEED * deltaTime, distance)
			local newPos = currentPos + direction * moveAmount

			newPos = stickToGround(newPos)

			local lookDir = Vector3.new(direction.X, 0, direction.Z).Unit
			local cf = CFrame.lookAt(newPos, newPos + lookDir, Vector3.yAxis)
			spider:PivotTo(cf)

			RunService.Heartbeat:Wait()
		end

		spiderData.IsMoving = false
		spider:SetAttribute("IsRunning", false)
	end)
end

local function wanderSpider(spiderData)
	if spiderData.IsMoving then
		return
	end

	local wanderPos = getRandomWanderPosition(spiderData.WanderPart)
	moveSpiderToPosition(spiderData, wanderPos)
	spiderData.LastWander = os.clock()
end

function SammyniSpyderini.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("SammyniSpyderiniEvent", true)

	task.delay(10, function()
		if not isActive then return end
		spawnSpiders()
	end)

	wanderTask = task.spawn(function()
		while isActive do
			task.wait(1)

			for _, spiderData in ipairs(spawnedSpiders) do
				local spider = spiderData.Model
				local currentTime = os.clock()

				if spider and spider.Parent and not spiderData.IsMoving then
					if (currentTime - spiderData.LastWander) > math.random(8, 15) then
						wanderSpider(spiderData)
					end
				end
			end
		end
	end)

	attackTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(8, 12)
			task.wait(waitTime)

			if not isActive then
				break
			end

			if #spawnedSpiders == 0 then
				continue
			end

			local roadAnimals = CollectionService:GetTagged("Animal")
			local currentTime = workspace:GetServerTimeNow()

			for animalName, lastTime in pairs(recentlyTargeted) do
				if (currentTime - lastTime) > 15 then
					recentlyTargeted[animalName] = nil
				end
			end

			local candidates = {}
			for _, animal in ipairs(roadAnimals) do
				if animal.PrimaryPart then
					local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
					local hasSpider = false

					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Spider" then
									hasSpider = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasSpider then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]

				local availableSpiders = {}
				for _, spiderData in ipairs(spawnedSpiders) do
					if spiderData.Model and spiderData.Model.Parent and not spiderData.IsMoving then
						table.insert(availableSpiders, spiderData)
					end
				end

				if #availableSpiders > 0 then
					local spiderData = availableSpiders[math.random(1, #availableSpiders)]
					followAndAttackAnimal(spiderData, selected)
					recentlyTargeted[selected.Name] = currentTime
				end
			end
		end
	end)
end

function SammyniSpyderini.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("SammyniSpyderiniEvent", false)

	if attackTask then
		task.cancel(attackTask)
		attackTask = nil
	end

	if wanderTask then
		task.cancel(wanderTask)
		wanderTask = nil
	end

	for _, spiderData in ipairs(spawnedSpiders) do
		stopSpiderMovement(spiderData)
		if spiderData.Model and spiderData.Model.Parent then
			spiderData.Model:Destroy()
		end
	end

	spawnedSpiders = {}
	recentlyTargeted = {}
end

return SammyniSpyderini
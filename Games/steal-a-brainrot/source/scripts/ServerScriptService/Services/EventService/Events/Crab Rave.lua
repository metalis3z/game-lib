local CrabRave = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local PathfindingService = game:GetService("PathfindingService")
local Players = game:GetService("Players")
local Net = require(ReplicatedStorage.Packages.Net)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

local CombatService = require(game:GetService("ServerScriptService").Services.CombatService)

local Hit = Net:RemoteEvent("EventService/Crab Rave/Hit")

local isActive = false
local attackTask = nil
local randomMoveTask = nil
local recentlyTargeted = {}
local crabs = {}
local crabFolder = nil

function CrabRave.OnStart()
	if isActive then
		return
	end
	isActive = true
	ReplicatedStorage:SetAttribute("CrabRave", true)

	crabFolder = workspace:FindFirstChild("Crabs")
	if not crabFolder then
		crabFolder = Instance.new("Model")
		crabFolder.Name = "Crabs"
		crabFolder.Parent = workspace
	end
	CollectionService:AddTag(crabFolder, "CrabRaveCrabFolder")

	local groundFolder = crabFolder:FindFirstChild("Ground")
	if not groundFolder then
		groundFolder = Instance.new("Folder")
		groundFolder.Name = "Ground"
		groundFolder.Parent = crabFolder
	end

	local wallFolder = crabFolder:FindFirstChild("Wall")
	if not wallFolder then
		wallFolder = Instance.new("Folder")
		wallFolder.Name = "Wall"
		wallFolder.Parent = crabFolder
	end

	local function createCrab(cframe, parentFolder, crabType)
		local crab = Instance.new("Model")
		crab.Name = "Crab"

		local rootPart = Instance.new("Part")
		rootPart.Name = "HumanoidRootPart"
		rootPart.Size = Vector3.new(2, 2, 2)
		rootPart.Transparency = 1
		rootPart.CanCollide = false
		rootPart.Anchored = true
		rootPart.CFrame = cframe
		rootPart.Parent = crab

		crab.PrimaryPart = rootPart
		crab.Parent = parentFolder

		CollectionService:AddTag(crab, "CrabRaveCrabs")

		return crab
	end

	local groundSpawnFolder = script:FindFirstChild("Ground")
	local wallSpawnFolder = script:FindFirstChild("Wall")

	if groundSpawnFolder then
		for _, positionPart in groundSpawnFolder:GetChildren() do
			if positionPart:IsA("BasePart") and positionPart.Name == "Position" then
				local crab = createCrab(positionPart.CFrame, groundFolder, "Ground")
				table.insert(crabs, {
					model = crab, 
					type = "Ground", 
					rootPart = crab.PrimaryPart, 
					startPos = positionPart.CFrame,
					isAttacking = false,
					moveConnection = nil
				})
			end
		end
	end

	if wallSpawnFolder then
		for _, positionPart in wallSpawnFolder:GetChildren() do
			if positionPart:IsA("BasePart") and positionPart.Name == "Position" then
				local crab = createCrab(positionPart.CFrame, wallFolder, "Wall")
				table.insert(crabs, {
					model = crab, 
					type = "Wall", 
					rootPart = crab.PrimaryPart,
					startPos = positionPart.CFrame,
					isAttacking = false,
					moveConnection = nil
				})
			end
		end
	end

	if attackTask then
		task.cancel(attackTask)
	end

	local function moveCrabToTarget(crabData, targetGetter, onReached)
		if crabData.moveConnection then
			crabData.moveConnection:Disconnect()
			crabData.moveConnection = nil
		end

		local path = PathfindingService:CreatePath({
			AgentRadius = 2,
			AgentHeight = 2,
			AgentCanJump = false
		})

		local waypoints = {}
		local currentWaypointIndex = 2
		local moveSpeed = 16
		local lastPathUpdate = 0
		local pathUpdateInterval = 0.01

		local function updatePath()
			local targetPos = if type(targetGetter) == "function" then targetGetter() else targetGetter
			if not targetPos then
				return false
			end

			local success, errorMsg = pcall(function()
				path:ComputeAsync(crabData.rootPart.Position, targetPos)
			end)

			if success and path.Status == Enum.PathStatus.Success then
				waypoints = path:GetWaypoints()
				currentWaypointIndex = 2
				return true
			end
			return false
		end

		if not updatePath() then
			if onReached then
				onReached(false)
			end
			return
		end

		crabData.moveConnection = RunService.Heartbeat:Connect(function(dt)
			if not crabData.model.Parent then
				if crabData.moveConnection then
					crabData.moveConnection:Disconnect()
					crabData.moveConnection = nil
				end
				return
			end

			lastPathUpdate = lastPathUpdate + dt
			if type(targetGetter) == "function" and lastPathUpdate >= pathUpdateInterval then
				lastPathUpdate = 0
				updatePath()
			end

			if currentWaypointIndex > #waypoints then
				if crabData.moveConnection then
					crabData.moveConnection:Disconnect()
					crabData.moveConnection = nil
				end
				if onReached then
					onReached(true)
				end
				return
			end

			local currentWaypoint = waypoints[currentWaypointIndex]
			local currentPos = crabData.rootPart.Position
			local targetPos = currentWaypoint.Position
			local direction = (targetPos - currentPos).Unit
			local distance = (targetPos - currentPos).Magnitude

			if distance < 0.5 then
				currentWaypointIndex = currentWaypointIndex + 1
			else
				local moveAmount = math.min(moveSpeed * dt, distance)
				local newPos = currentPos + direction * moveAmount

				local lookAtPos = currentPos + Vector3.new(direction.X, 0, direction.Z)
				crabData.rootPart.CFrame = CFrame.new(newPos, lookAtPos)
			end
		end)
	end

	attackTask = task.spawn(function()
		task.wait(2)

		while isActive do
			local waitTime = math.random(6, 12)
			task.wait(waitTime)

			if not isActive then
				break
			end

			local groundCrabs = {}
			for _, crabData in ipairs(crabs) do
				if crabData.type == "Ground" and crabData.model.Parent and not crabData.isAttacking then
					table.insert(groundCrabs, crabData)
				end
			end

			if #groundCrabs == 0 then
				continue
			end

			local targetPlayer = math.random(1, 1000) <= 25

			if targetPlayer then
				local playersInGame = Players:GetPlayers()
				if #playersInGame > 0 then
					local selectedCrab = groundCrabs[math.random(1, #groundCrabs)]
					local selectedPlayer = playersInGame[math.random(1, #playersInGame)]

					if selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
						selectedCrab.isAttacking = true
						selectedCrab.model:SetAttribute("IsRunning", true)
						selectedCrab.model:SetAttribute("Dance", nil)

						local function getPlayerPosition()
							if not selectedPlayer or not selectedPlayer.Character or not selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
								return nil
							end
							return selectedPlayer.Character.HumanoidRootPart.Position
						end

						moveCrabToTarget(selectedCrab, getPlayerPosition, function(reached)
							if not reached then
								selectedCrab.model:SetAttribute("IsRunning", false)
								selectedCrab.isAttacking = false
								return
							end

							selectedCrab.model:SetAttribute("Attack", true)
							task.wait(0.1)
							selectedCrab.model:SetAttribute("Attack", false)

							if selectedPlayer.Character then
								task.spawn(function()
									if selectedPlayer.Character then
										CombatService.Fling(selectedPlayer.Character:FindFirstChild("HumanoidRootPart"), 250, selectedPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector)
										Ragdoll.Ragdoll(selectedPlayer.Character)
										task.wait(2)
										if selectedPlayer.Character then
											Ragdoll.Unragdoll(selectedPlayer.Character)
										end
									end
								end)
							end

							task.wait(1)

							selectedCrab.model:SetAttribute("Dance", math.random(1, 4))

							moveCrabToTarget(selectedCrab, selectedCrab.startPos.Position, function()
								selectedCrab.rootPart.CFrame = selectedCrab.startPos
								selectedCrab.model:SetAttribute("IsRunning", false)
								selectedCrab.isAttacking = false
							end)
						end)
					end

					continue
				end
			end

			local roadAnimals = CollectionService:GetTagged("Animal")
			local currentTime = workspace:GetServerTimeNow()

			for animalName, lastTime in pairs(recentlyTargeted) do
				if (currentTime - lastTime) > 20 then
					recentlyTargeted[animalName] = nil
				end
			end

			local candidates = {}
			for _, animal in ipairs(roadAnimals) do
				if animal.PrimaryPart then
					local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
					local hasClaws = false
					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Claws" then
									hasClaws = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasClaws then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selectedCrab = groundCrabs[math.random(1, #groundCrabs)]
				local selectedAnimal = candidates[math.random(1, #candidates)]
				local now = workspace:GetServerTimeNow()

				selectedCrab.isAttacking = true
				selectedCrab.model:SetAttribute("IsRunning", true)
				selectedCrab.model:SetAttribute("Dance", nil)

				local function getAnimalPosition()
					if not selectedAnimal or not selectedAnimal.Parent then
						return nil
					end
					return (if selectedAnimal.PrimaryPart then selectedAnimal.PrimaryPart.CFrame else selectedAnimal:GetPivot()).Position
				end

				moveCrabToTarget(selectedCrab, getAnimalPosition, function(reached)
					if not reached then
						selectedCrab.model:SetAttribute("IsRunning", false)
						selectedCrab.isAttacking = false
						return
					end

					selectedCrab.model:SetAttribute("Attack", true)
					task.wait(0.1)
					selectedCrab.model:SetAttribute("Attack", false)

					Hit:FireAllClients(selectedAnimal.Name)
					recentlyTargeted[selectedAnimal.Name] = now

					task.delay(0.1, function()
						if not selectedAnimal or not selectedAnimal.Parent then
							return
						end

						local currentTraitsJson = selectedAnimal:GetAttribute("Traits")
						local currentTraits = {}

						if currentTraitsJson then
							local success, decoded = pcall(function()
								return HttpService:JSONDecode(currentTraitsJson)
							end)
							if success and type(decoded) == "table" then
								currentTraits = decoded
							end
						end

						for _, trait in ipairs(currentTraits) do
							if trait == "Claws" then
								return
							end
						end

						table.insert(currentTraits, "Claws")
						selectedAnimal:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
					end)

					task.wait(1)

					selectedCrab.model:SetAttribute("Dance", math.random(1, 4))

					moveCrabToTarget(selectedCrab, selectedCrab.startPos.Position, function()
						selectedCrab.rootPart.CFrame = selectedCrab.startPos
						selectedCrab.model:SetAttribute("IsRunning", false)
						selectedCrab.isAttacking = false
					end)
				end)
			end
		end
	end)

	randomMoveTask = task.spawn(function()
		task.wait(60)

		while isActive do
			task.wait(10)

			if not isActive then
				break
			end

			if math.random(1, 100) <= 10 then
				local availableCrabs = {}
				for _, crabData in ipairs(crabs) do
					if crabData.type == "Ground" and crabData.model.Parent and not crabData.isAttacking then
						table.insert(availableCrabs, crabData)
					end
				end

				if #availableCrabs > 0 then
					local numCrabs = math.random(3, math.min(6, #availableCrabs))
					local selectedCrabs = {}

					for i = 1, numCrabs do
						local randomIndex = math.random(1, #availableCrabs)
						table.insert(selectedCrabs, availableCrabs[randomIndex])
						table.remove(availableCrabs, randomIndex)
					end

					for _, crabData in ipairs(selectedCrabs) do
						task.spawn(function()
							crabData.isAttacking = true
							crabData.model:SetAttribute("IsRunning", true)
							crabData.model:SetAttribute("Dance", nil)

							local randomOffset = Vector3.new(
								math.random(-50, 50),
								0,
								math.random(-50, 50)
							)
							local targetPos = crabData.startPos.Position + randomOffset

							moveCrabToTarget(crabData, targetPos, function(reached)
								if reached then
									crabData.model:SetAttribute("IsRunning", false)
									crabData.model:SetAttribute("Dance", math.random(1, 4))

									task.wait(math.random(5, 15))

									crabData.model:SetAttribute("IsRunning", true)
									crabData.model:SetAttribute("Dance", nil)

									moveCrabToTarget(crabData, crabData.startPos.Position, function()
										crabData.rootPart.CFrame = crabData.startPos
										crabData.model:SetAttribute("IsRunning", false)
										crabData.model:SetAttribute("Dance", math.random(1, 4))
										crabData.isAttacking = false
									end)
								else
									crabData.model:SetAttribute("IsRunning", false)
									crabData.isAttacking = false
								end
							end)
						end)
					end
				end
			end
		end
	end)
end

function CrabRave.OnStop()
	if not isActive then
		return
	end
	isActive = false
	ReplicatedStorage:SetAttribute("CrabRave", false)

	if attackTask then
		task.cancel(attackTask)
		attackTask = nil
	end

	if randomMoveTask then
		task.cancel(randomMoveTask)
		randomMoveTask = nil
	end

	for _, crabData in ipairs(crabs) do
		if crabData.moveConnection then
			crabData.moveConnection:Disconnect()
		end
		if crabData.model and crabData.model.Parent then
			crabData.model:Destroy()
		end
	end

	if crabFolder and crabFolder.Parent then
		crabFolder:Destroy()
	end

	table.clear(crabs)
	recentlyTargeted = {}
end

return CrabRave
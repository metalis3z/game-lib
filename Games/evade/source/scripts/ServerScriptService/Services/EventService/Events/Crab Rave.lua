--!native
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
local crabs = {}
local crabFolder = nil
local attackTask = nil
local wanderTask = nil
local recentlyTargeted = {}
local eventStartTime = 0
local activeCrabs = {}

function CrabRave.OnStart()
	if isActive then
		return
	end
	isActive = true
	eventStartTime = workspace:GetServerTimeNow()
	ReplicatedStorage:SetAttribute("CrabRave", true)

	crabFolder = workspace:FindFirstChild("Crabs")
	if not crabFolder then
		crabFolder = Instance.new("Model")
		crabFolder.Name = "Crabs"
		crabFolder.Parent = workspace
	end

	CollectionService:AddTag(crabFolder, "CrabRaveCrabFolder")

	local GroundFolder = crabFolder:FindFirstChild("Ground")
	if not GroundFolder then
		GroundFolder = Instance.new("Folder")
		GroundFolder.Name = "Ground"
		GroundFolder.Parent = crabFolder
	end

	local WallFolder = crabFolder:FindFirstChild("Wall")
	if not WallFolder then
		WallFolder = Instance.new("Folder")
		WallFolder.Name = "Wall"
		WallFolder.Parent = crabFolder
	end

	local function CreateCrab(CFrameValue: CFrame, ParentFolder: Instance, CrabType: string)
		local Crab = Instance.new("Model")
		Crab.Name = "Crab"

		local RootPart = Instance.new("Part")
		RootPart.Name = "HumanoidRootPart"
		RootPart.Size = Vector3.new(2, 2, 2)
		RootPart.Transparency = 1
		RootPart.CanCollide = false
		RootPart.Anchored = true
		RootPart.CFrame = CFrameValue
		RootPart.Parent = Crab

		Crab.PrimaryPart = RootPart
		Crab.Parent = ParentFolder
		Crab:SetAttribute("CrabType", CrabType)
		Crab:SetAttribute("IsRunning", false)
		Crab:SetAttribute("Attack", false)
		Crab:SetAttribute("Dance", nil)

		CollectionService:AddTag(Crab, "CrabRaveCrabs")

		return Crab
	end

	local GroundSpawnFolder = script:FindFirstChild("Ground")
	local WallSpawnFolder = script:FindFirstChild("Wall")

	if GroundSpawnFolder then
		for _, PositionPart in GroundSpawnFolder:GetChildren() do
			if PositionPart:IsA("BasePart") and PositionPart.Name == "Position" then
				local Crab = CreateCrab(PositionPart.CFrame, GroundFolder, "Ground")
				table.insert(crabs, Crab)
			end
		end
	end

	if WallSpawnFolder then
		for _, PositionPart in WallSpawnFolder:GetChildren() do
			if PositionPart:IsA("BasePart") and PositionPart.Name == "Position" then
				local Crab = CreateCrab(PositionPart.CFrame, WallFolder, "Wall")
				table.insert(crabs, Crab)
			end
		end
	end

	attackTask = task.spawn(function()
		task.wait(30)

		while isActive do
			local waitTime = math.random(60, 120) / 10
			task.wait(waitTime)

			if not isActive then
				break
			end

			local availableCrabs = {}
			for _, crab in ipairs(crabs) do
				if crab and crab.Parent and crab:GetAttribute("CrabType") == "Ground" then
					if not activeCrabs[crab] then
						table.insert(availableCrabs, crab)
					end
				end
			end

			if #availableCrabs == 0 then
				continue
			end

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
				local selectedCrab = availableCrabs[math.random(1, #availableCrabs)]
				local selectedAnimal = candidates[math.random(1, #candidates)]

				activeCrabs[selectedCrab] = true
				recentlyTargeted[selectedAnimal.Name] = currentTime

				task.spawn(function()
					local crabStartPosition = selectedCrab.PrimaryPart.Position

					selectedCrab:SetAttribute("IsRunning", true)

					local maxChaseTime = 5
					local chaseStartTime = tick()
					local attackRange = 3

					while tick() - chaseStartTime < maxChaseTime and isActive do
						if not selectedAnimal or not selectedAnimal.Parent or not selectedAnimal.PrimaryPart then
							break
						end

						local targetPosition = selectedAnimal.PrimaryPart.Position
						local crabPosition = selectedCrab.PrimaryPart.Position
						local distanceToTarget = (targetPosition - crabPosition).Magnitude

						if distanceToTarget <= attackRange then
							break
						end

						local direction = (targetPosition - crabPosition).Unit
						local moveStep = direction * 20 * task.wait()
						local newPosition = crabPosition + moveStep

						selectedCrab:PivotTo(CFrame.new(newPosition, newPosition + direction))
					end

					selectedCrab:SetAttribute("IsRunning", false)

					selectedCrab:SetAttribute("Attack", true)
					task.wait(0.1)
					selectedCrab:SetAttribute("Attack", false)

					Hit:FireAllClients(selectedAnimal.Name)

					task.delay(0.5, function()
						if selectedAnimal and selectedAnimal.Parent then
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
						end
					end)

					task.wait(1)
					selectedCrab:SetAttribute("IsRunning", true)

					local currentPosition = selectedCrab.PrimaryPart.Position
					local distance = (crabStartPosition - currentPosition).Magnitude
					local duration = distance / 20
					local startTime = tick()

					while tick() - startTime < duration and isActive do
						local alpha = (tick() - startTime) / duration
						local currentPos = currentPosition:Lerp(crabStartPosition, alpha)
						selectedCrab:PivotTo(CFrame.new(currentPos, crabStartPosition))
						task.wait()
					end

					selectedCrab:SetAttribute("IsRunning", false)
					activeCrabs[selectedCrab] = nil
				end)
			end
		end
	end)

	wanderTask = task.spawn(function()
		task.wait(30)

		while isActive do
			local waitTime = math.random(50, 90) / 10
			task.wait(waitTime)

			if not isActive then
				break
			end

			local availableCrabs = {}
			for _, crab in ipairs(crabs) do
				if crab and crab.Parent and crab:GetAttribute("CrabType") == "Ground" then
					if not activeCrabs[crab] then
						table.insert(availableCrabs, crab)
					end
				end
			end

			if #availableCrabs == 0 then
				continue
			end

			local numCrabs = math.min(math.random(1, 3), #availableCrabs)
			local selectedCrabs = {}

			for i = 1, numCrabs do
				local randomIndex = math.random(1, #availableCrabs)
				table.insert(selectedCrabs, availableCrabs[randomIndex])
				table.remove(availableCrabs, randomIndex)
			end

			for _, crab in ipairs(selectedCrabs) do
				task.spawn(function()
					activeCrabs[crab] = true

					local originalPosition = crab.PrimaryPart.Position
					local randomOffset = Vector3.new(
						math.random(-20, 20),
						0,
						math.random(-20, 20)
					)
					local targetPosition = originalPosition + randomOffset

					crab:SetAttribute("IsRunning", true)

					local distance = (targetPosition - originalPosition).Magnitude
					local duration = distance / 20
					local startTime = tick()

					while tick() - startTime < duration and isActive do
						local alpha = (tick() - startTime) / duration
						local currentPos = originalPosition:Lerp(targetPosition, alpha)
						crab:PivotTo(CFrame.new(currentPos, targetPosition))
						task.wait()
					end

					crab:SetAttribute("IsRunning", false)

					task.wait(math.random(10, 20) / 10)

					crab:SetAttribute("IsRunning", true)

					distance = (originalPosition - targetPosition).Magnitude
					duration = distance / 20
					startTime = tick()

					while tick() - startTime < duration and isActive do
						local alpha = (tick() - startTime) / duration
						local currentPos = targetPosition:Lerp(originalPosition, alpha)
						crab:PivotTo(CFrame.new(currentPos, originalPosition))
						task.wait()
					end

					crab:SetAttribute("IsRunning", false)
					activeCrabs[crab] = nil
				end)
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

	if wanderTask then
		task.cancel(wanderTask)
		wanderTask = nil
	end

	for _, Crab in ipairs(crabs) do
		if Crab and Crab.Parent then
			Crab:Destroy()
		end
	end

	if crabFolder and crabFolder.Parent then
		crabFolder:Destroy()
	end

	table.clear(crabs)
	table.clear(recentlyTargeted)
	table.clear(activeCrabs)
end

return CrabRave
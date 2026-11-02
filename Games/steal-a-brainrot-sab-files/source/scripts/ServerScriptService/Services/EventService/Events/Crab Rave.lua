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
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local NpcPathfinding = require(game:GetService("ServerScriptService").Components.NpcPathfinding)
local Hit = Net:RemoteEvent("EventService/Crab Rave/Hit")

local isActive = false
local crabs = {}
local crabFolder = nil
local Trove = require(ReplicatedStorage.Packages.Trove)
local eventTrove = nil
local recentlyTargeted = {}
local eventStartTime = 0
local activeCrabs = {}
local maxattackers = 2

local globalDanceIndex = 0
local crabsInDanceMode = {}

local function getElapsed()
	local attributeTime = ReplicatedStorage:GetAttribute("CrabRaveStartTimestamp")
	if attributeTime then
		return workspace:GetServerTimeNow() - attributeTime
	end
	return workspace:GetServerTimeNow() - eventStartTime
end

local function applyGlobalDance()
	local startTime = workspace:GetServerTimeNow()
	for crab, overrideIndex in pairs(crabsInDanceMode) do
		if not crab or not crab.Parent then continue end

		local danceToSet = overrideIndex or globalDanceIndex
		crab:SetAttribute("Dance", danceToSet)
		crab:SetAttribute("DanceStartTime", startTime) 
	end
end

local function registerDanceCrab(crab)
	crabsInDanceMode[crab] = nil
	crab:SetAttribute("Dance", globalDanceIndex)
end

local function overrideDanceCrab(crab, danceIndex)
	crabsInDanceMode[crab] = danceIndex
	crab:SetAttribute("Dance", danceIndex)
end

local function unregisterDanceCrab(crab)
	crabsInDanceMode[crab] = nil
	crab:SetAttribute("Dance", 0)
end

function CrabRave.OnStart(eventData)
	if isActive then return end
	isActive = true
	eventTrove = Trove.new()

	eventTrove:Add(function()
		ReplicatedStorage:SetAttribute("CrabRave", false)
		ReplicatedStorage:SetAttribute("CrabRaveStartTimestamp", nil)
	end)
	local startTime = (eventData and eventData.startedAt) or workspace:GetServerTimeNow()
	ReplicatedStorage:SetAttribute("CrabRaveStartTimestamp", startTime)
	eventStartTime = startTime
	ReplicatedStorage:SetAttribute("CrabRave", true)

	crabFolder = workspace:FindFirstChild("Crabs")
	if not crabFolder then
		crabFolder = Instance.new("Model")
		crabFolder.Name = "Crabs"
		crabFolder.Parent = workspace
	end
	eventTrove:Add(crabFolder)

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
		Crab:SetAttribute("Dance", "")

		CollectionService:AddTag(Crab, "CrabRaveCrabs")

		return Crab
	end

	local GroundSpawnFolder = script:FindFirstChild("Ground")
	local WallSpawnFolder = script:FindFirstChild("Wall")

	if GroundSpawnFolder then
		local groundCrabData = {}

		for _, PositionPart in GroundSpawnFolder:GetChildren() do
			if PositionPart:IsA("BasePart") and (PositionPart.Name == "Position" or PositionPart.Name == "PositionMiddle") then
				local targetCFrame = PositionPart.CFrame
				local role = (PositionPart.Name == "PositionMiddle") and "Middle" or "Side"

				local offsetAmount = (targetCFrame.Position.X < -410.697) and -40 or 40
				local spawnPosition = targetCFrame.Position + Vector3.new(offsetAmount, 0, 0)
				local spawnCFrame = CFrame.new(spawnPosition) * targetCFrame.Rotation

				local Crab = CreateCrab(spawnCFrame, GroundFolder, "Ground")
				table.insert(crabs, Crab)
				table.insert(groundCrabData, {Instance = Crab, StartCFrame = targetCFrame, Role = role})

				task.spawn(function()
					local walkStartTime = 7
					local walkDuration = 2
					local walkEndTime = walkStartTime + walkDuration
					local currentTime = getElapsed()

					if currentTime >= walkEndTime then
						if Crab and Crab.PrimaryPart then
							Crab:PivotTo(targetCFrame)
							Crab:SetAttribute("IsRunning", false)
						end
						return
					end

					while getElapsed() < walkStartTime and isActive do
						task.wait(0.1)
					end

					if not isActive or not Crab or not Crab.Parent or not Crab.PrimaryPart then return end

					Crab:SetAttribute("IsRunning", true)

					local startPos = spawnCFrame.Position
					local endPos = targetCFrame.Position

					while isActive and Crab.Parent do
						local t = getElapsed()
						if t >= walkEndTime then break end

						local alpha = math.clamp((t - walkStartTime) / walkDuration, 0, 1)
						local currentPos = startPos:Lerp(endPos, alpha)
						local lookAtTarget = Vector3.new(endPos.X, currentPos.Y, endPos.Z)
						if (lookAtTarget - currentPos).Magnitude > 0.1 then
							Crab:PivotTo(CFrame.new(currentPos, lookAtTarget))
						else
							Crab:PivotTo(CFrame.new(currentPos) * targetCFrame.Rotation)
						end
						task.wait()
					end

					if isActive and Crab.Parent then
						Crab:PivotTo(targetCFrame)
						Crab:SetAttribute("IsRunning", false)
					end
				end)
			end
		end

		task.spawn(function()
			while getElapsed() < 31 and isActive do
				task.wait(0.1)
			end
			if not isActive then return end

			local MAP_CENTER_X = -410.697
			local ROUTINE_START_TIME = 30

			local movingCrabs = 0
			local allMovementDone = Instance.new("BindableEvent")

			for _, data in ipairs(groundCrabData) do
				movingCrabs += 1
				task.spawn(function()
					local crab = data.Instance
					if not crab or not crab.PrimaryPart then
						movingCrabs -= 1
						if movingCrabs <= 0 then allMovementDone:Fire() end
						return
					end

					local sideMultiplier = (data.StartCFrame.Position.X > MAP_CENTER_X) and -1 or 1
					local isMiddle = (data.Role == "Middle")
					local movementSequence = isMiddle and {50, -90, 80} or {-50, 90, -80}

					local originalRotation = data.StartCFrame.Rotation
					local linePosition = data.StartCFrame.Position

					local CRAB_SPEED = 20
					local PAUSE_DURATION = 0
					local cumulativeTime = ROUTINE_START_TIME

					local crabSize = crab.PrimaryPart.Size
					local collisionParams = OverlapParams.new()
					collisionParams.FilterType = Enum.RaycastFilterType.Exclude
					collisionParams.FilterDescendantsInstances = {crab, crabFolder}

					local timeSaved = 0

					for i, xOffset in ipairs(movementSequence) do
						if not isActive or not crab.Parent then break end

						local segmentDistance = math.abs(xOffset)
						local baseDuration = segmentDistance / CRAB_SPEED

						local remainingSegments = #movementSequence - i + 1

						local extraTimePerSegment = 0
						if timeSaved > 0 and remainingSegments > 0 then
							extraTimePerSegment = timeSaved / remainingSegments
							timeSaved = timeSaved - extraTimePerSegment
						end

						local moveDuration = baseDuration + extraTimePerSegment
						local segmentStartTime = cumulativeTime
						local segmentEndTime = segmentStartTime + moveDuration
						local currentTotalElapsed = getElapsed()
						local adjustedOffset = xOffset * sideMultiplier
						local currentTargetPos = linePosition + Vector3.new(adjustedOffset, 0, 0)

						if currentTotalElapsed >= segmentEndTime then
							linePosition = currentTargetPos
							crab:PivotTo(CFrame.new(linePosition) * originalRotation)
							cumulativeTime = segmentEndTime + PAUSE_DURATION
							continue
						end

						crab:SetAttribute("IsRunning", true)
						crab:SetAttribute("Dance", "")

						local startPos = linePosition
						local lastSafePos = startPos
						local hitSomething = false

						while isActive and crab.Parent do
							local currentTime = getElapsed()
							if currentTime >= segmentEndTime then
								break
							end

							local alpha = math.clamp((currentTime - segmentStartTime) / moveDuration, 0, 1)
							local currentLerpPos = startPos:Lerp(currentTargetPos, alpha)

							local nextAlpha = math.clamp(alpha + 0.05, 0, 1)
							local nextPos = startPos:Lerp(currentTargetPos, nextAlpha)
							local checkCFrame = CFrame.new(nextPos) * originalRotation

							local hits = workspace:GetPartBoundsInBox(
								checkCFrame,
								crabSize * Vector3.new(1.2, 1, 1.2),
								collisionParams
							)

							local blocked = false
							for _, hit in ipairs(hits) do
								if hit.CanCollide and not CollectionService:HasTag(hit.Parent, "CrabRaveCrabs") then
									blocked = true
									break
								end
							end

							if blocked then
								hitSomething = true

								local moveDir = (currentTargetPos - startPos).Unit
								local stoppedPos = lastSafePos - moveDir * 5

								local distFromStart = (stoppedPos - startPos):Dot(moveDir)
								if distFromStart < 0 then
									stoppedPos = startPos
								end

								local distanceTraveled = (stoppedPos - startPos).Magnitude
								local distanceSkipped = segmentDistance - distanceTraveled
								local timeSkipped = distanceSkipped / CRAB_SPEED

								local timeElapsedInSegment = currentTime - segmentStartTime
								local timeRemainingInSegment = moveDuration - timeElapsedInSegment

								timeSaved = timeSaved + timeSkipped

								linePosition = stoppedPos
								crab:PivotTo(CFrame.new(linePosition) * originalRotation)

								cumulativeTime = currentTime + PAUSE_DURATION
								break
							end

							lastSafePos = currentLerpPos
							crab:PivotTo(CFrame.new(currentLerpPos) * originalRotation)
							task.wait()
						end

						if not hitSomething then
							linePosition = currentTargetPos
							crab:PivotTo(CFrame.new(linePosition) * originalRotation)

							while getElapsed() < (segmentEndTime + PAUSE_DURATION) and isActive do
								task.wait()
							end

							cumulativeTime = segmentEndTime + PAUSE_DURATION
						end
					end

					if crab and crab.Parent then
						crab:SetAttribute("IsRunning", false)
					end

					if isActive and crab and crab.Parent then
						registerDanceCrab(crab)
					end

					movingCrabs -= 1
					if movingCrabs <= 0 then
						allMovementDone:Fire()
					end
				end)
			end

			eventTrove:Add(task.spawn(function()
				local connection
				local done = false

				connection = allMovementDone.Event:Connect(function()
					done = true
				end)

				local timeout = 60
				local waited = 0
				while not done and waited < timeout and isActive do
					task.wait(0.1)
					waited += 0.1
				end
				connection:Disconnect()
				allMovementDone:Destroy()

				if not isActive then return end

				while isActive do
					local elapsed = getElapsed()
					if elapsed >= 141 then
						globalDanceIndex = 4
						applyGlobalDance()
						break
					end

					local newDance = math.random(1, 4)
					globalDanceIndex = newDance
					applyGlobalDance()

					task.wait(math.random(10, 15))
					if not isActive then break end

					globalDanceIndex = 0
					applyGlobalDance()

					task.wait(math.random(1, 3))
				end
			end))
		end)
	end

	if WallSpawnFolder then
		for _, PositionPart in WallSpawnFolder:GetChildren() do
			if PositionPart:IsA("BasePart") and PositionPart.Name == "Position" then
				local Crab = CreateCrab(PositionPart.CFrame, WallFolder, "Wall")
				table.insert(crabs, Crab)
			end
		end
	end

	eventTrove:Add(task.spawn(function()
		while getElapsed() < 46.5 and isActive do
			task.wait(0.5)
		end
		local currentAttackers = 0

		while isActive do
			local waitTime = math.random(15, 30) / 10
			task.wait(waitTime)

			if not isActive then break end

			local currentMax = maxattackers
			if ReplicatedStorage:GetAttribute("3RoadsEvent") == true then
				currentMax = maxattackers * 3
			end

			if currentAttackers >= currentMax then continue end

			local availableCrabs = {}
			for _, crab in ipairs(crabs) do
				if crab and crab.Parent and crab:GetAttribute("CrabType") == "Ground" then
					if not activeCrabs[crab] then
						table.insert(availableCrabs, crab)
					end
				end
			end

			if #availableCrabs == 0 then continue end

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

				if not selectedAnimal.PrimaryPart or not SharedEventUtils.isPointInCarpet(selectedAnimal.PrimaryPart.Position) then
					continue
				end

				activeCrabs[selectedCrab] = true
				currentAttackers += 1
				recentlyTargeted[selectedAnimal.Name] = currentTime

				unregisterDanceCrab(selectedCrab)

				task.spawn(function()
					local crabStartPosition = selectedCrab.PrimaryPart.Position
					selectedCrab:SetAttribute("IsRunning", true)

					local maxChaseTime = 30
					local attackDistance = 10

					local attackSpeed = 22
					NpcPathfinding.chase(
						selectedCrab,
						function()
							if selectedAnimal and selectedAnimal.Parent and selectedAnimal.PrimaryPart then
								return selectedAnimal.PrimaryPart.Position
							end
							return nil
						end,
						attackSpeed,
						attackDistance,
						maxChaseTime,
						{
							shouldStop = function()
								return not isActive
							end,
						}
					)

					selectedCrab:SetAttribute("IsRunning", false)

					if selectedAnimal and selectedAnimal.PrimaryPart and selectedCrab and selectedCrab.PrimaryPart then
						local tPos = selectedAnimal.PrimaryPart.Position
						local cPos = selectedCrab.PrimaryPart.Position
						selectedCrab:PivotTo(CFrame.new(cPos, Vector3.new(tPos.X, cPos.Y, tPos.Z)))
					end

					if not selectedCrab or not selectedCrab.Parent or not selectedCrab.PrimaryPart then
						activeCrabs[selectedCrab] = nil
						currentAttackers -= 1
						return
					end
					require(game.ReplicatedStorage.Controllers.SoundController):PlaySound(ReplicatedStorage.Sounds.Events["Crab Rave"].Hit, selectedCrab.PrimaryPart.Position)
					require(game.ReplicatedStorage.Controllers.SoundController):PlaySound(ReplicatedStorage.Sounds.Events["Crab Rave"]["Brainrot Hit"], selectedCrab.PrimaryPart.Position)
					task.wait(0.1)

					Hit:FireAllClients(selectedAnimal.Name)

					task.delay(0.1, function()
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
							local hasClaws = false
							for _, trait in ipairs(currentTraits) do
								if trait == "Claws" then hasClaws = true break end
							end
							if not hasClaws then
								table.insert(currentTraits, "Claws")
								selectedAnimal:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
							end
						end
					end)

					task.wait(1)
					if not selectedCrab or not selectedCrab.Parent or not selectedCrab.PrimaryPart then
						activeCrabs[selectedCrab] = nil
						currentAttackers -= 1
						return
					end

					selectedCrab:SetAttribute("IsRunning", true)

					local returnDance = math.random(1, 4)
					overrideDanceCrab(selectedCrab, returnDance)

					local returnSpeed = 20
					local returnDistance = (crabStartPosition - selectedCrab.PrimaryPart.Position).Magnitude
					NpcPathfinding.moveTo(selectedCrab, crabStartPosition, returnSpeed, {
						maxTime = math.max(5, returnDistance / returnSpeed + 2),
						shouldStop = function()
							return not isActive
						end,
					})

					if selectedCrab.Parent and selectedCrab.PrimaryPart then
						selectedCrab:PivotTo(CFrame.new(selectedCrab.PrimaryPart.Position, crabStartPosition))
					end

					selectedCrab:SetAttribute("IsRunning", false)

					activeCrabs[selectedCrab] = nil
					currentAttackers -= 1
					if isActive and selectedCrab and selectedCrab.Parent then
						registerDanceCrab(selectedCrab)
					else
						crabsInDanceMode[selectedCrab] = nil
					end
				end)
			end
		end
	end))

	eventTrove:Add(task.spawn(function()
		while getElapsed() < 46.5 and isActive do
			task.wait(0.5)
		end
		local currentWanderers = 0

		while isActive do
			task.wait(math.random(10, 20) / 10)
			if not isActive then break end
			if currentWanderers >= 5 then continue end

			local availableCrabs = {}
			for _, crab in ipairs(crabs) do
				if crab and crab.Parent and crab:GetAttribute("CrabType") == "Ground" then
					if not activeCrabs[crab] then
						table.insert(availableCrabs, crab)
					end
				end
			end

			if #availableCrabs == 0 then continue end

			local openSlots = 5 - currentWanderers
			local numToSpawn = math.min(math.random(1, 2), openSlots, #availableCrabs)

			for i = 1, numToSpawn do
				local randomIndex = math.random(1, #availableCrabs)
				local crab = availableCrabs[randomIndex]
				table.remove(availableCrabs, randomIndex)

				activeCrabs[crab] = true
				currentWanderers += 1

				unregisterDanceCrab(crab)

				task.spawn(function()
					if not crab or not crab.Parent or not crab.PrimaryPart then
						activeCrabs[crab] = nil
						currentWanderers -= 1
						return
					end
					local currentPosition = crab.PrimaryPart.Position
					local randomOffset = Vector3.new(math.random(-20, 20), 0, math.random(-20, 20))
					local targetPosition = NpcPathfinding.stickToGround(currentPosition + randomOffset)

					crab:SetAttribute("IsRunning", true)

					local wanderSpeed = 20
					local distance = (targetPosition - currentPosition).Magnitude
					NpcPathfinding.moveTo(crab, targetPosition, wanderSpeed, {
						maxTime = math.max(3, distance / wanderSpeed + 2),
						shouldStop = function()
							return not isActive
						end,
					})

					crab:SetAttribute("IsRunning", false)
					task.wait(math.random(10, 20) / 10)

					activeCrabs[crab] = nil
					currentWanderers -= 1
					if isActive and crab and crab.Parent then
						registerDanceCrab(crab)
					else
						crabsInDanceMode[crab] = nil
					end
				end)
			end
		end
	end))
end

function CrabRave.OnStop()
	if not isActive then return end
	isActive = false
	globalDanceIndex = 0

	if eventTrove then
		eventTrove:Clean()
		eventTrove = nil
	end

	table.clear(crabs)
	table.clear(crabsInDanceMode)
	table.clear(recentlyTargeted)
	table.clear(activeCrabs)
end

return CrabRave
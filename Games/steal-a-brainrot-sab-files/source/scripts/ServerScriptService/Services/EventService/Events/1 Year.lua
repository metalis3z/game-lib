local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local NpcPathfinding = require(game:GetService("ServerScriptService").Components.NpcPathfinding)

local CreateFirework      = Net:RemoteEvent("EventService/1 Year/CreateFirework")
local ExplodeTraitEffect  = Net:RemoteEvent("EventService/1 Year/ExplodeTraitEffect")
local PhaseTaco           = Net:RemoteEvent("EventService/1 Year/PhaseTaco")
local PhaseClaws          = Net:RemoteEvent("EventService/1 Year/PhaseClaws")
local PhaseBrazilFocus    = Net:RemoteEvent("EventService/1 Year/PhaseBrazilFocus")
local PhaseBrazilBurst    = Net:RemoteEvent("EventService/1 Year/PhaseBrazilBurst")
local PhaseSombrero       = Net:RemoteEvent("EventService/1 Year/PhaseSombrero")

local PHASE_TACOS_START  = 0
local PHASE_TACOS_END    = 61
local PHASE_CLAWS_START  = 61
local PHASE_CLAWS_END    = 121
local PHASE_BRAZIL_START = 121
local PHASE_BRAZIL_END   = 181
local PHASE_MEXICO_START = 181
local PHASE_MEXICO_END   = 240

local FALLOFF_COUNT_MIN     = 6
local FALLOFF_COUNT_MAX     = 9
local FALLOFF_SPREAD_RADIUS = 70
local FALLOFF_HIT_RADIUS    = 10
local FALLOFF_TRAVEL_TIME   = 2.3
local FIREWORK_HEIGHT_MIN   = 40
local FIREWORK_HEIGHT_MAX   = 80
local FIREWORK_EFFECT_COUNT = 3

local BURST_GROW_DURATION = 2.25
local LIGHT_SPEED         = 50

local PUT_HAT_DURATION    = 0.5

local FireworkRaycastParams = RaycastParams.new()
FireworkRaycastParams.FilterType = Enum.RaycastFilterType.Include
FireworkRaycastParams.FilterDescendantsInstances = {
	workspace.Map,
	workspace.Plots,
}

local OneYear = {}

local isActive       = false
local eventTrove     = nil
local phaseTroves    = {}
local startedAt      = 0

local function decodeTraits(json)
	if not json then
		return {}
	end
	local ok, decoded = pcall(HttpService.JSONDecode, HttpService, json)
	if ok and type(decoded) == "table" then
		return decoded
	end
	return {}
end

local function encodeTraits(tbl)
	local ok, result = pcall(HttpService.JSONEncode, HttpService, tbl)
	if ok and type(result) == "string" then
		return result
	end
	return "[]"
end

local function hasTrait(animal, traitName)
	local traits = decodeTraits(animal:GetAttribute("Traits"))
	for _, t in ipairs(traits) do
		if t == traitName then
			return true
		end
	end
	return false
end

local function addTraitIfMissing(animal, traitName)
	local traits = decodeTraits(animal:GetAttribute("Traits"))
	for _, t in ipairs(traits) do
		if t == traitName then
			return false
		end
	end
	table.insert(traits, traitName)
	animal:SetAttribute("Traits", encodeTraits(traits))
	return true
end

local function getAnimalsNearPosition(position, radius)
	local hit = {}
	for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
		if animal.PrimaryPart then
			if (animal.PrimaryPart.Position - position).Magnitude <= radius then
				table.insert(hit, animal)
			end
		end
	end
	return hit
end

local function getPhaseTrove(phaseIndex)
	if not eventTrove then
		return nil
	end
	if not phaseTroves[phaseIndex] then
		phaseTroves[phaseIndex] = eventTrove:Extend()
	end
	return phaseTroves[phaseIndex]
end

local function cleanPhaseTrove(phaseIndex)
	local sub = phaseTroves[phaseIndex]
	if sub then
		sub:Clean()
		phaseTroves[phaseIndex] = nil
	end
end

local function generateFalloffTargets(peakPosition, originPosition)
	local falloffCount = math.random(FALLOFF_COUNT_MIN, FALLOFF_COUNT_MAX)
	local falloffs = {}
	local worldTargets = {}

	for _ = 1, falloffCount do
		local angle = math.random() * math.pi * 2
		local radius = math.random() * FALLOFF_SPREAD_RADIUS

		local offsetX = math.cos(angle) * radius
		local offsetZ = math.sin(angle) * radius

		local rayOrigin = peakPosition + Vector3.new(offsetX, 0, offsetZ)
		local raycastResult = workspace:Raycast(rayOrigin, Vector3.new(0, -200, 0), FireworkRaycastParams)

		local landingPosition
		if raycastResult then
			landingPosition = raycastResult.Position
		else
			landingPosition = originPosition + Vector3.new(offsetX, 0, offsetZ)
		end

		table.insert(falloffs, Vector3.new(offsetX, 0, offsetZ))
		table.insert(worldTargets, landingPosition)
	end

	return falloffs, worldTargets
end

local function scheduleFireworkHitDetection(worldTargets, travelDelay)
	task.delay(travelDelay, function()
		if not isActive then return end

		for _, landingPos in ipairs(worldTargets) do
			for _, animal in ipairs(getAnimalsNearPosition(landingPos, FALLOFF_HIT_RADIUS)) do
				if not hasTrait(animal, "1 Year") then
					ExplodeTraitEffect:FireAllClients(animal.Name)
					addTraitIfMissing(animal, "1 Year")
				end
			end
		end
	end)
end

local function startFireworkLoop()
	local OneYearModels = ReplicatedStorage.Models.Events:FindFirstChild("1 Year")
	local fireworksFolder = OneYearModels and OneYearModels:FindFirstChild("Fireworks")

	if not fireworksFolder then
		warn("[1Year] ReplicatedStorage.Models.Events['1 Year'].Fireworks missing; firework loop will not run")
		return
	end

	local fireworkModels = fireworksFolder:GetChildren()

	table.sort(fireworkModels, function(a, b)
		local an = tonumber(a.Name) or tonumber((a.Name:match("(%d+)$"))) or 0
		local bn = tonumber(b.Name) or tonumber((b.Name:match("(%d+)$"))) or 0
		return an < bn
	end)

	local fireworkPositions = {}
	for i, model in ipairs(fireworkModels) do
		local cframe
		if model:IsA("Model") and model.PrimaryPart then
			cframe = model.PrimaryPart.CFrame
		elseif model:IsA("BasePart") then
			cframe = model.CFrame
		end
		if cframe then
			fireworkPositions[i] = cframe
		end
	end

	eventTrove:Add(task.spawn(function()
		while isActive do
			task.wait(math.random(20, 40) / 10)
			if not isActive then break end

			local fireworkDataList = {}
			local numFireworks = math.random(1, 3)

			local validIndices = {}
			for index in pairs(fireworkPositions) do
				table.insert(validIndices, index)
			end

			if #validIndices == 0 then
				continue
			end

			for _ = 1, numFireworks do
				local chosenIndex = validIndices[math.random(1, #validIndices)]
				local launcherCFrame = fireworkPositions[chosenIndex]
				local height = math.random(FIREWORK_HEIGHT_MIN, FIREWORK_HEIGHT_MAX)
				local peakPosition = launcherCFrame.Position + Vector3.new(0, height, 0)
				local originPosition = launcherCFrame.Position

				local falloffOffsets, worldTargets = generateFalloffTargets(peakPosition, originPosition)
				local fireworkEffect = math.random(1, FIREWORK_EFFECT_COUNT)
				local travelDuration = height / 20
				local totalDelay = travelDuration * 0.8 + FALLOFF_TRAVEL_TIME

				scheduleFireworkHitDetection(worldTargets, totalDelay)

				table.insert(fireworkDataList, {
					Chosen = chosenIndex,
					Height = height,
					FireworkEffect = fireworkEffect,
					Falloffs = falloffOffsets,
				})
			end

			if #fireworkDataList > 0 then
				CreateFirework:FireAllClients(fireworkDataList)
			end
		end
	end))
end

local TACO_MULTI_SHOT_CHANCES = {
	{ shots = 3, chance = 0.15 },
	{ shots = 2, chance = 0.35 },
	{ shots = 1, chance = 1.00 },
}

local function getTacoShotCount()
	local roll = math.random()
	for _, entry in ipairs(TACO_MULTI_SHOT_CHANCES) do
		if roll <= entry.chance then
			return entry.shots
		end
	end
	return 1
end

local function startTacosPhase()
	local trove = getPhaseTrove(1)
	if not trove then return end

	ReplicatedStorage:SetAttribute("1YearTacosPhase", true)
	trove:Add(function()
		ReplicatedStorage:SetAttribute("1YearTacosPhase", nil)
	end)

	local recentlyTargeted = {}

	local function tryShootAnimal(selected)
		if not selected or not selected.Parent then return end
		if not selected.PrimaryPart or not SharedEventUtils.isPointInCarpet(selected.PrimaryPart.Position) then
			return
		end

		local now = workspace:GetServerTimeNow()
		PhaseTaco:FireAllClients(selected.Name, now)
		recentlyTargeted[selected.Name] = now

		local delayTrove = trove:Extend()
		delayTrove:Add(task.delay(2.5, function()
			if not selected or not selected.Parent then
				delayTrove:Clean()
				return
			end
			addTraitIfMissing(selected, "Taco")
			delayTrove:Clean()
		end))
	end

	local function getValidCandidates()
		local now = workspace:GetServerTimeNow()
		for name, last in pairs(recentlyTargeted) do
			if (now - last) > 20 then
				recentlyTargeted[name] = nil
			end
		end

		local candidates = {}
		for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
			if animal.PrimaryPart and not recentlyTargeted[animal.Name] and not hasTrait(animal, "Taco") then
				table.insert(candidates, animal)
			end
		end
		return candidates
	end

	trove:Add(task.spawn(function()
		while isActive and phaseTroves[1] do
			local waitTime = math.random(700, 1200) / 100
			if ReplicatedStorage:GetAttribute("3RoadsEvent") == true then
				waitTime = waitTime / 3
			end
			task.wait(waitTime)
			if not (isActive and phaseTroves[1]) then break end

			local shotCount = getTacoShotCount()
			for i = 1, shotCount do
				local candidates = getValidCandidates()
				if #candidates > 0 then
					tryShootAnimal(candidates[math.random(1, #candidates)])
				end
				if i < shotCount then
					task.wait(1)
					if not (isActive and phaseTroves[1]) then break end
				end
			end
		end
	end))
end

local function stopTacosPhase()
	cleanPhaseTrove(1)
end

local function startClawsPhase()
	local trove = getPhaseTrove(2)
	if not trove then return end

	ReplicatedStorage:SetAttribute("1YearClawsPhase", true)
	trove:Add(function()
		ReplicatedStorage:SetAttribute("1YearClawsPhase", nil)
	end)

	local crabs = {}
	local activeCrabs = {}
	local crabsInDanceMode = {}
	local globalDanceIndex = 0
	local recentlyTargeted = {}
	local maxattackers = 2

	local crabFolder = Instance.new("Model")
	crabFolder.Name = "OneYearCrabs"
	crabFolder.Parent = workspace
	trove:Add(crabFolder)
	CollectionService:AddTag(crabFolder, "CrabRaveCrabFolder")

	local GroundFolder = Instance.new("Folder")
	GroundFolder.Name = "Ground"
	GroundFolder.Parent = crabFolder

	local WallFolder = Instance.new("Folder")
	WallFolder.Name = "Wall"
	WallFolder.Parent = crabFolder

	local GroundSpawnFolder = script:FindFirstChild("Ground")
	local WallSpawnFolder   = script:FindFirstChild("Wall")

	if not GroundSpawnFolder or not WallSpawnFolder then
		local crabRaveModule = script.Parent and script.Parent:FindFirstChild("Crab Rave")
		if crabRaveModule then
			GroundSpawnFolder = GroundSpawnFolder or crabRaveModule:FindFirstChild("Ground")
			WallSpawnFolder   = WallSpawnFolder   or crabRaveModule:FindFirstChild("Wall")
		end
	end

	local function CreateCrab(cf, parentFolder, crabType)
		local Crab = Instance.new("Model")
		Crab.Name = "Crab"

		local RootPart = Instance.new("Part")
		RootPart.Name = "HumanoidRootPart"
		RootPart.Size = Vector3.new(2, 2, 2)
		RootPart.Transparency = 1
		RootPart.CanCollide = false
		RootPart.Anchored = true
		RootPart.CFrame = cf
		RootPart.Parent = Crab

		Crab.PrimaryPart = RootPart
		Crab.Parent = parentFolder
		Crab:SetAttribute("CrabType", crabType)
		Crab:SetAttribute("IsRunning", false)
		Crab:SetAttribute("Attack", false)
		Crab:SetAttribute("Dance", "")

		CollectionService:AddTag(Crab, "OneYearCrab")
		return Crab
	end

	local function applyGlobalDance()
		local now = workspace:GetServerTimeNow()
		for crab, overrideIndex in pairs(crabsInDanceMode) do
			if crab and crab.Parent then
				local danceToSet = overrideIndex or globalDanceIndex
				crab:SetAttribute("Dance", danceToSet)
				crab:SetAttribute("DanceStartTime", now)
			end
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

	if GroundSpawnFolder then
		for _, PositionPart in ipairs(GroundSpawnFolder:GetChildren()) do
			if PositionPart:IsA("BasePart") and (PositionPart.Name == "Position" or PositionPart.Name == "PositionMiddle") then
				local Crab = CreateCrab(PositionPart.CFrame, GroundFolder, "Ground")
				table.insert(crabs, Crab)
				registerDanceCrab(Crab)
			end
		end
	else
		warn("[1Year] Crab Rave 'Ground' spawn folder not found; no ground crabs will spawn")
	end

	if WallSpawnFolder then
		for _, PositionPart in ipairs(WallSpawnFolder:GetChildren()) do
			if PositionPart:IsA("BasePart") and PositionPart.Name == "Position" then
				local Crab = CreateCrab(PositionPart.CFrame, WallFolder, "Wall")
				table.insert(crabs, Crab)
			end
		end
	end

	trove:Add(task.spawn(function()
		while isActive and phaseTroves[2] do
			globalDanceIndex = math.random(1, 4)
			applyGlobalDance()
			task.wait(math.random(10, 15))
			if not (isActive and phaseTroves[2]) then break end

			globalDanceIndex = 0
			applyGlobalDance()
			task.wait(math.random(1, 3))
		end
	end))

	trove:Add(task.spawn(function()
		local currentAttackers = 0

		while isActive and phaseTroves[2] do
			task.wait(math.random(15, 30) / 10)
			if not (isActive and phaseTroves[2]) then break end

			local currentMax = maxattackers
			if ReplicatedStorage:GetAttribute("3RoadsEvent") == true then
				currentMax = maxattackers * 3
			end
			if currentAttackers >= currentMax then continue end

			local availableCrabs = {}
			for _, crab in ipairs(crabs) do
				if crab and crab.Parent and crab:GetAttribute("CrabType") == "Ground" and not activeCrabs[crab] then
					table.insert(availableCrabs, crab)
				end
			end
			if #availableCrabs == 0 then continue end

			local now = workspace:GetServerTimeNow()
			for name, last in pairs(recentlyTargeted) do
				if (now - last) > 15 then recentlyTargeted[name] = nil end
			end

			local candidates = {}
			for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
				if animal.PrimaryPart and not recentlyTargeted[animal.Name] and not hasTrait(animal, "Claws") then
					table.insert(candidates, animal)
				end
			end
			if #candidates == 0 then continue end

			local selectedCrab = availableCrabs[math.random(1, #availableCrabs)]
			local selectedAnimal = candidates[math.random(1, #candidates)]

			if not selectedAnimal.PrimaryPart or not SharedEventUtils.isPointInCarpet(selectedAnimal.PrimaryPart.Position) then
				continue
			end

			activeCrabs[selectedCrab] = true
			currentAttackers += 1
			recentlyTargeted[selectedAnimal.Name] = now
			unregisterDanceCrab(selectedCrab)

			task.spawn(function()
				local crabStartPosition = selectedCrab.PrimaryPart.Position
				selectedCrab:SetAttribute("IsRunning", true)

				local maxChaseTime = 30
				local attackDistance = 10

				NpcPathfinding.chase(
					selectedCrab,
					function()
						if selectedAnimal and selectedAnimal.Parent and selectedAnimal.PrimaryPart then
							return selectedAnimal.PrimaryPart.Position
						end
						return nil
					end,
					22,
					attackDistance,
					maxChaseTime,
					{
						shouldStop = function()
							return (not isActive) or (not phaseTroves[2])
						end,
					}
				)

				selectedCrab:SetAttribute("IsRunning", false)
				if selectedAnimal and selectedAnimal.PrimaryPart and selectedCrab and selectedCrab.PrimaryPart then
					local tPos = selectedAnimal.PrimaryPart.Position
					local cPos = selectedCrab.PrimaryPart.Position
					selectedCrab:PivotTo(CFrame.new(cPos, Vector3.new(tPos.X, cPos.Y, tPos.Z)))
				end

				selectedCrab:SetAttribute("Attack", true)
				if not selectedCrab or not selectedCrab.Parent or not selectedCrab.PrimaryPart then
					activeCrabs[selectedCrab] = nil
					currentAttackers -= 1
					return
				end
				task.wait(0.1)
				selectedCrab:SetAttribute("Attack", false)

				PhaseClaws:FireAllClients(selectedAnimal.Name)

				task.delay(0.1, function()
					if selectedAnimal and selectedAnimal.Parent then
						addTraitIfMissing(selectedAnimal, "Claws")
					end
				end)

				task.wait(1)
				if not selectedCrab or not selectedCrab.Parent or not selectedCrab.PrimaryPart then
					activeCrabs[selectedCrab] = nil
					currentAttackers -= 1
					return
				end

				selectedCrab:SetAttribute("IsRunning", true)
				overrideDanceCrab(selectedCrab, math.random(1, 4))

				local returnSpeed = 20
				local returnDistance = (crabStartPosition - selectedCrab.PrimaryPart.Position).Magnitude
				NpcPathfinding.moveTo(selectedCrab, crabStartPosition, returnSpeed, {
					maxTime = math.max(5, returnDistance / returnSpeed + 2),
					shouldStop = function()
						return (not isActive) or (not phaseTroves[2])
					end,
				})

				if selectedCrab.Parent and selectedCrab.PrimaryPart then
					selectedCrab:PivotTo(CFrame.new(selectedCrab.PrimaryPart.Position, crabStartPosition))
				end

				selectedCrab:SetAttribute("IsRunning", false)
				activeCrabs[selectedCrab] = nil
				currentAttackers -= 1
				if isActive and phaseTroves[2] and selectedCrab and selectedCrab.Parent then
					registerDanceCrab(selectedCrab)
				else
					crabsInDanceMode[selectedCrab] = nil
				end
			end)
		end
	end))

	trove:Add(task.spawn(function()
		local currentWanderers = 0
		while isActive and phaseTroves[2] do
			task.wait(math.random(10, 20) / 10)
			if not (isActive and phaseTroves[2]) then break end
			if currentWanderers >= 5 then continue end

			local availableCrabs = {}
			for _, crab in ipairs(crabs) do
				if crab and crab.Parent and crab:GetAttribute("CrabType") == "Ground" and not activeCrabs[crab] then
					table.insert(availableCrabs, crab)
				end
			end
			if #availableCrabs == 0 then continue end

			local openSlots = 5 - currentWanderers
			local numToSpawn = math.min(math.random(1, 2), openSlots, #availableCrabs)

			for _ = 1, numToSpawn do
				local idx = math.random(1, #availableCrabs)
				local crab = availableCrabs[idx]
				table.remove(availableCrabs, idx)

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
					local targetPosition = NpcPathfinding.stickToGround(
						currentPosition + Vector3.new(math.random(-20, 20), 0, math.random(-20, 20))
					)

					crab:SetAttribute("IsRunning", true)

					local wanderSpeed = 20
					local distance = (targetPosition - currentPosition).Magnitude
					NpcPathfinding.moveTo(crab, targetPosition, wanderSpeed, {
						maxTime = math.max(3, distance / wanderSpeed + 2),
						shouldStop = function()
							return (not isActive) or (not phaseTroves[2])
						end,
					})

					crab:SetAttribute("IsRunning", false)
					task.wait(math.random(10, 20) / 10)

					activeCrabs[crab] = nil
					currentWanderers -= 1
					if isActive and phaseTroves[2] and crab and crab.Parent then
						registerDanceCrab(crab)
					else
						crabsInDanceMode[crab] = nil
					end
				end)
			end
		end
	end))
end

local function stopClawsPhase()
	cleanPhaseTrove(2)
end

local function startBrazilPhase()
	local trove = getPhaseTrove(3)
	if not trove then return end

	ReplicatedStorage:SetAttribute("1YearBrazilPhase", true)
	trove:Add(function()
		ReplicatedStorage:SetAttribute("1YearBrazilPhase", nil)
	end)

	local MapFloor = nil
	local brazilEventsFolder = workspace:FindFirstChild("Events")
	if brazilEventsFolder then
		local brazilFolder = brazilEventsFolder:FindFirstChild("Brazil")
		if brazilFolder then
			MapFloor = brazilFolder:FindFirstChild("MapFloor")
		end
	end
	if not MapFloor then
		warn("[1Year] workspace.Events.Brazil.MapFloor not found; Brazil phase aborted")
		return
	end

	local lightPart
	local currentTween
	local trackedAnimal
	local trackingConn
	local isTargetingAnimal = false
	local recentlyTargeted = {}

	local function getRandomPosition()
		local rx = MapFloor.Position.X + (math.random() - 0.5) * MapFloor.Size.X
		local rz = MapFloor.Position.Z + (math.random() - 0.5) * MapFloor.Size.Z
		return Vector3.new(rx, MapFloor.Position.Y, rz)
	end

	lightPart = Instance.new("Part")
	lightPart.Name = "OneYearBrazilLight"
	lightPart.Size = Vector3.new(4, 20, 4)
	lightPart.Transparency = 1
	lightPart.CanCollide = false
	lightPart.Anchored = true
	lightPart.CFrame = CFrame.new(getRandomPosition())
	CollectionService:AddTag(lightPart, "OneYearBrazilHitbox")
	lightPart.Parent = workspace
	trove:Add(lightPart)

	local function tweenLightTo(position)
		if currentTween then
			currentTween:Cancel()
		end
		if not lightPart then return nil end
		local distance = (lightPart.Position - position).Magnitude
		local duration = distance / LIGHT_SPEED
		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
		currentTween = TweenService:Create(lightPart, tweenInfo, { CFrame = CFrame.new(position) })
		currentTween:Play()
		return currentTween
	end

	local function stopTrackingAnimal()
		if trackingConn then
			trackingConn:Disconnect()
			trackingConn = nil
		end
		trackedAnimal = nil
	end

	local function trackAnimal(animal)
		stopTrackingAnimal()
		trackedAnimal = animal
		trackingConn = trove:Connect(RunService.Heartbeat, function(dt)
			if not trackedAnimal or not trackedAnimal.PrimaryPart or not lightPart then
				stopTrackingAnimal()
				return
			end

			local p = trackedAnimal.PrimaryPart.Position
			local targetPos = Vector3.new(p.X, lightPart.Position.Y, p.Z)

			local distance = (lightPart.Position - targetPos).Magnitude
			local alpha = math.clamp(dt * LIGHT_SPEED / math.max(distance, 0.001), 0, 1)
			lightPart.CFrame = CFrame.new(lightPart.Position:Lerp(targetPos, alpha))
		end)
	end

	trove:Add(task.spawn(function()
		while isActive and phaseTroves[3] do
			if not isTargetingAnimal then
				local tween = tweenLightTo(getRandomPosition())
				if tween then
					tween.Completed:Wait()
				end
			else
				task.wait(0.1)
			end
			if not (isActive and phaseTroves[3]) then break end
		end
	end))

	trove:Add(task.spawn(function()
		while isActive and phaseTroves[3] do
			task.wait(math.random(7, 12))
			if not (isActive and phaseTroves[3]) or not lightPart then break end

			local now = workspace:GetServerTimeNow()
			for name, last in pairs(recentlyTargeted) do
				if now - last > 20 then recentlyTargeted[name] = nil end
			end

			local selected, shortest = nil, math.huge
			for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
				if animal.PrimaryPart and not recentlyTargeted[animal.Name] and not hasTrait(animal, "Brazil") then
					local dist = (lightPart.Position - animal.PrimaryPart.Position).Magnitude
					if dist < shortest then
						shortest = dist
						selected = animal
					end
				end
			end

			if selected and selected.PrimaryPart then
				if not SharedEventUtils.isPointInCarpet(selected.PrimaryPart.Position) then
					isTargetingAnimal = false
					continue
				end

				isTargetingAnimal = true

				if currentTween then
					currentTween:Cancel()
					currentTween = nil
				end

				trackAnimal(selected)

				local CLOSE_ENOUGH = 3
				local timeout = 5
				local elapsed = 0
				while elapsed < timeout do
					task.wait(0.05)
					elapsed += 0.05
					if not lightPart or not selected.PrimaryPart then break end
					local dist = (
						Vector3.new(lightPart.Position.X, 0, lightPart.Position.Z) - 
							Vector3.new(selected.PrimaryPart.Position.X, 0, selected.PrimaryPart.Position.Z)
					).Magnitude
					if dist <= CLOSE_ENOUGH then break end
				end

				task.wait(0.5)

				now = workspace:GetServerTimeNow()
				if lightPart then
					lightPart:SetAttribute("Focused", now)
					lightPart:SetAttribute("BurstTime", now + BURST_GROW_DURATION)
				end

				PhaseBrazilFocus:FireAllClients(selected.Name)
				recentlyTargeted[selected.Name] = now

				task.wait(BURST_GROW_DURATION)

				stopTrackingAnimal()
				PhaseBrazilBurst:FireAllClients(selected.Name)

				if lightPart then
					lightPart:SetAttribute("Focused", nil)
					lightPart:SetAttribute("BurstTime", nil)
				end

				local target = selected
				task.delay(0.1, function()
					if target and target.Parent then
						addTraitIfMissing(target, "Brazil")
					end
				end)

				isTargetingAnimal = false
			end
		end
	end))

	trove:Add(function()
		if currentTween then
			currentTween:Cancel()
			currentTween = nil
		end
		stopTrackingAnimal()
		isTargetingAnimal = false
		lightPart = nil
	end)
end

local function stopBrazilPhase()
	cleanPhaseTrove(3)
end

local function startMexicoPhase()
	local trove = getPhaseTrove(4)
	if not trove then return end

	ReplicatedStorage:SetAttribute("1YearMexicoPhase", true)
	trove:Add(function()
		ReplicatedStorage:SetAttribute("1YearMexicoPhase", nil)
	end)

	local recentlyTargeted = {}
	local recentlyTargetedPlayers = {}
	local spawnedRoaches = {}
	local activeAttacks = {}

	local WanderFolder = nil
	local eventsFolder = workspace:FindFirstChild("Events")
	if eventsFolder then
		WanderFolder = eventsFolder:FindFirstChild("Wander")
	end
	if not WanderFolder then
		warn("[1Year] workspace.Events.Wander not found; Mexico phase aborted")
		return
	end

	local sombreroTemplate = script:FindFirstChild("Sombrero")
	if not sombreroTemplate then
		local mexicoModule = script.Parent and script.Parent:FindFirstChild("Mexico")
		if mexicoModule then
			sombreroTemplate = mexicoModule:FindFirstChild("Sombrero")
		end
	end

	local ROACH_Y_OFFSET = 5

	local function stickToGround(position)
		return NpcPathfinding.stickToGround(position, ROACH_Y_OFFSET)
	end

	local function getRandomWanderPosition(wanderPart)
		local size = wanderPart.Size
		local cf = wanderPart.CFrame
		local rx = math.random(-size.X / 2, size.X / 2)
		local rz = math.random(-size.Z / 2, size.Z / 2)
		local samplePos = (cf * CFrame.new(rx, 0, rz)).Position
		return NpcPathfinding.stickToGround(samplePos, ROACH_Y_OFFSET)
	end

	local function createCockroach(position)
		local roach = Instance.new("Model")
		roach.Name = "Roach"

		local root = Instance.new("Part")
		root.Name = "HumanoidRootPart"
		root.Size = Vector3.new(2, 2, 2)
		root.Transparency = 1
		root.CanCollide = false
		root.Anchored = true
		root.CFrame = CFrame.new(position)
		root.Parent = roach

		roach.PrimaryPart = root
		CollectionService:AddTag(roach, "OneYearRoach")
		return roach
	end

	local instruments = { "Violin", "Maracas", "Trumpet" }
	for _, wanderPart in ipairs(WanderFolder:GetChildren()) do
		if wanderPart:IsA("BasePart") then
			local numRoaches = math.random(1, 3)
			for _ = 1, numRoaches do
				local spawnPos = stickToGround(getRandomWanderPosition(wanderPart))
				local roach = createCockroach(spawnPos)
				roach.Parent = workspace
				trove:Add(roach)

				local assigned = instruments[math.random(1, #instruments)]
				roach:SetAttribute("Instrument", assigned)
				roach:SetAttribute("Dance", true)
				roach:SetAttribute("IsRunning", false)
				roach:SetAttribute("Shuffle", false)

				table.insert(spawnedRoaches, {
					Model = roach,
					WanderPart = wanderPart,
					LastWander = 0,
					BaseInstrument = assigned,
				})
			end
		end
	end

	local function moveRoachToTarget(roachData, targetPosition)
		local roach = roachData.Model
		if not roach or not roach.Parent or not roach.PrimaryPart then return end

		roach:SetAttribute("IsRunning", true)
		roach:SetAttribute("Dance", true)

		local speed = 30
		local distance = (targetPosition - roach.PrimaryPart.Position).Magnitude

		NpcPathfinding.moveTo(roach, targetPosition, speed, {
			maxTime = math.max(5, distance / speed + 2),
			yOffset = ROACH_Y_OFFSET,
			shouldStop = function()
				return (not (isActive and phaseTroves[4])) or (not roach.Parent)
			end,
		})

		if roach.Parent then
			roach:SetAttribute("IsRunning", false)
		end
	end

	local function followAndAttackAnimal(roachData, targetAnimal)
		local roach = roachData.Model
		if not roach or not roach.Parent or not roach.PrimaryPart then return end

		local attackId = HttpService:GenerateGUID(false)
		activeAttacks[attackId] = true

		local originalInstrument = roachData.BaseInstrument
		if not originalInstrument or originalInstrument == "Sombrero" then
			originalInstrument = instruments[math.random(1, #instruments)]
			roachData.BaseInstrument = originalInstrument
		end

		roach:SetAttribute("Instrument", "Sombrero")
		roach:SetAttribute("IsRunning", true)
		roach:SetAttribute("Dance", true)

		local speed = 20

		task.spawn(function()

			roach:SetAttribute("Instrument", "Sombrero")
			local reachedTarget = NpcPathfinding.chase(
				roach,
				function()
					if targetAnimal and targetAnimal.Parent and targetAnimal.PrimaryPart then
						return targetAnimal.PrimaryPart.Position
					end
					return nil
				end,
				speed,
				10,
				30,
				{
					yOffset = ROACH_Y_OFFSET,
					shouldStop = function()
						return (not activeAttacks[attackId])
							or (not (isActive and phaseTroves[4]))
					end,
				}
			)

			roach:SetAttribute("Instrument", "Sombrero")
			roach:SetAttribute("IsRunning", false)

			if reachedTarget and targetAnimal and targetAnimal.Parent then
				roach:SetAttribute("Dance", true)
				roach:SetAttribute("AttackAnimation", (roach:GetAttribute("AttackAnimation") or 0) + 1)

				roach:SetAttribute("Instrument", "Sombrero")
				local elapsed = 0
				local lastTime = os.clock()
				while elapsed < PUT_HAT_DURATION
					and isActive and phaseTroves[4]
					and targetAnimal and targetAnimal.Parent and targetAnimal.PrimaryPart do
					local now = os.clock()
					local dt = now - lastTime
					lastTime = now
					elapsed += dt

					local targetPos = targetAnimal.PrimaryPart.Position
					local roachPos = roach.PrimaryPart.Position
					local diff = targetPos - roachPos
					local dist = diff.Magnitude
					if dist > 0.5 then
						local direction = diff.Unit
						local flat = Vector3.new(direction.X, 0, direction.Z).Unit
						local moveAmount = math.min(speed * dt, dist)
						local newPos = stickToGround(roachPos + direction * moveAmount)
						roach:PivotTo(CFrame.new(newPos, newPos + flat))
					end
					task.wait()
				end

				roach:SetAttribute("Instrument", originalInstrument)
				PhaseSombrero:FireAllClients(targetAnimal.Name)

				local player = Players:GetPlayerFromCharacter(targetAnimal)
				if player then
					if player:GetAttribute("HasSombreroHat") == true then
						if not targetAnimal:FindFirstChild("SombreroHat") and sombreroTemplate then
							local hatClone = sombreroTemplate:Clone()
							hatClone.Name = "SombreroHat"
							if hatClone:IsA("Accessory") and targetAnimal:FindFirstChild("Humanoid") then
								targetAnimal.Humanoid:AddAccessory(hatClone)
								PhaseSombrero:FireAllClients(targetAnimal)
							else
								hatClone.Parent = targetAnimal
								PhaseSombrero:FireAllClients(targetAnimal)
							end
						end
					end
				else
					addTraitIfMissing(targetAnimal, "Sombrero")
				end

                task.wait(1)
			end

			roach:SetAttribute("Instrument", originalInstrument)
			activeAttacks[attackId] = nil
		end)
	end

	trove:Add(task.spawn(function()
		while isActive and phaseTroves[4] do
			task.wait(1)
			for _, roachData in ipairs(spawnedRoaches) do
				local roach = roachData.Model
				local now = os.clock()
				if roach and roach.Parent and (now - roachData.LastWander) > math.random(5, 10) then
					if not roach:GetAttribute("IsRunning") then
						roach:SetAttribute("IsRunning", true)
						local wanderPos = getRandomWanderPosition(roachData.WanderPart)
						task.spawn(function()
							moveRoachToTarget(roachData, wanderPos)
						end)
						roachData.LastWander = now
					end
				end
			end
		end
	end))

	trove:Add(task.spawn(function()
		while isActive and phaseTroves[4] do
			task.wait(math.random(5, 10))
			if not (isActive and phaseTroves[4]) or #spawnedRoaches == 0 then break end

			local now = workspace:GetServerTimeNow()
			for name, last in pairs(recentlyTargeted) do
				if (now - last) > 15 then recentlyTargeted[name] = nil end
			end

			local candidates = {}
			for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
				if animal.PrimaryPart and not recentlyTargeted[animal.Name] and not hasTrait(animal, "Sombrero") then
					table.insert(candidates, animal)
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]

				local availableRoaches = {}
				for _, rData in ipairs(spawnedRoaches) do
					if rData.Model and rData.Model.Parent and not rData.Model:GetAttribute("IsRunning") then
						table.insert(availableRoaches, rData)
					end
				end

				if #availableRoaches > 0 then
					local roachData = availableRoaches[math.random(1, #availableRoaches)]
					roachData.Model:SetAttribute("IsRunning", true)
					followAndAttackAnimal(roachData, selected)
					recentlyTargeted[selected.Name] = now
				end
			end
		end
	end))

	trove:Add(task.spawn(function()
		while isActive and phaseTroves[4] do
			task.wait(math.random(15, 25))
			if not (isActive and phaseTroves[4]) or #spawnedRoaches == 0 then break end

			local now = workspace:GetServerTimeNow()
			for name, last in pairs(recentlyTargetedPlayers) do
				if (now - last) > 30 then recentlyTargetedPlayers[name] = nil end
			end

			local candidates = {}
			for _, player in ipairs(Players:GetPlayers()) do
				local character = player.Character
				if character and character:FindFirstChild("HumanoidRootPart") then
					local hasHat = player:GetAttribute("HasSombreroHat") == true
					if not recentlyTargetedPlayers[player.Name] and not hasHat then
						table.insert(candidates, player)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]

				local availableRoaches = {}
				for _, rData in ipairs(spawnedRoaches) do
					if rData.Model and rData.Model.Parent and not rData.Model:GetAttribute("IsRunning") then
						table.insert(availableRoaches, rData)
					end
				end

				if #availableRoaches > 0 then
					local roachData = availableRoaches[math.random(1, #availableRoaches)]
					roachData.Model:SetAttribute("IsRunning", true)
					recentlyTargetedPlayers[selected.Name] = now
					selected:SetAttribute("HasSombreroHat", true)
					followAndAttackAnimal(roachData, selected.Character)
				end
			end
		end
	end))

	trove:Add(task.spawn(function()
		while isActive and phaseTroves[4] do
			task.wait(3)
			for _, roachData in ipairs(spawnedRoaches) do
				local roach = roachData.Model
				if roach and roach.Parent then
					local currentInstrument = roach:GetAttribute("Instrument")
					local isRunning = roach:GetAttribute("IsRunning")
					if currentInstrument == "Sombrero" and not isRunning then
						local restore = roachData.BaseInstrument
						if not restore or restore == "Sombrero" then
							restore = instruments[math.random(1, #instruments)]
							roachData.BaseInstrument = restore
						end
						roach:SetAttribute("Instrument", restore)
					end
				end
			end
		end
	end))

	trove:Add(function()
		activeAttacks = {}
		spawnedRoaches = {}
		recentlyTargeted = {}
		recentlyTargetedPlayers = {}
	end)
end

local function stopMexicoPhase()
	cleanPhaseTrove(4)
end

local PHASES = {
	{ index = 1, startOffset = PHASE_TACOS_START,  endOffset = PHASE_TACOS_END,  start = startTacosPhase,  stop = stopTacosPhase  },
	{ index = 2, startOffset = PHASE_CLAWS_START,  endOffset = PHASE_CLAWS_END,  start = startClawsPhase,  stop = stopClawsPhase  },
	{ index = 3, startOffset = PHASE_BRAZIL_START, endOffset = PHASE_BRAZIL_END, start = startBrazilPhase, stop = stopBrazilPhase },
	{ index = 4, startOffset = PHASE_MEXICO_START, endOffset = PHASE_MEXICO_END, start = startMexicoPhase, stop = stopMexicoPhase },
}

local function schedulePhase(phase)
	local now = workspace:GetServerTimeNow()
	local startTime = startedAt + phase.startOffset
	local endTime   = startedAt + phase.endOffset

	local startDelay = startTime - now
	if endTime <= now then
		return
	end

	if startDelay <= 0 then
		if isActive then phase.start() end
	else
		eventTrove:Add(task.delay(startDelay, function()
			if isActive then phase.start() end
		end))
	end

	local stopDelay = endTime - workspace:GetServerTimeNow()
	if stopDelay <= 0 then
		phase.stop()
	else
		eventTrove:Add(task.delay(stopDelay, function()
			phase.stop()
		end))
	end
end

function OneYear.OnStart(data)
	if isActive then return end
	isActive = true

	eventTrove = Trove.new()
	phaseTroves = {}

	startedAt = (data and data.startedAt) or workspace:GetServerTimeNow()

	ReplicatedStorage:SetAttribute("1YearEvent", true)
	eventTrove:Add(function()
		ReplicatedStorage:SetAttribute("1YearEvent", nil)
	end)

	eventTrove:Add(function()
		ReplicatedStorage:SetAttribute("1YearTacosPhase",  nil)
		ReplicatedStorage:SetAttribute("1YearClawsPhase",  nil)
		ReplicatedStorage:SetAttribute("1YearBrazilPhase", nil)
		ReplicatedStorage:SetAttribute("1YearMexicoPhase", nil)
	end)

	startFireworkLoop()

	for _, phase in ipairs(PHASES) do
		schedulePhase(phase)
	end

	local totalDuration = PHASE_MEXICO_END
	local endDelay = (startedAt + totalDuration) - workspace:GetServerTimeNow()
	if endDelay > 0 then
		eventTrove:Add(task.delay(endDelay, function()
			if isActive then
				OneYear.OnStop()
			end
		end))
	end
end

function OneYear.OnStop()
	if not isActive then return end
	isActive = false

	if eventTrove then
		eventTrove:Clean()
		eventTrove = nil
	end
	phaseTroves = {}
end

function OneYear.IsRunning()
	return isActive
end

return OneYear
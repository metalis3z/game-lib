local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local NpcPathfinding = require(game:GetService("ServerScriptService").Components.NpcPathfinding)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Burst = Net:RemoteEvent("EventService/Mexico/Burst")

local Mexico = {}

local isActive = false
local isPaused = false
local recentlyTargeted = {}
local recentlyTargetedPlayers = {}
local spawnedRoaches = {}
local activeAttacks = {}

local eventTrove = nil

local PUT_HAT_DURATION = 0.5

local WANDER_FOLDER = workspace.Events:FindFirstChild("Wander")
local playersombrero = script.Sombrero

local ROACH_Y_OFFSET = 5

local function stickToGround(Position)
	return NpcPathfinding.stickToGround(Position, ROACH_Y_OFFSET)
end

local function getRandomWanderPosition(wanderPart)
	local size = wanderPart.Size
	local cf = wanderPart.CFrame

	local randomX = math.random(-size.X/2, size.X/2)
	local randomZ = math.random(-size.Z/2, size.Z/2)

	local samplePos = (cf * CFrame.new(randomX, 0, randomZ)).Position
	return NpcPathfinding.stickToGround(samplePos, ROACH_Y_OFFSET)
end

local function createCockroach(position)
	local roach = Instance.new("Model")
	roach.Name = "Roach"

	local rootPart = Instance.new("Part")
	rootPart.Name = "HumanoidRootPart"
	rootPart.Size = Vector3.new(2, 2, 2)
	rootPart.Transparency = 1
	rootPart.CanCollide = false
	rootPart.Anchored = true
	rootPart.CFrame = CFrame.new(position)
	rootPart.Parent = roach

	roach.PrimaryPart = rootPart

	CollectionService:AddTag(roach, "Roach")

	return roach
end

local function spawnRoaches()
	if not WANDER_FOLDER then
		warn("Wander folder not found at workspace.Events.Wander")
		return
	end

	for _, wanderPart in ipairs(WANDER_FOLDER:GetChildren()) do
		if wanderPart:IsA("BasePart") then
			local numRoaches = math.random(1, 3)

			for i = 1, numRoaches do
				local spawnPos = getRandomWanderPosition(wanderPart)
				spawnPos = stickToGround(spawnPos)
				local roach = createCockroach(spawnPos)

				eventTrove:Add(roach)

				roach.Parent = workspace

				local instruments = {"Violin", "Maracas", "Trumpet"}
				local assignedInstrument = instruments[math.random(1, #instruments)]

				roach:SetAttribute("Instrument", assignedInstrument)
				roach:SetAttribute("Dance", true)
				roach:SetAttribute("IsRunning", false)
				roach:SetAttribute("Shuffle", false)

				table.insert(spawnedRoaches, {
					Model = roach,
					WanderPart = wanderPart,
					LastWander = 0,
					BaseInstrument = assignedInstrument,
				})
			end
		end
	end
end

local function startSombreroCleanupLoop()
	eventTrove:Add(task.spawn(function()
		local instruments = {"Violin", "Maracas", "Trumpet"}

		while isActive do
			task.wait(3)

			for _, roachData in ipairs(spawnedRoaches) do
				local roach = roachData.Model
				if not roach or not roach.Parent then
					continue
				end

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
	end))
end

local function followAndAttackAnimal(roachData, targetAnimal)
	local roach = roachData.Model
	if not roach or not roach.Parent or not roach.PrimaryPart then
		return
	end

	if roachData.IsAttacking then
		return
	end
	roachData.IsAttacking = true

	local attackId = HttpService:GenerateGUID(false)
	activeAttacks[attackId] = true

	local originalInstrument = roachData.BaseInstrument
	if not originalInstrument or originalInstrument == "Sombrero" then
		local instruments = {"Violin", "Maracas", "Trumpet"}
		originalInstrument = instruments[math.random(1, #instruments)]
		roachData.BaseInstrument = originalInstrument
	end

	roach:SetAttribute("Instrument", "Sombrero")
	roach:SetAttribute("IsRunning", true)
	roach:SetAttribute("Dance", true)

	local attackTrove = eventTrove:Extend()

	attackTrove:Add(task.spawn(function()
		roach:SetAttribute("Instrument", "Sombrero")
		local reachedTarget = NpcPathfinding.chase(
			roach,
			function()
				if targetAnimal and targetAnimal.Parent and targetAnimal.PrimaryPart then
					return targetAnimal.PrimaryPart.Position
				end
				return nil
			end,
			20,
			10,
			30,
			{
				yOffset = ROACH_Y_OFFSET,
				shouldStop = function()
					return (not activeAttacks[attackId]) or (not isActive) or isPaused
				end,
			}
		)
		roach:SetAttribute("Instrument", "Sombrero")
		roach:SetAttribute("IsRunning", false)

		if reachedTarget and targetAnimal and targetAnimal.Parent then
			roach:SetAttribute("Dance", true)
			roach:SetAttribute("Instrument", "Sombrero")
			roach:SetAttribute("AttackAnimation", (roach:GetAttribute("AttackAnimation") or 0) + 1)

			local elapsed = 0
			local lastTime = os.clock()
			while elapsed < PUT_HAT_DURATION
				and targetAnimal
				and targetAnimal.Parent
				and targetAnimal.PrimaryPart
				and not isPaused
			do
				local now = os.clock()
				local dt = now - lastTime
				lastTime = now
				elapsed += dt

				local targetPos = targetAnimal.PrimaryPart.Position
				local roachPos = roach.PrimaryPart.Position
				local diff = targetPos - roachPos
				local distance = diff.Magnitude

				if distance > 0.5 then
					local direction = diff.Unit
					local flatDirection = Vector3.new(direction.X, 0, direction.Z).Unit
					local moveAmount = math.min(20 * dt, distance)
					local newPos = stickToGround(roachPos + direction * moveAmount)
					roach:PivotTo(CFrame.new(newPos, newPos + flatDirection))
				end

				task.wait()
			end

			roach:SetAttribute("Instrument", originalInstrument)
			Burst:FireAllClients(targetAnimal.Name)

			local player = Players:GetPlayerFromCharacter(targetAnimal)

			if player then
				if player:GetAttribute("HasSombreroHat") == true then
					if not targetAnimal:FindFirstChild("SombreroHat") then
						local hatClone = playersombrero:Clone()
						hatClone.Name = "SombreroHat"

						if hatClone:IsA("Accessory") and targetAnimal:FindFirstChild("Humanoid") then
							targetAnimal.Humanoid:AddAccessory(hatClone)
							Burst:FireAllClients(targetAnimal)
						else
							hatClone.Parent = targetAnimal
							Burst:FireAllClients(targetAnimal)
						end
					end
				end
			else
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

				local hasSombrero = false
				for _, trait in ipairs(currentTraits) do
					if trait == "Sombrero" then
						hasSombrero = true
						break
					end
				end

				if not hasSombrero then
					table.insert(currentTraits, "Sombrero")
					targetAnimal:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end
			end

			task.wait(1)
		end

		roach:SetAttribute("Instrument", originalInstrument)
		activeAttacks[attackId] = nil
		roachData.IsAttacking = false

		attackTrove:Destroy()
	end))
end

local function moveRoachToTarget(roachData, targetPosition)
	local roach = roachData.Model
	if not roach or not roach.Parent or not roach.PrimaryPart then
		return
	end

	roach:SetAttribute("IsRunning", true)
	roach:SetAttribute("Dance", true)

	local speed = 30
	local distance = (targetPosition - roach.PrimaryPart.Position).Magnitude

	NpcPathfinding.moveTo(roach, targetPosition, speed, {
		maxTime = math.max(5, distance / speed + 2),
		yOffset = ROACH_Y_OFFSET,
		shouldStop = function()
			return (not isActive) or (not roach.Parent)
		end,
	})

	if roach.Parent then
		roach:SetAttribute("IsRunning", false)
	end
end

function Mexico.OnStart(data)
	if isActive then return end
	isActive = true

	eventTrove = Trove.new()

	ReplicatedStorage:SetAttribute("MexicoEvent", true)
	eventTrove:Add(function()
		ReplicatedStorage:SetAttribute("MexicoEvent", nil)
	end)
	spawnRoaches()
	startSombreroCleanupLoop()

	eventTrove:Add(task.delay(math.max(data.startedAt + 28.5 - workspace:GetServerTimeNow(), 0), function()
		if not isActive then return end
		isPaused = true

		for _, roachData in ipairs(spawnedRoaches) do
			local roach = roachData.Model
			if roach and roach.Parent then
				roach:SetAttribute("IsRunning", false)
				roach:SetAttribute("Dance", false)
			end
		end

		eventTrove:Add(task.delay(math.max(data.startedAt + 34.5 - workspace:GetServerTimeNow(), 0), function()
			if not isActive then return end
			isPaused = false

			activeAttacks = {}
			for _, roachData in ipairs(spawnedRoaches) do
				local roach = roachData.Model
				if roach and roach.Parent then
					roachData.IsAttacking = false
					local instrument = roach:GetAttribute("Instrument")
					if instrument == "Sombrero" then
						roach:SetAttribute("Instrument", roachData.BaseInstrument or "Violin")
					end
					roach:SetAttribute("IsRunning", false)
					roach:SetAttribute("Dance", true)
				end
			end
		end))
	end))

	eventTrove:Add(task.spawn(function()
		while isActive do
			task.wait(1)

			for _, roachData in ipairs(spawnedRoaches) do
				local roach = roachData.Model
				local currentTime = os.clock()

				if roach and roach.Parent and (currentTime - roachData.LastWander) > math.random(5, 10) then
					if not roach:GetAttribute("IsRunning") and not roachData.IsAttacking and not isPaused then
						local wanderPos = getRandomWanderPosition(roachData.WanderPart)

						task.spawn(function()
							moveRoachToTarget(roachData, wanderPos)
						end)

						roachData.LastWander = currentTime
					end
				end
			end
		end
	end))

	eventTrove:Add(task.spawn(function()
		while isActive do
			local waitTime = math.random(5, 10)
			task.wait(waitTime)

			if not isActive or #spawnedRoaches == 0 or isPaused then
				if isPaused then continue end
				break
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
					local hasSombrero = false

					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Sombrero" then
									hasSombrero = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasSombrero then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local roachData = spawnedRoaches[math.random(1, #spawnedRoaches)]

				if roachData.Model and roachData.Model.Parent then
					followAndAttackAnimal(roachData, selected)
					recentlyTargeted[selected.Name] = currentTime
				end
			end
		end
	end))

	eventTrove:Add(task.spawn(function()
		while isActive do
			local waitTime = math.random(15, 25)
			task.wait(waitTime)

			if not isActive or #spawnedRoaches == 0 or isPaused then
				if isPaused then continue end
				break
			end

			local currentTime = workspace:GetServerTimeNow()

			for playerName, lastTime in pairs(recentlyTargetedPlayers) do
				if (currentTime - lastTime) > 30 then
					recentlyTargetedPlayers[playerName] = nil
				end
			end

			local candidates = {}
			for _, player in ipairs(Players:GetPlayers()) do
				local character = player.Character
				if character and character:FindFirstChild("HumanoidRootPart") then
					local HasSombreroHat = player:GetAttribute("HasSombreroHat") == true
					local isRecentlyTargeted = recentlyTargetedPlayers[player.Name] ~= nil

					if not isRecentlyTargeted and not HasSombreroHat then
						table.insert(candidates, player)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local roachData = spawnedRoaches[math.random(1, #spawnedRoaches)]

				if roachData.Model and roachData.Model.Parent then
					recentlyTargetedPlayers[selected.Name] = currentTime
					selected:SetAttribute("HasSombreroHat", true)
					followAndAttackAnimal(roachData, selected.Character)
				end
			end
		end
	end))
end

function Mexico.OnStop()
	if not isActive then
		return
	end

	isActive = false
	isPaused = false

	activeAttacks = {}
	spawnedRoaches = {}
	recentlyTargeted = {}
	recentlyTargetedPlayers = {}

	if eventTrove then
		eventTrove:Destroy()
		eventTrove = nil
	end
end

return Mexico
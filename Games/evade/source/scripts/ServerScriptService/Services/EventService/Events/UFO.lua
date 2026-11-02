--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local AbductionBurst = Net:RemoteEvent("EventService/UFO/AbductionBurst")
local Spawned = Net:RemoteEvent("EventService/UFO/Spawned")

local UFO = {}
local isActive = false
local strikeTask: thread? = nil
local recentlyTargeted: { [string]: number } = {}

local function createUfoMarker(spawnPosition: Vector3)
	local marker = Instance.new("Part")
	marker.Size = Vector3.new(1, 1, 1)
	marker.Transparency = 1
	marker.CanCollide = false
	marker.Anchored = true
	marker.CFrame = CFrame.new(spawnPosition)
	CollectionService:AddTag(marker, "GalaxyUFO")
	marker.Parent = workspace
	return marker
end

local function applyTraitToAnimal(animal: Instance, trait: string)
	local traitsJson = animal:GetAttribute("Traits")
	local traits = {}

	if traitsJson then
		local success, decoded = pcall(function()
			return HttpService:JSONDecode(traitsJson)
		end)
		if success and type(decoded) == "table" then
			traits = decoded
		end
	end

	for _, existing in ipairs(traits) do
		if existing == trait then
			return
		end
	end

	table.insert(traits, trait)
	animal:SetAttribute("Traits", HttpService:JSONEncode(traits))
end

local function moveUfoToPosition(ufoMarker: Part, targetPosition: Vector3, duration: number)
	local tween = TweenService:Create(ufoMarker, TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { CFrame = CFrame.new(targetPosition) })
	tween:Play()
	tween.Completed:Wait()
end

local function liftAndReturnAnimal(selected: Instance, ufoMarker: Part)
	if not selected.PrimaryPart then return end

	selected:SetAttribute("ForceIdle", true)
	local originalCFrame = selected.PrimaryPart.CFrame
	local liftTarget = originalCFrame.Position + Vector3.new(0, 30, 0)

	local liftTween = TweenService:Create(selected.PrimaryPart, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { CFrame = CFrame.new(liftTarget) * (originalCFrame - originalCFrame.Position) })
	liftTween:Play()
	liftTween.Completed:Wait()

	task.wait(0.5)
	AbductionBurst:FireAllClients(selected.PrimaryPart.Position)
	applyTraitToAnimal(selected, "UFO")
	task.wait(1.5)

	local lowerTween = TweenService:Create(selected.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { CFrame = originalCFrame })
	lowerTween:Play()
	lowerTween.Completed:Wait()

	ufoMarker:SetAttribute("BeamState", "off")
	task.wait(1)
	selected:SetAttribute("ForceIdle", false)
end

local function handleUfoDeparture(ufoMarker: Part)
	local departDistance = 200
	local angle = math.random() * math.pi * 2
	local offset = Vector3.new(math.cos(angle) * departDistance, 100, math.sin(angle) * departDistance)
	local departTween = TweenService:Create(ufoMarker, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { CFrame = CFrame.new(ufoMarker.Position + offset) })
	departTween:Play()
	departTween.Completed:Connect(function()
		ufoMarker:Destroy()
	end)
end

local function findAnimalCandidates()
	local animals = CollectionService:GetTagged("Animal")
	local currentTime = workspace:GetServerTimeNow()
	local candidates = {}

	for animalName, lastTime in pairs(recentlyTargeted) do
		if (currentTime - lastTime) > 15 then
			recentlyTargeted[animalName] = nil
		end
	end

	for _, animal in ipairs(animals) do
		if animal.PrimaryPart then
			local name = animal.Name
			if not recentlyTargeted[name] then
				local hasTrait = false
				local traitsJson = animal:GetAttribute("Traits")
				if traitsJson then
					local success, decoded = pcall(function()
						return HttpService:JSONDecode(traitsJson)
					end)
					if success and type(decoded) == "table" then
						for _, trait in ipairs(decoded) do
							if trait == "UFO" then
								hasTrait = true
								break
							end
						end
					end
				end
				if not hasTrait then
					table.insert(candidates, animal)
				end
			end
		end
	end

	return candidates
end

function UFO.OnStart()
	if isActive then return end
	isActive = true
	ReplicatedStorage:SetAttribute("UFOEvent", true)

	if strikeTask then
		task.cancel(strikeTask)
	end

	strikeTask = task.spawn(function()
		while isActive do
			task.wait(math.random(6, 12))
			if not isActive then break end

			local candidates = findAnimalCandidates()
			if #candidates == 0 then continue end

			local selected = candidates[math.random(1, #candidates)]
			local pos = selected.PrimaryPart.Position
			local spawnPos = pos + Vector3.new(math.cos(math.random() * math.pi * 2) * 50, 50, math.sin(math.random() * math.pi * 2) * 50)

			local ufoMarker = createUfoMarker(spawnPos)
			Spawned:FireAllClients()
			recentlyTargeted[selected.Name] = workspace:GetServerTimeNow()

			moveUfoToPosition(ufoMarker, pos + Vector3.new(0, 50, 0), 1.5)

			local connection
			connection = RunService.Heartbeat:Connect(function()
				if selected and selected.PrimaryPart and ufoMarker and ufoMarker.Parent then
					local p = selected.PrimaryPart.Position
					ufoMarker.CFrame = CFrame.new(p.X, ufoMarker.Position.Y, p.Z)
				else
					if connection then
						connection:Disconnect()
					end
				end
			end)

			ufoMarker:SetAttribute("BeamState", "down")
			liftAndReturnAnimal(selected, ufoMarker)
			if connection then connection:Disconnect() end
			handleUfoDeparture(ufoMarker)
		end
	end)
end

function UFO.OnStop()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("UFOEvent", false)

	if strikeTask then
		task.cancel(strikeTask)
		strikeTask = nil
	end

	recentlyTargeted = {}

	for _, marker in CollectionService:GetTagged("GalaxyUFO") do
		marker:Destroy()
	end
end

return UFO

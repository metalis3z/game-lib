--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local Focus = Net:RemoteEvent("EventService/Brazil/Focus")
local Burst = Net:RemoteEvent("EventService/Brazil/Burst")

local Brazil = {}
local isActive = false
local eventTrove = Trove.new()
local recentlyTargeted: {[string]: number} = {}
local lightPart: Part? = nil
local currentTween: Tween? = nil
local trackedAnimal: Model? = nil
local trackingConnection: RBXScriptConnection? = nil
local isTargetingAnimal = false

local BURST_GROW_DURATION = 2.25
local LIGHT_SPEED = 50
local MapFloor = workspace.Events.Brazil.MapFloor

local function getRandomPosition(): Vector3
	local randomX = MapFloor.Position.X + (math.random() - 0.5) * MapFloor.Size.X
	local randomZ = MapFloor.Position.Z + (math.random() - 0.5) * MapFloor.Size.Z
	return Vector3.new(randomX, MapFloor.Position.Y, randomZ)
end

local function createLightPart(): Part
	local part = Instance.new("Part")
	part.Name = "BrazilLight"
	part.Size = Vector3.new(4, 20, 4)
	part.Transparency = 1
	part.CanCollide = false
	part.Anchored = true
	part.CFrame = CFrame.new(getRandomPosition())
	CollectionService:AddTag(part, "BrazilHitbox")
	part.Parent = workspace
	eventTrove:Add(part)
	return part
end

local function tweenLightToPosition(position: Vector3): Tween?
	if currentTween then
		currentTween:Cancel()
	end
	if not lightPart then return nil end
	local distance = (lightPart.Position - position).Magnitude
	local duration = distance / LIGHT_SPEED
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
	currentTween = TweenService:Create(lightPart, tweenInfo, {CFrame = CFrame.new(position)})
	currentTween:Play()
	return currentTween
end

local function stopTrackingAnimal()
	if trackingConnection then
		trackingConnection:Disconnect()
		trackingConnection = nil
	end
	trackedAnimal = nil
end

local function trackAnimal(animal: Model)
	stopTrackingAnimal()
	trackedAnimal = animal
	trackingConnection = eventTrove:Connect(RunService.Heartbeat, function()
		if not trackedAnimal or not trackedAnimal.PrimaryPart or not lightPart then
			stopTrackingAnimal()
			return
		end
		local animalPos = trackedAnimal.PrimaryPart.Position
		lightPart.CFrame = CFrame.new(animalPos.X, lightPart.Position.Y, animalPos.Z)
	end)
end

local function decodeTraits(json: string?): {string}
	if not json then
		return {}
	end
	local s, data = pcall(HttpService.JSONDecode, HttpService, json)
	if s and typeof(data) == "table" then
		return data :: {string}
	end
	return {}
end

local function encodeTraits(tbl: {string}): string
	local s, result = pcall(HttpService.JSONEncode, HttpService, tbl)
	if s and typeof(result) == "string" then
		return result
	end
	return "[]"
end

local function hasTrait(traits: {string}, traitName: string): boolean
	for _, t in traits do
		if t == traitName then
			return true
		end
	end
	return false
end

local function addTraitIfMissing(animal: Model, traitName: string)
	local traits = decodeTraits(animal:GetAttribute("Traits"))
	if not hasTrait(traits, traitName) then
		table.insert(traits, traitName)
		animal:SetAttribute("Traits", encodeTraits(traits))
	end
end

local function continuousRandomMovement()
	eventTrove:Add(task.spawn(function()
		while isActive do
			if not isTargetingAnimal then
				local randomPos = getRandomPosition()
				local tween = tweenLightToPosition(randomPos)
				if tween then
					tween.Completed:Wait()
				end
			else
				task.wait(0.1)
			end
			if not isActive then break end
		end
	end))
end
local function resetState()
	lightPart = nil
	currentTween = nil
	trackedAnimal = nil
	trackingConnection = nil
	isTargetingAnimal = false
	recentlyTargeted = {}
end

local function animalCheckLoop()
	eventTrove:Add(task.spawn(function()
		while isActive do
			task.wait(math.random(7, 12))
			if not isActive or not lightPart then break end

			local roadAnimals = CollectionService:GetTagged("Animal")
			local now = workspace:GetServerTimeNow()

			for name, last in recentlyTargeted do
				if now - last > 20 then
					recentlyTargeted[name] = nil
				end
			end

			local selected: Model? = nil
			local shortestDistance = math.huge

			for _, animal in ipairs(roadAnimals) do
				if animal.PrimaryPart then
					local skip = recentlyTargeted[animal.Name] ~= nil
					local traits = decodeTraits(animal:GetAttribute("Traits"))

					if not skip and not hasTrait(traits, "Brazil") then
						local dist = (lightPart.Position - animal.PrimaryPart.Position).Magnitude
						if dist < shortestDistance then
							shortestDistance = dist
							selected = animal
						end
					end
				end
			end

			if selected and selected.PrimaryPart then
				if not SharedEventUtils.isPointInCarpet(selected.PrimaryPart.Position) then
					isTargetingAnimal = false
					continue
				end

				isTargetingAnimal = true

				local pos = selected.PrimaryPart.Position
				local tween = tweenLightToPosition(Vector3.new(pos.X, lightPart.Position.Y, pos.Z))

				if tween then tween.Completed:Wait() end

				trackAnimal(selected)
				task.wait(0.5)

				now = workspace:GetServerTimeNow()

				if lightPart then
					lightPart:SetAttribute("Focused", now)
					lightPart:SetAttribute("BurstTime", now + BURST_GROW_DURATION)
				end

				Focus:FireAllClients(selected.Name)
				recentlyTargeted[selected.Name] = now

				task.wait(BURST_GROW_DURATION)

				stopTrackingAnimal()
				Burst:FireAllClients(selected.Name)

				if lightPart then
					lightPart:SetAttribute("Focused", nil)
					lightPart:SetAttribute("BurstTime", nil)
				end

				local targetAnimal = selected
				task.delay(0.1, function()
					if not targetAnimal or not targetAnimal.Parent then return end
					addTraitIfMissing(targetAnimal, "Brazil")
				end)

				isTargetingAnimal = false
			end
		end
	end))
end

function Brazil.OnStart(data)
	if isActive then return end
	isActive = true

	eventTrove = Trove.new()

	lightPart = createLightPart()
	continuousRandomMovement()
	animalCheckLoop()

	ReplicatedStorage:SetAttribute("BrazilEvent", true)

	local startTime = data.startedAt :: number
	local now = workspace:GetServerTimeNow()
	local attributeDelay = (startTime + 5) - now

	task.delay(math.max(0, attributeDelay), function()
		if isActive then
			ReplicatedStorage:SetAttribute("BrazilEventMusic", true)
		end
	end)
end

function Brazil.OnStop()
	if not isActive then return end
	isActive = false

	ReplicatedStorage:SetAttribute("BrazilEvent", false)
	ReplicatedStorage:SetAttribute("BrazilEventMusic", false)

	if currentTween then
		currentTween:Cancel()
		currentTween = nil
	end

	trackedAnimal = nil
	trackingConnection = nil
	isTargetingAnimal = false

	eventTrove:Clean()

	lightPart = nil
	recentlyTargeted = {}
end

function Brazil.IsRunning(): boolean
	return isActive
end

return Brazil
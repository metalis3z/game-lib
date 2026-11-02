--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)

local Burst = Net:RemoteEvent("EventService/Meowl/Burst")

local Meowl = {}

local isActive = false
local attackTask: thread?

local sessionTrove: any?
local attackWorkersTrove: any?

local recentlyTargeted: { [string]: number } = {}
local spawnedMeowls: { BasePart } = {}
local meowlsFolder: Folder?
local originalPositions: { [BasePart]: CFrame } = {}

local function resetState()
	attackTask = nil
	recentlyTargeted = {}
	spawnedMeowls = {}
	meowlsFolder = nil
	originalPositions = {}
	attackWorkersTrove = nil
	sessionTrove = nil
end

local function tryAddToTrove(trove: any?, object: any, customCleanupMethod: any?)
	if not trove then
		return object
	end

	local ok, result = pcall(function()
		if customCleanupMethod ~= nil then
			return trove:Add(object, customCleanupMethod)
		end
		return trove:Add(object)
	end)

	if not ok then
		warn("[Meowl] Failed to add object to trove:", result)
	end

	return object
end

local function createFolder(): Folder
	local folder = Instance.new("Folder")
	folder.Name = "Meowls"
	folder.Parent = workspace
	return folder
end

local function decode(data: string?): { any }
	if not data then
		return {}
	end

	local ok, decoded = pcall(function()
		return HttpService:JSONDecode(data)
	end)

	return ok and type(decoded) == "table" and decoded or {}
end

local function encode(tbl: { any }): string
	return HttpService:JSONEncode(tbl)
end

local function hasTrait(traits: { any }, name: string): boolean
	for _, v in ipairs(traits) do
		if v == name then
			return true
		end
	end
	return false
end

local function getAnimals(): { Model }
	return CollectionService:GetTagged("Animal")
end

local function spawnMeowls()
	local folder = script:FindFirstChild("Meowls")
	if not folder then
		warn("[Meowl] spawnMeowls: no 'Meowls' folder found under script!")
		return
	end

	for _, part in ipairs(folder:GetChildren()) do
		if part:IsA("BasePart") then
			local clone = part:Clone()
			clone.Parent = meowlsFolder
			CollectionService:AddTag(clone, "MeowlEventMeowl")
			clone:SetAttribute("Flying", false)
			clone:SetAttribute("Attack", false)

			originalPositions[clone] = clone.CFrame
			table.insert(spawnedMeowls, clone)
		end
	end
end

local function flyToTarget(meowl: BasePart, target: Model): boolean
	if not meowl or not meowl.Parent then
		warn("[Meowl] flyToTarget: meowl is nil or has no parent before loop")
		return false
	end

	if not target or not target.Parent or not target.PrimaryPart then
		warn("[Meowl] flyToTarget: target invalid before loop")
		return false
	end

	meowl:SetAttribute("Flying", true)
	local speed = 50

	while isActive and meowl.Parent and target and target.Parent and target.PrimaryPart do
		local targetPos = target.PrimaryPart.Position + Vector3.new(0, 10, 0)
		local currentPos = meowl.Position
		local distance = (targetPos - currentPos).Magnitude

		if distance < 5 then
			return true
		end

		local dir = (targetPos - currentPos).Unit
		local move = math.min(speed * RunService.Heartbeat:Wait(), distance)
		local newPos = currentPos + dir * move
		meowl.CFrame = CFrame.new(newPos, newPos + dir)
	end

	return false
end

local function flyBack(meowl: BasePart)
	if not meowl or not meowl.Parent then
		warn("[Meowl] flyBack: meowl is nil or unparented, skipping")
		return
	end

	local original = originalPositions[meowl]
	if not original then
		warn("[Meowl] flyBack: no originalPosition found for meowl:", meowl.Name)
		meowl:SetAttribute("Flying", false)
		return
	end

	local start = meowl.Position
	local target = original.Position
	local distance = (target - start).Magnitude
	local speed = 50
	local duration = distance / speed
	local startTime = os.clock()

	while os.clock() - startTime < duration and isActive and meowl.Parent do
		local elapsed = os.clock() - startTime
		local alpha = elapsed / duration
		local currentPos = start:Lerp(target, alpha)

		local lookDir = target - currentPos
		if lookDir.Magnitude > 0 then
			meowl.CFrame = CFrame.new(currentPos, currentPos + lookDir.Unit)
		else
			meowl.CFrame = CFrame.new(currentPos)
		end

		task.wait()
	end

	if meowl and meowl.Parent then
		meowl.CFrame = original
		meowl:SetAttribute("Flying", false)
	else
		warn("[Meowl] flyBack: meowl was destroyed before return finished")
	end
end

local function giveTrait(animal: Model, name: string)
	local traits = decode(animal:GetAttribute("Traits"))
	if not hasTrait(traits, name) then
		table.insert(traits, name)
		animal:SetAttribute("Traits", encode(traits))
	end
end

local function selectTarget(): (Model?, BasePart?)
	local animals = getAnimals()
	local now = workspace:GetServerTimeNow()

	for k, t in pairs(recentlyTargeted) do
		if now - t > 20 then
			recentlyTargeted[k] = nil
		end
	end

	local candidates = {}
	for _, animal in ipairs(animals) do
		if animal.PrimaryPart then
			local recent = recentlyTargeted[animal.Name]
			local has = hasTrait(decode(animal:GetAttribute("Traits")), "Meowl")

			if not recent and not has then
				table.insert(candidates, animal)
			end
		end
	end

	if #candidates == 0 then
		return nil, nil
	end

	if #spawnedMeowls == 0 then
		return nil, nil
	end

	local availableMeowls = {}
	for _, meowl in ipairs(spawnedMeowls) do
		if meowl.Parent and not meowl:GetAttribute("Flying") then
			table.insert(availableMeowls, meowl)
		end
	end

	if #availableMeowls == 0 then
		return nil, nil
	end

	local target = candidates[math.random(1, #candidates)]
	local meowl = availableMeowls[math.random(1, #availableMeowls)]

	return target, meowl
end

local function attack()
	while isActive do
		task.wait(math.random(5, 10))

		if not isActive then
			break
		end

		if #spawnedMeowls == 0 then
			break
		end

		local animal, meowl = selectTarget()
		if not animal or not meowl or not meowl.Parent then
			continue
		end

		local worker = task.spawn(function()
			local reached = flyToTarget(meowl, animal)

			if reached and animal and animal.Parent then
				meowl:SetAttribute("Attack", true)
				Burst:FireAllClients(animal.Name)
				giveTrait(animal, "Meowl")

				task.wait(0.1)

				if meowl and meowl.Parent then
					meowl:SetAttribute("Attack", false)
				end

				task.wait(0.5)

				if meowl and meowl.Parent then
					flyBack(meowl)
				end
			else
				if meowl and meowl.Parent then
					flyBack(meowl)
				end
			end
		end)

		tryAddToTrove(attackWorkersTrove, worker)
		recentlyTargeted[animal.Name] = workspace:GetServerTimeNow()
	end
end

function Meowl.OnStart()
	if isActive then
		warn("[Meowl] OnStart called but already active!")
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("MeowlEvent", true)

	sessionTrove = Trove.new()
	attackWorkersTrove = sessionTrove:Extend()

	tryAddToTrove(sessionTrove, function()
		isActive = false
		ReplicatedStorage:SetAttribute("MeowlEvent", false)
	end)

	meowlsFolder = createFolder()
	tryAddToTrove(sessionTrove, meowlsFolder)

	spawnMeowls()

	attackTask = task.spawn(attack)
	tryAddToTrove(sessionTrove, attackTask)

	tryAddToTrove(sessionTrove, function()
		resetState()
	end)
end

function Meowl.OnStop()
	if not isActive then
		warn("[Meowl] OnStop called but not active!")
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("MeowlEvent", false)

	if sessionTrove then
		sessionTrove:Clean()
	else
		resetState()
	end
end

function Meowl.IsActive(): boolean
	return isActive
end

function Meowl.GetMeowls(): { BasePart }
	return spawnedMeowls
end

return Meowl
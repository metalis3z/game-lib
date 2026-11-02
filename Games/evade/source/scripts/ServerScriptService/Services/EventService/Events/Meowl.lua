--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/Meowl/Burst")

local Meowl = {}
local isActive = false
local attackTask: thread?
local recentlyTargeted: { [string]: number } = {}
local spawnedMeowls: { BasePart } = {}
local meowlsFolder: Folder?
local originalPositions: { [BasePart]: CFrame } = {}

local function createFolder(): Folder
	local folder = Instance.new("Folder")
	folder.Name = "Meowls"
	folder.Parent = workspace
	return folder
end

local function decode(data: string?): { any }
	if not data then return {} end
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
	if not folder then return end
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
	if not meowl or not meowl.Parent or not target or not target.Parent or not target.PrimaryPart then return false end
	meowl:SetAttribute("Flying", true)
	local speed = 30
	while isActive and meowl.Parent and target and target.Parent and target.PrimaryPart do
		local targetPos = target.PrimaryPart.Position + Vector3.new(0, 10, 0)
		local currentPos = meowl.Position
		local distance = (targetPos - currentPos).Magnitude
		if distance < 5 then return true end
		local dir = (targetPos - currentPos).Unit
		local move = math.min(speed * RunService.Heartbeat:Wait(), distance)
		meowl.CFrame = CFrame.new(currentPos + dir * move, currentPos + dir * move + dir)
	end
	return false
end

local function flyBack(meowl: BasePart)
	if not meowl or not meowl.Parent then return end
	local original = originalPositions[meowl]
	if not original then
		meowl:SetAttribute("Flying", false)
		return
	end
	local start = meowl.Position
	local target = original.Position
	local distance = (target - start).Magnitude
	local speed = 30
	local duration = distance / speed
	local startTime = os.clock()
	while os.clock() - startTime < duration and isActive and meowl.Parent do
		local alpha = (os.clock() - startTime) / duration
		local currentPos = start:Lerp(target, alpha)
		local dir = (target - currentPos).Unit
		meowl.CFrame = CFrame.new(currentPos, currentPos + dir)
		task.wait()
	end
	if meowl and meowl.Parent then
		meowl.CFrame = original
		meowl:SetAttribute("Flying", false)
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
	local candidates = {}
	local now = workspace:GetServerTimeNow()
	for k, t in pairs(recentlyTargeted) do
		if now - t > 20 then
			recentlyTargeted[k] = nil
		end
	end
	for _, a in ipairs(animals) do
		if a.PrimaryPart then
			local recent = recentlyTargeted[a.Name]
			local has = hasTrait(decode(a:GetAttribute("Traits")), "Meowl")
			if not recent and not has then
				table.insert(candidates, a)
			end
		end
	end
	if #candidates == 0 or #spawnedMeowls == 0 then return nil, nil end
	local target = candidates[math.random(1, #candidates)]
	local meowl = spawnedMeowls[math.random(1, #spawnedMeowls)]
	return target, meowl
end

local function attack()
	while isActive do
		task.wait(math.random(5, 10))
		if not isActive or #spawnedMeowls == 0 then break end
		local animal, meowl = selectTarget()
		if not animal or not meowl or not meowl.Parent then continue end
		task.spawn(function()
			local reached = flyToTarget(meowl, animal)
			if reached and animal and animal.Parent then
				meowl:SetAttribute("Attack", true)
				Burst:FireAllClients(animal.Name)
				giveTrait(animal, "Meowl")
				task.wait(0.1)
				meowl:SetAttribute("Attack", false)
				task.wait(0.5)
				flyBack(meowl)
			end
		end)
		recentlyTargeted[animal.Name] = workspace:GetServerTimeNow()
	end
end

function Meowl.OnStart()
	if isActive then return end
	isActive = true
	ReplicatedStorage:SetAttribute("MeowlEvent", true)
	meowlsFolder = createFolder()
	spawnMeowls()
	if attackTask then task.cancel(attackTask) end
	attackTask = task.spawn(attack)
end

function Meowl.OnStop()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("MeowlEvent", false)
	if attackTask then
		task.cancel(attackTask)
		attackTask = nil
	end
	if meowlsFolder and meowlsFolder.Parent then
		meowlsFolder:Destroy()
	end
	spawnedMeowls = {}
	originalPositions = {}
	recentlyTargeted = {}
	meowlsFolder = nil
end

function Meowl.IsActive(): boolean
	return isActive
end

function Meowl.GetMeowls(): { BasePart }
	return spawnedMeowls
end

return Meowl

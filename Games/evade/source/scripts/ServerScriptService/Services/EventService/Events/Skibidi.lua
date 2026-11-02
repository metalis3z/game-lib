--!native
-- Skibidi - 1:1 recreation by lordjaii

local Skibidi = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")

local Net = require(ReplicatedStorage.Packages.Net)
local EventService = require(ServerScriptService.Services.EventService)

local eventName = script.Name
local animalTag = "Animal"
local eventDuration = 300
local minWait = 60
local maxWait = 120
local cooldown = 30
local burstChance = 0.010
local traitName = "Skibidi"

local remotes = {
	Burst = Net:RemoteEvent(("EventService/%s/Burst"):format(eventName)),
}

local isActive = false
local traitTask = nil
local burstTask = nil
local eventSeed = 0
local recentlyTargeted = {}
local monitorConnection = nil

local function _hasSkibidiTrait(animal)
	local currentTraitsJson = animal:GetAttribute("Traits")
	if not currentTraitsJson then return false end

	local success, decoded = pcall(function()
		return HttpService:JSONDecode(currentTraitsJson)
	end)

	if success and type(decoded) == "table" then
		for _, trait in ipairs(decoded) do
			if trait == traitName then
				return true
			end
		end
	end

	return false
end

local function _giveSkibidiTrait(animal)
	if not animal or not animal.Parent then return end

	local currentTraitsJson = animal:GetAttribute("Traits")
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
		if trait == traitName then
			return
		end
	end

	table.insert(currentTraits, traitName)
	animal:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
	
	remotes.Burst:FireAllClients(animal.Name)
end

local function _startTraitLoop()
	if traitTask then
		task.cancel(traitTask)
	end
	recentlyTargeted = {}

	traitTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(minWait, maxWait)
			task.wait(waitTime)

			if not isActive then break end

			local roadAnimals = CollectionService:GetTagged(animalTag)
			local currentTime = Workspace:GetServerTimeNow()

			for animalName, lastTime in pairs(recentlyTargeted) do
				if (currentTime - lastTime) > cooldown then
					recentlyTargeted[animalName] = nil
				end
			end

			local candidates = {}
			for _, animal in ipairs(roadAnimals) do
				if animal.PrimaryPart then
					local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
					local hasTrait = _hasSkibidiTrait(animal)

					if not isRecentlyTargeted and not hasTrait then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local now = Workspace:GetServerTimeNow()

				recentlyTargeted[selected.Name] = now
				
				task.delay(0.5, function()
					_giveSkibidiTrait(selected)
				end)
			end
		end
	end)
end

local function _startBurstLoop()
	burstTask = task.spawn(function()
		while isActive do
			task.wait(1)
			
			local animals = CollectionService:GetTagged(animalTag)
			
			for _, animal in ipairs(animals) do
				if animal.PrimaryPart then
					local hasTrait = _hasSkibidiTrait(animal)
					
					if not hasTrait then
						if math.random() < burstChance then
							remotes.Burst:FireAllClients(animal.Name)
							
							task.delay(0.1, function()
								_giveSkibidiTrait(animal)
							end)
						end
					end
				end
			end
		end
	end)
end

local function _checkForSkibidiToilet()
	local animals = CollectionService:GetTagged(animalTag)
	
	for _, animal in ipairs(animals) do
		if animal and animal:GetAttribute("Index") == "Skibidi Toilet" then
			return true
		end
	end
	
	return false
end

local function _autoStartEvent()
	pcall(function()
		EventService:ExecuteEvent(eventName, eventDuration)
	end)
end

local function _startMonitoring()
	monitorConnection = CollectionService:GetInstanceAddedSignal(animalTag):Connect(function(animal)
		if animal and animal:GetAttribute("Index") == "Skibidi Toilet" then
			if not isActive then
				task.delay(0.5, _autoStartEvent)
			end
		end
	end)
end

local function _stopMonitoring()
	if monitorConnection then
		monitorConnection:Disconnect()
		monitorConnection = nil
	end
end

function Skibidi.OnStart(eventData)
	isActive = true
	print("skibidi event starting...")
	
	eventSeed = math.floor(tick() * 1000)
	ReplicatedStorage:SetAttribute("SkibidiEventSeed", eventSeed)
	ReplicatedStorage:SetAttribute("SkibidiEvent", true)
	
	_startTraitLoop()
	_startBurstLoop()
end

function Skibidi.OnStop()
	isActive = false
	print("skibidi event stops...")
	
	ReplicatedStorage:SetAttribute("SkibidiEvent", nil)
	ReplicatedStorage:SetAttribute("SkibidiEventSeed", nil)
	
	if traitTask then
		task.cancel(traitTask)
		traitTask = nil
	end
	
	if burstTask then
		task.cancel(burstTask)
		burstTask = nil
	end
	
	table.clear(recentlyTargeted)
end

function Skibidi.OnLoad()
	print("skibidi event 1;1 loaded successfully - lordjaii's")
	_startMonitoring()
end

function Skibidi.IsActive()
	return isActive
end

function Skibidi:TriggerBurst(animalName)
	if not isActive then return end
	remotes.Burst:FireAllClients(animalName)
end

return Skibidi
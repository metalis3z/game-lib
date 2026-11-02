local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local Shoot = Net:RemoteEvent("EventService/GUIGUI/Shoot")

local Bzh = {}

local CHANCE = 20 -- 1 chance sur CHANCE par tick — modifie cette valeur

local isActive = false
local sTask = nil
local startTime = nil
local recentlyTargeted = {}

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://106612375078537"
sound.Looped = true
sound.Volume = 0.3
sound.Name = "GUIGUISound"
sound.Parent = SoundService

local function hasTraitGuigui(animal)
	if not animal or not animal.Parent then return false end
	local json = animal:GetAttribute("Traits")
	if not json then return false end
	local ok, traits = pcall(function() return HttpService:JSONDecode(json) end)
	if not ok or type(traits) ~= "table" then return false end
	for _, t in ipairs(traits) do
		if t == "GUIGUI" then return true end
	end
	return false
end

local function pick()
	local roadAnimals = CollectionService:GetTagged("Animal")
	local movingAnimalsFolder = workspace:FindFirstChild("MovingAnimals")
	local currentTime = workspace:GetServerTimeNow()

	for animalId, lastTime in pairs(recentlyTargeted) do
		if (currentTime - lastTime) > 30 then
			recentlyTargeted[animalId] = nil
		end
	end

	local candidates = {}
	for _, animal in ipairs(roadAnimals) do
		if animal.Parent == movingAnimalsFolder and animal.PrimaryPart then
			if not recentlyTargeted[animal.Name] and not hasTraitGuigui(animal) then
				table.insert(candidates, animal)
			end
		end
	end

	if #candidates == 0 then return nil end
	return candidates[math.random(1, #candidates)]
end

local function event()
	if sTask then task.cancel(sTask) end

	sTask = task.spawn(function()
		task.wait(5)

		while isActive do
			task.wait(math.random(6, 16))
			if not isActive then break end

			-- 1 chance sur CHANCE de declencher
			if math.random(1, CHANCE) ~= 1 then continue end

			local selected = pick()
			if not selected then continue end

			local now = workspace:GetServerTimeNow()
			Shoot:FireAllClients(selected.Name, now)
			recentlyTargeted[selected.Name] = now

			-- Appliquer le trait apres l'animation (2.5s)
			task.delay(2.5, function()
				if not selected or not selected.Parent then return end
				if hasTraitGuigui(selected) then return end
				AnimalService:AddTraits(selected, {"GUIGUI"})
			end)
		end
	end)
end

function Bzh.OnStart()
	if isActive then return end
	isActive = true
	startTime = workspace:GetServerTimeNow()
	ReplicatedStorage:SetAttribute("GUIGUIEvent", true)
	if not sound.IsPlaying then sound:Play() end
	event()
end

function Bzh.OnStop()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("GUIGUIEvent", false)
	if sound.IsPlaying then sound:Stop() end
	if sTask then
		task.cancel(sTask)
		sTask = nil
	end
	table.clear(recentlyTargeted)
end

return Bzh
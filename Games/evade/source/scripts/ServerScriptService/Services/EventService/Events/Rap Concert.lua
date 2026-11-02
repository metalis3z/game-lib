local RapConcert = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local SoundService = game:GetService("SoundService")
local Net = require(ReplicatedStorage.Packages.Net)

local Animals = require(ReplicatedStorage.Datas.Animals)
local Shoot = Net:RemoteEvent("EventService/Rap Concert/Shoot")

local Targeted = {}
local shootTask = {}
local isActive = false

local YourRapConcertSongRoyy = "rbxassetid://83974889930577" 

local TuffMusic = nil

local function playTuffMusic()
	if TuffMusic then
		TuffMusic:Stop()
		TuffMusic:Destroy()
		TuffMusic = nil
	end

	TuffMusic = Instance.new("Sound")
	TuffMusic.SoundId = YourRapConcertSongRoyy
	TuffMusic.Looped = true          
	TuffMusic.Volume = 0.5           
	TuffMusic.Parent = SoundService 
	TuffMusic:Play()
end

local function stopTuffMusic()
	if TuffMusic then
		TuffMusic:Stop()
		TuffMusic:Destroy()
		TuffMusic = nil
	end
end

function has(animal)
	if not animal or not animal.Parent then return false end
	local traitsJson = animal:GetAttribute("Traits")
	if not traitsJson then return false end
	local success, decoded = pcall(function()
		return HttpService:JSONDecode(traitsJson)
	end)
	if not success or type(decoded) ~= "table" then return false end
	for _, trait in ipairs(decoded) do
		if trait == "Disco" then return true end
	end
	return false
end

function apply(animal)
	if not animal or not animal.Parent then
		return
	end
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
	for _, trait in ipairs(traits) do
		if trait == "Disco" then
			return
		end
	end
	table.insert(traits, "Disco")
	local encoded = HttpService:JSONEncode(traits)
	animal:SetAttribute("Traits", encoded)
end

function pick()
	local roadAnimals = CollectionService:GetTagged("Animal")
	local movingAnimalsFolder = workspace:FindFirstChild("MovingAnimals")
	if not movingAnimalsFolder then
		return nil
	end

	local currentTime = workspace:GetServerTimeNow()
	for animalName, lastTime in pairs(Targeted) do
		if (currentTime - lastTime) > 10 then
			Targeted[animalName] = nil
		end
	end

	local candidates = {}
	for _, animal in ipairs(roadAnimals) do
		if animal.Parent == movingAnimalsFolder and animal.PrimaryPart then
			if not Targeted[animal.Name] and not has(animal) then
				table.insert(candidates, animal)
			end
		end
	end

	if #candidates == 0 then
		return nil
	end
	return candidates[math.random(1, #candidates)]
end

function hit(player, rigIndex, animalName, hitTime)
	if not isActive then
		return
	end
	local movingAnimalsFolder = workspace:FindFirstChild("MovingAnimals")
	if not movingAnimalsFolder then
		return
	end
	local targetAnimal = movingAnimalsFolder:FindFirstChild(animalName)
	if targetAnimal then
		apply(targetAnimal)
	end
end

function handle()
	Shoot.OnServerEvent:Connect(function(player, rigIndex, animalName, hitTime)
		hit(player, rigIndex, animalName, hitTime)
	end)
end
handle()

function event()
	if next(shootTask) ~= nil then
		task.cancel(shootTask)
	end
	shootTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(1.5, 5)
			task.wait(waitTime)
			local targetAnimal = pick()
			if targetAnimal then
				print("target animal exists: ", targetAnimal)
				local rigIndex = math.random(1, 3)
				local currentTime = workspace:GetServerTimeNow()
				Shoot:FireAllClients(rigIndex, targetAnimal.Name, currentTime + 3)
				Targeted[targetAnimal.Name] = currentTime
				for i, plr in ipairs(Players:GetPlayers()) do
					hit(plr, rigIndex, targetAnimal.Name, workspace:GetServerTimeNow())
				end
			end
		end
	end)
end

function RapConcert.OnStart()
	if isActive then
		return
	end
	isActive = true
	ReplicatedStorage:SetAttribute("RapConcertEvent", true)

	playTuffMusic()

	event()
end

function RapConcert.OnStop()
	if not isActive then
		return
	end
	isActive = false
	ReplicatedStorage:SetAttribute("RapConcertEvent", false)

	if shootTask then
		task.cancel(shootTask)
		shootTask = nil
	end

	stopTuffMusic()
end

return RapConcert
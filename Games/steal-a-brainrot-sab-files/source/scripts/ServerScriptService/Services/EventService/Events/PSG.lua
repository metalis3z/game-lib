-- Concert Event - Server Script
-- Gestion des tirs, application du trait PSG

local PSG = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)
local Shoot = Net:RemoteEvent("EventService/Concert/Shoot")

local isActive = false
local targeted = {}
local shootTask = nil

-- ═══════════════════════════════════════════════
-- VÉRIFIE SI UN ANIMAL A DÉJÀ LE TRAIT PSG
-- ═══════════════════════════════════════════════
local function has(animal)
	if not animal or not animal.Parent then return false end
	local traitsJson = animal:GetAttribute("Traits")
	if not traitsJson then return false end
	local success, decoded = pcall(function()
		return HttpService:JSONDecode(traitsJson)
	end)
	if not success or type(decoded) ~= "table" then return false end
	for _, trait in ipairs(decoded) do
		if trait == "PSG" then return true end
	end
	return false
end

-- ═══════════════════════════════════════════════
-- APPLIQUE LE TRAIT PSG À UN ANIMAL
-- ═══════════════════════════════════════════════
local function apply(animal)
	if not animal or not animal.Parent then return end
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
		if trait == "PSG" then return end
	end
	table.insert(traits, "PSG")
	local encoded = HttpService:JSONEncode(traits)
	animal:SetAttribute("Traits", encoded)
end

-- ═══════════════════════════════════════════════
-- SÉLECTIONNE UN ANIMAL CIBLE ALÉATOIRE
-- ═══════════════════════════════════════════════
local function pick()
	local roadAnimals = CollectionService:GetTagged("Animal")
	local movingAnimalsFolder = workspace:FindFirstChild("MovingAnimals")
	if not movingAnimalsFolder then return nil end

	local currentTime = workspace:GetServerTimeNow()

	-- Nettoie les animaux ciblés depuis plus de 10 secondes
	for animalName, lastTime in pairs(targeted) do
		if (currentTime - lastTime) > 10 then
			targeted[animalName] = nil
		end
	end

	local candidates = {}
	for _, animal in ipairs(roadAnimals) do
		if animal.Parent == movingAnimalsFolder and animal.PrimaryPart then
			if not targeted[animal.Name] and not has(animal) then
				table.insert(candidates, animal)
			end
		end
	end

	if #candidates == 0 then return nil end
	return candidates[math.random(1, #candidates)]
end

-- ═══════════════════════════════════════════════
-- TRAITEMENT D'UN HIT REÇU DU CLIENT
-- ═══════════════════════════════════════════════
local function hit(player, rigIndex, animalName, hitTime)
	if not isActive then return end
	local movingAnimalsFolder = workspace:FindFirstChild("MovingAnimals")
	if not movingAnimalsFolder then return end
	local targetAnimal = movingAnimalsFolder:FindFirstChild(animalName)
	if targetAnimal then
		apply(targetAnimal)
	end
end

-- ═══════════════════════════════════════════════
-- CONNEXION DE L'ÉVÉNEMENT SERVEUR
-- ═══════════════════════════════════════════════
Shoot.OnServerEvent:Connect(function(plr, ind, brainrotName, hTime)
	hit(plr, ind, brainrotName, hTime)
end)

-- ═══════════════════════════════════════════════
-- BOUCLE DE TIR AUTOMATIQUE
-- ═══════════════════════════════════════════════
local function startShootLoop()
	shootTask = task.spawn(function()
		while isActive do
			local waitTime = math.random() * 3.5 + 1.5 -- Entre 1.5 et 5 secondes
			task.wait(waitTime)
			if not isActive then break end
			local targetAnimal = pick()
			if targetAnimal then
				local rigIndex = math.random(1, 3)
				local currentTime = workspace:GetServerTimeNow()
				Shoot:FireAllClients(rigIndex, targetAnimal.Name, currentTime + 3)
				targeted[targetAnimal.Name] = currentTime
			end
		end
	end)
end

-- ═══════════════════════════════════════════════
-- DÉMARRAGE DE L'ÉVÉNEMENT
-- ═══════════════════════════════════════════════
function PSG.OnStart()
	if isActive then return end
	isActive = true
	ReplicatedStorage:SetAttribute("PSGEvent", true)
	startShootLoop()
end

-- ═══════════════════════════════════════════════
-- ARRÊT DE L'ÉVÉNEMENT
-- ═══════════════════════════════════════════════
function PSG.OnStop()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("PSGEvent", false)
	if shootTask then
		task.cancel(shootTask)
		shootTask = nil
	end
	targeted = {}
end

return PSG
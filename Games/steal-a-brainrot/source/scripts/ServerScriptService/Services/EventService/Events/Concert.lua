local Concert = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Shoot = Net:RemoteEvent("EventService/Concert/Shoot")

local isActive = false
local shootTask = nil
local targeted = {}

-- =========================
-- TRAIT CHECK
-- =========================

local function hasDisco(animal)
	if not animal or not animal.Parent then
		return true  -- considère comme déjà Disco pour éviter les erreurs
	end

	local traitsJson = animal:GetAttribute("Traits")
	if not traitsJson then
		return false
	end

	local success, decoded = pcall(function()
		return HttpService:JSONDecode(traitsJson)
	end)

	if not success or type(decoded) ~= "table" then
		return false
	end

	for _, trait in ipairs(decoded) do
		if trait == "Disco" then
			return true
		end
	end

	return false
end

local function applyDisco(animal)
	if not animal or not animal.Parent then
		return
	end

	if hasDisco(animal) then
		return  -- déjà présent
	end

	-- Récupère les traits actuels
	local traits = {}
	local json = animal:GetAttribute("Traits")

	if json then
		local success, decoded = pcall(function()
			return HttpService:JSONDecode(json)
		end)
		if success and type(decoded) == "table" then
			traits = decoded
		end
	end

	-- Ajoute "Disco" s'il n'est pas déjà là (double vérification)
	local alreadyHas = false
	for _, t in ipairs(traits) do
		if t == "Disco" then
			alreadyHas = true
			break
		end
	end

	if not alreadyHas then
		table.insert(traits, "Disco")
		animal:SetAttribute("Traits", HttpService:JSONEncode(traits))
	end
end

-- =========================
-- PICK
-- =========================

local function pick()
	local movingAnimalsFolder = workspace:FindFirstChild("MovingAnimals")
	if not movingAnimalsFolder then
		return nil
	end

	local candidates = {}

	for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
		if animal.Parent == movingAnimalsFolder
			and animal.PrimaryPart
			and not targeted[animal.Name]
			and not hasDisco(animal) then

			table.insert(candidates, animal)
		end
	end

	if #candidates == 0 then
		return nil
	end

	return candidates[math.random(1, #candidates)]
end

-- =========================
-- LOOP
-- =========================

local function event()
	if shootTask then
		task.cancel(shootTask)
	end

	shootTask = task.spawn(function()
		-- Pause après le démarrage
		task.wait(15)

		while isActive do
			task.wait(math.random(6, 10))

			local targetAnimal = pick()
			if not targetAnimal then
				continue
			end

			-- Vérification finale avant de tirer
			if hasDisco(targetAnimal) then
				continue
			end

			-- Applique le trait
			applyDisco(targetAnimal)

			-- Si le trait est bien présent (normalement oui), on tire
			if hasDisco(targetAnimal) then
				local now = workspace:GetServerTimeNow()
				local rigIndex = math.random(1, 3)
				targeted[targetAnimal.Name] = now
				Shoot:FireAllClients(rigIndex, targetAnimal.Name, now + 3)
			end
		end
	end)
end

-- =========================
-- API
-- =========================

function Concert.OnStart()
	if isActive then return end

	isActive = true
	ReplicatedStorage:SetAttribute("ConcertEvent", true)
	event()
end

function Concert.OnStop()
	if not isActive then return end

	isActive = false
	ReplicatedStorage:SetAttribute("ConcertEvent", false)

	if shootTask then
		task.cancel(shootTask)
		shootTask = nil
	end

	targeted = {}
end

return Concert
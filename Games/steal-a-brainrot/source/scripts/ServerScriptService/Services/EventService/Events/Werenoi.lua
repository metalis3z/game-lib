local Werenoi = {}

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
		return true
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
		if trait == "Werenoi" then
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
		return
	end

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

					table.insert(traits, "Werenoi")
					closest:SetAttribute("Traits", HttpService:JSONEncode(traits))
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

		-- 🔹 Пауза после старта
		task.wait(15)

		while isActive do
			task.wait(math.random(6, 10))

			local targetAnimal = pick()
			if not targetAnimal then
				continue
			end

			-- 🔒 ФИНАЛЬНАЯ ПРОВЕРКА ПЕРЕД SHOOT
			if hasDisco(targetAnimal) then
				continue
			end

			local now = workspace:GetServerTimeNow()
			local rigIndex = math.random(1, 3)

			-- СНАЧАЛА выдаём trait
			applyDisco(targetAnimal)

			-- Если вдруг trait появился из другого скрипта — не стреляем
			if hasDisco(targetAnimal) then
				targeted[targetAnimal.Name] = now
				Shoot:FireAllClients(rigIndex, targetAnimal.Name, now + 3)
			end
		end
	end)
end

-- =========================
-- API
-- =========================

function Werenoi.OnStart()
	if isActive then return end

	isActive = true
	ReplicatedStorage:SetAttribute("WerenoiEvent", true)
	event()
end

function Werenoi.OnStop()
	if not isActive then return end

	isActive = false
	ReplicatedStorage:SetAttribute("WerenoiEvent", false)

	if shootTask then
		task.cancel(shootTask)
		shootTask = nil
	end

	targeted = {}
end

return Werenoi
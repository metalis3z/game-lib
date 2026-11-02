local Elexir = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")

local Net = require(ReplicatedStorage.Packages.Net)

local Hit = Net:RemoteEvent("EventService/Rain/Hit") -- CHANGÉ

local isActive = false
local rTask = nil

function apply(animal)
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
		if trait == "Elexir" then -- CHANGÉ
			return
		end
	end

	table.insert(currentTraits, "Elexir") -- CHANGÉ
	animal:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
end

function pick()
	local animals = CollectionService:GetTagged("Animal")
	if #animals == 0 then return nil end
	return animals[math.random(1, #animals)]
end

function Elexir.OnStart()
	if isActive then return end
	isActive = true

	rTask = task.spawn(function()
		while isActive do
			task.wait(math.random(3, 4))
			local targetAnimal = pick()

			if targetAnimal then
				apply(targetAnimal)
				Hit:FireAllClients(targetAnimal.Name)
			end
		end
	end)
end

function Elexir.OnStop()
	isActive = false
	if rTask then
		task.cancel(rTask)
		rTask = nil
	end
end

return Elexir
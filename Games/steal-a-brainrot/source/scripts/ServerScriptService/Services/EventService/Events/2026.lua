local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AnimalService = require(ServerScriptService.Services.AnimalService)

local Net = require(ReplicatedStorage.Packages.Net)
local CreateFirework = Net:RemoteEvent("EventService/2026/CreateFirework")
local ExplodeTraitEffect = Net:RemoteEvent("EventService/2026/ExplodeTraitEffect")

local Event2026 = {}

local isActive = false
local fireworkTask = nil
local traitApplyTask = nil
local recentlyTargeted = {}
local fireworkPositions = {}

local Brainrots = {
	{ Name = "Tootini Shrimpini", Chance = 70 },
	{ Name = "Rocco Disco", Chance = 25 },
	{ Name = "Bunito Bunito Spinito", Chance = 2.5 },
}

local function pickAnimalByChance()
	local total = 0
	for _, a in ipairs(Brainrots) do
		total += a.Chance
	end

	local roll = math.random() * total
	local sum = 0

	for _, a in ipairs(Brainrots) do
		sum += a.Chance
		if roll <= sum then
			return a.Name
		end
	end
end

function Event2026.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("2026Event", true)

	if fireworkTask then
		task.cancel(fireworkTask)
		fireworkTask = nil
	end

	if traitApplyTask then
		task.cancel(traitApplyTask)
		traitApplyTask = nil
	end

	table.clear(recentlyTargeted)
	table.clear(fireworkPositions)

	local fireworksFolder = ReplicatedStorage.Models.Events["2026"].Fireworks
	local fireworkModels = fireworksFolder:GetChildren()

	table.sort(fireworkModels, function(a, b)
		return (tonumber(a.Name) or math.huge) < (tonumber(b.Name) or math.huge)
	end)

	for i, model in ipairs(fireworkModels) do
		local cframe
		if model:IsA("Model") and model.PrimaryPart then
			cframe = model.PrimaryPart.CFrame
		elseif model:IsA("BasePart") then
			cframe = model.CFrame
		end
		if cframe then
			fireworkPositions[i] = cframe
		end
	end

	task.spawn(function()
		task.wait(17)
		if not isActive then return end

		fireworkTask = task.spawn(function()
			while isActive do
				task.wait(math.random(5, 10) / 10)
				if not isActive then break end
				if #fireworkPositions == 0 then continue end

				local fireworkData = {}
				local count = math.random(1, 3)

				for _ = 1, count do
					table.insert(fireworkData, {
						Chosen = math.random(1, #fireworkPositions),
						Height = math.random(80, 120),
						FireworkEffect = math.random(1, 3),
						Falloffs = {}
					})
				end

				CreateFirework:FireAllClients(fireworkData)
			end
		end)

		local animalName = pickAnimalByChance()
		if animalName then
			local Animals = require(ReplicatedStorage.Datas.Animals)

			local animalData
			for _, data in pairs(Animals) do
				if data.DisplayName == animalName or data.Name == animalName then
					animalData = data
					break
				end
			end

			if animalData then
				AnimalService.spawnAnimalCustom(
					animalData,
					nil,
					nil,
					nil,
					nil,
					nil
				)
			end

		end

		traitApplyTask = task.spawn(function()
			while isActive do
				task.wait(math.random(80, 150) / 10)
				if not isActive then break end

				local animals = CollectionService:GetTagged("Animal")
				local now = workspace:GetServerTimeNow()

				for name, time in pairs(recentlyTargeted) do
					if now - time > 15 then
						recentlyTargeted[name] = nil
					end
				end

				local candidates = {}

				for _, animal in ipairs(animals) do
					if animal.PrimaryPart and not recentlyTargeted[animal.Name] then
						local traits = {}
						local raw = animal:GetAttribute("Traits")

						if raw then
							local ok, decoded = pcall(HttpService.JSONDecode, HttpService, raw)
							if ok and type(decoded) == "table" then
								traits = decoded
							end
						end

						if not table.find(traits, "26") then
							table.insert(candidates, animal)
						end
					end
				end

				if #candidates > 0 then
					local selected = candidates[math.random(#candidates)]
					recentlyTargeted[selected.Name] = now

					ExplodeTraitEffect:FireAllClients(math.random(1, 3), selected.Name)

					task.delay(0.5, function()
						if not selected or not selected.Parent then return end

						local traits = {}
						local raw = selected:GetAttribute("Traits")
						if raw then
							local ok, decoded = pcall(HttpService.JSONDecode, HttpService, raw)
							if ok and type(decoded) == "table" then
								traits = decoded
							end
						end

						if not table.find(traits, "26") then
					table.insert(traits, "26")
					closestAnimal:SetAttribute("Traits", HttpService:JSONEncode(traits))
						end
					end)
				end
			end
		end)
	end)
end

function Event2026.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("2026Event", false)

	if fireworkTask then
		task.cancel(fireworkTask)
		fireworkTask = nil
	end

	if traitApplyTask then
		task.cancel(traitApplyTask)
		traitApplyTask = nil
	end

	table.clear(recentlyTargeted)
	table.clear(fireworkPositions)
end

return Event2026
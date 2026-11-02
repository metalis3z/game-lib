local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local CreateFirework = Net:RemoteEvent("EventService/10B Visits/CreateFirework")
local ExplodeTraitEffect = Net:RemoteEvent("EventService/10B Visits/ExplodeTraitEffect")
local SpawnEffect = Net:RemoteEvent("EventService/10B Visits/SpawnEffect")

local Event10BVisits = {}
local isActive = false
local fireworkTask = nil
local traitApplyTask = nil
local recentlyTargeted = {}
local fireworkPositions = {}

function Event10BVisits.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("10BVisitsEvent", true)

	if fireworkTask then
		task.cancel(fireworkTask)
	end

	if traitApplyTask then
		task.cancel(traitApplyTask)
	end

	local fireworksFolder = ReplicatedStorage.Models.Events["10B Visits"].Fireworks
	local fireworkModels = fireworksFolder:GetChildren()
	table.sort(fireworkModels, function(a, b)
		return tonumber(a.Name) < tonumber(b.Name)
	end)

	for i, model in ipairs(fireworkModels) do
		if model:IsA("Model") or model:IsA("BasePart") then
			local cframe = nil
			if model:IsA("Model") and model.PrimaryPart then
				cframe = model.PrimaryPart.CFrame
			elseif model:IsA("BasePart") then
				cframe = model.CFrame
			end

			if cframe then
				fireworkPositions[i] = cframe
			end
		end
	end

	fireworkTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(5, 10) / 10
			task.wait(waitTime)

			if not isActive then
				break
			end

			local fireworkData = {}
			local numFireworks = math.random(1, 3)

			for i = 1, numFireworks do
				local validPositions = {}
				for index, _ in pairs(fireworkPositions) do
					table.insert(validPositions, index)
				end

				if #validPositions > 0 then
					local chosenIndex = validPositions[math.random(1, #validPositions)]
					table.insert(fireworkData, {
						Chosen = chosenIndex,
						Height = math.random(80, 120),
						FireworkEffect = math.random(1, 3),
						Falloffs = {}
					})
				end
			end

			if #fireworkData > 0 then
				CreateFirework:FireAllClients(fireworkData)
			end
		end
	end)

	traitApplyTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(80, 150) / 10
			task.wait(waitTime)

			if not isActive then
				break
			end

			local roadAnimals = CollectionService:GetTagged("Animal")
			local currentTime = workspace:GetServerTimeNow()

			for animalName, lastTime in pairs(recentlyTargeted) do
				if (currentTime - lastTime) > 15 then
					recentlyTargeted[animalName] = nil
				end
			end

			local candidates = {}
			for _, animal in ipairs(roadAnimals) do
				if animal.PrimaryPart then
					local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
					local hasFireworks = false

					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)

						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "10B" then
									hasFireworks = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasFireworks then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local now = workspace:GetServerTimeNow()

				ExplodeTraitEffect:FireAllClients(selected.Name)

				recentlyTargeted[selected.Name] = now

				task.delay(0.5, function()
					local currentTraitsJson = selected:GetAttribute("Traits")
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
						if trait == "10B" then
							return
						end
					end

					table.insert(currentTraits, "10B")
					selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end)
			end
		end
	end)
end

function Event10BVisits.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("10BVisitsEvent", false)

	if fireworkTask then
		task.cancel(fireworkTask)
		fireworkTask = nil
	end

	if traitApplyTask then
		task.cancel(traitApplyTask)
		traitApplyTask = nil
	end

	recentlyTargeted = {}
	fireworkPositions = {}
end

return Event10BVisits
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/Concert/Shoot")

local RapConcert = {}

local isActive = false
local attackTask = nil
local recentlyTargeted = {}

function RapConcert.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("RapConcertEvent", true)
	task.wait(2)
	workspace.Sounds.RapConcert.Playing = true

	if attackTask then
		task.cancel(attackTask)
	end

	attackTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(18, 35)
			task.wait(waitTime)

			if not isActive then
				break
			end

			local roadAnimals = CollectionService:GetTagged("Animal")
			local currentTime = workspace:GetServerTimeNow()

			for animalName, lastTime in pairs(recentlyTargeted) do
				if (currentTime - lastTime) > 20 then
					recentlyTargeted[animalName] = nil
				end
			end

			local candidates = {}
			for _, animal in ipairs(roadAnimals) do
				if animal.PrimaryPart then
					local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
					local hasIndonesia = false

					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Disco" then
									hasIndonesia = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasIndonesia then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]

				Burst:FireAllClients(selected.Name)

				recentlyTargeted[selected.Name] = currentTime

				task.spawn(function()
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
						if trait == "Disco" then
							return
						end
					end

					table.insert(currentTraits, "Disco")
					selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end)
			end
		end
	end)
end

function RapConcert.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("RapConcertEvent", false)
	workspace.Sounds.RapConcert.Playing = false
	workspace.Sounds.RapConcert.TimePosition = 0

	if attackTask then
		task.cancel(attackTask)
		attackTask = nil
	end

	recentlyTargeted = {}
end

return RapConcert
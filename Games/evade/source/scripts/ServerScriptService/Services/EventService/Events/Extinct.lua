local Extinct = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)

local Burst = Net:RemoteEvent("EventService/Extinct/Burst")

local isActive = false
local extinctTask = nil
local recentlyTargeted = {}

function Extinct.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("ExtinctEvent", true)

	if extinctTask then
		task.cancel(extinctTask)
	end

	extinctTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(4, 9)
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
					local hasExtinct = false
					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Extinct" then
									hasExtinct = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasExtinct then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local now = workspace:GetServerTimeNow()

				Burst:FireAllClients(selected.Name)

				task.delay(0.1, function()
					if not selected or not selected.Parent then
						return
					end

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

					local hasExtinct = false
					for _, trait in ipairs(currentTraits) do
						if trait == "Extinct" then
							hasExtinct = true
							break
						end
					end

					if not hasExtinct then
						table.insert(currentTraits, "Extinct")
						selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
					end
				end)

				recentlyTargeted[selected.Name] = now
			end
		end
	end)
end

function Extinct.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("ExtinctEvent", false)

	if extinctTask then
		task.cancel(extinctTask)
		extinctTask = nil
	end

	recentlyTargeted = {}
end

return Extinct
local Rain = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)

local Hit = Net:RemoteEvent("EventService/Rain/Hit")

local isActive = false
local trove = nil
local recentlyTargeted = {}

function Rain.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("RainEvent", true)

	if trove then
		trove:Destroy()
	end
	trove = Trove.new()

	trove:Add(task.spawn(function()
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
					local hasRain = false
					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Wet" then
									hasRain = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasRain then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]

				if not selected.PrimaryPart or not SharedEventUtils.isPointInCarpet(selected.PrimaryPart.Position) then
					continue
				end

				local now = workspace:GetServerTimeNow()

				Hit:FireAllClients(selected.Name)
				recentlyTargeted[selected.Name] = now

				trove:Add(task.delay(0.1, function()
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

					for _, trait in ipairs(currentTraits) do
						if trait == "Wet" then
							return
						end
					end

					table.insert(currentTraits, "Wet")
					selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end))
			end
		end
	end))
end

function Rain.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("RainEvent", false)

	if trove then
		trove:Destroy()
		trove = nil
	end

	recentlyTargeted = {}
end

return Rain
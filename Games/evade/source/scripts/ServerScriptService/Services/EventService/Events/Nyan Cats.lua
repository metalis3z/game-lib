local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Struck = Net:RemoteEvent("EventService/NyanCats/Struck")

local NyanCats = {}
local isActive = false
local strikeTask = nil
local recentlyTargeted = {}

function NyanCats.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("NyanCatsEvent", true)

	if strikeTask then
		task.cancel(strikeTask)
	end

	strikeTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(40, 80) / 10
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
					local hasNyan = false

					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Nyan" then
									hasNyan = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasNyan then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local catIndex = math.random(1, 30)
				local now = workspace:GetServerTimeNow()

				Struck:FireAllClients(catIndex, selected.Name, now)
				recentlyTargeted[selected.Name] = now

				task.delay(3.1, function()
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
						if trait == "Nyan" then
							return
						end
					end

					table.insert(currentTraits, "Nyan")
					selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end)
			end
		end
	end)
end

function NyanCats.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("NyanCatsEvent", false)

	if strikeTask then
		task.cancel(strikeTask)
		strikeTask = nil
	end

	recentlyTargeted = {}
end

return NyanCats
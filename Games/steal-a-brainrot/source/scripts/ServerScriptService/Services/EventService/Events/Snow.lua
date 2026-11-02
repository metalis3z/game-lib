local Snow = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)
local Hit = Net:RemoteEvent("EventService/Snow/Hit")

local isActive = false
local snowTask = nil
local recentlyTargeted = {}

function Snow.OnStart()
	if isActive then
		return
	end
	isActive = true
	ReplicatedStorage:SetAttribute("Snow", true)

	if snowTask then
		task.cancel(snowTask)
	end

	snowTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(6, 12)
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
					local hasSnowy = false
					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Snowy" then
									hasSnowy = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasSnowy then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local now = workspace:GetServerTimeNow()

				Hit:FireAllClients(selected.Name)
				recentlyTargeted[selected.Name] = now

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

					for _, trait in ipairs(currentTraits) do
						if trait == "Snowy" then
							return
						end
					end

					table.insert(currentTraits, "Snowy")
					selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end)
			end
		end
	end)
end

function Snow.OnStop()
	if not isActive then
		return
	end
	isActive = false
	ReplicatedStorage:SetAttribute("Snow", false)

	if snowTask then
		task.cancel(snowTask)
		snowTask = nil
	end

	recentlyTargeted = {}
end

return Snow
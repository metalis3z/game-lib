local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Shoot = Net:RemoteEvent("EventService/RainingTacos/Shoot")

local RainingTacos = {}

local isActive = false
local shootTask = nil
local recentlyTargeted = {}

function RainingTacos.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("RainingTacosEvent", true)

	if shootTask then
		task.cancel(shootTask)
	end

	shootTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(6, 16)
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
					local hasTaco = false

					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Taco" then
									hasTaco = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasTaco then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local now = workspace:GetServerTimeNow()

				Shoot:FireAllClients(selected.Name, now)

				recentlyTargeted[selected.Name] = now

				task.delay(2.5, function()
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
						if trait == "Taco" then
							return
						end
					end

					table.insert(currentTraits, "Taco")
					selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end)
			end
		end
	end)
end

function RainingTacos.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("RainingTacosEvent", false)

	if shootTask then
		task.cancel(shootTask)
		shootTask = nil
	end

	recentlyTargeted = {}
end

return RainingTacos
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Projectile = Net:RemoteEvent("EventService/WitchingHour/Projectile")
local Burst = Net:RemoteEvent("EventService/WitchingHour/Burst")

local WitchingHour = {}
local isActive = false
local strikeTask = nil
local recentlyTargeted = {}
local witchate= game.Workspace.Events["Witching Hour"].Model

function WitchingHour.OnStart()
	if isActive then
		return
	end
	
	witchate:PivotTo(CFrame.new(-381.109, -9.5, 32.906))


	isActive = true
	ReplicatedStorage:SetAttribute("WitchingHourEvent", true)

	if strikeTask then
		task.cancel(strikeTask)
	end

	strikeTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(60, 120) / 10
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
					local hasWitchHat = false

					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)

						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Witch Hat" then
									hasWitchHat = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasWitchHat then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local now = workspace:GetServerTimeNow()
				local travelTime = 2.5

				Projectile:FireAllClients(
					selected.Name,
					1,
					travelTime,
					now,
					#candidates
				)

				recentlyTargeted[selected.Name] = now

				task.delay(travelTime, function()
					Burst:FireAllClients(selected.Name)

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
						if trait == "Witch Hat" then
							return
						end
					end

					table.insert(currentTraits, "Witch Hat")
					selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end)
			end
		end
	end)
end

function WitchingHour.OnStop()
	if not isActive then
		return
	end
	
	witchate:PivotTo(CFrame.new(0, 100000, 0))


	isActive = false
	ReplicatedStorage:SetAttribute("WitchingHourEvent", false)

	if strikeTask then
		task.cancel(strikeTask)
		strikeTask = nil
	end

	recentlyTargeted = {}
end

return WitchingHour
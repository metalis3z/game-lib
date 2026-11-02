local LosMatteos = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)
local CreateLightningBolt = Net:RemoteEvent("EventService/Los Matteos/CreateLightningBolt")

local isActive = false
local lightningTask = nil
local recentlyTargeted = {}
local strikeId = 0

function LosMatteos.OnStart()
	if isActive then
		return
	end
	isActive = true
	ReplicatedStorage:SetAttribute("LosMatteosEvent", true)

	if lightningTask then
		task.cancel(lightningTask)
	end

	lightningTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(4, 10)
			task.wait(waitTime)

			if not isActive then
				break
			end

			local rainingArea = workspace.Events["Los Matteos"].RainArea
			local areaSize = rainingArea.Size
			local areaCFrame = rainingArea.CFrame

			local strikeCount = math.random(1, 2)

			for i = 1, strikeCount do
				strikeId = strikeId + 1

				local randomX = math.random(-areaSize.X/2, areaSize.X/2)
				local randomZ = math.random(-areaSize.Z/2, areaSize.Z/2)
				local strikePos = (areaCFrame * CFrame.new(randomX, 0, randomZ)).Position

				local shouldHitAnimal = math.random(1, 100) <= 20
				local targetAnimal = nil

				if shouldHitAnimal then
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
							local hasMatteoHat = false
							local currentTraitsJson = animal:GetAttribute("Traits")
							if currentTraitsJson then
								local success, decoded = pcall(function()
									return HttpService:JSONDecode(currentTraitsJson)
								end)
								if success and type(decoded) == "table" then
									for _, trait in ipairs(decoded) do
										if trait == "Matteo Hat" then
											hasMatteoHat = true
											break
										end
									end
								end
							end

							if not isRecentlyTargeted and not hasMatteoHat then
								local animalPos = (if animal.PrimaryPart then animal.PrimaryPart.CFrame else animal:GetPivot()).Position
								local distance = (animalPos - strikePos).Magnitude
								if distance <= 150 then
									table.insert(candidates, {animal = animal, distance = distance})
								end
							end
						end
					end

					if #candidates > 0 then
						table.sort(candidates, function(a, b)
							return a.distance < b.distance
						end)

						targetAnimal = candidates[1].animal
						local animalPos = (if targetAnimal.PrimaryPart then targetAnimal.PrimaryPart.CFrame else targetAnimal:GetPivot()).Position
						animalPos = animalPos + Vector3.new(0, targetAnimal:GetExtentsSize().Y * 0.5, 0)

						CreateLightningBolt:FireAllClients(strikeId, animalPos, targetAnimal.Name)
						recentlyTargeted[targetAnimal.Name] = workspace:GetServerTimeNow()

						task.delay(0.15, function()
							if not targetAnimal or not targetAnimal.Parent then
								return
							end

							local currentTraitsJson = targetAnimal:GetAttribute("Traits")
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
								if trait == "Matteo Hat" then
									return
								end
							end

							table.insert(currentTraits, "Matteo Hat")
							targetAnimal:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
						end)
					else
						CreateLightningBolt:FireAllClients(strikeId, strikePos, nil)
					end
				else
					CreateLightningBolt:FireAllClients(strikeId, strikePos, nil)
				end

				if i < strikeCount then
					task.wait(0.3)
				end
			end
		end
	end)
end

function LosMatteos.OnStop()
	if not isActive then
		return
	end
	isActive = false
	ReplicatedStorage:SetAttribute("LosMatteosEvent", false)

	if lightningTask then
		task.cancel(lightningTask)
		lightningTask = nil
	end

	recentlyTargeted = {}
	strikeId = 0
end

return LosMatteos
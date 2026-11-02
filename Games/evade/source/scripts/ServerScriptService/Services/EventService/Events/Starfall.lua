local Starfall = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)
local CreateStar = Net:RemoteEvent("EventService/Starfall/CreateStar")
local ExplodeStar = Net:RemoteEvent("EventService/Starfall/ExplodeStar")

local isActive = false
local starfallTask = nil
local activeMeteors = {}
local nextStarId = 1

function Starfall.OnStart()
	if isActive then
		return
	end
	isActive = true
	ReplicatedStorage:SetAttribute("Starfall", true)

	if starfallTask then
		task.cancel(starfallTask)
	end

	starfallTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(40, 75) / 100
			task.wait(waitTime)

			if not isActive then
				break
			end

			local mapFloor = workspace.Events.Starfall.MapFloor
			local floorSize = mapFloor.Size
			local floorCFrame = mapFloor.CFrame

			local randomX = math.random(-floorSize.X/2, floorSize.X/2)
			local randomZ = math.random(-floorSize.Z/2, floorSize.Z/2)
			local targetPos = (floorCFrame * CFrame.new(randomX, 0, randomZ)).Position

			local fixedOrigin = Vector3.new(-1000, 225, 50) -- change

			local dir = (targetPos - fixedOrigin)


			local horizontal = Vector3.new(dir.X, 0, dir.Z)
			local hDist = horizontal.Magnitude

			if hDist > 0 then
				horizontal = horizontal.Unit * hDist
			end

			local vDist = hDist
			local startPos = Vector3.new(
				fixedOrigin.X,
				targetPos.Y + vDist,
				fixedOrigin.Z
			)

			local fallDuration = math.random(25, 40) / 10

			local starId = nextStarId
			nextStarId = nextStarId + 1

			CreateStar:FireAllClients(starId, startPos, targetPos, fallDuration)

			activeMeteors[starId] = {
				targetPos = targetPos,
				impactTime = workspace:GetServerTimeNow() + fallDuration
			}

			task.delay(fallDuration, function()
				local meteorData = activeMeteors[starId]
				if not meteorData then
					return
				end

				activeMeteors[starId] = nil

				local shouldHitAnimal = math.random(1, 100) <= 5
				local targetAnimal = nil

				if shouldHitAnimal then
					local roadAnimals = CollectionService:GetTagged("Animal")
					local candidates = {}

					for _, animal in ipairs(roadAnimals) do
						if animal.PrimaryPart then
							local currentTraitsJson = animal:GetAttribute("Traits")
							local hasComet = false

							if currentTraitsJson then
								local success, decoded = pcall(function()
									return HttpService:JSONDecode(currentTraitsJson)
								end)
								if success and type(decoded) == "table" then
									for _, trait in ipairs(decoded) do
										if trait == "Cometstruck" then
											hasComet = true
											break
										end
									end
								end
							end

							if not hasComet then
								table.insert(candidates, animal)
							end
						end
					end

					if #candidates > 0 then
						targetAnimal = candidates[math.random(1, #candidates)]
						local animalPos = nil
						local animalModel = targetAnimal
						animalPos = (if animalModel.PrimaryPart then animalModel.PrimaryPart.CFrame else animalModel:GetPivot()).Position
						animalPos = animalPos + Vector3.new(0, targetAnimal:GetExtentsSize().Y * 0.5, 0)

						ExplodeStar:FireAllClients(starId, animalPos, targetAnimal.Name)

						task.delay(0.1, function()
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
								if trait == "Cometstruck" then
									return
								end
							end

							table.insert(currentTraits, "Cometstruck")
							targetAnimal:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
						end)
					else
						ExplodeStar:FireAllClients(starId, meteorData.targetPos, nil)
					end
				else
					ExplodeStar:FireAllClients(starId, meteorData.targetPos, nil)
				end
			end)
		end
	end)
end

function Starfall.OnStop()
	if not isActive then
		return
	end
	isActive = false
	ReplicatedStorage:SetAttribute("Starfall", false)

	if starfallTask then
		task.cancel(starfallTask)
		starfallTask = nil
	end

	table.clear(activeMeteors)
	nextStarId = 1
end

return Starfall
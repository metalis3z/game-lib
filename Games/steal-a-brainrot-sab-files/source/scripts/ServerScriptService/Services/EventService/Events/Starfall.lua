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
			local waitTime = math.random(25) / 100
			task.wait(waitTime)

			if not isActive then
				break
			end

			local mapFloor = workspace.Events.Starfall.MapFloor
			local floorSize = mapFloor.Size
			local floorCFrame = mapFloor.CFrame

			local shouldHitAnimal = math.random(1, 100) <= 3
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
				end
			end

			local targetPos

			if targetAnimal then
				local animalModel = targetAnimal
				local animalPos = (if animalModel.PrimaryPart then animalModel.PrimaryPart.CFrame else animalModel:GetPivot()).Position
				targetPos = animalPos + Vector3.new(0, animalModel:GetExtentsSize().Y * 0.5, 0)
			else
				local randomX = math.random(-floorSize.X / 2, floorSize.X / 2)
				local randomZ = math.random(-floorSize.Z / 2, floorSize.Z / 2)
				targetPos = (floorCFrame * CFrame.new(randomX, 0, randomZ)).Position
			end

			local fixedOrigin = Vector3.new(-1000, 225, 50)

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

			local fallDuration = math.random(250, 400) / 100

			local starId = nextStarId
			nextStarId = nextStarId + 1

			CreateStar:FireAllClients(starId, startPos, targetPos, fallDuration)

			activeMeteors[starId] = {
				targetPos = targetPos,
				impactTime = workspace:GetServerTimeNow() + fallDuration,
				targetAnimal = targetAnimal,
			}

			task.delay(fallDuration, function()
				local meteorData = activeMeteors[starId]
				if not meteorData then
					return
				end

				activeMeteors[starId] = nil

				local animal = meteorData.targetAnimal

				if animal and animal.Parent then
					local animalPos = (if animal.PrimaryPart then animal.PrimaryPart.CFrame else animal:GetPivot()).Position
					local impactPos = animalPos + Vector3.new(0, animal:GetExtentsSize().Y * 0.5, 0)

					ExplodeStar:FireAllClients(starId, impactPos, animal.Name)

					task.delay(0.1, function()
						if not animal or not animal.Parent then
							return
						end

						local currentTraitsJson = animal:GetAttribute("Traits")
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
						animal:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
					end)
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
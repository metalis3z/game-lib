local Starfall = {}
local MeteorSpeed = 25
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
	if isActive then return end
	isActive = true
	ReplicatedStorage:SetAttribute("Starfall", true)
	if starfallTask then task.cancel(starfallTask) end
	starfallTask = task.spawn(function()
		while isActive do
			local meteorCount = math.min(math.random(6, 10), 50)
			local mapSpawns = {}
			for _, obj in ipairs(script.Spawns:GetChildren()) do
				if obj.Name == "MapSpawn" and obj:IsA("BasePart") then
					table.insert(mapSpawns, obj)
				end
			end
			for i = 1, meteorCount do
				if not isActive then break end
				local mapFloor = workspace.Events.Starfall.MapFloor
				local spawnPoint = mapSpawns[math.random(1, #mapSpawns)]
				local floorSize = mapFloor.Size
				local floorCFrame = mapFloor.CFrame
				local spawnCFrame = spawnPoint and spawnPoint.CFrame or mapFloor.CFrame
				local starId = nextStarId
				nextStarId = nextStarId + 1
				local shouldHitAnimal = math.random(1, 100) <= 2
				local targetPos, targetAnimal = nil, nil
				if shouldHitAnimal then
					local animals = CollectionService:GetTagged("Animal")
					local candidates = {}
					for _, animal in ipairs(animals) do
						if animal.PrimaryPart then
							local traitsJson = animal:GetAttribute("Traits")
							local hasComet = false
							if traitsJson then
								local success, decoded = pcall(function() return HttpService:JSONDecode(traitsJson) end)
								if success and type(decoded) == "table" then
									for _, trait in ipairs(decoded) do
										if trait == "Cometstruck" then hasComet = true break end
									end
								end
							end
							if not hasComet then table.insert(candidates, animal) end
						end
					end
					if #candidates > 0 then
						targetAnimal = candidates[math.random(1, #candidates)]
						targetPos = (targetAnimal.PrimaryPart and targetAnimal.PrimaryPart.CFrame or targetAnimal:GetPivot()).Position
						targetPos = targetPos + Vector3.new(0, targetAnimal:GetExtentsSize().Y * 0.5, 0)
					end
				end
				if not targetPos then
					local randomX = math.random(-floorSize.X / 2, floorSize.X / 2)
					local randomZ = math.random(-floorSize.Z / 2, floorSize.Z / 2)
					targetPos = (floorCFrame * CFrame.new(randomX, 0, randomZ)).Position
				end
				local startPos = spawnCFrame.Position + Vector3.new(0, math.random(300, 500), 0)
				local fallDuration = MeteorSpeed
				local tiltAngle = math.random(30, 45) * (math.random(0, 1) * 2 - 1)
				CreateStar:FireAllClients(starId, startPos, targetPos, fallDuration, tiltAngle)
				activeMeteors[starId] = { targetPos = targetPos, impactTime = workspace:GetServerTimeNow() + fallDuration, animal = targetAnimal }
				task.delay(fallDuration, function()
					local meteorData = activeMeteors[starId]
					if not meteorData then return end
					activeMeteors[starId] = nil
					ExplodeStar:FireAllClients(starId, meteorData.targetPos, targetAnimal and targetAnimal.Name or nil)
					if targetAnimal and targetAnimal.Parent then
						local traitsJson = targetAnimal:GetAttribute("Traits")
						local traits = {}
						if traitsJson then
							local success, decoded = pcall(function() return HttpService:JSONDecode(traitsJson) end)
							if success and type(decoded) == "table" then traits = decoded end
						end
						local hasComet = false
						for _, trait in ipairs(traits) do
							if trait == "Cometstruck" then hasComet = true break end
						end
						if not hasComet then
								table.insert(traits, "Cometstruck")
								targetAnimal:SetAttribute("Traits", HttpService:JSONEncode(traits))
						end
					end
				end)
				if i < meteorCount then task.wait(0.1) end
			end
			task.wait(0.5)
		end
	end)
end

function Starfall.OnStop()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("Starfall", false)
	if starfallTask then task.cancel(starfallTask) starfallTask = nil end
	table.clear(activeMeteors)
	nextStarId = 1
end

return Starfall
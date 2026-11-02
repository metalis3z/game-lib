local Phase = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)

local CreateLightningOrb = Net:RemoteEvent("EventService/Phase 4: Mygame43/CreateLightningOrb")
local Mygame43 = ReplicatedStorage:WaitForChild("Models").Events["Phase 4: Mygame43"].mygame43

local IsActive = false
local recentlyTargeted = {}

function Phase.OnStart()
	if IsActive then
		return
	end

	IsActive = true

	local Mygame43_Clone = Mygame43:Clone()
	Mygame43_Clone.Parent = workspace
	Mygame43_Clone:AddTag("Mygame43")

	task.spawn(function()
		while IsActive do
			local waitTime = Random.new():NextNumber(8, 15)
			task.wait(waitTime)

			if not IsActive then
				break
			end

			local numBalls = math.random(1, 2)

			for i = 1, numBalls do
				local hitAnimal = math.random(1, 100) <= 35
				local targetPosition
				local targetAnimal = nil
				local didHit = false

				if hitAnimal then
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
							local hasLightning = false
							local currentTraitsJson = animal:GetAttribute("Traits")

							if currentTraitsJson then
								local success, decoded = pcall(function()
									return HttpService:JSONDecode(currentTraitsJson)
								end)
								if success and type(decoded) == "table" then
									for _, trait in ipairs(decoded) do
										if trait == "Lightning" then
											hasLightning = true
											break
										end
									end
								end
							end

							if not isRecentlyTargeted and not hasLightning then
								table.insert(candidates, animal)
							end
						end
					end

					if #candidates > 0 then
						targetAnimal = candidates[math.random(1, #candidates)]
						local flightDuration = Random.new():NextNumber(1.5, 2.5)
						local velocity = Vector3.zero

						if targetAnimal.PrimaryPart:IsA("BasePart") and targetAnimal.PrimaryPart.AssemblyLinearVelocity then
							velocity = targetAnimal.PrimaryPart.AssemblyLinearVelocity
						end

						local predictedOffset = velocity * flightDuration
						targetPosition = targetAnimal.PrimaryPart.Position + predictedOffset

						recentlyTargeted[targetAnimal.Name] = currentTime
						didHit = true
					else
						hitAnimal = false
					end
				end

				if not hitAnimal then
					local wanderFolder = workspace.Events:FindFirstChild("Wander")
					if wanderFolder then
						local parts = wanderFolder:GetChildren()
						if #parts > 0 then
							local randomPart = parts[Random.new():NextInteger(1, #parts)]
							targetPosition = randomPart.Position
						end
					end
				end

				if targetPosition then
					local seed = Random.new():NextInteger(1, 999999)
					local orbIndex = Random.new():NextInteger(1, 4)
					local flightDuration = Random.new():NextNumber(1.5, 2.5)

					CreateLightningOrb:FireAllClients(seed, orbIndex, targetPosition, flightDuration, didHit)

					if didHit and targetAnimal then
						task.delay(flightDuration + 0.1, function()
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
								if trait == "Lightning" then
									return
								end
							end

							table.insert(currentTraits, "Lightning")
							targetAnimal:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
						end)
					end
				end

				if i < numBalls then
					task.wait(0.1)
				end
			end
		end
	end)
end

function Phase.OnStop()
	if not IsActive then
		return
	end
	
	if workspace:WaitForChild("mygame43") then
		workspace:WaitForChild("mygame43"):Destroy()
	end

	IsActive = false
	recentlyTargeted = {}
end

return Phase
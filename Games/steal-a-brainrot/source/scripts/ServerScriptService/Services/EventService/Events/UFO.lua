local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local AbductionBurst = Net:RemoteEvent("EventService/UFO/AbductionBurst")
local Spawned = Net:RemoteEvent("EventService/UFO/Spawned")

local UFO = {}
local isActive = false
local strikeTask = nil
local recentlyTargeted = {}

function UFO.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("UFOEvent", true)

	if strikeTask then
		task.cancel(strikeTask)
	end

	strikeTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(90, 150) / 10
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
					local hasUFO = false

					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)

						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "UFO" then
									hasUFO = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasUFO then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local targetPosition = selected.PrimaryPart.Position

				local ufoMarker = Instance.new("Part")
				ufoMarker.Size = Vector3.new(1, 1, 1)
				ufoMarker.Transparency = 1
				ufoMarker.CanCollide = false
				ufoMarker.Anchored = true
				ufoMarker.CFrame = CFrame.new(targetPosition + Vector3.new(0, 50, 0))
				ufoMarker.Name = "UFOMarker"
				CollectionService:AddTag(ufoMarker, "GalaxyUFO")
				ufoMarker.Parent = workspace

				Spawned:FireAllClients()

				recentlyTargeted[selected.Name] = currentTime

				task.wait(1)

				ufoMarker:SetAttribute("BeamState", "down")
				selected:SetAttribute("ForceIdle", true)

				task.wait(2)

				AbductionBurst:FireAllClients(targetPosition)

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
					if trait == "UFO" then
						ufoMarker:Destroy()
						selected:SetAttribute("ForceIdle", false)
						task.wait(0.5)
						selected:SetAttribute("ForceIdle", nil)
						return
					end
				end

				table.insert(currentTraits, "UFO")
				selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))

				task.wait(1)

				ufoMarker:SetAttribute("BeamState", "off")

				task.wait(0.5)

				selected:SetAttribute("ForceIdle", false)

				task.wait(0.5)

				selected:SetAttribute("ForceIdle", nil)

				task.wait(1)

				ufoMarker:Destroy()
			end
		end
	end)
end

function UFO.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("UFOEvent", false)

	if strikeTask then
		task.cancel(strikeTask)
		strikeTask = nil
	end

	recentlyTargeted = {}

	for _, marker in CollectionService:GetTagged("GalaxyUFO") do
		if marker.Name == "UFOMarker" then
			marker:Destroy()
		end
	end
end

return UFO
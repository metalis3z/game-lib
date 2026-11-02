local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)

local Burst = Net:RemoteEvent("EventService/Skibidi/Burst")
local SpawnSkibidi = Net:RemoteEvent("EventService/Skibidi/SpawnSkibidi")

local Skibidi = {}

local isActive = false
local recentlyTargeted = {}
local eventTrove = nil

function Skibidi.OnStart()
	if isActive then
		return
	end

	isActive = true
	eventTrove = Trove.new()
	ReplicatedStorage:SetAttribute("SkibidiEvent", true)

	local eventSeed = ReplicatedStorage:GetAttribute("SkibidiEventSeed")
	if not eventSeed then
		eventSeed = math.random(1, 1000000)
		ReplicatedStorage:SetAttribute("SkibidiEventSeed", eventSeed)
	end

	local startTime = Workspace:GetServerTimeNow()

	eventTrove:Add(task.spawn(function()
		local lastSeed = -1
		local rng = nil

		while isActive do
			task.wait(0.1)

			local currentSeedValue = eventSeed + (Workspace:GetServerTimeNow() - startTime) // 5

			if currentSeedValue ~= lastSeed then
				rng = Random.new(currentSeedValue)
				lastSeed = currentSeedValue
			end

			local groundParts = Workspace.Events.Skibidi.Ground:GetChildren()
			local wallParts = Workspace.Events.Skibidi.WallTop:GetChildren()

			if #groundParts > 0 then
				local part = groundParts[rng:NextInteger(1, #groundParts)]
				local size = part.Size
				local offset = CFrame.new(
					rng:NextNumber(-size.X / 2, size.X / 2),
					size.Y / 2,
					rng:NextNumber(-size.Z / 2, size.Z / 2)
				)
				local spawnCFrame = part.CFrame * offset
				SpawnSkibidi:FireAllClients(spawnCFrame, "Ground")
			end

			if #wallParts > 0 then
				local part = wallParts[rng:NextInteger(1, #wallParts)]
				local size = part.Size
				local offset = CFrame.new(
					rng:NextNumber(-size.X / 2, size.X / 2),
					size.Y / 2,
					rng:NextNumber(-size.Z / 2, size.Z / 2)
				)
				local spawnCFrame = part.CFrame * offset
				SpawnSkibidi:FireAllClients(spawnCFrame, "WallTop")
			end
		end
	end))

	eventTrove:Add(task.spawn(function()
		while isActive do
			task.wait(math.random(6, 12))

			if not isActive then break end

			local roadAnimals = CollectionService:GetTagged("Animal")
			local currentTime = Workspace:GetServerTimeNow()

			for animalName, lastTime in pairs(recentlyTargeted) do
				if (currentTime - lastTime) > 20 then
					recentlyTargeted[animalName] = nil
				end
			end

			local candidates = {}
			for _, animal in ipairs(roadAnimals) do
				if animal.PrimaryPart then
					local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
					local hasSkibidi = false

					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(HttpService.JSONDecode, HttpService, currentTraitsJson)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Skibidi" then
									hasSkibidi = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasSkibidi then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				recentlyTargeted[selected.Name] = currentTime

				local attackSequenceTrove = eventTrove:Extend()

				attackSequenceTrove:Add(task.spawn(function()
					if not selected or not selected.PrimaryPart then
						attackSequenceTrove:Clean()
						return
					end

					selected:SetAttribute("ForceIdle", true)
					SpawnSkibidi:FireAllClients(selected.PrimaryPart.CFrame, "Ground")

					task.wait(1)

					if not isActive then
						if selected and selected.Parent then
							selected:SetAttribute("ForceIdle", nil)
						end
						attackSequenceTrove:Clean()
						return
					end

					if not selected or not selected.Parent then
						attackSequenceTrove:Clean()
						return
					end

					Burst:FireAllClients(selected.Name)
					selected:SetAttribute("ForceIdle", nil)

					local currentTraitsJson = selected:GetAttribute("Traits")
					local currentTraits = {}

					if currentTraitsJson then
						local success, decoded = pcall(HttpService.JSONDecode, HttpService, currentTraitsJson)
						if success and type(decoded) == "table" then
							currentTraits = decoded
						end
					end

					for _, trait in ipairs(currentTraits) do
						if trait == "Skibidi" then
							attackSequenceTrove:Clean()
							return
						end
					end

					table.insert(currentTraits, "Skibidi")
					selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))

					attackSequenceTrove:Clean()
				end))
			end
		end
	end))
end

function Skibidi.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("SkibidiEvent", false)

	if eventTrove then
		eventTrove:Clean()
		eventTrove = nil
	end

	recentlyTargeted = {}
end

return Skibidi
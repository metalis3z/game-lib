local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)

local Struck = Net:RemoteEvent("EventService/NyanCats/Struck")

local NyanCats = {}
local isActive = false
local eventTrove = nil
local recentlyTargeted = {}

function NyanCats.OnStart()
	if isActive then
		return
	end

	isActive = true
	eventTrove = Trove.new()
	ReplicatedStorage:SetAttribute("NyanCatsEvent", true)

	eventTrove:Add(task.spawn(function()
		while isActive do
			local is3Roads = ReplicatedStorage:GetAttribute("3RoadsEvent") == true

			local minWait = is3Roads and (1000 / 3) or 1000
			local maxWait = is3Roads and (1200 / 3) or 1200

			local waitTime = math.random(minWait, maxWait) / 100
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
					local hasNyan = false

					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Nyan" then
									hasNyan = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasNyan then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]

				if not selected.PrimaryPart or not SharedEventUtils.isPointInCarpet(selected.PrimaryPart.Position) then
					continue
				end

				local catIndex = math.random(1, 30)
				local now = workspace:GetServerTimeNow()

				Struck:FireAllClients(catIndex, selected.Name, now)
				recentlyTargeted[selected.Name] = now

				local delayTrove = eventTrove:Extend()

				delayTrove:Add(task.delay(3.1, function()
					if not selected or not selected.Parent then
						delayTrove:Clean()
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

					local alreadyHas = false
					for _, trait in ipairs(currentTraits) do
						if trait == "Nyan" then
							alreadyHas = true
							break
						end
					end

					if not alreadyHas then
						table.insert(currentTraits, "Nyan")
						selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
					end

					delayTrove:Clean()
				end))
			end
		end
	end))
end

function NyanCats.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("NyanCatsEvent", false)

	if eventTrove then
		eventTrove:Clean()
		eventTrove = nil
	end

	recentlyTargeted = {}
end

return NyanCats
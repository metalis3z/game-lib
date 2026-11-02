local LaVacca = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local Comet = Net:RemoteEvent("EventService/LaVacca/Comet")
local animalservice = require(game.ServerScriptService.Services.AnimalService)
local Animals = require(ReplicatedStorage.Datas.Animals)
local isActive = false
local cometTask = nil
local recentlyTargeted = {}

function LaVacca.OnStart()
	if isActive then
		return
	end
	isActive = true
	ReplicatedStorage:SetAttribute("LaVaccaEvent", true)
    
	if cometTask then
		task.cancel(cometTask)
	end
	task.wait(15)
	cometTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(5, 10)
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
					local hasGalactic = false
					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Galactic" then
									hasGalactic = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasGalactic then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]

				if not selected.PrimaryPart or not SharedEventUtils.isPointInCarpet(selected.PrimaryPart.Position) then
					continue
				end

				local now = workspace:GetServerTimeNow()

				local cometStartPos = ReplicatedStorage:GetAttribute("LaVaccaCenter") or workspace.MapCenter.Position
				cometStartPos = cometStartPos + Vector3.new(0, 200, 0)

				Comet:FireAllClients(cometStartPos, selected.Name)
				recentlyTargeted[selected.Name] = now

				task.delay(1.1, function()
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
						if trait == "Galactic" then
							return
						end
					end

					table.insert(currentTraits, "Galactic")
					selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end)
			end
		end
	end)
end

function LaVacca.OnStop()
	if not isActive then
		return
	end
	isActive = false
	ReplicatedStorage:SetAttribute("LaVaccaEvent", false)

	if cometTask then
		task.cancel(cometTask)
		cometTask = nil
	end

	recentlyTargeted = {}
end

return LaVacca
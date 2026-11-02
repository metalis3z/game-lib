local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)

-- RemoteEvent renommé Burger
local Shoot = Net:RemoteEvent("EventService/RainingTacos/Shoot")

local RainingBurgers = {}
local isActive = false
local shootTask = nil
local recentlyTargeted = {}

function RainingBurgers.OnStart()
	if isActive then
		return
	end
	isActive = true
	ReplicatedStorage:SetAttribute("RainingBurgersEvent", true)

	if shootTask then
		task.cancel(shootTask)
	end

	shootTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(10, 25)
			task.wait(waitTime)
			if not isActive then
				break
			end

			local roadAnimals = CollectionService:GetTagged("Animal")
			local currentTime = workspace:GetServerTimeNow()

			-- Nettoyage des cibles récentes (cooldown 20 secondes)
			for animalName, lastTime in pairs(recentlyTargeted) do
				if (currentTime - lastTime) > 20 then
					recentlyTargeted[animalName] = nil
				end
			end

			-- Filtrage des candidats valides
			local candidates = {}
			for _, animal in ipairs(roadAnimals) do
				if animal.PrimaryPart then
					local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
					local hasBurger = false

					-- Vérifie que l'animal n'a pas déjà le trait "Burger"
					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Burger" then
									hasBurger = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasBurger then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local now = workspace:GetServerTimeNow()

				-- Fire vers tous les clients
				Shoot:FireAllClients(selected.Name, now)
				recentlyTargeted[selected.Name] = now

				-- Après 2.5s (durée du vol), on applique le trait "Burger"
				task.delay(2.5, function()
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

					-- Vérifie une dernière fois avant d'ajouter
					for _, trait in ipairs(currentTraits) do
						if trait == "Burger" then
							return
						end
					end

					table.insert(currentTraits, "Burger")
					selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end)
			end
		end
	end)
end

function RainingBurgers.OnStop()
	if not isActive then
		return
	end
	isActive = false
	ReplicatedStorage:SetAttribute("RainingBurgersEvent", false)

	if shootTask then
		task.cancel(shootTask)
		shootTask = nil
	end

	recentlyTargeted = {}
end

return RainingBurgers
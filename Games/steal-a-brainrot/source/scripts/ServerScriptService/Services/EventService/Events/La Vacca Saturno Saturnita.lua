local LaVacca = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local MapInformation = require(ReplicatedStorage.Shared.MapInformation)
local Net = require(ReplicatedStorage.Packages.Net)
local Comet = Net:RemoteEvent("EventService/LaVacca/Comet")

local isActive = false
local cometTask
local recentlyTargeted = {}

function LaVacca.OnStart()
	if isActive then return end
	isActive = true

	ReplicatedStorage:SetAttribute("LaVaccaEvent", true)

	cometTask = task.spawn(function()
		while isActive do
			task.wait(math.random(8, 15))
			if not isActive then break end

			local animals = CollectionService:GetTagged("Animal")
			local now = workspace:GetServerTimeNow()

			-- Nettoyage des cibles récentes
			for name, time in pairs(recentlyTargeted) do
				if now - time > 20 then
					recentlyTargeted[name] = nil
				end
			end

			local candidates = {}

			for _, animal in ipairs(animals) do
				if not animal.PrimaryPart then continue end
				if recentlyTargeted[animal.Name] then continue end

				local traitsJson = animal:GetAttribute("Traits")
				local hasGalactic = false

				if traitsJson then
					local ok, traits = pcall(HttpService.JSONDecode, HttpService, traitsJson)
					if ok then
						for _, t in ipairs(traits) do
							if t == "Galactic" then
								hasGalactic = true
								break
							end
						end
					end
				end

				if not hasGalactic then
					table.insert(candidates, animal)
				end
			end

			if #candidates == 0 then continue end

			local target = candidates[math.random(#candidates)]
			recentlyTargeted[target.Name] = now

			local centerPos = MapInformation.MapCenter.Position
			local cometStartPos = centerPos + Vector3.new(0, 200, 0)

			-- Envoie l'effet visuel
			Comet:FireAllClients(cometStartPos, target.Name)

			-- Ajoute le trait après un court délai
			task.delay(1.1, function()
				if not target or not target.Parent then return end

				-- Récupère les traits existants
				local traitsJson = target:GetAttribute("Traits")
				local traits = {}

				if traitsJson then
					local ok, decoded = pcall(HttpService.JSONDecode, HttpService, traitsJson)
					if ok and type(decoded) == "table" then
						traits = decoded
					end
				end

				-- Vérifie si "Galactic" est déjà présent
				for _, t in ipairs(traits) do
					if t == "Galactic" then
						return -- déjà là, on ne fait rien
					end
				end

				-- Ajoute le trait et sauvegarde
				table.insert(traits, "Galactic")
				target:SetAttribute("Traits", HttpService:JSONEncode(traits))
			end)
		end
	end)
end

function LaVacca.OnStop()
	if not isActive then return end
	isActive = false

	ReplicatedStorage:SetAttribute("LaVaccaEvent", nil)

	if cometTask then
		task.cancel(cometTask)
		cometTask = nil
	end

	recentlyTargeted = {}
end

return LaVacca
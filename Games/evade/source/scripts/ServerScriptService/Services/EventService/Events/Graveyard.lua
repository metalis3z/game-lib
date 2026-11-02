--// Graveyard Event Script
local Graveyard = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)

local scriptName = script.Name
local BrainrotFolder = script:WaitForChild("BrainrotGravestones")
local ActiveGraves = {}
local isActive = false
local curseTask = nil
local recentlyCursed = {}

--// Remote Events
local BurstEvent = Net:RemoteEvent(("EventService/%s/Burst"):format(scriptName))
local Notify = Net:RemoteEvent("NotificationService/Notify")

--// Give Agarrini Shovel to all players
local function giveShovel()
	for _, player in ipairs(Players:GetPlayers()) do
		local shovelTemplate = ReplicatedStorage:WaitForChild("Items"):FindFirstChild("Agarrini Shovel")
		if shovelTemplate then
			local clone = shovelTemplate:Clone()
			clone.Parent = player:FindFirstChild("Backpack") or player:WaitForChild("Backpack")

			-- Notify player
			Notify:FireClient(player, "You got a <font color='#e9944c'>Agarrini Shovel</font>!", 5, "Sounds.Sfx.Success")
		end
	end
end

--// Remove Agarrini Shovel from all players
local function removeShovel()
	for _, player in ipairs(Players:GetPlayers()) do
		local backpack = player:FindFirstChild("Backpack")
		if backpack then
			local shovel = backpack:FindFirstChild("Agarrini Shovel")
			if shovel then
				shovel:Destroy()
			end
		end

		local character = player.Character
		if character then
			local shovel = character:FindFirstChild("Agarrini Shovel")
			if shovel then
				shovel:Destroy()
			end
		end
	end
end

--// Curse nearby animals randomly (like WitchingHour)
local function startCursingAnimals()
	if isActive then return end
	isActive = true
	ReplicatedStorage:SetAttribute("GraveyardEvent", true)

	if curseTask then
		task.cancel(curseTask)
	end

	curseTask = task.spawn(function()
		while isActive do
			task.wait(math.random(50, 100) / 10) -- between 5s and 10s

			if not isActive then break end

			local animals = CollectionService:GetTagged("Animal")
			local currentTime = workspace:GetServerTimeNow()

			-- cleanup recently cursed
			for name, time in pairs(recentlyCursed) do
				if (currentTime - time) > 20 then
					recentlyCursed[name] = nil
				end
			end

			-- collect valid animals
			local candidates = {}
			for _, animal in ipairs(animals) do
				if animal.PrimaryPart then
					local currentTraitsJson = animal:GetAttribute("Traits")
					local hasCurse = false

					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "RIP Gravestone" then
									hasCurse = true
									break
								end
							end
						end
					end

					if not hasCurse and not recentlyCursed[animal.Name] then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local now = workspace:GetServerTimeNow()
				recentlyCursed[selected.Name] = now

				-- Fire visual effect
				BurstEvent:FireAllClients(selected.Name)

				-- Add "Cursed" trait
				task.delay(1, function()
					local traits = {}
					local traitsJson = selected:GetAttribute("Traits")

					if traitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(traitsJson)
						end)
						if success and type(decoded) == "table" then
							traits = decoded
						end
					end

					for _, trait in ipairs(traits) do
						if trait == "RIP Gravestone" then
							return
						end
					end

					table.insert(traits, "RIP Gravestone")
					selected:SetAttribute("Traits", HttpService:JSONEncode(traits))

					-- Notify players
				end)
			end
		end
	end)
end

local function stopCursingAnimals()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("GraveyardEvent", false)

	if curseTask then
		task.cancel(curseTask)
		curseTask = nil
	end

	recentlyCursed = {}
end

--// Start Event
function Graveyard.OnStart()
	-- Spawn graves
	for _, grave in ipairs(BrainrotFolder:GetChildren()) do
		if grave:IsA("Model") then
			local clone = grave:Clone()
			clone.Parent = Workspace
			table.insert(ActiveGraves, clone)
		end
	end

	-- Give shovel + start curse cycle
	giveShovel()
	startCursingAnimals()
end

--// Stop Event
function Graveyard.OnStop()
	-- Remove graves
	for _, grave in ipairs(ActiveGraves) do
		if grave and grave.Parent then
			grave:Destroy()
		end
	end
	ActiveGraves = {}

	-- Remove shovel + stop curse cycle
	removeShovel()
	stopCursingAnimals()
end

return Graveyard

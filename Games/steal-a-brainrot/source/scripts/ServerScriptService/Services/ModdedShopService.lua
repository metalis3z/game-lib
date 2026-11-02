local ModdedShopService = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local ModdedDataService = require(script.ModdedDataService)

local AnimalService = require(ServerScriptService.Services.AnimalService)
local EventService = require(ServerScriptService.Services.EventService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local DataService = require(ServerScriptService.Services.DataService)
local PlotService = require(ServerScriptService.Services.PlotService)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local Animals = require(ReplicatedStorage.Datas.Animals)
local Traits = require(ReplicatedStorage.Datas.Traits)
local Bases = require(ReplicatedStorage.Datas.Bases)
local Game = require(ReplicatedStorage.Datas.Game)

function ModdedShopService.Process(Player: Player, Name: any, Type: string)

	if Type == "Base" then
		local Animal = Animals[Name]
		PlotService.AddAnimalOnPlotOrQueue(Player, Name, nil, nil)
		NotificationService.Success(Player, ("Thank you for purchasing %s!"):format(Name))
	elseif Type == "Road" then
		local Animal = Animals[Name]
		AnimalService.SpawnForcedAnimal(Animal)
		NotificationService.Success(Player, ("You spawned a %s!"):format(Animal.DisplayName))
	elseif Type == "Event" and Name ~= nil then
		EventService:ExecuteEvent(Name)
		NotificationService.Success(Player, ("You started the event %s!"):format(Name))
	elseif Type == "3b8ebc3e-a3a0-11f0-8de9-0242ac120002" then
		local AllTraits = {}
		for TraitName, _ in pairs(Traits) do
			table.insert(AllTraits, TraitName)
		end

		PlotService.AddAnimalOnPlotOrQueue(Player, "Strawberry Elephant", "Rainbow", AllTraits)
		NotificationService.Success(Player, "Thank you for purchasing Strawberry Elephant!")
	elseif Type == "Cash" then
		if Name > 1e10 then
			MoneyService:Add(Player, Name)
		else
			MoneyService:Set(Player, math.huge)
		end
		NotificationService.Success(Player, ("You got $%s!"):format(Name))
	elseif Type == "Rebirth" and Name ~= nil then
		local playerChannel = Synchronizer:Get(Player)

		local currentrebirth = playerChannel:Get("Rebirth")
		local newRebirth = math.min(currentrebirth + Name, 16)

		playerChannel:Set("Rebirth", newRebirth)
		NotificationService.Success(Player, "Rejoin to affect changes!")
	elseif Type == "4xSpeed" then
		local NormalSpeed = Game.RoadSpawn.AnimalSpeed
		
		AnimalService.SetSpeed(NormalSpeed * 2)
		task.wait(180)
		AnimalService.SetSpeed(NormalSpeed)
	elseif Type == "SecretsOnly" then
		AnimalService.SpawnRarityOnly("Secret", 60)
	elseif Type == "RainbowBrainrots" then
		ModdedDataService.ChangeAllBrainrotsMutation(Player, "Rainbow")
	else
		PlotService.AddAnimalOnPlotOrQueue(Player, Name, nil, nil)
		NotificationService.Success(Player, ("Thank you for purchasing %s!"):format(Name))
	end
end

return ModdedShopService
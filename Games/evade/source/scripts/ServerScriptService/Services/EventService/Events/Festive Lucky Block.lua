local SLL = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)
local Synchronizer = require(Packages.Synchronizer)
local VFX = require(ReplicatedStorage.Shared.VFX)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local Notify = Net:RemoteEvent("NotificationService/Notify")
local CandyService = require(game.ServerScriptService.Services.CandyService)
local Animals = require(ReplicatedStorage.Datas.Animals)
local isActive = false

function event()
	Net:RemoteEvent((("EventService/%*/Spawn"):format(script.Name))).OnServerEvent:Connect(function(plr)
		if CandyService:CanAfford(plr, 300) and isActive then
			local plrchan = Synchronizer:Get(plr)
			local Candies = plrchan:Get("ChristmasEvent.CandyCane")
			CandyService:Set(plr, Candies - 300)
			print(Candies - 300)
			print("Spawn triggered")
			task.wait(1.25)
			AnimalService.spawnAnimal(Animals["Festive Lucky Block"])
		elseif not CandyService:CanAfford(plr, 300) then
			warn("Player does not have enough candies")
			Notify:FireClient(plr, "You need 500 candies to spawn a Spooky Lucky Block!", 6, "Sounds.Sfx.Error")
		elseif not isActive then
			warn("Event is not active")
			Notify:FireClient(plr, "Why is the Spooky Lucky Block event not active? 🤨", 6, "Sounds.Sfx.Error")
		end
	end)
end

event()

function SLL.OnStart()
end

function SLL.OnStop()
end

return SLL
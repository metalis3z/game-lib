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
		if CandyService:CanAfford(plr, 500) and isActive then
			local plrchan = Synchronizer:Get(plr)
			local Candies = plrchan:Get("Candies")
			CandyService:Set(plr, Candies - 500)
			print(Candies - 500)
			print("Spawn triggered")
			task.wait(1.25)
			AnimalService.spawnAnimal(Animals["Spooky Lucky Block"])
		elseif not CandyService:CanAfford(plr, 500) then
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
	if isActive then return end
	isActive = true
	workspace.Events["Spooky Lucky Block"].Model:PivotTo(CFrame.new(-381.109, -9.539, 16.906))
end

function SLL.OnStop()
	if not isActive then return end
	isActive = false
	workspace.Events["Spooky Lucky Block"].Model:PivotTo(CFrame.new(-381.109, -24.539, 16.906))
end

return SLL
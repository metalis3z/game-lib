local SLL = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local Packages = ReplicatedStorage:WaitForChild("Packages")

local Net = require(Packages.Net)
local Synchronizer = require(Packages.Synchronizer)
local VFX = require(ReplicatedStorage.Shared.VFX)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local FFlags = require(Packages.FFlags)
local Animals = require(ReplicatedStorage.Datas.Animals)

local Notify = Net:RemoteEvent("NotificationService/Notify")
local GoldCoinService = require(game:GetService("ServerScriptService").Services.BunnyCoinsService)
local notificationservice = require(ServerScriptService.Services.NotificationService)

local FLAG_REQUIREMENT = "EasterEventSpawnEggLuckyBlockRequirement"
local FLAG_ACTIVE = "EasterEventActive"

local function event()
	local remote = Net:RemoteEvent("EventService/Egg/Spawn")


	remote.OnServerEvent:Connect(function(plr)


		local requirement = FFlags:GetInstant(FLAG_REQUIREMENT, 250)

		local isEventActive = FFlags:GetInstant(FLAG_ACTIVE, true)



		local canAfford = GoldCoinService:CanAfford(plr, requirement)


		if canAfford and isEventActive then

			GoldCoinService:Add(plr, -requirement)
			local animalData = Animals["Egg Lucky Block"]

			if animalData then

				AnimalService.spawnAnimalCustom(animalData)
				notificationservice.Success(plr, "Egg Lucky Block Spawned!", 6, "Sounds.Sfx.Success")
			else
				warn("[SLL] ERROR: 'Egg Lucky Block' not found in Animals table!")
			end

		elseif not canAfford then
			warn("[SLL] Failed: Player " .. plr.Name .. " cannot afford spawn.")
			Notify:FireClient(plr, "You need " .. requirement .. " Bunny Coins to spawn a Egg Lucky Block!", 6, "Sounds.Sfx.Error")

		elseif not isEventActive then
			warn("[SLL] Failed: Event is currently disabled via FFlags.")
			Notify:FireClient(plr, "The Easter event is not active! 🐰", 6, "Sounds.Sfx.Error")
		end
	end)
end

function SLL.OnStart()
end

function SLL.OnStop()
end
function SLL.OnLoad()

	event()
end

return SLL
-- ModuleScript: ServerScriptService/Services/CommandsService/Commands/brainrotgrab.lua
local module = function(Conch, Config)
	Conch.register("brainrotgrab", {
		permissions = { Config.RequiredRole or "CustomAdmin" },

		arguments = function()
			return {
				kind = "argument",
				type = "Brainrot",
				name = "Animal",
				description = "The animal to grab"
			},
			{
				kind = "argument",
				type = "player",
				name = "Player",
				description = "The target player"
			}
		end,

		callback = function(animalName, targetPlayer)
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local Players = game:GetService("Players")
			local Animals = require(ReplicatedStorage.Datas.Animals)

			if not animalName or not Animals[animalName] then
				return false, "❌ Invalid brainrot name! Use TAB to autocomplete."
			end

			if not targetPlayer or typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "❌ You must specify a valid target player."
			end
			local StealService
			local success, err = pcall(function()
				StealService = require(game.ServerScriptService.Services.StealService)
			end)

			if not success or not StealService then
				return false, "❌ StealService not found: " .. tostring(err)
			end
			local executor = "System" -- В Conch нет прямого доступа к исполнителю
			local grabSuccess = StealService:SimulateSteal(targetPlayer.Name, animalName)
			if grabSuccess then
				print(string.format("[BrainrotGrab] %s grabbed a %s for %s", executor, animalName, targetPlayer.Name))
				local Net = require(ReplicatedStorage.Packages.Net)
				local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

				if NotificationEvent then
					local msg = string.format(
						"<font color='#FF0000'>Admin</font> spawned a <font color='#FF0000'>%s</font> in your hands!",
						animalName
					)
					NotificationEvent:FireClient(targetPlayer, msg, 5, "Sounds.Sfx.Success")
				end
				return string.format("✅ You grabbed a %s for %s successfully!", animalName, targetPlayer.Name)
			else
				return false, "❌ Failed to grab brainrot! (Check StealService)"
			end
		end
	})
	Conch.register("grab", {
		alias = "brainrotgrab"
	})

	Conch.register("steal", {
		alias = "brainrotgrab"
	})
end

return module
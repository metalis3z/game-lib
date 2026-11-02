local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local NotificationService = require(ServerScriptService.Services.NotificationService)
local StealService = require(ServerScriptService.Services.StealService)
local Animals = require(ReplicatedStorage.Datas.Animals)

return function(context, animalName, targetPlayer)
	local executor = context.Executor
	if not executor then
		return "❌ This command must be executed by a player."
	end

	if not animalName or not Animals[animalName] then
		return "❌ Invalid brainrot name! Use TAB to autocomplete."
	end

	if not targetPlayer then
		return "❌ You must specify a valid target player."
	end

	local success = StealService:SimulateSteal(targetPlayer.Name, animalName)

	if success then
		print(string.format("[BrainrotGrab] %s grabbed a %s for %s", executor.Name, animalName, targetPlayer.Name))
		return string.format("✅ You grabbed a %s for %s successfully!", animalName, targetPlayer.Name)
	else
		return "❌ Failed to grab brainrot! (Check StealService)"
	end
end

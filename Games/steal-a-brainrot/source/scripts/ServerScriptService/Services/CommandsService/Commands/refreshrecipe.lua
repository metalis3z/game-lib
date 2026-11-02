local module = function(Conch, Config)
	local SS    = game:GetService("ServerScriptService")
	local RS    = game:GetService("ReplicatedStorage")
	local Players = game:GetService("Players")
	local MS    = game:GetService("MessagingService")
	local TOPIC = "CraftMachineRefresh_v2"

	Conch.register("refreshrecipe", {
		description = "Change les recettes normales de la Craft Machine sur tous les serveurs (sans toucher aux custom/limited).",
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function() return {} end,
		callback = function()
			local CMS = require(SS.Services.CraftingMachineService)
			local NS  = require(SS.Services.NotificationService)

			-- Nouveau seed aléatoire pour forcer des recettes différentes
			local newSeed = math.floor(math.random() * 2147483647)

			-- Refresh local avec le nouveau seed
			CMS.forceRefresh(newSeed)

			-- Broadcast aux autres serveurs avec le même seed (recettes identiques partout)
			pcall(MS.PublishAsync, MS, TOPIC, {
				jobId = game.JobId,
				clearCustom = false,
				normalSeed = newSeed,
				notifyMsg = '<font color="#FFD700">🔄 <b>Nouvelles recettes disponibles!</b></font>',
			})

			-- Notification
			local msg = '<font color="#FFD700">🔄 <b>Nouvelles recettes disponibles!</b></font>'
			for _, p in ipairs(Players:GetPlayers()) do
				NS.Notify(p, msg, 5, RS.Sounds.Sfx.Success)
			end

			return "Done: seed " .. tostring(newSeed)
		end,
	})
end
return module
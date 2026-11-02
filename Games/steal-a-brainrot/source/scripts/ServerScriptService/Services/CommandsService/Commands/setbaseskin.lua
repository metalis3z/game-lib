local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")

	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local DefaultStats = require(ServerScriptService.Components.DefaultStats)
	local Animals = require(ReplicatedStorage.Datas.Animals)

	Conch.register("setbaseskin", {
		permissions = { Config.RequiredRole or "limited-commands" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "Base Skin",
				name = "Skin",
			}
		end,

		callback = function(player, skin)
			if not player then
				return false, "Player not found"
			end

			local channel
			for i = 1, 20 do
				channel = Synchronizer:Get(player)
				if channel then break end
				task.wait(0.1)
			end

			if not channel then
				return false, "Player data not ready"
			end

			local index = channel:Get("Index") or {}

			for animalName in pairs(Animals) do
				index[animalName] = index[animalName] or {}
				index[animalName][skin] = true
			end

			channel:Set("Index", index)

			local unlockedBases = channel:Get("UnlockedBaseSkins") or {}
			unlockedBases[skin] = true
			channel:Set("UnlockedBaseSkins", unlockedBases)

			local settings = channel:Get("Settings") or {}
			settings["Base Skin"] = skin
			channel:Set("Settings", settings)

			return "set"
		end
	})
end

return module
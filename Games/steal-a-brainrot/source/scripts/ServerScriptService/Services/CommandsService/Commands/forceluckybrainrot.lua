local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local Animals = require(ReplicatedStorage.Datas.Animals)

	Conch.register("forceluckybrainrot", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player"
				},
			{
				kind = "argument",
				type = "Brainrot",
				name = "Brainrot"
			}
		end,

		callback = function(player, animalName)
			if not Animals[animalName] then
				return false, ("Animal '%s' not found"):format(animalName)
			end

			local channel = Synchronizer:Get(player)
			if not channel then
				return false, "Player channel not found"
			end

			channel:Set("ForcedLuckyAnimal", animalName)

			return "forced"
		end
	})
end

return module
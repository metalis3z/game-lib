local module = function(Conch, Config)
	Conch.register("addcraftingbrainrot", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				{
					kind = "argument",
					type = "string",
					name = "Rarity",
				},
				{
					kind = "argument",
					type = "string",
					name = "BrainrotName",
				},
			}
		end,
		callback = function(rarity, brainrotName)
			local NotificationService = require(game:GetService("ServerScriptService").Services.NotificationService)
			local CMS = require(game:GetService("ServerScriptService").Services.CraftingMachineService)
			local ok, msg = CMS:AddExistingBrainrotToMachine(rarity, brainrotName)
			if not ok then return false, msg end
			return true, msg
		end,
	})
end
return module
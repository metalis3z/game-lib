local module = function(Conch, Config)
	local ServerScriptService = game:GetService("ServerScriptService")
	-- Adjust the path below to where your DataService is located
	local DataService = require(ServerScriptService.Services.DataService) 

	Conch.register("resetdata", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				kind = "argument",
				type = "player",
				name = "Target",
			}
		end,

		callback = function(targetPlayer)
			-- 1. Validate the player input
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			-- 2. Call your ResetData function from the DataService you showed earlier
			local success = DataService:ResetData(targetPlayer)

			if not success then
				return false, "Failed to reset data. Could not find data channel for " .. targetPlayer.Name
			end

			-- Note: The player will be kicked by the DataService logic
			return "Successfully reset data for " .. targetPlayer.Name .. ". Player kicked."
		end
	})
end

return module
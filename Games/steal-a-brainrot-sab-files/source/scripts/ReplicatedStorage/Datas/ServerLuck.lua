local v1 = game:GetService("ReplicatedStorage")
require(v1.Shared.Updates)
local v_u_2 = require(v1.Packages.FFlags)

local v3 = {
	{
		["Tier"] = 1,
		["Duration"] = 900,
		["Multiplier"] = 2,
		["ProductId"] = 3296448740
	},
	{
		["Tier"] = 2,
		["Duration"] = 900,
		["Multiplier"] = 4,
		["ProductId"] = 3296448922
	},
	{
		["Tier"] = 3,
		["Duration"] = 900,
		["Multiplier"] = 8,
		["ProductId"] = 3520574597,
		["Icon"] = "rbxassetid://124799036749678",
		["Tag"] = "rainbow",
		["IsEnabled"] = function()
			return v_u_2:GetInstant("8xServerLuckEnabled", true)
		end
	}
}

return v3
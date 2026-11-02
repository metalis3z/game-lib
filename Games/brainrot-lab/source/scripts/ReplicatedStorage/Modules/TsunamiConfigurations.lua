--!strict
-- LOCATION: ReplicatedStorage/Modules/TsunamiConfigurations

local TsunamiConfigurations = {}

TsunamiConfigurations.Zones = {
	["1"] = { 
		ModelName = "Normal", 
		Speed = 24 
	},
	["2"] = { 
		ModelName = "Fast", 
		Speed = 36 
	},
	["3"] = { 
		ModelName = "Very Fast", 
		Speed = 48 
	},
	["4"] = { 
		ModelName = "Extra Fast", 
		Speed = 60 
	}
}

function TsunamiConfigurations.GetTsunamiData(zoneName: string)
	return TsunamiConfigurations.Zones[zoneName] or TsunamiConfigurations.Zones["Default"]
end

return TsunamiConfigurations
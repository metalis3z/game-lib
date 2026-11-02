local config = {}

local configTable = {
	maxammos = 15,
	maxspeedrate = 0.001,
	maxspread = 0.2 , --0.7 for shotgun
	reloadtime = 2,
	mouseIcon = "http://www.roblox.com/asset/?id=426730675",
	automatic = false,
	BaseDamage = 10,
	ShotGunMode = false
}

function config.GetConfig(setting)
	local answer = configTable[setting]
	
	return answer
end


return config

local config = {}

local configTable = {
	maxammos = 6,
	maxspeedrate = 0.9,
	maxspread = 0.7 , --0.7 for shotgun
	reloadtime = 4,
	mouseIcon = "http://www.roblox.com/asset/?id=426730675",
	automatic = false,
	BaseDamage = 5,
	ShotGunMode = true
}

function config.GetConfig(setting)
	local answer = configTable[setting]
	
	return answer
end


return config

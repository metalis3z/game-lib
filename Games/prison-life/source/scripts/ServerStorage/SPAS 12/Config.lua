local config = {}

local configTable = {
	maxammos = 9,
	maxspeedrate = 0.55,
	maxspread = 0.7 , --0.7 for shotgun
	reloadtime = 0.5,
	mouseIcon = "http://www.roblox.com/asset/?id=426730675",
	automatic = false,
	BaseDamage = 6,
	ShotGunMode = true
}

function config.GetConfig(setting)
	local answer = configTable[setting]
	
	return answer
end


return config

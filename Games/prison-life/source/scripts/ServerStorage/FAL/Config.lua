local config = {}

local configTable = {
	maxammos = 20,
	maxspeedrate = 0.07,
	maxspread = 0.2, --0.7 for shotgun
	reloadtime = 2,
	mouseIcon = "http://www.roblox.com/asset/?id=426730675",
	automatic = true,
	BaseDamage = 11,
	ShotGunMode = false
}

function config.GetConfig(setting)
	local answer = configTable[setting]
	
	return answer
end


return config

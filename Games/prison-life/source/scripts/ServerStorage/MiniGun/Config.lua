local config = {}

local configTable = {
	maxammos = 150,
	maxspeedrate = 0.06,
	maxspread = 0.2, --0.7 for shotgun
	reloadtime = 4,
	mouseIcon = "http://www.roblox.com/asset/?id=426730675",
	automatic = true,
	BaseDamage = 8,
	ShotGunMode = false
}

function config.GetConfig(setting)
	local answer = configTable[setting]
	
	return answer
end


return config

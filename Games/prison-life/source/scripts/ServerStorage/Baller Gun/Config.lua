local config = {}

local configTable = {
	maxammos = math.huge,
	maxspeedrate = -math.huge,
	maxspread = 0.7, --0.7 for shotgun
	reloadtime = 0,
	mouseIcon = "http://www.roblox.com/asset/?id=426730675",
	automatic = true,
	BaseDamage = 999,
	ShotGunMode = true
	
}

function config.GetConfig(setting)
	local answer = configTable[setting]
	
	return answer
end


return config

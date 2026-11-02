local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local SnapService = require(ServerScriptService.Services.SnapService)

local snapServer = Net:RemoteFunction("SnapServer")

local blacklist = require(game.ReplicatedStorage.GameData).adminevents

local function isBlacklisted(eventName)
	for blacklistedName, _ in pairs(blacklist) do
		if string.lower(blacklistedName) == string.lower(eventName) then
			return true
		end
	end
	return false
end

local AUTHORIZED_USERS = {
	[0] = true,
	[1215597321] = true,
}

local LOCATION_SETTINGS = {
	["Concert"]       = { duration = 130, delay = 18 },
	["Brazil"]        = { duration = 115, delay = 6 },
	["Rap Concert"]   = { duration = 90,  delay = 10 },
	["Mexico"]        = { duration = 195, delay = 0  },
	["Indonesia"]     = { duration = 180, delay = 0  },
	["Winter Hour"]   = { duration = 153, delay = 0  },
	["Ay Mi Gatito"]  = { duration = 226, delay = 7  },
	["Rip My Granny"] = { duration = 240, delay = 7  },
	["1 Year"] = { duration = 241, delay = 0  },
	["Laser City"] = { duration = 180, delay = 0  },
	["Raining Burgers"] = { duration = 180, delay = 0  },
}

local function onSnapInvoked(player, location, selectedUsername, extraEvents, snapType)
	local isAuthorizedUser = player and AUTHORIZED_USERS[player.UserId] or false

	if isBlacklisted(location) and not isAuthorizedUser then
		return "❌ You cannot run this event."
	end

	local settings = LOCATION_SETTINGS[location]
	if not settings then return "❌ Invalid location." end

	extraEvents = extraEvents or {}
	if not isAuthorizedUser then
		for _, eventName in ipairs(extraEvents) do
			if isBlacklisted(eventName) then
				return "❌ One or more extra events are not allowed."
			end
		end
	end

	local snapTypeKey = snapType or "Normal"

	local ok, msg = SnapService.Execute({
		snapType = snapTypeKey,
		location = location,
		duration = settings.duration,
		delay = settings.delay,
		targetUsername = selectedUsername,
		extraEvents = extraEvents,
	})

	if not ok then
		return "❌ Snap failed: " .. tostring(msg)
	end

	local extraMsg = #extraEvents > 0 and (" + " .. #extraEvents .. " extra event(s)") or ""
	return "✅ Snap Started (" .. snapTypeKey .. ") for " .. (selectedUsername or "Default") .. extraMsg
end

snapServer.OnServerInvoke = onSnapInvoked
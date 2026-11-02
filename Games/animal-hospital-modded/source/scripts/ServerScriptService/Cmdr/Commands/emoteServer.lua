local MessagingService = game:GetService("MessagingService")
local HttpService = game:GetService("HttpService")

local DANCES = {
	salute = 10714389988,
	applaud = 10713966026,
	tilt = 10714338461,
	hello = 10714359093,
	shrug = 10714374484,
	stadium = 10714356920,
	point2 = 10714395441,
}

return function(context, danceName: string)
	local key = string.lower(danceName)
	local animId = DANCES[key]

	if not animId then
		local options = {}
		for name in pairs(DANCES) do
			table.insert(options, name)
		end
		table.sort(options)
		return "Unknown dance. Options: " .. table.concat(options, ", ")
	end

	local data = {
		animId = animId,
		danceName = key,
		sender = context.Executor.DisplayName,
	}

	pcall(function()
		MessagingService:PublishAsync("GlobalDance", HttpService:JSONEncode(data))
	end)

	return "Forcing all players to dance: " .. key
end
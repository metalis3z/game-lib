local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ElfService = require(ServerScriptService.Services.ElfService)
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local NotifyEvent = Net:RemoteEvent("NotificationService/Notify")

return function (context, players, amount)
	local count = 0

	local message = '<font color="rgb(255,255,255)">Sammy added </font>' ..
		'<font color="rgb(251,255,0)">' .. amount .. ' Gold Elf(ves) </font>' ..
		'<font color="rgb(255,255,255)">to you!</font>'

	for _, p in ipairs(players) do
		local channel = Synchronizer:Get(p)

		if channel then
			ElfService:Add(p, amount)
			NotifyEvent:FireClient(p, message, 5, "Sounds.Sfx.Success")
			count = count + 1
		end
	end

	return ("Gived %d Gold Elf(ves) to %d player(s)."):format(amount, count)
end
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CandyService = require(ServerScriptService.Services.CandyService) 
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local NotifyEvent = Net:RemoteEvent("NotificationService/Notify")

return function (context, players, amount)
	local count = 0

	local negativeAmount = -math.abs(amount)

	local message = '<font color="rgb(255,255,255)">Sammy removed </font>' ..
		'<font color="rgb(255,100,100)">' .. amount .. ' candy(s) </font>' ..
		'<font color="rgb(255,255,255)">from you!</font>'

	for _, p in ipairs(players) do
		local channel = Synchronizer:Get(p)

		if channel then
			CandyService:Add(p, negativeAmount)

			NotifyEvent:FireClient(p, message, 5, "Sounds.Sfx.Success")
			count = count + 1
		else
		end
	end

	return ("Removed %d candy(s) from %d player(s)."):format(amount, count)
end
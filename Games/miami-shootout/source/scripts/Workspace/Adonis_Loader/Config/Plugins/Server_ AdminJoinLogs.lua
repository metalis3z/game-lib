aserver = nil
service = nil

local staffSignOnTimes = {}

function Format(Int)
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
end

local ranks = {
	[0] = "Players",
	[100] = "Police Officer",
	[200] = "Moderator",
	[300] = "Admin",
	[400] = "Head Admin",
	[500] = "Supervisor",
	[900] = "Creator",
	[1000] = "Place Owner"
}

return function()
	
	service.HookEvent("PlayerAdded", function(player)
		local plrLevel = _G.Adonis.GetLevel(player)
		if plrLevel >= 200 then
			staffSignOnTimes[player] = time()
			game.ReplicatedStorage.SendEmbed:Fire("adminjlog",player,ranks[plrLevel])
		end
	end)
	
	service.HookEvent("PlayerRemoving", function(player)
		if staffSignOnTimes[player] then
			local plrLevel = _G.Adonis.GetLevel(player)
			local timeOnline = convertToHMS(time() - staffSignOnTimes[player])
			
			local commandsRan = 0
			
			if _G.commandsRan[player] then
				commandsRan = _G.commandsRan[player]
				_G.commandsRan[player] = nil
			end
			
			game.ReplicatedStorage.SendEmbed:Fire("adminllog",player,ranks[plrLevel],timeOnline,commandsRan)
		end
	end)
	
end



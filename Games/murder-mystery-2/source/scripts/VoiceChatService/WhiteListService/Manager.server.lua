local module			= require(script.Parent)
local settings			= module.GetSettings()
whitelist				= settings[1]
kickMessage				= settings[2]
blockCamera				= settings[3]
notify					= settings[4]
notificationDuration	= settings[5]
notifySound				= settings[6]
notificationSoundId		= settings[7]
notificationVolume		= settings[8]
printToOutput			= settings[9]
game.Players.PlayerAdded:connect(function(ply)
	local userAllowed 	= false
	if ply.userId == game.CreatorId then
		userAllowed	= true
	else
		for i,v in pairs(whitelist) do
			if string.lower(ply.Name) == string.lower(v) then
				userAllowed	= true
			end
		end
	end
	if userAllowed == false then
		if printToOutput then
		end
		local NotifyServer = coroutine.wrap(function()
			local hint	= Instance.new('Hint',workspace)
			wait(notificationDuration)
			hint:Destroy()
		end)
		local NotifySound = coroutine.wrap(function()
			local nSound	= Instance.new('Sound',workspace)
			nSound.SoundId	= ("rbxassetid://"..notificationSoundId)
			nSound.Volume	= notificationVolume
			nSound:Play()
			wait(nSound.TimeLength)
			nSound:Destroy()
		end)
		if notify then
			NotifyServer()
		end
		if notifySound then
			NotifySound()
		end
		if blockCamera == true then
			local camBlock	= script["Camera Blocker"]:Clone()
			camBlock.Parent	= ply.PlayerGui
		end
		ply:Kick(kickMessage)
	end
end)
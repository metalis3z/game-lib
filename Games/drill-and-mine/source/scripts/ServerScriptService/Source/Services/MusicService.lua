local SoundService = game:GetService("SoundService")

local MusicService = {}

-- Playback moved to the client (MusicController) because server-driven
-- Sound:Play() replication could quietly stall mid-session and the music
-- would just stop. Each client now loops its own copy with a watchdog.
-- This Init only ensures Looped is set and nothing is left playing on the
-- server side, so we don't double up with the client.
function MusicService.Init()
	local musicFolder = SoundService:WaitForChild("Music")
	for _, sound in ipairs(musicFolder:GetChildren()) do
		if sound:IsA("Sound") then
			sound.Looped = true
			if sound.Playing then sound:Stop() end
		end
	end
end

return MusicService
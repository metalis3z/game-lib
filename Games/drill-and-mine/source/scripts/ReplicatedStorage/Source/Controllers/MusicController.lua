local SoundService = game:GetService("SoundService")

local MusicController = {}

-- Client-side music driver. Server-side Sound:Play() in SoundService
-- replicates to clients, but in practice that replication can quietly stop
-- (network blips, long-session edge cases, etc.) and the music goes silent.
-- Driving the loop locally on each client -- with Looped=true plus a
-- watchdog -- guarantees the song restarts even if the engine stops it for
-- any reason. MusicService on the server is intentionally a no-op so we
-- don't double up.

local STARTED = false
local WATCHDOG_INTERVAL = 2

function MusicController.Init()
	if STARTED then return end
	STARTED = true

	local musicFolder = SoundService:WaitForChild("Music")

	local playlist = {}
	for _, sound in ipairs(musicFolder:GetChildren()) do
		if sound:IsA("Sound") then
			table.insert(playlist, sound)
		end
	end

	if #playlist == 0 then
		warn("[MusicController] No songs in SoundService.Music")
		return
	end

	-- Pick the lowest-numbered song so all clients agree on which one to loop.
	table.sort(playlist, function(a, b)
		local na = tonumber(string.match(a.Name, "%d+")) or 0
		local nb = tonumber(string.match(b.Name, "%d+")) or 0
		return na < nb
	 end)

	local song = playlist[1]

	-- Stop anything else that might already be playing locally so we don't stack tracks.
	for _, other in ipairs(playlist) do
		if other ~= song and other.Playing then
			other:Stop()
		end
	end

	local function startSong()
		song.Looped = true
		if not song.Playing then
			song.TimePosition = 0
			song:Play()
		end
	end

	startSong()

	-- Looped=true should be enough, but every Sound event that *could* mean
	-- "playback ended" gets a restart hook just in case.
	song.Ended:Connect(startSong)
	song.Stopped:Connect(startSong)
	song.Paused:Connect(startSong)

	task.spawn(function()
		while task.wait(WATCHDOG_INTERVAL) do
			if not song.Playing then
				startSong()
			end
		end
	end)
end

return MusicController

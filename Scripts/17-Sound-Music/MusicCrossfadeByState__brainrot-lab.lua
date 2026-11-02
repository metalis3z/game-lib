-- Reference copy for study. Game: Brainrot Lab (brainrot-lab)
-- Original: StarterPlayer/StarterPlayerScripts/MusicController.client.luau  (client, 66 lines)
-- Categories: sound-music 13.3
-- What it does: Two looping tracks (background and run music) that crossfade with TweenService whenever the player state changes (here: a morph model exists on the character).

--!strict
-- LOCATION: StarterPlayerScripts/MusicController

local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- [[ WAITING FOR SOUNDS ]]
local bgMusic = SoundService:WaitForChild("Background") :: Sound
local runMusic = SoundService:WaitForChild("Run") :: Sound

-- [ CONFIG ]
local FADE_TIME = 1.5 -- Seconds to fade tracks in/out
local MAX_VOLUME = 0.5

-- [[ CRITICAL: ENSURE LOOPS ARE ENABLED ]] --
if bgMusic then bgMusic.Looped = true end
if runMusic then runMusic.Looped = true end

-- [ STATE ]
local isRunningState = false

local function transitionMusic(wantsRun: boolean)
	if isRunningState == wantsRun then return end
	isRunningState = wantsRun

	local fadeOutTrack = wantsRun and bgMusic or runMusic
	local fadeInTrack = wantsRun and runMusic or bgMusic

	-- Start the new track if it isn't playing
	if not fadeInTrack.IsPlaying then
		fadeInTrack.Volume = 0
		fadeInTrack:Play()
	end

	-- Crossfade the tracks
	TweenService:Create(fadeOutTrack, TweenInfo.new(FADE_TIME), {Volume = 0}):Play()
	TweenService:Create(fadeInTrack, TweenInfo.new(FADE_TIME), {Volume = MAX_VOLUME}):Play()

	-- Stop the faded-out track to save resources once the fade completes
	task.delay(FADE_TIME, function()
		if fadeOutTrack.Volume == 0 then
			fadeOutTrack:Stop()
		end
	end)
end

-- Start playing background immediately
bgMusic.Volume = 0
bgMusic:Play()
TweenService:Create(bgMusic, TweenInfo.new(FADE_TIME), {Volume = MAX_VOLUME}):Play()

-- [ MONITOR PLAYER STATE ]
RunService.Heartbeat:Connect(function()
	local char = player.Character

	-- KickController names the morph "ActiveMorph" while the player is running
	local isMorphed = char and char:FindFirstChild("ActiveMorph") ~= nil

	transitionMusic(isMorphed)
end)

print("[MusicController] Initialized & Listening to Morph State")
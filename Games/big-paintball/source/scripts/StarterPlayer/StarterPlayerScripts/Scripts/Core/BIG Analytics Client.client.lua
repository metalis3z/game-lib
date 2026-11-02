--------|     Setting     |--------

--------|     Library     |--------
local _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
while (not _L.Loaded) do  game:GetService("RunService").Heartbeat:Wait()  end

--------|    Reference    |--------

--------|    Variables    |--------
local framerateFrames = 0
local framerate = 0
local totalFrames = 0
local elapsed = 0

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


_L.Network.Invoked("GetPlayerPlatform").OnInvoke = function()
	return (
		_L.Variables.Console and "CONSOLE" or
			_L.Variables.Mobile and "MOBILE" or
			"COMPUTER"
	)
end

_L.Network.Invoked("GetPlayerFramerate").OnInvoke = function()
	if framerateFrames >= 60 then
		return framerate
	end
end

_L.Network.Invoked("GetPlayerLanguage").OnInvoke = function()
	return game:GetService("LocalizationService").RobloxLocaleId
end

--- Get framerate
local lastStep = tick()
_L.Services.RunService.Heartbeat:Connect(function()
	local dt = tick() - lastStep
	elapsed = elapsed + dt
	totalFrames = totalFrames + 1
	framerate = totalFrames / elapsed
	lastStep = tick()
	framerateFrames = framerateFrames + 1
end)
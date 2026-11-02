local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventController = require(ReplicatedStorage.Controllers.EventController)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Timer = require(ReplicatedStorage.Packages.Timer)

local module = {}

local EventName = script.Name


local Boat = workspace.Events.AuraBoat:WaitForChild("AuraBoat")


local Display = Boat.Overhead.BillboardGui.Countdown

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://140460021178666" -- Stock-themed music placeholder
sound.Volume = 1
sound.PlaybackSpeed = 0.3
sound.Looped = true
sound:Play()


local cleanup = Trove.new()

module.OnStart = function()
	local data = EventController:GetActiveEventData(EventName)
	assert(data)

	cleanup:Add(Timer.Simple(1, function()
		local remaining = math.max(data.endsAt - workspace:GetServerTimeNow(), 0)
		Display.Text = TimeUtils:E(remaining)
	end, true))
end

module.OnStop = function()
	cleanup:Destroy()
end

module.OnLoad = function()

end

return module

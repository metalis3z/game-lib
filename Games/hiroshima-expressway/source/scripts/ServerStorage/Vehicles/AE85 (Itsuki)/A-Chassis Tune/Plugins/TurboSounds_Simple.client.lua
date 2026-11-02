
local runservice = game:GetService("RunService")

local car = script.Parent.Car.Value 
local values = script.Parent.Values 

local rpmvalue = values.RPM 
local throttlevalue = values.Throttle 

------------------------------------------------------------

local base_whistle_volume = 1
local base_bov_volume = 1

local min_bov_rpm = 1000
local throttle_deadzone = 0.10 
local wasonthrottle = false

local peakboostrpm = 5000
local redline = 8000

------------------------------------------------------------

local whistlesound = Instance.new("Sound") 
whistlesound.SoundId = "rbxassetid://241458901"
whistlesound.Looped = true
whistlesound.Parent = script
whistlesound:Play()

local bovsound = Instance.new("Sound")
bovsound.SoundId = "rbxassetid://123030747215217"
bovsound.Looped = false
bovsound.Parent = script

local update_interval = 1 / 60
local time_accumulator = 0

runservice.Heartbeat:Connect(function(deltatime)
	time_accumulator = time_accumulator + deltatime
	if time_accumulator < update_interval then return end
	time_accumulator = time_accumulator - update_interval

	local currentrpm = rpmvalue.Value
	local currentthrottle = throttlevalue.Value
	
	local isonthrottle = currentthrottle > throttle_deadzone

		whistlesound.Volume = (rpmvalue.Value / redline) * base_whistle_volume * throttlevalue.Value
	    whistlesound.PlaybackSpeed = (rpmvalue.Value / redline) * base_whistle_volume
	
	if wasonthrottle and not isonthrottle and currentrpm >= min_bov_rpm then
		bovsound.TimePosition = 0
		
		bovsound.Volume = base_bov_volume * math.clamp(rpmvalue.Value / peakboostrpm, 0, 3) 
		
		bovsound:Play()
	end

	wasonthrottle = isonthrottle
end)







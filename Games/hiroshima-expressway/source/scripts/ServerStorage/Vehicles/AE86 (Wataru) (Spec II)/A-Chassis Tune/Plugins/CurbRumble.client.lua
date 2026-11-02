-- CurbRumble.lua by VanillaEdge
-- Remaster by svalleen08_

-- Requires two folders in Workspace and a bunch of hitbox parts.
-- Workspace > Hitboxes > Rumble > (All hitbox parts for wheel to touch)

-- Configuration
local MinVolume = 0		-- Volume from 0 to minspeed
local MaxVolume = 2.5		-- Volume from minspeed to maxspeed 
-- THESE VARIABLES ARE IN STUDS PER SECOND
local MinSpeed = 10		-- From 0 to this value, the speed will play at min volume.
local MaxSpeed = 100	-- From MinSpeed to this value, volume will exponentially grow.

-- Variables
local rumbleHitboxes = workspace.Hitboxes.Rumble:GetChildren()
local soundTemplate = script.RumbleSound
local car = script.Parent.Car.Value
local wheels = car.Wheels:GetChildren()
local velocity = script.Parent.Values.Velocity

local wheelRumbleCounts = {} -- Count of contacts per wheel
local safetyCheckDebounce = {} -- Debounce check for safety function
local rumblePartContacts = {} -- Tracks contacts per wheel
local allSounds = {}

-- Setup for each wheel
for _, wheel in ipairs(wheels) do
	local wheelSound = soundTemplate:Clone()
	wheelSound.Looped = true
	wheelSound.Parent = wheel
	wheelSound.Playing = true
	wheelSound.Volume = 0
	
	wheelRumbleCounts[wheel] = 0
	safetyCheckDebounce[wheel] = false
	rumblePartContacts[wheel] = {}
	table.insert(allSounds, wheelSound)
end

-- Play or stop sounds based on conditions
local function handleTouch(wheel, increment, rumblePart)
	local wheelSound = wheel:FindFirstChild(soundTemplate.Name)
	if wheelSound then
		
		if increment > 0 then
			-- Add rumble part to wheel's contacts
			if not rumblePartContacts[wheel][rumblePart] then
				rumblePartContacts[wheel][rumblePart] = true
				wheelRumbleCounts[wheel] = wheelRumbleCounts[wheel] + 1
			end
		else
			-- Remove rumble part from wheel's contacts
			if rumblePartContacts[wheel][rumblePart] then
				rumblePartContacts[wheel][rumblePart] = nil
				wheelRumbleCounts[wheel] = wheelRumbleCounts[wheel] - 1
			end
		end
		
		-- Handle sounds
		if wheelRumbleCounts[wheel] <= 0 then
			wheelRumbleCounts[wheel] = 0 -- Negative prevention
		end
	end
end

-- Safety check to reset sound if no contacts after delay
local function safetyCheck(wheel)
	if next(rumblePartContacts[wheel]) == nil then
		handleTouch(wheel, -wheelRumbleCounts[wheel], nil) -- Reset if no parts are in contact
	end
	safetyCheckDebounce[wheel] = false -- Reset debounce state
end

-- Connect
for _, rumblePart in ipairs(rumbleHitboxes) do
	rumblePart.Touched:Connect(function(hitPart)
		if hitPart.Parent == car.Wheels then
			handleTouch(hitPart, 1, rumblePart)
			if not safetyCheckDebounce[hitPart] then
				safetyCheckDebounce[hitPart] = true
				delay(2, function() safetyCheck(hitPart) end)
			end
		end
	end)

	rumblePart.TouchEnded:Connect(function(hitPart)
		if hitPart.Parent == car.Wheels then
			handleTouch(hitPart, -1, rumblePart)
		end
	end)
end

-- Adjust sound by velocity
task.spawn(function()
	while true do
		for _, sound: Sound in allSounds do
			local speed = velocity.Value.Magnitude
			local clampedSpeed = math.clamp(speed, MinSpeed, MaxSpeed)
			local normalizedSpeed = (clampedSpeed - MinSpeed) / (MaxSpeed - MinSpeed)

			sound.Volume = (MinVolume + (MaxVolume - MinVolume) * normalizedSpeed) * wheelRumbleCounts[sound.Parent]
		end
		
		task.wait(0.1)
	end
end)


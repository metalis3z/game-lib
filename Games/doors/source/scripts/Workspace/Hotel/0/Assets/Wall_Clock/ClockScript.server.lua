-- Ganondude

local time_zone = -11		-- Time zone, offset from GMT.

local clock = script.Parent
local face = clock.Face
local hour_hand = clock.HandHour
local minute_hand = clock.HandMinute
local second_hand = clock.HandSecond

local secondsInDay = 60*60*24

function rotateClockHand(hand,rotation)
	local lv = (face.CFrame*CFrame.Angles(math.pi/7,0,0)).lookVector*face.Size.Y/2.5

	hand.CFrame = face.CFrame*CFrame.Angles(0,-rotation,0) + lv
	hand.CFrame = hand.CFrame - hand.CFrame.lookVector*hand.Size.Z/2
end

while true do
	local tick = math.fmod(tick(),secondsInDay)

	local hour = math.floor(tick/3600) + 5 + time_zone
	local minute = math.floor(tick/60 - 60*hour)
	local second = math.floor(math.fmod(tick,60))

	rotateClockHand(hour_hand,hour*(math.pi/6) + minute*(math.pi/500))
	rotateClockHand(minute_hand,minute*(math.pi/30))
	rotateClockHand(second_hand,second*(math.pi/30))

	wait(0.1)
end

-- Ganondude
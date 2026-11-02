
local reverse = script.Parent.ReverseBeep
local seat = script.Parent
local lastThrottle = 0
local loop = false

seat.Changed:connect(function(prop)
	
	if prop == "Occupant" then
		if seat.Occupant then
			loop = true
			while loop do
				wait(.2)
				if seat.ThrottleFloat < 0 and not reverse.IsPlaying  then
					wait(.3)
					if seat.Throttle < 0 then
						reverse:Play()
					end
				elseif seat.ThrottleFloat >= 0 and reverse.IsPlaying then
					reverse:Stop()
				end
			end
		else
			reverse:Stop()
			loop = false
		end
	end
end)
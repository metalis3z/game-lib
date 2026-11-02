--[[

	Exhaustingly written by cc567

]]

--Feel free to poke around and see how this works.  It's not very complex

local car = script.Parent.Car.Value
local Values = script.Parent:WaitForChild("Values") --This bit of code is still in 90% of A-Chassis plugins lol
local _Tune = require(car["A-Chassis Tune"])
local Handler = car:WaitForChild("ExhaustHandler")
local IsFlaming = false --Exhaust flame debounce.  Debounces are important so code block doesn't run too quickly

Values.Throttle.Changed:Connect(function() -- This is where all the magic happens.  Flames are determined by when you release the throttle
	
	local RPMRatio = Values.RPM.Value / _Tune.Redline
	
	print(RPMRatio)
	
	if RPMRatio > 0.8 and not IsFlaming and car.DriveSeat.Throttle < 1 then
		
		IsFlaming = true
		Handler:FireServer("Flames",true)
		wait(0.1)
		Handler:FireServer("Flames",false)
		Handler:FireServer("FlamesSmall",false)
		wait(0.1)
		Handler:FireServer("FlamesSmall",false)
		IsFlaming = false
	elseif Values.Throttle.Value < 0.5 then
		
		Handler:FireServer("FlamesSmall",false)
		
		
	end
	
end)
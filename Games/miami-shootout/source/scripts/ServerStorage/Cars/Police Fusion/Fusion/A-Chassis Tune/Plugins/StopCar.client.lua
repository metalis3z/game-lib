--[[
local FE = workspace.FilteringEnabled
local car = script.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])

local body = car.Body

local event= car.SmeersLightsHandler

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" and child:IsA("Weld") then
		--print("stopping car")
		--event:FireServer({["EnableBrakes"]=true})
		--script.Parent.IsOn.Value=false
	end
end)
-]]
--chedsapp with rccbay

--settings

local DOWN_GEAR_BACKFIRE = true -- will your car backfire when gearing down?
local DOWN_GEAR_BACKFIRE_CHANCE = 1 -- a 1 in x chance that you will backfire when gearing down

local GENERAL_BACKFIRE_CHANCE = 1 -- a 1 in x chance that you will backfire

--shitass code

local car = script.Parent:WaitForChild("Car").Value
local values = script.Parent.Values
local backfire = car:WaitForChild("backfire")
local _tune = require(car["A-Chassis Tune"])


local reddding = false
local throt = false

values.RPM.Changed:Connect(function()
	local rpm = values.RPM.Value
	if rpm >= _tune.Redline - 500 then
		reddding = true
	else
		reddding = false
	end
	
end)

local lastgear = nil
values.Gear.Changed:Connect(function()
	--print(lastgear)
	if lastgear ~= nil and lastgear == values.Gear.Value + 1 then
		local ran = math.random(1,DOWN_GEAR_BACKFIRE_CHANCE)
		if ran == 1 then
			backfire:FireServer()
		end
	end
	lastgear = values.Gear.Value
end)

values.Throttle.Changed:Connect(function()
	if values.Throttle.Value >= 1 then
		throt = true
	else
		throt = false
	end
end)

local deb = false

while wait() do
	if throt == false and reddding == true and deb == false then
		deb = true
		local ran = math.random(1,GENERAL_BACKFIRE_CHANCE)
		if ran == 1 then
			backfire:FireServer()
		end
		wait(0.2)
		deb = false
	end
end
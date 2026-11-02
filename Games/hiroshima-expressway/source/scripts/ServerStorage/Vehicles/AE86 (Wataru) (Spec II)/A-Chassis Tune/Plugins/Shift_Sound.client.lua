local transmissionsound = true

local car = script.Parent.Car.Value
local values = script.Parent.Values.Gear

local mL = Instance.new("Sound")
mL.Parent = car.DriveSeat
mL.Name = "ShiftSound"
mL.SoundId = "rbxassetid://139782180614936"
mL.Volume = 2.8
mL.PlaybackSpeed = 1

script.Parent.Values.Gear.Changed:connect(function()
	if transmissionsound == true then
		car.DriveSeat.ShiftSound:Play()
	end
end)
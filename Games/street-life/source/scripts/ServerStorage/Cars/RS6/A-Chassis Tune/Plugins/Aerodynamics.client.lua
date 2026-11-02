--Aerodynamics script by RikOne2--
--				1.1				--
--Fixed NaN angle issue (car spazzing)--
--Script is now FE+
--For drag value, multiply actual drag by 271.875‬
local Drag = 59  --Drag (The higher is the value, less the drag is | Standard is 30-40, depends from how aereodynamic your car is)
local F = 200	--Front Downforce (The higher is the value, less the downforce is)
local R = 85	--Rear Downforce (The higher is the value, less the downforce is)
local Vol = 200 -- Wind sound volume (The higher is the value, less the volume is)

local car = script.Parent.Car.Value
local sound = car.Body.Drag.Wind
local handler = car.Aerodynamics
sound:Play()
handler:FireServer("SoundPlay")

while wait() do
	local angle = math.acos(math.abs(car.Body.DownforceF.Velocity.unit:Dot(car.Body.DownforceF.CFrame.lookVector)))
	if angle > 0 then
	car.Body.DownforceF.T.Force = Vector3.new(0,-(((car.DriveSeat.Velocity.magnitude^2)/F)*(angle^2)),0)
	car.Body.DownforceR.T.Force = Vector3.new(0,-(((car.DriveSeat.Velocity.magnitude^2)/R)*(angle^2)),0)
	end
	car.Body.Drag.T.Force = Vector3.new(0,0,((car.DriveSeat.Velocity.magnitude^2)/Drag))
	sound.Volume = car.DriveSeat.Velocity.magnitude/Vol
	
	handler:FireServer("SoundUpdate",sound.Volume)
end
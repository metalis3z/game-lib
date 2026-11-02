bike = script.Parent.Bike.Value
local handler = bike:WaitForChild("Kickstand")

bike.Body.Kickstand:WaitForChild("P")
bike.Body.Kickstand.P:WaitForChild("Stand")
bike.Body.Kickstand.P.Stand.Foot:WaitForChild("BodyGyro")
bike.Body.Kickstand.P.Stand:WaitForChild("Foot")
local P = bike.Body.Kickstand.P
local Stand = bike.Body.Kickstand.P.Stand
local Down = bike.Body.Kickstand.P.Stand.Foot.BodyGyro
local Foot = bike.Body.Kickstand.P.Stand.Foot
local weld = P.Motor


function StandDown()
	--[[weld.DesiredAngle = -1.5
	Down.P = 200
	Down.D = 200
	Down.MaxTorque = Vector3.new(0,0,2000)
	Foot.CanCollide = true]]
	handler:FireServer("StandDown",-1.5,200,200,2000,true)
end

function StandUp()
	--[[Down.P = 0
	Down.D = 0
	Down.MaxTorque = Vector3.new(0,0,0)
	weld.DesiredAngle = 0
	Foot.CanCollide = false]]
	handler:FireServer("StandUp",0,0,0,0,false)
end

StandUp()

bike.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" and child:IsA("Weld") then
		if bike.DriveSeat.Velocity.Magnitude < 10 then
			StandDown()
		end
	end
end)
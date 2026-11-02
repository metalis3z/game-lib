gyro = script.Parent.BodyGyro
force = script.Parent.BodyVelocity

--force.maxForce = Vector3.new(200,0,200)
gyro.maxTorque = Vector3.new(50000,500000,500000)
gyro.cframe = CFrame.fromEulerAnglesXYZ(math.pi/2,math.pi,-math.pi/2+ math.random(-2*math.pi,2*math.pi))

current_look = math.random(-2*math.pi,2*math.pi)
math.randomseed(tick())
function idle()
	wait(math.random(3,10))
end
function lookaround()
	for i=1,math.random(2,5) do
		wait(math.random(.5,1))
		current_look = current_look + math.random(-math.pi/12,math.pi/12)
		gyro.cframe = CFrame.fromEulerAnglesXYZ(math.pi/2,math.pi,-math.pi/2+ current_look)
	end
end
function walk()
	for i=1,math.random(2,10) do
		
	current_look = current_look + math.random(-math.pi/4,math.pi/4)
	gyro.cframe = CFrame.fromEulerAnglesXYZ(math.pi/2,math.pi,-math.pi/2+ current_look)
	wait(math.random(.5,1))
	force.velocity = (script.Parent.CFrame * CFrame.fromEulerAnglesXYZ(0,-math.pi/2,0)).lookVector * 20
	force.maxForce = Vector3.new(100,100,100)
	wait(math.random(.5,1))
	force.maxForce = Vector3.new(0,0,0)
	wait(math.random(1,1.5))
	end
end

while true do--math.random(0,2*math.pi)
	wait()
	local rand =  math.random(1,4)
	if rand == 1 then
		walk()
	elseif rand == 2 or rand == 4 then
		lookaround()
	else
		idle()
	end
end
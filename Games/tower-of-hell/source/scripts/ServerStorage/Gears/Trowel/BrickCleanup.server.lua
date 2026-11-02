-- this script removes its parent from the workspace after 29 to 30 seconds

function rnd1()
	local i = math.random(-5000,5000)*.001
	return i
end

function rnd2()
	local i = math.random(-12500,12500)*.001
	return i
end

function rnd3()
	local i = math.random(12500,25000)*.001
	return i
end

wait(1+math.random(20000,20000)*.001)
script.Parent:BreakJoints()
script.Parent.CanCollide = false
script.Parent.Velocity = Vector3.new(rnd2(),rnd3(),rnd2())
script.Parent.RotVelocity = Vector3.new(rnd1(),rnd2(),rnd1())
for i = 0, 1, .1 do
	wait()
	script.Parent.Transparency = i
end
script.Parent.Parent = nil
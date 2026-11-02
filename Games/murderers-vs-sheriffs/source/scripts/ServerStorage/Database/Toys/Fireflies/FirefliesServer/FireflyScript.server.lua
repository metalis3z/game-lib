local Firefly = script.Parent
local BodyVelocity = Firefly:WaitForChild("BodyVelocity")

wait(.5 + math.random())
BodyVelocity.Velocity = BodyVelocity.Velocity * Vector3.new(1, 0, 1)
for Count = 1, 100 do
	BodyVelocity.Velocity = BodyVelocity.Velocity + Vector3.new(math.random() - .5, math.random() - .5, math.random() - .5) * 5
	wait(.5 + math.random())
end

Firefly:Destroy()
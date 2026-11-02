script.Parent.Parent.Move.BodyGyro.cframe = script.Parent.Parent.Move.CFrame
value1 = 0
while true do
wait()
speed = script.Parent.MaxSpeed
turnspeed = script.Parent.TurnSpeed
if script.Parent.Throttle== 1 then
if value1 < speed then value1 = value1+1 end
script.Parent.Parent.Move.BodyVelocity.velocity = script.Parent.Parent.Move.CFrame.lookVector*value1
end
if script.Parent.Throttle == 0 then
value1 = 0
script.Parent.Parent.Move.BodyVelocity.velocity = script.Parent.Parent.Move.CFrame.lookVector*value1
end
if script.Parent.Throttle== -1 then
if value1<14 then value1 = value1+1 end
script.Parent.Parent.Move.BodyVelocity.velocity = script.Parent.Parent.Move.CFrame.lookVector*-value1
end
if script.Parent.Steer == 1 then
script.Parent.Parent.Move.BodyGyro.cframe = script.Parent.Parent.Move.BodyGyro.cframe * CFrame.fromEulerAnglesXYZ(0,-(turnspeed),0)
end
if script.Parent.Steer == -1 then
script.Parent.Parent.Move.BodyGyro.cframe = script.Parent.Parent.Move.BodyGyro.cframe * CFrame.fromEulerAnglesXYZ(0,turnspeed,0)
end
end
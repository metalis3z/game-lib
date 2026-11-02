robo=script.Parent:clone()
while true do
	wait(0)
	if script.Parent.Humanoid.Health<1 then
		wait(1)
		robot=robo:clone()
		robot.Parent=script.Parent.Parent
		robot:makeJoints()
		script.Parent:remove()
	end
end

		






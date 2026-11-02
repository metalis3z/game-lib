z = script.Parent

backup = z:clone()

while true do
	wait(5)
	if z.Humanoid.Health == 0 then
		z:Remove()
		wait(300)
		backup.Parent = game.Workspace
		backup.Head:MakeJoints()
	end
	if z == nil then
		wait(300)
		backup.Parent = game.Workspace
		backup.Head:MakeJoints()
	end
end 
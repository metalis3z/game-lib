while true do
	if script.Parent.FakeHumanoid.Health <=0 then
		script.Parent.Move:Destroy()
		wait(3)
		script.Parent:Destroy()
	end
	wait(1)
end
while script.Parent ~= nil do
	task.wait()
	script.Parent.CFrame = script.Parent.CFrame * CFrame.Angles(0, 0.01, 0)
end
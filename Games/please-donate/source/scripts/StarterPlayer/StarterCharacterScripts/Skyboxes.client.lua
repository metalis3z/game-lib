

workspace.ChildAdded:Connect(function(Child)
	if Child.Name == "Skybox"  then
		while Child.Parent do
			Child.CFrame *= CFrame.Angles(math.rad(.05), math.rad(.025), 0)
			task.wait()
		end
	elseif Child.Name == "Skybox2"  then
		while Child.Parent do
			Child.CFrame *= CFrame.Angles(0, math.rad(-.05), 0)
			task.wait()
		end
	end
end)
while wait(0.5) do
	if script.Parent:FindFirstChild("Humanoid") and script.Parent:FindFirstChild("Humanoid").MaxHealth < 100 then
		script.Parent:FindFirstChild("Humanoid").MaxHealth = 100
	end
end
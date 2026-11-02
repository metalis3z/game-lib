local speedMutator = game:GetService("ReplicatedStorage").Mutators:WaitForChild("High Speed")

function updateSpeed(toggle)
	repeat wait() until script.Parent:FindFirstChild("Humanoid")
	if toggle then script.Parent.Humanoid.WalkSpeed = 20
	else script.Parent.Humanoid.WalkSpeed = 16
	end
end

updateSpeed(speedMutator.Value)
speedMutator.Changed:Connect(updateSpeed)
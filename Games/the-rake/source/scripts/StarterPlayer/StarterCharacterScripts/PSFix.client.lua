while wait() do
	if workspace:FindFirstChild("PowerStation").RestorePart.Restoring.Value == true and script.Parent.Restorer.Value == false then
		workspace:FindFirstChild("PowerStation").ProximityPrompt.MaxActivationDistance = 0
	end
end
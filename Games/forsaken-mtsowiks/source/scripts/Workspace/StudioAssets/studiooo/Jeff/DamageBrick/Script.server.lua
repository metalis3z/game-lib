script.Parent.Touched:Connect(function(otherPart)
	if otherPart.Parent:FindFirstChildOfClass("Humanoid") then
		otherPart.Parent:FindFirstChildOfClass("Humanoid"):TakeDamage(5)
	end
end)
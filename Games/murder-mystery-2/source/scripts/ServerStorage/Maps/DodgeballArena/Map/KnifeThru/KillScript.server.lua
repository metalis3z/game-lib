script.Parent.Touched:connect(function(Hit)
	local Humanoid = Hit.Parent:FindFirstChild("Humanoid");
	if Humanoid then
		Humanoid.WalkSpeed = 0;
	end
end);
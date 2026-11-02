script.Parent.Touched:connect(function(Hit)
	local Humanoid = Hit.Parent:FindFirstChild("Humanoid")
	if Humanoid ~= nil then
		Humanoid.Health = 0
	end
end)
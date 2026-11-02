script.Parent.Activated:Connect(function(plr)
	local char = plr.Character
	if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
		spawn(function()
			repeat char.Humanoid.Health = char.Humanoid.Health + 1 wait() until char.Humanoid.Health == char.Humanoid.MaxHealth
		end)
	end
end)
script.Parent.Touched:Connect(function(Hit)
	if game.Players:FindFirstChild(Hit.Parent.Name) then
		if Hit.Parent.Name ~= script.Parent.Parent.Data.Owner.Value then
			if script.Parent.Parent.Data.LazersEnabled.Value == true then
				if Hit.Parent:FindFirstChild("Humanoid") then
					Hit.Parent:FindFirstChild("Humanoid").Health = 0
				end
			end
		end
	end
end)
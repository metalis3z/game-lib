local button = script.Parent

button.MouseButton1Click:Connect(function()
	for _, descendant in ipairs(workspace.Players.Survivors:GetDescendants()) do
		if descendant:IsA("Humanoid") then
			descendant.Health = 0 -- "Kill" the humanoid by setting its health to 0
		end
	end
end)

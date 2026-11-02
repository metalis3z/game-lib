script.Parent.ProximityPrompt.Triggered:Connect(function()
	for _, v in pairs(workspace.Players.Survivors:GetChildren()) do
		if not game.Players:GetPlayerFromCharacter(v) then
			v:Destroy()
		end
	end
	for _, v in pairs(game.ServerStorage.Assets.Miscellaneous.Testing.TestingPlaceSurvivors:GetChildren()) do
		v:Clone().Parent = workspace.Players.Survivors
	end
end)
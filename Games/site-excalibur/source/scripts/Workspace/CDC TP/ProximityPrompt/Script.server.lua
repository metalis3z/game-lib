local ProximityPrompt = script.Parent
ProximityPrompt.Triggered:Connect(function(player)
	player.Character.HumanoidRootPart.Position = workspace.Dream.Position
end)

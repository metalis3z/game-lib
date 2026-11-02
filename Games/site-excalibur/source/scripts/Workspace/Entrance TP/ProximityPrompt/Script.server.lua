local ProximityPrompt = script.Parent
ProximityPrompt.Triggered:Connect(function(player)
	player.Character.HumanoidRootPart.Position = workspace.Destination.Position -- Change "Teleportpart" To your part name
end)


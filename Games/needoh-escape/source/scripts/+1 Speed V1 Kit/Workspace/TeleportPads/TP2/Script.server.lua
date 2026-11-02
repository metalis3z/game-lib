local tpname = "TP1"
script.Parent.ProximityPrompt.Triggered:Connect(function(player)
	player.Character:MoveTo(script.Parent.Parent:FindFirstChild(tpname).Position)
end)
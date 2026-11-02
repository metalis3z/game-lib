game.Players.PlayerRemoving:Connect(function(p)
	
	if game.Workspace.PoliceCars:FindFirstChild(p.Name .. "'s Car") then
		game.Workspace.PoliceCars:FindFirstChild(p.Name .. "'s Car"):Destroy()
	end
	
end)
script.Parent.RemoteEvent.OnServerEvent:Connect(function(Player)
	if Player.Character:WaitForChild("Humanoid").Health == 0 then
		game.Workspace.EyeHallway.Eye.Scream:Play()
	else
		Player.Character:WaitForChild('Humanoid'):TakeDamage(5)
		game.Workspace.EyeHallway.Eye.Attack:Play()
	end
end)

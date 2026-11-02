-- Created and Supported by LSPLASH

game:GetService("ReplicatedStorage"):FindFirstChild("EntityInfo"):WaitForChild("GRevive").OnServerEvent:Connect(function(p1, p2)
	p1:SetAttribute("CantRevive", true)
	
	p1.PlayerStats.Revives.Value -= 1
	game.Workspace.CurrentRooms.CurrentRoom.HaltCorridorValue = false
end)
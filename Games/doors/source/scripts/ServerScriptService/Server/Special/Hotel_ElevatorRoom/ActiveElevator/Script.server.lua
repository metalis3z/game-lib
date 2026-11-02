script.Parent.Event:Connect(function()
	game.Workspace.Ambience_Unranged:Play()
	
	game.Workspace.Ambience_Figure:Stop()
	game.Workspace.Ambience_FigureEnd:Stop()
	
	game.ReplicatedStorage.EntityInfo.FigureCutsceneFall:FireAllClients()
	game.ReplicatedStorage.EntityInfo.FigureCutsceneWalk:FireAllClients()
	
	wait(5)
	game.Workspace:FindFirstChild("ElevatorCar", true):SetAttribute("Activated", true)
end)
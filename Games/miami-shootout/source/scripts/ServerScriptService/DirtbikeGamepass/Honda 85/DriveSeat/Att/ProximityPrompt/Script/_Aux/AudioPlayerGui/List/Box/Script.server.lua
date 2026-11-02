


script.Parent.TextButton.MouseButton1Click:Connect(function()

	
	local playername = script.Parent.Name
	local gui = script.Parent.Parent.Parent.Parent.AudioPlayerScript.Car.Value.DriveSeat.Att.ProximityPrompt.Script.Aux
	
	
		local dog = gui:Clone()
		
	dog.Parent = game.Players:FindFirstChild(playername).PlayerGui
	script.Parent.Parent.Parent.Parent.AudioPlayerScript.Car.Value.Stats.PlayerWithAux.Value = playername
	local me = script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Name

	game.Players:FindFirstChild(me).PlayerGui:FindFirstChild("Aux"):Destroy()
end)
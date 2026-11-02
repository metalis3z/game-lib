local v = script.Parent

v.Triggered:Connect(function()
	if v.Parent:GetAttribute("DoNotDelete") == true then

	else
		if game.Workspace.CurrentRooms:WaitForChild(game.Workspace.CurrentRooms.CurrentRoom.Value):FindFirstChild("TimerLever") then
			game.Workspace.CurrentRooms:WaitForChild(game.Workspace.CurrentRooms.CurrentRoom.Value):FindFirstChild("TimerLever"):Destroy()
		end
		
		v.Parent:SetAttribute("DoNotDelete", true)
		v.Parent.RotateThis.Anchored = false
		v.Parent.RotateThis.ToUnanchor.Anchored = false
		v.Parent.Main.SoundToPlay:Play()
		game.Workspace.Hunt_AmbienceEnd.TimePosition = 0.6
		game.Workspace.Hunt_AmbienceEnd:Play()
		v.Parent:FindFirstChildOfClass("HingeConstraint").TargetAngle = -74.9

		game.Workspace.Game:SetAttribute("GameTimer", game.Workspace.Game:GetAttribute("GameTimer") + 60)
		game.Workspace.Game:SetAttribute("Ambience", game.Workspace.Game:GetAttribute("Ambience") - 60)
		game.Workspace.Hunt_AmbienceStart.TimePosition = (game.Workspace.Game:GetAttribute("TimerEnd") - game.Workspace.Game:GetAttribute("GameTimer"))
	end
end)

game.Workspace.Game:GetAttributeChangedSignal("GameTimer"):Connect(function()
	v.Parent.DisplayTimer.Text.Text = require(game.ServerScriptService.Game.Directory.Hunt_RoomGeneration):IntValueTime(game.Workspace.Game:GetAttribute("GameTimer"))
end)
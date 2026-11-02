script.Parent.MouseButton1Click:connect(function(person)
	game.Players.LocalPlayer.Character.Torso.Anchored = true
	saving = game.Lighting.SavingLocation:Clone()
	saving.Parent = game.Players.LocalPlayer.PlayerGui
	wait(15)
	game.Players.LocalPlayer.Data.X.Value = game.Players.LocalPlayer.Character.Torso.Position.X
	game.Players.LocalPlayer.Data.Y.Value = game.Players.LocalPlayer.Character.Torso.Position.Y
	game.Players.LocalPlayer.Data.Z.Value = game.Players.LocalPlayer.Character.Torso.Position.Z
	game.Players.LocalPlayer.Character.Torso.Anchored = false
	saving:remove()
end)
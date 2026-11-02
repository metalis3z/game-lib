script.Parent.MouseButton1Click:connect(function(person)
	if script.Parent.Status.Value == "On" then
		game.Players.LocalPlayer.Backpack.MusicScript.Music:Stop()
		game.Players.LocalPlayer.Backpack.MusicScript.Disabled = true
		game.Players.LocalPlayer.Backpack.MusicScript:Destroy()
		script.Parent.Text = "Turn Music On"
		script.Parent.Status.Value = "Off"
		return
	end
	
	if script.Parent.Status.Value == "Off" then
		musicscript = script.Parent.MusicScript:Clone()
		musicscript.Parent = game.Players.LocalPlayer.Backpack
		musicscript.Disabled = false
		game.Players.LocalPlayer.Backpack.MusicScript.Music:Play()
		script.Parent.Text = "Turn Music Off"
		script.Parent.Status.Value = "On"
		return
	end
end)
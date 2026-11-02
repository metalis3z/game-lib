game.Players.LocalPlayer.Character.UvLamp.Activated:Connect(function()
	script.Parent.Frame.Visible = true
	wait(3)
	script.Parent.Frame.Visible = false
end)
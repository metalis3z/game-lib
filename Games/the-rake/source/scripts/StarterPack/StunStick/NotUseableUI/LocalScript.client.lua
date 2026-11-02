game.Players.LocalPlayer.Character.StunStick.Activated:Connect(function()
	script.Parent.Frame.Visible = true
	wait(3)
	script.Parent.Frame.Visible = false
end)
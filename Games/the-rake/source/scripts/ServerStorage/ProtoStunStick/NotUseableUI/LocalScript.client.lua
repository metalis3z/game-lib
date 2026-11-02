game.Players.LocalPlayer.Character.ProtoStunStick.Activated:Connect(function()
	script.Parent.Frame.Visible = true
	wait(3)
	script.Parent.Frame.Visible = false
end)
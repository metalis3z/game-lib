Toolname = "AK-47"

function boop(Player)
	if Player.Backpack:FindFirstChild(Toolname) then

		Player.PlayerGui.youAlredyHaveThat.Frame.Visible  = true
		Player.PlayerGui.youAlredyHaveThat.Frame.BackgroundTransparency = 0.1
		wait(3)
		Player.PlayerGui.youAlredyHaveThat.Frame.BackgroundTransparency = 0.2
		wait(.2)
		Player.PlayerGui.youAlredyHaveThat.Frame.BackgroundTransparency = 0.4
		wait(.2)
		Player.PlayerGui.youAlredyHaveThat.Frame.BackgroundTransparency = 0.5
		wait(.2)
		Player.PlayerGui.youAlredyHaveThat.Frame.BackgroundTransparency = 0.6
		wait(.2)
		Player.PlayerGui.youAlredyHaveThat.Frame.BackgroundTransparency = 0.7
		wait(.2)
		Player.PlayerGui.youAlredyHaveThat.Frame.BackgroundTransparency = 0.8
		wait(.2)
		Player.PlayerGui.youAlredyHaveThat.Frame.BackgroundTransparency = 0.9
		Player.PlayerGui.youAlredyHaveThat.Frame.BackgroundTransparency = 1

		Player.PlayerGui.youAlredyHaveThat.Frame.Visible = false
		Player.PlayerGui.youAlredyHaveThat.Frame.BackgroundTransparency = 0
end
end
script.Parent.ClickDetector.MouseClick:Connect(boop)

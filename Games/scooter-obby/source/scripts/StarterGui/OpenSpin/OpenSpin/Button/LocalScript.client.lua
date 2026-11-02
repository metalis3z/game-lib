local player = game.Players.LocalPlayer

script.Parent.Activated:Connect(function()
	if player.PlayerGui.WheelSpin:GetAttribute("Open") == false then
		player.PlayerGui.WheelSpin.Enabled = true
		player.PlayerGui.WheelSpin:SetAttribute("Open", true)
	else
		player.PlayerGui.WheelSpin.Enabled = false
		player.PlayerGui.WheelSpin:SetAttribute("Open", false)
	end
end)
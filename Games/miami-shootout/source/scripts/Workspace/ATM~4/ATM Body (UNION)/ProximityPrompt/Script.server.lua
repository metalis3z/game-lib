script.Parent.Triggered:Connect(function(p)
	if p.PlayerGui:FindFirstChild"ATMGUI" then return end

	local hi = game.Lighting.Assets.GUI.ATMGui:Clone()
	hi.Parent = p.PlayerGui

	local dc
	dc = p.Character.Humanoid.Running:Connect(function(speed)
		if speed == 0 then return end
		if hi then hi:Destroy() end
		dc:Disconnect()
	end)

end)
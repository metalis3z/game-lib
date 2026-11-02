script.Parent.OnServerEvent:Connect(function()
	local d = game.Lighting.Brightness
	game.Lighting.Brightness = 100.5
	workspace.Orb:Destroy()
	wait(5)
	repeat
		game.Lighting.Brightness = game.Lighting.Brightness - 1
		wait()
	until game.Lighting.Brightness <= d
	script.Enabled = false
end)
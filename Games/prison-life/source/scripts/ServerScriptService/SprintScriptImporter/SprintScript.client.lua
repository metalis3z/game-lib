local mouse = game.Players.LocalPlayer:GetMouse()

--[[function getTool()	
	for _, kid in ipairs(script.Parent:GetChildren()) do
		if kid.className == "Tool" then return kid end
	end
	return nil
end]]--

mouse.KeyDown:connect(function(key) -- Run function
	key = string.lower(key)
	if string.byte(key) == 48 then
		local player = game.Players.LocalPlayer
		if player.sprint.Value == true then
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 24
		end
	end
end)

mouse.KeyUp:connect(function(key)
	key = string.lower(key)
	if string.byte(key) == 48 then
		local player = game.Players.LocalPlayer
		if player.sprint.Value == true then
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
		end
	end
end)

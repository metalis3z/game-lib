repeat wait() until game.Players.LocalPlayer.Character ~= nil
wait(1)

player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")
running = false
value = game.Players.LocalPlayer.PlayerGui.Stamina.Frame.Value

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "r" and not running == true) and value.Value >= 10 then
		
		running = true
		
		originalspeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
		
		while running == true do
			
			if value.Value == 0 then
				running = false
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = originalspeed
				game.Players.LocalPlayer.PlayerGui.Stamina.Frame.Value.Script.Disabled = false
				return
			end
			
			game.Players.LocalPlayer.PlayerGui.Stamina.Frame.Value.Script.Disabled = true
		
			script.Parent.Parent.Character.Humanoid.WalkSpeed = originalspeed + 10
			
			value.Value = value.Value - 1

			wait(0.25)
		end
		
		else if (string.lower(key) == "r" and running) then
		
			running = false
			script.Parent.Parent.Character.Humanoid.WalkSpeed = originalspeed
			game.Players.LocalPlayer.PlayerGui.Stamina.Frame.Value.Script.Disabled = false
		
		end
	end
end)
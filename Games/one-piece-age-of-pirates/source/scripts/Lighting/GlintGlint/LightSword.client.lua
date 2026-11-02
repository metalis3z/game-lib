player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "c") then
		
		script.Disabled = true
		
		sword = game.Lighting.LightSword:Clone()
		sword.Parent = game.Players.LocalPlayer.Backpack
		
		sword.Equipped:connect(function(mouse)
    		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 28
		end)
		
		sword.Unequipped:connect(function(mouse)
    		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
		end)
		
		wait(15)
		
		sword:remove()
		
		wait(40)
		script.Disabled = false
	end
end)
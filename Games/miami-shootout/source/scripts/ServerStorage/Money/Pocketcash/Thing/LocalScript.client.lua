local cooldown = false
local animation1 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.Parent.Animation1)
local animation2 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.Parent.Animation2)
		local animation3 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.Parent.Animation3)

script.Parent.Flex.TextButton.MouseButton1Click:connect(function()
	if cooldown == false then
		cooldown = true
		local random = math.random(1,3)
		
		if random == 1 then
			
			animation1:Play()	
			wait(3.9)
			animation1:Stop()
			cooldown = false
		end
		
		
		
		
		
		
		if random == 2 then
		
			animation2:Play()	
			
			wait(3.9)
			animation2:Stop()
			cooldown = false
		end
		
		
		if random == 3 then
		
	
			animation3:Play()	
			wait(3.9)
			animation3:Stop()
			cooldown = false
		end
	end
	
end)



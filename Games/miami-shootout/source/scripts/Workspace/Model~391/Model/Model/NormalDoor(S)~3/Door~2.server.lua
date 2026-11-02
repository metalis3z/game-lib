local Cooldown = false
local Cooldown2 = false
script.Parent.Clicc.ClickDetector.MouseClick:Connect(function(d)
	


	
	if script.Parent.lock.Value == true then
		script.Parent.door["Locked Door"]:Play()	
	else
    if Cooldown == true then return end
	Cooldown = true
	
	local ani = d.Character.Humanoid:LoadAnimation(script.Animation)
	ani:Play()
	
	script.Parent.door.Open:Play()
	script.Parent.Motor.Motor.DesiredAngle = -1.7
	wait(2)
	script.Parent.Motor.Motor.DesiredAngle = 0
	wait(.5)
	script.Parent.door.Close:Play()
	Cooldown = false
	end
end)





script.Parent.xd.ClickDetector.MouseClick:Connect(function(Player)

		if script.Parent.lock.Value == false then
			script.Parent.lock.Value = true
			script.Parent.ot.Transparency = 0
			script.Parent.o.Transparency = 1
			script.Parent.door.Lock:Play()
	   elseif script.Parent.lock.Value == true then
			script.Parent.lock.Value = false
			script.Parent.ot.Transparency = 1
			script.Parent.o.Transparency = 0
			script.Parent.door.Lock:Play()
		end

end)

script.Parent.Clicc.ClickDetector.RightMouseClick:Connect(function(player)
	
	if not player.PlayerGui:FindFirstChild("DoorAction") and Cooldown2 == false then
		Cooldown2 = true
		
		local gui = script.DoorAction:Clone()
		
		gui.Parent = player.PlayerGui
		
		gui.Value.Value = script.Parent
		
		gui.Script.Disabled = false
		
		wait(1)
		
		Cooldown2 = false
		
	end
	
	
end)
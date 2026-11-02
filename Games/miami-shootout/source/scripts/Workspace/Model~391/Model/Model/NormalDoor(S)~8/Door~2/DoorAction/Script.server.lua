



local door = script.Parent.Value.Value

local plr = script.Parent.Parent.Parent

script.Parent.Frame.Knock.MouseButton1Click:Connect(function()
	script.Parent.Enabled = false
	
	local ani = plr.Character.Humanoid:LoadAnimation(script.Animation)
	ani:Play()
	
	local sound = door.door.Knock:Clone()
	
	sound.Parent = door.Clicc
	
	
	sound:Play()
	
	game.Debris:AddItem(sound,sound.TimeLength)
	
	script.Parent:Destroy()
	
end)


local dbb = false
script.Parent.Frame.Kick.MouseButton1Click:Connect(function()
	if plr.Character.Humanoid.Health <=0 or dbb == true then return end
	dbb = true
	script.Parent.Frame.Kick.Active = false
	script.Parent.Enabled = false
	if door:FindFirstChild("HP") then
	if door.HP.Value >0 then

	local ani = plr.Character.Humanoid:LoadAnimation(script.kick)
	
	ani:Play()
	
	local sound = door.door.BreakDown.Kick:Clone()
	
	sound.Parent = door.Clicc
	
	
	sound:Play()
	
	script.Parent.Enabled = false
	
	game.Debris:AddItem(sound,sound.TimeLength)
	
	wait(.15)
	
	if door.Motor.Motor.DesiredAngle == 0 and door.Motor.Motor.CurrentAngle == 0 then
		
		door.Clicc.ClickDetector.MaxActivationDistance = 0
		
		
		door.Motor.Motor.DesiredAngle = .06
		
		wait(.05)
		
		door.Motor.Motor.DesiredAngle = -.1
		wait(.16)
		door.Motor.Motor.DesiredAngle = .06
		
		wait(.05)
		
		door.Motor.Motor.DesiredAngle = -.1
		
		wait(.15)
		
		door.Motor.Motor.DesiredAngle = -.06
		wait(.06)
		door.Motor.Motor.DesiredAngle = .06
		
		wait(.05)
		
		door.Motor.Motor.DesiredAngle = 0
		
		
		
		
		
	end
	
	
	door.Clicc.ClickDetector.MaxActivationDistance = 10
	
	door.HP.Value = door.HP.Value -1
	
	script.Parent:Destroy()
	
		
		
	elseif door.HP.Value <=0 then
		
		
		repeat wait() until door.Motor.Motor.DesiredAngle == 0 and door.Motor.Motor.CurrentAngle == 0
		
		
		local children = door:GetChildren()
		for i = 1, #children do
		local child = children[i]
			if child:IsA("Part") or child:IsA("UnionOperation") or child:IsA("MeshPart") then
				
				child.Anchored = false
				
				
				
				
			end
		end
		
		
		door.Clicc.ClickDetector.MaxActivationDistance = 0
		
		local ani = plr.Character.Humanoid:LoadAnimation(script.kick)
	
		ani:Play()
	
		local sound = door.door.BreakDown.Break:Clone()
	
		sound.Parent = door.Clicc
	
	
		sound:Play()
	
		game.Debris:AddItem(sound,sound.TimeLength)
	
	
		script.Parent:Destroy()
		
		
	
	
	end
	end
end)
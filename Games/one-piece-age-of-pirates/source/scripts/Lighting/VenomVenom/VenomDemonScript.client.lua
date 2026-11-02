player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")
running = false

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "v") then
		
		head = game.Lighting.VenomVenom.VenomDemon.Head.Part:Clone()
		torso = game.Lighting.VenomVenom.VenomDemon.Torso.Part:Clone()
		rightarm = game.Lighting.VenomVenom.VenomDemon.RightArm.Part:Clone()
		leftarm = game.Lighting.VenomVenom.VenomDemon.LeftArm.Part:Clone()
		
		game.Debris:AddItem(head, 20)
		game.Debris:AddItem(torso, 20)
		game.Debris:AddItem(rightarm, 20)
		game.Debris:AddItem(leftarm, 20)
		
		head.Parent = game.Workspace
		torso.Parent = game.Workspace
		rightarm.Parent = game.Workspace
		leftarm.Parent = game.Workspace
		
		torso.Firedamage.Disabled = false
		rightarm.Firedamage.Disabled = false
		leftarm.Firedamage.Disabled = false
		
		o1 = Instance.new("StringValue", torso)
		o1.Name = "Owner"
		o1.Value = game.Players.LocalPlayer.Name
		
		o2 = Instance.new("StringValue", rightarm)
		o2.Name = "Owner"
		o2.Value = game.Players.LocalPlayer.Name
		
		o3 = Instance.new("StringValue", leftarm)
		o3.Name = "Owner"
		o3.Value = game.Players.LocalPlayer.Name
		
		for i = 1, 400 do
			
			head.CFrame = game.Players.LocalPlayer.Character.Torso.CFrame * CFrame.new(0, 39, 0)
			
			torso.CFrame = game.Players.LocalPlayer.Character.Torso.CFrame * CFrame.new(0, 14, 0)
			
			leftarm.CFrame = torso.CFrame * CFrame.new(-22, 3, 0)
			
			rightarm.CFrame = torso.CFrame * CFrame.new(22, 3, 0)
			
			wait(0.05)
		end
		
		head:Destroy()
		torso:Destroy()
		leftarm:Destroy()
		rightarm:Destroy()
		
		
		script.Disabled = true
		
		wait(40)
		
		script.Disabled = false
		
	end
end)
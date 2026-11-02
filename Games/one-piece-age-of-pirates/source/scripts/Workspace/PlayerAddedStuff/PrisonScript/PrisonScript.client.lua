	player = game.Players.LocalPlayer
	
	if player.Data.Bounty.Value <= 5000000 and player.Data.Imprisoned.Value == true then
		print("level 1")
		val = math.random(1, 7)
		if val == 1 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level1.Spawn1.Position)
		end
		if val == 2 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level1.Spawn2.Position)
		end
		if val == 3 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level1.Spawn3.Position)
		end
		if val == 4 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level1.Spawn4.Position)
		end
		if val == 5 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level1.Spawn5.Position)
		end
		if val == 6 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level1.Spawn6.Position)
		end
		if val == 7 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level1.Spawn7.Position)
		end
		
		wait()
		
		local d = player.Backpack:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Tool") then
		clone = d[i]:Clone()
		clone.Parent = nil
		d[i]:remove()
		end
		end
		
		local d2 = player.Backpack:GetChildren() 
		for i2=1, #d2 do 
		if (d2[i2].className == "LocalScript") then 
				d2[i2].Disabled = true
			end
		end
		
		gui = script.JailTime:Clone()
		gui.Parent = player.PlayerGui
		gui.TimeValue.Value = 60
		gui.Background.Value.Script.Disabled = false
		
		repeat
			gui.TimeValue.Value = gui.TimeValue.Value - 1
			wait(1)
		until
			gui.TimeValue.Value == 0
			
		clone.Parent = player.Backpack
		
		local d2 = player.Backpack:GetChildren() 
		for i2=1, #d2 do 
		if (d2[i2].className == "LocalScript") then 
				d2[i2].Disabled = false
			end
		end
		
		gui:remove()
		player.Data.Imprisoned.Value = false
		player.Character:MoveTo(game.Workspace.FakeImpelDown.Door.Position + Vector3.new(-20, 0, 0))
		script:Destroy()
		
		force = Instance.new("ForceField")
		force.Parent = player.Character
		wait(20)
		force:remove()
	end
	
	if player.Data.Bounty.Value >= 5000001 and player.Data.Bounty.Value <= 20000000 and player.Data.Imprisoned.Value == true then
		print("level 2")
		val = math.random(1, 7)
		if val == 1 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level2.Spawn1.Position)
		end
		if val == 2 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level2.Spawn2.Position)
		end
		if val == 3 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level2.Spawn3.Position)
		end
		if val == 4 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level2.Spawn4.Position)
		end
		if val == 5 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level2.Spawn5.Position)
		end
		if val == 6 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level2.Spawn6.Position)
		end
		if val == 7 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level2.Spawn7.Position)
		end
		
		wait()
		
		local d = player.Backpack:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Tool") then
		clone = d[i]:Clone()
		clone.Parent = nil
		d[i]:remove()
		end
		end
		
		local d2 = player.Backpack:GetChildren() 
		for i2=1, #d2 do 
		if (d2[i2].className == "LocalScript") then 
				d2[i2].Disabled = true
			end
		end
		
		gui = script.JailTime:Clone()
		gui.Parent = player.PlayerGui
		gui.TimeValue.Value = 90
		gui.Background.Value.Script.Disabled = false
		
		repeat
			gui.TimeValue.Value = gui.TimeValue.Value - 1
			wait(1)
		until
			gui.TimeValue.Value == 0
			
		clone.Parent = player.Backpack
		
		local d2 = player.Backpack:GetChildren() 
		for i2=1, #d2 do 
		if (d2[i2].className == "LocalScript") then 
				d2[i2].Disabled = false
			end
		end
		
		gui:remove()
		player.Data.Imprisoned.Value = false
		player.Character:MoveTo(game.Workspace.FakeImpelDown.Door.Position + Vector3.new(-20, 0, 0))
		script:Destroy()
		
		force = Instance.new("ForceField")
		force.Parent = player.Character
		wait(20)
		force:remove()
	end
	
	if player.Data.Bounty.Value >= 20000001 and player.Data.Bounty.Value <= 50000000 and player.Data.Imprisoned.Value == true then
		print("level 3")
		val = math.random(1, 7)
		if val == 1 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level3.Spawn1.Position)
		end
		if val == 2 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level3.Spawn2.Position)
		end
		if val == 3 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level3.Spawn3.Position)
		end
		if val == 4 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level3.Spawn4.Position)
		end
		if val == 5 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level3.Spawn5.Position)
		end
		if val == 6 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level3.Spawn6.Position)
		end
		if val == 7 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level3.Spawn7.Position)
		end
		
		wait()
		
		local d = player.Backpack:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Tool") then
		clone = d[i]:Clone()
		clone.Parent = nil
		d[i]:remove()
		end
		end
		
		local d2 = player.Backpack:GetChildren() 
		for i2=1, #d2 do 
		if (d2[i2].className == "LocalScript") then 
				d2[i2].Disabled = true
			end
		end
		
		gui = script.JailTime:Clone()
		gui.Parent = player.PlayerGui
		gui.TimeValue.Value = 120
		gui.Background.Value.Script.Disabled = false
		
		repeat
			gui.TimeValue.Value = gui.TimeValue.Value - 1
			wait(1)
		until
			gui.TimeValue.Value == 0
			
		clone.Parent = player.Backpack
		
		local d2 = player.Backpack:GetChildren()
		for i2=1, #d2 do 
		if (d2[i2].className == "LocalScript") then 
				d2[i2].Disabled = false
			end
		end
		
		gui:remove()
		player.Data.Imprisoned.Value = false
		player.Character:MoveTo(game.Workspace.FakeImpelDown.Door.Position + Vector3.new(-20, 0, 0))
		script:Destroy()
		
		force = Instance.new("ForceField")
		force.Parent = player.Character
		wait(20)
		force:remove()
	end
	
	if player.Data.Bounty.Value >= 50000001 and player.Data.Bounty.Value <= 100000000 and player.Data.Imprisoned.Value == true then
		print("level 4")
		val = math.random(1, 7)
		if val == 1 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level4.Spawn1.Position)
		end
		if val == 2 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level4.Spawn2.Position)
		end
		if val == 3 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level4.Spawn3.Position)
		end
		if val == 4 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level4.Spawn4.Position)
		end
		if val == 5 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level4.Spawn5.Position)
		end
		if val == 6 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level1.Spawn6.Position)
		end
		if val == 7 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level1.Spawn7.Position)
		end
		
		wait()
		
		local d = player.Backpack:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Tool") then
		clone = d[i]:Clone()
		clone.Parent = nil
		d[i]:remove()
		end
		end
		
		local d2 = player.Backpack:GetChildren() 
		for i2=1, #d2 do 
		if (d2[i2].className == "LocalScript") then 
				d2[i2].Disabled = true
			end
		end
		
		gui = script.JailTime:Clone()
		gui.Parent = player.PlayerGui
		gui.TimeValue.Value = 150
		gui.Background.Value.Script.Disabled = false
		
		repeat
			gui.TimeValue.Value = gui.TimeValue.Value - 1
			wait(1)
		until
			gui.TimeValue.Value == 0
			
		clone.Parent = player.Backpack
		
		local d2 = player.Backpack:GetChildren() 
		for i2=1, #d2 do 
		if (d2[i2].className == "LocalScript") then 
				d2[i2].Disabled = false
			end
		end
		
		gui:remove()
		player.Data.Imprisoned.Value = false
		player.Character:MoveTo(game.Workspace.FakeImpelDown.Door.Position + Vector3.new(-20, 0, 0))
		script:Destroy()
		
		force = Instance.new("ForceField")
		force.Parent = player.Character
		wait(20)
		force:remove()
	end
	
	if player.Data.Bounty.Value >= 100000001 and player.Data.Bounty.Value <= 250000000 and player.Data.Imprisoned.Value == true then
		print("level 5")
		val = math.random(1, 7)
		if val == 1 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level5.Spawn1.Position)
		end
		if val == 2 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level5.Spawn2.Position)
		end
		if val == 3 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level5.Spawn3.Position)
		end
		if val == 4 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level5.Spawn4.Position)
		end
		if val == 5 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level5.Spawn5.Position)
		end
		if val == 6 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level5.Spawn6.Position)
		end
		if val == 7 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level5.Spawn7.Position)
		end
		
		wait()
		
		local d = player.Backpack:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Tool") then
			clone = d[i]:Clone()
			clone.Parent = nil
			d[i]:remove()
		end
		end
		
		local d2 = player.Backpack:GetChildren() 
		for i2=1, #d2 do 
		if (d2[i2].className == "LocalScript") then 
				d2[i2].Disabled = true
			end
		end
		
		gui = script.JailTime:Clone()
		gui.Parent = player.PlayerGui
		gui.TimeValue.Value = 180
		gui.Background.Value.Script.Disabled = false
		
		repeat
			gui.TimeValue.Value = gui.TimeValue.Value - 1
			wait(1)
		until
			gui.TimeValue.Value == 0
			
		clone.Parent = player.Backpack
		
		local d2 = player.Backpack:GetChildren() 
		for i2=1, #d2 do 
		if (d2[i2].className == "LocalScript") then 
				d2[i2].Disabled = false
			end
		end
		
		gui:remove()
		player.Data.Imprisoned.Value = false
		player.Character:MoveTo(game.Workspace.FakeImpelDown.Door.Position + Vector3.new(-20, 0, 0))
		script:Destroy()
		
		force = Instance.new("ForceField")
		force.Parent = player.Character
		wait(20)
		force:remove()
	end
	
	if player.Data.Bounty.Value >= 250000001 and player.Data.Imprisoned.Value == true then
		print("level 6")
		val = math.random(1, 7)
		if val == 1 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level6.Spawn1.Position)
		end
		if val == 2 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level6.Spawn2.Position)
		end
		if val == 3 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level6.Spawn3.Position)
		end
		if val == 4 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level6.Spawn4.Position)
		end
		if val == 5 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level6.Spawn5.Position)
		end
		if val == 6 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level6.Spawn6.Position)
		end
		if val == 7 then
			player.Character:MoveTo(game.Workspace.ImpelDown.Level6.Spawn7.Position)
		end
		
		wait()
		
		local d = player.Backpack:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Tool") then
		clone = d[i]:Clone()
		clone.Parent = nil
		d[i]:remove()
		end
		end
		
		local d2 = player.Backpack:GetChildren() 
		for i2=1, #d2 do 
		if (d2[i2].className == "LocalScript") then 
				d2[i2].Disabled = true
			end
		end
		
		gui = script.JailTime:Clone()
		gui.Parent = player.PlayerGui
		gui.TimeValue.Value = 210
		gui.Background.Value.Script.Disabled = false
		
		repeat
			gui.TimeValue.Value = gui.TimeValue.Value - 1
			wait(1)
		until
			gui.TimeValue.Value == 0
			
		clone.Parent = player.Backpack
		
		local d2 = player.Backpack:GetChildren() 
		for i2=1, #d2 do 
		if (d2[i2].className == "LocalScript") then 
				d2[i2].Disabled = false
			end
		end
		
		gui:remove()
		player.Data.Imprisoned.Value = false
		player.Character:MoveTo(game.Workspace.FakeImpelDown.Door.Position + Vector3.new(-20, 0, 0))
		script:Destroy()
		
		force = Instance.new("ForceField")
		force.Parent = player.Character
		wait(20)
		force:remove()
	end
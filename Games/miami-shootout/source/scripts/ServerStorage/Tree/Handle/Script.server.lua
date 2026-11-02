local serverdb = false

script.Parent.RemoteEvent.OnServerEvent:Connect(function(p)
	if serverdb == false then
		serverdb = true
	wait(1)
	
	local eff = script.Parent.Particle:Clone()
	
	eff.Parent = p.Character.Head
		
		eff.Enabled = true
		wait(math.random(1,3))
		
		eff.Enabled = false
		
		game.Debris:AddItem(eff,5)
		
		serverdb = false
		
		
		script.Parent.Size = script.Parent.Size - Vector3.new(0,0,.1)
		
		if script.Parent.Size.Z <=.1 then
			
			p.Character.Humanoid:UnequipTools()
			
			script.Parent.Parent:Destroy()
			
		end
		
	end
end)

script.Parent.Parent.Equipped:Connect(function()
	script.Parent.Parent.Part.Transparency = 1
	
	
	
end)
script.Parent.Parent.Unequipped:Connect(function()
	script.Parent.Parent.Part.Transparency = 0
end)
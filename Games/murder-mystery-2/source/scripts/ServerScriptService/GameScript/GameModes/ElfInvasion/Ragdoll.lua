gluePos = {
	['RightHand'] = {CFrame.new(1.5, 0.5, 0), CFrame.new(0, 0.5, 0)},
	['RightLowerArm'] = {CFrame.new(1.5, 0.5, 0), CFrame.new(0, 0.5, 0)},
	['RightUpperArm'] = {CFrame.new(1.5, 0.5, 0), CFrame.new(0, 0.5, 0)},
	
	['LeftHand'] = {CFrame.new(-1.5, 0.5, 0), CFrame.new(0, .5, 0)},
	['LeftLowerArm'] = {CFrame.new(-1.5, 0.5, 0), CFrame.new(0, .5, 0)},
	['LeftUpperArm'] = {CFrame.new(-1.5, 0.5, 0), CFrame.new(0, .5, 0)},
	
	['RightFoot'] = {CFrame.new(0.5, -1, 0),  CFrame.new(0, 1, 0)},
	['RightLowerLeg'] = {CFrame.new(0.5, -1, 0),  CFrame.new(0, 1, 0)},
	['RightUpperLeg'] = {CFrame.new(0.5, -1, 0),  CFrame.new(0, 1, 0)},
	
	['LeftFoot'] = {CFrame.new(-0.5, -1, 0), CFrame.new(0, 1, 0)},
	['LeftLowerLeg'] = {CFrame.new(-0.5, -1, 0), CFrame.new(0, 1, 0)},
	['LeftUpperLeg'] = {CFrame.new(-0.5, -1, 0), CFrame.new(0, 1, 0)},
	
	['Head'] = {CFrame.new(0, 1, 0), CFrame.new(0, -.5, 0)}
}

bodyParts = {
	'RightHand',
	'RightLowerArm',
	'RightUpperArm',
	
	'LeftHand',
	'LeftLowerArm',
	'LeftUpperArm',	
	
	'Head',
	
	'RightFoot',
	'RightLowerLeg',
	'RightUpperLeg',
	
	'LeftFoot',
	'LeftLowerLeg',
	'LeftUpperLeg',
}


function ragdoll(dedchar, keepChar)
	dedchar.Archivable = true
	local c = dedchar:Clone()
	if not keepChar then
		dedchar:Destroy()
	end
	
	wait(1/60)
	if c:FindFirstChild("Pet") then
		c.Pet:Destroy();
	end
	c.Parent = workspace
	c.Humanoid.MaxHealth = 0
	c.Name = "Raggy";
	game:GetService("Debris"):AddItem(c, 30)
	
	for i,v in pairs(c:GetChildren()) do
		if gluePos[v.Name] then
			v.CanCollide = true
			v.Velocity = Vector3.new(0,0,0)
		elseif v:IsA("Script") or v:IsA("LocalScript") then
			v:Destroy()
		end	
		if v.Name == "HumanoidRootPart" then
			v:Destroy()
		end			
	end 
	
	for i,v in pairs(c.UpperTorso:GetChildren()) do
		if v:IsA("Motor6D") then
			v:Destroy()
		end
	end
	
	local welds = {}
	for z,x in pairs(bodyParts) do
		local part = c:FindFirstChild(x)
		part.Velocity = Vector3.new(0,0,0)
		local g = Instance.new("Weld", c)
		g.Part0 = c.UpperTorso
		g.Part1 = part
		local cframes = gluePos[x]
		g.C0 = cframes[1]
		g.C1 = cframes[2]
		table.insert(welds, g)
	end
	
	for z,x in pairs(bodyParts) do
		local part = c:FindFirstChild(x)
		print("Glue for "..x)
		local g = Instance.new("Glue", c)
		g.Part0 = c.UpperTorso
		g.Part1 = part
		local cframes = gluePos[x]
		g.C0 = cframes[1]
		g.C1 = cframes[2]
	end
	
	for _,Part in pairs(c:GetChildren()) do
		if c:IsA("Tool") or c.Name == "Handle" then
			c:Destroy();
		end
	end
	
	spawn(function()
		wait()
		for i,v in pairs(welds) do
			v:Destroy()
		end
	end)
end

return ragdoll

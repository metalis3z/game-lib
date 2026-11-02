local ProximityPrompt = script.Parent
local DriveSeat = ProximityPrompt.Parent
local Bike = DriveSeat.Parent
local Owner = Bike:WaitForChild('Owner')

ProximityPrompt.TriggerEnded:Connect(function(Player)
	local Character = Player.Character or Player.CharacterAdded:Wait()
	local Humanoid = Character:FindFirstChildWhichIsA('Humanoid')
	local Shiftlock = Character:FindFirstChild('Shiftlock')
	
	if DriveSeat:FindFirstChild('Locked') then
		game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'Vehicle is locked.', 2)
		return 
	end
	
	if Shiftlock then
		if Shiftlock.Value == true then
			game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'Cant enter vehicle while in shiftlock.', 2)
			return
		end
	else
		return
	end
	
	if string.lower(Owner.Value) == string.lower(Player.Name) and not Humanoid.Sit then 
		DriveSeat:Sit(Humanoid)
		ProximityPrompt.Enabled = false
	else
		return
	end
end)

DriveSeat.ChildAdded:Connect(function(Child)
	if Child.Name == 'Locked' then
		ProximityPrompt.Enabled = false
		for _,v in next, Bike:GetDescendants() do
			if v:IsA('Seat') and not v:IsA('VehicleSeat') and v.Name == 'Seat' then
				v.Disabled = true
			end
		end
	end
end)

DriveSeat.ChildRemoved:Connect(function(Child)
	if Child.Name == 'Locked' then
		ProximityPrompt.Enabled = true
		for _,v in next, Bike:GetDescendants() do
			if v:IsA('Seat') and not v:IsA('VehicleSeat') and v.Name == 'Seat' then
				v.Disabled = false
			end
		end
	end
end)
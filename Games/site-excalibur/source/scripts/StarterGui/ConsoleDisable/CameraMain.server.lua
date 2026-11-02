event = script.RemoteEvent
player = script.Parent.Parent

event.OnServerEvent:connect(function(plr, pos, pos2, OldNeckC0, OldNeckC1, OldShoulderC0, OldShoulderC1, OldShoulder2C0, OldShoulder2C1, inthird)
	if plr ~= player then
		--plr:Kick("h e y")
	else
		
		local char = plr.Character
		if char:FindFirstChild("Head") and char:FindFirstChild("UpperTorso") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
	local toMouse = (pos - char.Head.Position).unit
			local angle = math.acos(toMouse:Dot(Vector3.new(0,1,0)))
			local neckAngle = angle
			if math.deg(neckAngle) > 110 then
		neckAngle = math.rad(110)
			end
			
			local torso = char:FindFirstChild("UpperTorso")
			local head = char:FindFirstChild("Head")
			local Neck = head["Neck"]
			local rua = char:FindFirstChild("RightUpperArm")
			local lua = char:FindFirstChild("LeftUpperArm")
			local Shoulder = rua["RightShoulder"]
			local Shoulder2 = lua["LeftShoulder"]
			
			Shoulder.C0 = OldShoulderC0
			Shoulder.C1 = OldShoulderC1
			Shoulder2.C0 = OldShoulder2C0
			Shoulder2.C1 = OldShoulder2C1
			
			Neck.C0 = CFrame.new(0,0.75,0) * CFrame.Angles(math.pi/2 - neckAngle,0,0)
			
			local toMouse = (pos - head.Position).unit
			local angle = math.acos(toMouse:Dot(Vector3.new(0,1,0)))
			
			if char:FindFirstChild("Head") and char:FindFirstChild("UpperTorso") and char:FindFirstChildOfClass("Tool") and not inthird then
	--char.Torso.Neck.C1 = CFrame.new() --Sets the C1 to a blank CFrame so the head doesn't glitch.
 	--char.Torso["Right Shoulder"].C1 = OldShoulderC0
	Shoulder.C0 = CFrame.new(1,0.5,0) * CFrame.Angles(math.pi/2 - angle,0,0)
	--char.Torso["Left Shoulder"].C1 = OldShoulder2C1
	Shoulder2.C0 = CFrame.new(-1,0.5,0) * CFrame.Angles(math.pi/2 - angle,0,0)
	
    --char.Torso.Neck.C0 = CFrame.new(0, 1.5, 0) * CFrame.Angles(math.asin((pos - pos2).unit.y), 0, 0) --Moves the head up by 1.5 studs and then sets the angle of your character's neck looking up towards the mouse using inverse trigonometry (A grade maths) and unit vectors (so you only get the direction.)
	elseif char:FindFirstChild("Head") and char:FindFirstChild("UpperTorso") and char:FindFirstChildOfClass("Tool") == nil or inthird then
		Neck.C0 = OldNeckC0
		Neck.C1 = OldNeckC1
		Shoulder.C0 = OldShoulderC0
		Shoulder.C1 = OldShoulderC1
		Shoulder2.C0 = OldShoulder2C0
		Shoulder2.C1 = OldShoulder2C1
end

if char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues") then
	local offr = char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues").RightArm.Value
	local offl = char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues").LeftArm.Value
	local offh = char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues").Head.Value
		
	Shoulder.C0 = Shoulder.C0 * offr
	Shoulder2.C0 = Shoulder2.C0 * offl
	Neck.C0 = Neck.C0 * offh
end

			end
		
		end
end)
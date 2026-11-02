GUI = script.Parent.Screen

script.Parent.ChildAdded:connect(function(child)
	if child:IsA("Weld") and (child.Part1.Name == "HumanoidRootPart") then --// Detect player
		child.C0 = CFrame.new(0,-0.6,0)*CFrame.fromEulerAnglesXYZ(-(math.pi/2),0,0) --// Reposition player
		player = game.Players:GetPlayerFromCharacter(child.Part1.Parent)
		if player and (not player.PlayerGui:FindFirstChild("Screen")) then --// The part after the "and" prevents multiple GUI's to be copied over.
			GUI.CarSeat.Value = script.Parent --// Puts a reference of the seat in this ObjectValue, now you can use this ObjectValue's value to find the car directly.
			GUI:Clone().Parent = player.PlayerGui --// Compact version
		end
	end
end)

script.Parent.ChildRemoved:connect(function(child)
	if child:IsA("Weld") and child.Part1.Name == "HumanoidRootPart" then
		script.Parent.Parent.Parent.RWD.Throttle = 0
		script.Parent.Parent.Parent.RWD.Torque = 10
		script.Parent.Parent.Parent.LW.VS.Throttle = 0
		script.Parent.Parent.Parent.LW.VS.Torque = 10
		script.Parent.Parent.Parent.RW.VS.Throttle = 0
		script.Parent.Parent.Parent.RW.VS.Torque = 10
		script.Parent.Sound.Pitch = 0
		player = game.Players:GetPlayerFromCharacter(child.Part1.Parent)
		if player and player.PlayerGui:FindFirstChild("Screen") then
			player.PlayerGui:FindFirstChild("Screen"):Destroy()
		end
	end
end)


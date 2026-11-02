if script.Parent:IsA("VehicleSeat")then
	   script.Parent.ChildAdded:Connect(function(Child)
		 if Child:IsA("Weld") and game.Players:GetPlayerFromCharacter(Child.Part1.Parent)~=nil then
			local Player = game.Players:GetPlayerFromCharacter(Child.Part1.Parent)
			local Gui = script.Radio:Clone()
			Gui.Parent = Player.PlayerGui
			Gui:WaitForChild("Vehicle")
			Gui.Vehicle.Value = script.Parent.Parent
		end
	end)
end


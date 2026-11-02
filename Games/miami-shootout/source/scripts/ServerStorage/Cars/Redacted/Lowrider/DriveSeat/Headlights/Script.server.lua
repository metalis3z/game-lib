if script.Parent.Parent:IsA("VehicleSeat")then
	   script.Parent.Parent.ChildAdded:Connect(function(Child)
		 if Child:IsA("Weld") and game.Players:GetPlayerFromCharacter(Child.Part1.Parent)~=nil then
			local Player = game.Players:GetPlayerFromCharacter(Child.Part1.Parent)
			local Gui = script.VehicleMisc:Clone()
			Gui.Parent = Player.PlayerGui
			Gui:WaitForChild("Vehicle")
			Gui.Vehicle.Value = script.Parent.Parent.Parent
			Gui.Lights.Disabled = false
		end
	end)
end


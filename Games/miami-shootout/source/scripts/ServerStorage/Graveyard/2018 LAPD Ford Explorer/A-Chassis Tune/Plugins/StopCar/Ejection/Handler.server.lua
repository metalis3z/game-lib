script.Parent.OnServerEvent:Connect(function(p,car)
	
	print("got an ejection fired")
	if car == script.Parent.Parent then
		print("zoo")
		if p.Team == game.Teams.Police then
			for i,v in pairs(car.Body:GetChildren()) do
				if v.Name == "Seat" then
					local occupant = v.Occupant
					print("EJECTING...")
					if occupant then occupant.Jump = true print("EJECTED") end
				end
			end
		end
	end
	
end)
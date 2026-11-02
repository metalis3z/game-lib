function playSiren(Seat,Name)
	
	for i,v in pairs(Seat:GetChildren()) do
		
		if v:IsA("Sound") then
			if v.Name ~= "Honk" and v.Name ~= Name then
				v:Stop()
			end
			if v.Name == Name then
				v:Play()
			end
		end
		
	end
	
end

script.Parent.OnServerEvent:Connect(function(p,car,action,paramater)
	
	if p.Team ~= game.Teams.Police then
		return print("not police")
	end
	
	print("got a siren fired")
	if car == script.Parent.Parent then
		print("we good at "..car:GetFullName())
		local driveSeat = car:FindFirstChild("DriveSeat")
	
		if action == "honk" then
			driveSeat.Honk:Play()
		elseif action == "stopsirens" then
			playSiren(driveSeat,"NONE")
		elseif action == "play" then
			playSiren(driveSeat,paramater)
		end
		
	end
	
end)
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

script.Parent.OnServerEvent:Connect(function(p,car,action,paramater,p2)
	
	if p.Team ~= game.Teams.EMS then
		return print("not EMS")
	end
	
	print("got a siren fired")
	if car == script.Parent.Parent then
		print("we good at "..car:GetFullName())
		local driveSeat = car:FindFirstChild("DriveSeat")
	
		if action == "honk" then
			driveSeat.Honk:Play()
		elseif action == "spotlight" then
			
			local spotLight = car:FindFirstChild("Body"):FindFirstChild("Headlight")
			
			if paramater == "on" then
				spotLight.on.Value = true
			elseif paramater == "off" then
				spotLight.on.Value = false
			end
		elseif action == "lights" then
			if paramater == "rumbler" then
				if p2 == "on" then
					car:FindFirstChild("Body"):FindFirstChild("Lightbar").on.Value = true
				elseif p2 == "off" then
					car:FindFirstChild("Body"):FindFirstChild("Lightbar").on.Value = false
				end
			end
		elseif action == "stopsirens" then
			playSiren(driveSeat,"NONE")
		elseif action == "play" then
			playSiren(driveSeat,paramater)
		end
		
	end
	
end)
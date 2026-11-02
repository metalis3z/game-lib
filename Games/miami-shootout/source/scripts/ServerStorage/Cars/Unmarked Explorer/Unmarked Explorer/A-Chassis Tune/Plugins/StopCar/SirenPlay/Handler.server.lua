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
	
	if p.Team ~= game.Teams.Police then
		return print("not police")
	end
	
	print("got a siren fired")
	if car == script.Parent.Parent then
		print("we good at "..car:GetFullName())
		local driveSeat = car:FindFirstChild("DriveSeat")
	
		if action == "honk" then
			driveSeat.Honk:Play()
		elseif action == "spotlight" then
			
			local spotLight = car:FindFirstChild("Body"):FindFirstChild("Spotlight")
			
			if paramater == "on" then
				for h,t in pairs(spotLight.Off.Trans:GetChildren())do
					t.Transparency = 1
				end

				for m,p in pairs(spotLight.Lights:GetChildren())do
					if p.Name == "On" then
						p.Transparency = 0
						spotLight.Lights.Light.Transparency = 0.3
					end
				end
				for i,light in pairs(spotLight.Lights:GetChildren()) do
					if light.Name == "Light" then 
						light.Material = "Neon" 
					end
				end
				spotLight.Lights.LightPart.Light.SpotLight.Enabled = true
				spotLight.Lights.LightPart.Beam.Enabled = true
			elseif paramater == "off" then
				for i,light in pairs(spotLight.Lights:GetChildren()) do
					if light.Name == "Light" then light.Material = "SmoothPlastic" 
					end
				end
				spotLight.Lights.LightPart.Light.SpotLight.Enabled = false
				spotLight.Lights.LightPart.Beam.Enabled = false
				for h,t in pairs(spotLight.Off.Trans:GetChildren())do
					t.Transparency = 0
					spotLight.Off.Trans.Light.Transparency = 0.3
				end
				for m,p in pairs(spotLight.Lights:GetChildren())do
					if p.Name == "On" then
						p.Transparency = 1
						spotLight.Lights.Light.Transparency = 1
					end
				end
				spotLight.Lights.Motor1.DesiredAngle = 0
			elseif paramater == "right_start" then
				print("STARTING RIGHT")
				spotLight.Lights.Motor1.DesiredAngle = -3.2
			elseif paramater == "right_stop" then
				print("STOPPING RIGHT")
				spotLight.Lights.Motor1.DesiredAngle = spotLight.Lights.Motor1.CurrentAngle
			elseif paramater == "left_start" then
				print("STARTING LEFT")
				spotLight.Lights.Motor1.DesiredAngle = 3.2
			elseif paramater == "left_stop" then
				print("STOPPING LEFT")
				spotLight.Lights.Motor1.DesiredAngle = spotLight.Lights.Motor1.CurrentAngle
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
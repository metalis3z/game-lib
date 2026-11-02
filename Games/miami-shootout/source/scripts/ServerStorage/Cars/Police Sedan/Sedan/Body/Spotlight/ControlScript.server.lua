wait()
local up = false


script.Parent.RemoteEvent.OnServerEvent:Connect(function(p, var)
	if var == "Lights on" then
		for h,t in pairs(script.Parent.Off.Trans:GetChildren())do
			t.Transparency = 1
		end
		
		for m,p in pairs(script.Parent.Lights:GetChildren())do
			if p.Name == "On" then
				p.Transparency = 0
				script.Parent.Lights.OnG.Transparency = 0.75
				script.Parent.Lights.Light.Transparency = 0
			end
		end
		for i,light in pairs(script.Parent.Lights:GetChildren()) do
			if light.Name == "Light" then 
				light.Material = "Neon" 
			end
		end
		script.Parent.Lights.LightPart.Light.SpotLight.Enabled = true
		script.Parent.Lights.LightPart.Beam.Enabled = true
	elseif var == "Lights off" then
		
		for i,light in pairs(script.Parent.Lights:GetChildren()) do
			if light.Name == "Light" then light.Material = "SmoothPlastic" 
			end
		end
		script.Parent.Lights.LightPart.Light.SpotLight.Enabled = false
		script.Parent.Lights.LightPart.Beam.Enabled = false
		for h,t in pairs(script.Parent.Off.Trans:GetChildren())do
				t.Transparency = 0
				script.Parent.Off.Trans.Light.Transparency = 0.75
			end
			for m,p in pairs(script.Parent.Lights:GetChildren())do
				if p.Name == "On" then
					p.Transparency = 1
					script.Parent.Lights.OnG.Transparency = 1
					script.Parent.Lights.Light.Transparency = 1
				end
			end
		script.Parent.Lights.Motor1.DesiredAngle = 0
	end
	if var == "Right start" then
		script.Parent.Lights.Motor1.DesiredAngle = -3.2
	elseif var == "Right stop" then
		script.Parent.Lights.Motor1.DesiredAngle = script.Parent.Lights.Motor1.CurrentAngle
	elseif var == "Left start" then
		script.Parent.Lights.Motor1.DesiredAngle = 3.2
	elseif var == "Left stop" then
		script.Parent.Lights.Motor1.DesiredAngle = script.Parent.Lights.Motor1.CurrentAngle
	end
end)

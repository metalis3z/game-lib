

script.Parent.ClickDetector.MouseClick:Connect(function()
	
	if script.Parent.Parent.Screen.SpotLight.Enabled == false then
	
	script.Parent.Parent.Screen.BrickColor = BrickColor.new("Pastel Blue")
	
	script.Parent.Parent.Screen.Material = "Neon"
	
	script.Parent.Parent.Screen.SpotLight.Enabled = true
	
	script.Parent.Parent.Screen.Decal.Transparency = 0.7
	script.Parent.Parent.Screen.Decal1.Transparency = 0.7
	
	script.Parent.Parent.Screen["TV Noise"]:Play()

	
	
	else
		
	script.Parent.Parent.Screen.BrickColor = BrickColor.new("Really black")
	
	script.Parent.Parent.Screen.Material = "SmoothPlastic"
	
	script.Parent.Parent.Screen.SpotLight.Enabled = false
	
	script.Parent.Parent.Screen.Decal.Transparency = 1
	script.Parent.Parent.Screen.Decal1.Transparency = 1
	
	script.Parent.Parent.Screen["TV Noise"]:Stop()
	
	end
end)



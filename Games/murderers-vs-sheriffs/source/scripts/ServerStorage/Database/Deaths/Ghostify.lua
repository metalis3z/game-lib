return function(char)
	for i,v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 0.5
			v.BrickColor = BrickColor.new("Institutional white")
			for i,c in pairs(char:GetChildren()) do
				if c.Name == "Part" and c.Name ~= "HumanoidRootPart" then
					c.Transparency = 0.6
					for i,a in pairs(char:GetChildren()) do
						if a:IsA("Accessory") or a:IsA("ShirtGraphic") or a:IsA("Shirt") or a:IsA("Pants") then
							a:Destroy()
						end
					end
				end
			end
		end
	end
end
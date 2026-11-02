return function(char)
	for i,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Color = Color3.fromRGB(255, 255, 255)
			v.Transparency = 0.2
			if v.Name == "Part" then
				v.Transparency = 1
			end
		end
	end
	for i,v in pairs(char:GetDescendants()) do
		if v:IsA("SpecialMesh") then
			v.TextureId = ""
		end
	end
	for i,v in pairs(char:GetDescendants()) do
		if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
			v:Destroy()
		end
	end
end
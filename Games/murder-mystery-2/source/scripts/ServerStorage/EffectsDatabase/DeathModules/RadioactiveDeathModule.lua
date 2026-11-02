return function(char)
	for i,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Color = Color3.fromRGB(0, 255, 0)
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
return function(rag)
	for i,v in pairs(rag:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Color = Color3.fromRGB(248, 217, 109)
			v.Material = Enum.Material.Sand
		end
	end
	for i,v in pairs(rag:GetDescendants()) do
		if v:IsA("SpecialMesh") then
			v.TextureId = ""
		end
	end
	for i,v in pairs(rag:GetDescendants()) do
		if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
			v:Destroy()
		end
	end
end
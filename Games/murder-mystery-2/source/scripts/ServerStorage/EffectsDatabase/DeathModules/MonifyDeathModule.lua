return function(char)
	for _, v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") then

			local shirt = char:FindFirstChildOfClass("Shirt")
			local Pants = char:FindFirstChildOfClass("Pants")

			shirt.ShirtTemplate = "rbxassetid://6249435894"

			Pants.PantsTemplate = "rbxassetid://6249435894"
		end
	end
	for _, v in pairs(char:GetChildren()) do
		if v:IsA('Accessory') then
			v:Destroy()
		end
	end
end
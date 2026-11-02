for i, v in pairs(script.Parent:GetDescendants()) do
	if v:IsA("Light") then
		v.Enabled = true
	end
end

for i, v in pairs(script.Parent.Parent:GetDescendants()) do
	if v:IsA("Model") and v.Name == "Table" then
		local clone = script.Parent.Parent.Parent.FurniturePoint.Start:Clone()
		
		clone.Name = "FurniturePoint"..i
		clone.Parent = script.Parent.Parent.Parent.FurniturePoint
		clone:PivotTo(v.PrimaryPart.CFrame)
		clone:SetAttribute("Type", "Random")
		v:Destroy()
	end
	
	if v:IsA("Model") and v.Name == "Dresser" then
		local clone = script.Parent.Parent.Parent.FurniturePoint.Start:Clone()

		clone.Name = "FurniturePoint"..i
		clone.Parent = script.Parent.Parent.Parent.FurniturePoint
		clone:PivotTo(v.PrimaryPart.CFrame)
		clone:SetAttribute("Type", "Dresser")
		v:Destroy()
	end
	
	if v:IsA("Model") and v.Name == "Painting_VeryBig" or v:IsA("Model") and v.Name == "Painting_Big" then
		local clone = script.Parent.Parent.Parent.PaintingPoint.Start:Clone()

		clone.Name = "PaintingPoint"..i
		clone.Parent = script.Parent.Parent.Parent.PaintingPoint
		clone:PivotTo(v.PrimaryPart.CFrame)
		v:Destroy()
	end
end

for i, v in pairs(script.Parent.Parent.Parent.Parts:GetDescendants()) do
	if v:IsA("Model") and v.Name == "DoorNormal" then
		
		local clone = script.Parent.Parent.Parent.RandomDoor.Start:Clone()
		
		clone.Name = "RandomDoor"
		clone.Parent = script.Parent.Parent.Parent.RandomDoor
		clone:PivotTo(v.PrimaryPart.CFrame)
		v:Destroy()
	end
end

script.Parent.Parent.Parent.RandomDoor.Start:Destroy()
script.Parent.Parent.Parent.FurniturePoint.Start:Destroy()
script.Parent.Parent.Parent.PaintingPoint.Start:Destroy()
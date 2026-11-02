return function(char)
	for _, v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") then
			v.Color = Color3.fromRGB(0,0,0)
		end
	end    
	for _, v in pairs(char:GetChildren()) do
		if v:IsA("Pants") or v:IsA("Shirt") then
			v:Destroy()
		end
	end
	if 
		char:WaitForChild("head")then
		local eliteskull =
			Instance.new("SpecialMesh", char.Head)
		eliteskull.MeshId = "http://www.roblox.com/asset/?id=36869983"
		eliteskull.TextureId = "rbxassetid://6252016835"
		eliteskull.Scale = Vector3.new(1,1,1)
	end
	char.Head.face:Destroy()
	local Burning =
		Instance.new("Fire", char.Head)
	Burning.Color = 
		Color3.fromRGB(255,0,0)
	Burning.SecondaryColor = 
		Color3.fromRGB(255,0,0)
	Burning.Heat = 3
	Burning.Size = 4
end
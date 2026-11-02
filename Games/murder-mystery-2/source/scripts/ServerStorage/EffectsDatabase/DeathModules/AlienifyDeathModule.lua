return function(char)
	for i,v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") then
			v.Color = Color3.fromRGB(124, 156, 107)
		end
	end
	for i,v in pairs(char:GetChildren()) do
		if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("Accessory") then
			v:Destroy()
		end
	end
	if
		char:WaitForChild("head")then
	local Alien =
		Instance.new("SpecialMesh", char.Head)
	Alien.MeshId = "http://www.roblox.com/asset/?id=13827689"
		Alien.TextureId = "http://www.roblox.com/asset/?id=20908610"
		Alien.Scale = Vector3.new(1,1,1)
		char.Head.face:Destroy()
	end
	script.a:Clone().Parent = char.UpperTorso
	script.c:Clone().Parent = char.LeftUpperArm
	script.c1:Clone().Parent = char.RightUpperArm
end
return function(char)
	for _, v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") then

			local shirt = char:FindFirstChildOfClass("Shirt")
			local Pants = char:FindFirstChildOfClass("Pants")

			shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=1152311636"

			Pants.PantsTemplate = "http://www.roblox.com/asset/?id=2901884452"
		end
	end
	for _, v in pairs(char:GetChildren()) do
		if v:IsA('Accessory') then
			v:Destroy()
		end
	end

	if char:WaitForChild("head") then
		local dogehat = Instance.new("SpecialMesh", char.Head)
		dogehat.MeshId = "rbxassetid://151778863"
		dogehat.TextureId = "rbxassetid://151778895"
		dogehat.Scale = Vector3.new(1,1,1)
	end
	char.head.face:Destroy()
end
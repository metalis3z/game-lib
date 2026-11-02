return function(Knife)
	if Knife.Handle:FindFirstChild("Mesh") then
		Knife.Handle.Mesh.TextureId = "rbxassetid://1268902588"
	else
		Knife.Handle.TextureID = "rbxassetid://1268902588"
	end
end
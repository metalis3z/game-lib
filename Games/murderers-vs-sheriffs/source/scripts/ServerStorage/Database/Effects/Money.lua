return function(Knife)
	if Knife.Handle:FindFirstChild("Mesh") then
		Knife.Handle.Mesh.TextureId = "rbxassetid://12180152174"
	else
		Knife.Handle.TextureID = "rbxassetid://12180152174"
	end
end
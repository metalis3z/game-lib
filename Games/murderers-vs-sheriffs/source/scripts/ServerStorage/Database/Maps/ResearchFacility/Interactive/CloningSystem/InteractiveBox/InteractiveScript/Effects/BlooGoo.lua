-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1, v2, v3 = pairs(p1:GetDescendants());
	for _,v5 in pairs(p1:GetChildren()) do
		if v5:IsA("CharacterAppearance") then
			v5:Destroy();
		end;
		if v5:FindFirstChild("Mesh") then
			v5.Mesh.TextureId = "";
			v5.Mesh.VertexColor = Vector3.new(0, 0, 0);
		end;
		if v5:IsA("BasePart") then
			v5.BrickColor = BrickColor.new("Toothpaste");
			if v5:IsA("MeshPart") then
				v5.TextureID = "";
			end;
		end;	
	end;
end;

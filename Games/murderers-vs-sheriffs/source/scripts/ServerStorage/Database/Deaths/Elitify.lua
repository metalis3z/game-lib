return function(p1)
	for _,v6 in pairs(p1:GetChildren()) do
		wait()
		if v6:IsA("CharacterAppearance") then
			v6:Destroy();
		end;
		if v6:FindFirstChild("Mesh") then
			v6.Mesh.TextureId = "";
			v6.Mesh.VertexColor = Vector3.new(0, 0, 0);
		end;
		if v6:IsA("BasePart") then
			v6.BrickColor = BrickColor.new("Really black");
			if v6:IsA("MeshPart") then
				v6.TextureID = "http://www.roblox.com/asset/?id=2675785344";
			end;
			if v6.Name == "Head" then
				local Fire = Instance.new("Fire", v6);
				Fire.Heat = 1
				Fire.Color = Color3.fromRGB(255, 0, 0)
			end;	
			end;
	end;
end;
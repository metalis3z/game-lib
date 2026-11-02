return function(p1)
	local v1 = Instance.new("Sound");
	v1.SoundId = "http://www.roblox.com/asset/?id=177045481";
	v1.Volume = 0.2;
	v1.PlayOnRemove = false;
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
			if v6.Name == "UpperTorso" then
				local fire = Instance.new("Fire")
				fire.Color = Color3.fromRGB(0, 170, 255)
				fire.SecondaryColor = Color3.fromRGB(0, 170, 255)
				fire.Parent = v6

				v1.Parent = v6
				v1:Play()
				game.Debris:AddItem(v1, 5)
			end
		end;
	end;
end;
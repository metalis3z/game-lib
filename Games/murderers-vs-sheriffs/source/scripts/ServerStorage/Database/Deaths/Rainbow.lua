return function(char)
	local v1 = Instance.new("Sound");
	v1.SoundId = "http://www.roblox.com/asset/?id=177045481";
	v1.Volume = 0.2;
	v1.PlayOnRemove = false;
	for _,v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") then
			v.Color = Color3.fromRGB(0,0,0)
		end
		if v.Name == "UpperTorso" then
			local Fire = script.Fire:Clone()
			v1.Parent = v;
			v1:Play();
			game.Debris:AddItem(v1, 5);
			Fire.Parent = v
		end
		for _,clothes in pairs(char:GetChildren()) do
			if clothes:IsA("Shirt") or clothes:IsA("Pants") then
				clothes:Destroy()
			end
		end
	end
end
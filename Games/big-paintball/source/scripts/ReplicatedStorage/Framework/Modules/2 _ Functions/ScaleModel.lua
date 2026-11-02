--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2)
	if type(p1) ~= "table" then
		p1 = { p1 };
	elseif typeof(p1) == "Instance" then
		p1 = p1:GetChildren();
	end;
	for v1, v2 in ipairs(p1) do
		local v6 = nil;
		local v7 = nil;
		if v2.ClassName == "Model" and v2.PrimaryPart then
			v6 = v2.PrimaryPart;
			v7 = v6.CFrame;
		elseif v2:IsA("BasePart") then
			v6 = v2;
			v7 = v2.CFrame;
			v2.Size = v2.Size * p2;
		end;
		for v8, v9 in pairs(v2:GetDescendants()) do
			if v9:IsA("BasePart") then
				v9.Size = v9.Size * p2;
				if not v6 then
					v6 = v9;
					v7 = v9.CFrame;
				elseif v9 ~= v6 then
					v9.CFrame = (v7 + v7:inverse() * v9.CFrame.p * p2) * CFrame.Angles(v9.CFrame:toEulerAnglesXYZ());
				end;
			elseif v9.ClassName == "Attachment" then
				v9.Position = v9.Position * p2;
			elseif v9.ClassName == "ParticleEmitter" then
				u1.Functions.ScaleParticle(v9, p2);
			elseif v9.ClassName == "SpecialMesh" then
				v9.Scale = v9.Scale * p2;
			end;
		end;	
	end;
end;

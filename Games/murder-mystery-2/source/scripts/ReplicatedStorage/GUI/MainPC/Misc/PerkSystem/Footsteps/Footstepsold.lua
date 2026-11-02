-- Decompiled with the Synapse X Luau decompiler.

return function()
	local v1 = {};
	local v2 = Instance.new("Model", game.Workspace);
	v2.Name = "Footsteps";
	({
		[0.5] = "LeftUpperLeg"
	})[-0.5] = "RightUpperLeg";
	local v3 = 0.5;
	while true do
		wait(0.25);
		for v4, v5 in pairs(game.Players:GetPlayers()) do
			if v5.Character ~= nil and v5 ~= game.Players.LocalPlayer then
				local v6 = v1[v5.Name];
				if v6 == nil then
					v1[v5.Name] = v5.Character.HumanoidRootPart.CFrame.p;
					v6 = v1[v5.Name];
				end;
				if (v5.Character.HumanoidRootPart.CFrame.p - v6).magnitude >= 0.2 then
					local v7 = script.Footstep:Clone();
					v7.CFrame = CFrame.new(v5.Character.HumanoidRootPart.CFrame.p - Vector3.new(0, 3, 0));
					v7.Footstep.Frame1.ImageLabel.ImageColor3 = v5.Character.UpperTorso.BrickColor.Color;
					v7.Footstep.Frame2.ImageLabel.ImageColor3 = v5.Character.UpperTorso.BrickColor.Color;
					local l__LookVector__8 = v5.Character.HumanoidRootPart.CFrame.LookVector;
					local v9 = Vector3.new(l__LookVector__8.X, v7.CFrame.p.Y, l__LookVector__8.Z);
					v7.CFrame = CFrame.new(v7.Position, v7.Position + v5.Character.HumanoidRootPart.CFrame.LookVector - Vector3.new(0, v5.Character.HumanoidRootPart.CFrame.LookVector.Y, 0));
					v7.Parent = v2;
					game.Debris:AddItem(v7, 40);
					v1[v5.Name] = v5.Character.HumanoidRootPart.CFrame.p;
				end;
			end;
		end;
		if v3 == 0.5 then
			v3 = -0.5;
		else
			v3 = 0.5;
		end;	
	end;
end;

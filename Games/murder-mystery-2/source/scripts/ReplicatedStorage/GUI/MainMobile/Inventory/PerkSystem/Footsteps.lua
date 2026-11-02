-- Decompiled with the Synapse X Luau decompiler.

return function()
	local v1 = {};
	local v2 = Instance.new("Model", game.Workspace);
	v2.Name = "Footsteps";
	local v3 = {
		[0.5] = "LeftFoot"
	};
	v3[-0.5] = "RightFoot";
	local v4 = 0.5;
	while true do
		wait(0.25);
		for v5, v6 in pairs(game.Players:GetPlayers()) do
			if v6.Character ~= nil and v6 ~= game.Players.LocalPlayer then
				local v7 = v1[v6.Name];
				if v7 == nil then
					v1[v6.Name] = v6.Character.HumanoidRootPart.CFrame.p;
					v7 = v1[v6.Name];
				end;
				if (v6.Character.HumanoidRootPart.CFrame.p - v7).magnitude >= 0.2 then
					local v8 = script.Footstep:Clone();
					v8.CFrame = CFrame.new(v6.Character.HumanoidRootPart.CFrame.p - Vector3.new(0, 3, 0));
					v8.Footstep[v3[v4]].Visible = true;
					for v9, v10 in pairs(v8.Footstep:GetDescendants()) do
						if v10:IsA("ImageLabel") then
							v10.ImageColor3 = v6.Character.UpperTorso.BrickColor.Color;
							local v11 = game:GetService("TweenService"):Create(v10, TweenInfo.new(27, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 3), {
								ImageTransparency = 1
							}):Play();
						end;
					end;
					local l__LookVector__12 = v6.Character.HumanoidRootPart.CFrame.LookVector;
					local v13 = Vector3.new(l__LookVector__12.X, v8.CFrame.p.Y, l__LookVector__12.Z);
					v8.CFrame = CFrame.new(v8.Position, v8.Position + v6.Character.HumanoidRootPart.CFrame.LookVector - Vector3.new(0, v6.Character.HumanoidRootPart.CFrame.LookVector.Y, 0));
					v8.Parent = v2;
					game.Debris:AddItem(v8, 30);
					v1[v6.Name] = v6.Character.HumanoidRootPart.CFrame.p;
				end;
			end;
		end;
		if v4 == 0.5 then
			v4 = -0.5;
		else
			v4 = 0.5;
		end;	
	end;
end;

-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Oracle Decompiler

local l_TweenService_0 = game:GetService("TweenService");
local l_Folder_0 = Instance.new("Folder");
l_Folder_0.Name = "Footsteps";
l_Folder_0.Parent = workspace;
local v2 = TweenInfo.new(57, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 3);
local v3 = {};
local v4 = "LeftFoot";
local v5 = {
	BrickColor.new("Bright red").Color, 
	BrickColor.new("Bright blue").Color, 
	BrickColor.new("Bright green").Color, 
	BrickColor.new("Bright yellow").Color, 
	BrickColor.new("Bright purple").Color, 
	BrickColor.new("Bright orange").Color, 
	BrickColor.new("Bright violet").Color, 
	BrickColor.new("Pink").Color, 
	BrickColor.new("Dark blue").Color
};
local v6 = {};
Random.new():Shuffle(v5);
while true do
	task.wait(0.25);
	for _, v8 in game.Players:GetPlayers() do
		if v8 ~= game.Players.LocalPlayer then
			local l_Character_0 = v8.Character;
			if l_Character_0 then
				local l_HumanoidRootPart_0 = l_Character_0:FindFirstChild("HumanoidRootPart");
				if l_HumanoidRootPart_0 then
					local l_LeftFoot_0 = l_Character_0:FindFirstChild("LeftFoot");
					local l_RightFoot_0 = l_Character_0:FindFirstChild("RightFoot");
					if l_LeftFoot_0 and l_RightFoot_0 then
						if v3[v8] == nil then
							v3[v8] = l_HumanoidRootPart_0.Position;
						end;
						if v6[v8] == nil then
							if v5[1] then
								v6[v8] = v5[1];
								table.remove(v5, 1);
							else
								v6[v8] = BrickColor.new("Medium stone grey").Color;
							end;
						end;
						if (l_HumanoidRootPart_0.Position - v3[v8]).Magnitude >= 0.2 then
							v3[v8] = l_HumanoidRootPart_0.Position;
							local _ = l_Character_0[v4];
							local v14 = v4 == "LeftFoot" and -0 or 0;
							local v15 = nil;
							local v16 = RaycastParams.new();
							v16.FilterDescendantsInstances = {
								l_Character_0
							};
							local v17 = workspace:Raycast(l_HumanoidRootPart_0.Position, -l_HumanoidRootPart_0.CFrame.UpVector * 12, v16);
							v15 = if v17 then v17.Position else (l_HumanoidRootPart_0.CFrame * CFrame.new(v14, -3.05, 0)).Position;
							local l_LookVector_0 = l_HumanoidRootPart_0.CFrame.LookVector;
							local v19 = script.Footstep:Clone();
							v19.SurfaceGui[v4].Visible = true;
							v19.CFrame = CFrame.lookAt(v15, v15 + l_LookVector_0);
							if v4 == "LeftFoot" then
								v19.SurfaceGui.RightFoot:Destroy();
							else
								v19.SurfaceGui.LeftFoot:Destroy();
							end;
							for _, v21 in v19.SurfaceGui[v4]:GetDescendants() do
								if v21:IsA("ImageLabel") then
									v21.ImageColor3 = v6[v8];
									l_TweenService_0:Create(v21, v2, {
										ImageTransparency = 1
									}):Play();
								end;
							end;
							v19.Parent = l_Folder_0;
							game.Debris:AddItem(v19, 60);
						end;
					end;
				end;
			end;
		end;
	end;
	if v4 == "LeftFoot" then
		v4 = "RightFoot";
	else
		v4 = "LeftFoot";
	end;
end;
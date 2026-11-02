-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = Random.new();
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local l__Sentries__3 = game.Workspace:WaitForChild("__THINGS"):WaitForChild("Sentries");
local function u4()
	local v2 = 0;
	for v3, v4 in pairs(l__Sentries__3:GetChildren()) do
		if v4.Name == l__LocalPlayer__2.Name then
			v2 = v2 + 1;
		end;
	end;
	return v2;
end;
local l__Assets__5 = game.ReplicatedStorage:WaitForChild("Assets");
local u6 = u1.Player.Get("Camera");
local l__Mini_Sentries__7 = game.Workspace:WaitForChild("__THINGS"):WaitForChild("Mini Sentries");
local l__Armored_Sentries__8 = game.Workspace:WaitForChild("__THINGS"):WaitForChild("Armored Sentries");
local function u9()
	local l__Spawns__5 = game.Workspace:WaitForChild("__MAP"):WaitForChild("Spawns");
	for v6, v7 in pairs(game.Teams:GetTeams()) do
		if v7 ~= l__LocalPlayer__2.Team then
			if l__Spawns__5:FindFirstChild(v7.Name) then
				for v8, v9 in pairs(l__Spawns__5:WaitForChild(v7.Name):GetChildren()) do
					if v9 and v9.Position and l__LocalPlayer__2:DistanceFromCharacter(v9.Position) < u1.Variables.MinSentrySpawnPlace then
						return true;
					end;
				end;
			else
				u1.Print(string.format("Failed to gets spawns for team '%s'", v7.Name), true);
			end;
		end;
	end;
end;
local u10 = {};
return function()
	local u11 = nil;
	local u12 = Instance.new("BindableEvent");
	u11 = {
		InUse = true, 
		Completed = u12.Event, 
		Cancel = function()
			for v10, v11 in pairs(u10) do
				if v11.kill ~= nil then
					v11:kill();
				end;
				table.remove(u10, v10);
			end;
			return true;
		end
	};
	local v12 = (function()
		local v13 = u1.Player.Get("Humanoid");
		if not l__LocalPlayer__2:FindFirstChild("__SPAWNED") then
			return;
		end;
		if not u1.Player.Get("Character") then
			u1.Print("Unable to start placing, no character found.");
			return;
		end;
		if v13 and v13.Health <= 0 then
			u1.Print("Unable to start placing, player is dead.");
			return;
		end;
		if u4() >= 10 then
			u1.Signal.Fire("New Item", "Error", string.format("Maximum of %s sentries", tostring(10)));
			return;
		end;
		local v14 = l__Assets__5:WaitForChild("Sentry"):Clone();
		v14.Parent = game.Workspace.__DEBRIS;
		local v15 = v14:GetModelSize();
		if not u1.Shared.isFFA() then
			if l__LocalPlayer__2.Team == game.Teams.Blue then
				v14:WaitForChild("Turret Bottom").TextureID = "http://www.roblox.com/asset/?id=3817447461";
			elseif l__LocalPlayer__2.Team == game.Teams.Red then
				v14:WaitForChild("Turret Bottom").TextureID = "http://www.roblox.com/asset/?id=3817447153";
			else
				u1.Print("No team found when placing sentry", true);
				v14:WaitForChild("Turret Bottom").TextureID = "http://www.roblox.com/asset/?id=3745127041";
			end;
		else
			v14:WaitForChild("Turret Bottom").TextureID = "http://www.roblox.com/asset/?id=3817447153";
		end;
		for v16, v17 in pairs(v14:GetDescendants()) do
			if v16:IsA("MeshPart") then
				v16.BrickColor = BrickColor.new("Bright green");
				v16.Material = Enum.Material.SmoothPlastic;
				v16.Transparency = 0.5;
				v16.TextureID = "";
			end;
			if v16.Name == "SENTRY_LIGHT" then
				v16:Destroy();
			end;		
		end;
		local u13 = {};
		local u14 = 0;
		local u15 = nil;
		local function u16(p1)
			for v21, v22 in pairs(u13) do
				v22:Disconnect();
			end;
			v14:Destroy();
			u11.InUse = false;
			u12:Fire();
			delay(0.1, function()
				u1.Variables.HideGun = false;
			end);
			u1.RunService:UnbindFromRenderStep("Update Placing");
		end;
		u1.RunService:BindToRenderStep("Update Placing", Enum.RenderPriority.Camera.Value, function(p2)
			u14 = 0;
			local v23, v24, v25 = u6.CFrame:ToOrientation();
			local v26 = CFrame.new(u6.CFrame.p) * CFrame.Angles(0, v24, 0) * CFrame.new(0, v15.Y / 2, -3);
			local v27 = {};
			local v28 = {};
			for v29, v30 in pairs(game.Workspace:WaitForChild("__MAP"):GetChildren()) do
				if v30.Name ~= "Spawns" then
					table.insert(v28, v30);
				end;
			end;
			for v31, v32 in pairs(v14.PrimaryPart:GetChildren()) do
				if v32:IsA("Attachment") then
					local v33, v34 = u1.Functions.QuickRay(v26 * v32.CFrame, CFrame.new(3500, 0, 0), v28);
					u15 = v33;
					v27[v32.Name] = v34;
				end;
			end;
			local l__unit__35 = (v27.FrontLeft - v27.BackLeft).unit;
			local l__unit__36 = (v27.BackRight - v27.BackLeft).unit;
			local v37 = l__unit__36:Cross(l__unit__35);
			local v38 = 0.25 * (v27.FrontLeft + v27.FrontRight + v27.BackLeft + v27.BackRight);
			if v38.Y < u6.CFrame.p.Y - 6.5 or u6.CFrame.p.Y + 2 < v38.Y then
				u14 = 100;
			end;
			if u14 >= 100 then
				v14:SetPrimaryPartCFrame(v26 * CFrame.new(0, -6, 0));
			else
				v14:SetPrimaryPartCFrame(CFrame.new(0, 2, 0) * CFrame.new(v38.X, v38.Y, v38.Z, l__unit__36.X, v37.X, -l__unit__35.X, l__unit__36.Y, v37.Y, -l__unit__35.Y, l__unit__36.Z, v37.Z, -l__unit__35.Z));
			end;
			for v39, v40 in pairs((u1.Functions.GetTouchingParts(v14.Top.Hitbox))) do
				if not (not v40:IsDescendantOf(game.Workspace.__MAP)) or not (not v40:IsDescendantOf(game.Workspace.__THINGS.Sentries)) or not (not v40:IsDescendantOf(l__Mini_Sentries__7)) or v40:IsDescendantOf(l__Armored_Sentries__8) then
					u14 = u14 + 1;
				end;
			end;
			if tick() - 0 <= 0.1 then
				return;
			end;
			if u1.Shared.isIntermission() then
				u16();
				return;
			end;
			if not (u14 > 0) then
				for v41, v42 in pairs(v14:GetDescendants()) do
					if v42:IsA("MeshPart") then
						v42.BrickColor = BrickColor.new("Bright green");
						v42.Material = Enum.Material.Neon;
					end;
				end;
				return;
			end;
			for v43, v44 in pairs(v14:GetDescendants()) do
				if v44:IsA("MeshPart") then
					v44.TextureID = "";
					v44.BrickColor = BrickColor.new("Really red");
					v44.Material = Enum.Material.Neon;
				end;
			end;
		end);
		u1.Variables.HideGun = true;
		local function u17()
			if tick() - 0 <= 0.1 then
				return;
			end;
			if u14 > 0 then
				u1.Signal.Fire("New Item", "Error", "You cannot place here!");
				return;
			end;
			if u9() then
				u1.Signal.Fire("New Item", "Error", "Unable to place here, enemy spawn nearby!");
				return;
			end;
			u1.Network.Fire("Place Sentry", v14:GetPrimaryPartCFrame() * CFrame.new(0, -0.35, 0), u15);
			for v45, v46 in pairs(u10) do
				if v46.kill ~= nil then
					v46:kill(true);
				end;
				table.remove(u10, v45);
			end;
		end;
		u13.inputBegan = u1.UserInputService.InputBegan:Connect(function(p3, p4)
			if p4 then
				return;
			end;
			if p3.UserInputType == Enum.UserInputType.MouseButton1 or p3.KeyCode == Enum.KeyCode.ButtonR2 then
				u17();
			end;
		end);
		u13.mobileTap = u1.UserInputService.TouchTap:Connect(function(p5, p6)
			if p6 then
				return;
			end;
			if #p5 == 1 then
				u17();
			end;
		end);
		u13.death = u1.Player.Get("Humanoid").Died:Connect(function()
			u16();
		end);
		u13.humanoidDied = l__LocalPlayer__2.Character:WaitForChild("Humanoid").StateChanged:Connect(function(p7, p8)
			if p8 == Enum.HumanoidStateType.Dead then
				u16();
			end;
		end);
		u13.playerKilled = u1.Network.Fired("Player Killed"):Connect(function(p9)
			if p9 == l__LocalPlayer__2 then
				u16();
			end;
		end);
		return {
			kill = u16
		};
	end)();
	if v12 then
		table.insert(u10, v12);
	end;
	return nil;
end;

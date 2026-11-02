-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = Random.new();
local l__Shields__2 = game.Workspace:WaitForChild("__THINGS"):WaitForChild("Shields");
local l__LocalPlayer__3 = game.Players.LocalPlayer;
local function u4()
	local v2 = 0;
	for v3, v4 in pairs(l__Shields__2:GetChildren()) do
		if v4.Name == l__LocalPlayer__3.Name then
			v2 = v2 + 1;
		end;
	end;
	return v2;
end;
local l__Assets__5 = game.ReplicatedStorage:WaitForChild("Assets");
local u6 = u1.Player.Get("Camera");
local u7 = {};
return function()
	local u8 = nil;
	local u9 = Instance.new("BindableEvent");
	
	u8 = {
		InUse = true, -- set true if issue
		Completed = u9.Event, 
		Cancel = function()
			for v5, v6 in pairs(u7) do
				if v6.kill ~= nil then
					v6:kill();
				end;
				table.remove(u7, v5);
			end;
			return true;
		end
	};
	local v7 = (function()
		local v8 = u1.Player.Get("Humanoid");
		if not l__LocalPlayer__3:FindFirstChild("__SPAWNED") then
			return;
		end;
		if not u1.Player.Get("Character") then
			u1.Print("Unable to start placing, no character found.");
			return;
		end;
		if v8 and v8.Health <= 0 then
			u1.Print("Unable to start placing, player is dead.");
			return;
		end;
		if u4() >= 3 then
			u1.Signal.Fire("New Item", "Error", string.format("Maximum of %s Shields", tostring(3)));
			return;
		end;
		local v9 = l__Assets__5:WaitForChild("ShieldPlacement"):Clone();
		v9.Parent = game.Workspace.__DEBRIS;
		local u10 = {};
		local u11 = 0;
		local u12 = v9:GetModelSize();
		local u13 = nil;
		local function u14(p1)
			for v10, v11 in pairs(u10) do
				v11:Disconnect();
			end;
			v9:Destroy();
			u8.InUse = false;
			u9:Fire();
			
			delay(0.1, function()
				u1.Variables.HideGun = false;
			end);
			u1.RunService:UnbindFromRenderStep("Update Shield Placing");
		end;
		u1.RunService:BindToRenderStep("Update Shield Placing", Enum.RenderPriority.Camera.Value, function(p2)
			u11 = 0;
			local v12, v13, v14 = u6.CFrame:ToOrientation();
			local v15 = CFrame.new(u6.CFrame.p) * CFrame.Angles(0, v13, 0) * CFrame.new(0, u12.Y / 2, -5);
			local v16 = {};
			local v17 = {};
			for v18, v19 in pairs(game.Workspace:WaitForChild("__MAP"):GetChildren()) do
				if v19.Name ~= "Spawns" then
					table.insert(v17, v19);
				end;
			end;
			for v20, v21 in pairs(v9.PrimaryPart:GetChildren()) do
				if v21:IsA("Attachment") then
					local v22, v23 = u1.Functions.QuickRay(v15 * v21.CFrame, CFrame.new(3500, 0, 0), v17);
					u13 = v22;
					v16[v21.Name] = v23;
				end;
			end;
			local l__unit__24 = (v16.FrontLeft - v16.BackLeft).unit;
			local l__unit__25 = (v16.BackRight - v16.BackLeft).unit;
			local v26 = l__unit__25:Cross(l__unit__24);
			local v27 = 0.25 * (v16.FrontLeft + v16.FrontRight + v16.BackLeft + v16.BackRight);
			if v27.Y < u6.CFrame.p.Y - 6 or u6.CFrame.p.Y + 2 < v27.Y then
				u11 = 100;
			end;
			if u11 >= 100 then
				v9:SetPrimaryPartCFrame(v15 * CFrame.new(0, -6, 0));
			else
				v9:SetPrimaryPartCFrame(CFrame.new(v27.X, v27.Y, v27.Z, l__unit__25.X, v26.X, -l__unit__24.X, l__unit__25.Y, v26.Y, -l__unit__24.Y, l__unit__25.Z, v26.Z, -l__unit__24.Z) * CFrame.new(0, 3.25, 0));
			end;
			for v28, v29 in pairs((u1.Functions.GetTouchingParts(v9.PrimaryPart))) do
				if v29:IsDescendantOf(l__Shields__2) then
					u11 = u11 + 1;
				end;
			end;
			if tick() - 0 <= 0.1 then
				return;
			end;
			if u1.Shared.isIntermission() then
				u14();
				return;
			end;
			if u11 > 0 then
				for v30, v31 in pairs(v9:GetDescendants()) do
					if v31:IsA("BasePart") then
						v31.BrickColor = BrickColor.new("Really red");
						v31.Material = Enum.Material.Neon;
					end;
				end;
				return;
			end;
			for v32, v33 in pairs(v9:GetDescendants()) do
				if v33:IsA("BasePart") then
					v33.BrickColor = BrickColor.new("Bright green");
					v33.Material = Enum.Material.Neon;
				end;
			end;
		end);
		u1.Variables.HideGun = true;
		local function u15()
			if tick() - 0 <= 0.1 then
				return;
			end;
			if u11 > 0 then
				u1.Signal.Fire("New Item", "Error", "You cannot place here!");
				return;
			end;
			u1.Network.Fire("Place Shield", v9:GetPrimaryPartCFrame() * CFrame.new(0, -0.35, 0), u13);
			for v34, v35 in pairs(u7) do
				if v35.kill ~= nil then
					v35:kill(true);
				end;
				table.remove(u7, v34);
			end;
		end;
		u10.inputBegan = u1.UserInputService.InputBegan:Connect(function(p3, p4)
			if p4 then
				return;
			end;
			if p3.UserInputType == Enum.UserInputType.MouseButton1 or p3.KeyCode == Enum.KeyCode.ButtonR2 then
				u15();
			end;
		end);
		u10.mobileTap = u1.UserInputService.TouchTap:Connect(function(p5, p6)
			if p6 then
				return;
			end;
			if #p5 == 1 then
				u15();
			end;
		end);
		u10.death = u1.Player.Get("Humanoid").Died:Connect(function()
			u14();
		end);
		u10.humanoidDied = l__LocalPlayer__3.Character:WaitForChild("Humanoid").StateChanged:Connect(function(p7, p8)
			if p8 == Enum.HumanoidStateType.Dead then
				u14();
			end;
		end);
		u10.playerKilled = u1.Network.Fired("Player Killed"):Connect(function(p9)
			if p9 == l__LocalPlayer__3 then
				u14();
			end;
		end);
		return {
			kill = u14
		};
	end)();
	if v7 then
		table.insert(u7, v7);
	end;
	return nil;
end;

-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local v3 = v1.Player.Get();
local v4 = v1.Player.Get("Camera");
local l__controls__5 = require(v3:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")).controls;
local v6 = v1.Entity.Get(v3);
local l__Drones__1 = game.Workspace:WaitForChild("__THINGS"):WaitForChild("Drones");
local u2 = require(v1.Player.Get("Player"):WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local u3 = Random.new();
v1.Network.Fired(".9"):Connect(function(p1, p2, p3, p4, p5)
	if not p4 or not p4.Parent or not p4.PrimaryPart then
		return;
	end;
	v1.Projectiles.Fire(p1, CFrame.new(p2, p3), p5, tick(), false, "Drone", p4);
	v1.Audio.Play(4145946468, p4.PrimaryPart, u3:NextNumber(0.95, 1.05), 0.65, 250);
end);
local u4 = {};
local u5 = {};
v1.Network.Fired("i"):Connect(function(p6, p7)
	if not p6 and not p6.PrimaryPart then
		return;
	end;
	v1.Audio.Play(4145945166, p6.PrimaryPart, 1, 0.5, 150);
	if p7 == v3 then
		if p6:FindFirstChild("Health") and p6.Health.Value <= 0 then
			return;
		end;
		v1.Signal.Fire("Do Hitmarker", true);
	end;
	if u4[p6] then
		return;
	end;
	coroutine.wrap(function()
		u4[p6] = true;
		for v7, v8 in pairs(p6:GetDescendants()) do
			if v8:IsA("MeshPart") then
				if not u5[v8] then
					u5[v8] = v8.TextureID;
				end;
				v8.TextureID = "";
				v8.Material = Enum.Material.SmoothPlastic;
				v8.BrickColor = BrickColor.Red();
			end;
		end;
		wait(0.1);
		for v9, v10 in pairs(p6:GetDescendants()) do
			if v10:IsA("MeshPart") then
				if u5[v10] then
					v10.TextureID = u5[v10];
				end;
				v10.Material = Enum.Material.SmoothPlastic;
				v10.Color = Color3.new(1, 1, 1);
			end;
		end;
		u4[p6] = nil;
	end)();
end);
v1.Network.Fired("h"):Connect(function(p8, p9)
	if not p8 or not p9 then
		return;
	end;
	v1.Audio.Play(4145945485, p8:GetPrimaryPartCFrame().p, 1, 0.8, 300);
	if p8.Name == v3.Name and p9 and p9.Name then
		v1.Signal.Fire("New Item", "Error", string.format("%s took down your Drone!", p9.DisplayName));
		v1.Audio.Play(3941857043, script);
	end;
	v1.Audio.Play(4145945166, p8.PrimaryPart, 1, 0.5, 150);
	if p9 == v3 and p8:FindFirstChild("Health") and p8.Health.Value > 0 then
		v1.Signal.Fire("Do Hitmarker", true);
	end;
	local v11, v12 = v1.Functions.CreateParticleHost(p8:GetPrimaryPartCFrame());
	for v13, v14 in ipairs(l__Assets__2.Particles.Explosion:GetChildren()) do
		local v16 = v14:Clone();
		v16.Parent = v12;
		v16:Emit(v16.Rate);	
	end;
	v11.Parent = game.Workspace.__DEBRIS;
	local v17 = Instance.new("PointLight");
	v17.Brightness = 5;
	v17.Color = Color3.fromRGB(255, 188, 52);
	v17.Range = 30;
	v17.Parent = v12;
	coroutine.wrap(function()
		local v18 = tick();
		while v17 and v17.Parent and tick() - v18 < 1.35 do
			local v19 = (tick() - v18) / 1.35;
			v17.Range = 30 - 30 * v1.Functions.Easing(v19, "Quart", "Out");
			v17.Brightness = 5 - 5 * v1.Functions.Easing(v19, "Sine", "Out");
			v1.Heartbeat();		
		end;
	end)();
	local l__Magnitude__20 = (v1.Player.Get("Camera").CFrame.p - p8:GetPrimaryPartCFrame().p).Magnitude;
	if l__Magnitude__20 <= 50 then
		v1.Shake.Create(1, (1 - l__Magnitude__20 / 50) / 2, 0.05);
	end;
	p8:Destroy();
end);
wait(1);
local function u6(p10, p11)
	local v21 = {};
	local v22 = CFrame.new(0, 8.5, 0);
	local v23 = p10.Character.HumanoidRootPart.CFrame * v22;
	local v24 = CFrame.new(0, 0, 0);
	local v25 = CFrame.new(0, 0, 0);
	local v26 = CFrame.new(0, 0, 0);
	local v27 = CFrame.new(0, 0, 0);
	local v28 = v1.Functions.GenerateUID();
	local v29
	if p10 then
		local v29 = p10.Team and p10.Team.TeamColor or BrickColor.new("Institutional white");
	else
		v29 = BrickColor.new("Institutional white");
	end;
	local l__Magnitude__30 = p11:GetModelSize().Magnitude;
	v1.Audio.Play(4145944575, p11.PrimaryPart, 1, 0.5, 250);
	local v31 = Instance.new("Part");
	v31.Shape = Enum.PartType.Ball;
	v31.TopSurface = Enum.SurfaceType.Smooth;
	v31.BottomSurface = Enum.SurfaceType.Smooth;
	v31.Anchored = true;
	v31.CanCollide = false;
	v31.BrickColor = v29;
	v31.Size = Vector3.new(1, 1, 1);
	v31.BrickColor = v29;
	v31.Transparency = 0.5;
	v31.Material = Enum.Material.Neon;
	v31.CFrame = v23;
	v31.Parent = game.Workspace.__DEBRIS;
	coroutine.wrap(function()
		v1.Functions.FastTween(v31, {
			Transparency = 1
		}, { 0.2, "Quad", "Out" });
		v1.Functions.FastTween(v31, {
			Size = Vector3.new(l__Magnitude__30 * 2, l__Magnitude__30 * 2, l__Magnitude__30 * 2)
		}, { 0.5, "Quad", "Out" });
		wait(1);
		v31:Destroy();
	end)();
	local v32 = v1.Audio.Play(9165092165, p11.PrimaryPart, 1, 0.15, 180, nil, true);
	local u7 = v23;
	if not p11 or not p11.Parent or not p11.PrimaryPart then
		return;
	end;
	p11:SetPrimaryPartCFrame(v24);
	p11:WaitForChild("Gun");
	for v33, v34 in pairs(p11:GetChildren()) do
		if v34.Name == "Propeller" and not v21[v34] then
			v21[v34] = p11.PrimaryPart.CFrame:ToObjectSpace(v34.CFrame);
		end;
	end;
	local u8 = Vector3.new(0, 0, 0);
	local u9 = 0;
	local function u10(p12)
		if not game.Workspace:FindFirstChild("__MAP") then
			return false;
		end;
		if v1.Functions.NewQuickRay(p10.Character.HumanoidRootPart:GetRenderCFrame() * v22, CFrame.new(p12), 5, { game.Workspace:WaitForChild("__MAP") }) then
			return true;
		end;
		return false;
	end;
	local u11 = 0;
	local u12 = v26;
	local u13 = v27;
	local u14 = v25;
	local u15 = nil;
	local u16 = CFrame.new(0, 0, 0);
	local u17 = 0;
	local u18 = p11.PrimaryPart.CFrame:ToObjectSpace(p11.Gun.CFrame);
	local u19 = 0;
	local u20 = 0;
	local function u21()
		for v35, v36 in ipairs(game.Players:GetPlayers()) do
			if v36 and v36.Character and v36.Character:FindFirstChild("HumanoidRootPart") and (v36.Character:FindFirstChild("Humanoid") and v36.Character.Humanoid.Health > 0 and v36 ~= p10) then
				local u22 = nil;
				local u23 = nil;
				local u24 = nil;
				if v1.Shared.isFFA() or v36.Team ~= p10.Team then
					(function()
						local l__p__38 = v36.Character.HumanoidRootPart.CFrame.p;
						local v39, v40 = game.Workspace:FindPartOnRayWithIgnoreList(Ray.new(u7.p, (l__p__38 - u7.p).unit * 85), { p11, p10.Character });
						if v39 and v39:IsDescendantOf(v36.Character) then
							local l__magnitude__41 = (l__p__38 - u7.p).magnitude;
							if not u22 or u23 < l__magnitude__41 then
								u22 = v36;
								u23 = l__magnitude__41;
								u24 = l__p__38;
							end;
						end;
					end)();
				end;
			end;		
		end;
		for v42, v43 in pairs(game.Workspace.__THINGS.Sentries:GetChildren()) do
			local v44 = game.Players:FindFirstChild(v43.Name);
			if v44 and v44.Character and v44.Character:FindFirstChild("HumanoidRootPart") and (v44.Character:FindFirstChild("Humanoid") and v44.Character.Humanoid.Health > 0 and v44 ~= p10) then
				local u25 = nil;
				local u26 = nil;
				local u27 = nil;
				if v44.Team ~= p10.Team then
					(function()
						local l__p__45 = v43.PrimaryPart.CFrame.p;
						local v46, v47 = game.Workspace:FindPartOnRayWithIgnoreList(Ray.new(u7.p, (l__p__45 - u7.p).unit * 85), { p11, p10.Character });
						if v46 and v46:IsDescendantOf(v43) then
							local l__magnitude__48 = (l__p__45 - u7.p).magnitude;
							if not u25 or u26 < l__magnitude__48 then
								u25 = v44;
								u26 = l__magnitude__48;
								u27 = l__p__45;
							end;
						end;
					end)();
				end;
			end;
		end;
		return nil, nil;
	end;
	local u28 = 1;
	v1.RunService:BindToRenderStep("UpdateDrone_" .. v28, Enum.RenderPriority.Camera.Value - 1, function(p13)
		if p11.Parent ~= l__Drones__1 or p10.Parent ~= game.Players then
			v1.RunService:UnbindFromRenderStep("UpdateDrone_" .. v28);
			return;
		end;
		if p10.Parent == game.Players and p10.Character and p10.Character:FindFirstChild("HumanoidRootPart") and p10.Character:FindFirstChild("Humanoid") then
			if p10.Character and p10.Character.Humanoid.Health > 0 and p10:FindFirstChild("__SPAWNED") then
				if p10 ~= v3 then
					local v49 = v1.Entity.Get(p10);
					if v49.MoveVectorX and v49.MoveVectorZ then
						u8 = Vector3.new(v49.MoveVectorX, 0, v49.MoveVectorZ);
					end;
				elseif tick() - u9 >= 0.2 then
					local v50 = not v1.Variables.Console and u2:GetMoveVector() or v1.Variables.ControllerMoveVector;
					local v51 = math.clamp(v50.X, -1, 1);
					local v52 = math.clamp(v50.Z, -1, 1);
					if u10(Vector3.new(v51, 0, 0)) then
						v51 = 0;
					end;
					if u10(Vector3.new(0, 0, v52)) then
						v52 = 0;
					end;
					u8 = Vector3.new(v51, 0, v52);
					v1.Network.Fire(".8", u8);
					u9 = tick();
				end;
			end;
			if tick() - u11 > 0.1 then
				u11 = tick();
				if u10(Vector3.new(0, 0, -1)) then
					u12 = CFrame.new(0, 0, 0);
				else
					u12 = CFrame.new(0, 0, -2.75);
				end;
			end;
			u13 = u13:Lerp(CFrame.Angles(u8.Z / 3, 0, -u8.X / 3), p13 * 5);
			u14 = u14:Lerp(CFrame.new(u8.X * 10, 0, u8.Z * 10), p13 * 2);
			if p10.Character and p10.Character.Humanoid.Health > 0 and p10:FindFirstChild("__SPAWNED") then
				u7 = u7:Lerp(p10.Character.HumanoidRootPart:GetRenderCFrame() * v22 * CFrame.new(0, math.cos(game.Workspace.DistributedGameTime), 0) * u14 * v24 * u12 * u13, p13 * 2);
			end;
			if u15 and u15.Parent == game.Players and u15.Character and u15.Character:FindFirstChild("HumanoidRootPart") then
				u16 = u16:Lerp(CFrame.new(Vector3.new(0, 0, 0), p11.PrimaryPart.CFrame:ToObjectSpace(u15.Character:FindFirstChild("HumanoidRootPart").CFrame).p), p13 * 3);
			else
				u16 = u16:Lerp(CFrame.Angles(0, math.rad(u17), 0), p13 * 3);
			end;
			p11.PrimaryPart.CFrame = u7;
			p11.Gun.CFrame = u7 * u16 * u18;
			u19 = u19 + p13 * 12500;
			u17 = u17 + p13 * 25;
			for v53, v54 in pairs(p11:GetChildren()) do
				if v54.Name == "Propeller" and v21[v54] then
					v54.CFrame = p11.PrimaryPart.CFrame * v21[v54] * CFrame.Angles(0, math.rad(u19), 0);
				end;
			end;
			if p10 ~= v3 then
				return;
			else
				if tick() - u20 >= 0.15 and p11:WaitForChild("Health").Value > 0 then
					u20 = tick();
					local v55, v56 = u21();
					if v55 and v56 then
						if not u15 or u15 ~= v55 then
							v1.Audio.Play(4145946095, p11.PrimaryPart, 1, 0.2, 200);
						end;
						u15 = v55;
						v1.Audio.Play(4145946468, p11.PrimaryPart, u3:NextNumber(0.95, 1.05), 0.65, 250);
						v1.Network.Fire(".9", p11.Gun:WaitForChild(tostring(u28)).WorldPosition, v56 + Vector3.new(u3:NextNumber(-2, 2), u3:NextNumber(-2, 2) + 1, u3:NextNumber(-2, 2)), p11);
						local v57
						if u28 == 1 then
							local v57 = 2;
						else
							v57 = 1;
						end;
						u28 = v57;
					end;
				end;
				return;
			end;
		end;
	end);
end;
v1.Network.Fired(".b"):Connect(function(p14, p15)
	u6(p14, p15);
end);
for v58, v59 in pairs(l__Drones__1:GetChildren()) do
	for v60, v61 in pairs(game.Players:GetPlayers()) do
		if v61.Name == v59.Name then
			u6(v61, v59);
		end;
	end;
end;

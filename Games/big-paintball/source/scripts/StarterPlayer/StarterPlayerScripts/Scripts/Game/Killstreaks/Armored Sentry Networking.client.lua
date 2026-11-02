-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l__Armored_Sentries__3 = game.Workspace:WaitForChild("__THINGS"):WaitForChild("Armored Sentries");
local v4 = Random.new();
local v5 = v1.Player.Get();
local v6 = v1.Player.Get("Camera");
local v7 = v1.Entity.Get(v5);
v1.Network.Fired(".d"):Connect(function(p1, p2, p3, p4)
	v1.Projectiles.Fire(p2, p3, p4, math.floor(game.Workspace.DistributedGameTime), false, "Armored Sentry", p1);
end);
local u1 = {};
local u2 = {};
v1.Network.Fired("a"):Connect(function(p5, p6)
	if p5 == nil or not p5:FindFirstChild("Top") then
		return;
	end;
	if p6 == v5 then
		if p5:FindFirstChild("Health") and p5.Health.Value <= 0 then
			return;
		end;
		v1.Signal.Fire("Do Hitmarker", true);
		v1.Audio.Play(3976628692, p5:GetPrimaryPartCFrame().p, 0.8, 0.75, 250);
	end;
	if u1[p5] then
		return;
	end;
	coroutine.wrap(function()
		u1[p5] = true;
		for v8, v9 in pairs(p5:GetDescendants()) do
			if v9:IsA("MeshPart") then
				if not u2[v9] then
					u2[v9] = {
						TextureID = v9.TextureID, 
						Material = v9.Material, 
						Color = v9.Color
					};
				end;
				v9.TextureID = "";
				v9.Material = Enum.Material.SmoothPlastic;
				v9.Color = Color3.fromRGB(255, 0, 0);
			end;
		end;
		wait(0.1);
		for v10, v11 in pairs(p5:GetDescendants()) do
			if v11:IsA("MeshPart") and u2[v11] then
				for v12, v13 in pairs(u2[v11]) do
					v11[v12] = v13;
				end;
			end;
		end;
		u1[p5] = nil;
	end)();
end);
v1.Network.Fired("9"):Connect(function(p7, p8)
	if u1[p7] then
		while u1[p7] and tick() - tick() <= 0.35 do
			v1.Heartbeat();		
		end;
	end;
	v1.Audio.Play("rbxassetid://6819741672", p7:GetPrimaryPartCFrame().p, 1, 1, 400);
	local v14 = p7:Clone();
	v14.Name = "Destroyed Sentry";
	if p8 == v5 and p7:FindFirstChild("Health") and p7.Health.Value > 0 then
		v1.Signal.Fire("Do Hitmarker", true);
		v1.Audio.Play(3976628692, p7:GetPrimaryPartCFrame().p, 0.8, 0.75, 250);
	end;
	if not p7 then
		return;
	end;
	p7:Destroy();
	if p7.Name == v5.Name and p8 and p8.Name then
		v1.Signal.Fire("New Item", "Error", string.format("%s took out your Armored Sentry!", p8.DisplayName));
		v1.Audio.Play(3941857043, script);
	end;
	for v15, v16 in ipairs(v14:GetDescendants()) do
		if v16.Name == "Turret Top" or v16.Name == "Turret Bottom" then
			v16.Anchored = false;
			v16.CanCollide = true;
			v16.Parent = v14;
		elseif v16.ClassName ~= "Model" and v16.Name ~= "Center" then
			v16:Destroy();
		end;	
	end;
	v14.PrimaryPart = v14:FindFirstChild("Turret Bottom");
	v14.Parent = game.Workspace.__DEBRIS;
	local v18, v19 = v1.Functions.CreateParticleHost(v14:GetPrimaryPartCFrame());
	for v20, v21 in ipairs(l__Assets__2.Particles.Explosion:GetChildren()) do
		local v23 = v21:Clone();
		v23.Parent = v19;
		v23:Emit(v23.Rate);	
	end;
	v18.Parent = v14;
	local v24 = Instance.new("PointLight");
	v24.Brightness = 5;
	v24.Color = Color3.fromRGB(255, 188, 52);
	v24.Range = 30;
	v24.Parent = v19;
	coroutine.wrap(function()
		local v25 = tick();
		while v24 and v24.Parent and tick() - v25 < 1.35 do
			local v26 = (tick() - v25) / 1.35;
			v24.Range = 30 - 30 * v1.Functions.Easing(v26, "Quart", "Out");
			v24.Brightness = 5 - 5 * v1.Functions.Easing(v26, "Sine", "Out");
			v1.Heartbeat();		
		end;
	end)();
	local l__Magnitude__27 = (v1.Player.Get("Camera").CFrame.p - v14:GetPrimaryPartCFrame().p).Magnitude;
	if l__Magnitude__27 <= 50 then
		v1.Shake.Create(1, (1 - l__Magnitude__27 / 50) / 2, 0.05);
	end;
	v14:FindFirstChild("Turret Top").Velocity = Vector3.new(v4:NextNumber(-20, 20), v4:NextNumber(50, 80), v4:NextNumber(-20, 20));
	v14:FindFirstChild("Turret Top").RotVelocity = Vector3.new(v4:NextNumber(-35, 35), v4:NextNumber(-35, 35), v4:NextNumber(-35, 35));
	for v28, v29 in ipairs((l__Assets__2.Particles:FindFirstChild("Fire"):GetChildren())) do
		if v29.ClassName == "ParticleEmitter" then
			v29:Clone().Parent = v14:FindFirstChild("Turret Top").Center;
		end;	
	end;
	for v31, v32 in ipairs(v14:GetDescendants()) do
		if v32:IsA("BasePart") then
			coroutine.wrap(function()
				wait(1.6666666666666667);
				local v34 = tick();
				while v32 and v32.Parent and tick() - v34 < 1.6666666666666667 do
					v32.Transparency = v1.Functions.Easing((tick() - v34) / 1.6666666666666667, "Sine", "Out");
					v1.Heartbeat();				
				end;
			end)();
		elseif v32.ClassName == "ParticleEmitter" then
			coroutine.wrap(function()
				v1.Functions.Wait(0.8333333333333334);
				if v32 then
					v32.Enabled = false;
				end;
			end)();
		end;	
	end;
	v1.Functions.Wait(2.5);
	v14:Destroy();
end);
local u3 = {};
v1.Network.Fired(".c"):Connect(function(p9, p10)
	local v35 = p10:GetPrimaryPartCFrame();
	Instance.new("NumberValue").Value = 1.5;
	if not u3[p10] then
		u3[p10] = Instance.new("CFrameValue");
		u3[p10].Value = p10.Top:GetPrimaryPartCFrame();
		u3[p10].Changed:Connect(function()
			if p10 and p10:FindFirstChild("Top") then
				p10.Top:SetPrimaryPartCFrame(u3[p10].Value);
			end;
		end);
	end;
	v1.Audio.Play("rbxassetid://6819732143", p10:GetPrimaryPartCFrame().p, 1, 1, 375);
end);

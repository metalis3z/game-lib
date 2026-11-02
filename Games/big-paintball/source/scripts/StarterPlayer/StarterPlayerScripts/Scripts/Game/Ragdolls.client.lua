-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l____VARIABLES__3 = game.Workspace:WaitForChild("__VARIABLES");
local v4 = v1.Player.Get();
local v5 = v1.Player.Get("Camera");
local v23
local v22
local u1 = {
	Blue = Color3.fromRGB(20, 232, 255), 
	Red = Color3.fromRGB(255, 0, 0)
};
local u2 = {
	LeftAnkle = {
		Properties = {
			LimitsEnabled = true, 
			UpperAngle = 15, 
			LowerAngle = -45
		},
		"Hinge"
	}, 
	RightAnkle = {
		Properties = {
			LimitsEnabled = true, 
			UpperAngle = 15, 
			LowerAngle = -45
		},
		"Hinge"
	}, 
	LeftKnee = {
		Properties = {
			LimitsEnabled = true, 
			UpperAngle = 0, 
			LowerAngle = -75
		},
		"Hinge"
	}, 
	RightKnee = {
		Properties = {
			LimitsEnabled = true, 
			UpperAngle = 0, 
			LowerAngle = -75
		},
		"Hinge"
	}, 
	LeftHip = { "BallSocket" }, 
	RightHip = { "BallSocket" }, 
	Waist = { "BallSocket" }, 
	LeftShoulder = { "BallSocket" }, 
	RightShoulder = { "BallSocket" }, 
	LeftElbow = { "BallSocket" }, 
	RightElbow = { "BallSocket" }, 
	LeftWrist = {
		Properties = {
			LimitsEnabled = true, 
			UpperAngle = 0, 
			LowerAngle = 0
		},
		"Hinge"
	}, 
	RightWrist = {
		Properties = {
			LimitsEnabled = true, 
			UpperAngle = 0, 
			LowerAngle = 0
		},
		"Hinge"
	}, 
	Neck = { "BallSocket" }
};
v1.Network.Fired("Player Killed"):Connect(function(p1, p2, p3, p4)
	if not p2 or not p1 then
		v1.Print("Invalid parameters");
		return;
	end;
	if p2 and p2.Parent == game.Players and p2.Character and p2.Character:FindFirstChild("HumanoidRootPart") then
		local v6, v7 = v1.GunCmds.GetEquipped(p2);
		if v6 and v7 then
			local v8 = v1.Functions.SafeClone(p1.Character);
			p1.Character.Parent = game.ReplicatedStorage.CharacterGraveyard;
			v8.Parent = game.Workspace.__THINGS.Ragdolls;
			coroutine.wrap(function()
				local v9 = nil;
				if p2 and p2.Team and u1[p2.Team.Name] then
					v9 = u1[p2.Team.Name];
				end;
				v1.Signal.Fire("Do Impact FX", v8.UpperTorso.Position, v9);
			end)();
			coroutine.wrap(function()
				wait(4);
				v8:Destroy();
			end)();
			for v10, v11 in pairs(v8:GetDescendants()) do
				if v11:IsA("BasePart") then
					v1.PhysicsService:SetPartCollisionGroup(v11, "Ragdolls");
				end;
			end;
			if not (not v7) and not v7.disableRagdoll or p3 then
				v8.HumanoidRootPart.Anchored = true;
				v8.HumanoidRootPart.CanCollide = false;
				v8.HumanoidRootPart:BreakJoints();
				for v12, v13 in pairs(v8:GetDescendants()) do
					if v13:IsA("Motor6D") and u2[v13.Name] then
						local v17 = Instance.new(u2[v13.Name][1] .. "Constraint");
						local v18 = v13.Parent:FindFirstChild(v13.Name .. "Attachment") or v13.Parent:FindFirstChild(v13.Name .. "RigAttachment");
						local v19 = v13.Part0:FindFirstChild(v13.Name .. "Attachment") or v13.Part0:FindFirstChild(v13.Name .. "RigAttachment");
						if u2[v13.Name].Properties then
							for v20, v21 in pairs(u2[v13.Name].Properties) do
								v17[v20] = v21;
							end;
						end;
						if v18 and v19 then
							v17.Attachment0 = v18;
							v17.Attachment1 = v19;
							v17.Parent = v13.Parent;
							v13:Destroy();
						end;
					elseif v13:IsA("Attachment") then
						v13.Axis = Vector3.new(0, 1, 0);
						v13.SecondaryAxis = Vector3.new(0, 0, 1);
						v13.Rotation = Vector3.new(0, 0, 0);
					elseif v13:IsA("BasePart") then
						v1.PhysicsService:SetPartCollisionGroup(v13, "Ragdolls");
					end;				
				end;
				if p3 and p3.PrimaryPart then
					v22 = (v8:FindFirstChild("HumanoidRootPart").CFrame.p - p3.PrimaryPart.CFrame.p).Unit;
				else
					v22 = (v8:FindFirstChild("HumanoidRootPart").CFrame.p - p2.Character:FindFirstChild("HumanoidRootPart").CFrame.p).Unit;
				end;
				if p3 then
					v23 = 175;
				else
					v23 = v7.velocity;
				end;
				v8.UpperTorso.Velocity = v22 * v23 * 1.25;
			end;
			if v7 and v7.killEffect and not p3 then
				v7.killEffect(v8);
			end;
			local v24 = v1.Directory.Guns["30"];
			if v24 and p3 and p4 and p4 == "Dark Matter Sentry" then
				v24.killEffect(v8);
			end;
			if v8:FindFirstChild("Head") and v8.Head:FindFirstChild("RadarPing") then
				v8.Head:FindFirstChild("RadarPing"):Destroy();
			end;
			if v8:FindFirstChild("Head") and v8.Head:FindFirstChild("TeamIndicator") then
				v8.Head:FindFirstChild("TeamIndicator"):Destroy();
				local v25 = Instance.new("Part");
				v25.CFrame = v8.HumanoidRootPart.CFrame;
				v25.Transparency = 1;
				v25.Size = Vector3.new(0.1, 0.1, 0.1);
				v25.Anchored = true;
				v25.CanCollide = false;
				v25.Parent = game.Workspace.__DEBRIS;
				local v26 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("DeadTeamIndicator"):Clone();
				v26.Parent = v25;
				coroutine.wrap(function()
					wait(1);
					v1.Functions.FastTween(v26.Face, {
						ImageTransparency = 1
					}, { 4, "Quad", "Out" });
					wait(4);
					v25:Destroy();
				end)();
			end;
		end;
	end;
end);

-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local v2 = v1.Player.Get("Camera");
function Lerp(p1, p2, p3)
	return p1 + (p2 - p1) * p3;
end;
local l__Guns__1 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Guns");
local u2 = nil;
local l__UserGameSettings__3 = UserSettings():GetService("UserGameSettings");
local u4 = nil;
local u5 = nil;
local function u6(p4, p5, p6)
	if not p4 then
		return;
	end;
	local v3 = game.Players:GetPlayerFromCharacter(p4);
	if not p6 then
		p6 = 0;
	end;
	local v4, v5 = v1.GunCmds.GetEquipped(v3);
	if not v4 or not v5 and not p5 then
		v1.Print("Failed to get equipped gun for " .. p4.Name, true);
		v4 = "1";
		v5 = v1.Directory.Guns[v4];
	end;
	if p5 then
		v4 = p5;
		v5 = v1.Directory.Guns[v4];
	end;
	v1.Player.Get("Humanoid", v3):LoadAnimation(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("DisableUpperBody")):Play();
	local l__idle__6 = v5.offsets.thirdPerson.idle;
	local v7 = CFrame.new(0, 0, 0);
	local v8 = CFrame.new(0, 0, 0);
	local v9 = Instance.new("CFrameValue");
	local v10 = l__Guns__1:FindFirstChild(v4):Clone();
	v10:SetPrimaryPartCFrame(p4:WaitForChild("HumanoidRootPart").CFrame * l__idle__6);
	v10.Name = v3.Name;
	v10.Parent = game.Workspace.__DEBRIS.Guns;
	local v11 = nil;
	for v12, v13 in pairs(v10:GetDescendants()) do
		if v13.Name == "highlights" then
			v11 = v1.GUIFX.Rainbow(v13, "Color", 0.1);
		end;
	end;
	local l__Right__14 = v10.PrimaryPart:WaitForChild("Right");
	local l__Left__15 = v10.PrimaryPart:WaitForChild("Left");
	local l__Barrel__16 = v10.PrimaryPart:WaitForChild("Barrel");
	local v17 = v1.Functions.GenerateUID();
	local v18 = v1.Player.Get("UpperTorso", v3);
	local v19 = v1.Player.Get("RightShoulder", v3);
	local v20 = v1.Player.Get("RightElbow", v3);
	local v21 = v1.Player.Get("RightWrist", v3);
	local v22 = v1.Player.Get("LeftShoulder", v3);
	local v23 = v1.Player.Get("LeftElbow", v3);
	local v24 = v1.Player.Get("LeftWrist", v3);
	local v25 = math.abs(v19.C1.Y) + math.abs(v20.C0.Y);
	local v26 = math.abs(v20.C1.Y) + math.abs(v21.C0.Y) + math.abs(v21.C1.Y);
	local v27 = math.abs(v22.C1.Y) + math.abs(v23.C0.Y);
	local v28 = math.abs(v23.C1.Y) + math.abs(v24.C0.Y) + math.abs(v24.C1.Y);
	if (not v18 or not v19 or not v20 or not v21) and v10 then
		v10:Destroy();
		if p6 < 10 then
			p6 = p6 + 1;
			wait(0.1);
			u6(p4, p5, p6);
		else
			v1.Print(string.format("Failed to equip third person gun for '%s', too many attempts - timeout.", true));
		end;
		return;
	end;
	v18:WaitForChild("Waist");
	local u7 = {};
	local u8 = l__idle__6;
	local u9 = v5.offsets.thirdPerson.left;
	local u10 = v5.offsets.thirdPerson.right;
	local u11 = v5.offsets.thirdPerson.fire;
	local u12 = v5.offsets.thirdPerson.sprint;
	local u13 = v10;
	local function u14()
		v1.Services.RunService:UnbindFromRenderStep("UpdateGun" .. v17);
		v1.Services.RunService:UnbindFromRenderStep("UpdateGunIK" .. v17);
		for v29, v30 in pairs(game.Workspace:WaitForChild("__DEBRIS"):WaitForChild("Guns"):GetChildren()) do
			if v30.Name == v3.Name then
				v30:Destroy();
			end;
		end;
		for v31, v32 in pairs(u7) do
			if v32.Disconnect then
				v32:Disconnect();
			end;
		end;
		u8 = nil;
		u9 = nil;
		u10 = nil;
		u11 = nil;
		u12 = nil;
		if u13 then
			u13 = nil;
		end;
		if v11 then
			v11();
		end;
	end;
	local u15 = 0;
	local u16 = l__idle__6;
	local u17 = 0;
	local u18 = 0;
	local u19 = 0;
	local u20 = 0;
	local u21 = 0;
	local u22 = false;
	local u23 = 0;
	local u24 = v1.Entity.Get(v3);
	local u25 = tick();
	v1.Services.RunService:BindToRenderStep("UpdateGun" .. v17, Enum.RenderPriority.Camera.Value, function(p7)
		if not p4 or not p4:FindFirstChild("HumanoidRootPart") then
			return;
		end;
		if not v18:FindFirstChild("Waist") then
			u14();
			return;
		end;
		u13:SetPrimaryPartCFrame(p4.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(u15), 0, 0) * u16 * v9.Value * CFrame.new(0, -math.cos(u17 * math.max(p4.HumanoidRootPart.Velocity.Magnitude / 1.5, 12)) / 8, 0));
		if u18 <= 1 then
			u2 = 1;
		else
			u2 = u18;
		end;
		if tick() - u19 <= math.clamp(u2 / 1000, 0.005, 0.45) then
			return;
		end;
		u19 = tick();
		local v33 = game.Workspace:WaitForChild("__THINGS"):WaitForChild("PlayerOrientationParts"):FindFirstChild(v3.Name);
		u15 = 0;
		u20 = v33.Orientation.Y - u21;
		if v33 then
			u15 = v33.Orientation.X;
			u21 = u20;
		end;
		u21 = Lerp(p7 * 10, u21, 0);
		v18:WaitForChild("Waist").C0 = v18:WaitForChild("Waist").C0:Lerp(CFrame.new(0, 0, 0.1) * CFrame.Angles(math.rad(u15) / 1.5, math.rad(u20) * 5, 0), p7 * 10);
		if p4.HumanoidRootPart.Velocity.Magnitude > 10 then
			u17 = u17 + p7 * 2;
		end;
		if u22 then
			u16 = u16:Lerp(u12, p7 * 15);
		else
			u16 = u16:Lerp(u8, p7 * 15);
		end;
		if tick() - u23 > 0.1 then
			u23 = tick();
			if u24.isSprinting then
				u22 = true;
			else
				u22 = false;
			end;
		end;
		if v5 and v5.animatedTexture and u13:FindFirstChild("effect") then
			local v34 = math.max(tick() - u25, 0.001);
			local v35 = math.clamp(math.sin(v34 / 2), 0, 1);
			local v36 = math.clamp(math.sin(v34 / 3), 0, 1);
			for v37, v38 in pairs(u13:GetChildren()) do
				if v38.Name == "effect" then
					for v39, v40 in pairs(v38:GetChildren()) do

						if v40.ClassName == "Texture" then
							if v40.Name == "1" then
								v40.OffsetStudsU = v34 / 3.25;
								v40.OffsetStudsV = -(v34 / -3.5);
								v40.Transparency = 0 + v35 * 0.1;
							elseif v40.Name == "2" then
								v40.OffsetStudsU = -(v34 / 1.35);
								v40.OffsetStudsV = v34 / 2.5;
								v40.Transparency = 0.3 + v35 * -0.2;
							elseif v40.Name == "3" then
								v40.OffsetStudsU = -(v34 / 3);
								v40.OffsetStudsV = v34 / 5;
								v40.Transparency = 0.9;
							end;
						end;					
					end;
				end;
			end;
		end;
	end);
	if u13:FindFirstChild("RightArm") then
		u13:WaitForChild("RightArm"):Destroy();
	end;
	if u13:FindFirstChild("LeftArm") then
		u13:WaitForChild("LeftArm"):Destroy();
	end;
	local u26 = 0;
	local u27 = l__UserGameSettings__3.SavedQualityLevel.Value;
	local l__C0__28 = v19.C0;
	local l__C0__29 = v20.C0;
	local l__C0__30 = v22.C0;
	local l__C0__31 = v23.C0;
	v1.Services.RunService:BindToRenderStep("UpdateGunIK" .. v17, Enum.RenderPriority.Last.Value, function(p8)
		if not u13 or not u13.PrimaryPart then
			return;
		end;
		if u18 <= 1 then
			u4 = 1;
		else
			u4 = u18;
		end;
		if tick() - u26 <= math.clamp(u4 / 650, 0.01, 0.75) then
			return;
		end;
		if u13:FindFirstChild("RightArm") then
			u13:WaitForChild("RightArm"):Destroy();
		end;
		if u13:FindFirstChild("LeftArm") then
			u13:WaitForChild("LeftArm"):Destroy();
		end;
		u26 = tick();
		u27 = l__UserGameSettings__3.SavedQualityLevel.Value;
		u18 = game.Players.LocalPlayer:DistanceFromCharacter(u13.PrimaryPart.Position);
		if l__Right__14 then
			local v42, v43, v44 = v1.Functions.SolveIK(v18.CFrame * l__C0__28, l__Right__14.WorldPosition, v25, v26);
			v19.C0 = v19.C0:Lerp(v18.CFrame:toObjectSpace(v42) * CFrame.Angles(v43, 0, 0), p8 * 15);
			v20.C0 = v20.C0:Lerp(l__C0__29 * CFrame.Angles(v44, 0, 0), p8 * 15);
		end;
		if l__Left__15 then
			local v45, v46, v47 = v1.Functions.SolveIK(v18.CFrame * l__C0__30, l__Left__15.WorldPosition, v27, v28);
			v22.C0 = v22.C0:Lerp(v18.CFrame:toObjectSpace(v45) * CFrame.Angles(v46, 0, 0), p8 * 15);
			v23.C0 = v23.C0:Lerp(l__C0__31 * CFrame.Angles(v47, 0, 0), p8 * 15);
		end;
	end);
	u7.thirdPersonShoot = v1.Signal.Fired("Do Third Person Shoot"):Connect(function(p9)
		if p9 == v3 then
			if u13 and u13.Parent and u13.PrimaryPart then
				if v5.shootSound then
					u5 = 0.175;
				else
					u5 = 0.375;
				end;
				v1.Audio.Play(v5.shootSound and v5.shootSound or 3545263252, u13.PrimaryPart.CFrame.p, math.random(95, 105) / 100, u5, 150);
			end;
			local u32 = nil;
			u32 = v1.Functions.FastTween(v9, {
				Value = u11
			}, { 0.01, "Linear", "Out" }).Completed:Connect(function(p10)
				v1.Functions.FastTween(v9, {
					Value = CFrame.new(0, 0, 0)
				}, { 0.15, "Quad", "Out" });
				if u32 then
					u32:Disconnect();
				end;
			end);
		end;
	end);
	u7.playerLeaving = game.Players.PlayerRemoving:Connect(function(p11)
		if p11 == v3 then
			u14();
		end;
	end);
	u7.characterRemoving = v3.CharacterRemoving:Connect(function()
		u14();
	end);
	u7.humanoidDied = v3.Character:WaitForChild("Humanoid").StateChanged:Connect(function(p12, p13)
		if p13 == Enum.HumanoidStateType.Dead then
			u14();
		end;
	end);
	u7.playerKilled = v1.Network.Fired("Player Killed"):Connect(function(p14)
		if p14 == v3 then
			u14();
		end;
	end);
	if not (not v1.Variables.Mobile) or not (not v1.Variables.Console) or v1.Save.Get().Level <= 5 then
		p4:WaitForChild("Hitbox").Size = Vector3.new(3.5, 6, 1.5) * 1.35;
	end;
end;
v1.Network.Fired("Player Show Equip"):Connect(function(p15, p16)
	if p15 ~= game.Players.LocalPlayer then
		coroutine.wrap(function()
			u6(p15.Character, p16);
		end)();
	end;
end);
wait(1);
for v48, v49 in pairs(game.Players:GetPlayers()) do
	if v49:FindFirstChild("__SPAWNED") and v49 ~= game.Players.LocalPlayer then
		u6(v49.Character, nil);
	end;
end;

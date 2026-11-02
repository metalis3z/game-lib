-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local u1 = 0;
local l__TweenService__2 = game:GetService("TweenService");
return function(p1, p2, p3)
	if p1.dead == true then
		return
	end
	local v3 = game.ReplicatedStorage.Entities.Screech:Clone();
	local v4 = math.random(-1, 1) * 2;
	if v4 < 0 then
		v4 = -1.1;
	end;
	u1 = u1 + 1;

	local l__unit__5 = (p1.finalCamCFrame.LookVector * Vector3.new(-1, 0, -1) + Vector3.new(0, 0, 0)).unit; -- Vector3.new(0, v4, 0)).unit;
	local l__p__6 = p1.finalCamCFrame.p;
	v3:SetPrimaryPartCFrame(CFrame.new(l__p__6 + l__unit__5 * 4, l__p__6) * CFrame.new(0, 0.5, 0));
	v3.Parent = p1.cam;
	local v7 = {};
	for v8, v9 in pairs(v3.Animations:GetChildren()) do
		if v9:IsA("Animation") then
			v7[v9.Name] = v3.AnimationController:LoadAnimation(v9);
		end;
	end;
	local v10 = tick();
	v7.Idle:Play();
	delay(math.random(1, 10) / 5, function()
		v3.HumanoidRootPart.Sound:Play();
	end);
	local v11 = tick();
	local v12 = 5 + math.random(1, 10) / 5;
	local u3 = false;
	local u4 = v3.PrimaryPart.CFrame;
	local u5 = true;
	local l__PointLight__6 = v3.Base.Attachment.PointLight;
	local u7 = 0;
	local u8 = false;
	local v13 = game:GetService("RunService"):BindToRenderStep("screechStuff" .. u1, 100, function(p4)
		if not u3 then
			v3.PrimaryPart.CFrame = u4;
		else

		end;
		if u5 then
			local v14 = (p1.finalCamCFrame.LookVector.unit - l__unit__5).Magnitude * 100;
			l__PointLight__6.Brightness = math.clamp(50 - v14, 0, 50) / 50;
			if v14 < 35 then
				u7 = u7 + p4;
			end;
			if u7 >= 0.1 then
				u8 = true;
			end;
		end;
	end);
	p1.camShaker:ShakeOnce(0.5, 12, 3, 1);
	for v15 = 1, 1000000 do
		task.wait();
		local l__p__16 = p1.finalCamCFrame.p;
		u4 = CFrame.new(l__p__16 + l__unit__5 * 3.5, l__p__16) * CFrame.new(0, 0.5, 0);
		if v11 + v12 < tick() then
			break;
		end;
		if u8 then
			break;
		end;
	end;
	local v17 = tick();
	local l__CFrame__18 = v3.PrimaryPart.CFrame;
	if p1.char:GetAttribute("CrucifixEnabled", true) then
		local v18, v19, v20 = CFrame.new(Vector3.new(0, 0, 0), l__unit__5):ToOrientation();
		if math.abs(p1.ax - math.deg(v19)) > 180 then
			p1.ax_t = p1.ax_t - 360;
		end;
		p1.ax_t = math.deg(v19);
		p1.ay_t = math.deg(v18);
		wait()
		v3:Destroy();
		game.Workspace.GameSettings.Fires.ScreechCrucifix:FireServer(u4, "cameadadadwwfafw")
		u3 = true;
		return
	else
		if u8 then
			game.ReplicatedStorage.EntityInfo.ScreechCaught:FireServer()
			v7.Caught:Play();
			script.Caught:Play();
			p1.camShaker:ShakeOnce(6, 42, 0, 1);
		else
			game.ReplicatedStorage.ClientBricks.TakeDamageScreech:FireServer(game.Players.LocalPlayer, 30)
			v7.Attack:Play();
			script.Attack:Play();
			p1.camShaker:ShakeOnce(8, 42, 0, 1);
		end;
	end
	v3.HumanoidRootPart.Sound:Stop();
	l__PointLight__6.Brightness = 1;
	local v19, v20, v21 = CFrame.new(Vector3.new(0, 0, 0), l__unit__5):ToOrientation();
	if math.abs(p1.ax - math.deg(v20)) > 180 then
		p1.ax_t = p1.ax_t - 360;
	end;
	p1.ax_t = math.deg(v20);
	p1.ay_t = math.deg(v19);
	game.ReplicatedStorage.Bricks.Screech:FireServer(u8);
	u5 = false;
	for v22 = 1, 1000000 do
		task.wait();
		local l__p__23 = p1.finalCamCFrame.p;
		u4 = l__CFrame__18:Lerp(CFrame.new(l__p__23 + l__unit__5 * 3.5, l__p__23) * CFrame.new(0, 0.5, 0), (l__TweenService__2:GetValue((tick() - v17) / 0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In)));
		if v17 + 0.1 < tick() then
			break;
		end;
	end;
	local v24 = tick();
	for v25 = 1, 1000000 do
		task.wait();
		u4 = CFrame.new(p1.finalCamCFrame.Position + p1.finalCamCFrame.LookVector * 3, p1.finalCamCFrame.Position) * CFrame.new(0, 0.5, 0);
		if v24 + 2 < tick() then
			break;
		end;
	end;
	u3 = true;
	v3:Destroy();

end;
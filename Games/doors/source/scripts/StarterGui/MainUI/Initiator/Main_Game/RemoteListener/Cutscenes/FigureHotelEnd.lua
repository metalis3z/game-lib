-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__EntityInfo__2 = game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo");
local l__TweenService__1 = game:GetService("TweenService");
return function(p1)
	local l__FigureCamPos__3 = workspace:FindFirstChild("FigureCamPos", true);
	local l__FigureCamPos2__4 = workspace:FindFirstChild("FigureCamPos2", true);
	local l__RigSpawnStairs__5 = workspace:FindFirstChild("RigSpawnStairs", true);
	local l__PlayerSpawnStairs__6 = workspace:FindFirstChild("PlayerSpawnStairs", true);
	local v7 = game.ReplicatedStorage.JumpscareModels.FigureLibrary:Clone();
	v7:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0));
	v7.Parent = p1.cam;
	local v8 = v7.AnimationController:LoadAnimation(v7.AnimIntroEnd);
	for v9 = 1, 10000 do
		task.wait();
		if v8.Length > 0 then
			break;
		end;
	end;
	if not (v8.Length > 0) then
		warn("Animations not loaded");
	end;
	v7:SetPrimaryPartCFrame(l__RigSpawnStairs__5.CFrame);
	task.delay(1, function()
		v7.Head.Click:Play();
		wait(2);
		v8:Play(0, 1, 1);
		v8:GetMarkerReachedSignal("Footstep"):Connect(function(p2)
			local v10 = "LeftFoot";
			if tostring(p2) == "1" then
				v10 = "RightFoot";
			end;
			v7[v10].Footstep:Play();
			v7[v10].FootstepLow:Play();
			p1.camShaker:ShakeOnce(2, 12, 0, 0.5);
		end);
		v8.Stopped:Connect(function()
			v7:Destroy();
		end);
		v7.Head.Click:Stop();
		v7.Head.Growl:Play();
		p1.camShaker:ShakeOnce(3, 12, 0.4, 1.3);
		wait(1);
	end);
	p1.stopcam = true;
	p1.freemouse = true;
	p1.hideplayers = 2;
	p1.update();
	local v11 = l__FigureCamPos__3.CFrame + l__FigureCamPos__3.CFrame.LookVector * 15;
	local l__CFrame__12 = l__FigureCamPos__3.CFrame;
	local l__CFrame__13 = l__FigureCamPos2__4.CFrame;
	local l__CFrame__14 = p1.cam.CFrame;
	local v15 = tick() + 2;
	local l__FieldOfView__16 = p1.cam.FieldOfView;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		FieldOfView = 60
	}):Play();
	for v17 = 1, 100000 do
		task.wait();
		if not (tick() <= v15) then
			break;
		end;
		p1.cam.CFrame = l__CFrame__14:Lerp(l__CFrame__13, (l__TweenService__1:GetValue((2 - math.abs(tick() - v15)) / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	local v18 = tick() + 2;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
		FieldOfView = 70
	}):Play();
	for v19 = 1, 100000 do
		task.wait();
		if not (tick() <= v18) then
			break;
		end;
		p1.cam.CFrame = l__CFrame__13:Lerp(v11, (l__TweenService__1:GetValue((2 - math.abs(tick() - v18)) / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	local v20 = tick() + 3.5;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
		FieldOfView = 70
	}):Play();
	for v21 = 1, 100000 do
		task.wait();
		if not (tick() <= v20) then
			break;
		end;
		p1.cam.CFrame = v11:Lerp(l__CFrame__12, (l__TweenService__1:GetValue((3.5 - math.abs(tick() - v20)) / 3.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	local v22, v23, v24 = CFrame.new(Vector3.new(0, 0, 0), l__PlayerSpawnStairs__6.CFrame.LookVector):ToOrientation();
	if math.abs(p1.ax - math.deg(v23)) > 180 then
		p1.ax_t = p1.ax_t - 360;
	end;
	p1.ax_t = math.deg(v23);
	local l__CFrame__25 = p1.cam.CFrame;
	local v26 = tick() + 1.5;
	local l__FieldOfView__27 = p1.cam.FieldOfView;
	for v28 = 1, 100000 do
		task.wait();
		local v29 = l__TweenService__1:GetValue((1.5 - math.abs(tick() - v26)) / 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
		if not (tick() <= v26) then
			break;
		end;
		p1.cam.CFrame = l__CFrame__25:Lerp(p1.basecamcf, v29) * p1.csgo;
		p1.cam.FieldOfView = l__FieldOfView__27 + (p1.fovspring - l__FieldOfView__27) * v29;
	end;
	p1.crouch(false);
	v7:Destroy();
	p1.stopcam = false;
	p1.freemouse = false;
	p1.hideplayers = 0;
	p1.update();
end;

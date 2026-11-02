-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__EntityInfo__2 = game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo");
local l__TweenService__1 = game:GetService("TweenService");
return function(p1)
	local l__FigureCamPos__3 = workspace:FindFirstChild("FigureCamPos", true);
	local l__RigSpawn__4 = workspace:FindFirstChild("RigSpawn", true);
	local l__BreakSound__5 = workspace:FindFirstChild("BreakSound", true);
	local l__LampParticle__6 = workspace:FindFirstChild("LampParticle", true);
	local l__LampParticleSmall__7 = workspace:FindFirstChild("LampParticleSmall", true);
	local v8 = game.ReplicatedStorage.JumpscareModels.FigureLibrary:Clone();
	v8:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0));
	v8.Parent = p1.cam;
	local v9 = v8.AnimationController:LoadAnimation(v8.AnimIdle);
	local v10 = v8.AnimationController:LoadAnimation(v8.AnimIntro);
	v9:Play(0, 1, 1);
	for v11 = 1, 10000 do
		task.wait();
		if v9.Length > 0 and v10.Length > 0 then
			break;
		end;
	end;
	if not (v9.Length > 0) or not (v10.Length > 0) then
		warn("Animations not loaded");
	end;
	v9:Play(0, 1, 1);
	v8:SetPrimaryPartCFrame(l__RigSpawn__4.CFrame);
	task.delay(3, function()
		v10:Play(0.5, 1, 1);
		v10:GetMarkerReachedSignal("Footstep"):Connect(function(p2)
			local v12 = "LeftFoot";
			if tostring(p2) == "1" then
				v12 = "RightFoot";
			end;
			v8[v12].Footstep:Play();
			v8[v12].FootstepLow:Play();
			p1.camShaker:ShakeOnce(2, 12, 0, 0.5);
		end);
		v10.Stopped:Connect(function()
			v8:Destroy();
		end);
		v8.Head.Click:Play();
		wait(2);
		p1.camShaker:ShakeOnce(7, 14, 0.4, 1.3);
		l__BreakSound__5.Break:Play();
		wait(0.4);
		v8.Head.Click:Stop();
		v8.Head.Growl:Play();
		p1.camShaker:ShakeOnce(3, 12, 0.4, 1.3);
		wait(1.3);
		v8.Head.Break:Play();
		v8.Head.Break3:Play();
		p1.camShaker:ShakeOnce(5, 18, 0.1, 1.3);
		p1.camShaker:ShakeOnce(4, 10, 1, 2.4);
		wait(0.5);
		l__LampParticle__6:Emit(6);
		l__LampParticleSmall__7:Emit(6);
		v8.Head.Break2:Play();
	end);
	p1.stopcam = true;
	p1.freemouse = true;
	p1.hideplayers = 2;
	p1.update();
	local v13 = l__FigureCamPos__3.CFrame + l__FigureCamPos__3.CFrame.LookVector * 15;
	local l__CFrame__14 = l__FigureCamPos__3.CFrame;
	local l__CFrame__15 = p1.cam.CFrame;
	local v16 = tick() + 3;
	local l__FieldOfView__17 = p1.cam.FieldOfView;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		FieldOfView = 60
	}):Play();
	for v18 = 1, 100000 do
		task.wait();
		if not (tick() <= v16) then
			break;
		end;
		p1.cam.CFrame = l__CFrame__15:Lerp(v13, (l__TweenService__1:GetValue((3 - math.abs(tick() - v16)) / 3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	local v19 = tick() + 5;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
		FieldOfView = 70
	}):Play();
	for v20 = 1, 100000 do
		task.wait();
		if not (tick() <= v19) then
			break;
		end;
		p1.cam.CFrame = v13:Lerp(l__CFrame__14, (l__TweenService__1:GetValue((5 - math.abs(tick() - v19)) / 5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	v8:Destroy();
	local l__CFrame__21 = p1.cam.CFrame;
	local v22 = tick() + 0.5;
	local l__FieldOfView__23 = p1.cam.FieldOfView;
	for v24 = 1, 100000 do
		task.wait();
		local v25 = l__TweenService__1:GetValue((0.5 - math.abs(tick() - v22)) / 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
		if not (tick() <= v22) then
			break;
		end;
		p1.cam.CFrame = l__CFrame__21:Lerp(p1.basecamcf, v25) * p1.csgo;
		p1.cam.FieldOfView = l__FieldOfView__23 + (p1.fovspring - l__FieldOfView__23) * v25;
	end;
	p1.stopcam = false;
	p1.freemouse = false;
	p1.hideplayers = 0;
	p1.update();
end;

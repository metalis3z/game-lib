-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__EntityInfo__2 = game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo");
local l__TweenService__1 = game:GetService("TweenService");
return function(p1)
	local l__CamPosEnd__3 = workspace:FindFirstChild("CamPosEnd", true);
	local l__CamPosWire__4 = workspace:FindFirstChild("CamPosWire", true);
	local l__CamPosOverhead__5 = workspace:FindFirstChild("CamPosOverhead", true);
	local l__CamPosHall1__6 = workspace:FindFirstChild("CamPosHall1", true);
	local l__CamPosHall2__7 = workspace:FindFirstChild("CamPosHall2", true);
	local l__RigSpawnFire__8 = workspace:FindFirstChild("RigSpawnFire", true);
	local l__PlayerSpawnFire__9 = workspace:FindFirstChild("PlayerSpawnFire", true);
	local l__SparkPart__10 = workspace:FindFirstChild("SparkPart", true);
	local v11 = game.ReplicatedStorage.JumpscareModels.FigureLibrary:Clone();
	v11:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0));
	v11.Parent = p1.cam;
	local v12 = v11.AnimationController:LoadAnimation(v11.AnimIntroEndFire);
	for v13 = 1, 10000 do
		task.wait();
		if v12.Length > 0 then
			break;
		end;
	end;
	if not (v12.Length > 0) then
		warn("Animations not loaded");
	end;
	v11:SetPrimaryPartCFrame(l__RigSpawnFire__8.CFrame);
	task.spawn(function()
		v12:Play(0, 1, 1);
		v12:GetMarkerReachedSignal("Footstep"):Connect(function(p2)
			local v14 = "LeftFoot";
			if tostring(p2) == "1" then
				v14 = "RightFoot";
			end;
			v11[v14].Footstep:Play();
			v11[v14].FootstepLow:Play();
			p1.camShaker:ShakeOnce(2, 12, 0, 0.5);
		end);
		v12.Stopped:Connect(function()
			v11:Destroy();
		end);
		v11.Head.Click:Play();
		wait(2);
		l__SparkPart__10.Particle:Emit(5);
		l__SparkPart__10.Particle.Enabled = true;
		l__SparkPart__10.Sound:Play();
		task.spawn(function()
			for v15, v16 in pairs(l__SparkPart__10.Parent:GetDescendants()) do
				if v16:GetAttribute("EnableAfterFire") then
					task.delay(v16:GetAttribute("EnableAfterFire") / 2, function()
						v16.Enabled = true;
					end);
				end;
			end;
		end);
		wait(0.5);
		l__SparkPart__10.Particle.Enabled = false;
		v11.Head.Click:Stop();
		v11.Head.Growl:Play();
		p1.camShaker:ShakeOnce(3, 12, 0.4, 1.3);
		wait(1.5);
		wait(3.8);
		v11.Head.GlassBreak:Play();
		local l__WindowToBreak__17 = workspace:FindFirstChild("WindowToBreak", true);
		p1.camShaker:ShakeOnce(14, 18, 0, 1.3);
		p1.camShaker:ShakeOnce(24, 2, 0, 2);
		l__WindowToBreak__17.Normal.Union.Transparency = 1;
		l__WindowToBreak__17.Normal.Glass.Transparency = 1;
		l__WindowToBreak__17.Broken:SetPrimaryPartCFrame(l__WindowToBreak__17.Broken.PrimaryPart.CFrame + Vector3.new(0, 50, 0));
		l__WindowToBreak__17.Broken.Glass.ParticleEmitter:Emit(25);
	end);
	p1.stopcam = true;
	p1.freemouse = true;
	p1.hideplayers = 1.2;
	p1.update();
	local v18 = l__CamPosEnd__3.CFrame + l__CamPosEnd__3.CFrame.LookVector * 3;
	local l__CFrame__19 = l__CamPosEnd__3.CFrame;
	p1.cam.FieldOfView = 60;
	local v20 = tick() + 1.2;
	for v21 = 1, 100000 do
		task.wait();
		if not (tick() <= v20) then
			break;
		end;
		p1.cam.CFrame = v18:Lerp(l__CFrame__19, (l__TweenService__1:GetValue((1.2 - math.abs(tick() - v20)) / 1.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	local v22 = l__CamPosWire__4.CFrame + l__CamPosWire__4.CFrame.LookVector * 1;
	local l__CFrame__23 = l__CamPosWire__4.CFrame;
	local v24 = tick() + 1.5;
	for v25 = 1, 100000 do
		task.wait();
		if not (tick() <= v24) then
			break;
		end;
		p1.cam.CFrame = v22:Lerp(l__CFrame__23, (l__TweenService__1:GetValue((1.5 - math.abs(tick() - v24)) / 1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	local v26 = l__CamPosOverhead__5.CFrame + l__CamPosOverhead__5.CFrame.LookVector * 1;
	local l__CFrame__27 = l__CamPosOverhead__5.CFrame;
	local v28 = tick() + 3.4;
	p1.camShaker:ShakeOnce(5, 12, 0, 7);
	p1.camShaker:ShakeOnce(12, 5, 0, 7);
	for v29 = 1, 100000 do
		task.wait();
		if not (tick() <= v28) then
			break;
		end;
		p1.cam.CFrame = v26:Lerp(l__CFrame__27, (l__TweenService__1:GetValue((3.4 - math.abs(tick() - v28)) / 3.4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	local v30 = l__CamPosHall1__6.CFrame + l__CamPosHall1__6.CFrame.LookVector * 5;
	local l__CFrame__31 = l__CamPosHall1__6.CFrame;
	local v32 = tick() + 1.5;
	for v33 = 1, 100000 do
		task.wait();
		if not (tick() <= v32) then
			break;
		end;
		p1.cam.CFrame = v30:Lerp(l__CFrame__31, (l__TweenService__1:GetValue((1.5 - math.abs(tick() - v32)) / 1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	local v34 = l__CamPosHall2__7.CFrame + l__CamPosHall2__7.CFrame.LookVector * 5;
	local l__CFrame__35 = l__CamPosHall2__7.CFrame;
	local v36 = tick() + 1.6;
	for v37 = 1, 100000 do
		task.wait();
		if not (tick() <= v36) then
			break;
		end;
		p1.cam.CFrame = v34:Lerp(l__CFrame__35, (l__TweenService__1:GetValue((1.6 - math.abs(tick() - v36)) / 1.6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	local v38, v39, v40 = CFrame.new(Vector3.new(0, 0, 0), l__PlayerSpawnFire__9.CFrame.LookVector):ToOrientation();
	if math.abs(p1.ax - math.deg(v39)) > 180 then
		p1.ax_t = p1.ax_t - 360;
	end;
	p1.ax_t = math.deg(v39);
	v11:Destroy();
	p1.stopcam = false;
	p1.freemouse = false;
	p1.hideplayers = 0;
	p1.update();
end;

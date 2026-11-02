-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__EntityInfo__2 = game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo");
local l__TweenService__1 = game:GetService("TweenService");
return function(p1)
	local l__CamPosChase1__3 = workspace:FindFirstChild("CamPosChase1", true);
	local l__CamPosChase2__4 = workspace:FindFirstChild("CamPosChase2", true);
	local l__PlayerSpawnChase__5 = workspace:FindFirstChild("PlayerSpawnChase", true);
	local l__DoorToBreakDown__6 = workspace:FindFirstChild("DoorToBreakDown", true);
	p1.stopcam = true;
	p1.freemouse = true;
	p1.update();
	local v7 = l__CamPosChase1__3.CFrame + l__CamPosChase1__3.CFrame.LookVector * 2;
	local l__CFrame__8 = l__CamPosChase1__3.CFrame;
	local v9 = tick() + 2;
	for v10 = 1, 100000 do
		task.wait();
		if not (tick() <= v9) then
			break;
		end;
		p1.cam.CFrame = v7:Lerp(l__CFrame__8, (l__TweenService__1:GetValue((2 - math.abs(tick() - v9)) / 2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	local v11 = l__CamPosChase2__4.CFrame + l__CamPosChase2__4.CFrame.LookVector * 3;
	local l__CFrame__12 = l__CamPosChase2__4.CFrame;
	local v13 = tick() + 1.5;
	task.delay(0.1, function()
		l__DoorToBreakDown__6.Door.Growl:Play();
		for v14 = 1, 2 do
			l__DoorToBreakDown__6.Door.Knock:Play();
			l__DoorToBreakDown__6.Door.ParticleEmitter:Emit(10);
			p1.camShaker:ShakeOnce(5, 15, 0, 0.9);
			p1.camShaker:ShakeOnce(8, 2, 0, 0.9);
			wait(1.1);
		end;
	end);
	for v15 = 1, 100000 do
		task.wait();
		local v16 = l__TweenService__1:GetValue((1.5 - math.abs(tick() - v13)) / 1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
		pcall(function()
			p1.char.PrimaryPart.Anchored = true;
		end);
		if not (tick() <= v13) then
			break;
		end;
		p1.cam.CFrame = v11:Lerp(l__CFrame__12, v16) * p1.csgo;
	end;
	local v17, v18, v19 = CFrame.new(Vector3.new(0, 0, 0), l__PlayerSpawnChase__5.CFrame.LookVector):ToOrientation();
	if math.abs(p1.ax - math.deg(v18)) > 180 then
		p1.ax_t = p1.ax_t - 360;
	end;
	p1.ax_t = math.deg(v18);
	pcall(function()
		p1.char.PrimaryPart.Anchored = false;
	end);
	p1.crouch(false);
	p1.stopcam = false;
	p1.freemouse = false;
	p1.hideplayers = 0;
	p1.update();
end;

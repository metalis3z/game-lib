-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__EntityInfo__2 = game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo");
local l__TweenService__1 = game:GetService("TweenService");
return function(p1)
	if not workspace:FindFirstChild("SeekMoving", true) then
		warn("cant find elevator!");
		return;
	end;
	local l__SeekMoving__3 = workspace:FindFirstChild("SeekMoving", true);
	local l__PrimaryPart__4 = l__SeekMoving__3.PrimaryPart;
	p1.stopcam = true;
	p1.freemouse = true;
	p1.hideplayers = -1;
	p1.update();
	for v5, v6 in pairs(l__SeekMoving__3:GetDescendants()) do
		if v6.Name == "StringCheese" then
			v6.Enabled = true;
			delay(6 + math.random(1, 50) / 100, function()
				l__TweenService__1:Create(v6, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0), {
					Width1 = 0, 
					CurveSize0 = -2
				}):Play();
				l__TweenService__1:Create(v6, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.1), {
					Width0 = 0, 
					CurveSize1 = -2
				}):Play();
				wait(0.2);
				v6.Enabled = false;
			end);
		end;
	end;
	local l__CamPos1__7 = l__PrimaryPart__4:FindFirstChild("CamPos1", true);
	local l__CamPos2__8 = l__PrimaryPart__4:FindFirstChild("CamPos2", true);
	local l__CamPos3__9 = l__PrimaryPart__4:FindFirstChild("CamPos3", true);
	local l__CamPos4__10 = l__PrimaryPart__4:FindFirstChild("CamPos4", true);
	local l__CamPos5__11 = l__PrimaryPart__4:FindFirstChild("CamPos5", true);
	local l__CamPos6__12 = l__PrimaryPart__4:FindFirstChild("CamPos6", true);
	local l__CFrame__13 = p1.cam.CFrame;
	local v14 = tick() + 1;
	local l__FieldOfView__15 = p1.cam.FieldOfView;
	p1.camShaker:ShakeOnce(12, 0.5, 2, 10);
	for v16 = 1, 100000 do
		task.wait();
		local v17 = l__TweenService__1:GetValue((1 - math.abs(tick() - v14)) / 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
		if not (tick() <= v14) then
			break;
		end;
		p1.cam.CFrame = l__CFrame__13:Lerp(l__CamPos1__7.WorldCFrame, v17) * p1.csgo;
		p1.cam.FieldOfView = l__FieldOfView__15 + (p1.fovspring - l__FieldOfView__15) * v17;
	end;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
		FieldOfView = 30
	}):Play();
	p1.camShaker:ShakeOnce(9, 0.5, 0.5, 7, Vector3.new(0.1, 0.1, 0.1));
	p1.camShaker:ShakeOnce(2, 3, 1, 12);
	
	local l__WorldCFrame__18 = l__CamPos1__7.WorldCFrame;
	local l__WorldCFrame__19 = l__CamPos2__8.WorldCFrame;
	local v20 = tick() + 2;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		FieldOfView = 60
	}):Play();
	for v21 = 1, 100000 do
		if not (tick() <= v20) then
			break;
		end;
		p1.cam.CFrame = l__CamPos1__7.WorldCFrame:Lerp(l__CamPos2__8.WorldCFrame, (l__TweenService__1:GetValue((2 - math.abs(tick() - v20)) / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.In))) * p1.csgo;
		task.wait();
	end;
	local l__WorldCFrame__22 = l__CamPos3__9.WorldCFrame;
	local l__WorldCFrame__23 = l__CamPos4__10.WorldCFrame;
	local v24 = tick() + 3.4;
	p1.cam.FieldOfView = 45;
	for v25 = 1, 100000 do
		if not (tick() <= v24) then
			break;
		end;
		p1.cam.CFrame = l__WorldCFrame__22:Lerp(l__WorldCFrame__23, (l__TweenService__1:GetValue((3.4 - math.abs(tick() - v24)) / 3.4, Enum.EasingStyle.Linear, Enum.EasingDirection.In))) * p1.csgo;
		task.wait();
	end;
	local l__WorldCFrame__26 = l__CamPos5__11.WorldCFrame;
	local l__WorldCFrame__27 = l__CamPos6__12.WorldCFrame;
	local v28 = tick() + 1.2;
	p1.cam.FieldOfView = 60;
	for v29 = 1, 100000 do
		if not (tick() <= v28) then
			break;
		end;
		p1.cam.CFrame = l__WorldCFrame__26:Lerp(l__WorldCFrame__27, (l__TweenService__1:GetValue((1.2 - math.abs(tick() - v28)) / 1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))) * p1.csgo;
		task.wait();
	end;
	local v30, v31, v32 = CFrame.new(Vector3.new(0, 0, 0), l__PrimaryPart__4.CFrame.LookVector):ToOrientation();
	if math.abs(p1.ax - math.deg(v31)) > 180 then
		p1.ax_t = p1.ax_t - 360;
	end;
	p1.ax_t = math.deg(v31);
	local l__CFrame__33 = p1.cam.CFrame;
	local v34 = tick() + 1;
	local l__FieldOfView__35 = p1.cam.FieldOfView;
	for v36 = 1, 100000 do
		task.wait();
		local v37 = l__TweenService__1:GetValue((1 - math.abs(tick() - v34)) / 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
		if not (tick() <= v34) then
			break;
		end;
		p1.cam.CFrame = l__CFrame__33:Lerp(p1.basecamcf, v37) * p1.csgo;
		p1.cam.FieldOfView = l__FieldOfView__35 + (p1.fovspring - l__FieldOfView__35) * v37;
	end;
	p1.chaseMove = true;
	p1.stopcam = false;
	p1.freemouse = false;
	p1.hideplayers = 1;
	p1.update();
	p1.camShaker:ShakeOnce(48, 0.3, 0.7, 40);
end;
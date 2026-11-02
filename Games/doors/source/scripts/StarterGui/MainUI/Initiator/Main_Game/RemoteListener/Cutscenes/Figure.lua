-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__Bricks__2 = game:GetService("ReplicatedStorage"):WaitForChild("Bricks");
local l__TweenService__1 = game:GetService("TweenService");
return function(p1)
	local l__FigureCamPos__3 = workspace:FindFirstChild("FigureCamPos", true);
	p1.stopcam = true;
	p1.freemouse = true;
	p1.chase = true;
	p1.hideplayers = 2;
	p1.update();
	local v4 = l__FigureCamPos__3.CFrame + l__FigureCamPos__3.CFrame.LookVector * 25;
	local l__CFrame__5 = l__FigureCamPos__3.CFrame;
	local l__CFrame__6 = p1.cam.CFrame;
	local v7 = tick() + 2;
	local l__FieldOfView__8 = p1.cam.FieldOfView;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(1.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
		FieldOfView = 40
	}):Play();
	for v9 = 1, 100000 do
		task.wait();
		if not (tick() <= v7) then
			break;
		end;
		p1.cam.CFrame = l__CFrame__6:Lerp(v4, (l__TweenService__1:GetValue((2 - math.abs(tick() - v7)) / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	local v10 = tick() + 6;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		FieldOfView = 70
	}):Play();
	for v11 = 1, 100000 do
		task.wait();
		if not (tick() <= v10) then
			break;
		end;
		p1.cam.CFrame = v4:Lerp(l__CFrame__5, (l__TweenService__1:GetValue((6 - math.abs(tick() - v10)) / 6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	local l__CFrame__12 = p1.cam.CFrame;
	local v13 = tick() + 0.5;
	local l__FieldOfView__14 = p1.cam.FieldOfView;
	for v15 = 1, 100000 do
		task.wait();
		local v16 = l__TweenService__1:GetValue((0.5 - math.abs(tick() - v13)) / 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
		if not (tick() <= v13) then
			break;
		end;
		p1.cam.CFrame = l__CFrame__12:Lerp(p1.basecamcf, v16) * p1.csgo;
		p1.cam.FieldOfView = l__FieldOfView__14 + (p1.fovspring - l__FieldOfView__14) * v16;
	end;
	p1.stopcam = false;
	p1.freemouse = false;
	p1.chase = false;
	p1.hideplayers = 0;
	p1.update();
end;

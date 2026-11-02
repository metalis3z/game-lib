
-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local l__TweenService__1 = game:GetService("TweenService");
return function(p1, p2, p3)
	local v3 = game.ReplicatedStorage.Entities.Spider:Clone();
	v3.Parent = p1.cam;
	local v4 = v3.AnimationController:LoadAnimation(v3.Animations.Jump);
	local v5 = tick();
	for v6 = 1, 100 do
		if v4.Length > 0 then
			break;
		end;
		task.wait();
	end;
	local v7 = math.ceil(p2.Main.Size.X * 10) - 2;
	local v8 = math.ceil(p2.Main.Size.Z * 10) - 2;
	local v9 = Vector3.new(math.random(-v7, v7) / 22, 0, math.random(-v8, v8) / 22);
	local v10 = CFrame.Angles(0, math.rad(math.random(0, 360)), 0);
	v3:SetPrimaryPartCFrame((p2.Main.CFrame + v9) * v10);
	local l__CFrame__11 = v3.PrimaryPart.CFrame;
	for v12 = 1, 1000000 do
		task.wait();
		v3.PrimaryPart.CFrame = (p2.Main.CFrame + v9) * v10;
		if v5 + p3 < tick() then
			break;
		end;
	end;
	v3.PrimaryPart.Sound:Play();
	script.Scare:Play();
	game.ReplicatedStorage.ClientBricks:FindFirstChild("AchievementSpider"):FireServer(game.Players.LocalPlayer)
	v4:Play(0);
	local v13 = tick();
	local l__CFrame__14 = v3.PrimaryPart.CFrame;
	p1.camShaker:ShakeOnce(5, 6, 0.3, 0.6);
	for v15 = 1, 1000000 do
		task.wait();
		v3.PrimaryPart.CFrame = l__CFrame__14:Lerp(CFrame.new(p1.cam.CFrame.Position + p1.cam.CFrame.LookVector * 0.35, p1.cam.CFrame.Position), (l__TweenService__1:GetValue((tick() - v13) / 0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In)));
		if v13 + 0.2 < tick() then
			break;
		end;
	end;
	p1.camShaker:ShakeOnce(3, 24, 0, 1);
	local v16 = tick();
	for v17 = 1, 1000000 do
		task.wait();
		v3.PrimaryPart.CFrame = CFrame.new(p1.cam.CFrame.Position + p1.cam.CFrame.LookVector * 0.35, p1.cam.CFrame.Position);
		if v16 + 0.6 < tick() then
			break;
		end;
	end;
	v3:Destroy();
end;


-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__Bricks__2 = game:GetService("ReplicatedStorage"):WaitForChild("Bricks");
local l__TweenService__1 = game:GetService("TweenService");
return function(p1)
	game.Workspace:FindFirstChild("CollisionPlayer", true).CanCollide = true
	v1.MainFrame.Crosshair.Visible = false
	
	for i, v in pairs(game.Players:GetPlayers()) do 
		if v.Character then
			v.Character:PivotTo(game.Workspace:FindFirstChild("PartTp", true).CFrame)
		end
	end
	
	local PrimaryDoor = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 3).Door
	PrimaryDoor.Name = "DoorEnd_1"
	
    p1.camShaker:StartShake(12, 0.2, 0.5, 100);
	local l__FigureCamPos__3 = workspace:FindFirstChild("FigureCamPosFall", true);
	local l__Lide__1 = workspace:FindFirstChild("Lide", true);
	local l__AlternateBayourd__3 = workspace:FindFirstChild("AlternateBayourd", true);
	local l__FigureSetupFall__3 = workspace:FindFirstChild("FigureSetupFall", true);
	p1.stopcam = true;
	p1.freemouse = true;
	p1.hideplayers = 2;
	p1.update();

	PrimaryDoor.HingeConstraint.TargetAngle = 0
	PrimaryDoor.HingeConstraint.ServoMaxTorque = 255565
	PrimaryDoor.Collision.CanCollide = true
	
	local l__Floor__1 = l__AlternateBayourd__3:FindFirstChild("Floor")
	
	local l__Figure__1 = l__FigureSetupFall__3.FigureCutscene
	local l__WorldCFrame__1 = l__FigureCamPos__3.CamPos1.WorldCFrame;
	local l__WorldCFrame__4 = l__FigureCamPos__3.CamPos2.WorldCFrame;
	local l__WorldCFrame__5 = l__FigureCamPos__3.CamPos3.WorldCFrame;
	local l__CFrame__6 = p1.cam.CFrame;
	local v7 = tick() + 3;
	local l__FieldOfView__8 = p1.cam.FieldOfView;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		FieldOfView = 60
	}):Play();
	
	local v37 = tick() + 3;
	for v38 = 1, 100000 do
		task.wait();
		local v39 = l__TweenService__1:GetValue((3 - math.abs(tick() - v37)) / 3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
		if not (tick() <= v37) then
			break;
		end;
		p1.cam.CFrame = l__WorldCFrame__1 * p1.csgo;
	end;
	
	workspace:FindFirstChild("PartElectro", true).Effect.Core.Enabled = true
	workspace:FindFirstChild("PartElectro", true).Effect.CoreMiniSparks.Enabled = true
	workspace:FindFirstChild("PartElectro", true).Effect.MiniSparks.Enabled = true
	workspace:FindFirstChild("PartElectro", true).Effect.Sparks.Enabled = true
	
	wait(0.7)
	
	l__TweenService__1:Create(p1.cam, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		FieldOfView = 75
	}):Play();
	
	workspace:FindFirstChild("OilPuddleMan", true).FireParticles.Enabled = true
	workspace:FindFirstChild("OilPuddleMan", true).SmokeParticles.Enabled = true
	workspace:FindFirstChild("OilPuddleMan", true).SparkParticles.Enabled = true

	workspace:FindFirstChild("OilPuddleMan", true).Attachment.FireLight.Enabled = true
	
	local v402 = tick() + 3;
	for v41 = 1, 100000 do
		task.wait();
		local v39 = l__TweenService__1:GetValue((3 - math.abs(tick() - v402)) / 2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
		if not (tick() <= v402) then
			break;
		end;
		p1.cam.CFrame = l__WorldCFrame__4 * p1.csgo;
	end;
	
	local v402 = tick() + 2;
	for v41 = 1, 100000 do
		task.wait();
		local v39 = l__TweenService__1:GetValue((2 - math.abs(tick() - v402)) / 2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
		if not (tick() <= v402) then
			break;
		end;
		p1.cam.CFrame = l__WorldCFrame__5 * p1.csgo;
	end;
	
	local v403 = tick() + 4.2;
	for v41 = 1, 100000 do
		task.wait();
		local v39 = l__TweenService__1:GetValue((4.2 - math.abs(tick() - v403)) / 4.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
		if not (tick() <= v403) then
			break;
		end;
		p1.cam.CFrame = l__WorldCFrame__5 * p1.csgo;
	end;
	
	l__Floor__1.Attachment1.FireLight.Enabled = true
	l__Floor__1.Attachment2.FireLight.Enabled = true
	
	l__Floor__1.FireParticles.Enabled = true
	l__Floor__1.SmokeParticles.Enabled = true
	l__Floor__1.SparkParticles.Enabled = true
	
	v1.MainFrame.Crosshair.Visible = true
	p1.stopcam = false;
	p1.freemouse = false;
	p1.hideplayers = 0;
	p1.update();
end;

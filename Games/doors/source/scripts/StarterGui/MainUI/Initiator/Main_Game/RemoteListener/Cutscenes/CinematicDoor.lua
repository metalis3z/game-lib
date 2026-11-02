-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__Bricks__2 = game:GetService("ReplicatedStorage"):WaitForChild("Bricks");
local l__TweenService__1 = game:GetService("TweenService");
return function(p1)
	script.Parent.Parent.Parent.Parent.Parent.Parent.PermUI.Enabled = false
	v1.Enabled = false
	game.ReplicatedStorage.Sounds["LA_The Hotel"]:Play()
	
	p1.stopcam = true;
	p1.freemouse = true;
	p1.hideplayers = 2;
	p1.update();
	
	game.Lighting.CinematicDoor.Enabled = true
	
	p1.cam.FieldOfView = 80
	
	local CinematicDoor = game.ReplicatedStorage.Misc.CinematicYellowDoorDefault:Clone()
	
	CinematicDoor:PivotTo(CinematicDoor.PrimaryPart.CFrame * CFrame.new(0, 1550, 0))
	CinematicDoor.Parent = game.Workspace

	local l__DoorCamPos__1 = CinematicDoor.Void.DoorCamPos.WorldCFrame;
	local l__StartCamPos__1 = CinematicDoor.Void.StartCamPos.WorldCFrame;
	local l__FirstCamPos__1 = CinematicDoor.Void.FirstCamPos.WorldCFrame;
	local l__EndCamPos__1 = CinematicDoor.Void.EndCamPos.WorldCFrame;
	local l__CFrame__6 = p1.cam.CFrame;
	
	local timeaction = 0.3
	local v37 = tick() + timeaction;
	for v38 = 1, 100000 do
		task.wait();
		local v39 = l__TweenService__1:GetValue((timeaction - math.abs(tick() - v37)) / timeaction, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
		if not (tick() <= v37) then
			break;
		end;
		p1.cam.CFrame = l__FirstCamPos__1 * p1.csgo;
	end;
	
	local t = l__TweenService__1:Create(p1.cam, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		FieldOfView = 50
	})

	t:Play()
	
	local t2 = l__TweenService__1:Create(game.Lighting.CinematicDoor, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		Contrast = 0,
		Brightness = 0,
	})
	
	t2:Play()
	
	p1.camShaker:ShakeOnce(8, 0.8, 0.5, 15);
	
	local v20 = tick() + 2;
	for v21 = 1, 100000 do
		if not (tick() <= v20) then
			break;
		end;
		p1.cam.CFrame = l__FirstCamPos__1:Lerp(l__StartCamPos__1, (l__TweenService__1:GetValue((2 - math.abs(tick() - v20)) / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.In))) * p1.csgo;
		task.wait();
	end;
	
	CinematicDoor.Door.Door.Open:Play()
	CinematicDoor.Door.Door.Anchored = false
	
	local v20 = tick() + 2;
	for v21 = 1, 100000 do
		if not (tick() <= v20) then
			break;
		end;
		p1.cam.CFrame = l__StartCamPos__1:Lerp(l__DoorCamPos__1, (l__TweenService__1:GetValue((2 - math.abs(tick() - v20)) / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.In))) * p1.csgo;
		task.wait();
	end;
	
	p1.camShaker:ShakeOnce(8, 3, 0.5, 1);
	
	script.Parent.Parent.Parent.Parent.Parent.Parent.TableUI.Blackscree.Visible = true
	local t = l__TweenService__1:Create(script.Parent.Parent.Parent.Parent.Parent.Parent.TableUI.Blackscree, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		BackgroundTransparency = 0
	})

	t:Play()
	
	local v20 = tick() + 1.5;
	for v21 = 1, 100000 do
		if not (tick() <= v20) then
			break;
		end;
		p1.cam.CFrame = l__DoorCamPos__1:Lerp(l__EndCamPos__1, (l__TweenService__1:GetValue((2 - math.abs(tick() - v20)) / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.In))) * p1.csgo;
		task.wait();
	end;
	
	local t23 = l__TweenService__1:Create(game.Workspace.CurrentRooms:FindFirstChild("0").DoorFrame.Union.AttachDoor.PointLight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		Brightness = 3
	})

	t23:Play()
	
	game.Workspace.CurrentRooms:FindFirstChild("0").DoorFrame.Union.HelpParticle:Emit(29)
	game.Workspace.CurrentRooms:FindFirstChild("0").DoorFrame.Union.AttachDoor.ParticleEmitter:Emit(1)
	game.Workspace.CurrentRooms:FindFirstChild("0").DoorFrame.Union.Attachment.ParticleEmitter:Emit(1)
	
	wait(0.4)

	local t23 = l__TweenService__1:Create(game.Workspace.CurrentRooms:FindFirstChild("0").DoorFrame.Union.AttachDoor.PointLight, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		Brightness = 0
	})

	t23:Play()

	v1.Enabled = true
	script.Parent.Parent.Parent.Parent.Parent.Parent.PermUI.Enabled = true
	v1.MainFrame.Crosshair.Visible = true
	p1.stopcam = false;
	p1.freemouse = false;
	p1.hideplayers = 0;
	p1.update();
	CinematicDoor:Destroy()
	
	local t = l__TweenService__1:Create(script.Parent.Parent.Parent.Parent.Parent.Parent.TableUI.Blackscree, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		BackgroundTransparency = 1
	})

	t:Play()
end;
-- Decompiled with the Synapse X Luau decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__Bricks__2 = game:GetService("ReplicatedStorage"):WaitForChild("Bricks");
local u3 = script:FindFirstAncestor("MainUI");
return function(p1)
	game.ReplicatedStorage.Bricks.ChangeModuleVariable:FireServer(game.Players.LocalPlayer, "hideplayers", 1)
	u3.MainFrame.Crosshair.Visible = false
	u3.MainFrame.Hotbar.Visible = false
	u3.MainFrame.Healthbar.Visible = false
	if not workspace:FindFirstChild("ElevatorCar", true) then
		warn("cant find elevator!");
		return;
	end;
	local l__ElevatorCar__1 = workspace:FindFirstChild("ElevatorCar", true);
	local l__Parent__2 = l__ElevatorCar__1.Parent;
	p1.stopcam = true;
	p1.freemouse = true;
	p1.hideplayers = -2;
	local v3 = CFrame.new(0, 0, 0);
	local v4 = tick() + 2;
	local l__CFrame__5 = p1.cam.CFrame;
	local v6 = l__ElevatorCar__1.Figure.AnimationController:LoadAnimation(l__ElevatorCar__1.Figure.Animation);
	local v7 = l__ElevatorCar__1.AnimationController:LoadAnimation(l__ElevatorCar__1.Animation);
	local v8 = l__ElevatorCar__1:FindFirstChild("CamPos1", true).WorldCFrame;
	local l__CamPos0__9 = l__ElevatorCar__1:FindFirstChild("CamPos0", true);
	local l__CamPos1__10 = l__ElevatorCar__1:FindFirstChild("CamPos1", true);
	local l__CamPos2__11 = l__ElevatorCar__1:FindFirstChild("CamPos2", true);
	local l__CamPos3__12 = l__ElevatorCar__1:FindFirstChild("CamPos3", true);
	local l__CamPos4__13 = l__ElevatorCar__1:FindFirstChild("CamPos4", true);
	local l__CamPos5__14 = l__ElevatorCar__1:FindFirstChild("CamPos5", true);
	local l__CamPos6__15 = l__ElevatorCar__1:FindFirstChild("CamPos6", true);
	l__TweenService__1:Create(p1.cam, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
		FieldOfView = 80
	}):Play();
	p1.camShaker:ShakeOnce(8, 0.2, 0.5, 100);
	for v16 = 1, 100000 do
		task.wait();
		if not (tick() <= v4) then
			break;
		end;
		v8 = l__CamPos1__10.WorldCFrame;
		p1.cam.CFrame = l__CFrame__5:Lerp(v8, (l__TweenService__1:GetValue((2 - math.abs(tick() - v4)) / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	p1.cam.CFrame = v8 * p1.csgo;
	local u4 = true;
	spawn(function()
		for v17 = 1, 10000000000000 do
			task.wait();
			p1.cam.CFrame = v8 * p1.csgo;
			if u4 == false then
				break;
			end;
		end;
	end);
	local v2 = {};
	game.ReplicatedStorage.EntityInfo:WaitForChild("CutsceneFollowup").OnClientEvent:Wait();
	
	game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(l__ElevatorCar__1.Animations:FindFirstChild("AnimationOnce")):Play()
	
	--[[-for v3 = 1, 4 do
		local v4 = l__ElevatorCar__1.Spawns:FindFirstChild("PlayerWeld" .. v3);
		local v5 = l__ElevatorCar__1.Animations:FindFirstChild("Character" .. v3);
		if v4 and v5 then
			pcall(function()
				local l__Parent__6 = v4.Weld.Part0.Parent;
				if l__Parent__6 then
					print("No way. I Found A Character!!! *flosses*");
					table.insert(v2, (l__Parent__6.Humanoid:LoadAnimation(v5)));
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(v5):Play()
					game.Players.LocalPlayer.Character:PivotTo(v4.CFrame)
				end;
			end);
		else
			warn("yo... im calling my grammy maw");
		end;
	end;--]]
	u4 = false;
	script.EndMusic:Play();
	v6:Play(0);
	v7:Play(0);
	delay(0, function()
		l__ElevatorCar__1.Figure.Head.Growl:Play();
		wait(0.4);
		v6.TimePosition = 0.4;
		v7.TimePosition = 0.4;
		l__ElevatorCar__1.Figure.Head.Footstep:Play();
		p1.camShaker:ShakeOnce(2, 18, 0, 0.7);
		wait(0.3);
		l__ElevatorCar__1.Figure.Head.Footstep:Play();
		l__ElevatorCar__1.Figure.Head.Hit:Play();
		p1.camShaker:ShakeOnce(3, 18, 0, 0.7);
		wait(1);
		l__ElevatorCar__1.Figure.Head.Click:Play();
	end);
	local l__WorldCFrame__18 = l__CamPos1__10.WorldCFrame;
	local l__WorldCFrame__19 = l__CamPos2__11.WorldCFrame;
	local v20 = tick() + 10;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		FieldOfView = 60
	}):Play();
	p1.camShaker:ShakeOnce(2, 6, 1, 1);
	p1.camShaker:ShakeOnce(0.1, 15, 2, 30);
	p1.camShaker:ShakeOnce(6, 0.4, 35, 10);
	delay(24.7, function()
		p1.camShaker:ShakeOnce(12, 0.5, 2, 2);
		l__TweenService__1:Create(p1.cam, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			FieldOfView = 40
		}):Play();
		wait(2);
		p1.camShaker:ShakeOnce(7, 8, 0, 3);
		p1.camShaker:ShakeOnce(3, 32, 0, 1);
		l__TweenService__1:Create(p1.cam, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			FieldOfView = 70
		}):Play();
	end);
	for v21 = 1, 100000 do
		task.wait();
		if not (tick() <= v20) then
			break;
		end;
		p1.cam.CFrame = l__CamPos0__9.WorldCFrame:Lerp(l__CamPos1__10.WorldCFrame, (l__TweenService__1:GetValue((10 - math.abs(tick() - v20)) / 10, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	local v22 = tick() + 10;
	for v23 = 1, 100000 do
		task.wait();
		if not (tick() <= v22) then
			break;
		end;
		p1.cam.CFrame = l__CamPos1__10.WorldCFrame * p1.csgo;
	end;
	local v24 = tick() + 9;
	for v25 = 1, 100000 do
		task.wait();
		if not (tick() <= v24) then
			break;
		end;
		p1.cam.CFrame = l__CamPos1__10.WorldCFrame:Lerp(l__CamPos2__11.WorldCFrame, (l__TweenService__1:GetValue((9 - math.abs(tick() - v24)) / 9, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	p1.cam.FieldOfView = 80;
	local v26 = tick() + 3.5;
	p1.camShaker:ShakeOnce(25, 2, 0, 3.5);
	for v27, v28 in pairs(l__ElevatorCar__1:GetDescendants()) do
		if v28.Name == "PulleyCenter" or v28.Name == "PulleyCorner" then
			local v29 = math.random(710, 770) / 100;
			if v28.Name == "PulleyCenter" then
				v29 = 0.33;
			end;
			delay(v29, function()
				v28.Transparency = 1;
				p1.camShaker:ShakeOnce(1, 15, 0, 0.4);
				for v30, v31 in pairs(v28:GetDescendants()) do
					if v31.Name == "Spark" then
						v31:Emit(1);
					elseif v31.Name == "Particle" then
						v31:Emit(5);
						v31.Enabled = true;
					elseif v31:IsA("Sound") then
						v31:Play();
					elseif v31:IsA("PointLight") then
						v31.Enabled = true;
						local v32 = {
							Range = 2, 
							Brightness = 0, 
							Color = Color3.fromRGB(255, 228, 147)
						};
						local v33 = l__TweenService__1:Create(v31, TweenInfo.new(math.random(20, 50) / 100, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 50, true), v32);
						v33:Play();
					end;
				end;
			end);
		elseif v28.Name == "ElevatorLight" and v28:IsA("BasePart") then
			v28.Material = Enum.Material.Neon;
			for v34, v35 in pairs(v28:GetDescendants()) do
				if v35:IsA("Light") then
					l__TweenService__1:Create(v35, TweenInfo.new(math.random(20, 50) / 100, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 50, true), {
						Range = 2, 
						Brightness = 0, 
						Color = Color3.fromRGB(255, 228, 147)
					}):Play();
				end;
			end;
		end;
	end;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(3.5, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
		FieldOfView = 40
	}):Play();
	delay(2, function()
		l__ElevatorCar__1.Figure.Head.GrowlFar:Play();
	end);
	for v36 = 1, 100000 do
		task.wait();
		if not (tick() <= v26) then
			break;
		end;
		p1.cam.CFrame = l__CamPos3__12.WorldCFrame:Lerp(l__CamPos4__13.WorldCFrame, (l__TweenService__1:GetValue((3.5 - math.abs(tick() - v26)) / 3.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	p1.camShaker:ShakeOnce(35, 0.2, 0, 3);
	p1.camShaker:ShakeOnce(3, 10, 0, 3);
	p1.camShaker:ShakeOnce(0.4, 43, 0, 20);
	local v37 = tick() + 3;
	p1.cam.FieldOfView = 80;
	for v38 = 1, 100000 do
		task.wait();
		local v39 = l__TweenService__1:GetValue((3 - math.abs(tick() - v37)) / 3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
		if not (tick() <= v37) then
			break;
		end;
		p1.cam.CFrame = l__CamPos6__15.WorldCFrame * p1.csgo;
	end;
	local v40 = tick() + 2;
	p1.cam.FieldOfView = 60;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(1.98, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
		FieldOfView = 20
	}):Play();
	p1.camShaker:ShakeOnce(15, 1, 1, 2);
	p1.camShaker:ShakeOnce(8, 12, 0, 2);
	for v41 = 1, 100000 do
		task.wait();
		if not (tick() <= v40) then
			break;
		end;
		p1.cam.CFrame = l__CamPos5__14.WorldCFrame * p1.csgo;
	end;
	local v42 = tick() + 2.5;
	p1.cam.FieldOfView = 80;
	p1.camShaker:ShakeOnce(7, 32, 2, 6);
	p1.camShaker:ShakeOnce(7, 26, 0, 6, Vector3.new(0, 0, 0), Vector3.new(1, 2, 2));
	p1.camShaker:ShakeOnce(25, 1, 0, 6, Vector3.new(0, 0, 0), Vector3.new(0, 2, 2));
	delay(2.34, function()
		p1.camShaker:ShakeOnce(55, 5, 0.1, 6, Vector3.new(0, 0, 0), Vector3.new(2, 2, 2));
	end);
	for v43 = 1, 100000 do
		task.wait();
		local v44 = l__TweenService__1:GetValue((2.5 - math.abs(tick() - v42)) / 2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
		if not (tick() <= v42) then
			break;
		end;
		p1.cam.CFrame = l__CamPos6__15.WorldCFrame * p1.csgo;
	end;
	script.Parent.Parent.Parent.Health["Solution Lights"]:Play()
	u3.ToBeContinued.Visible = true;
	l__TweenService__1:Create(u3.ToBeContinued.TextLabel, TweenInfo.new(4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		TextTransparency = 1
	}):Play();
	game.ReplicatedStorage.EntityInfo.BadgeSc:FireServer(game.ReplicatedStorage.EntityInfo.GetLimbs:InvokeServer())
	wait(4);
	l__TweenService__1:Create(u3.ToBeContinued.ImageLabel, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		ImageTransparency = 0
	}):Play();
	wait(5);
	pcall(function()
		p1.spectate(true, false);
	end);
	l__TweenService__1:Create(u3.ToBeContinued.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
end;
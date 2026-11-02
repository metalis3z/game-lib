-- Decompiled with the Synapse X Luau decompiler.

local l__EntityInfo__1 = game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo");
local l__TweenService__2 = game:GetService("TweenService");
local u3 = script:FindFirstAncestor("MainUI");
return function(p1)
	if not workspace:FindFirstChild("ElevatorCar", true) then
		warn("cant find elevator!");
		return;
	end;
	local l__ElevatorCar__1 = workspace:FindFirstChild("ElevatorCar", true);
	local v2 = {};
	local u4 = false;
	l__EntityInfo__1:WaitForChild("CutsceneFollowup").OnClientEvent:Connect(function()
		u4 = true;
	end);
	for v3 = 1, 4 do
		local v4 = l__ElevatorCar__1.Spawns:FindFirstChild("PlayerWeld" .. v3);
		local v5 = l__ElevatorCar__1.Animations:FindFirstChild("Character" .. v3);
		if v4 and v5 then
			pcall(function()
				local l__Parent__6 = v4.Weld.Part0.Parent;
				if l__Parent__6 then
					print("No way. I Found A Character!!! *flosses*");
					table.insert(v2, (l__Parent__6.Humanoid:LoadAnimation(v5)));
				end;
			end);
		else
			warn("yo... im calling my grammy maw");
		end;
	end;
	table.insert(v2, l__ElevatorCar__1.FigureElevator.AnimationController:LoadAnimation(l__ElevatorCar__1.Animations.FigureElevator));
	table.insert(v2, l__ElevatorCar__1.FigureFirst.AnimationController:LoadAnimation(l__ElevatorCar__1.Animations.FigureFirst));
	table.insert(v2, l__ElevatorCar__1.AnimationController:LoadAnimation(l__ElevatorCar__1.Animations.ElevatorCar));
	local l__Parent__7 = l__ElevatorCar__1.Parent;
	p1.stopcam = true;
	p1.freemouse = true;
	p1.hideplayers = -1;
	local v8 = CFrame.new(0, 0, 0);
	local v9 = tick() + 1;
	local l__CFrame__10 = p1.cam.CFrame;
	local v11 = l__ElevatorCar__1:FindFirstChild("CamPos1", true).WorldCFrame;
	local l__CamPos0__12 = l__ElevatorCar__1:FindFirstChild("CamPos0", true);
	local l__CamPos1__13 = l__ElevatorCar__1:FindFirstChild("CamPos1", true);
	local l__CamPos2__14 = l__ElevatorCar__1:FindFirstChild("CamPos2", true);
	local l__CamPos3__15 = l__ElevatorCar__1:FindFirstChild("CamPos3", true);
	local l__CamPos4__16 = l__ElevatorCar__1:FindFirstChild("CamPos4", true);
	local l__CamPos5__17 = l__ElevatorCar__1:FindFirstChild("CamPos5", true);
	local l__CamPos6__18 = l__ElevatorCar__1:FindFirstChild("CamPos6", true);
	l__TweenService__2:Create(p1.cam, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		FieldOfView = 80
	}):Play();
	p1.camShaker:ShakeOnce(8, 0.2, 0.5, 100);
	for v19 = 1, 100000 do
		task.wait();
		if not (tick() <= v9) then
			break;
		end;
		v11 = l__CamPos1__13.WorldCFrame;
		p1.cam.CFrame = l__CFrame__10:Lerp(v11, (l__TweenService__2:GetValue((1 - math.abs(tick() - v9)) / 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	p1.cam.CFrame = v11 * p1.csgo;
	local u5 = true;
	spawn(function()
		for v20 = 1, 10000000000000 do
			task.wait();
			p1.cam.CFrame = v11 * p1.csgo;
			if u5 == false then
				break;
			end;
		end;
	end);
	for v21 = 1, 500 do
		wait(0.1);
		if u4 then
			break;
		end;
	end;
	u5 = false;
	script.EndMusic:Play();
	for v22, v23 in pairs(v2) do
		v23:Play(0, 1, 1);
		local u6 = tick();
		task.spawn(function()
			for v24 = 1, 10 do
				wait(0.5);
				v23.TimePosition = tick() - u6;
			end;
		end);
	end;
	delay(0, function()
		l__ElevatorCar__1.FigureFirst.Head.Growl:Play();
		l__ElevatorCar__1.FigureFirst.Head.Footstep:Play();
		p1.camShaker:ShakeOnce(2, 18, 0, 0.7);
		wait(0.2);
		l__ElevatorCar__1.FigureFirst.Head.Footstep:Play();
		wait(0.2);
		l__ElevatorCar__1.FigureFirst.Head.Hit:Play();
		p1.camShaker:ShakeOnce(3, 18, 0, 0.7);
		wait(1.5);
		l__ElevatorCar__1.FigureFirst.Head.Hit:Play();
		p1.camShaker:ShakeOnce(3, 18, 0, 0.7);
		wait(1);
		l__ElevatorCar__1.FigureFirst.Head.Click:Play();
	end);
	local l__WorldCFrame__25 = l__CamPos1__13.WorldCFrame;
	local l__WorldCFrame__26 = l__CamPos2__14.WorldCFrame;
	local v27 = tick() + 10;
	l__TweenService__2:Create(p1.cam, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		FieldOfView = 60
	}):Play();
	p1.camShaker:ShakeOnce(2, 6, 1, 1);
	p1.camShaker:ShakeOnce(0.1, 15, 2, 30);
	p1.camShaker:ShakeOnce(6, 0.4, 35, 10);
	delay(24.7, function()
		p1.camShaker:ShakeOnce(12, 0.5, 2, 2);
		wait(2);
		p1.camShaker:ShakeOnce(7, 8, 0, 3);
		p1.camShaker:ShakeOnce(3, 32, 0, 1);
		l__TweenService__2:Create(p1.cam, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			FieldOfView = 70
		}):Play();
	end);
	for v28 = 1, 100000 do
		task.wait();
		if not (tick() <= v27) then
			break;
		end;
		p1.cam.CFrame = l__CamPos0__12.WorldCFrame:Lerp(l__CamPos1__13.WorldCFrame, (l__TweenService__2:GetValue((10 - math.abs(tick() - v27)) / 10, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	local v29 = tick() + 15;
	for v30 = 1, 100000 do
		task.wait();
		if not (tick() <= v29) then
			break;
		end;
		p1.cam.CFrame = l__CamPos1__13.WorldCFrame * p1.csgo;
	end;
	local v31 = tick() + 4;
	for v32 = 1, 100000 do
		task.wait();
		if not (tick() <= v31) then
			break;
		end;
		p1.cam.CFrame = l__CamPos1__13.WorldCFrame:Lerp(l__CamPos2__14.WorldCFrame, (l__TweenService__2:GetValue((4 - math.abs(tick() - v31)) / 4, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	p1.cam.FieldOfView = 80;
	local v33 = tick() + 3.5;
	p1.camShaker:ShakeOnce(25, 2, 0, 3.5);
	for v34, v35 in pairs(l__ElevatorCar__1:GetDescendants()) do
		if v35.Name == "PulleyCenter" or v35.Name == "PulleyCorner" then
			local v36 = math.random(710, 770) / 100;
			if v35.Name == "PulleyCenter" then
				v36 = 0.33;
			end;
			delay(v36, function()
				v35.Transparency = 1;
				p1.camShaker:ShakeOnce(1, 15, 0, 0.4);
				for v37, v38 in pairs(v35:GetDescendants()) do
					if v38.Name == "Spark" then
						v38:Emit(1);
					elseif v38.Name == "Particle" then
						v38:Emit(5);
						v38.Enabled = true;
					elseif v38:IsA("Sound") then
						v38:Play();
					elseif v38:IsA("PointLight") then
						v38.Enabled = true;
						local v39 = {
							Range = 2, 
							Brightness = 0, 
							Color = Color3.fromRGB(255, 228, 147)
						};
						local v40 = l__TweenService__2:Create(v38, TweenInfo.new(math.random(20, 50) / 100, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 50, true), v39);
						v40:Play();
					end;
				end;
			end);
		elseif v35.Name == "ElevatorLight" and v35:IsA("BasePart") then
			v35.Material = Enum.Material.Neon;
			for v41, v42 in pairs(v35:GetDescendants()) do
				if v42:IsA("Light") then
					l__TweenService__2:Create(v42, TweenInfo.new(math.random(20, 50) / 100, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 50, true), {
						Range = 2, 
						Brightness = 0, 
						Color = Color3.fromRGB(255, 228, 147)
					}):Play();
				end;
			end;
		end;
	end;
	l__TweenService__2:Create(p1.cam, TweenInfo.new(3.5, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
		FieldOfView = 70
	}):Play();
	delay(2, function()
		l__ElevatorCar__1.FigureElevator.Head.GrowlFar:Play();
	end);
	for v43 = 1, 100000 do
		task.wait();
		if not (tick() <= v33) then
			break;
		end;
		p1.cam.CFrame = l__CamPos3__15.WorldCFrame:Lerp(l__CamPos4__16.WorldCFrame, (l__TweenService__2:GetValue((3.5 - math.abs(tick() - v33)) / 3.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut))) * p1.csgo;
	end;
	p1.camShaker:ShakeOnce(35, 0.2, 0, 3);
	p1.camShaker:ShakeOnce(3, 10, 0, 3);
	p1.camShaker:ShakeOnce(0.4, 43, 0, 20);
	local v44 = tick() + 3;
	p1.cam.FieldOfView = 90;
	for v45 = 1, 100000 do
		task.wait();
		local v46 = l__TweenService__2:GetValue((3 - math.abs(tick() - v44)) / 3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
		if not (tick() <= v44) then
			break;
		end;
		p1.cam.CFrame = l__CamPos6__18.WorldCFrame * p1.csgo;
	end;
	local v47 = tick() + 2;
	p1.cam.FieldOfView = 70;
	l__TweenService__2:Create(p1.cam, TweenInfo.new(1.98, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
		FieldOfView = 20
	}):Play();
	p1.camShaker:ShakeOnce(15, 1, 1, 2);
	p1.camShaker:ShakeOnce(8, 12, 0, 2);
	for v48 = 1, 100000 do
		task.wait();
		if not (tick() <= v47) then
			break;
		end;
		p1.cam.CFrame = l__CamPos5__17.WorldCFrame * p1.csgo;
	end;
	local v49 = tick() + 2.5;
	p1.cam.FieldOfView = 90;
	p1.camShaker:ShakeOnce(7, 32, 2, 6);
	p1.camShaker:ShakeOnce(7, 26, 0, 6, Vector3.new(0, 0, 0), Vector3.new(1, 2, 2));
	p1.camShaker:ShakeOnce(25, 1, 0, 6, Vector3.new(0, 0, 0), Vector3.new(0, 2, 2));
	delay(2.34, function()
		p1.camShaker:ShakeOnce(55, 5, 0.1, 6, Vector3.new(0, 0, 0), Vector3.new(2, 2, 2));
	end);
	for v50 = 1, 100000 do
		task.wait();
		local v51 = l__TweenService__2:GetValue((2.5 - math.abs(tick() - v49)) / 2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
		if not (tick() <= v49) then
			break;
		end;
		p1.cam.CFrame = l__CamPos6__18.WorldCFrame * p1.csgo;
	end;
	u3.ToBeContinued.Visible = true;
	l__TweenService__2:Create(u3.ToBeContinued.TextLabel, TweenInfo.new(4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		TextTransparency = 1
	}):Play();
	wait(4);
	l__TweenService__2:Create(u3.ToBeContinued.ImageLabel, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		ImageTransparency = 0
	}):Play();
	wait(5);
	pcall(function()
		p1.spectate(true);
	end);
	l__TweenService__2:Create(u3.ToBeContinued.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
end;

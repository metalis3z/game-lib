-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local l__LocalPlayer__1 = game.Players.LocalPlayer;
	local v2 = require(l__LocalPlayer__1:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
	local v3 = game["Run Service"];
	local l__UserInputService__4 = game:GetService("UserInputService");
	local l__TweenService__5 = game:GetService("TweenService");
	local l__mouse__6 = l__LocalPlayer__1:GetMouse();
	local l__MinigameBackout__7 = script:FindFirstAncestor("MainUI").MinigameBackout;
	p1.stopcam = true;
	p1.freemouse = true;
	p1.hideplayers = 2;
	local v8 = CFrame.new(0, 0, 0);
	local v9 = tick() + 1;
	local v10 = tick() + 1;
	local l__Padlock__11 = workspace:FindFirstChild("Padlock", true);
	local l__Selector__12 = l__Padlock__11:FindFirstChild("Selector", true);
	l__Padlock__11.ConfirmUI.Enabled = p1.controller == "console";
	l__Selector__12.Visible = p1.controller == "console";
	local l__WorldCFrame__13 = workspace:FindFirstChild("CamAttachPadlock", true).WorldCFrame;
	p1.camShaker:ShakeOnce(2, 0.5, 0.5, 8);
	local l__CFrame__1 = p1.cam.CFrame;
	local l__FieldOfView__2 = p1.cam.FieldOfView;
	local u3 = false;
	task.spawn(function()
		for v14 = 1, 100000 do
			task.wait();
			local v15 = l__TweenService__5:GetValue((1 - math.abs(tick() - v9)) / 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
			if not (tick() <= v9) then
				break;
			end;
			p1.cam.CFrame = l__CFrame__1:Lerp(l__WorldCFrame__13, v15) * p1.csgo;
			p1.cam.FieldOfView = l__FieldOfView__2 + (30 - l__FieldOfView__2) * v15;
		end;
		p1.cam.CFrame = l__WorldCFrame__13 * p1.csgo;
		for v16 = 1, 10000000000000 do
			task.wait();
			p1.cam.CFrame = l__WorldCFrame__13 * p1.csgo;
			if u3 == true then
				break;
			end;
		end;
	end);
	local l__ActivateEventPrompt__17 = l__Padlock__11:FindFirstChild("ActivateEventPrompt");
	l__ActivateEventPrompt__17.Enabled = false;
	local l__AnimationController__18 = l__Padlock__11.AnimationController;
	local v19 = {};
	for v20, v21 in pairs(l__Padlock__11:FindFirstChild("Animations"):GetChildren()) do
		v19[v21.Name] = l__AnimationController__18:LoadAnimation(v21);
	end;
	v19.start:Play(0.1);
	v19.idle:Play(0.2);
	local v22 = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
	local l__MinigameBackout__23 = script.Parent.Parent.Parent.Parent.MinigameBackout;
	l__MinigameBackout__23.Visible = true;
	l__TweenService__5:Create(l__MinigameBackout__23, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 3, true), {
		ImageColor3 = Color3.fromRGB(107, 129, 179), 
		Size = UDim2.new(0.1, 60, 0.1, 60)
	}):Play();
	local u4 = nil;
	local u5 = nil;
	local u6 = nil;
	local u7 = nil;
	local u8 = v10;
	local function u9(p2, p3)
		p2.NumberUI.TextLabel.Text = p3;
		for v24, v25 in pairs(p2:GetChildren()) do
			if v25:IsA("BasePart") and v25:FindFirstChild("NumberUI") then
				local v26 = 1;
				if v25.Name == "NumberTop" then
					v26 = 2;
				elseif v25.Name == "NumberBelow" then
					v26 = -1;
				elseif v25.Name == "NumberBottom" then
					v26 = -2;
				end;
				local v27 = (p3 + v26) % 10;
				if v27 == nil then
					warn("idk lol");
					v27 = 0;
				end;
				v25.NumberUI.TextLabel.Text = v27;
			end;
		end;
	end;
	local function u10(p4, p5)
		if tick() < u8 then
			return;
		end;
		if p5 == nil then
			p5 = 1;
		end;
		local v28 = (tonumber(p4.NumberUI.TextLabel.Text) + p5) % 10;
		if v28 == nil then
			warn("idk lol");
			v28 = 0;
		end;
		p4.Sound.Pitch = 1 + p5 / 10 + v28 / 30;
		p4.Sound:Play();
		u9(p4, v28);
		local l__Weld__29 = p4.Weld;
		l__Weld__29.C0 = l__Weld__29.C0 * CFrame.Angles(math.rad(45 * p5), 0, 0);
		l__TweenService__5:Create(p4.Weld, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			C0 = CFrame.new(0, 0, 0)
		}):Play();
	end;
	local function u11()
		v19.input:Play();
		u8 = tick() + 1;
		local v30 = "";
		for v31 = 1, 5 do
			for v32, v33 in pairs(l__Padlock__11:GetDescendants()) do
				if v33.Name == "Number" and v33:IsA("MeshPart") and v33:GetAttribute("ID") == v31 then
					v30 = v30 .. tostring(v33.NumberUI.TextLabel.Text);
				end;
			end;
		end;
		print(v30)
		p1.remotes:WaitForChild("PL"):FireServer(v30);
		wait(0.3);
		for v34, v35 in pairs(l__Padlock__11:GetDescendants()) do
			if v35.Name == "Number" and v35:IsA("BasePart") then
				local l__Weld__36 = v35.Weld;
				l__Weld__36.C0 = l__Weld__36.C0 * CFrame.Angles(3.141592653589793, 0, 0);
				l__TweenService__5:Create(v35.Weld, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					C0 = CFrame.new(0, 0, 0)
				}):Play();
				u9(v35, 0);
			end;
		end;
	end;
	local function u12()
		if u3 == false then
			pcall(function()
				u4:Disconnect();
				u5:Disconnect();
				u6:Disconnect();
				u7:Disconnect();
			end);
			print("Unlocked")
			u3 = true;
			p1.hideplayers = 0;
			l__MinigameBackout__23.Visible = false;
			v19["end"].Priority = Enum.AnimationPriority.Action4
			v19["end"]:Play();
			v19.idle:Stop();
			l__Padlock__11.ConfirmUI.Enabled = false;
			l__Selector__12.Visible = false;
			local l__basecamcf__37 = p1.basecamcf;
			local v38 = tick() + 0.5;
			p1.camShaker:ShakeOnce(2, 0.5, 0.5, 1);
			local l__CFrame__13 = p1.cam.CFrame;
			local l__FieldOfView__14 = p1.cam.FieldOfView;
			task.spawn(function()
				for v39 = 1, 100000 do
					task.wait();
					local v40 = l__TweenService__5:GetValue((0.5 - math.abs(tick() - v38)) / 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
					if not (tick() <= v38) then
						break;
					end;
					p1.cam.CFrame = l__CFrame__13:Lerp(p1.basecamcf, v40) * p1.csgo;
					p1.cam.FieldOfView = l__FieldOfView__14 + (p1.fovspring - l__FieldOfView__14) * v40;
				end;
				p1.stopcam = false;
				p1.freemouse = false;
				l__ActivateEventPrompt__17.Enabled = l__Padlock__11.Padlocked.Value;
			end);
		end;
	end;
	local u15 = 1;
	u4 = l__UserInputService__4.InputBegan:Connect(function(p6)
		if p6.UserInputType == Enum.UserInputType.MouseButton1 or p6.UserInputType == Enum.UserInputType.Touch then
			local v41 = p1.cam:ScreenPointToRay(p6.Position.X, p6.Position.Y);
			local v42, v43 = workspace:FindPartOnRay(Ray.new(v41.Origin, v41.Direction * 1000), p1.char);
			if v42.Name == "Number" then
				u10(v42);
				p1.camShaker:ShakeOnce(0.1, 2, 0.06, 0.2);
				return;
			end;
			if v42.Name == "ConfirmButton" or v42.Name == "ConfirmUIHolder" then
				u11();
				return;
			end;
		elseif p6.UserInputType == Enum.UserInputType.MouseButton2 then
			local v44 = p1.cam:ScreenPointToRay(p6.Position.X, p6.Position.Y);
			local v45, v46 = workspace:FindPartOnRay(Ray.new(v44.Origin, v44.Direction * 1000), p1.char);
			if v45.Name == "Number" then
				u10(v45, -1);
				p1.camShaker:ShakeOnce(0.1, 2, 0.06, 0.2);
				return;
			end;
			if v45.Name == "ConfirmButton" then
				u11();
				return;
			end;
		else
			if p6.KeyCode == Enum.KeyCode.ButtonA then
				u11();
				return;
			end;
			if p6.KeyCode == Enum.KeyCode.ButtonB then
				u12();
				return;
			end;
			if p6.KeyCode == Enum.KeyCode.ButtonX or p6.KeyCode == Enum.KeyCode.DPadUp then
				for v47, v48 in pairs(l__Padlock__11:GetDescendants()) do
					if v48.Name == "Number" and v48:IsA("BasePart") and v48:GetAttribute("ID") == u15 then
						u10(v48);
					end;
				end;
				return;
			end;
			if p6.KeyCode == Enum.KeyCode.DPadDown then
				for v49, v50 in pairs(l__Padlock__11:GetDescendants()) do
					if v50.Name == "Number" and v50:IsA("BasePart") and v50:GetAttribute("ID") == u15 then
						u10(v50, -1);
					end;
				end;
				return;
			end;
			if p6.KeyCode == Enum.KeyCode.DPadLeft or p6.KeyCode == Enum.KeyCode.DPadRight then
				if p6.KeyCode == Enum.KeyCode.DPadRight then
					u15 = math.clamp(u15 + 1, 1, 5);
				else
					u15 = math.clamp(u15 - 1, 1, 5);
				end;
				for v51, v52 in pairs(l__Padlock__11:GetDescendants()) do
					if v52.Name == "Number" and v52:IsA("BasePart") and v52:GetAttribute("ID") == u15 then
						l__Selector__12.Parent = v52.NumberUI.TextLabel;
					end;
				end;
			end;
		end;
	end);
	u5 = l__MinigameBackout__23.MouseButton1Down:Connect(u12);
	u6 = l__Padlock__11.Padlocked.Changed:connect(function()
		if l__Padlock__11.Padlocked.Value == false then
			u12();
		end;
	end);
	u7 = l__LocalPlayer__1.Character.Humanoid.HealthChanged:Connect(function()
		if l__LocalPlayer__1.Character.Humanoid.Health < 0.1 then
			u12();
		end;
	end);
	if l__Padlock__11.Padlocked.Value == false then
		u12();
	end;
	spawn(function()
		for v53, v54 in pairs (l__Padlock__11:GetDescendants()) do
			local v57 = v54
			if v57.Name == "Number" and v57:IsA("BasePart") then
				delay(v57:GetAttribute("ID") / 20, function()
					l__TweenService__5:Create(v57, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 1, true), {
						Color = Color3.fromRGB(159, 160, 221)
					}):Play();
				end);
			end;
			if v57.Name == "ConfirmButton" and v57:IsA("BasePart") then
				delay(2, function()
					l__TweenService__5:Create(v57, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
						Color = Color3.fromRGB(139, 255, 158)
					}):Play();
				end);
			end;		
		end;
	end);
	if u3 == true then
		return;
	end;
end;

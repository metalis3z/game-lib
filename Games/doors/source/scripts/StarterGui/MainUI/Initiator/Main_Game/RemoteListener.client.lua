-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local v3 = require(l__LocalPlayer__2:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local v4 = game["Run Service"];
local l__UserInputService__5 = game:GetService("UserInputService");
local l__TweenService__6 = game:GetService("TweenService");
local l__EntityInfo__1 = game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo");
local u2 = require(script.Parent);
local v7 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("Module_Events"));
v7.init(u2);
local l__ClosestPoint__8 = Ray.new().ClosestPoint;
local v9 = Vector3.new();
game.SoundService.Main.Volume = 1;
local function v10()
	if u2.skybox then
		u2.skybox:Destroy();
	end;
	u2.skybox = game:GetService("ReplicatedStorage"):WaitForChild("Misc"):WaitForChild("SkyboxPart"):Clone();
	if game:GetService("ReplicatedStorage"):WaitForChild("GameData"):WaitForChild("Floor").Value then

	end;
	u2.skybox.CFrame = u2.cam.CFrame;
	u2.skybox.Parent = u2.cam;
end;
v10();

l__EntityInfo__1:WaitForChild("UpdateFloor").OnClientEvent:Connect(v10);
l__EntityInfo__1:WaitForChild("PadlockHint").OnClientEvent:Connect(function(p1, p2, p3)
	local l__Hints__11 = v1.Parent.PermUI.Hints;
	l__Hints__11.Visible = true;
	if not p1 or not p2 then
		l__Hints__11.Visible = false;
		for v12, v13 in pairs(l__Hints__11:GetChildren()) do
			if v13.Name == "Icon" then
				v13:Destroy();
			end;
		end;
		return;
	end;
	local v14 = l__Hints__11.Template:Clone();
	v14.Name = "Icon";
	v14.Visible = true;
	v14.ImageRectOffset = Vector2.new(50 * p1, 0);
	v14.TextLabel.Text = p2;
	if p3 and p3 ~= l__LocalPlayer__2.UserId then
		v14.User.Visible = true;
		v14.User.Image = "rbxthumb://type=AvatarHeadShot&id=" .. p3 .. "&w=48&h=48";
	end;
	v14.Parent = l__Hints__11;
end);
l__EntityInfo__1:WaitForChild("MotorReplication").OnClientEvent:Connect(function(p4, p5, p6, p7)
	pcall(function()
		if not p4 or not p4:FindFirstChild("Humanoid") or not p4:FindFirstChild("Humanoid"):GetAttribute("AppearanceFinal") then
			return;
		end;
		local v15 = CFrame.new(0, 0.22, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
		local v16 = CFrame.new(0, -1.1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
		local v17 = CFrame.new(0, 0.88, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
		local v18 = CFrame.new(1, 0.62, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
		local v19 = CFrame.new(-1, 0.62, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
		if p4 and p4:FindFirstChild("HumanoidRootPart") then
			local l__HumanoidRootPart__20 = p4:WaitForChild("HumanoidRootPart", 0.5);
			local l__ClientMotors__21 = p4:FindFirstChild("ClientMotors");
			local l__Waist__22 = p4:WaitForChild("UpperTorso", 0.5):WaitForChild("Waist", 0.5);
			local l__Neck__23 = p4:WaitForChild("Head", 0.5):WaitForChild("Neck", 0.5);
			local l__Root__24 = p4:WaitForChild("LowerTorso", 0.5):WaitForChild("Root", 0.5);
			local l__RightShoulder__25 = p4:WaitForChild("RightUpperArm", 0.5):WaitForChild("RightShoulder", 0.5);
			local l__LeftShoulder__26 = p4:WaitForChild("LeftUpperArm", 0.5):WaitForChild("LeftShoulder", 0.5);
			local l__Value__27 = l__Root__24:WaitForChild("CVal").Value;
			local l__Value__28 = l__Waist__22:WaitForChild("CVal").Value;
			local l__Value__29 = l__Neck__23:WaitForChild("CVal").Value;
			local l__Value__30 = l__LeftShoulder__26:WaitForChild("CVal").Value;
			local l__Value__31 = l__RightShoulder__25:WaitForChild("CVal").Value;
			local v32 = v16 * CFrame.Angles(0, math.rad(p5 * -45), 0);
			local v33 = v15 * CFrame.Angles(math.rad(p6 * 0.25), 0, 0) * CFrame.Angles(0, math.rad(p5 * 45), 0) * CFrame.Angles(0, 0, math.rad(p7));
			local v34 = v17 * CFrame.Angles(math.rad(p6 * 0.5), 0, 0);
			local v35 = v19 * CFrame.Angles(math.rad(p6 * -0.025), 0, 0);
			local v36 = v18 * CFrame.Angles(math.rad(p6 * -0.025), 0, 0);
			if not l__ClientMotors__21 then
				local v37 = Instance.new("BoolValue");
				v37.Name = "ClientMotors";
				v37.Parent = p4;
			end;
			if p4.Humanoid:GetAttribute("Stunned") == true then
				if l__HumanoidRootPart__20 then
					l__Waist__22.Enabled = false;
					l__Neck__23.Enabled = false;
					l__Root__24.Enabled = false;
					l__RightShoulder__25.Enabled = false;
					l__LeftShoulder__26.Enabled = false;
					return;
				end;
			else
				l__Waist__22.Enabled = true;
				l__Neck__23.Enabled = true;
				l__Root__24.Enabled = true;
				l__RightShoulder__25.Enabled = true;
				l__LeftShoulder__26.Enabled = true;
				if l__HumanoidRootPart__20 and (l__HumanoidRootPart__20.Position - u2.cam.CFrame.p).Magnitude > 100 then
					l__Root__24.C0 = v32;
					l__Waist__22.C0 = v33;
					l__Neck__23.C0 = v34;
					l__LeftShoulder__26.C0 = v35;
					l__RightShoulder__25.C0 = v36;
					return;
				end;
				if l__HumanoidRootPart__20 then
					local v38 = {};
					local v39 = {};
					local v40 = {};
					local v41 = {};
					local v42 = {};
					v38.C0 = v32;
					v39.C0 = v33;
					v40.C0 = v34;
					v41.C0 = v35;
					v42.C0 = v36;
					l__TweenService__6:Create(l__Root__24, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), v38):Play();
					l__TweenService__6:Create(l__Waist__22, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), v39):Play();
					l__TweenService__6:Create(l__Neck__23, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), v40):Play();
					l__TweenService__6:Create(l__RightShoulder__25, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), v42):Play();
					l__TweenService__6:Create(l__LeftShoulder__26, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), v41):Play();
				end;
			end;
		end;
	end);
end);
l__EntityInfo__1:WaitForChild("SoundToClient").OnClientEvent:Connect(function(p8, p9, p10, p11)
	if p8 and p9 then
		u2.playaudio(p8, p9, p10, p11);
	end;
end);
local u3 = {};
l__EntityInfo__1:WaitForChild("UseEnemyModule").OnClientEvent:Connect(function(p12, p13, ...)
	if not u3[p12] then
		u3[p12] = require(game:GetService("ReplicatedStorage").ClientModules.EntityModules:FindFirstChild(p12));
	end;
	u3[p12][p13](u2, ...);
end);
l__EntityInfo__1:WaitForChild("UseEventModule").OnClientEvent:Connect(function(p14, ...)
	v7[p14](...);
end);
l__EntityInfo__1:WaitForChild("ReplicateAnimation").OnClientEvent:Connect(function(p15, p16, p17, p18, p19, p20, p21, p22)
	local v43 = game.ReplicatedStorage.AnimationRoot:Clone();
	local v44 = p15.Humanoid.Animator:LoadAnimation(v43.Animation);
	v43:SetPrimaryPartCFrame(p15.PrimaryPart.CFrame);
	v43.Parent = u2.cam;
	l__TweenService__6:Create(v43.PrimaryPart, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		CFrame = p17
	}):Play();
	local v45 = nil;
	local v46 = v43.AnimationController:LoadAnimation(p16);
	local v47 = p15.Humanoid.Animator:LoadAnimation(p16);
	local v48 = nil;
	local v49 = nil;
	if p22 then
		v48 = v43.AnimationController:LoadAnimation(p22);
		v49 = p15.Humanoid.Animator:LoadAnimation(p22);
	end;
	local v50 = false;
	if u2.char == p15 then
		u2.stopcam = true;
		v50 = true;
		u2.hum:UnequipTools();
		u2.crouch(false);
	end;
	if p19 and p20 then
		p20 = p19:LoadAnimation(p20);
		if v50 then
			v45 = p19.Parent:FindFirstChild("CamAttach", true);
			if v45 then
				v45 = v45.WorldCFrame;
				u2.hideplayers = -1;
			end;
		end;
	end;
	for v51 = 1, 1000 do
		if v47.Length > 0 then
			if p20 == nil then
				break;
			end;
			if p20.Length > 0 then
				break;
			end;
		end;
		task.wait();
	end;
	v47:Play(0, 1, 1);
	v44:Play(0, 1, 1);
	v46:Play(0, 1, 1);
	if p22 then
		v48:Play(0, 1, 1);
		v49:Play(0, 1, 1);
	end;
	if p19 and p20 then
		p20:Play(0, 1, 1);
	end;
	local l__CFrame__52 = p15.PrimaryPart.CFrame;
	local l__CFrame__53 = u2.cam.CFrame;
	local u4 = false;
	local u5 = tick();
	task.spawn(function()
		for v54 = 1, 100000 do
			task.wait();
			if u4 then
				break;
			end;
			local v55 = l__TweenService__6:GetValue((tick() - u5) * 4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
			if v45 then
				v55 = l__TweenService__6:GetValue((tick() - u5) / 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
			end;
			p15.PrimaryPart.CFrame = p15.PrimaryPart.CFrame:Lerp(v43.LowerTorso.CFrame * CFrame.new(0, 0.96, 0), v55);
			if v50 then
				local v56
				if v45 then
					v56 = v45;
				else
					v56 = p15.Head.CFrame * CFrame.new(0, 0.4, -0.3) * CFrame.Angles(math.rad(math.clamp(u2.bobspring.p.Y, -80, 80)), math.rad(math.clamp(u2.bobspring.p.X, -80, 80)), math.rad(math.clamp(u2.bobspring.p.Z, -40, 40))) * CFrame.Angles(0, math.rad(u2.camlockedoffset[1]), 0) * CFrame.Angles(math.rad(u2.camlockedoffset[2]), 0, 0) * u2.csgo;
				end;
				u2.cam.CFrame = u2.cam.CFrame:Lerp(v56, v55);
			end;
		end;
	end);
	if p21 and p22 then
		for v57 = 1, 10000000 do
			task.wait(0.05);
			if p15.Humanoid:GetAttribute(p21) ~= true then
				break;
			end;
		end;
	else
		task.wait(v47.Length - 0.1);
	end;
	u4 = true;
	l__TweenService__6:Create(p15.PrimaryPart, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		CFrame = p18
	}):Play();
	v47:AdjustWeight(0.01);
	v47:AdjustSpeed(0.01);
	v47:Stop(0);
	v46:Stop(0);
	v44:Stop(0);
	if p22 then
		v48:Stop(0.3, 1, 1);
		v49:Stop(0, 1, 1);
	end;
	v43:Destroy();
	if v50 and not p22 then
		local v58 = tick();
		local l__CFrame__59 = u2.cam.CFrame;
		if not p15:GetAttribute("Hiding") then
			u2.camlockedoffset = { 0, 0 };
		end;
		for v60 = 1, 10000 do
			u2.cam.CFrame = l__CFrame__59:Lerp(u2.basecamcf * u2.csgo, (l__TweenService__6:GetValue((tick() - v58) * 4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)));
			task.wait();
			if v58 + 0.25 <= tick() then
				break;
			end;
		end;
		u2.stopcam = false;
		u2.crouch(false);
		if v45 then
			u2.hideplayers = 0;
		end;
	end;
end);
local u6 = false;
l__EntityInfo__1:WaitForChild("Jumpscare").OnClientEvent:Connect(function(p23, run_id)
	if u6 == true and run_id ~= "Admin Panel" then
		return;
	end;
	u6 = true;
	v1.MainFrame.Heartbeat.Visible = false;
	if p23 == "Seek" then
		u2.freemouse = true
		
		u2.deathtick = tick() + 0.5;
		if workspace:FindFirstChild("SeekMoving", true) then
			local l__SeekMoving__61 = workspace:FindFirstChild("SeekMoving", true);
			u2.stopcam = true;
			u2.fovtarget = 40;
			local v62 = tick();
			for v63 = 1, 10000 do
				u2.cam.CFrame = (u2.basecamcf * u2.csgo):Lerp(l__SeekMoving__61.PrimaryPart.CamAttach.WorldCFrame, (l__TweenService__6:GetValue((tick() - v62) * 4, Enum.EasingStyle.Sine, Enum.EasingDirection.In)));
				task.wait();
				if v62 + 0.25 <= tick() then
					break;
				end;
			end;
		else
			warn("cant find seekmoving");
		end;
		script.Jumpscare_Seek:Play();
		v1.Jumpscare.Jumpscare_Seek.Visible = true;
		local v64 = tick();
		for v65 = 1, 1000 do
			local v66 = math.clamp((tick() - v64) * 2, 0.1, 1);
			v1.Jumpscare.Jumpscare_Seek.ImageLabel.Position = UDim2.new(0.5 + math.random(-100, 100) / (5000 * v66), 0, 0.5 + math.random(-100, 100) / (2500 * v66), 0);
			v1.Jumpscare.Jumpscare_Seek.BackgroundColor3 = Color3.new(math.random(0, 4) / 12, 0, 0);
			game["Run Service"].RenderStepped:wait();
			if v64 + 0.7 <= tick() then
				break;
			end;
		end;
		u2.stopcam = false;
		script.Jumpscare_Seek:Stop();
		script.Kill:Play();
		v1.Jumpscare.Jumpscare_Seek.ImageLabel.Visible = false;
		for v67 = 1, 4 do
			v1.Jumpscare.Jumpscare_Seek.BackgroundColor3 = Color3.new(math.random(0, 1), 0, 0);
			wait();
		end;
		v1.Jumpscare.Jumpscare_Seek.Visible = false;
		u2.deathtick = tick();
		u2.fovtarget = 70;
		return;
	end;
	if p23 == "Rush" then
		u2.freemouse = true
		
		u2.deathtick = tick() + 10;
		script.Jumpscare_Rush:Play();
		v1.Jumpscare.Jumpscare_Rush.Visible = true;
		local v68 = tick();
		local v69 = math.random(5, 30) / 10;
		local v70 = v69 + math.random(10, 60) / 10;
		local v71 = 0.25;
		for v72 = 1, 100000 do
			task.wait();
			if v68 + v69 <= tick() then
				v1.Jumpscare.Jumpscare_Rush.ImageLabel.Visible = true;
				v69 = v69 + math.random(7, 44) / 10;
				script.Jumpscare_Rush.Pitch = 1 + math.random(-100, 100) / 500;
				v1.Jumpscare.Jumpscare_Rush.BackgroundColor3 = Color3.new(0, 0, math.random(0, 10) / 255);
				v1.Jumpscare.Jumpscare_Rush.ImageLabel.Position = UDim2.new(0.5, math.random(-2, 2), 0.5, math.random(-2, 2));
				v71 = v71 + 0.05;
				v1.Jumpscare.Jumpscare_Rush.ImageLabel.Size = UDim2.new(v71, 0, v71, 0);
			end;
			if v68 + v70 <= tick() then
				break;
			end;
		end;
		v1.Jumpscare.Jumpscare_Rush.ImageLabel.Visible = true;
		script.Jumpscare_Rush:Stop();
		script.Jumpscare_Rush2:Play();
		v1.Jumpscare.Jumpscare_Rush.ImageLabel.Visible = false;
		v1.Jumpscare.Jumpscare_Rush.ImageLabelBig.Visible = true;
		v1.Jumpscare.Jumpscare_Rush.ImageLabelBig:TweenSize(UDim2.new(2.5, 0, 2.5, 0), "In", "Sine", 0.3, true);
		local v73 = tick();
		for v74 = 1, 1000 do
			local v75 = math.random(0, 10) / 10;
			v1.Jumpscare.Jumpscare_Rush.BackgroundColor3 = Color3.new(v75, v75, math.clamp(math.random(25, 50) / 50, v75, 1));
			v1.Jumpscare.Jumpscare_Rush.ImageLabelBig.Position = UDim2.new(0.5 + math.random(-100, 100) / 5000, 0, 0.5 + math.random(-100, 100) / 3000, 0);
			task.wait(0.016666666666666666);
			if v73 + 0.3 <= tick() then
				break;
			end;
		end;
		v1.Jumpscare.Jumpscare_Rush.ImageLabelBig.Visible = false;
		v1.Jumpscare.Jumpscare_Rush.BackgroundColor3 = Color3.new(0, 0, 0);
		v1.Jumpscare.Jumpscare_Rush.Visible = false;
		u2.deathtick = tick();
		return;
	end;
	if p23 == "Blitz" then
		u2.freemouse = true

		u2.deathtick = tick() + 10;
		script.Jumpscare_Blitz:Play();
		v1.Jumpscare.Jumpscare_Blitz.Visible = true;
		local v76 = tick();
		local v77 = math.random(5, 30) / 100;
		local v78 = v77 + math.random(10, 60) / 100;
		local v79 = 0.2;
		for v80 = 1, 100000 do
			task.wait(0.016666666666666666);
			v1.Jumpscare.Jumpscare_Blitz.ImageLabel.Position = UDim2.new(0.5, math.random(-15, 15), 0.5, math.random(-15, 15));
			v1.Jumpscare.Jumpscare_Blitz.BackgroundColor3 = Color3.new(0, math.random(4, 10) / 255, math.random(0, 3) / 255);
			if v76 + v77 <= tick() then
				v1.Jumpscare.Jumpscare_Blitz.ImageLabel.Visible = true;
				v77 = v77 + math.random(7, 44) / 100;
				script.Jumpscare_Blitz.Pitch = math.random(35, 155) / 100;
				v1.Jumpscare.Jumpscare_Blitz.BackgroundColor3 = Color3.new(0, math.random(4, 10) / 255, math.random(0, 3) / 255);
				v1.Jumpscare.Jumpscare_Blitz.ImageLabel.Position = UDim2.new(0.5, math.random(-25, 25), 0.5, math.random(-25, 25));
				v79 = v79 + 0.05;
				v1.Jumpscare.Jumpscare_Blitz.ImageLabel.Size = UDim2.new(v79, 0, v79, 0);
			end;
			if v76 + v78 <= tick() then
				break;
			end;
		end;
		v1.Jumpscare.Jumpscare_Blitz.ImageLabel.Visible = true;
		v1.Jumpscare.Jumpscare_Blitz.ImageLabel:TweenSize(UDim2.new(9, 0, 9, 0), "In", "Quart", 0.3, true);
		local v81 = tick();
		for v82 = 1, 100 do
			local v83 = math.random(0, 10) / 10;
			v1.Jumpscare.Jumpscare_Blitz.BackgroundColor3 = Color3.new(v83, math.clamp(math.random(25, 50) / 50, v83, 1), math.clamp(math.random(25, 50) / 150, v83, 1));
			game["Run Service"].RenderStepped:wait();
			if v81 + 0.3 <= tick() then
				break;
			end;
		end;
		script.Jumpscare_Blitz:Stop();
		v1.Jumpscare.Jumpscare_Blitz.ImageLabel.Visible = false;
		v1.Jumpscare.Jumpscare_Blitz.BackgroundColor3 = Color3.new(0, 0, 0);
		v1.Jumpscare.Jumpscare_Blitz.Visible = false;
		u2.deathtick = tick();
		return;
	end;
	if p23 == "Ambush" then
		u2.freemouse = true
		
		u2.deathtick = tick() + 10;
		script.Jumpscare_Ambush:Play();
		v1.Jumpscare.Jumpscare_Ambush.Visible = true;
		local v76 = tick();
		local v77 = math.random(5, 30) / 100;
		local v78 = v77 + math.random(10, 60) / 100;
		local v79 = 0.2;
		for v80 = 1, 100000 do
			task.wait(0.016666666666666666);
			v1.Jumpscare.Jumpscare_Ambush.ImageLabel.Position = UDim2.new(0.5, math.random(-15, 15), 0.5, math.random(-15, 15));
			v1.Jumpscare.Jumpscare_Ambush.BackgroundColor3 = Color3.new(0, math.random(4, 10) / 255, math.random(0, 3) / 255);
			if v76 + v77 <= tick() then
				v1.Jumpscare.Jumpscare_Ambush.ImageLabel.Visible = true;
				v77 = v77 + math.random(7, 44) / 100;
				script.Jumpscare_Ambush.Pitch = math.random(35, 155) / 100;
				v1.Jumpscare.Jumpscare_Ambush.BackgroundColor3 = Color3.new(0, math.random(4, 10) / 255, math.random(0, 3) / 255);
				v1.Jumpscare.Jumpscare_Ambush.ImageLabel.Position = UDim2.new(0.5, math.random(-25, 25), 0.5, math.random(-25, 25));
				v79 = v79 + 0.05;
				v1.Jumpscare.Jumpscare_Ambush.ImageLabel.Size = UDim2.new(v79, 0, v79, 0);
			end;
			if v76 + v78 <= tick() then
				break;
			end;
		end;
		script.Jumpscare_Ambush2:Play();
		v1.Jumpscare.Jumpscare_Ambush.ImageLabel.Visible = true;
		v1.Jumpscare.Jumpscare_Ambush.ImageLabel:TweenSize(UDim2.new(9, 0, 9, 0), "In", "Quart", 0.3, true);
		local v81 = tick();
		for v82 = 1, 100 do
			local v83 = math.random(0, 10) / 10;
			v1.Jumpscare.Jumpscare_Ambush.BackgroundColor3 = Color3.new(v83, math.clamp(math.random(25, 50) / 50, v83, 1), math.clamp(math.random(25, 50) / 150, v83, 1));
			game["Run Service"].RenderStepped:wait();
			if v81 + 0.3 <= tick() then
				break;
			end;
		end;
		script.Jumpscare_Ambush:Stop();
		v1.Jumpscare.Jumpscare_Ambush.ImageLabel.Visible = false;
		v1.Jumpscare.Jumpscare_Ambush.BackgroundColor3 = Color3.new(0, 0, 0);
		v1.Jumpscare.Jumpscare_Ambush.Visible = false;
		u2.deathtick = tick();
		return;
	end;
	if p23 == "Figure" then
		l__TweenService__6:Create(game.SoundService.Main, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Volume = 0
		}):Play();
		local l__FigureSetup__84 = workspace:FindFirstChild("FigureSetup", true);
		if workspace:FindFirstChild("FigureSetup", true) then
			local v85 = u2.cam;
			if l__FigureSetup__84 then
				v85 = l__FigureSetup__84.Parent;
			end;
			u2.stopcam = true;
			u2.fovtarget = 80;
			script.Reverse:Play();
			script.Figure_Growl:Play();
			local v86 = game:GetService("ReplicatedStorage"):WaitForChild("JumpscareModels"):WaitForChild("Figure"):Clone();
			if l__FigureSetup__84 then
				l__FigureSetup__84.Parent = game:GetService("ReplicatedStorage");
				v86:SetPrimaryPartCFrame(l__FigureSetup__84.FigureRagdoll.PrimaryPart.CFrame);
			else
				v86:SetPrimaryPartCFrame(u2.cam.CFrame);
			end;
			v86.Parent = u2.cam;
			v86:WaitForChild("AnimationController"):LoadAnimation(v86:WaitForChild("Jumpscare")):Play(0, 1, 1);
			game.Debris:AddItem(v86, 10);
			local l__OriginalCFrame__87 = script:WaitForChild("OriginalCFrame");
			l__OriginalCFrame__87.Value = u2.cam.CFrame;
			l__TweenService__6:Create(l__OriginalCFrame__87, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				Value = v86:WaitForChild("CamSpot").CFrame
			}):Play();
			u2.camShaker:ShakeOnce(20, 12, 0, 0.2);
			u2.camShaker:ShakeOnce(2, 24, 0.1, 0.5, Vector3.new(0, 0, 0), Vector3.new(3, 1, 3));
			u2.camShaker:ShakeOnce(8, 25, 0.7, 1, Vector3.new(0, 0, 0));
			local v88 = tick();
			delay(0.55, function()
				u2.camShaker:ShakeOnce(1, 35, 0.01, 1, Vector3.new(0, 0, 0), Vector3.new(3, 1, 3));
			end);
			for v89 = 1, 1000 do
				game["Run Service"].RenderStepped:wait();
				u2.cam.CFrame = l__OriginalCFrame__87.Value * u2.csgo;
				if v88 + 0.8 <= tick() then
					break;
				end;
			end;
			if l__FigureSetup__84 then
				l__FigureSetup__84.Parent = v85;
			end;
			v86:Destroy();
		end;
		script.Kill:Play();
		v1.FlashFrame.Visible = true;
		for v90 = 1, 8 do
			v1.FlashFrame.BackgroundColor3 = Color3.new(math.random(0, 1), 0, 0);
			wait();
		end;
		v1.FlashFrame.BackgroundColor3 = Color3.new(0, 0, 0);
		u2.cam.CameraType = Enum.CameraType.Scriptable;
		u2.stopcam = false;
		u2.deathtick = tick();
		v1.FlashFrame.Visible = false;
	end;
end);

local CamVal

l__EntityInfo__1.RenderCamOffset.OnClientEvent:Connect(function(p1)
	u2.ax_t = p1
	u2.ax = p1
end)

l__EntityInfo__1.RenderCamStop.OnClientEvent:Connect(function(p1)
	CamVal:Disconnect()
end)

l__EntityInfo__1.RenderCamMiddle.OnClientEvent:Connect(function()
	v1.MainFrame.HideVignette.Visible = false;
end)

l__EntityInfo__1.RenderCam.OnClientEvent:Connect(function(p1, p2)
	
	u2.ax_t = p1
	u2.ax = p1
	
	local camera = workspace.CurrentCamera
	local head = u2.char:WaitForChild("Head")
	
	CamVal = game:GetService("RunService").RenderStepped:Connect(function()
		camera.CFrame = head.CFrame
	end)
	
	task.wait(0.8) -- 0.75
	
	v1.MainFrame.HideVignette.ImageTransparency = 1;
	v1.MainFrame.HideVignette.Visible = true;
	l__TweenService__6:Create(v1.MainFrame.HideVignette, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		ImageTransparency = 0
	}):Play();
	
	u2.ax_t = p2
	u2.ax = p2
end) 

l__EntityInfo__1:WaitForChild("Cutscene").OnClientEvent:Connect(function(p24)
	local v91 = script.Cutscenes:FindFirstChild(p24);
	if v91 then
		require(v91)(u2);
	end;
end);
l__EntityInfo__1:WaitForChild("GetOutOfHiding").OnClientEvent:Connect(function()
	u2.char:SetAttribute("Hiding", true);
	u2.char:SetAttribute("Hiding", false);
end);
u2.char:GetAttributeChangedSignal("Hiding"):Connect(function()
	if u2.char:GetAttribute("Hiding") == true then
		for v88 = 1, 100000 do
			task.wait(0.1);
			if u2.char:GetAttribute("Hiding") == false then
				u2.ax_t = u2.ax_t + u2.camlockedoffset[1] % 360;
				u2.ay_t = math.clamp(u2.ay_t + u2.camlockedoffset[2], -65, 65);
				if math.abs(u2.ax_t) > 180 then
					u2.ax_t = u2.ax_t - 360;
					u2.ax_t = u2.ax_t;
				end;
				if math.abs(u2.ax) > 180 then
					u2.ax = u2.ax - 360;
					u2.ax = u2.ax;
				end;
				u2.camShaker:ShakeOnce(8, 1, 0, 1, Vector3.new(0, 0, 0));
				u2.camlock = nil;
				--game:GetService("ReplicatedStorage").RemotesFolder.CamLock:FireServer();
				v1.HideVignette.Visible = false;
				return;
			end;
		end;
	end;
end);
l__EntityInfo__1:WaitForChild("CamLock").OnClientEvent:Connect(function(p23)
	local v89, v90, v91 = CFrame.new(Vector3.new(0, 0, 0), p23):ToOrientation();
	if math.abs(u2.ax - math.deg(v90)) > 180 then
		u2.ax_t = u2.ax_t - 360;
		u2.ax = u2.ax_t;
	end;
	u2.camlock = {
		y = math.deg(v89), 
		x = math.deg(v90), 
		z = 0, 
		last = tick() + 1, 
		pos = u2.char.PrimaryPart.Position
	};
	u2.camlockHead = false;
	v1.HideVignette.ImageTransparency = 1;
	v1.HideVignette.Visible = true;
	l__TweenService__6:Create(v1.HideVignette, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		ImageTransparency = 0
	}):Play();
	u2.camShaker:ShakeOnce(12, 1, 0, 1, Vector3.new(0, 0, 0));
end);

l__EntityInfo__1:WaitForChild("CamLockHead").OnClientEvent:Connect(function(p24)
	local v92, v93, v94 = CFrame.new(Vector3.new(0, 0, 0), p24):ToOrientation();
	if math.abs(u2.ax - math.deg(v93)) > 180 then
		u2.ax_t = u2.ax_t - 360;
	end;
	u2.camlockHead = true;
	u2.camlock = {
		y = math.deg(v92), 
		x = math.deg(v93), 
		z = 0, 
		last = tick() + 1, 
		pos = u2.char.PrimaryPart.Position
	};
end);
l__EntityInfo__1:WaitForChild("CamShake").OnClientEvent:Connect(function(p27, p28, p29, p30, p31, p32)
	u2.camShaker:ShakeOnce(p27, p28, p29, p30, p31, p32);
end);
l__EntityInfo__1:WaitForChild("ChangeModuleVariable").OnClientEvent:Connect(function(p33, p34)
	u2[p33] = p34;
end);
for v99, v100 in pairs(script:WaitForChild("Modules"):GetChildren()) do
	local l__Name__7 = v100.Name;
	task.spawn(function()
		l__EntityInfo__1:WaitForChild(l__Name__7).OnClientEvent:Connect(function(...)
			require(script:WaitForChild("Modules"):WaitForChild(l__Name__7, 1))(u2, ...);
		end);
	end);
end;
function u2.shakerel(p35, p36, p37, p38, p39, p40, p41)
	local v101 = nil;
	v101 = 0;
	for v102 = 1, 2 do
		local v103 = 100;
		if v102 == 2 then
			v103 = 30;
		end;
		v101 = v101 + math.abs(math.clamp((u2.cam.CFrame.Position - p35).Magnitude, 0, v103) - v103) / v103;
	end;
	u2.camShaker:ShakeOnce(p36 * v101 * 0.8, p37, p38, p39, p40, p41);
end;
l__EntityInfo__1:WaitForChild("CamShakeRelative").OnClientEvent:Connect(u2.shakerel)
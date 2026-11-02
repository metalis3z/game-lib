local l__LocalPlayer__1 = game.Players.LocalPlayer;
local v2 = require(l__LocalPlayer__1:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local v3 = game["Run Service"];
local l__mouse__4 = l__LocalPlayer__1:GetMouse();
local v5 = {};
local u1 = require(script.Parent);
local l__TweenService__2 = game:GetService("TweenService");
local l__MinigameBackout__3 = script:FindFirstAncestor("MainUI").MinigameBackout;
local l__UserInputService__4 = game:GetService("UserInputService");
local l__Parent__5 = script.Parent.Parent.Parent;
local u6 = 1;
local function u7(p1)
	local rev_p1 = p1
	local cp1 = {}
	for v6 = #rev_p1, 1, -1 do
		local v7 = math.random(1, #rev_p1);
		local v9191 = rev_p1[v7]
		table.insert(cp1, v9191)
		table.remove(rev_p1, v7)
	end;
	return cp1
end;
local function u8(p2)
	if u1.stopcam == true then
		return;
	end;
	u1.hum:UnequipTools();
	if p2 == "Padlock" then
		require(script.Padlock)(u1);
	end;
	if p2 == "ElevatorBreaker" then
		u1.stopcam = true;
		u1.freemouse = true;
		u1.hideplayers = 2;
		local v8 = CFrame.new(0, 0, 0);
		local v9 = tick() + 2;
		local l__WorldCFrame__10 = workspace:FindFirstChild("ElevatorBreakerCameraCFrame", true).WorldCFrame;
		u1.camShaker:ShakeOnce(2, 0.5, 0.5, 8);
		local l__CFrame__9 = u1.cam.CFrame;
		local l__FieldOfView__10 = u1.cam.FieldOfView;
		local u11 = false;
		task.spawn(function()
			for v11 = 1, 100000 do
				task.wait();
				local v12 = l__TweenService__2:GetValue((2 - math.abs(tick() - v9)) / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
				if not (tick() <= v9) then
					break;
				end;
				u1.cam.CFrame = l__CFrame__9:Lerp(l__WorldCFrame__10, v12) * u1.csgo;
				u1.cam.FieldOfView = l__FieldOfView__10 + (57 - l__FieldOfView__10) * v12;
			end;
			u1.cam.CFrame = l__WorldCFrame__10 * u1.csgo;
			for v13 = 1, 10000000000000 do
				task.wait();
				u1.cam.CFrame = l__WorldCFrame__10 * u1.csgo;
				if u11 == true then
					break;
				end;
			end;
		end);
		wait(1);
		u1.char.PrimaryPart.Anchored = true;
		local l__ElevatorBreaker__14 = workspace:FindFirstChild("ElevatorBreaker", true);
		local l__ActivateEventPrompt__15 = l__ElevatorBreaker__14:FindFirstChild("ActivateEventPrompt");
		l__ActivateEventPrompt__15.Parent = nil;
		local v16 = l__ElevatorBreaker__14:Clone();
		v16.Parent = l__ElevatorBreaker__14.Parent;
		l__ActivateEventPrompt__15.Parent = v16;
		l__ActivateEventPrompt__15.Enabled = false;
		local l__Selector__17 = v16.XBoxUI:FindFirstChild("Selector", true);
		v16.XBoxUI.Enabled = u1.controller == "console";
		l__ElevatorBreaker__14:Destroy();
		v16:WaitForChild("DoorHinge").TargetAngle = 135;
		local l__Door__18 = v16.Door;
		l__Door__18.CFrame = l__Door__18.CFrame + Vector3.new(0, 0.05, 0);
		local l__SurfaceGui__19 = v16:WaitForChild("SurfaceGui");
		local u12 = {};
		local function v20()
			local v21 = 0;
			for v22, v23 in pairs(v16:GetChildren()) do
				if v23.Name == "BreakerSwitch" then
					local v24 = v23:GetAttribute("ID");
					local v25 = v23:GetAttribute("Enabled");
					for v26, v27 in pairs(u12) do
						if v27[1] == v24 and v27[2] == v25 then
							v21 = v21 + 1;
						end;
					end;
				end;
			end;
			return v21;
		end;
		local u13 = nil;
		local u14 = nil;
		local function u15(p3, p4)
			if p4 == nil then
				p4 = not p3:GetAttribute("Enabled");
			end;
			if p3:GetAttribute("Enabled") ~= p4 then
				p3.Sound:Play();
			end;
			p3:SetAttribute("Enabled", p4);
			if p3:GetAttribute("Enabled") == true then
				p3:FindFirstChild("PrismaticConstraint", true).TargetPosition = -0.2;
				p3.Light.Material = Enum.Material.Neon;
				p3.Light.Attachment.Spark:Emit(1);
				p3.Sound.Pitch = 1.3;
			else
				p3:FindFirstChild("PrismaticConstraint", true).TargetPosition = 0.2;
				p3.Light.Material = Enum.Material.Glass;
				p3.Sound.Pitch = 1.2;
			end;
			p3.Sound:Play();
		end;
		local u16 = 1;
		local v29 = tick()
		local function u17(p5)
			if u11 == false then
				pcall(function()
					u13:Disconnect();
					u14:Disconnect();
				end);
				u11 = true;
				l__MinigameBackout__3.Visible = false;
				v16.XBoxUI.Enabled = false;
				u1.hideplayers = 0;
				v16:WaitForChild("DoorHinge").TargetAngle = 0;
				local l__basecamcf__28 = u1.basecamcf;
				local v29 = tick() + 0.5;
				u1.camShaker:ShakeOnce(2, 0.5, 0.5, 8);
				if p5 == true then
					wait(2);
					l__ActivateEventPrompt__15.Enabled = true;
					return;
				end;
			else
				return;
			end;
			u1.char.PrimaryPart.Anchored = false;
			local l__CFrame__18 = u1.cam.CFrame;
			local l__FieldOfView__19 = u1.cam.FieldOfView;
			task.spawn(function()
				for v30 = 1, 100000 do
					task.wait();
					local v31 = l__TweenService__2:GetValue((0.5 - math.abs(tick() - v29)) / 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
					if not (tick() <= v29) then
						break;
					end;
					u1.cam.CFrame = l__CFrame__18:Lerp(u1.basecamcf, v31) * u1.csgo;
					u1.cam.FieldOfView = l__FieldOfView__19 + (u1.fovspring - l__FieldOfView__19) * v31;
				end;
				u1.stopcam = false;
				u1.freemouse = false;
				wait(2);
				l__ActivateEventPrompt__15.Enabled = true;
			end);
		end;
		u13 = l__UserInputService__4.InputBegan:Connect(function(p6)
			if p6.UserInputType == Enum.UserInputType.MouseButton1 or p6.UserInputType == Enum.UserInputType.Touch then
				local v32 = u1.cam:ScreenPointToRay(p6.Position.X, p6.Position.Y);
				local v33, v34 = workspace:FindPartOnRay(Ray.new(v32.Origin, v32.Direction * 1000), u1.char);
				if v33.Name == "BreakerSwitch" then
					u15(v33);
					u1.camShaker:ShakeOnce(0.5, 2, 0.06, 0.2);
					return;
				end;
			elseif p6.KeyCode == Enum.KeyCode.DPadUp or p6.KeyCode == Enum.KeyCode.DPadDown or p6.KeyCode == Enum.KeyCode.DPadLeft or p6.KeyCode == Enum.KeyCode.DPadRight then
				local v35 = math.floor(u16 / 2);
				if p6.KeyCode == Enum.KeyCode.DPadLeft and u16 % 2 == 0 then
					u16 = math.clamp(u16 - 1, 0, 10);
				end;
				if p6.KeyCode == Enum.KeyCode.DPadRight and u16 % 2 ~= 0 then
					u16 = math.clamp(u16 + 1, 0, 10);
				end;
				if p6.KeyCode == Enum.KeyCode.DPadUp then
					u16 = math.clamp(u16 - 2, 0, 10);
				end;
				if p6.KeyCode == Enum.KeyCode.DPadDown then
					u16 = math.clamp(u16 + 2, 0, 10);
				end;
				v16.XBoxUI.Enabled = true;
				for v36, v37 in pairs(v16.XBoxUI:GetChildren()) do
					if v37:GetAttribute("ID") == u16 then
						l__Selector__17.Parent = v37;
					end;
				end;
				return;
			elseif p6.KeyCode == Enum.KeyCode.ButtonA or p6.KeyCode == Enum.KeyCode.ButtonX then
				for v38, v39 in pairs(v16:GetChildren()) do
					if v39.Name == "BreakerSwitch" and v39:GetAttribute("ID") == u16 then
						u15(v39);
					end;
				end;
				return;
			elseif p6.KeyCode == Enum.KeyCode.ButtonB then
				u17();
			end;
		end);
		local l__MinigameBackout__40 = l__Parent__5.MinigameBackout;
		l__MinigameBackout__40.Visible = true;
		l__TweenService__2:Create(l__MinigameBackout__40, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 3, true), {
			ImageColor3 = Color3.fromRGB(107, 129, 179), 
			Size = UDim2.new(0.1, 60, 0.1, 60)
		}):Play();
		u14 = l__MinigameBackout__40.MouseButton1Down:Connect(u17);
		game.ReplicatedStorage.EntityInfo.Cutscene.OnClientEvent:Connect(function()
			u17(true);
		end);
		spawn(function()
			for v41, v42 in pairs(v16:GetChildren()) do
				if v42.Name == "BreakerSwitch" and v42:IsA("BasePart") then
					delay(v42:GetAttribute("ID") / 20, function()
						l__TweenService__2:Create(v42, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 1, true), {
							Color = Color3.fromRGB(159, 159, 221)
						}):Play();
					end);
				end;
			end;
		end);
		wait(3);
		for v43 = u6, 3 do
			u6 = v43;
			local v44 = 0;
			for v45 = 1, 10 do
				local v46 = math.random(1, 8) >= 4; -- 6
				if v45 >= 6 and v44 <= 2 then
					v46 = true;
				end;
				if v44 >= 5 then
					v46 = false;
				end;
				if v46 then
					v44 = v44 + 1;
				end;
				u12[v45] = { v45, v46 };
			end;
			u12 = u7(u12, v43);
			warn(u12, v43)
			if v43 == 3 then
				u12[10][2] = true;
			end;
			for v47 = 1, 100 do
				if v47 ~= 1 then
					u12 = u7(u12);
				end;
				l__SurfaceGui__19.Frame.Code.Frame.Visible = true;
				for v48, v49 in pairs(u12) do
					local v52 = v49
					local v51 = v48
					if v43 == 3 and v51 == 10 then
						l__SurfaceGui__19.Frame.Code.Text = "??";
					else
						l__SurfaceGui__19.Frame.Code.Text = string.format("%.2i", v52[1]);
					end;
					if v52[2] == true then
						l__SurfaceGui__19.Frame.Code.Frame.BackgroundTransparency = 0;
						v16.Box.Beep.Pitch = 1.5;
					else
						l__SurfaceGui__19.Frame.Code.Frame.BackgroundTransparency = 1;
						v16.Box.Beep.Pitch = 1;
					end;
					v16.Box.Beep:Play();
					task.wait(1.2 - v43 / 5);
					if u11 == true then
						break;
					end;				
				end;
				if u11 == true then
					break;
				end;
				wait(2);
				if v43 == 3 then
					wait(1);
				end;
				local v53 = v20();
				l__SurfaceGui__19.Frame.Code.Text = "...";
				l__SurfaceGui__19.Frame.Code.Frame.Visible = false;
				l__SurfaceGui__19.Frame.Bar.Filled:TweenSize(UDim2.new(v53 / 10, 0, 1, 0), "In", "Sine", 1, true);
				v16.Box.Progress:Play();
				l__TweenService__2:Create(v16.Box.Progress, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					PlaybackSpeed = 1.01 + v53 / 10
				}):Play();
				wait(1);
				if u11 == true then
					break;
				end;
				v16.Box.Progress:Stop();
				if v53 == 10 then
					u6 = v43 + 1;
					if v43 == 3 then
						l__MinigameBackout__40.Visible = false;
					end;
					pcall(function()
						v16.Box.Correct:Play();
						u1.camShaker:ShakeOnce(1, 1, 0.06, 0.5);
						local v54 = l__SurfaceGui__19.Frame.Squares[tostring(v43)];
						v54.BackgroundTransparency = 0;
						v54.Size = UDim2.new(0, 9, 0, 9);
						v54:TweenSize(UDim2.new(0, 5, 0, 5), "In", "Quart", 0.5, true);
						l__SurfaceGui__19.Frame.Squares.Text = v43 .. "/3";
						wait(1);
						v16.Box.Progress.PlaybackSpeed = 1.01;
						l__SurfaceGui__19.Frame.Bar.Filled:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.5, true);
						if v43 == 3 then
							for v55, v56 in pairs(v16:GetChildren()) do
								if v56.Name == "BreakerSwitch" then
									delay(v56:GetAttribute("ID") / 20, function()
										u15(v56, true);
									end);
								end;
							end;
							return;
						end;
						for v57, v58 in pairs(v16:GetChildren()) do
							if v58.Name == "BreakerSwitch" then
								delay(v58:GetAttribute("ID") / 20, function()
									if v58:GetAttribute("Enabled") ~= false then
										u15(v58, false);
									end;
								end);
							end;
						end;
						wait(1.5);
					end);
					break;
				end;
			end;
			if u11 == true then
				break;
			end;
		end;
		if u11 == true then
			return;
		end;
		u1.remotes:WaitForChild("EBF"):FireServer();
		l__SurfaceGui__19.Frame.Code.Visible = false;
		l__SurfaceGui__19.Frame.Squares.Visible = false;
		l__SurfaceGui__19.Frame.Line.Visible = false;
		l__SurfaceGui__19.Frame.Bar.Visible = false;
		l__SurfaceGui__19.Frame.TextLabel.Visible = true;
		wait(1);
		u17();
	end;
end;
u1.remotes:WaitForChild("EngageMinigame").OnClientEvent:Connect(function(...)
	u8(...);
end);
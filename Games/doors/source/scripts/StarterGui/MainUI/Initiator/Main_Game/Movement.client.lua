local v1 = script:FindFirstAncestor("MainUI");
local v2 = require(script.Parent);
local v3 = require(v1.Modules.Spring);
local v4 = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local v5 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetPlatform"));
local l__UserInputService__6 = game:GetService("UserInputService");
local l__TweenService__7 = game:GetService("TweenService");
local l__Humanoid__8 = v2.char:WaitForChild("Humanoid");
local l__Animator__9 = l__Humanoid__8:WaitForChild("Animator");
local l__Collision__10 = v2.char:WaitForChild("Collision");
local l__HumanoidRootPart__11 = v2.char:WaitForChild("HumanoidRootPart");
local l__BodyGyro__12 = v2.char:WaitForChild("HumanoidRootPart"):WaitForChild("BodyGyro");
local l__Waist__13 = v2.char:WaitForChild("UpperTorso"):WaitForChild("Waist");
local l__Neck__14 = v2.char:WaitForChild("Head"):WaitForChild("Neck");
local l__Root__15 = v2.char:WaitForChild("LowerTorso"):WaitForChild("Root");
local l__RightShoulder__16 = v2.char:WaitForChild("RightUpperArm"):WaitForChild("RightShoulder");
local l__LeftShoulder__17 = v2.char:WaitForChild("LeftUpperArm"):WaitForChild("LeftShoulder");
local l__RightUpperArm__18 = v2.char:WaitForChild("RightUpperArm");
local l__LeftUpperArm__19 = v2.char:WaitForChild("LeftUpperArm");
local l__Waist__20 = v2.char:WaitForChild("UpperTorso"):WaitForChild("Waist");
local l__Neck__21 = v2.char:WaitForChild("Head"):WaitForChild("Neck");
local l__Root__22 = v2.char:WaitForChild("LowerTorso"):WaitForChild("Root");
local l__RightShoulder__23 = v2.char:WaitForChild("RightUpperArm"):WaitForChild("RightShoulder");
local l__LeftShoulder__24 = v2.char:WaitForChild("LeftUpperArm"):WaitForChild("LeftShoulder");
local v25 = Vector3.new(0, 0, 1);
local l__Animations__26 = v2.char:WaitForChild("Animations");
local v27 = Vector3.new(0, 0, 0);
local v28 = tick();
local v29 = tick();
local v30 = tick();
local v31 = OverlapParams.new();
local v32 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicaDataModule"));
local v33 = {
	Crouch = v1.MainFrame:WaitForChild("MobileButtons"):WaitForChild("CrouchButton")
};
local v34, v35 = v5();
v31.CollisionGroup = "Player";
l__Humanoid__8:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
l__Humanoid__8:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false);
l__Humanoid__8:SetStateEnabled(Enum.HumanoidStateType.Seated, false);
l__Humanoid__8:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
l__Humanoid__8:SetStateEnabled(Enum.HumanoidStateType.Jumping, false);
l__Humanoid__8:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
local v36 = {
	Walk = {}
};
for v37, v38 in pairs(l__Animations__26:GetChildren()) do
	v36[v38.Name] = v2.hum:WaitForChild("Animator"):LoadAnimation(v38);
end;
v2.an = v36;
local l__Forward__39 = v36.Forward;
v2.hum:LoadAnimation(l__Animations__26:WaitForChild("IdleAnimation")):Play(0.2, 1, 0.75);
l__Forward__39:Play(0.2, 0.01, 0.75);
local u1 = 0;
local u2 = 15;
local u3 = false;
function updatespeed()
	u1 = l__Humanoid__8:GetAttribute("SpeedBoost");
	if l__Humanoid__8:GetAttribute("SpeedBoostExtra") then
		u1 = u1 + l__Humanoid__8:GetAttribute("SpeedBoostExtra");
	end;
	v2.fovtarget = 70 + math.clamp(u1 * 2.5, 0, 20);
	if l__Humanoid__8:GetAttribute("SpeedBoostBehind") then
		u1 = u1 + l__Humanoid__8:GetAttribute("SpeedBoostBehind");
	end;
	u2 = 15;
	if u3 == true then
		u2 = 11;
	end;
	if v2.crouching == true then
		u2 = 10;
	end;
	l__Humanoid__8.WalkSpeed = u2 + tonumber(u1);
end;
l__Humanoid__8:GetAttributeChangedSignal("SpeedBoost"):Connect(updatespeed);
l__Humanoid__8:GetAttributeChangedSignal("SpeedBoostExtra"):Connect(updatespeed);
l__Humanoid__8:GetAttributeChangedSignal("SpeedBoostBehind"):Connect(updatespeed);
local u4 = v34;
local u5 = v35;
print(u5)
function v2.crouch(p1)
	local v40 = true;
	if v2.crouching == true then
		for v39, v40 in pairs((workspace:GetPartsInPart(l__Collision__10, v31))) do
			if v40.CollisionGroup == "CrouchCollision" then
				v40 = false;
				return
			end;
		end;
	else
		v2.char:SetAttribute("Crouching", v40)
	end;
	local v43, v44 = v5();
	u4 = v43;
	u5 = v44;
	if v40 == true and v2.camlock == nil and v2.stopcam == false or p1 ~= nil then
		if p1 ~= nil then
			v2.crouching = p1;
		else
			v2.char:SetAttribute("Crouching", v40)
			v2.crouching = not v2.crouching;
		end;
		if v2.crouching == true then
			v1.MainFrame.Healthbar.Effects.Crouching.Visible = true
			
			v36.Crouch:Play(0.2, 1, 0);
			v2.spring:Impulse(Vector3.new(math.random(-2, 2), -10, math.random(-2, 2)));
			updatespeed();
			if u5 == "mobile" then
				v33.Crouch.ImageTransparency = 0;
				v33.Crouch.Image = "rbxassetid://8571432274";
				
				v33.Crouch.BackgroundTransparency = 1;
				--[[l__TweenService__7:Create(v33.Crouch, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
					BackgroundTransparency = 1, 
					ImageTransparency = 0.5
				}):Play();--]]
			end;
			return
		end;
		v1.MainFrame.Healthbar.Effects.Crouching.Visible = false
		
		v2.char:SetAttribute("Crouching", false)
		v36.Crouch:Stop(0.2);
		v2.spring:Impulse(Vector3.new(math.random(-2, 2), 5, math.random(-2, 2)));
		updatespeed();
		
		if u5 == "mobile" then
			v33.Crouch.ImageTransparency = 0;
			v33.Crouch.Image = "rbxassetid://8571378399";
			v33.Crouch.BackgroundTransparency = 1;
			--[[l__TweenService__7:Create(v33.Crouch, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
				BackgroundTransparency = 1, 
				ImageTransparency = 1
			}):Play();--]]
		end;
	end;
end;
updatespeed();
l__UserInputService__6.InputBegan:connect(function(p2, p3)
	if p2.UserInputType == Enum.UserInputType.MouseButton2 then
		v2.hrc = true;
	end;
	if p3 == true then
		return;
	end;
	if p2.KeyCode == Enum.KeyCode.C or p2.KeyCode == Enum.KeyCode.ButtonB or p2.KeyCode == Enum.KeyCode.ButtonR3 or p2.KeyCode == Enum.KeyCode.ButtonL3 or p2.KeyCode == Enum.KeyCode.LeftControl or p2.KeyCode == Enum.KeyCode.LeftShift then
		v2.crouch();
	end;
end);
l__UserInputService__6.InputEnded:connect(function(p4, p5)
	if p4.KeyCode == Enum.KeyCode.Space then
		v2.holdjump = false;
	end;
	if p4.UserInputType == Enum.UserInputType.MouseButton2 then
		v2.hrc = false;
	end;
	if p5 == true then
		return;
	end;
	--[[if (p4.KeyCode == Enum.KeyCode.C or p4.KeyCode == Enum.KeyCode.ButtonB or p4.KeyCode == Enum.KeyCode.ButtonR3 or p4.KeyCode == Enum.KeyCode.ButtonL3 or p4.KeyCode == Enum.KeyCode.LeftControl or p4.KeyCode == Enum.KeyCode.LeftShift) then
		for v45 = 1, 5000 do
			if v2.crouching ~= true then
				break;
			end;
			v2.crouch();
			task.wait(0.1);
		end;
	end;--]]
end);
v2.hum:GetAttributeChangedSignal("Stunned"):Connect(function(p6)
	v2.stunned = l__Humanoid__8:GetAttribute("Stunned");
	local l__stunned__46 = v2.stunned;
	l__Humanoid__8:ChangeState(l__stunned__46 and Enum.HumanoidStateType.Physics or Enum.HumanoidStateType.GettingUp);
	if l__stunned__46 then
		for v47, v48 in pairs(l__Humanoid__8:GetPlayingAnimationTracks()) do
			v48:Stop(0);
		end;
	end;
end);
v33.Crouch.MouseButton1Down:Connect(function()
	v2.crouch();
end);
local u6 = l__Forward__39;
l__Humanoid__8.StateChanged:Connect(function(p7, p8)
	if p8 == Enum.HumanoidStateType.Running or p8 == Enum.HumanoidStateType.RunningNoPhysics or p8 == Enum.HumanoidStateType.StrafingNoPhysics then
		local l__Forward__49 = v36.Forward;
		if u6 ~= l__Forward__49 then
			u6 = l__Forward__49;
		end;
	elseif p8 == Enum.HumanoidStateType.Physics then
		v1.Event_Sprinting:Fire(false);
	end;
	if p8 == Enum.HumanoidStateType.Landed then
		v2.spring:Impulse(Vector3.new(math.random(-2, 2), -10, math.random(-2, 2)));
	end;
	if p8 == Enum.HumanoidStateType.Jumping then
		v2.spring:Impulse(Vector3.new(math.random(-2, 2), 10, math.random(-2, 2)));
	end;
end);
print(u5)
if u5 ~= "mobile" then
	pcall(function()
		v33.Crouch.BackgroundTransparency = 1;
		v33.Crouch.ImageTransparency = 1;
		v33.Crouch.Visible = true;
		v33.Crouch:WaitForChild("UIStroke").Enabled = false;
	end);
else
	pcall(function()
		v33.Crouch.BackgroundTransparency = 0.35;
		v33.Crouch.ImageTransparency = 0;
		v33.Crouch.Visible = true;
		v33.Crouch:WaitForChild("UIStroke").Enabled = true;
	end);
end;
local u7 = false;
local u8 = v25;
local u9 = v27;
local u10 = 0;
local l__C0__11 = l__Root__22.C0;
local l__C0__12 = l__Waist__20.C0;
local l__C0__13 = l__Neck__21.C0;
local l__C0__14 = l__LeftShoulder__24.C0;
local l__C0__15 = l__RightShoulder__23.C0;
local u16 = v28;
local u17 = v27;
local u18 = v2.ax;
local u19 = v2.az_t;
local u20 = false;
local u21 = false;
game["Run Service"]:BindToRenderStep("movement", 101, function(p9)
	local v50 = l__Humanoid__8.MoveDirection;
	if v2.chase and v2.stopcam == false and v2.chaseMove == true then
		local l__unit__51 = (l__Humanoid__8.MoveDirection + (v2.cam.CFrame.LookVector * Vector3.new(1, 0, 1)).unit * 1.1).unit;
		l__Humanoid__8:Move(l__unit__51, false);
		v50 = l__unit__51;
	end;
	if v50.Magnitude > 0.1 then
		if u7 == false then

		end;
		u8 = v50;
		u7 = true;
		if v2.chase then
			v2.chaseMove = false;
		end;
	else
		if u7 == true then

		end;
		u7 = false;
	end;
	local v52 = v50.Magnitude * l__Humanoid__8.WalkSpeed;
	local v53 = v4:GetMoveVector();
	local v54 = u6;
	local v55 = Vector3.new(math.clamp(l__HumanoidRootPart__11.Velocity.X, -v52, v52), 0, math.clamp(l__HumanoidRootPart__11.Velocity.Z, -v52, v52)).Magnitude;
	if tick() <= v30 + 0.5 then
		v55 = 0;
	end;
	if v2.crouching == true then
		u6:AdjustWeight(0.02);
		u6:AdjustSpeed(0.02);
		v54 = v36.Crouch;
	else
		v54:AdjustWeight(math.clamp(v55 / 15, 0.02, 1));
	end;
	v54:AdjustSpeed(math.clamp(v55, 0.02, 30) / 15);
	if v53.Z > 0.1 then
		v53 = Vector3.new(v53.X * -1, v53.Y, v53.Z);
		if u3 == false then
			u3 = true;
			updatespeed();
		end;
	elseif u3 == true then
		u3 = false;
		updatespeed();
	end;
	local v56 = 0;
	if v2.aiming == true then
		v56 = 0;
	end;
	if v2.crouching == true then
		v56 = 30;
	end;
	u9 = u9 + (v53 - u9) * math.clamp(p9 * 10, 0.01, 1);
	u10 = u10 + (v56 - u10) * math.clamp(p9 * 5, 0.01, 1);
	local v57 = Vector3.new(1, 0, 1);
	local u22 = Vector3.new(0, 0, 0);
	pcall(function()
		u22 = v2.bobspring.p;
	end);
	if v2.camlock ~= nil then
		u22 = Vector3.new(0, 0, 0);
	end;
	if v2.hideplayers < 0 then
		l__Root__22.C0 = l__C0__11;
		l__Waist__20.C0 = l__C0__12;
		l__Neck__21.C0 = l__C0__13;
		l__LeftShoulder__24.C0 = l__C0__14;
		l__RightShoulder__23.C0 = l__C0__15;
	elseif v2.stunned == false then
		l__Root__22.C0 = l__C0__11 * CFrame.Angles(0, math.rad(u9.x * -25), 0) * CFrame.Angles(math.rad(u22.Y * 3), math.rad(u22.X * 3), math.rad(u22.X * 2));
		l__Waist__20.C0 = l__C0__12 * CFrame.Angles(math.rad(v2.ay * 0.25), 0, 0) * CFrame.Angles(0, math.rad(u9.x * 25), 0) * CFrame.Angles(0, 0, math.rad(v2.az)) * CFrame.Angles(math.rad(u22.Y * -3), math.rad(u22.X * -3), math.rad(u22.X * -2));
		l__Neck__21.C0 = l__C0__13 * CFrame.Angles(math.rad(v2.ay * 0.1), 0, 0);
		if v2.tool then
			l__LeftShoulder__24.C0 = l__C0__14 * CFrame.new(0, 1, -0.75) * CFrame.Angles(math.rad(v2.ay * 0.75 + u10), 0, 0) * CFrame.new(0, -1 + u10 / 60, 0.5) * CFrame.new(v2.tooloffset.X, v2.tooloffset.Y, v2.tooloffset.Z);
			l__RightShoulder__23.C0 = l__C0__15 * CFrame.new(0, 1, -0.75) * CFrame.Angles(math.rad(v2.ay * 0.75 + u10), 0, 0) * CFrame.new(0, -1 + u10 / 60, 0.5) * CFrame.new(v2.tooloffset.X, v2.tooloffset.Y, v2.tooloffset.Z);
		else
			l__LeftShoulder__24.C0 = l__C0__14 * CFrame.new(0, -0.3 - v2.ay / 270, math.clamp(-v2.ay / 90, -0.4, 0)) * CFrame.Angles(math.rad(v2.ay * -0.025 + u10), 0, 0);
			l__RightShoulder__23.C0 = l__C0__15 * CFrame.new(0, -0.3 - v2.ay / 270, math.clamp(-v2.ay / 90, -0.4, 0)) * CFrame.Angles(math.rad(v2.ay * -0.025 + u10), 0, 0);
		end;
	else
		l__Root__22.C0 = l__C0__11;
		l__Waist__20.C0 = l__C0__12;
		l__Neck__21.C0 = l__C0__13;
		l__LeftShoulder__24.C0 = l__C0__14;
		l__RightShoulder__23.C0 = l__C0__15;
	end;
	if v2.finalCamCFrame and not v2.stopcam then
		if v2.stunned == false and v2.camlock == nil and not v2.freemouse then
			l__HumanoidRootPart__11.CFrame = CFrame.new(l__HumanoidRootPart__11.Position, l__HumanoidRootPart__11.Position + v2.finalCamCFrame.LookVector * v57);
		end;
		if v2.skybox then
			v2.skybox.CFrame = CFrame.new(v2.cam.CFrame.Position) * CFrame.new(0, 5, 0);
		end;
		v2.cam.CFrame = v2.finalCamCFrame;
	end;
	if u16 + 0.067 < tick() then
		if (u9 - u17).Magnitude > 0.05 or math.abs(u18 - v2.ax) > 0.1 or u19 ~= v2.az_t or v2.aiming ~= u20 or v2.crouching ~= u21 then
			game:GetService("ReplicatedStorage").EntityInfo.MotorReplication:FireServer(math.ceil(u9.x * 10) / 10, math.ceil(v2.ay + 0), v2.az_t, v2.crouching);
			u16 = tick();
			u18 = v2.ax;
			u17 = u9;
		end;
	elseif u19 ~= v2.az_t or v2.aiming ~= u20 or v2.crouching ~= u21 then
		game:GetService("ReplicatedStorage").EntityInfo.MotorReplication:FireServer(math.ceil(u9.x * 10) / 10, math.ceil(v2.ay + 0), v2.az_t, v2.crouching);
		u16 = tick();
		u18 = v2.ax;
		u17 = u9;
	end;
	u21 = v2.crouching;
	u20 = v2.aiming;
	u19 = v2.az_t;
end);

if v2.platform == "console" then
	task.spawn(function()
		v1.ConsoleHints.Visible = true;
		task.wait(120)
		v1.ConsoleHints.Visible = false;
	end)
end

local req = false

if game.Workspace.Game.Modifiers:FindFirstChild("Quiet") then
	if game.Workspace.Game.Modifiers:FindFirstChild("Quiet").Value == true then
		v2.char:GetAttributeChangedSignal("Crouching"):Connect(function()
			if req == false then
				req = true
				while true do
					wait(1)
					if v2.char:GetAttribute("Crouching", true) then

					else
						v2.char.Humanoid:TakeDamage(5)
					end
				end
			end
		end)
	end
end
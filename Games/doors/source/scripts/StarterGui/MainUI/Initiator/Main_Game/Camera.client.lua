local v1 = script:FindFirstAncestor("MainUI");
local v2 = require(script.Parent);
local v3 = require(v1.Modules.Spring);
local l__UserInputService__4 = game:GetService("UserInputService");
local l__TweenService__5 = game:GetService("TweenService");
local l__LocalPlayer__6 = game.Players.LocalPlayer;
local l__Humanoid__7 = v2.char:WaitForChild("Humanoid");
local l__HumanoidRootPart__8 = v2.char:WaitForChild("HumanoidRootPart");
local v9 = CFrame.new(0, 0, 0);
local v10 = Vector3.new(0, 0, 0);
local v11 = Vector3.new(0, 0, 0);
v2.camSens = 0.5;
v2.camsmoothamt = 25;
v2.hrc = false;
v2.bobspring = v3.new(Vector3.new(0, 0, 0));
v2.bobspring:__newindex("Damper", 0.9);
v2.bobspring:__newindex("Speed", 10);
local v12 = v3.new(Vector3.new(0, -2.7, -0.25));
v12:__newindex("Damper", 1);
v12:__newindex("Speed", 20);
v2.cam.CameraType = Enum.CameraType.Scriptable;
local v13 = {
	Acog = 25, 
	HoloSight = 15, 
	[""] = 0
};
local v14 = Instance.new("PointLight");
v14.Color = Color3.fromRGB(120, 122, 138);
v14.Range = 10;
v14.Brightness = 0.55;
if v2.platform == "console" or v2.platform == "mobile" then
	v14.Brightness = 0.7;
	v14.Range = 12;
	pcall(function()
		game.Lighting.XBoxColor.Enabled = true;
	end);
end;
v14.Shadows = false;
v14.Parent = v2.char:WaitForChild("Head");
delay(5, function()
	v14.Parent = v2.char:WaitForChild("Head");
end);
local v15 = RaycastParams.new();
v15.CollisionGroup = "NoPlayer";
v15.FilterDescendantsInstances = { v2.viewmodel, v2.char };
l__UserInputService__4.MouseIconEnabled = false;
local v16 = Vector2.new(0, 0);
v2.update();
local u1 = 0.016666666666666666;
local u2 = v9;
local u3 = v16;
local function u4(p1)
	if p1 ~= p1 then
		return;
	end;
	local v17 = p1.Magnitude / u1;
	if v17 >= 1000 then
		p1 = p1 * (1000 / v17);
	end;
	v2.ay_t = math.clamp(v2.ay_t - p1.y, -65, 65);
	v2.ax_t = (v2.ax_t - p1.x) % 360;
	if v2.camlock ~= nil or v2.stopcam then
		v2.camlockedoffset[2] = math.clamp(v2.camlockedoffset[2] - p1.y / 2, -25, 25);
		v2.camlockedoffset[1] = math.clamp(v2.camlockedoffset[1] - p1.x / 2, -65, 65);
	end;
	u2 = u2 * (CFrame.Angles(0, math.rad(-p1.x), 0) * CFrame.Angles(math.rad(-p1.y), 0, 0));
	if v2.camsmoothamt < 35 then
		v2.bobspring:Impulse(Vector3.new(-p1.x / 1, -p1.y / 1, 0));
	end;
end;
l__UserInputService__4.InputChanged:connect(function(p2, p3)
	if (p2.UserInputType == Enum.UserInputType.MouseMovement or p2.UserInputType == Enum.UserInputType.Touch or p2.KeyCode == Enum.KeyCode.Thumbstick2) and (p3 == false and v2.dead == false or (v2.hrc == true or p2.KeyCode == Enum.KeyCode.Thumbstick2) and v2.dead == true) then
		local v18 = v2.cam.FieldOfView / 90;
		local v19 = Vector2.new(p2.Delta.x * v2.camSens, p2.Delta.y * v2.camSens) * 0.8 * v18;
		if p2.UserInputType == Enum.UserInputType.Touch then
			v19 = Vector2.new(p2.Delta.x * v2.camSens, p2.Delta.y * v2.camSens) * 1.6 * v18;
			v2.hrc = true;
		end;
		if p2.KeyCode == Enum.KeyCode.Thumbstick2 then
			local v20 = Vector2.new(p2.Position.x * v2.camSens, p2.Position.y * -1 * v2.camSens) * 12 * v18;
			u3 = v20.Unit * math.max(v20.Magnitude - 0.45, 0) * 1.5;
			return;
		else
			u4(v19);
		end;
	end;
end);
v1.Event_RepositionViewmodel.Event:Connect(function()
	v12:__newindex("Position", Vector3.new(0, -3, -0.35));
end);
v2.settingsvisible = v1.Settings.Visible;
v1.Settings.Changed:Connect(function()
	v2.settingsvisible = v1.Settings.Visible;
end);
local u5 = nil;
local u6 = v10;
local u7 = v11;
game["Run Service"]:BindToRenderStep("caminit", 95, function(p4)
	v2.cam.CameraType = Enum.CameraType.Scriptable;
	if v2.freemouse == true or (v2.dead == true and v2.hrc == false or v2.settingsvisible) then
		l__UserInputService__4.MouseBehavior = Enum.MouseBehavior.Default;
		l__UserInputService__4.MouseIconEnabled = true;
	else
		l__UserInputService__4.MouseBehavior = Enum.MouseBehavior.LockCenter;
		l__UserInputService__4.MouseIconEnabled = false;
	end;
	if u5 ~= nil then
		u4((Vector2.new(u5.Position.x, u5.Position.y * -1) * 1).Unit * (math.max(u5.Position.Magnitude - 0.25, 0) * 7 * (0.5 + v2.camSens * 0.7) * (v2.cam.FieldOfView / 90)) * p4 * 60);
	end;
	if v2.camlock ~= nil and ((tick() <= v2.camlock.last or l__Humanoid__7.MoveDirection.Magnitude < 0.75) and v2.camlockHead == false) then
		v2.ax_t = v2.camlock.x;
		v2.ay_t = v2.camlock.y;
		v2.ax = v2.camlock.x;
		v2.ay = v2.camlock.y;
	elseif v2.camlock == nil or not v2.camlockHead then
		if v2.camlock ~= nil then
			game:GetService("ReplicatedStorage").EntityInfo.CamLock:FireServer();
		end;
		local v21 = v2.ax_t - v2.ax;
		v2.ax = (v2.ax + (math.abs(v21) > 180 and v21 - v21 / math.abs(v21) * 360 or v21) * math.clamp(p4 * v2.camsmoothamt, 0.01, 1)) % 360;
		v2.ay = v2.ay + (v2.ay_t - v2.ay) * math.clamp(p4 * v2.camsmoothamt, 0.01, 1);
	end;
	local v22 = Vector3.new(0, 0.2, 0);
	local v23 = Vector3.new(0, 0, -0.25);
	if v2.crouching == true then
		v22 = Vector3.new(0, -0.2, 0);
	end;
	u1 = p4;
	u6 = u6 + (v22 - u6) * math.clamp(p4 * 10, 0.01, 1);
	u7 = u7 + (v23 - u7) * math.clamp(p4 * 10, 0.01, 1);
	v2.fovspring = v2.fovspring + (v2.fovtarget - v2.fovspring) * math.clamp(p4 * 5, 0.01, 1);
	v2.az = v2.az + (v2.az_t - v2.az) * math.clamp(p4 * 12, 0.01, 1);
	local v24 = Vector3.new(0, 0, 0);
	if v2.dead == true then
		local v25 = workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1);
		if v25 and v2.spectarget == nil then
			local room_start_id = "RoomStart"
			
			if v25:FindFirstChild("RoomEntrance") then
				room_start_id = "RoomEntrance"
			end
			wait()
			v2.basecamcf = v25[room_start_id].CFrame * CFrame.new(0, 5, -9) * CFrame.Angles(0, math.rad((tick() - v2.deathtick) * 15), 0);
		elseif v2.spectarget then
			if v2.trackspec ~= false then
				v2.basecamcf = CFrame.new(v2.spectarget.Position) * CFrame.new(0, 1, 0) * CFrame.Angles(0, math.rad(v2.ax), 0) * CFrame.Angles(-0.2617993877991494, 0, 0) * CFrame.new(0, 0, 6);
			end;
		else
			warn("no spectate at all brah.");
		end;
	elseif v2.stunned == true then
		local l__p__26 = (l__HumanoidRootPart__8.CFrame * CFrame.new(0, 1.45, 0)).p;
		local v27 = RaycastParams.new();
		v27.CollisionGroup = "NoPlayer";
		v27.FilterDescendantsInstances = { v2.viewmodel, v2.char };
		local v28 = workspace:Raycast(l__p__26, l__HumanoidRootPart__8.CFrame.LookVector * 0.75, v27);
		if v28 and v28.Position then
			local l__Position__29 = v28.Position;
			local l__Instance__30 = v28.Instance;
			if l__Position__29 then
				v2.basecamcf = l__HumanoidRootPart__8.CFrame * CFrame.new(0, 1.45, -(l__p__26 - l__Position__29)) * CFrame.Angles(math.rad(math.clamp(v2.bobspring.p.Y, -80, 80)), math.rad(math.clamp(v2.bobspring.p.X, -80, 80)), math.rad(math.clamp(v2.bobspring.p.Z, -40, 40)));
			end;
		else
			v2.basecamcf = l__HumanoidRootPart__8.CFrame * CFrame.new(0, 1.45, -0.75) * CFrame.Angles(math.rad(math.clamp(v2.bobspring.p.Y, -80, 80)), math.rad(math.clamp(v2.bobspring.p.X, -80, 80)), math.rad(math.clamp(v2.bobspring.p.Z, -40, 40)));
		end;
		v2.bobspring:__newindex("Speed", 3);
	elseif v2.camlock ~= nil then
		v2.basecamcf = (v2.char.Head.CFrame + Vector3.new(0, 0, 0)) * CFrame.new(0, 0.4, -0.5) * CFrame.Angles(math.rad(math.clamp(v2.bobspring.p.Y, -80, 80)), math.rad(math.clamp(v2.bobspring.p.X, -80, 80)), math.rad(math.clamp(v2.bobspring.p.Z, -40, 40))) * CFrame.Angles(0, math.rad(v2.camlockedoffset[1]), 0) * CFrame.Angles(math.rad(v2.camlockedoffset[2]), 0, 0);
		v2.bobspring:__newindex("Speed", 5);
	else
		v2.bobspring:__newindex("Speed", 12);
		local v31 = (v2.char.Head.Position - v2.char.LowerTorso.Position) * Vector3.new(1, 0, 1);
		v2.basecamcf = CFrame.new(v2.char.Head.Position + v2.char.Head.CFrame.UpVector * 0.2) * CFrame.new(u6) * CFrame.Angles(0, math.rad(v2.ax), 0) * CFrame.new(-v2.az / 40, 0, -0.2) * CFrame.Angles(math.rad(math.clamp(v2.ay + v2.bobspring.Position.Y + v2.spring.p.Y + v2.recoil_spring.Position.Y, -88, 88)), 0, 0) * CFrame.new(u7) * CFrame.Angles(0, 0, math.rad(v2.az / 2)) * CFrame.Angles(0, math.rad(math.clamp(-v2.bobspring.p.X, -20, 20)), math.rad(math.clamp(-v2.bobspring.p.X, -20, 20)));
	end;
	if v2.stopcam == false then
		v2.finalCamCFrame = v2.basecamcf * v2.csgo + v24;
		v2.cam.FieldOfView = v2.fovspring;
	end;
end);
local function v32()
	local v33 = {};
	for v34, v35 in pairs((l__UserInputService__4:GetGamepadState(Enum.UserInputType.Gamepad1))) do
		v33[v35.KeyCode] = v35;
	end;
	u5 = v33[Enum.KeyCode.Thumbstick2];
end;
l__UserInputService__4.GamepadConnected:Connect(v32);
if v2.controller == "console" then
	v32();
end;
local l__controller__36 = v2.controller;
l__UserInputService__4.LastInputTypeChanged:Connect(v32);
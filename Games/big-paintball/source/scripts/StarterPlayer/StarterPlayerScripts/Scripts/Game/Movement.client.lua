-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__CurrentCamera__2 = game.Workspace.CurrentCamera;
local v3 = require(v1.Player.Get("Player"):WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetCameras();
local u1 = nil;
local u2 = false;
local u3 = 0;
local u4 = 0;
local u5 = {
	quiet = 5611407891, 
	quieter = 5611407781, 
	louder = 5611408017
};
local u6 = require(v1.Player.Get("Player"):WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local u7 = 16;
local u8 = 16;
local u9 = { 5611408142, 5611408261, 5611408551, 5611408680, 5611409001, 5611409142, 5611409495, 5611409595 };
local u10 = Random.new();
local l__LocalPlayer__11 = game.Players.LocalPlayer;
v1.Signal.Fired("Change Max Walkspeed"):Connect(function(p1)
	u8 = p1;
end);
local function u12(p2)
	local l__Humanoid__4 = p2:WaitForChild("Humanoid");
	local l__HumanoidRootPart__5 = p2:WaitForChild("HumanoidRootPart");
	pcall(function()
		v1.RunService:UnbindFromRenderStep("Update Movement");
	end);
	pcall(function()
		if u1 then
			u1:Disconnect();
		end;
	end);
	u2 = false;
	l__Humanoid__4.WalkSpeed = 0;
	l__Humanoid__4.JumpPower = 25;
	local function u13()
		local v6 = RaycastParams.new();
		v6.FilterType = Enum.RaycastFilterType.Whitelist;
		v6.FilterDescendantsInstances = { game.Workspace:WaitForChild("__MAP") };
		local v7 = p2:GetModelSize();
		local v8 = false;
		for v9 = -1, 1, 0.5 do
			for v10 = -0.5, 0.5, 0.5 do
				if game.Workspace:Raycast(l__HumanoidRootPart__5.Position, CFrame.new(l__HumanoidRootPart__5.Position + Vector3.new(v9, 0, v10), l__HumanoidRootPart__5.Position + Vector3.new(v9, -50, v10)).LookVector * (v7.Y / 2 + 0.1), v6) then
					v8 = true;
				end;
			end;
		end;
		if v8 then
			return true;
		end;
		return false;
	end;
	local u14 = 0;
	local u15 = false;
	local u16 = tick();
	local u17 = 0;
	local u18 = tick();
	local function u19()
		if u13() then
			l__Humanoid__4.JumpPower = 25;
			l__Humanoid__4:ChangeState(Enum.HumanoidStateType.Jumping);
			u14 = l__HumanoidRootPart__5.Position.Y;
			u15 = false;
			u16 = tick();
			if u17 > 1 then
				if u17 <= 3 then
					u3 = u3 + 1;
				else
					u3 = u3 + (0.75 + (tick() - u18) / 2);
				end;
				u3 = math.clamp(u3, 0, 7);
			end;
			u17 = u17 + 1;
			u4 = 7.5;
			v1.Signal.Fire("Bhop Gun Animation", 0.2 + u3 / 35);
			if u17 % 1 == 0 then
				v1.Audio.Play(5611407453, script, 0.7, 0.2);
			else
				v1.Audio.Play(5611407614, script, 0.7, 0.2);
			end;
			coroutine.wrap(function()
				wait(0.05);
				u4 = 0;
				while not u13() or tick() - u18 <= 0.1 do
					v1.Heartbeat();				
				end;
				local v11 = u14 - l__HumanoidRootPart__5.Position.Y;
				if v11 > 8 then
					v1.Audio.Play(u5.louder, script, 1, 0.2);
					return;
				end;
				if v11 > 2 then
					v1.Audio.Play(u5.quieter, script, 1, 0.2);
					return;
				end;
				v1.Audio.Play(u5.quiet, script, 1, 0.2);
			end)();
			u18 = tick();
		else
			coroutine.wrap(function()
				v1.Functions.Wait(0.05);
				if u13() then
					u19();
				end;
			end)();
		end;
		coroutine.wrap(function()
			v1.Heartbeat();
			l__Humanoid__4.JumpPower = 25;
		end)();
	end;
	local u20 = tick();
	local u21 = false;
	local u22 = tick();
	local u23 = tick();
	local u24 = tick();
	v1.RunService:BindToRenderStep("Update Movement", Enum.RenderPriority.Character.Value, function(p3)
		local v12 = tick();
		if v12 - u20 <= 0.05 then
			return;
		end;
		u20 = v12;
		local v13 = not v1.Variables.Console and u6:GetMoveVector() or v1.Variables.ControllerMoveVector;
		if v13.Magnitude > 0.1 then
			if u7 < u8 then
				u7 = u7 + p3 * 65;
			end;
		elseif u7 > 12 then
			u7 = u7 - p3 * 65 * 2;
		end;
		local v14 = u13();
		if v14 and not u21 and v12 - u18 >= 0.01 then
			u21 = true;
			u22 = v12;
		elseif not v14 and u21 then
			u21 = false;
			u16 = v12;
			u15 = true;
			u22 = v12;
		end;
		if not (not u21) and v12 - u22 > 0.25 and u3 > 0 or u8 < 20 or l__HumanoidRootPart__5.Velocity.Magnitude < 4 then
			u3 = 0;
			u17 = 0;
		end;
		u7 = math.clamp(u7, 12, u8);
		l__Humanoid__4.WalkSpeed = u7 + u3 + u4;
		if v12 - u23 >= 0.2 then
			if u3 > 0 then
				u2 = true;
				v1.Signal.Fire("Change Boost FOV", true, u3 / 2);
			elseif u3 <= 0 and u2 then
				u2 = false;
				v1.Signal.Fire("Change Boost FOV", false);
			end;
			u23 = v12;
		end;
		if u21 and v12 - u22 > 0.05 and (math.clamp(0.5 - Vector2.new(l__HumanoidRootPart__5.Velocity.X, l__HumanoidRootPart__5.Velocity.Z).Magnitude / 85, 0.2, 0.5) < v12 - u24 and v13.magnitude > 0.1) then
			u24 = v12;
			v1.Audio.Play(u9[u10:NextInteger(1, #u9)], script, 1, 0.175);
		end;
	end);
	--v1.ContextActionService:UnbindAction("jumpAction");
	--v1.ContextActionService:UnbindAction("Do Jump");
	game.ReplicatedStorage:WaitForChild("RAISE DEVEX RATES").Event:Connect(function()
		if not l__LocalPlayer__11:FindFirstChild("__SPAWNED") then
			return;
		end;
		if not v1.Variables.Mobile then
			return;
		end;
		u19();
	end);
	u1 = v1.UserInputService.InputBegan:Connect(function(p4, p5)
		if p5 then
			return;
		end;
		if not l__LocalPlayer__11:FindFirstChild("__SPAWNED") then
			return;
		end;
		if p4.KeyCode == Enum.KeyCode.Space or p4.KeyCode == Enum.KeyCode.ButtonA then
			u19();
		end;
	end);
end;
l__LocalPlayer__11.CharacterAdded:Connect(function(p6)
	u12(p6);
end);
while not l__LocalPlayer__11.Character do
	v1.Heartbeat();
end;
u12(l__LocalPlayer__11.Character);

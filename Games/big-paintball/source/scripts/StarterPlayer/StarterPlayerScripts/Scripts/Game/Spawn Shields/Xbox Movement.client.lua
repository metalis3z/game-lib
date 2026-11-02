-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local v2 = require(v1.Player.Get("Player"):WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local v3 = Vector3.new(0, 0, 0);
local v4 = tick();
wait(3);
if not v1.Variables.Console then
	return;
end;
v1.UserInputService.InputBegan:Connect(function(p1)
	if not game.Players.LocalPlayer:FindFirstChild("__SPAWNED") then
		return;
	end;
end);
local u1 = v3;
v1.UserInputService.InputChanged:Connect(function(p2)
	if p2.KeyCode == Enum.KeyCode.Thumbstick1 then
		if not game.Players.LocalPlayer:FindFirstChild("__SPAWNED") then
			return;
		end;
		u1 = p2.Position;
	end;
end);
v1.UserInputService.InputEnded:Connect(function(p3)
	if p3.KeyCode == Enum.KeyCode.Thumbstick1 then
		u1 = Vector3.new(0, 0, 0);
	end;
end);
v1.RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function()
	if game.Players.LocalPlayer.Character then
		local l__Humanoid__5 = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid");
		if l__Humanoid__5 then
			if u1.Magnitude > 0.1 then
				l__Humanoid__5:Move(Vector3.new(u1.X, 0, -u1.Y), true);
			elseif v2:GetMoveVector() == Vector3.new(0, 0, 0) then
				l__Humanoid__5:Move(Vector3.new(0, 0, 0), true);
			end;
			if tick() - v4 >= 0.01 then
				if u1.Magnitude > 0.1 then
					v1.Variables.ControllerMoveVector = Vector3.new(u1.X, 0, -u1.Y);
					return;
				end;
				v1.Variables.ControllerMoveVector = v2:GetMoveVector();
			end;
		end;
	end;
end);

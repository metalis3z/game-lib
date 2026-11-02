-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local v3 = v1.Player.Get("Camera");
local v4 = {};
for v5, v6 in pairs(v1.Directory.Killstreaks) do
	v4[v5] = 0;
end;
v1.Variables.AvailableItems = v4;
local l__Crosshair__1 = v1.Player.Get("PlayerGui"):WaitForChild("Crosshair");
local u2 = v1.Entity.Get((v1.Player.Get()));
local u3 = 0;
local u4 = 0;
local u5 = 0;
local function u6(p1, p2)
	l__Crosshair__1.Hitmarker.ImageTransparency = 0;
	v1.Functions.FastTween(l__Crosshair__1.Hitmarker, {
		ImageTransparency = 1
	}, { 0.75, "Quad", "Out" });
	v1.Audio.Play(3759805686, script, 1.2, 2.75);
	if not p1 then
		v1.Audio.Play(3701094988, script, 1, 1.45);
		if v1.Variables.Console and v1.HapticService:IsVibrationSupported(Enum.UserInputType.Gamepad1) then
			v1.HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 0.25);
			wait(0.1);
			v1.HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 0);
		end;
	end;
end;
v1.Network.Fired("Killed Player"):Connect(function()
	u3 = u3 + 1;
	v1.Variables.Killstreak = u3;
	if tick() - u4 <= 3.25 then
		v1.Audio.Play(4157884244, script, 1 + math.clamp(u5 - 1, 0, 10) / 25, 1);
		u5 = u5 + 1;
	else
		u5 = 1;
	end;
	u4 = tick();
	u6(nil, u2.Kills);
end);
v1.Network.Fired("Reset Killstreak"):Connect(function()
	u3 = 0;
	v1.Variables.Killstreak = 0;
end);
local u7 = v4;
v1.Network.Fired("New Killstreak Item"):Connect(function(p3, p4, p5)
	u7 = p4;
	if not p5 and p3 and p3.Name and p3.KeyBind then
		v1.Signal.Fire("New Item", "Message", string.format("+1 %s! Press %s to use", p3.Name, p3.KeyBind));
	end;
end);
v1.Network.Fired("Do Hitmarker"):Connect(function(p6)
	u6(p6, u2.Kills);
end);
v1.Signal.Fired("Do Hitmarker"):Connect(function(p7)
	u6(p7, u2.Kills);
end);

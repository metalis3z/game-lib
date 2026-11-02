-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l__Sentries__3 = game.Workspace:WaitForChild("__THINGS"):WaitForChild("Sentries");
local v4 = v1.Player.Get("Camera");
local v5 = v1.Entity.Get((v1.Player.Get()));
local u1 = nil;
v1.Network.Fired("Do Nuke Effects"):Connect(function(p1)
	if u1 == nil then
		u1 = {
			Ambient = game.Lighting.Ambient, 
			Brightness = game.Lighting.Brightness, 
			ColorShift_Bottom = game.Lighting.ColorShift_Bottom, 
			ColorShift_Top = game.Lighting.ColorShift_Top, 
			OutdoorAmbient = game.Lighting.OutdoorAmbient, 
			ClockTime = game.Lighting.ClockTime, 
			FogColor = game.Lighting.FogColor, 
			FogEnd = game.Lighting.FogEnd, 
			FogStart = game.Lighting.FogStart, 
			ExposureCompensation = game.Lighting.ExposureCompensation
		};
	end;
	if not p1 then
		v1.Audio.Play(9165092099, script, 1, 3);
		wait(0.25);
		v1.Shake.Create(3, 2.5, 0.15);
	end;
	local v6 = {};
	local v7
	if p1 then
		v7 = 0.01;
	else
		v7 = 0.15;
	end;
	v6[1] = v7;
	v6[2] = "Exponential";
	v6[3] = "Out";
	v1.Functions.FastTween(game.Lighting, {
		Ambient = Color3.fromRGB(255, 183, 0), 
		Brightness = game.Lighting.Brightness, 
		ColorShift_Bottom = Color3.fromRGB(255, 0, 0), 
		ColorShift_Top = Color3.fromRGB(255, 170, 0), 
		OutdoorAmbient = Color3.fromRGB(255, 182, 153), 
		ClockTime = game.Lighting.ClockTime, 
		FogColor = Color3.fromRGB(253, 249, 122), 
		FogEnd = game.Lighting.FogEnd, 
		FogStart = game.Lighting.FogStart, 
		ExposureCompensation = 1.5
	}, v6);
	wait(3);
	v1.Functions.FastTween(game.Lighting, u1, { 4, "Quad", "Out" });
end);

-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l____VARIABLES__3 = game.Workspace:WaitForChild("__VARIABLES");
local v4 = v1.Player.Get();
local v5 = v1.Player.Get("Camera");
local l__Gui__1 = v1.GUI.SpawnGlow.Gui;
local v14
local v15
local function u2(p1)
	local v6 = 0;
	local v7 = 0;
	l__Gui__1.Enabled = true;
	l__Gui__1.Frame.Transparency = 0.9;
	for v8, v9 in pairs(l__Gui__1:GetChildren()) do
		if v9.Name == "Border" then
			v9.ImageTransparency = 0.25;
		end;
	end;
	while p1 and p1.Parent ~= nil do
		if tick() - v6 > 0.25 then
			local v10 = tick();
			for v11, v12 in pairs(l__Gui__1:GetChildren()) do
				if v12.Name == "Border" then
					local v13 = {};
					if v7 == 0 then
						v14 = 0.4;
					else
						v14 = 0.25;
					end;
					v13.ImageTransparency = v14;
					v1.Functions.FastTween(v12, v13, { 0.35, "Quad", "Out" });
				end;
			end;
			if v7 == 0 then
				v15 = 1;
			else
				v15 = 0;
			end;
			v7 = v15;
		end;
		v1.Heartbeat();	
	end;
	for v16, v17 in pairs(l__Gui__1:GetChildren()) do
		if v17.Name == "Border" then
			v1.Functions.FastTween(v17, {
				ImageTransparency = 1
			}, { 0.25, "Quad", "Out" });
		end;
	end;
	v1.Functions.FastTween(l__Gui__1.Frame, {
		Transparency = 1
	}, { 0.25, "Quad", "Out" });
	wait(0.25);
	l__Gui__1.Enabled = false;
end;
v1.Network.Fired("Show Forcefield"):Connect(function(p2)
	u2(p2);
end);

-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local v2 = v1.Player.Get("Camera");
local u1 = v1.Player.Get();
local l__GadgetIndicator__2 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("GadgetIndicator");
local function u3(p1, p2)
	if not p1 or not p2 then
		v1.Print("Invalid arguments", true);
		return;
	end;
	if p2.Top.Main:FindFirstChild("GadgetIndicator") then
		p2.Top.Main:FindFirstChild("GadgetIndicator"):Destroy();
	end;
	if not v1.Shared.isFFA() and p1.Team == u1.Team or p1 == u1 then
		l__GadgetIndicator__2:Clone().Parent = p2.Top.Main;
	end;
end;
v1.Network.Fired("New Sentry"):Connect(function(p3, p4)
	u3(p3, p4);
end);
v1.Network.Fired("New Mini Sentry"):Connect(function(p5, p6)
	u3(p5, p6);
end);
v1.Network.Fired("New Armored Sentry"):Connect(function(p7, p8)
	u3(p7, p8);
end);
for v3, v4 in pairs(game.Workspace:WaitForChild("__THINGS"):WaitForChild("Sentries"):GetChildren()) do
	u3(game.Players:FindFirstChild(v4.Name), v4);
end;
for v5, v6 in pairs(game.Workspace:WaitForChild("__THINGS"):WaitForChild("Mini Sentries"):GetChildren()) do
	u3(game.Players:FindFirstChild(v6.Name), v6);
end;
for v7, v8 in pairs(game.Workspace:WaitForChild("__THINGS"):WaitForChild("Armored Sentries"):GetChildren()) do
	u3(game.Players:FindFirstChild(v8.Name), v8);
end;
for v9, v10 in pairs(game.Workspace:WaitForChild("__THINGS"):WaitForChild("Dark Matter Sentries"):GetChildren()) do
	u3(game.Players:FindFirstChild(v10.Name), v10);
end;

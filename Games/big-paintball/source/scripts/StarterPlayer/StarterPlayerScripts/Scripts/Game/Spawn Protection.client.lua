-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l__LocalPlayer__1 = game.Players.LocalPlayer;
local function u2()
	if l__LocalPlayer__1 and l__LocalPlayer__1.Character and l__LocalPlayer__1.Parent == game.Players and l__LocalPlayer__1.Character.Parent == game.Workspace and l__LocalPlayer__1.Character:FindFirstChild("ForceField") then
		l__LocalPlayer__1.Character:FindFirstChild("ForceField").Visible = false;
	end;
end;
coroutine.wrap(function()
	u2();
	while true do
		u2();
		v1.Heartbeat()
	end;
end)();

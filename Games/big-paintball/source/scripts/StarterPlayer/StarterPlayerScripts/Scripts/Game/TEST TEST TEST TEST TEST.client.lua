-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
wait(10);
local v2 = 0;
while true do
	v2 = v2 + 1;
	wait(1.5);
	v1.Signal.Fire("New Reward Item", "gdfgdfgd " .. v2, 100, true);
end;

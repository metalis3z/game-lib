-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Guns__2 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Guns");
v1.Network.Fired("New Projectile"):Connect(function(...)
	v1.Projectiles.Fire(...);
end);

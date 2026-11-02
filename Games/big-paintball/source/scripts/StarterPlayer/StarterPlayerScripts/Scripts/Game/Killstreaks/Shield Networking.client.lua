-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__CarePackages__2 = v1.Things:WaitForChild("CarePackages");
local l__Assets__3 = v1.Assets;
local v4 = Random.new();
v1.Network.Fired(". "):Connect(function(p1, p2)
	local v5 = p2:GetPrimaryPartCFrame();
end);

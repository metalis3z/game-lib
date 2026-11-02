-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
return function(p1, p2)
	v1.GUIFX.Rainbow(p1.TextLabel, "TextColor3", 0.25);
	v1.GUIFX.Rainbow(p1.Icon, "ImageColor3", 0.25);
end;

-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
return function(p1, p2, ...)
	local v2 = ...;
	p1.title.Text = v1.Language.Translate(v2) and v2;
end;

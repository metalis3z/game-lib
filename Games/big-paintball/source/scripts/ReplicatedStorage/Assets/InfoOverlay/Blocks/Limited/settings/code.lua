-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
return function(p1, p2)
	local v2 = tick();
	while p1 and p1:FindFirstChild("TextLabel") do
		p1.TextLabel.UIGradient.Rotation = (tick() - v2) * 60 * 2;
		p1.Icon.UIGradient.Rotation = (tick() - v2) * 60 * 1.25;
		v1.RenderStepped();	
	end;
end;

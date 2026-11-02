-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
return function(p1, p2)
	local v2, v3, v4 = Color3.toHSV(p1.TextLabel.TextColor3);
	local v5 = tick();
	while p1 and p1:FindFirstChild("TextLabel") do
		local v6 = Color3.fromHSV(v2, v3, 0.75 + math.abs(math.tan(tick() - v5) - 0.75));
		p1.TextLabel.TextColor3 = v6;
		p1.Icon.ImageColor3 = v6;
		v1.RenderStepped();	
	end;
end;

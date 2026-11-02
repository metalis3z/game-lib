-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local v7 = nil;
return function(p1, p2, ...)
	local v2 = ...;
	if v2 == "%%random" then
		local v3 = { "x", "X", "%", "Z", "z", ".", "/", "8", "*", "#", "@", "?", "!", " ", " ", " " };
		local v4 = { "THE ENERGY IS UNSTABLE", "EVERYTHING IS FRAGILE", "THE GROUND IS SHAKING", "THE PORTAL IS OPEN" };
		while p1 and p1:FindFirstChild("desc") do
			local v5 = "";
			if math.random(1, 300) ~= 1 then
				for i = 1, 75 do
					v5 = v5 .. v3[math.random(1, #v3)];
				end;
			else
				local v7 = tostring(v4[math.random(1, #v4)])
			end;
			
			p1.desc.Text = v5
			p1.desc.AutoLocalize = false;
			v1.Heartbeat();		
		end;
	else
		local v8 = v1.Language.Translate(v2) and v2;
		p1.desc.Text = v2 
	end;
end;

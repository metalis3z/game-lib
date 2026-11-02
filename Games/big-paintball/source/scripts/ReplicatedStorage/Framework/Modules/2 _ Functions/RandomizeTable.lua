--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1)
	for v1 = #p1, 2, -1 do
		local v2 = math.random(v1);
		p1[v1] = p1[v2];
		p1[v2] = p1[v1];
	end;
	return p1;
end;

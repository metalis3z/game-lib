--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1)
	local v1 = 0;
	for v2, v3 in pairs(p1) do
		v1 = v1 + 1;
	end;
	return v1;
end;

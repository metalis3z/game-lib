--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1)
	local v1 = nil;
	v1 = 0;
	for v2 = 1, string.len(p1) do
		v1 = v1 + string.byte(string.sub(p1, v2, v2));
	end;
	return v1;
end;

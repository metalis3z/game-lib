--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2)
	for v1, v2 in ipairs(p1 or {}) do
		if v2 == p2 then
			return true;
		end;
	end;
	return false;
end;

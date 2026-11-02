--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1)
	local v1 = os.date("!%X", tonumber(p1));
	if p1 <= 3600 then
		v1 = v1:sub(4);
	end;
	return v1;
end;

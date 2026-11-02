--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2, p3)
	local l__Gravity__1 = game.Workspace.Gravity;
	local v2 = math.atan((p3 ^ 2 + math.sqrt(p3 ^ 4 - l__Gravity__1 * (l__Gravity__1 * p1 ^ 2 + 2 * p2 * p3 ^ 2))) / (l__Gravity__1 * p1));
	if v2 ~= v2 then
		v2 = math.pi / 4;
	end;
	return v2;
end;

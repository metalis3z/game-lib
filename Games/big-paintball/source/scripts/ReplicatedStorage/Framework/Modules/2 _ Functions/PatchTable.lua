--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1)
	if type(p1) ~= "table" then
		return;
	end;
	local v1 = {};
	for v2, v3 in pairs(p1) do
		table.insert(v1, v3);
	end;
	return v1;
end;

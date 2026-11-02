--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2)
	for v1 = #p1, 1, -1 do
		if p1[v1] == p2 then
			table.remove(p1, v1);
		end;
	end;
	return p1;
end;

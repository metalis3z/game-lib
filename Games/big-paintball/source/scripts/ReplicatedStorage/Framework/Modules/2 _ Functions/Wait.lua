--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local u2 = Random.new();
return function(p1, p2)
	if p2 then
		p1 = u2:NextNumber(p1, p2);
	end;
	task.wait(p1);
end;

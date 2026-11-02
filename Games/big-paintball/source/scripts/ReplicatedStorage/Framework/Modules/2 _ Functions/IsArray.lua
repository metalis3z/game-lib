--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1)
	for v1, v2 in pairs(p1) do
		if type(v1) ~= "number" then
			return false;
		end;
		if p1[v1] == nil then
			return false;
		end;
		if v1 >= 10 then
			break;
		end;
	end;
	return true;
end;

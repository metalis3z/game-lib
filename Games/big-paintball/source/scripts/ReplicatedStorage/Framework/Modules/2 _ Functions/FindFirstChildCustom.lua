--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2)
	if not p1 then
		return u1.Print("1st argument is blank or nil", true);
	end;
	if not p2 then
		return u1.Print("2nd argument is blank or nil", true);
	end;
	if type(p1) == "userdata" then
		p1 = p1:GetChildren();
	end;
	for v1, v2 in ipairs(p1) do
		if p2(v2) then
			return v2;
		end;
	end;
end;

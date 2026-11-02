--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local function u2(p1, p2)
	p2 = p2 or {};
	if type(p1) ~= "table" then
		return p1;
	end;
	if p2[p1] then
		return p2[p1];
	end;
	local v1 = {};
	p2[p1] = v1;
	for v2, v3 in next, p1 do
		v1[u2(v2, p2)] = u2(v3, p2);
	end;
	setmetatable(v1, u2(getmetatable(p1), p2));
	return v1;
end;
return function(p3, p4)
	if p4 then
		return u2(p3);
	end;
	return game.HttpService:JSONDecode(game.HttpService:JSONEncode(p3));
end;

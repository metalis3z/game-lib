--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {
	I = 1, 
	V = 5, 
	X = 10, 
	L = 50, 
	C = 100, 
	D = 500, 
	M = 1000
};
local u2 = { 1, 5, 10, 50, 100, 500, 1000 };
local u3 = { "I", "V", "X", "L", "C", "D", "M" };
return function(p1)
	p1 = tonumber(p1);
	if not p1 or p1 ~= p1 then
		error("Unable to convert to number");
	end;
	if p1 == math.huge then
		error("Unable to convert infinity");
	end;
	p1 = math.floor(p1);
	if p1 <= 0 then
		return p1;
	end;
	local v2 = "";
	for v3 = #u2, 1, -1 do
		local v4 = u2[v3];
		while p1 - v4 >= 0 and p1 > 0 do
			v2 = v2 .. u3[v3];
			p1 = p1 - v4;		
		end;
		for v5 = 1, v3 - 1 do
			local v6 = u2[v5];
			if p1 - (v4 - v6) >= 0 and p1 < v4 and p1 > 0 and v4 - v6 ~= v6 then
				v2 = v2 .. u3[v5] .. u3[v3];
				p1 = p1 - (v4 - v6);
				break;
			end;
		end;
	end;
	return v2;
end;

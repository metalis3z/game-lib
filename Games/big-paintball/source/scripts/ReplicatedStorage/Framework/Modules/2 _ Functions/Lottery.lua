--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local u2 = Random.new();
return function(...)
	local v1 = { ... };
	if type(v1[1][1]) == "table" then
		v1 = u1.Functions.CloneTable(v1[1]);
	end;
	if #v1 < 2 then
		for i, v in pairs(v1[1]) do
		end
		return v1[1][1], nil, 100;
	end;
	local u3 = nil;
	(function()
		local v2 = 0;
		for v3, v4 in ipairs(v1) do
			v2 = v2 + v4[2];
		end;
		for v5, v6 in ipairs(v1) do
			local v7 = v6[2];
			v6[2] = v7 / v2;
			v6[3] = v7;
		end;
	end)();
	(function()
		u3 = u2:NextNumber();
	end)();
	local v8 = (function()
		local v9 = 0;
		for v10, v11 in ipairs(v1) do
			v9 = v9 + v11[2];
			if u3 <= v9 then
				return v11;
			end;
		end;
	end)();
	return v8[1], u3, v8[2];
end;

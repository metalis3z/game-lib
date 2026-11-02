--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
function CompareTable(p1, p2, p3)
	local v1 = type(p1);
	local v2 = type(p2);
	if v1 ~= v2 then
		return false;
	end;
	if v1 ~= "table" then
		if v2 ~= "table" then
			return p1 == p2;
		end;
	end;
	local v3 = getmetatable(p1);
	if not p3 then
		if v3 then
			if v3.__eq then
				return p1 == p2;
			end;
		end;
	end;
	for v4, v5 in pairs(p1) do
		local v9 = p2[v4];
		if v9 ~= nil then

		else
			return false;
		end;
		if not CompareTable(v5, v9) then
			return false;
		end;	
	end;
	for v10, v11 in pairs(p2) do
		local v15 = p1[v10];
		if v15 ~= nil then

		else
			return false;
		end;
		if not CompareTable(v15, v11) then
			return false;
		end;	
	end;
	return true;
end;
return CompareTable;

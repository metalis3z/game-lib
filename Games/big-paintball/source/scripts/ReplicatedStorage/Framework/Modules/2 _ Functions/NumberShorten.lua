--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2)
	local v1 = nil;
	local v2
	if p2 == nil then
		v2 = true;
	else
		v2 = p2;
	end;
	p2 = v2;
	local v3 = "";
	local u2 = "";
	v1 = function(p3)
		local v4 = u2:sub(1, #u2 - 1);
		if not p2 then
			return string.format("%.2f", p3);
		end;
		if p3 >= 100 then
			if p3 % 10 == 0 then
				return string.format("%.2f", p3);
			else
				return string.format("%.0f", p3);
			end;
		end;
		if not (p3 >= 10) or p3 % 1 == 0 then
			return string.format("%.2f", p3);
		end;
		if p3 % 1 == 0 then
			return string.format("%.2f", p3);
		end;
		return string.format("%.1f", p3);
	end;
	if p1 >= 1000000000000 then
		u2 = v1(p1 / 1000000000000);
		v3 = "t";
	elseif p1 >= 1000000000 then
		u2 = v1(p1 / 1000000000);
		v3 = "b";
	elseif p1 >= 1000000 then
		u2 = v1(p1 / 1000000);
		v3 = "m";
	elseif p1 > 1000 then
		u2 = v1(p1 / 1000);
		v3 = "k";
	else
		u2 = u1.Functions.Commas(p1);
	end;
	if p1 > 1000 then
		while #u2 > 1 and string.find(u2, "%.") ~= nil and u2:sub(#u2, #u2) == "0" do
			u2 = u2:sub(1, #u2 - 1);		
		end;
		if u2:sub(#u2, #u2) == "." then
			u2 = u2:sub(1, #u2 - 1);
		end;
	end;
	local v5 = u2 .. v3;
	if v5 == "1000m" then
		return "1b";
	end;
	if v5 == "1000k" then
		return "1m";
	end;
	if v5 ~= "1000b" then
		return v5;
	end;
	return "1t";
end;

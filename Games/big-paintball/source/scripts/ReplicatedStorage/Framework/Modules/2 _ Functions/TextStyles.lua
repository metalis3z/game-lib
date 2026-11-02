--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
function UTF8sub(p1, p2, p3)
	p2 = utf8.offset(p1, p2);
	p3 = utf8.offset(p1, p3 + 1) - 1;
	return string.sub(p1, p2, p3);
end;
local u2 = game:GetService("RunService"):IsStudio();
local u3 = require(script:WaitForChild("styles"));
return function(p4, p5)
	if not u2 then
		for v1, v2 in pairs(u3) do
			p4 = string.gsub(p4, "%[" .. v1 .. "]", "");
			p4 = string.gsub(p4, "%[/" .. v1 .. "]", "");
		end;
		return p4;
	end;
	local function v3(p6, p7)
		local v4 = u3[p7];
		for v5 = 1, string.len("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") do
			p6 = string.gsub(p6, string.sub("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", v5, v5), (UTF8sub(v4, v5, v5)));
		end;
		return p6;
	end;
	if p5 then
		p4 = v3(p4, p5);
	end;
	if not p5 then
		for v6, v7 in pairs(u3) do
			local v8 = "%[" .. v6 .. "]";
			local v9 = "%[/" .. v6 .. "]";
			p4 = string.gsub(p4, v8 .. "-.-" .. v9, function(p8)
				return v3(string.gsub(string.gsub(p8, v8, ""), v9, ""), v6);
			end);
		end;
	end;
	return p4;
end;

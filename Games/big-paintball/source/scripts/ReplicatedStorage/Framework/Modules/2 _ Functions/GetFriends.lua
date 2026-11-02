--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {};
return function(p1)
	local v2 = {};
	for v3, v4 in ipairs(game.Players:GetPlayers()) do
		if p1 ~= v4 then
			local u2 = false;
			pcall(function()
				u2 = p1:IsFriendsWith(v4.UserId);
			end);
			if u2 then
				table.insert(v2, v4);
			end;
		end;
	end;
	return v2;
end;

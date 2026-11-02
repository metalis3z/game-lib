--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local u2 = {};
return function(p1)
	if u2[p1] then
		return u2[p1];
	end;
	local u3 = nil;
	if not pcall(function()
		u3 = game.Players:GetNameFromUserIdAsync(p1);
	end) then
		return "??";
	end;
	u2[p1] = u3;
	return nil;
end;

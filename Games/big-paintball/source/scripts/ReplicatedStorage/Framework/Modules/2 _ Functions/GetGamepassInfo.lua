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
	pcall(function()
		u3 = u1.MarketplaceService:GetProductInfo(p1, Enum.InfoType.GamePass);
	end);
	if u3 then
		u2[p1] = u3;
	end;
	return u3;
end;

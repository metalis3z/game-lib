-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local u2 = {};
return function(p1)
	if u2[p1] ~= nil then
		return u2[p1];
	end;
	local u3 = nil;
	pcall(function()
		u3 = u1.MarketplaceService:GetProductInfo(p1, Enum.InfoType.Product);
	end);
	if u3 ~= nil then
		u2[p1] = u3;
	end;
	return nil;
end;

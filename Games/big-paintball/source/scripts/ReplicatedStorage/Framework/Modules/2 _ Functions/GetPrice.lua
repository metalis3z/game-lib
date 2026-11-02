-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {};
local v2
return function(p1, p2)
	if p2 then
		local v2 = u1.Functions.GetProductInfo(p1, Enum.InfoType.Product);
	else
		v2 = u1.Functions.GetGamepassInfo(p1);
	end;
	if not v2 then
		u1.Print("Failed to grab price for ID (" .. p1 .. ")", true);
		return;
	end;
	-- For 
	if game:GetService("RunService"):IsStudio() then
		return 0, true -- set to false if no work
	end
	--[[if not v2.IsForSale then
		return 0, false;
	end;]]
	return tonumber(v2.PriceInRobux), true;
end;

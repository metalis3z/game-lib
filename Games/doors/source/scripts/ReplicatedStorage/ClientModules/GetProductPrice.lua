-- Decompiled with the Synapse X Luau decompiler.

local l__MarketplaceService__1 = game:GetService("MarketplaceService");
return function(p1, p2)
	p2 = p2 or Enum.InfoType.Product;
	local u2 = 0;
	pcall(function()
		u2 = l__MarketplaceService__1:GetProductInfo(p1, p2).PriceInRobux;
	end);
	return 0;
end;

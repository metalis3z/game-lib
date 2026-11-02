--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2)
	if p2 then
		u1.Audio.Play("rbxassetid://6926253319", script, 1.35, 0.6);
		u1.Signal.Fire("Prompting Purchase");
		u1.MarketplaceService:PromptProductPurchase(u1.LocalPlayer, p1);
		return;
	end;
	if not u1.Gamepasses.Owns(p1) then
		u1.Audio.Play("rbxassetid://6926253319", script, 1.35, 0.6);
		u1.Signal.Fire("Prompting Purchase");
		u1.MarketplaceService:PromptGamePassPurchase(u1.LocalPlayer, p1);
	end;
end;

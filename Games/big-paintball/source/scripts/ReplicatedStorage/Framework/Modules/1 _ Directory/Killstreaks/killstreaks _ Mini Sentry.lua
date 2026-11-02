-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["6"] = {
		displayName = "Mini Sentry!", 
		description = "Place a cute baby sentry that automatically fires at enemies!", 
		thumbnail = "rbxassetid://6731283446", 
		offsale = false, 
		disabled = false, 
		price = 2500000, 
		gamepassId = 0, 
		productId = 0, 
		interval = 6, 
		module = u1.Game.KillstreakController:WaitForChild("Mini Sentry")
	}
};

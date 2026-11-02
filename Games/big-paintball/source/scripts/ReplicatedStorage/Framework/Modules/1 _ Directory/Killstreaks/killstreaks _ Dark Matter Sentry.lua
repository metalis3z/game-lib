-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["9"] = {
		displayName = "Dark Matter Sentry!", 
		description = "%%random", 
		thumbnail = "rbxassetid://8482436652", 
		offsale = false, 
		disabled = false, 
		price = 80000000, 
		gamepassId = 0, 
		productId = 0, 
		interval = 32, 
		module = u1.Game.KillstreakController:WaitForChild("DarkMatterSentry")
	}
};

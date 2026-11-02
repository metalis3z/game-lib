-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["7"] = {
		displayName = "Armored Sentry!", 
		description = "An absolute tank with a built-in minigun that automatically sprays at enemies!", 
		thumbnail = "rbxassetid://6731283279", 
		offsale = false, 
		disabled = false, 
		price = 12000000, 
		gamepassId = 0, 
		productId = 0, 
		interval = 24, 
		module = u1.Game.KillstreakController:WaitForChild("Armored Sentry")
	}
};

-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["2"] = {
		displayName = "Sentry!", 
		description = "Place a stationary sentry that automatically fires at enemies!", 
		thumbnail = "rbxassetid://4352589418", 
		offsale = true, 
		disabled = false, 
		price = 0, 
		gamepassId = 0, 
		productId = 0, 
		interval = 8, 
		module = u1.Game.KillstreakController:WaitForChild("Sentry"), 
		xboxKeybind = Enum.KeyCode.DPadLeft, 
		xboxImage = "rbxassetid://4448384282", 
		keybind = Enum.KeyCode.X
	}
};

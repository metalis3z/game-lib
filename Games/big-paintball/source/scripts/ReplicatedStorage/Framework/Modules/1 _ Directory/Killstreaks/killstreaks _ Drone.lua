-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["3"] = {
		displayName = "Drone!", 
		description = "Follows you around aerially and fires paint at enemies!", 
		thumbnail = "rbxassetid://4352589268", 
		offsale = true, 
		disabled = false, 
		price = 0, 
		gamepassId = 0, 
		productId = 0, 
		interval = 11, 
		module = u1.Game.KillstreakController:WaitForChild("Drone"), 
		xboxKeybind = Enum.KeyCode.DPadDown, 
		xboxImage = "rbxassetid://4448384333", 
		keybind = Enum.KeyCode.C
	}
};

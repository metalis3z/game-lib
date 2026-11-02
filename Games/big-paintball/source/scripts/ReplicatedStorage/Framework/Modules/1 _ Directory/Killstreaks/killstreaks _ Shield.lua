-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["8"] = {
		displayName = "Shield!", 
		description = "Place it anywhere! Block oncoming enemy projectiles!", 
		thumbnail = "rbxassetid://0", 
		offsale = true, 
		disabled = true, 
		price = 1000000, 
		gamepassId = 0, 
		productId = 0, 
		interval = 15, 
		module = u1.Game.KillstreakController:WaitForChild("Shield"), 
		xboxKeybind = Enum.KeyCode.DPadLeft, 
		xboxImage = "rbxassetid://4448384282", 
		keybind = Enum.KeyCode.X
	}
};

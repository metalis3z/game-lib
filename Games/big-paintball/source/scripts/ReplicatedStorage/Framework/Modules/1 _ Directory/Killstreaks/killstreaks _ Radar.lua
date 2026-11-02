-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["1"] = {
		displayName = "Radar!", 
		description = "Ping the location of enemy players for 10 seconds!", 
		thumbnail = "rbxassetid://4387084987", 
		offsale = true, 
		disabled = false, 
		price = 0, 
		gamepassId = 0, 
		productId = 0, 
		interval = 4, 
		module = game.ReplicatedStorage.Game.KillstreakController:WaitForChild("Radar"), --u1.Game.KillstreakController:WaitForChild("Radar"), 
		xboxKeybind = Enum.KeyCode.DPadUp, 
		xboxImage = "rbxassetid://4448384378", 
		keybind = Enum.KeyCode.Z
	}
};

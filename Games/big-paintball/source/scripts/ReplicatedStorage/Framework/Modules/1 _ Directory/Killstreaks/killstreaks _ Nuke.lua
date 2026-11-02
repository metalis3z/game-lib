-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["4"] = {
		displayName = "Nuke!", 
		description = "Decimate the entire enemy team, at the press of a button!", 
		thumbnail = "rbxassetid://4352588832", 
		offsale = true, 
		disabled = false, 
		price = 0, 
		gamepassId = 0, 
		productId = 0, 
		interval = 100, 
		module = u1.Game.KillstreakController:WaitForChild("Nuke"), 
		xboxKeybind = Enum.KeyCode.DPadRight, 
		xboxImage = "rbxassetid://4448384173", 
		keybind = Enum.KeyCode.V
	}
};

-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["5"] = {
		displayName = "Care Package!", 
		description = "Call in a Care Package full of credits!", 
		thumbnail = "rbxassetid://6731283363", 
		offsale = false, 
		disabled = false, 
		price = 4000000, 
		gamepassId = 0, 
		productId = 0, 
		interval = 20, 
		module = u1.Game.KillstreakController:WaitForChild("Care Package"), 
		xboxKeybind = Enum.KeyCode.DPadUp, 
		xboxImage = "rbxassetid://4448384378", 
		keybind = Enum.KeyCode.Z
	}
};

--credit to quartz games studio
local Players = game:GetService("Players")

game:GetService("ReplicatedStorage")

local ExclusiveStoreController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.ExclusiveStoreController)
local LocalPlayer = Players.LocalPlayer
local ItemFrame_Exotic = script.Parent:WaitForChild("ItemFrame_Exotic")
local ItemFrame_Super = script.Parent:WaitForChild("ItemFrame_Super")
local ItemFrame_Secret = script.Parent:WaitForChild("ItemFrame_Secret")

ExclusiveStoreController:Setup({
	container = script.Parent,
	templates = {
		Secret = ItemFrame_Secret,
		Super = ItemFrame_Super,
		Exotic = ItemFrame_Exotic
	}
})
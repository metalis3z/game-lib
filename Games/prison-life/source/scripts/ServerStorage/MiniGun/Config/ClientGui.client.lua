local player = game.Players.LocalPlayer

local config = require(script.Parent)

local tool = script.Parent.Parent
local ammos = tool:WaitForChild("Ammos")
local reloading = tool:WaitForChild("Reloading")

local maxammos = config.GetConfig("maxammos")

local gui

tool.Equipped:Connect(function()
	gui = script.AmmoGui
	gui.Parent = player.PlayerGui
end)

reloading.Changed:Connect(function()
	if reloading.Value == true then
		gui.Backpack.Magazine.Text = "RELOADING"
	else
		gui.Backpack.Magazine.Text = maxammos.."/"..maxammos
	end
end)

ammos.Changed:Connect(function()
	gui.Backpack.Magazine.Text = ammos.Value.."/"..maxammos
end)

tool.Unequipped:Connect(function()
	gui.Parent = script
end)
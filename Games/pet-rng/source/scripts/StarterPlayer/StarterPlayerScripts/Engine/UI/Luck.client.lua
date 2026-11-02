local player = game.Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RSEngine = ReplicatedStorage:WaitForChild("Engine")
local Modules = RSEngine:WaitForChild("Modules")
local LuckModule = require(Modules:WaitForChild("Luck"))

local playerGui = player.PlayerGui
local gui = playerGui:WaitForChild("GUI")
local bottom = gui:WaitForChild("Bottom")
local roll = bottom:WaitForChild("roll")
local multiText = roll:WaitForChild("multi")

while wait() do
	local Luck = LuckModule.GetLuck(player)
	multiText.Text = "x" .. 2+Luck .. " Luck"
end


local UserInputService = game:GetService("UserInputService")

game.Players.LocalPlayer:WaitForChild("PlayerGui")

local v1 = script.Parent.Parent
local v2 = script.Parent

if not UserInputService.TouchEnabled or UserInputService.KeyboardEnabled then
	return
end

v2.Scale = 1.35
v1.Position = UDim2.new(0.02, 0, 1, 0)
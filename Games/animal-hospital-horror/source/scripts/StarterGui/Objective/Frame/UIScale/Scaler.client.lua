local UserInputService = game:GetService("UserInputService")

game.Players.LocalPlayer:WaitForChild("PlayerGui")

local v1 = script.Parent

if not UserInputService.TouchEnabled or UserInputService.KeyboardEnabled then
	return
end

v1.Scale = v1:GetAttribute("GoalScale") or 1.2
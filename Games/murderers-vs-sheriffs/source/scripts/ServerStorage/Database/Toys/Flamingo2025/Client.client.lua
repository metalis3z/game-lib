local Tool = script.Parent
local Player = game.Players.LocalPlayer
local Mouse = nil
local MouseClickConnection = nil

Tool.Equipped:Connect(function()
	Mouse = Player:GetMouse()
	MouseClickConnection = Mouse.Button1Down:Connect(function()
		Tool:WaitForChild("PlaceToyEvent"):FireServer()
	end)
end)

Tool.Unequipped:Connect(function()
	if MouseClickConnection then
		MouseClickConnection:Disconnect()
		MouseClickConnection = nil
	end
end)
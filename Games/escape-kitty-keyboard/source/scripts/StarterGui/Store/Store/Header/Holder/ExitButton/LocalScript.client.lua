local button = script.Parent
local player = game.Players.LocalPlayer

local storeGui = player.PlayerGui:WaitForChild("Store")
local storeFrame = storeGui:WaitForChild("Store")

button.MouseButton1Click:Connect(function()
	storeFrame.Visible = false
end)
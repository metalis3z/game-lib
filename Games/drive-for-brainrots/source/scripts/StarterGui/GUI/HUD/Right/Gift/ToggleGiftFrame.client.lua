local button = script.Parent
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local gui = playerGui:WaitForChild("GUI")
local giftFrame = gui.Frames.GiftrewardFrame

button.MouseButton1Click:Connect(function()
	giftFrame.Visible = not giftFrame.Visible
end)

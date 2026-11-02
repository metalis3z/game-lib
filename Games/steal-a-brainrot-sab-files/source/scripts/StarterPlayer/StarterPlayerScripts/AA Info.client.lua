local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI
local screenGui = playerGui:WaitForChild("AA Info") -- Remplace par le nom de ton ScreenGui
local frame = screenGui:WaitForChild("AA INFO")
local closeButton = frame:WaitForChild("Close")

frame.Visible = false

-- Cherche le ProximityPrompt "Admin Abuse" dans le Workspace
local prompt = workspace:FindFirstChild("Admin Abuse", true)

if prompt and prompt:IsA("ProximityPrompt") then
	prompt.Triggered:Connect(function(triggeringPlayer)
		if triggeringPlayer == player then
			frame.Visible = true
		end
	end)
end

closeButton.MouseButton1Click:Connect(function()
	frame.Visible = false
end)
local openBtn = script.Parent
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Find the TeleportGui ScreenGui in PlayerGui
local mainGui = playerGui:WaitForChild("Codes")
mainGui.Enabled = false

-- Setup Click Sound
local clickSound = Instance.new("Sound")
clickSound.Name = "ClickSound"
clickSound.SoundId = "rbxassetid://452267918" -- Replace with your preferred Sound ID
clickSound.Volume = 0.5
clickSound.Parent = openBtn

openBtn.MouseButton1Click:Connect(function()
	-- Play the sound
	clickSound:Play()

	-- Toggle the GUI
	mainGui.Enabled = not mainGui.Enabled
end)
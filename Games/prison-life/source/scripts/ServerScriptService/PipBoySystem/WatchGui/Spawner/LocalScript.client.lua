local PipBoyConfig = game.ReplicatedStorage:WaitForChild("PipBoyConfig")
local Remotes = PipBoyConfig:WaitForChild("Remotes")

local Frame = script.Parent
local StatFrame = Frame.Parent:WaitForChild("Stats")
local SettingFrame = Frame.Parent:WaitForChild("Settings")

local NextGui = Frame:WaitForChild("Next")
local BackGui = Frame:WaitForChild("Back")

NextGui.MouseButton1Click:Connect(function()
	Remotes.PlaySounds:FireServer("Select", false)

	Frame.Visible = false
	StatFrame.Visible = true
end)

BackGui.MouseButton1Click:Connect(function()
	Remotes.PlaySounds:FireServer("Select", false)

	Frame.Visible = false
	SettingFrame.Visible = true
end)
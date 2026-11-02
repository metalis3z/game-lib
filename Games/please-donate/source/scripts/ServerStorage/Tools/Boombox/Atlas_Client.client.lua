wait(0.5)
local Tool = script.Parent
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local MainUI = game.Players.LocalPlayer.PlayerGui.ScreenGui

Tool.Equipped:Connect(function()
	MainUI.Buttons.Boombox.Visible = true
end)

Tool.Unequipped:Connect(function()
	MainUI.Buttons.Boombox.Visible = false
	script.Parent.MainEvent:FireServer('Stop')
end)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local containerFrame = script.Parent.Misc.Frame
local hideButtonUI = containerFrame.Keybinds
local animatedHideButton = AnimatedButton.new(hideButtonUI)


animatedHideButton:Animate()

animatedHideButton.OnActivated:Connect(function ()
	ReplicatedStorage:WaitForChild("ResetKeys"):Fire()
end)

local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)

local Saves = script.Saves

InterfaceController:Register("Saves", script.Parent.Parent.Parent, "TopQuint")

Saves.Parent = script.Parent.Parent.Parent.Parent.Parent.LeftCenter.LeftCenter.Buttons

local Saves = AnimatedButton.new(Saves)
Saves:Animate()
Saves.OnActivated:Connect(function()
	InterfaceController:Toggle("Saves", true)
end)

local Close = AnimatedButton.new(script.Parent)
Close:Animate()
Close.OnActivated:Connect(function()
	InterfaceController:Toggle("Saves", false)
end)
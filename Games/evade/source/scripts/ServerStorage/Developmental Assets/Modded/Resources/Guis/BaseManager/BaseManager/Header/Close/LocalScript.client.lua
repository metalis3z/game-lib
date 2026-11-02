local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)

local BaseManager = script.BaseManager

InterfaceController:Register("BaseManager", script.Parent.Parent.Parent, "TopQuint")

BaseManager.Parent = script.Parent.Parent.Parent.Parent.Parent.LeftCenter.LeftCenter.Buttons

local GradientScroll = require(script.Parent.Parent.Parent.Content.CanvasGroup.List.GradientScroll)

GradientScroll(script.Parent.Parent.Main.UIGradient, 3)
GradientScroll(BaseManager.UIGradient, 3)

local Open = AnimatedButton.new(BaseManager)
Open:Animate()
Open.OnActivated:Connect(function()
	InterfaceController:Toggle("BaseManager", true)
end)

local Close = AnimatedButton.new(script.Parent)
Close:Animate()
Close.OnActivated:Connect(function()
	InterfaceController:Toggle("BaseManager", false)
end)
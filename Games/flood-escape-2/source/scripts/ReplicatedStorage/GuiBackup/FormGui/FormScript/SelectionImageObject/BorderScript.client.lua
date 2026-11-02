local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormModules = ReplicatedStorage.FormModules
local Colors = require(FormModules.Colors)
wait()
local ContainerGui = script:FindFirstAncestorOfClass("ScreenGui")

-- UI
local SelectionImageObject = script.Parent
local Border = SelectionImageObject.UIStroke
local Gradient = Border.UIGradient

-- Colors
Border.Color = Colors.White

ContainerGui:GetAttributeChangedSignal("ThemeColor"):Connect(function()
	local themeColor = ContainerGui:GetAttribute("ThemeColor")
	Gradient.Color = ColorSequence.new(themeColor)
end)


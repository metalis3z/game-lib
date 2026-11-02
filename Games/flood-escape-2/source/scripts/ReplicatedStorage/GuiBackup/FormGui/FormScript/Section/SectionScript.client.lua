local ContainerGui = script:FindFirstAncestorOfClass("ScreenGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormModules = ReplicatedStorage.FormModules
local Colors = require(FormModules.Colors)
local Config = require(FormModules.Config)

-- UI
local Section = script.Parent
local Border = Section.UIStroke
local Required = Section.Required
local RequiredIcon = Required.Icon
local RequiredLabel = Required.Label

-- Events
local ShowValidation = Section.ShowValidation

-- Colors
local themeColor = ContainerGui:GetAttribute("ThemeColor")

Border.Color = themeColor
RequiredIcon.ImageColor3 = themeColor
RequiredLabel.TextColor3 = themeColor

ShowValidation.Event:Connect(function (show)
	Border.Enabled = show
	Required.Visible = show
end)

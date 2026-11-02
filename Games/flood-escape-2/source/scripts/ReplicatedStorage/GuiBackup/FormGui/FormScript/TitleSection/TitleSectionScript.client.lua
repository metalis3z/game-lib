local ContainerGui = script:FindFirstAncestorOfClass("ScreenGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormModules = ReplicatedStorage.FormModules
local Colors = require(FormModules.Colors)
local Config = require(FormModules.Config)

-- UI
local TitleSection = script.Parent
local Divider = TitleSection.Divider
local Shared = TitleSection.Shared
local Required = TitleSection.Required

-- Colors
local themeColor = ContainerGui:GetAttribute("ThemeColor")

TitleSection.ImageColor3 = themeColor
Divider.BackgroundColor3 = Colors.LightGray
Shared.TextColor3 = Colors.DarkGray
Required.TextColor3 = themeColor

local ContainerGui = script:FindFirstAncestorOfClass("ScreenGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormModules = ReplicatedStorage.FormModules
local Colors = require(FormModules.Colors)
local Config = require(FormModules.Config)

-- UI
local Buttons = script.Parent
local Cancel = Buttons.Cancel
local Submit = Buttons.Submit
local SubmitLabel = Submit.Label
local SubmitGradient = Submit.UIGradient

-- Colors
local themeColor = ContainerGui:GetAttribute("ThemeColor")

Cancel.BackgroundColor3 = themeColor:Lerp(Colors.White, 0.5)
Cancel.TextColor3 = themeColor

Submit.BackgroundColor3 = themeColor
Submit.Label.TextColor3 = Colors.GetContrastColor(themeColor)
SubmitGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, themeColor),
	ColorSequenceKeypoint.new(0.5, Colors.White),
	ColorSequenceKeypoint.new(1, themeColor)
})

-- Selection
local function scrollToBottom()
	local ScrollingFrame = Buttons:FindFirstAncestorOfClass("ScrollingFrame")
	if ScrollingFrame then
		local bottom = Vector2.new(ScrollingFrame.CanvasPosition, ScrollingFrame.AbsoluteCanvasSize.Y)
		ScrollingFrame.CanvasPosition = bottom
	end
end

Cancel.SelectionGained:Connect(scrollToBottom)
Submit.SelectionGained:Connect(scrollToBottom)

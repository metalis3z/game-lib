local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormModules = ReplicatedStorage.FormModules
local Colors = require(FormModules.Colors)
local Assets = require(FormModules.Assets)
wait()
local ContainerGui = script:FindFirstAncestorOfClass("ScreenGui")

-- Constants
local defaultImageColor = Colors.Black
local checkedColor = ContainerGui:GetAttribute("ThemeColor")

-- Variables
local CheckboxContainer = script.Parent
local Checkbox = CheckboxContainer:FindFirstChildOfClass("ImageButton")
local Label = CheckboxContainer:FindFirstChildOfClass("TextButton")
local CheckedValue = CheckboxContainer.Checked

-- Validation
if Checkbox == nil then
	warn("Missing ImageButton for checkbox")
	return
end

if CheckedValue == nil then
	warn("Missing BoolValue for checkbox")
	return
end

-- Helpers
local function updateCheckbox()
	local checked = CheckedValue.Value
	
	if checked then
		Checkbox.Image = Assets.Checkbox.Checked
		Checkbox.ImageColor3 = checkedColor 
	else
		Checkbox.Image = Assets.Checkbox.Unchecked
		Checkbox.ImageColor3 = defaultImageColor
	end
end

CheckedValue.Changed:Connect(updateCheckbox)

local function selectCheckbox()
	CheckedValue.Value = not CheckedValue.Value
end

-- Setup
updateCheckbox(CheckedValue.Value)
Checkbox.Activated:Connect(function ()
	selectCheckbox()
end)
Label.Activated:Connect(function ()
	selectCheckbox()
end)

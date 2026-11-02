local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormModules = ReplicatedStorage.FormModules
local Colors = require(FormModules.Colors)
local Assets = require(FormModules.Assets)
wait()
local ContainerGui = script:FindFirstAncestorOfClass("ScreenGui")

-- Constants
local defaultImageColor = Colors.Black
local selectedColor = ContainerGui:GetAttribute("ThemeColor")

-- Variables
local RadioButtonGroup = script.Parent
local RadioButtonGroupValue = RadioButtonGroup:FindFirstChildOfClass("ObjectValue")
local RadioButtons = {}

-- Validation
if RadioButtonGroupValue == nil then
	warn("Missing ObjectValue for radio button group")
	return
end

-- Helpers
local function updateRadioButtons()
	for _, elem in ipairs(RadioButtons) do
		local imageButton = elem:FindFirstChildOfClass("ImageButton")
		
		if RadioButtonGroupValue.Value == elem.Value then
			imageButton.Image = Assets.RadioButton.Checked
			imageButton.ImageColor3 = selectedColor
		else
			imageButton.Image = Assets.RadioButton.Unchecked
			imageButton.ImageColor3 = defaultImageColor
		end
	end
end

RadioButtonGroupValue.Changed:Connect(updateRadioButtons)

local function selectRadioButton(radioButton)
	RadioButtonGroupValue.Value = radioButton.Value
end

-- Setup
local defaultSelectedRadioButton = nil
for _, elem in ipairs(RadioButtonGroup:GetChildren()) do
	if elem:IsA("Frame") and elem.Value then
		table.insert(RadioButtons, elem)
		
		if RadioButtonGroupValue.Value == elem.Value then
			defaultSelectedRadioButton = elem
		end

		local imageButton = elem:FindFirstChildOfClass("ImageButton")
		if imageButton == nil then
			warn("Missing image button for radio button")
			continue
		end

		imageButton.Activated:Connect(function ()
			selectRadioButton(elem)
		end)

		local textButton = elem:FindFirstChildOfClass("TextButton")
		if textButton == nil then
			warn("Missing text button for radio button label")
			continue
		end

		textButton.Activated:Connect(function ()
			selectRadioButton(elem)
		end)
	end
end

-- Select default radio button
if defaultSelectedRadioButton ~= nil then
	selectRadioButton(defaultSelectedRadioButton)
end


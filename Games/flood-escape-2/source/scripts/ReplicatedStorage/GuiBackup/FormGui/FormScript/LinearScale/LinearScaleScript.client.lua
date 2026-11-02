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
local LinearScale = script.Parent
local LinearScaleListLayout = LinearScale:FindFirstChildOfClass("UIListLayout")
local LinearScaleValue = LinearScale:FindFirstChildOfClass("ObjectValue")
local LinearScaleStartLabel = LinearScale:FindFirstChild("StartLabel")
local LinearScaleEndLabel = LinearScale:FindFirstChild("EndLabel")
local RadioButtons = {}

-- Validation
if LinearScaleValue == nil then
	warn("Missing ObjectValue for linear scale")
	return
end

-- Helpers
local function updateRadioButtons()
	for _, elem in ipairs(RadioButtons) do
		local imageButton = elem:FindFirstChildOfClass("ImageButton")

		if LinearScaleValue.Value == elem.Value then
			imageButton.Image = Assets.RadioButton.Checked
			imageButton.ImageColor3 = selectedColor
		else
			imageButton.Image = Assets.RadioButton.Unchecked
			imageButton.ImageColor3 = defaultImageColor
		end
	end
end

LinearScaleValue.Changed:Connect(updateRadioButtons)

local function selectRadioButton(radioButton)
	LinearScaleValue.Value = radioButton.Value
end

-- Setup
local defaultSelectedOption = nil
for _, elem in ipairs(LinearScale:GetChildren()) do
	if elem:IsA("Frame") and elem.Value then
		table.insert(RadioButtons, elem)

		if LinearScaleValue.Value == elem.Value then
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

-- Resizing
local WIDTH_BREAKPOINT = 500
local LABEL_WIDTH = 0.2
function updateSize()
	local isCompact = LinearScale.AbsoluteSize.X < WIDTH_BREAKPOINT
	
	if isCompact then
		LinearScaleListLayout.FillDirection = Enum.FillDirection.Vertical

		LinearScaleStartLabel.Size = UDim2.fromScale(1, 0)
		LinearScaleStartLabel.TextXAlignment = Enum.TextXAlignment.Left

		LinearScaleEndLabel.Size = UDim2.fromScale(1, 0)
		LinearScaleEndLabel.TextXAlignment = Enum.TextXAlignment.Left
	else
		LinearScaleListLayout.FillDirection = Enum.FillDirection.Horizontal

		LinearScaleStartLabel.Size = UDim2.fromScale(LABEL_WIDTH, 0)
		LinearScaleStartLabel.TextXAlignment = Enum.TextXAlignment.Center

		LinearScaleEndLabel.Size = UDim2.fromScale(LABEL_WIDTH, 0)
		LinearScaleEndLabel.TextXAlignment = Enum.TextXAlignment.Center
	end

	for _, elem in ipairs(RadioButtons) do
		local listLayout = elem:FindFirstChildOfClass("UIListLayout")
		
		if isCompact then
			listLayout.FillDirection = Enum.FillDirection.Horizontal
			listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			listLayout.VerticalAlignment = Enum.VerticalAlignment.Center

			elem.Size = UDim2.fromScale(1, 0)
		else
			listLayout.FillDirection = Enum.FillDirection.Vertical
			listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
			
			elem.Size = UDim2.new((1 - LABEL_WIDTH*2) / #RadioButtons, -1 * LinearScaleListLayout.Padding.Offset, 0, 0)
			elem.Label.TextXAlignment = Enum.TextXAlignment.Center
		end
	end
end
updateSize()

LinearScale:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSize)

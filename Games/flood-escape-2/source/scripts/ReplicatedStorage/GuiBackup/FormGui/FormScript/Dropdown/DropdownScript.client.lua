local ContentProvider = game:GetService("ContentProvider")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormModules = ReplicatedStorage.FormModules
local Colors = require(FormModules.Colors)
wait()
local ContainerGui = script:FindFirstAncestorOfClass("ScreenGui")

-- UI
local Dropdown = script.Parent
local Selected = Dropdown.Selected
local SelectedLabel = Selected.Label
local DropdownIcon = SelectedLabel.Icon

-- Constants
local iconDown = "http://www.roblox.com/asset/?id=6031091004"
local iconUp = "http://www.roblox.com/asset/?id=6031090990"
local defaultColor = Selected.BackgroundColor3
local defaultBorderColor = Selected.BorderColor3
local themeColor = ContainerGui:GetAttribute("ThemeColor")
local hoverColor = themeColor:Lerp(defaultColor, 0.9)
local selectedColor = themeColor:Lerp(defaultColor, 0.95)

-- Preload images
ContentProvider:PreloadAsync({ iconDown, iconUp})

-- Variables
local DropdownValue = Dropdown:FindFirstChildOfClass("ObjectValue")
local Options = {}

-- Validation
if DropdownValue == nil then
	warn("Missing ObjectValue for dropdown")
	return
end

local isOpen = false
local function toggleDropdown(keepFocus)
	isOpen = not isOpen

	DropdownIcon.Image = if isOpen then iconUp else iconDown
	
	for _, elem in ipairs(Options) do
		elem.Visible = isOpen
	end
	
	if keepFocus then
		GuiService.SelectedObject = Selected
	end
end

-- Helpers
local function selectOption(option, keepFocus)
	for _, elem in ipairs(Options) do
		local isSelectedElem = elem == option
		
		-- Update value
		if isSelectedElem then
			DropdownValue.Value = elem.Value
			
			SelectedLabel.Text = elem.Value.Value
			SelectedLabel.TextColor3 = Colors.Black
			
			elem.BackgroundColor3 = selectedColor
		else
			elem.BackgroundColor3 = defaultColor
		end
	end
	
	toggleDropdown(keepFocus)
end

-- Setup
function onHoverEnter(elem)
	elem.BackgroundColor3 = hoverColor
end

function onHoverLeave(elem, isSelected)
	elem.BackgroundColor3 = if isSelected then selectedColor else defaultColor
end

local defaultSelectedOption = nil
for _, elem in ipairs(Dropdown:GetDescendants()) do
	if elem ~= Selected and elem:IsA("ImageButton") and elem.Value then
		table.insert(Options, elem)
		
		if DropdownValue.Value == elem.Value then
			defaultSelectedOption = elem
		end

		elem.Activated:Connect(function (inputObject)
			local isSelect = GuiService.SelectedObject == elem
			selectOption(elem, isSelect)
		end)
		
		elem.MouseEnter:Connect(function ()
			onHoverEnter(elem)
		end)
		
		elem.MouseLeave:Connect(function ()
			onHoverLeave(elem, elem.Value == DropdownValue.Value)
		end)
		
		-- Gamepad / Keyboard Support
		elem.SelectionGained:Connect(function ()
			onHoverEnter(elem)
		end)

		elem.SelectionLost:Connect(function ()
			onHoverLeave(elem, elem.Value == DropdownValue.Value)
		end)
	end
end

-- Select default option
if defaultSelectedOption ~= nil then
	selectOption(defaultSelectedOption)
end

Selected.Activated:Connect(function (inputObject)
	toggleDropdown()
end)

Selected.MouseEnter:Connect(function ()
	onHoverEnter(Selected)
end)

Selected.MouseLeave:Connect(function ()
	onHoverLeave(Selected)
end)

-- Gamepad / Keyboard Support
Selected.SelectionGained:Connect(function ()
	onHoverEnter(Selected)
end)

Selected.SelectionLost:Connect(function ()
	onHoverLeave(Selected)
end)

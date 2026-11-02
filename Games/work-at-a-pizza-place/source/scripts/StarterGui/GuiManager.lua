
local GuiManager = {}
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local Slider = require(script:WaitForChild("Slider"))
local RadialMenu = require(script:WaitForChild("RadialMenu"))
local TabGroup = require(script:WaitForChild("TabGroup"))
local ListView = require(script:WaitForChild("ListView"))
local ToggleButton = require(script:WaitForChild("ToggleButton"))
local TextInput = require(script:WaitForChild("TextInput"))
local DropdownMenu = require(script:WaitForChild("DropdownMenu")) --UPDATECHANGE

local Window = require(script:WaitForChild("Window"))
local UIEvents = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))




GuiManager.Data = {}
GuiManager.DataNames = {}
GuiManager.WindowFocusStack = {} 



function GuiManager:RegisterWindow(window,...)
	if self.Data[window] == nil then
		local Window = Window.new(self,window,...)
		self.Data[window] = Window
		self.DataNames[window.Name] = Window
		return Window
	else
		return self.Data[window]  --if trying to register a second time, return the window data instead of registering again
	end
end


function GuiManager:TouchControlsEnabled(enabled)
	if game:GetService("UserInputService").TouchEnabled then
		local touchGui = PlayerGui:WaitForChild("TouchGui",2)
		if touchGui then
			local touchFrame = touchGui:WaitForChild("TouchControlFrame",2)
			if touchFrame then
				touchFrame.Visible = enabled
			end
		end
	end
end

function GuiManager:RegisterTabs(window,tabs)
	local group = TabGroup.new(tabs,self.Data[window])
	self.Data[tabs] = group
	return group
end

function GuiManager:RegisterTextInput(window,textInput)
	local textInputObject = TextInput.new(textInput,self.Data[window])
	self.Data[textInput] = textInputObject
	return textInputObject
end


function GuiManager:RegisterListView(window,listView,header,footer)
	local listObj = ListView.new(listView,self.Data[window],header,footer)
	self.Data[listView] = listObj
	return listObj
end

function GuiManager:RegisterRadialMenu(menu)
	local radial = RadialMenu.new(menu,self)
	self.Data[menu] = radial
	return radial
end

function GuiManager:RegisterDropdownMenu(window,dropdown,initialValue) --UDPATECHANGE
	local dropdownObj = DropdownMenu.new(dropdown,self.Data[window],initialValue)
	self.Data[dropdown] = dropdownObj
	return dropdownObj
end

function GuiManager:RegisterToggleButton(window,button,initialValue)
	local buttonObj = ToggleButton.new(button,self.Data[window],initialValue)
	self.Data[button] = buttonObj
	return buttonObj
end

function GuiManager:RegisterSlider(window,slider,initialValue)
	local sliderObj = Slider.new(slider,self.Data[window],initialValue)
	self.Data[slider] = sliderObj
	return sliderObj
end

--returns a list of gui object inside a window
function GuiManager:GetRegisteredObjectData(window)
	return self.Data[window]
end


function GuiManager:GetWindowDataByName(windowName)
	while self.DataNames[windowName] == nil do wait() end
	return self.DataNames[windowName]
end





local menuButtons = {}

function GuiManager:RegisterTopbarButton(button)
	
	--make icons more transparent on smaller screens
	if script.Parent.MainGui.AbsoluteSize.Y <= 480 and button:FindFirstChild("Icon") then
		button.Icon.ImageTransparency = .2
		if button:FindFirstChild("MoneyzCount") then
			button.TextTransparency = .2
		end
	end
	

	button.Changed:connect(function(prop)
		--icons color
		if prop == "Selected" and button:FindFirstChild("Icon") then
			
			if button.Selected then
				--SoundFX:PlaySound("Pop3")
				button.Icon.ImageColor3 = Color3.new(0, 162/255, 255/255)
			else
				button.Icon.ImageColor3 = Color3.new(1,1,1)
			end
			
		elseif prop == "Selectable" then --HOVER effect
			if button.Selectable then
				button.BackgroundColor3 = Color3.new(113/255,113/255,133/255)
			else
				button.BackgroundColor3 = Color3.new(31/255,31/255,31/255)
			end
				
		end
	end)
	
	table.insert(menuButtons,button)
end


local UIS = game:GetService("UserInputService")


local function FindButton(position)
	for _,button in ipairs(menuButtons) do
		if Utility:PointInsideGui(button,position,false) then
			return button
		end
	end
end


function GuiManager:CoreGuiGamepadActionsEnabed(enabled)
	for object,data in pairs(GuiManager.Data) do
		if data.Type == "Window" and data.IsCoreGuiWindow then
			data:GamepadActionsEnabled(enabled)
		end
	end
end

function GuiManager:CloseAllWindows()
	for object,data in pairs(GuiManager.Data) do
		if data.Type == "Window" and object.Visible and not data.IsCoreGuiWindow and object.Name ~= "Paycheck" and object.Name ~= "CustomizePet" and object.Name ~= "Tutorial" then
			UIEvents.WindowManuallyClosed:Fire(data.Object)
			data:SetVisible(false)
		end
	end
end


--top bar button detect which button was clicked
UIS.InputBegan:connect(function(inputObject, gameProccess)
	if gameProccess and inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
		local position = inputObject.Position
		if position.Y < 0 then
			local button = FindButton(position)
			if button then
				button.Selected = true
				UIEvents.TopbarButtonPressed:Fire(button)
				return
			end
		end
	end
end)


local lastHoveredButton

--top bar button hover over effect
if not UIS.TouchEnabled then
	UIS.InputChanged:connect(function(inputObject, gameProccess)
		if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
			local position = inputObject.Position
			if position.Y <= 10 then
				local button = FindButton(position)
				if button and not button.Selectable then
					button.Selectable = true
					if lastHoveredButton then
						
						lastHoveredButton.Selectable = false
					end
					lastHoveredButton = button
					return
				elseif not button and lastHoveredButton then
					lastHoveredButton.Selectable = false
					lastHoveredButton = nil
				end
			end
		end
	end)
end


setmetatable(GuiManager, {
	__index = GuiManager.Data,
	__newindex = GuiManager.Data
})


return GuiManager



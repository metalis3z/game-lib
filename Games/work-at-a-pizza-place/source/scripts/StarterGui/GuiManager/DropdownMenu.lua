local DropdownMenu = {}
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local UIEvents = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UIEvents")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiService = game:GetService("GuiService")

DropdownMenu.__index = DropdownMenu





function DropdownMenu.new(dropdownButton,windowData)

	local this = {}
	setmetatable(this, DropdownMenu)
	this.Object = dropdownButton
	this.Type = "DropDownMenu"
	this.WindowData = windowData
	this.List = {}
	this.TextButtons = {}
	this.ScrollingFrame = dropdownButton:WaitForChild("ScrollingFrame")
	this.SelectedOption = dropdownButton:WaitForChild("SelectedOption")
	this.Template = dropdownButton:WaitForChild("Template")
	this.MaxScreenCoverageScaleY = .5  -- .5 takes up half the screen 


	
	this.Object.MouseButton1Down:connect(function()

		local ScrollFrame = this.ScrollingFrame
		local Template = this.Template
		
		UIEvents.DropDownMenuOpened:Fire(this.WindowData.Object)
		
		if not ScrollFrame.Visible then
			ScrollFrame.Visible = true
			
			
			for i,optionName in ipairs(this.List) do
				local newButton = Template:clone()
				newButton.OptionName.Text = optionName
				newButton.Parent = ScrollFrame
				newButton.Visible = true
				newButton.Selectable = false
				
				if _G.GamepadEnabled then
					local previousButton = this.TextButtons[i-1]
					if previousButton then
						newButton.NextSelectionUp =  previousButton--previous button
						previousButton.NextSelectionDown = newButton
					end
					if newButton.OptionName.Text == this.SelectedOption.Text then
						GuiService.SelectedObject = newButton
					end
				end
				
				
				local originalColor = newButton.BackgroundColor3
				local originalTextColor = newButton.OptionName.TextColor3
			
				newButton.MouseButton1Click:connect(function()
					if _G.GamepadEnabled then
						GuiService.SelectedObject = dropdownButton
					end
					this.SelectedOption.Text = optionName
					this:Close()
					UIEvents.DropDownMenuOptionSelected:Fire(this.WindowData.Object,optionName)
				end)
				
				newButton.MouseEnter:connect(function()
					newButton.BackgroundColor3 = Color3.new(152/255, 152/255, 152/255)
					newButton.OptionName.TextColor3 = Color3.new(1,1,1)
				end)
				
				newButton.MouseLeave:connect(function()
					newButton.BackgroundColor3 = originalColor
					newButton.OptionName.TextColor3 = originalTextColor
				end)
					
				table.insert(this.TextButtons,newButton)
			end
			
			
			
			---Adjust Size Of Scrolling Frame
			local firstTextButton = this.TextButtons[1] 
			
			local listItemSize = (firstTextButton and firstTextButton.AbsoluteSize.Y) or 0 --template dosent have the accurate size, it changes when it goes inside the scrollingframe, get first item size instead
			
			local scrollSizeY = #this.List * listItemSize
			
			ScrollFrame.CanvasSize = UDim2.new(0,0,0,scrollSizeY)
			
			--make the scroll frame the same size as the CanvasSize as long as it take up less than half (by default) the screen
			if scrollSizeY < MainGui.AbsoluteSize.Y * this.MaxScreenCoverageScaleY then
				ScrollFrame.Size = UDim2.new(1,10,0,scrollSizeY)

				
			--make scrolling frame take up half (by defualt) the screen as long at it dosent go off screen
			elseif ScrollFrame.AbsolutePosition.Y + (MainGui.AbsoluteSize.Y * this.MaxScreenCoverageScaleY) < MainGui.AbsoluteSize.Y then
				ScrollFrame.Size = UDim2.new(1,10,0,MainGui.AbsoluteSize.Y * this.MaxScreenCoverageScaleY)

			--make scrolling frame aligh to the bottom of the screen
			else
				ScrollFrame.Size = UDim2.new(1,10,0,MainGui.AbsoluteSize.Y - ScrollFrame.AbsolutePosition.Y)
			end
		else
			this:Close()
		end
	end)
	
	
	
	return this
end



function DropdownMenu:SetList(list,initialSelectionName)
	if list then
		self.List = list
		self:Close()
		self.SelectedOption.Text = initialSelectionName or list[1] or ""
	end
end

function DropdownMenu:Close()
	self.ScrollingFrame.Visible = false
	for _,button in ipairs(self.TextButtons) do
		button:Destroy()
	end
	self.TextButtons = {}
end







return DropdownMenu

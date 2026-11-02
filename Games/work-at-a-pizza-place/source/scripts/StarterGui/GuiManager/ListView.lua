local ListView = {}
local ListItem = require(script:WaitForChild("ListItem"))
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local UIEvents = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UIEvents")
local GuiService = game:GetService("GuiService")


ListView.__index = ListView



function ListView.new(listFrame,windowData,header,footer)

	local this = {}
	setmetatable(this, ListView)

	this.ListItems = {}
	this.Object = listFrame
	this.Type = "ListView"
	this.ScrollingFrame = listFrame.Parent
	this.Template = nil
	this.WindowData = windowData
	this.CurrentSelection = nil
	this.NumListItems = 0
	this.Data = nil
	this.MultiSelectMode = false
	this.SingleSelectionMode = false --one item is hightlighed at a time
	this.NumColumbs = 0
	this.Header = header
	this.Footer = footer
	this.InternalHeader = nil --inside the scrolling frame i.e. - dropdownmenu inside inventory
	this.InternalFooter = nil
	this.UILayout = listFrame:FindFirstChild("UIGridLayout") or listFrame:FindFirstChild("UIListLayout") or listFrame:FindFirstChild("UITableLayout") 
	this.GamepadSelectFirstItemOnRefresh = false
	this.ListOffset = listFrame.AbsolutePosition.Y - this.ScrollingFrame.AbsolutePosition.Y
	this.RecycleRows = true --resuse the list item class or just delete all list item data after refresh
	this.AutoResize = false
	
	return this
end






function ListView:SetCellPadding(padding)
	self.UILayout.CellPadding = padding
end

function ListView:GetListItemIndex(listItemData)
	for i,listItem in ipairs(self.ListItems) do
		if listItem == listItemData then
			return i
		end
	end
end

function ListView:GetItemDataByProperyValue(property,value)
	for i,listItem in ipairs(self.ListItems) do
		if listItem.ItemData[property] == value then
			return i,listItem
		end
	end
end


--DOSENT WORK
function ListView:JumpToListItem(listItemObject)
	local firstItem = self.ListItems[1]
	if firstItem then
		local internalHeaderSizeY = (self.InternalHeader and self.InternalHeader.AbsoluteSize.Y) or self.ListOffset
		local newPos = (listItemObject.AbsolutePosition.Y - firstItem.AbsolutePosition.Y) + internalHeaderSizeY 
		self.ScrollingFrame.CanvasPosition = Vector2.new(0,newPos)
	end
end







function ListView:UpdateData(dataList,template,displayFunction)

	if not dataList then dataList = {} end
	self.Template = template
	self.Data = dataList
	self.NumListItems = #dataList
	
	template.Visible = false
	
	--save button names in order from left to right depending on layout order
	local internalButtons = {}
	for _,child in ipairs(template:GetChildren()) do
		if child:IsA("GuiButton") and child.Visible then
			table.insert(internalButtons,child.LayoutOrder,child.Name)
		end
	end
	
	
	if self.UILayout:IsA("UIGridLayout") then
		self.UILayout.CellSize = UDim2.new(0,template.AbsoluteSize.X,0,template.AbsoluteSize.Y)
		self.NumColumbs = math.floor((self.Object.AbsoluteSize.X + self.UILayout.CellPadding.X.Offset) / (self.UILayout.CellSize.X.Offset + self.UILayout.CellPadding.X.Offset))	
	else
		self.NumColumbs = 1
	end
	
	self.NumRows = math.ceil(#dataList / self.NumColumbs)
	

	
 	--update item data with new data
	local lastIndex = 0
	
	
	
	for i,data in ipairs(dataList) do
		
		if not self.RecycleRows and self.ListItems[i] then --delete all old listitems if not recycling
			self.ListItems[i]:Delete()
			self.ListItems[i] = nil
		end 
		
		local item = (self.RecycleRows and self.ListItems[i]) or ListItem.new(self,self.WindowData)
		item:SetTemplate(template)
		item:UpdateDisplay(data,i,displayFunction) --update the buttons display with new info and image
		item.Object.LayoutOrder = i
		
		
		self.ListItems[i] = item

	
		local previousItem = self.ListItems[i-1]
		
		
		if #internalButtons == 0 then  --can be frame (like ratings list) or guibutton

			--left and right selections for grid layout
			if previousItem and self.UILayout:IsA("UIGridLayout") then
				previousItem.Object.NextSelectionRight = item.Object
				item.Object.NextSelectionLeft = previousItem.Object
			end
		
		--up and down selections
			if i-self.NumColumbs > 0 then
				item.Object.NextSelectionUp = self.ListItems[i-self.NumColumbs].Object
				
				self.ListItems[i-self.NumColumbs].Object.NextSelectionDown = item.Object
			else
				item.Object.NextSelectionUp = nil
			end
		
		
		
		else  --navigate internal buttons -- only works with UIlistlayout

			local previousButton
			--goes through each button starting from the left
			for _,buttonName in ipairs(internalButtons) do
				
				local currentButton = item.Object[buttonName]
				
				if i-self.NumColumbs > 0 then
					currentButton.NextSelectionUp = self.ListItems[i-self.NumColumbs].Object[buttonName]
						
					self.ListItems[i-self.NumColumbs].Object[buttonName].NextSelectionDown = currentButton
				else
					currentButton.NextSelectionUp = nil
				end
				
					
				if previousButton then
					currentButton.NextSelectionLeft = previousButton
					previousButton.NextSelectionRight = currentButton
				end
				
					
				previousButton = item.Object[buttonName]
					
			end
			
		end
		
		item.Object.NextSelectionDown = nil
		item.Object.NextSelectionRight = nil
		
		lastIndex = i
	end	
	
	lastIndex = lastIndex + 1
	
	--delete unused list items
	for i=lastIndex,#self.ListItems do
		if self.ListItems[i] and self.ListItems[i].Object then
			self.ListItems[i]:Delete()
			self.ListItems[i] = nil
		end
	end
	
	
	

	
	
	
	
	
	--start selection back at the top when list is refreshed 
	if _G.GamepadEnabled and self.GamepadSelectFirstItemOnRefresh and #dataList > 0 then
		if #internalButtons == 0 then
			game:GetService("GuiService").SelectedObject = self.ListItems[1].Object
		else
			game:GetService("GuiService").SelectedObject = self.ListItems[1].Object[internalButtons[1]] --select button farthest to the left
		end
	end
	


	--external header to footer scrolling frame resize
	local headerSizeY = (self.Header and self.Header.AbsoluteSize.Y) or (self.ScrollingFrame.AbsolutePosition.Y - self.WindowData.Object.AbsolutePosition.Y)
	local footerSizeY = (self.Footer and self.Footer.AbsoluteSize.Y) or 0
	if self.AutoResize then
		self.ScrollingFrame.Size = UDim2.new(
			self.ScrollingFrame.Size.X.Scale,
			self.ScrollingFrame.Size.X.Offset,
			1,
			- (headerSizeY + footerSizeY)
		)
	end
	
	
	--internal header to footer canvas resize
	local internalHeaderSizeY = (self.InternalHeader and self.InternalHeader.AbsoluteSize.Y) or self.ListOffset
	local internalFooterSizeY = (self.InternalFooter and self.InternalFooter.AbsoluteSize.Y) or 0

	if self.UILayout:IsA("UIGridLayout") then
		self.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,(self.NumRows * (self.UILayout.CellSize.Y.Offset + self.UILayout.CellPadding.Y.Offset)) + (internalHeaderSizeY + internalFooterSizeY))
	
	elseif self.UILayout:IsA("UIListLayout") then
		self.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,(self.NumRows * (template.AbsoluteSize.Y + self.UILayout.Padding.Offset)) + (internalHeaderSizeY + internalFooterSizeY))
	
	elseif self.UILayout:IsA("UITableLayout") then
		self.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,(self.NumRows * (template.AbsoluteSize.Y + self.UILayout.Padding.Y.Offset)) + (internalHeaderSizeY + internalFooterSizeY))
	
	end	

		
	self.ScrollingFrame.CanvasPosition = Vector2.new(0,0)
	
	
	self:SetSelection(nil)
	
	
		
	if self.Footer or self.InternalFooter then
		print(#self.ListItems,"SAA")
		for i,itemData in ipairs(self.ListItems) do
			if itemData.Object.NextSelectionDown == nil then
				local footer = self.InternalFooter or self.Footer --internal comes first if it exists
				itemData.Object.NextSelectionDown = footer 
				footer.NextSelectionUp = itemData.Object --nextselectionup points to last object in list only
				print(itemData.Object,"HAHA")
			end
		end
		if self.Footer and self.InternalFooter then
			self.Footer.NextSelectionUp = self.InternalFooter
			self.InternalFooter.NextSelectionUp = self.Footer
		end
	end
	
	
	if self.Header or self.InternalHeader then
		for i,itemData in ipairs(self.ListItems) do
			if itemData.Object.NextSelectionUp == nil then
				local header = self.InternalHeader or self.Header --internal comes first if it exists
				itemData.Object.NextSelectionUp = header
				if header.NextSelectionDown == nil then --nextselectiondown points to first object in list only
					header.NextSelectionDown = itemData.Object
				end 
			end
		end
		if self.Header and self.InternalHeader then
			self.Header.NextSelectionDown = self.InternalHeader
			self.InternalHeader.NextSelectionDown = self.Header
		end
	end
	

	
	
end




function ListView:DisableListItems(disabled)
	for _,item in ipairs(self.ListItems) do
		item.Disabled = disabled
	end
end



function ListView:SetSelection(listItem,button)
	
	--unselect previous
	if not self.MultiSelectMode and self.CurrentSelection then
		self.CurrentSelection:SetSelected(false) 
	end
	
	
	if listItem then
		listItem:SetSelected(true)
		self.CurrentSelection = listItem
		
		UIEvents.ListItemPressed:Fire(self.WindowData.Object,self.Object,button or listItem.Object,listItem.ItemData)

	end
end




return ListView

local player = game.Players.LocalPlayer
local Window = script.Parent
local GuiService = game:GetService("GuiService")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local ScrollingFrame = Window:WaitForChild("ScrollingFrame")
local List = ScrollingFrame:WaitForChild("List")
local Template = Window:WaitForChild("Template")
local DropDownButton = ScrollingFrame:WaitForChild("DropDownButton")
local Backpack = Window.Parent:WaitForChild("Backpack")
local RemoveHats = Window:WaitForChild("RemoveHats")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Tabs = Window:WaitForChild("Tabs")
local Enums =  require(game.ReplicatedStorage:WaitForChild("Enums"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))


local WindowData = GuiManager:RegisterWindow(Window,"Right","Right")
local TabsData = GuiManager:RegisterTabs(Window,Tabs)
local ListViewData = GuiManager:RegisterListView(Window,List)
local DropdownMenuData = GuiManager:RegisterDropdownMenu(Window,DropDownButton,"All")



local CurrentType = "Furniture"
local CurrentCategory = "All"
local InventoryData = nil -- {AssetId = 123455, Quantity = 1, Name = "Stove"}
local SellMode = false
local isSmallScreen = false
local inventoryWidth = Window.AbsoluteSize.X
local MAX_NUM_HATS = 3


ListViewData.InternalHeader = DropDownButton

--for mobile players or super small computer screens
local TouchEnabled = game:GetService("UserInputService").TouchEnabled
if MainGui.AbsoluteSize.X < inventoryWidth * 3 or TouchEnabled then
	isSmallScreen = true
	Template.Quantity.Size = UDim2.new(0.5,0,.45,0)
	Template.Size = UDim2.new(0,65,0,65)
	ListViewData:SetCellPadding(UDim2.new(0,1,0,1))
end


if Enums.GamepadEnabled then
	Template.Size = UDim2.new(0,110,0,110)
	ListViewData:SetCellPadding(UDim2.new(0,3,0,3))
end


WindowData:SetConsoleSize(UDim2.new(0,360,1,0))
WindowData.FirstSelectedObject = DropDownButton
ListViewData.SingleSelectionMode = true
TabsData:SetConsoleSize(UDim2.new(0,240,0,50))
GuiService:AddSelectionTuple("InventoryGroup",List,DropDownButton,RemoveHats)


DropdownMenuData.MaxScreenCoverageScaleY = 1


if not Enums.IsOnline and TouchEnabled then
	ScrollingFrame.ScrollingEnabled = false
end



ListDisplayFunction = function(objectData,object,listItemData,index)
		
	object.Style = Enum.ButtonStyle.RobloxRoundButton
		
	if listItemData.Category == "Shirts" or listItemData.Category == "Pants" then
		object.Thumbnail.Image = "http://www.roblox.com/Thumbs/Asset.ashx?Width=100&Height=100&AssetID=" .. listItemData.AssetId
	else
		object.Thumbnail.Image = "http://www.roblox.com/Thumbs/Asset.ashx?Width=75&Height=75&AssetID=" .. listItemData.AssetId
	end
		
	local Type = Enums.CategoryToType[listItemData.Category]
	if Type == "Furniture" and listItemData.Quantity > 1 then
		object.Quantity.Text = "X" .. listItemData.Quantity
		object.Quantity.Backdrop.Text = "X" .. listItemData.Quantity
	else
		object.Quantity.Text = ""
		object.Quantity.Backdrop.Text = ""
	end
		
		
	if objectData.ListView.MultiSelectMode or (listItemData.Category == "Shirts" or listItemData.Category == "Pants")  then
		if player.Backpack:FindFirstChild(listItemData.Name) or player.Character:FindFirstChild(listItemData.Name) then
			object.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
		else
			object.Style = Enum.ButtonStyle.RobloxRoundButton
		end
	end
		
end
	

function GetSortedItemsFromInventory()
	local items = {}
	if not InventoryData then return end
	for _,item in ipairs(InventoryData) do
		if Enums.CategoryToType[item.Category] == CurrentType then
			if item.Category == CurrentCategory or CurrentCategory == "All" then
				table.insert(items,item)
			end
		end
	end
	return items
end



function SortByFurnitureSet()
	local sets = {}
	local items = {}
	
	if not InventoryData then return end
	
	for _,item in ipairs(InventoryData) do
		local setName = item.Name:match("%a+")
		sets[setName] = sets[setName] or {}
		table.insert(sets[item.Name:match("%a+")],item)
	end
	
	local setsList = {}
	for setName,items in pairs(sets) do
		if #items >= 3 then
			for _,item in ipairs(items) do
				table.insert(setsList,item)
			end
		end
	end
	return setsList
end

--default categories
local DropMenuHistory = {
	Furniture = "All",
	WallsFloors = "Walls",
	Clothing = "Hats",
	Gear = "All",
	Vehicles = "All",
}




function RefreshScrollingFrame()
		
	if SellMode or CurrentType == "Gear" then
		ListViewData.MultiSelectMode = true
		RemoveHats.Visible = false
		ListViewData.Footer = nil
		RemoveHats.NextSelectionUp = nil

	elseif CurrentType == "Clothing" and CurrentCategory == "Hats" then
		ListViewData.MultiSelectMode = true
		RemoveHats.Visible = true
		ListViewData.Footer = RemoveHats
	else
		ListViewData.MultiSelectMode = false
		RemoveHats.Visible = false
		ListViewData.Footer = nil
		RemoveHats.NextSelectionUp = nil
	end
		
		
	local items = GetSortedItemsFromInventory(CurrentType)
	ListViewData:UpdateData(items,Template,ListDisplayFunction)
	
	
end


local currentTab
function TabChanged(window,tab)
	if window == Window and InventoryData then
		CurrentType = tab.Name
		CurrentCategory = DropMenuHistory[CurrentType] --
		currentTab = tab


		--remove dropmenu if gear or vehicle tab
		local categoryList = Enums.TypeToCategoryList[CurrentType]
		if categoryList == nil or #categoryList == 0 then
			DropDownButton.Visible = false
			DropDownButton.NextSelectionDown = nil
			--DropDownButton.Selectable = false
			ListViewData.InternalHeader = nil
		else
			DropDownButton.Visible = true
			--DropDownButton.Selectable = true
			ListViewData.InternalHeader = DropDownButton
		end
		
		DropdownMenuData:SetList(categoryList,CurrentCategory)
		
		
		RefreshScrollingFrame()
		
		
		if _G.GamepadEnabled then
			if DropDownButton.Visible and #ListViewData.ListItems > 0 then
				GuiService.SelectedObject = DropDownButton
				
			elseif not DropDownButton.Visible and #ListViewData.ListItems > 0 then
				GuiService.SelectedObject = ListViewData.ListItems[1].Object

			end
		end
		
		
	end
end





UIEvents.TabChanged.Event:connect(TabChanged)


local currentItemData

--when item from list is selected
UIEvents.ListItemPressed.Event:connect(function(window,listContainer,listItem,itemData)
	if window == Window and InventoryData then
		if listContainer == List then
			
			
			
			if SellMode then 
				ListViewData:DisableListItems(true)
			
				if not itemData.Unsellable then
					
					currentItemData = nil
					local price = Utility:SendData("GetAssetPrice","AssetLibraryManagerChannel",10,itemData.AssetId)
					if price then
						if Dialog:GetChoice("Sell","Sell " .. itemData.Name .. " for " .. Utility:AddCommas(math.floor(price/2)) .. " Moneyz?","Yes","No") then
							Utility:SendData("SellInventoryItem","PlayerChannel",nil,itemData.AssetId)
							SoundFX:PlaySound("CashRegister")
						
						else
							listItem.Style = Enum.ButtonStyle.RobloxRoundButton
						end
					end
					
				else
					Dialog:ShowMessage("Unsellable","You cannot sell this item.")
				end
				
				ListViewData:DisableListItems(false)
				
				return
			
			end
			
			
			 currentItemData = itemData
			if itemData.Type == "Furniture" then
				workspace.Main.InventoryItemSelected:Fire(itemData.AssetId,isSmallScreen) --start dragging
				
			
			elseif itemData.Type == "WallsFloors" then
				Utility:SendData("SetWallFloor","HouseChannel",nil,itemData.AssetId)
				
			elseif itemData.Type == "Gear" then
				
				--tween just the thumbnail
				local thumbnail = listItem.Thumbnail:clone()
				thumbnail.Size = (isSmallScreen and UDim2.new(0,40,0,40)) or UDim2.new(0,60,0,60)
				thumbnail.Parent = MainGui
				
				local buttonAbsPos = UDim2.new(0,listItem.AbsolutePosition.X,0,listItem.AbsolutePosition.Y)
				local backpackPos = UDim2.new(0,Backpack.AbsolutePosition.X,0,Backpack.AbsolutePosition.Y)
				
				--remove from backpack and put in inventory
				if player.Backpack:FindFirstChild(itemData.Name) or player.Character:FindFirstChild(itemData.Name) then
					listItem.Style = Enum.ButtonStyle.RobloxRoundButton
					
					thumbnail.Position = backpackPos
					
					local item = player.Backpack:FindFirstChild(itemData.Name)
					if player.Character:FindFirstChild(itemData.Name) then
						item = player.Character:FindFirstChild(itemData.Name)
						item.Parent = player.Backpack
					end
					wait()
					item:Destroy()

					thumbnail:TweenPosition(buttonAbsPos,Enum.EasingDirection.Out,Enum.EasingStyle.Sine,.3,false,function() 
						thumbnail:Destroy()
					end)
					
					Utility:SendData("UnsaveBackpackItem","PlayerChannel",nil,itemData.AssetId,itemData.Category)
		
				else-- add to backpack
					thumbnail.Position = buttonAbsPos
					thumbnail:TweenPosition(backpackPos,Enum.EasingDirection.Out,Enum.EasingStyle.Sine,.3,false,function() 
						thumbnail:Destroy()
						if not player.Backpack:FindFirstChild(itemData.Name) and not player.Character:FindFirstChild(itemData.Name) then
							game.Workspace.Main.LoadRobloxItem:FireServer(itemData.AssetId,"Gear")
							Utility:SendData("SaveBackpackItem","PlayerChannel",nil,itemData.AssetId,itemData.Category)

						end
					end)
					
					listItem.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
					

				end
				
				
				
			elseif itemData.Category == "Hats" and player.Character and player.Character:FindFirstChild("Head") then
				
			
				local thumbnail = listItem.Thumbnail:clone()
				thumbnail.Size = (isSmallScreen and UDim2.new(0,55,0,55)) or UDim2.new(0,72,0,72)
				thumbnail.Parent = MainGui
				
				local vectorHeadPos,visible = workspace.CurrentCamera:WorldToScreenPoint(player.Character.Head.Position)
				local headPos = UDim2.new(0,vectorHeadPos.X-thumbnail.Size.X.Offset/2,0,vectorHeadPos.Y-thumbnail.Size.Y.Offset/2)
				local buttonAbsPos = UDim2.new(0,listItem.AbsolutePosition.X,0,listItem.AbsolutePosition.Y)
				
				--remove hat
				if player.Character:FindFirstChild(itemData.Name) then
					
					--tween copy from head to listitem
					thumbnail.Position = headPos
					player.Character:FindFirstChild(itemData.Name):Destroy()
					thumbnail:TweenPosition(buttonAbsPos,Enum.EasingDirection.Out,Enum.EasingStyle.Sine,.3,false,function() 
						
						thumbnail:Destroy()
					end)
					
					listItem.Style = Enum.ButtonStyle.RobloxRoundButton

					Utility:SendData("UnsaveClothing","PlayerChannel",nil,itemData.AssetId,itemData.Category)
				
				else --add hat
					
					--count num of hats on player
					local hatCount = 0
					for _,obj in ipairs(player.Character:GetChildren()) do
						if obj:IsA("Accessory") or obj:IsA("Hat") then
							hatCount = hatCount + 1
						end
					end
					
					if hatCount < MAX_NUM_HATS then
						
					
						--tween copy from listitems to head
						thumbnail.Position = buttonAbsPos
						thumbnail:TweenPosition(headPos,Enum.EasingDirection.Out,Enum.EasingStyle.Sine,.3,false,function() 
							thumbnail:Destroy()
							if not player.Character:FindFirstChild(itemData.Name) then
								game.Workspace.Main.LoadRobloxItem:FireServer(itemData.AssetId,"Hats")
								Utility:SendData("SaveClothing","PlayerChannel",nil,itemData.AssetId,"Hats")
							end
	
						end)
						listItem.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
					
					else
						Dialog:ShowMessage("Too many hats","You can only put 3 hats on at a time.")
						listItem.Style = Enum.ButtonStyle.RobloxRoundButton
						thumbnail:Destroy()
					end

				end
				
				
				
			elseif (itemData.Category == "Packages" or itemData.Category == "Pants" or itemData.Category == "Shirts") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				
				
				
				local vectorTorsoPos,visible = workspace.CurrentCamera:WorldToScreenPoint(player.Character.HumanoidRootPart.Position)
				local buttonAbsPos = UDim2.new(0,listItem.AbsolutePosition.X,0,listItem.AbsolutePosition.Y)
				local thumbnail = listItem.Thumbnail:clone()
				
				thumbnail.Size = (isSmallScreen and UDim2.new(0,55,0,55)) or UDim2.new(0,72,0,72)
				thumbnail.Parent = MainGui
				
					
				--tween copy from listitems to head
				thumbnail.Position = buttonAbsPos
				thumbnail:TweenPosition(UDim2.new(0,vectorTorsoPos.X,0,vectorTorsoPos.Y),Enum.EasingDirection.Out,Enum.EasingStyle.Sine,.3,false,function() 
					thumbnail:Destroy()
					if itemData.Category == "Packages" then
						game.Workspace.Main.LoadRobloxItem:FireServer(itemData.AssetId,"Packages")
					else --clothing
						game.Workspace.Main.LoadClothing:FireServer(itemData.AssetId,itemData.Name,itemData.Category) --clothing
					end
					Utility:SendData("SaveClothing","PlayerChannel",nil,itemData.AssetId,itemData.Category)
				
				end)
				
				listItem.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
				
			end
		end
	end
end)


workspace.Main.SellItemsMode.OnClientEvent:connect(function()
	Window.Sell.Visible = true
	SellMode = true
	WindowData:SetVisible(true)
end)


--lets the client know the current quantity of an item
workspace.Main.InventoryItemQuantityChanged.OnClientEvent:connect(function(assetId,quantity)
	if InventoryData then
	
		--allows player to continuously place the same furniture until the quantity = 0
		--[[if currentItemData and currentItemData.AssetId == assetId and currentItemData.Type == "Furniture" then
			if quantity and quantity ~= 0 and quantity < currentItemData.Quantity then --if placing furniture, if removing furniture then quantity > current item quantity
				workspace.Main.InventoryItemSelected:Fire(currentItemData.AssetId)
			end
		end]]
		
		--find inventory item and set to new quantity
		for i,item in ipairs(InventoryData) do
			if item.AssetId == assetId then
				item.Quantity = quantity
				if item.Quantity <= 0 then
					table.remove(InventoryData,i)
					
				end
		
				local items = GetSortedItemsFromInventory(currentTab.Name)
				ListViewData:UpdateData(items,Template,ListDisplayFunction)

				
				return
			end
		end
	end
end)


workspace.Main.InventoryItemAdded.OnClientEvent:connect(function(itemData)
	if InventoryData then
		itemData.Type = Enums.CategoryToType[itemData.Category]
		table.insert(InventoryData,1,itemData)
		TabChanged(Window,currentTab)
	end
end)


local firstTimeVisible = true





UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
	
	
	
	if window == Window and visible then
		
		if _G.TutorialEnabled then
			workspace.TutorialService.PlayerAction:FireServer("InventoryOpened",true)
		end
		
		currentItemData = nil
		InventoryData = Utility:SendData("GetInventory","PlayerChannel",2) or Utility:SendData("GetInventory","PlayerChannel",2)
		
						
		if InventoryData == nil then 
			Dialog:ShowMessage("Error","There was a error while loading your inventory. Try again later")
			return
		end
		
		--add "Type" feild to all the inventory items
		for i,item in ipairs(InventoryData) do
			InventoryData[i].Type = Enums.CategoryToType[item.Category]
		end
		
		
		if firstTimeVisible then --show the furniture tab
			firstTimeVisible = false
			TabsData:SetFirstTabPressed(Tabs.Furniture)
		end
	
		
		
		
	elseif window == Window and not visible then
		Window.Sell.Visible = false
		SellMode = false
	
	end
end)




RemoveHats.MouseButton1Click:connect(function()
	for _,obj in ipairs(player.Character:GetChildren()) do
		if obj:IsA("Accessory") or obj:IsA("Hat") then
			obj:Destroy()
		end
	end
end)


--disable scrolling when player is choosing category from list
UIEvents.DropDownMenuOpened.Event:connect(function(window)

	if window == Window then
		ScrollingFrame.CanvasSize = UDim2.new(0,0,0,0)--.ScrollingEnabled = false
	end
	
end)


UIEvents.DropDownMenuOptionSelected.Event:connect(function(window,optionName)

	if window == Window then
		CurrentCategory = optionName
		DropMenuHistory[CurrentType] = CurrentCategory
				
		RefreshScrollingFrame()
		
	end
	
end)


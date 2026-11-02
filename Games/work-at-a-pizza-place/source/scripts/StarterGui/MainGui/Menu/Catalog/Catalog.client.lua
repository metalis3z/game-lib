local Window = script.Parent
local player = game.Players.LocalPlayer
local GuiService = game:GetService("GuiService")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums =  require(game.ReplicatedStorage:WaitForChild("Enums"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
--local Enums = require(game.ReplicatedStorage:WaitForChild("Dialog"))


local Categories = Window:WaitForChild("Categories")
local Tabs = Window:WaitForChild("Tabs")
local ScrollingFrame = Window:WaitForChild("ScrollingFrame")
local List = ScrollingFrame:WaitForChild("List")
local Templates = Window:WaitForChild("Templates")
local Template = Templates:WaitForChild("Template")
local GamePassTemplate = Templates:WaitForChild("GamePassTemplate")
local MoneyzTemplate = Templates:WaitForChild("MoneyzTemplate")
local Title = Window:WaitForChild("Title")


if Enums.GamepadEnabled then
	Tabs.AnchorPoint = Vector2.new(.5,0)
	Tabs.Position = UDim2.new(.5,0,0,30)
	Title.TextYAlignment = Enum.TextYAlignment.Bottom
end


local MIN_ROW_SIZE = 330
--expand horizontally
if ScrollingFrame.AbsoluteSize.X <= MIN_ROW_SIZE then
	--Window.Position = UDim2.new(0,0,Window.Position.Y.Scale,Window.Position.Y.Offset)
	
	Window.Size = UDim2.new(1,0,Window.Size.Y.Scale,Window.Size.Y.Offset)
	
	--WindowData:UpdateTweenEndPoints()
end


local isSmallScreen = false

local OriginalSize = Window.Size
local OriginalPosition = Window.Position

local WindowData = GuiManager:RegisterWindow(Window,"Left","Right",nil,nil,true)
local TabsData = GuiManager:RegisterTabs(Window,Tabs)
local ListViewData = GuiManager:RegisterListView(Window,List)

local CurrentType = "Furniture"
local CurrentCategory = "All"
local currentTab

local CatalogData =  Utility:SendData("GetAssetLibrary","AssetLibraryManagerChannel",10) or Utility:SendData("GetAssetLibrary","AssetLibraryManagerChannel",10) or {} -- {AssetId = 123455, Quantity = 1, Name = "Stove"}


ListViewData.SingleSelectionMode = true
TabsData:SetConsoleSize(UDim2.new(0,350,0,50))





if Enums.CanChat == false then
	 CatalogData["157972955"] = nil --remove signs
end

--add "Type" and assetID field to all the inventory items
for id,data in pairs(CatalogData) do
	CatalogData[id].Type = Enums.CategoryToType[data.Category]
	CatalogData[id].AssetId = tonumber(id)
end


local MaxListSize = #Enums.TypeToCatalogCategoryList.Furniture * Categories.Template.AbsoluteSize.Y
local willCategoryListOverflow = Categories.AbsoluteSize.Y < MaxListSize

if willCategoryListOverflow then --expand window vertically so more categoies show so player doesnt have to scroll as much
	--Window.Position = UDim2.new(Window.Position.X.Scale,Window.Position.X.Offset,0,0)
	Window.Size = UDim2.new(Window.Size.X.Scale,Window.Size.X.Offset,1,0)
	--Categories.Size = UDim2.new(Categories.Size.X.Scale,Categories.Size.X.Offset,1,-83) -- gets rid of bottom padding
	--ScrollingFrame.Size = UDim2.new(ScrollingFrame.Size.X.Scale,ScrollingFrame.Size.X.Offset,1,-83) -- gets rid of bottom padding
	
	WindowData:UpdateTweenEndPoints()
	
	--check again to see if it will still over flow
	willCategoryListOverflow = Categories.AbsoluteSize.Y < MaxListSize
	if willCategoryListOverflow then
		
		--remove title and push everything up
		Title.Visible = false

		Categories.Position = UDim2.new(0,1,0,40)
		Categories.Size = UDim2.new(0,150,1,-40)
		
		ScrollingFrame.Position = UDim2.new(0,150,0,40)
		ScrollingFrame.Size = UDim2.new(1,-170,1,-40)
		
		Tabs.Position = UDim2.new(0,0,0,0)
		Tabs.Size = UDim2.new(1,-50,0,40)
		
		Template.Size = UDim2.new(1,0,0,125)

	end
	
end






--make window size and template size bigger for xbox
if Enums.GamepadEnabled then
	Categories.Template.Size = UDim2.new(1,-5,0,39)
	Template.Size = UDim2.new(1,0,0,210)
	GamePassTemplate.Size = UDim2.new(1,0,0,210)
	MoneyzTemplate.Size = UDim2.new(1,0,0,210)
end







local GamePassList = {}
local MoneyzList = {}

--turns key,value data into sorted list based on .Index value
local function MakeList(list,productData)
	for nameId,data in pairs(productData) do
		data.NameId = nameId
		list[data.Index] = data
	end
end
MakeList(GamePassList,Enums.GamePasses)
MakeList(MoneyzList,Enums.Moneyz)

-- dont let mobile players buy deivery bike
if game:GetService("UserInputService").TouchEnabled then
	for i,pass in ipairs(GamePassList) do
		if pass.NameId == "DeliveryBike" then
			table.remove(GamePassList,i)
		elseif pass.NameId == "PontoonBoat" and Enums.IsPartyServer then
			table.remove(GamePassList,i)
		end
	end
end








workspace.Main.ProductPurchaseComplete.OnClientEvent:connect(function(nameId)
	
	if nameId == nil then return end
	
	SoundFX:PlaySound("CashRegister")

	--if bough a gamepass
	for i,pass in ipairs(GamePassList) do
		if pass.NameId == nameId then
			GamePassList[i].Owned = true
		end
	end
	
	--hide catalog so paycheck can come in
	if Enums.Moneyz[nameId] then
		WindowData:SetVisible(false)
	end
	
	TabChanged(Window,currentTab) --refresh tab
end)

local GamePassesOwned =  Utility:SendData("GetGamePasses","PlayerChannel",10) or Utility:SendData("GetGamePasses","PlayerChannel",10) or {}

for i,pass in ipairs(GamePassList) do
	if GamePassesOwned[pass.NameId] then
		GamePassList[i].Owned = true
	end
end



--for gamepasses and moneyz
UIEvents.ListItemPressed.Event:connect(function(window,listContainer,listItem,itemData)
	if window == Window then
		if listContainer == List then
			if itemData.Category == "GamePasses" or itemData.Category == "Moneyz" then
				if not Enums.FreeMode and not Enums.Admins[player.Name] and Enums.IsTestPlace then
					Dialog:ShowMessage("","You cannot make purchases on the test server.")
					return
				end
				if not _G.StartedPlaying  then
					Dialog:ShowMessage("Error","You cannot buy items right now. Try rejoining the game.")
					return
				end
				if itemData.Name == "Pontoon Boat" and not Utility:SendData("GetSettings","PlayerChannel",10).WaterEnabled then
					if Dialog:GetChoice("Detailed water","You must have detailed water enabled to buy the boat. Would you like to enabled it now?","Yes","No") then
						GuiManager[MainGui.Menu.Settings.SettingOptions.WaterEnabled.ToggleButton]:Toggle(true)
					end
				end
				
				local foundUncashedCheck = workspace.Main.CheckForUncashedChecks:InvokeServer()
				
				if Enums.FreeMode then
					workspace.Main.FreeProducts:FireServer(itemData.ProductId)
				
				elseif foundUncashedCheck then --make player cash check before letting the player buy more moneyz. Only one check at a time can be cashed
					Dialog:ShowMessage("","You need to cash your check first before buying another.")
				else
					game:GetService("MarketplaceService"):PromptProductPurchase(player, itemData.ProductId)
				end
			else
				if Dialog:GetChoice("Purchase","Would you like to buy " .. itemData.Name .. " for " .. itemData.Price .. " Moneyz?","Yes","No") then
					WindowData.Object.BuyButtonPressed:Fire(listItem,itemData)
				end
			end
		end
	end
end)






function GetSortedCatalog(byPrice)
	local items = {}
	for id,data in pairs(CatalogData) do
		if not data.Discontinued and not (data.DisabledOnConsole and _G.GamepadEnabled) and Enums.CategoryToType[data.Category] == CurrentType then
			if data.Category == CurrentCategory or CurrentCategory == "All" then
				if not byPrice or #items == 0 then
					table.insert(items,data)
				else
					local inserted = false
					for i,item in pairs(items) do
						if data.Price < item.Price then
							table.insert(items,i,data)
							inserted = true
							break
						end
					end
					if not inserted then
						table.insert(items,data)
					end
				end
			end
		end
	end
	return items
end



function SortByFurnitureSet()
	local sets = {}
	local items = {}
	for _,item in ipairs(CatalogData) do
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
local CategoryHistory = {
	Furniture = "Beds",
	WallsFloors = "Walls",
	Clothing = "Hats",
	Gear = "All",
	Vehicles = "All",
	GamePasses = "All",
	Moneyz = "All"
}



DisplayFunction = function(objectData,object,listItemData,index)
		
		if listItemData.Category == "GamePasses" or listItemData.Category == "Moneyz" then
			
			object.Thumbnail.Image = "rbxassetid://" .. listItemData.ImageId
			object.ItemName.Text = listItemData.Name
			
			
			object.Price.CurrencyAmount.Text = tostring(listItemData.Price)
			

			if listItemData.ProductId == 19762535 then --money bag
				object.Shareable.Visible = true
			end
			
			if listItemData.Owned then
				object.Price.Visible = false
				object.Owned.Visible = true
			end
			
			
		
		else
			object.Thumbnail.Image = "http://www.roblox.com/Thumbs/Asset.ashx?Width=75&Height=75&AssetID=" .. listItemData.AssetId
			object.Thumbnail.New.Visible = (listItemData.New and listItemData.New + 1209600 > tick() and true) or false
			object.Moneyz.Text = Utility:AddCommas(math.floor(listItemData.Price))
		end
			
			--absolute size dosent not update fast enough, need delay
			
			
		
		object.ItemName.Text = listItemData.Name
		
	
		spawn(function()
			while object.ItemName.AbsoluteSize.Y == 0 do wait() end
			if listItemData.Category ~= "Moneyz" then
				object.ItemName.Size = UDim2.new(1,12,.16,0)
				
				if object.ItemName.TextBounds.Y < object.ItemName.AbsoluteSize.Y then
					object.ItemName.Size = UDim2.new(1,12,.32,0)
				end
			end
		
		end) 
	end




function UpdateListViewData()

	if CurrentType == "GamePasses" then
		ListViewData:UpdateData(GamePassList,GamePassTemplate,DisplayFunction)
	elseif CurrentType == "Moneyz" then
		ListViewData:UpdateData(MoneyzList,MoneyzTemplate,DisplayFunction)
	else
		local items = GetSortedCatalog(true)
		ListViewData:UpdateData(items,Template,DisplayFunction)
	end
end



local categoryButtons = {}
local CategoryButton


function TabChanged(window,tab)

	if window == Window then
		CurrentType = tab.Name
		CurrentCategory = CategoryHistory[CurrentType] --
		currentTab = tab
		
		Title.Text = tab.Name
		
		for _,button in ipairs(categoryButtons) do
			button:Destroy()
		end
		
		
		
		--create side category buttons
		for i,category in ipairs(Enums.TypeToCatalogCategoryList[CurrentType]) do
			local button = Categories.Template:clone()
			button.Parent = Categories
			button.Position = UDim2.new(0,5,0,button.Size.Y.Offset*(i-1))
			button.TextLabel.Text = category
			button.Visible = true
			
			Categories.CanvasSize = UDim2.new(0,0,0,i * button.AbsoluteSize.Y)
			
			table.insert(categoryButtons,button)
			
			if category == CurrentCategory then
				button.BackgroundTransparency = 0.2
				button.BackgroundColor3 = Color3.new(94/255,94/255,94/255)
				
				CategoryButton = button
				if Enums.GamepadEnabled then
					GuiService.SelectedObject = button
				end
	
			else
				button.BackgroundTransparency = 0.7
			end
			
			button.MouseButton1Click:connect(function()
				if button ~= CategoryButton then
					CategoryButton.BackgroundTransparency = 0.7
					CategoryButton.BackgroundColor3 = Color3.new(31/255,31/255,31/255)
					button.BackgroundTransparency = 0.2
					button.BackgroundColor3 = Color3.new(94/255,94/255,94/255)
					CategoryButton = button
					CurrentCategory = category
					UpdateListViewData()
					button.NextSelectionRight = ListViewData.ListItems[1].Object --select first item in catalog

					if Enums.GamepadEnabled then
						GuiService:RemoveSelectionGroup("CatalogGroup")
						GuiService:AddSelectionTuple("CatalogGroup",ScrollingFrame,Categories)
						local numColumbs = ListViewData.NumColumbs
						for i,itemData in ipairs(ListViewData.ListItems) do
							if math.fmod(i,numColumbs) == 1 then
								itemData.Object.NextSelectionLeft = button
							end
						end
					end
				end
			end)
			
			
			button.MouseLeave:connect(function()
				if CategoryButton ~= button then
					button.BackgroundColor3 = Color3.new(31/255,31/255,31/255)
				end
			end)
			
			button.MouseEnter:connect(function()
				button.BackgroundColor3 = Color3.new(94/255,94/255,94/255)
			end)
			
		end
		
		
		
		
		UpdateListViewData()
		
		
		if Enums.GamepadEnabled then
			
			--select first catalog item instead if there are no categories
			if #Enums.TypeToCatalogCategoryList[CurrentType] == 0 and ListViewData.ListItems[1] then
				GuiService.SelectedObject = ListViewData.ListItems[1].Object --select first object
			end
			
			game:GetService("GuiService").GuiNavigationEnabled = true
			GuiService:RemoveSelectionGroup("CatalogGroup")
			GuiService:AddSelectionTuple("CatalogGroup",ScrollingFrame,Categories)
		end
		
		
		
		
	end
end

UIEvents.TabChanged.Event:connect(TabChanged)






local currentItemData

--when buy button is pressed
Window.BuyButtonPressed.Event:connect(function(object,itemData)
	
	if workspace.Main.BuyCatalogItem:InvokeServer(itemData.AssetId) then
		
		SoundFX:PlaySound("CashRegister")
		--Utility:TweenAbsolutePosition(MainGui,object.Thumbnail,object.Thumbnail.AbsolutePosition, Vector2.new(ScreenGui.AbsoluteSize.X,object.Thumbnail.AbsolutePosition.Y),"Out","Linear",.3)

	end
end)


local firstTimeVisible = true

local WindowSizeChanged

UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
	
	if window == Window and visible then
		currentItemData = nil
		
		
		if firstTimeVisible then --show the furniture tab
			firstTimeVisible = false
			TabsData:SetFirstTabPressed(Tabs.Furniture)
		end
		
		WindowSizeChanged = MainGui.Changed:connect(function(prop)
			if prop == "AbsoluteSize" then
				--ResizeWindow()
			end
		end)
		
		wait() --wait for category list to populate
		--ResizeWindow()
		
	elseif window == Window and not visible then
		
--		WindowSizeChanged:disconnect()
	end
end)


workspace.Main.OpenCatalogTab.OnClientEvent:connect(function(tabName)
	if not Window.Visible then
		WindowData:SetVisible(true)
	end
	wait()
	TabsData:SetFirstTabPressed(Tabs[tabName]) 
end)











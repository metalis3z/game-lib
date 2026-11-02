local Window = script.Parent

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))


local Layout = Window:WaitForChild("Layout")
local Loading = Window:WaitForChild("Loading")
local Title = Layout:WaitForChild("Title")
local Tabs = Layout:WaitForChild("Tabs")
local Favorites = Tabs:WaitForChild("Favorites")
local Popular = Tabs:WaitForChild("Popular")
local PasteId = Layout:WaitForChild("PasteId")
local Help = PasteId:WaitForChild("Help")
local TextBox = PasteId:WaitForChild("TextBox")
local ScrollingFrame = Layout:WaitForChild("ScrollingFrame")
local List = ScrollingFrame:WaitForChild("List")
local Template = ScrollingFrame:WaitForChild("Template")

if _G.GamepadEnabled then
	ScrollingFrame.Size = UDim2.new(1,0,.78,0)
	Tabs.Size = UDim2.new(.7,0,.09,0)
	Template.Size = UDim2.new(1,0,0,40)
end

if Window.AbsoluteSize.Y > MainGui.AbsoluteSize.Y then
	Window.UIAspectRatioConstraint:Destroy()
	Window.Size = UDim2.new(0,200,1,0)
end



local delimiter = "~"

local WindowData = GuiManager:RegisterWindow(Window,"Left","Left")
local ListViewData = GuiManager:RegisterListView(Window,List)
local TabsData = GuiManager:RegisterTabs(Window,Tabs)
local TextInput = GuiManager:RegisterTextInput(Window,TextBox)
TextInput.NumbersOnly = true
TextInput.DefaultText = "Enter ID"
TextInput:Initialize()

ListViewData.GamepadSelectFirstItemOnRefresh = true
WindowData:SetConsoleSize(UDim2.new(1,0,0,430))
PasteId.Visible = false


asset_types = {
["Shirt"] = 11,
["Pants"] = 12,
["Audio"] = 3,
["Decal"] = 13,
["Place"] = 9,
["Accessory"] = {[8] = true,[41]=true,[42]=true,[43]=true,[44]=true,[45]=true,[46]=true,[47]=true}
}





local top50 = workspace.Main.GetTop50:InvokeServer()
local history = Utility:SendData("GetHistory","PlayerChannel",10)



local ListItems = {}
local assetType = nil
local currentList = top50
local currentTab = Popular
local currentModel  --music player, poster, place portal



local historyHash = {}
local top50Hash = {}


--hash each list so can cross refrence to see if a item on popular list has already been favorited without having to loop through every item





DisplayFunction = function(objectData,object,listItemData,index)
	
	object.AssetNameButton.TextLabel.Text = "  " .. listItemData[2]
		
	if currentTab == Popular then
		if historyHash[tostring(listItemData[1])] then
			object.FavoriteButton.Icon.Image = "rbxassetid://905979446"
		else
			object.FavoriteButton.Icon.Image = "rbxassetid://906018985"
		end
			
	elseif currentTab == Favorites then
			
		object.FavoriteButton.Icon.Image = "rbxassetid://906143958"
	
	end
	
end

function RefreshHash()
	historyHash = {}
	for assetType,data in pairs(history) do
		for _,item in ipairs(data) do
			historyHash[tostring(item[1])] = true
		end
	end
end


function RefreshList()
	if currentTab == Popular then
		RefreshHash()
		ListViewData:UpdateData(top50[assetType],Template,DisplayFunction)
		
	else
		ListViewData:UpdateData(history[assetType],Template,DisplayFunction)

	end
end


RefreshList()

UIEvents.ListItemPressed.Event:connect(function(window,listContainer,listItem,itemData)
	if listItem.Name == "FavoriteButton" then
		if currentTab == Popular then
			local alreadyFavorited = historyHash[tostring(itemData[1])]
			if alreadyFavorited then
				--remove from favorites
				listItem.Icon.Image = "rbxassetid://906018985" --empty star
				history = Utility:SendData("RemoveAssetFromHistory","PlayerChannel",10,assetType,itemData[1],itemData[2])	
				
			else
				--add to favorites
				listItem.Icon.Image = "rbxassetid://905979446" --full star
				history = Utility:SendData("AddAssetToHistory","PlayerChannel",10,assetType,itemData[1],itemData[2])	
			end
			
			RefreshHash()
			
			
		elseif currentTab == Favorites then --when X is pressed
			history = Utility:SendData("RemoveAssetFromHistory","PlayerChannel",10,assetType,itemData[1],itemData[2])	
			RefreshList()
		end


	elseif listItem.Name == "AssetNameButton" then
		if currentModel.Name == "Spray Paint" then
			workspace.Main.AssetIdChanged.AssetIdChanged:Fire(currentModel,itemData[1])
		else
			workspace.Main.AssetIdChanged:FireServer(currentModel,itemData[1])
		end
		
		workspace.Main.AssetUsed:FireServer(currentModel,assetType,itemData[1],itemData[2])
	
	end
end)


UIEvents.TextInputFocusLost.Event:connect(function(window,textInput)

	if window == Window then
		
		if TextInput.IsValid then
			
			Loading.Visible = true

			local id = tonumber(TextInput.UnfilteredText)
			local success,assetInfo = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(id,0) end)
				
			local validId = false
			if success then
				if type(asset_types[assetType]) == "table" then
					if  asset_types[assetType][assetInfo.AssetTypeId] then
						validId = true
					end
				else
					validId = (assetInfo.AssetTypeId == asset_types[assetType])
				end
			end
	
			if success and validId  then --add back
				history = Utility:SendData("AddAssetToHistory","PlayerChannel",10,assetType,tonumber(TextInput.UnfilteredText),assetInfo.Name)
				RefreshList()
				Loading.Visible = false

			elseif success and not validId then
				Dialog:ShowMessage("Error", "The item must be a " .. assetType .. " ID")
				Loading.Visible = false
				return
			else
				Loading.Visible = false
				Dialog:ShowMessage("Error", "The item with the given ID could not be found.")
				return
			
			end
		end
	end
end)


local function OpenWindow(object,asset_type)
	assetType = asset_type
	
	currentModel = object
	
	Title.Text =  assetType .. " Picker"
	
	TextBox.Text = "Enter " .. asset_type .. " ID"

	WindowData:SetVisible(true)
end
	


workspace.Main.OpenAssetPicker.OnClientEvent:connect(OpenWindow)
workspace.Main.OpenAssetPicker.OpenAssetPicker.Event:connect(OpenWindow)






function TabChanged(window,tab)
	if window == Window then
		currentTab = tab
		RefreshList()
		PasteId.Visible = currentTab == Favorites
	end
end

UIEvents.TabChanged.Event:connect(TabChanged)



UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
	if window == Window then

		RefreshList()
		
		if visible then
			game:GetService("ContextActionService"):BindAction("CtrlPressed2", function() TextBox:CaptureFocus() end, false, Enum.KeyCode.RightControl, Enum.KeyCode.LeftControl)	
		else
			game:GetService("ContextActionService"):UnbindAction("CtrlPressed2")
		end
		
	end
end)


Help.MouseButton1Click:connect(function() Window.Parent.IdHelp.Visible = true end)

--[[
wait(2)
assetType = "Audio"
WindowData:SetVisible(true)
]]



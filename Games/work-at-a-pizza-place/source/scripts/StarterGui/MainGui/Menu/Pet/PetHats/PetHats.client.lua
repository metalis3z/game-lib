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

local Layout = Window:WaitForChild("Layout")
local Top = Layout:WaitForChild("Top")
local ScrollingFrame = Layout:WaitForChild("ScrollingFrame")
local Tabs = Top:WaitForChild("Tabs")
local List = ScrollingFrame:WaitForChild("List")
local TemplateShop = ScrollingFrame:WaitForChild("TemplateShop")
local TemplateMyHats = ScrollingFrame:WaitForChild("TemplateMyHats")
local Title = Top:WaitForChild("Title")

if MainGui.AbsoluteSize.Y < 500 then
	Title.Visible = false
	Tabs.Position = UDim2.new(.5,0,0,0)
	Tabs.Size = UDim2.new(.8,0,1,0)
	Window.Size = UDim2.new(0.3,100,1,0)
end

if Window.AbsoluteSize.X < 260 then
	Window.Size = UDim2.new(0,140,1,0)
end

--[[514
390
260
140]]

local CurrentPet = nil

local OriginalSize = Window.Size
local OriginalPosition = Window.Position

local WindowData = GuiManager:RegisterWindow(Window,"Right","Right")
local TabsData = GuiManager:RegisterTabs(Window,Tabs)
local ListViewData = GuiManager:RegisterListView(Window,List)

ListViewData.GamepadSelectFirstItemOnRefresh = true


local CurrentTab

local PetHatShopData =  Utility:SendData("GetPetHatsLibrary","AssetLibraryManagerChannel",10) or Utility:SendData("GetPetHatsLibrary","AssetLibraryManagerChannel",10) or {} -- {AssetId = 123455, Quantity = 1, Name = "Stove"}


local PetHatInventoryData = nil

TabsData:SetConsoleSize(UDim2.new(0,350,0,50))

--dont show the "No Hat" button in the shop
for i,item in ipairs(PetHatShopData) do
	if item.AssetId == 860395229 then 
		table.remove(PetHatShopData,i)
	end
end


function RefreshHatIntentory()
	local InventoryData = Utility:SendData("GetInventory","PlayerChannel",2) or Utility:SendData("GetInventory","PlayerChannel",2)

	--filter everything buy pet hats
	local petHats = {}
	for i,data in ipairs(InventoryData) do
		if data.Category == "PetHats" then
			table.insert(petHats,data)
		end
	end
		
	PetHatInventoryData = petHats
end



local petHatPreview = false


--for gamepasses and moneyz
UIEvents.ListItemPressed.Event:connect(function(window,listContainer,listItem,itemData)
	if window == Window then
		if listContainer == List then
			if CurrentTab.Name == "Shop" then
				petHatPreview = true
				workspace.PetService.SetCustomHat:FireServer(CurrentPet.Name,itemData.Name,itemData.AssetId,true)
				wait(2)

				if Dialog:GetChoice("Purchase","Would you like to buy " .. itemData.Name .. " for " .. itemData.Price .. " Moneyz?","Yes","No") then
					if workspace.Main.BuyCatalogItem:InvokeServer(itemData.AssetId) then
						workspace.PetService.SetCustomHat:FireServer(CurrentPet.Name,itemData.Name,itemData.AssetId,false)
						SoundFX:PlaySound("CashRegister")
						RefreshHatIntentory()
					end
				end
			elseif CurrentTab.Name == "MyHats" then
				workspace.PetService.SetCustomHat:FireServer(CurrentPet.Name,itemData.Name,itemData.AssetId,false)
			end
		end
	end
end)



ListDisplayFunction = function(objectData,object,listItemData,index)
	
	object.Style = Enum.ButtonStyle.RobloxRoundButton
	object.Thumbnail.Image = "http://www.roblox.com/Thumbs/Asset.ashx?Width=75&Height=75&AssetID=" .. listItemData.AssetId
		
	if listItemData.Price then  --shop item
		object.ItemName.Text = listItemData.Name
		object.Moneyz.Text = Utility:AddCommas(math.floor(listItemData.Price))
		object.Thumbnail.New.Visible = (listItemData.New and listItemData.New + 1209600 > tick() and true) or false
	end
end



function TabChanged(window,tab)

	if window == Window then
		
		CurrentTab = tab
		
		if tab.Name == "MyHats" then
			ListViewData:UpdateData(PetHatInventoryData,TemplateMyHats,ListDisplayFunction)
			
		elseif tab.Name == "Shop" then
			ListViewData:UpdateData(PetHatShopData,TemplateShop,ListDisplayFunction)
		end

		
	end
end

UIEvents.TabChanged.Event:connect(TabChanged)








local firstTimeVisible = true
local camera = workspace.CurrentCamera
local cameraCFrame

UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
	
	if window == Window then
		if visible then
			
			CurrentPet = _G.CurrentPet
			
			RefreshHatIntentory()
			
			cameraCFrame = camera.CoordinateFrame
			
			workspace.PetService.Command:InvokeServer(CurrentPet.Name, "Stay")
			
			local zoomOut = 2
			local size = CurrentPet.Size.Y * zoomOut
			camera.CameraType = "Scriptable"
			camera:Interpolate(CFrame.new(CurrentPet.Position + Vector3.new(0,.4,0) + (CurrentPet.CFrame.lookVector * (size + .3))) , CFrame.new(CurrentPet.Position),.5)
			local finished = camera.InterpolationFinished:connect(function()
				camera.CoordinateFrame = CFrame.new(CurrentPet.Position + Vector3.new(0,.4,0) + (CurrentPet.CFrame.lookVector * (size + .3)),CurrentPet.Position)
			end)
			
			
			
			if firstTimeVisible then --show the furniture tab
				firstTimeVisible = false
				TabsData:SetFirstTabPressed(Tabs.MyHats)
			end
		else
			workspace.PetService.Command:InvokeServer(CurrentPet.Name, "Stop")
			camera.CoordinateFrame = cameraCFrame
			camera.CameraType = "Custom"
			GuiManager:GetWindowDataByName("PetPanel"):SetVisible(true)
			if petHatPreview then
				workspace.PetService.SetCustomHat:FireServer(CurrentPet.Name,nil,nil,true)
			end
		end
	
	end
	
end)












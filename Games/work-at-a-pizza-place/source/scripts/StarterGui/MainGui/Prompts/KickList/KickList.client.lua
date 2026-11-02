local Window = script.Parent
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))


local ScrollingFrame = Window:WaitForChild("ScrollingFrame")
local List = ScrollingFrame:WaitForChild("List")
local Template = ScrollingFrame:WaitForChild("Template")
local Empty = Window:WaitForChild("Empty")





local WindowData = GuiManager:RegisterWindow(script.Parent,"Left","Right",nil,nil,true)
local ListViewData = GuiManager:RegisterListView(Window,List)


WindowData:SetConsoleSize(UDim2.new(0,350,Window.Size.Y.Scale,Window.Size.Y.Offset))
ListViewData.GamepadSelectFirstItemOnRefresh = true


--fill the y axis if it dosent fit
if Window.AbsoluteSize.Y > MainGui.AbsoluteSize.Y then
	Window.Size = UDim2.new(0,Window.Size.X.Offset,0,MainGui.AbsoluteSize.Y)
	WindowData:UpdateTweenEndPoints()
end

	
	
	
	
ListDisplayFunction = function(objectData,object,listItemData,index)
	object.PlayerName.Text = listItemData.Name
end

	

UIEvents.ListItemPressed.Event:connect(function(window,listContainer,listItem,itemData)
	if window == Window  then
		local kickPlayer = itemData
		if kickPlayer and kickPlayer:DistanceFromCharacter(game.Players.LocalPlayer.Character.HumanoidRootPart.Position) < 100 then
			local newPlayerList = Utility:SendData("KickPlayerFromHouse","HouseChannel",nil,kickPlayer)
			ListViewData:UpdateData(newPlayerList,Template,ListDisplayFunction)
		end
	end
end)



UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)

	if window == Window and visible then
		
		local playerList = Utility:SendData("GetPlayersInHouseByOwner","HouseChannel",2)
	
		ListViewData:UpdateData(playerList,Template,ListDisplayFunction)
		
		if #playerList > 0 then
			Empty.Visible = false
		else
			Empty.Visible = true
		end
	end
end)





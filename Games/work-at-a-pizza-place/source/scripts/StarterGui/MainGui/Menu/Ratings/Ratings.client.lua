local Window = script.Parent

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))


local Layout = Window:WaitForChild("Layout")
local Top = Layout:WaitForChild("Top")
local Tabs =  Top:WaitForChild("Tabs")
local Global = Tabs:WaitForChild("Global")
local Local = Tabs:WaitForChild("Local")
local ScrollingFrame = Layout:WaitForChild("ScrollingFrame")
local List = ScrollingFrame:WaitForChild("List")
local Template = ScrollingFrame:WaitForChild("Template")






local WindowData = GuiManager:RegisterWindow(script.Parent,"Left","Right",nil,nil,true)
local ListViewData = GuiManager:RegisterListView(Window,List)
local TabsData = GuiManager:RegisterTabs(Window,Tabs)


WindowData:SetConsoleSize(UDim2.new(0,440,Window.Size.Y.Scale,Window.Size.Y.Offset))
TabsData:SetConsoleSize(UDim2.new(0.5,0,.43,0))
ListViewData.GamepadSelectFirstItemOnRefresh = true


--fill the y axis if it dosent fit
if Window.AbsoluteSize.Y > MainGui.AbsoluteSize.Y then
	Window.Size = UDim2.new(0,Window.Size.X.Offset,0,MainGui.AbsoluteSize.Y)
	WindowData:UpdateTweenEndPoints()
end


local currentTab = Global


ListDisplayFunction = function(objectData,object,listItemData,index)
	if listItemData.key and listItemData.value then
		object.Rank.Text = index .. "."
		object.Visible = true
		object.Rating.Text = string.sub(listItemData.value/10000,1,4)
		object.PlayerImage.Image = "http://www.roblox.com/Thumbs/Avatar.ashx?x=48&y=48&Format=Png&username=" .. listItemData.key 
		object.PlayerName.Text = listItemData.key 
	end
end

UIEvents.TabChanged.Event:connect(function(window,tab)
	if window == Window then
		if tab == Global then
			ListViewData:UpdateData(game.Workspace.Main.GetRatings:InvokeServer("Global"),Template,ListDisplayFunction)
		elseif tab == Local then
			ListViewData:UpdateData(game.Workspace.Main.GetRatings:InvokeServer("Local"),Template,ListDisplayFunction)
		end
		currentTab = tab
	end
end)


UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
	if window == Window then
		if currentTab == Global then
			ListViewData:UpdateData(game.Workspace.Main.GetRatings:InvokeServer("Global"),Template,ListDisplayFunction)
		elseif currentTab == Local then
			ListViewData:UpdateData(game.Workspace.Main.GetRatings:InvokeServer("Local"),Template,ListDisplayFunction)
		end
	end
end)








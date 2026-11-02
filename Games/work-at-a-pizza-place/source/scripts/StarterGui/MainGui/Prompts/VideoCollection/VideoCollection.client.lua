local Window = script.Parent

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))


local Layout = Window:WaitForChild("Layout")
local Top = Layout:WaitForChild("Top")
local ScrollingFrame = Layout:WaitForChild("ScrollingList"):WaitForChild("ScrollingFrame")
local List = ScrollingFrame:WaitForChild("List")
local Template = ScrollingFrame:WaitForChild("Template")
local Help = Layout:WaitForChild("Import"):WaitForChild("Help")
local ImportTextBox = Layout.Import:WaitForChild("TextBox")
local Power = Top:WaitForChild("Power")
local NoVideos = Layout.ScrollingList:WaitForChild("NoVideosMessage")
local Title = Top:WaitForChild("Title")

local WindowData = GuiManager:RegisterWindow(script.Parent,"Left","Right",nil,nil,true)
local ListViewData = GuiManager:RegisterListView(Window,List)
ListViewData.RecycleRows = false

local currentTV
local currentTVOwner


WindowData:SetConsoleSize(UDim2.new(0,440,Window.Size.Y.Scale,Window.Size.Y.Offset))
ListViewData.GamepadSelectFirstItemOnRefresh = true


--fill the y axis if it dosent fit
if Window.AbsoluteSize.Y > MainGui.AbsoluteSize.Y then
	Window.Size = UDim2.new(0,Window.Size.X.Offset,0,MainGui.AbsoluteSize.Y)
	WindowData:UpdateTweenEndPoints()
end

if _G.GamepadEnabled or game:GetService("UserInputService").TouchEnabled then
	Layout.Import.Visible = false
	NoVideos.Text = "You don't own any videos yet. You can add videos to your collection by looking at another player's collection. Just go to another house and click on any TV to check if they have any videos you can take."
end


ListDisplayFunction = function(objectData,object,listItemData,index)
	object.VideoName.Text = listItemData[2]
	object.CreatorName.Text = "by " .. listItemData[3]
end



local function RefreshList(tvOwner)
	local videoList = Utility:SendData("GetVideoCollection","PlayerChannel",2,tvOwner)
	
	if tvOwner ~= game.Players.LocalPlayer then
		Template.Take.Visible = true
		Template.Play.Visible = false
		Template.Delete.Visible = false
		NoVideos.Visible = false
	else
		Template.Take.Visible = false
		Template.Play.Visible = true
		Template.Delete.Visible = true
		NoVideos.Visible = (#videoList == 0 and true) or false
	end
	
	if videoList then
		ListViewData:UpdateData(videoList,Template,ListDisplayFunction)
	end
end

Help.MouseButton1Click:connect(function()
	workspace.Main.ShowInstructions:Fire(1)
	GuiManager:GetWindowDataByName("Instructions"):SetVisible(true)
end)

ImportTextBox:GetPropertyChangedSignal("Text"):connect(function()
	if ImportTextBox.Text:match("VideoName") then --if ImportTextBox.Text:match("\n(%d+)|([%d.]+)|([^%|]*)|") then
		local text = ImportTextBox.Text
		ImportTextBox.Text = ""
		Window.Loading.Visible = true
		Utility:SendData("ImportVideo","PlayerChannel",60,text)
		Window.Loading.Visible = false
		RefreshList(currentTVOwner)
	end
	ImportTextBox.Text = ""
end)


Power.MouseButton1Click:connect(function()
	if currentTV then
		if not currentTV.Screen.SurfaceGui.Enabled then
			currentTV.Screen.SurfaceGui.Enabled = true
			Power.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
		else
			currentTV.Screen.SurfaceGui.Enabled = false
			Power.Style = Enum.ButtonStyle.RobloxRoundButton
		end
	end
end)


workspace.Main.ShowVideoCollection.OnClientEvent:connect(function(tvOwner,tvModel)
	WindowData:SetVisible(true)
	RefreshList(tvOwner)
	currentTV = tvModel
	currentTVOwner = tvOwner
	
	if tvOwner == game.Players.LocalPlayer then
		Power.Visible = true
		if tvModel.Screen.SurfaceGui.Enabled then
			Power.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
		else
			Power.Style = Enum.ButtonStyle.RobloxRoundButton
		end
		Title.Text = "My Video Collection"
	else
		Power.Visible = false
		Title.Text = tvOwner.Name .. "'s Video Collection"
	end
	
end)


UIEvents.ListItemPressed.Event:connect(function(window,listContainer,listItem,itemData)

	if window == Window then
		
		local videoId = itemData[1]
		local videoName = itemData[2]
		local videoCreator = itemData[3]
		
		
		if listItem.Name == "Play" then
			Utility:SendData("PlayVideo","PlayerChannel",nil,videoId,videoName,videoCreator)
			WindowData:SetVisible(false)

		elseif listItem.Name == "Delete" then
			if Dialog:GetChoice("Delete?", "Are you sure you want to delete this video?","Yes","No") then
				Utility:SendData("DeleteVideo","PlayerChannel",2,videoId)
				RefreshList(currentTVOwner)
			end
			
		elseif listItem.Name == "Take" then
			Dialog:ShowMessage("Video Added",videoName .. " has been added to your video collection.")
			Utility:SendData("TakeVideo","PlayerChannel",2,videoId,videoName,videoCreator)
			
		end
	end
end)

UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
	if window == Window then
		if visible then
			game:GetService("ContextActionService"):BindAction("CtrlPressed", function() ImportTextBox:CaptureFocus() end, false, Enum.KeyCode.RightControl, Enum.KeyCode.LeftControl)	
		else
			game:GetService("ContextActionService"):UnbindAction("CtrlPressed")
		end
	end
end)

--wait(2)
--WindowData:SetVisible(true)
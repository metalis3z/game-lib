local Window = script.Parent
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Template = Window:WaitForChild("Template")
local List = Window:WaitForChild("ScrollingFrame"):WaitForChild("List")

Window.Position = UDim2.new(Window.Position.X.Scale,Window.Position.X.Offset,0,0)


local WindowData = GuiManager:RegisterWindow(Window)
WindowData:SetConsoleSize(UDim2.new(0,700,1,0))

local ListViewData = GuiManager:RegisterListView(Window,List)

while player.Character == nil or player.Character:FindFirstChild("Humanoid") == nil do
	wait()
end
wait(1) --make sure the rig type is set -- a player didnt have R15 dances for some reason
local rig = player.Character.Humanoid.RigType

local emotes = {
				{"Glee",1},{"Cheer",1},{"Sad",1},{"Laugh",1},{"Think",1},
				{"Scared",1},{"Amazed",1},{"Angry",1},{"Confused",1},
				
				{"Hi",2},{"Bye",2},{"Clap",2},
				{"Sleep",2},{"Point",2},{"Whistle",2},{"Sit",2},
				
				{"Dance",3},{"Dance2",3},{"Dance3",3},{"Shuffle",3,rig},
				{"Twist",3,rig},{"Swing",3,rig},{"Easy",3,rig},{"HipHop",3,rig},
				{"HipHop2",3,rig},{"Flair",3,rig},{"Marashin",3,rig},
}

	
UIEvents.ListItemPressed.Event:connect(function(window,listContainer,listItem,itemData)
	if window == Window then
		if MainGui.AbsoluteSize.Y/3 < Window.AbsolutePosition.Y + Window.AbsoluteSize.Y then
			WindowData:SetVisible(false)
		end
		game.Workspace.Animation.PlayAnimation.PlayAnimation:Fire(itemData[1],.3)
	end
end)
	
ListDisplayFunction = function(objectData,object,listItemData,index)
	object.TextLabel.Text = listItemData[1]
	local groupColors = {"Bright red","Bright blue","Bright yellow"}
	object.GroupColor.BackgroundColor3 = BrickColor.new(groupColors[listItemData[2]]).Color
		
	if listItemData[3] then
		if listItemData[3] == Enum.HumanoidRigType.R6 then
			object.Visible = false
		end
	end
end
	
	

ListViewData:UpdateData(emotes,Template,ListDisplayFunction)


WindowData.FirstSelectedObject = ListViewData.ListItems[1].Object





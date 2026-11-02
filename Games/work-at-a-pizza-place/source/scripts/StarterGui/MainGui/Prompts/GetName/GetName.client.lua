local Window = script.Parent
local Save = Window:WaitForChild("Save")
local Name = Window:WaitForChild("name")
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local player = game.Players.LocalPlayer
local ChatService = game:GetService("Chat")

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))

local WindowData = GuiManager:RegisterWindow(Window)
WindowData.FirstSelectedObject = Name



local edit_text = Window.name
local id = nil

function mouseEnter()
	edit_text.BackgroundColor3 = Color3.new(153/255,153/255,153/255)
end
edit_text.MouseEnter:connect(mouseEnter)

function mouseLeave(button)
	edit_text.BackgroundColor3 = Color3.new(1,1,1)
end
edit_text.MouseLeave:connect(mouseLeave)


local debounce = false
function submit()
	
	if edit_text.Text == "" then
		Dialog:ShowMessage("No Name","You must enter name.")
		return
	end
	if not debounce then
		debounce = true
			
		local exists = pcall(function() id = game.Players:GetUserIdFromNameAsync(edit_text.Text) end)
			
		edit_text.Text = workspace.Main.FilterString:InvokeServer(nil,edit_text.Text)

		if exists and id then
			Window.Visible = false
		else
			Dialog:ShowMessage("Player does not exist", "Please make sure you spelled the player's name correctly.")
		end
		
		debounce = false
	end
end

script.Parent.Save.MouseButton1Click:connect(submit)





function game.Workspace.MessageService.GetName.OnClientInvoke()
	id = nil
	wait(.5)
	WindowData:SetVisible(true)
	while id == nil do
		wait(.2)
	end
	return id
end



UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
	if window == Window and not visible and id == nil then
		id = -1
	end
end)




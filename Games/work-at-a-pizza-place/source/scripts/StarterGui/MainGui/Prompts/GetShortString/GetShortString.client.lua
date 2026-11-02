local Window = script.Parent
local Done = Window:WaitForChild("Done")
local String = Window:WaitForChild("String")
local Title = Window:WaitForChild("Title")
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local player = game.Players.LocalPlayer

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))

local WindowData = GuiManager:RegisterWindow(Window)
WindowData.FirstSelectedObject = String

local message = nil

local function filterText(text)
	local s = ""  
	for w in string.gmatch(text, "%w+") do 
		s = s .. " " .. w 
	end 
	return s
end

Done.MouseButton1Click:connect(function()
	if string.len(String.Text) < 50 then
		String.Text = workspace.Main.FilterString:InvokeServer(nil,message)
		if string.find(String.Text,"##") then
			Dialog:ShowMessage("Text was Filtered", "Some words were filtered. Please try another name.")
			return
		end
		message = String.Text
		WindowData:SetVisible(false)
	else
		Dialog:ShowMessage("Too Long","The name you entered has too many character.")
	end
end)



function waitForMessage()
	wait(.5)
	String.Text = ""
	message = nil
	WindowData:SetVisible(true)
	while message == nil do
		wait(.2)
	end
		
end

function game.Workspace.MessageService.GetShortString.OnClientInvoke(promptMessage)
	Title.Text = promptMessage
	waitForMessage()
	return message
end

function game.Workspace.MessageService.GetShortString.GetShortString.OnInvoke(promptMessage)
	Title.Text = promptMessage
	waitForMessage()
	return message
end


UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
	
	if window == Window and not visible and message == nil then
		message = ""
	end
end)




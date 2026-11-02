local Window = script.Parent

local player = game.Players.LocalPlayer
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))


local Done = Window:WaitForChild("Done")
local InputText = Window:WaitForChild("InputText")
local Clear = Window:WaitForChild("Clear")


local WindowData = GuiManager:RegisterWindow(Window)
WindowData.FirstSelectedObject = InputText
WindowData:SetConsoleSize(UDim2.new(1,0,0,280))


if _G.GamepadEnabled then
	InputText.TextSize = 28
end




message = nil



function submit()
	if string.len(InputText.Text) > 120 then
		InputText.Text = string.sub(InputText.Text,1,120)
	end
	
	InputText.Text = workspace.Main.FilterString:InvokeServer(nil,InputText.Text)

	if string.find(InputText.Text,"##") then
		if Dialog:GetChoice("Filtered Text","Some of the words were filtered.","Retry","Done") then
			return
		end
	end
	
	WindowData:SetVisible(false)
	message = InputText.Text
	
end

Done.MouseButton1Click:connect(submit)

Clear.MouseButton1Click:connect(function() InputText.Text = "" end)





function game.Workspace.MessageService.GetString.OnClientInvoke()
	wait(.5)
	WindowData:SetVisible(true)
	message = nil
	while message == nil do
		wait(.2)
	end
	return message
	
end


UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
	if window == Window and not visible and message == nil then
		message = ""
	end
end)





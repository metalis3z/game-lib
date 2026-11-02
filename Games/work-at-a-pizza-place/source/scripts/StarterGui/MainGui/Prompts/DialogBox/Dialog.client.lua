local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Window = script.Parent
local Yes = Window:WaitForChild("Yes")
local No = Window:WaitForChild("No")
local Title = Window:WaitForChild("Title")
local Message = Window:WaitForChild("Message")
local AButton = Window:WaitForChild("AButton")
local BButton = Window:WaitForChild("BButton")
local Cancel = Window:WaitForChild("Cancel")
local Queue = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Queue"))
local Enums =  require(game.ReplicatedStorage:WaitForChild("Enums"))


if Enums.GamepadEnabled then
 	Message.FontSize = Enum.FontSize.Size28
	Window.Size = UDim2.new(0, 500,1, 0)
	AButton.Visible = true
	Yes.Visible = false
	No.Visible = false
	Cancel.Visible = false
end

local windowData = GuiManager:RegisterWindow(Window,"Left","Right")
windowData.IsPopup = true
windowData.IsGamepadNavigateable = false

local DialogQueue = Queue.new()
local choice = nil
local selection 

function ShowDialog(title,message,button1,button2,async,isClient)
	
	local yesConnection,noConnection,cancelConnection
	
	
	DialogQueue:Wait()
	
	choice = nil


	
	Message.Text = message
	Title.Text = title
	
	windowData:SetVisible(true)


	---PC--------
	Yes.Text = button1
	No.Text = button2
		
	yesConnection = Yes.MouseButton1Click:connect(function()
		choice = true
	end)
	noConnection = No.MouseButton1Click:connect(function()
		choice = false
	end)
	
	cancelConnection = Cancel.MouseButton1Click:connect(function()
		choice = false
	end)
		
	if button2 == "" then
		No.Visible = false
		Yes.Position = UDim2.new(.5,0,1,-10)
	else
		No.Visible = true
		Yes.Position = UDim2.new(.3,0,1,-10)
	end
		
		
	---XBOX---------

	AButton.TextLabel.Text = button1
	BButton.TextLabel.Text = button2
	
	local buttonIconSize = AButton.Icon.AbsoluteSize.X
	AButton.Size = UDim2.new(0,AButton.TextLabel.TextBounds.X + buttonIconSize,0,buttonIconSize)
	BButton.Size = UDim2.new(0,BButton.TextLabel.TextBounds.X + buttonIconSize,0,buttonIconSize)

	if Enums.GamepadEnabled then

		if button2 == "" then
			BButton.Visible = false
			AButton.Position = UDim2.new(.5,0,1,0)
		else
			No.Visible = false
			BButton.Visible = true
			AButton.Position = UDim2.new(.25,0,1,0)
		end
		
	end
		
	
	while choice == nil do wait() end
	
	
	yesConnection:disconnect()
	noConnection:disconnect()
	cancelConnection:disconnect()

	if async then
		if isClient then
		--lets game.ReplicatedStorage.Dialog know that the player has made a choice
			workspace.MessageService.DialogButtonPressed.DialogButtonPressed:Fire(choice)
		else
			workspace.MessageService.DialogButtonPressed:FireServer(choice)
		end
	end
	
	windowData:SetVisible(false)
	
	wait(windowData.TweenDuration)
	
	DialogQueue:Next()

	
end

if Enums.GamepadEnabled then
	
	windowData:RegisterGamepadAction(Enum.KeyCode.ButtonA,function(action,state,inputObject)
		if state == Enum.UserInputState.Begin then
			choice = true
		end
	end)
	
	windowData:RegisterGamepadAction(Enum.KeyCode.ButtonB,function(action,state,inputObject)
		if state == Enum.UserInputState.Begin then
			choice = false
		end
	end)
	
	
end


--shows coin icon asking if player wants to buy more moneyz
workspace.MessageService.CoinIconVisible.OnClientEvent:connect(function(visible)
	print("VISI",visible)
	No.MoneyzIcon.Visible = visible
end)



workspace.MessageService.Dialog.Dialog.Event:connect(ShowDialog)
workspace.MessageService.Dialog.OnClientEvent:connect(ShowDialog)



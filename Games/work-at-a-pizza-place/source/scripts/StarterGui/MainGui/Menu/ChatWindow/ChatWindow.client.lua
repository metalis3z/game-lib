local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))
local Enums =  require(game.ReplicatedStorage:WaitForChild("Enums"))
local Debug = require(game.ReplicatedStorage:WaitForChild("Debug"))
local ChatService = game:GetService("Chat")


local ChatMenu = script.Parent.Parent:WaitForChild("ChatMenu")
local Chat = ChatMenu:WaitForChild("Chat")
local Phrases = Chat:WaitForChild("Phrases")
local ToggleChat = ChatMenu:WaitForChild("ToggleChat")


local Window = script.Parent
local ScrollingFrame = Window:WaitForChild("ScrollingFrame")
local Template = Window:WaitForChild("MessageTemplate")
local Bar = Window:WaitForChild("Bar")
local TextBox = Bar:WaitForChild("TextBox"):WaitForChild("TextBox")

ChatMenu.Position = UDim2.new(ChatMenu.Position.X.Scale,ChatMenu.Position.X.Offset,0,-36)
Window.Position = UDim2.new(0,5,0,0)

if Enums.CanChat == false then
	ChatMenu.Size = UDim2.new(0,180,0,36)
end

--make bigger on small screen
if MainGui.AbsoluteSize.Y < 500 then
	Window.Size = UDim2.new(.4,0,.35,0)
end

if Enums.GamepadEnabled then
	ChatMenu.Visible = false
end



local MAX_NUM_LINES = 5 --textbox
local CHARACTER_LIMIT = 200  --textbox
local TEXT_SIZE = (Enums.GamepadEnabled and 28) or 20
local EXPIRE_TIME = 30 --seconds
local SPACING = 3 --space between message and player name



local BubbleChatOnly = false--SavedSettings.BubbleEnabled
local isGuest = (player.userId < -4 and true) or false
local MaxMessages = (MainGui.AbsoluteSize.Y / TEXT_SIZE) --make max double the screen height
local messages = {}
local State = "Open" --scroll, closed


Template.Size = UDim2.new(1,-5,0,TEXT_SIZE)
--stops text from cutting off
Window.Size = UDim2.new(Window.Size.X.Scale,Window.Size.X.Offset,0,Utility:Round(Window.AbsoluteSize.Y,TEXT_SIZE))


GuiManager:RegisterTopbarButton(Chat)
GuiManager:RegisterTopbarButton(ToggleChat)
GuiManager:RegisterTopbarButton(ChatMenu:WaitForChild("MainMenu"))



local windowData = GuiManager:RegisterWindow(Window)
local menuwindowData = GuiManager:RegisterWindow(ChatMenu)








local function SetWindowState(state)
	if state == "Scrolling" then
		State = "Scrolling"
		ScrollingEnabled(true)
		windowData:SetVisible(true)
		ToggleChat.Selected = true
	
	elseif state == "Closed" then
		ToggleChat.Selected = false
		State = "Closed"
		ScrollingEnabled(false)
		windowData:SetVisible(false)
		
	elseif state == "Open" then
		ToggleChat.Selected = true
		State = "Open"
		ScrollingEnabled(false)
		windowData:SetVisible(true)
	end
end


function ShowMessage(speaker,message)
	
	local template = Template:clone()
	template.Visible = true
	template.Name = "Message"
	template.Parent = ScrollingFrame
	template.Size = UDim2.new(1,0,0,TEXT_SIZE)

	
	local SpeakerLabel = template.Speaker
	local MessageLineTemplate = template.MessageLineTemplate
	
	if speaker then
		SpeakerLabel.TextColor = speaker.TeamColor
		SpeakerLabel.TextSize = TEXT_SIZE
		SpeakerLabel.Text = speaker.Name .. ":"
		SpeakerLabel.Size = UDim2.new(0,SpeakerLabel.TextBounds.X,0,TEXT_SIZE)
		SpeakerLabel.Visible = true
	else --server message broadcast
		SpeakerLabel.Visible = false
		SpeakerLabel.Text = ""
		SpeakerLabel.Size = UDim2.new(0,0,0,TEXT_SIZE)
		MessageLineTemplate.TextColor3 = Color3.new(199/255,199/255,199/255)
	end
	
	local lines = {}

	--the first line
	local currentLineTemplate = MessageLineTemplate
	currentLineTemplate.Visible = true
	currentLineTemplate.Name = "Line1"
	currentLineTemplate.TextSize = TEXT_SIZE
	currentLineTemplate.Position = UDim2.new(0,SpeakerLabel.AbsoluteSize.X + SPACING,0,0)
	currentLineTemplate.Size = UDim2.new(1,-SpeakerLabel.AbsoluteSize.X - SPACING,0,TEXT_SIZE)
	currentLineTemplate.Parent = template
	currentLineTemplate.Text = message --just in case there are no spaces in message
	table.insert(lines,currentLineTemplate)


	--for multiline messages
	local lineNumber = 2
	local currentMessage = ""
	local lastMessage
	local startStringIndex = 1
	local stringIndexRanges = {}
	
	--removes exess white space in messages
	local newMessage = ""
	for w in string.gmatch(message, "%S+") do --loop for each word
		newMessage = newMessage .. " " .. w
	end
	message = newMessage
	
	
	for w in string.gmatch(message, "%S+") do --loop for each word
		
		--update textfield until it becomes full
		currentLineTemplate.Text = currentMessage .. " " .. w
		
		if not currentLineTemplate.TextFits then
			--then start a new textfield below it
			table.insert(stringIndexRanges,{startStringIndex,startStringIndex + string.len(currentMessage) - 1})
			startStringIndex = startStringIndex + string.len(currentMessage) + 1
			currentLineTemplate.Text = currentMessage
			currentMessage = w
			currentLineTemplate = MessageLineTemplate:clone()
			currentLineTemplate.Visible = true
			currentLineTemplate.TextSize = TEXT_SIZE
			currentLineTemplate.Position = UDim2.new(0,0,0,(lineNumber-1) * TEXT_SIZE)
			currentLineTemplate.Size = UDim2.new(1,0,0,TEXT_SIZE)
			currentLineTemplate.Parent = template
			currentLineTemplate.Text = currentMessage
			currentLineTemplate.Name = "Line" .. tostring(lineNumber)
			template.Size = UDim2.new(1,-5,0,lineNumber * TEXT_SIZE)
			table.insert(lines,currentLineTemplate)

			lineNumber = lineNumber + 1
		else
			
			currentMessage = currentMessage .. " " .. w

		end
	end
	
	if speaker and speaker.Parent and speaker.Character and speaker.Character.Parent == workspace then
		ChatService:Chat(speaker.Character,message)
	end
	
	table.insert(stringIndexRanges,{startStringIndex,startStringIndex + string.len(currentMessage)+1})
	
	local filteredMessage = message
	--dont filter server messages
	spawn(function()
		if speaker ~= nil then
			
			--[[if player ~= speaker then
				--replace text with underscores only for other player's text
				for _,line in ipairs(lines) do
					line.Text = string.rep("_",string.len(line.Text))
				end
			end]]
			
			filteredMessage = workspace.Main.FilterString:InvokeServer(speaker,message)
	
			if #lines > 1 then
				for i,line in ipairs(lines) do
					line.Text = string.sub(filteredMessage,stringIndexRanges[i][1],stringIndexRanges[i][2])
					print(line.Text)
				end
			else
				currentLineTemplate.Text = filteredMessage
			end
			
				
			
		
			
			
		end
	end)
	
	--pop off old messages
	if #messages > MaxMessages then
		messages[#messages]:Destroy()
		table.remove(messages,#messages)
	end
	
	
end


local MessagesSent = {}
local FLOOD_MESSAGES_MAX = 7
local FLOOD_INTERVAL = 15

function IsFlooded()

	while #MessagesSent > 0 and tick() - MessagesSent[1] > FLOOD_INTERVAL do
		table.remove(MessagesSent,1)
	end
	
	if #MessagesSent > FLOOD_MESSAGES_MAX then
		return true
	end
	return false
end




function RefreshLayout()
	--[[local currentHeight = 0
	for _,message in ipairs(messages) do
		local messageSize = message.Size.Y.Offset
		currentHeight = currentHeight + messageSize + 3
		message.Position = UDim2.new(0,5,1,-currentHeight)
	end]]
end



--show/hide textbox
function EditTextEnabled(enabled)
	
	if enabled and State == "Closed" then SetWindowState("Open") end
	
	if enabled then
		Bar.Visible = true
		wait()
		TextBox:CaptureFocus()
		--Chat.Selected = true
	else
		Bar.Visible = false
		--Chat.Selected = false

	end
end







--when press enter or click somewhere else
local focusLost = TextBox.FocusLost:connect(function(fromEnter)

	
	EditTextEnabled(false)
	
	if TextBox.Text == "" then return end
	
	local isFlooded = IsFlooded()
	
	--if player pressed enter
	if fromEnter and not isFlooded then
		SoundFX:PlaySound("Pop3")
		
		

		workspace.Main.Chatted:FireServer(TextBox.Text,BubbleChatOnly)
		workspace.Main.Chatted.Chatted:Fire(TextBox.Text) --emotions
		
		table.insert(MessagesSent,tick())
		
		ShowMessage(player,TextBox.Text) --yeilds until filtered

	
	elseif isFlooded then
		ShowMessage(nil,"Wait before sending another message")
		RefreshLayout()

	end
	TextBox.Text = ""
	Chat.Selected = false
end)



--when typing
local textLength = 0
local textChanged = TextBox.Changed:connect(function(property)
	if property == "Text" then
		
		if string.len(TextBox.Text) > CHARACTER_LIMIT then
			TextBox.Text = string.sub(TextBox.Text,1,CHARACTER_LIMIT)
			return
		end
		
		if textLength > string.len(TextBox.Text) then --if backspacing
			Bar.Size = UDim2.new(1, 14,0, 30)
			for i=1,MAX_NUM_LINES do
				if not TextBox.TextFits then
					Bar.Size = UDim2.new(1,14,0,18*i + 40)
				else
					break
				end
			end
			
		elseif not TextBox.TextFits then
			Bar.Size = UDim2.new(1,14,0,Bar.Size.Y.Offset+18)
		end
		
		textLength = string.len(TextBox.Text)
	end
end)



	
--when '/' key is pressed
local slashPressed
if Enums.CanChat then
	local slashPressed = game:GetService("UserInputService").InputBegan:connect(function(inputObject,gameProcessed)
		if (inputObject.UserInputType == Enum.UserInputType.Keyboard)  then
			if inputObject.KeyCode == Enum.KeyCode.Slash and not Bar.Visible then
				wait() --so the '/' dosent get added to textbox
				EditTextEnabled(true)
			end
		end
	end)
end



if isGuest then
	slashPressed:disconnect()
	textChanged:disconnect()
	focusLost:disconnect()
end




--display messages sent by other players
workspace.Main.Chatted.OnClientEvent:connect(function(speaker,message)
	
	ShowMessage(speaker,message)
	RefreshLayout()

	
end)


function ScrollingEnabled(enabled)
	--take up full screen
	if enabled then
		Window.Size = UDim2.new(.3,0,1,-40)
		--ScrollingFrame.ScrollingEnabled = true
		local size = (#messages > 0 and -messages[#messages].Position.Y.Offset) or 0
		ScrollingFrame.CanvasSize = UDim2.new(0,0,0,size)
		ScrollingFrame.CanvasPosition = Vector2.new(0,size)
	
	else --take up small part of screen
		Window.Size = UDim2.new(.3,0,.25,0)
		--ScrollingFrame.ScrollingEnabled = false
		local size = (#messages > 0 and -messages[#messages].Position.Y.Offset) or 0
		ScrollingFrame.CanvasSize = UDim2.new(0,0,0,0)
		ScrollingFrame.CanvasPosition = Vector2.new(0,size)
	end
end


--when bubble chat setting is changed
UIEvents.ToggleButtonPressed.Event:connect(function(window,button,state)
	if window.Name == "Settings" and button.Parent.Name == "BubbleEnabled" then
		BubbleChatOnly = state
	end
end)




--detect when icon buttons are pressed
UIEvents.TopbarButtonPressed.Event:connect(function(button)
	if button == Chat then
		if isGuest then
			Phrases.Visible = not Phrases.Visible
			Chat.Selected = Phrases.Visible
		else
			EditTextEnabled(true)				
		end
		

	elseif button == ToggleChat then
		if State == "Open" then
			SetWindowState("Scrolling")
			
		elseif State == "Scrolling" then
			SetWindowState("Closed")

		
		elseif State == "Closed" then
			SetWindowState("Open")

		end
	end
end)



--ToggleChat.Selected = true




--populate guest chat phrases
if isGuest then
	local counter = 0
	for i,phrase in ipairs({"Yes","No","Ok","Hello","Goodbye","Sorry","Stop","Thank You","Wow"}) do
	
		local option = Phrases:WaitForChild("Option"):Clone()
		option.Visible = true
		option.Position = UDim2.new((i-1)%3/3,0,0,(math.floor((i-1)/3))*40)
		option.Name = phrase
		option.Text=  phrase
		option.Parent = Phrases
		option.MouseButton1Click:connect(function() 
			
			local isFlooded = IsFlooded()
			if not isFlooded then
				table.insert(MessagesSent,tick())
				ChatService:Chat(player.Character,phrase)
				workspace.Main.Chatted:FireServer(phrase,true)
			
			elseif isFlooded then
				ShowMessage(nil,"Wait before sending another message")
				RefreshLayout()
			end
			
			Phrases.Visible = false
			Chat.Selected = false
		end)
	end
end
	









--UPDATECHANGE
if Enums.CanChat == false then
	windowData:SetVisible(false)
	windowData.Disabled = true
	ToggleChat.Visible = false
	Chat.Visible = false

else

	windowData:RegisterGamepadAction(Enum.KeyCode.ButtonY, function(action,state,inputObject)
		if state == Enum.UserInputState.Begin and Window.Visible then
			EditTextEnabled(true)
		end
	end)
	
	windowData:GamepadActionsEnabled(true)
	
end

wait(1)
if Debug.Enabled and not Debug.IntroEnabled then
	windowData:SetVisible(false)
	windowData:SetVisible(true)
end


if _G.GamepadEnabled then
	menuwindowData:SetVisible(false)
else
	menuwindowData:SetVisible(true)
end

windowData:SetVisible(true)


	








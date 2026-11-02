local billboards = {}
local billboardEvents = {}
local headDestroyed = {}

local Window = script.Parent
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")

local ResponsePanel = Window:WaitForChild("ResponsePanel")
local responded = false
local InConversation = false
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local windowData = GuiManager:RegisterWindow(ResponsePanel,"Left","Left")
windowData.FirstSelectedObject = ResponsePanel:WaitForChild("Choice1")

local CONVERSATION_DISTANCE = 30
local CHAT_IDLE_TIMEOUT = 150 --15 seconds


local ChoiceValues = {
	[ResponsePanel:WaitForChild("Choice1")] = nil,
	[ResponsePanel:WaitForChild("Choice2")] = nil,
	[ResponsePanel:WaitForChild("Choice3")] = nil,
	[ResponsePanel:WaitForChild("Choice4")] = nil,
	[ResponsePanel:WaitForChild("Choice5")] = nil
}

local currentHead = nil


function EnableBubbles(enabled)
	
	for _,obj in ipairs(PlayerGui:GetChildren()) do
		if obj.Name == "BillboardTemplate" and obj.Adornee and obj.Adornee:FindFirstChild("InUse") and not obj.Adornee.InUse.Value then
			obj.Enabled = enabled
		end
	end
end


function StartConversation(head,billboard)
	if billboard.Enabled then
		workspace.Dialog:FireServer("ClickedBubble",head)
		currentHead = head
		EnableBubbles(false) --billboards[currentHead].Enabled = false
		InConversation = true
				
		workspace.TutorialService.PlayerAction:FireServer("ClickedBubble",true)
				
		while InConversation do
			wait(.1)
			if player:DistanceFromCharacter(head.Position) > CONVERSATION_DISTANCE then
						
				workspace.Dialog:FireServer("EndConversation",head)
				workspace.MessageService.ShowHint.ShowHint:Fire("Chat ended becuase you walked away.",3)
				break
			end
		end
	end
end


function AddClickableBubble(head)

	local billboard = script.Parent.BillboardTemplate:clone()
	billboard.Parent = PlayerGui
	billboard.Adornee = head
	billboard.Enabled = not InConversation
	billboards[head] = billboard
	billboardEvents[head] = billboard.ClickableBubble.MouseButton1Click:connect(function()
		
		if player:DistanceFromCharacter(head.Position) < CONVERSATION_DISTANCE then
			
			StartConversation(head,billboard)
		else
			workspace.MessageService.ShowHint.ShowHint:Fire("You are too far away to chat. ",2)
		end
	end)
	
	--when dialog is destoryed, remove clickable bubble
	head.ChildRemoved:connect(function(obj)
		if obj.Name == "Dialog" then
			billboardEvents[head]:disconnect()
			billboardEvents[head] = nil
			billboards[head]:Destroy()
			if currentHead == head then
				windowData:SetVisible(false)
				InConversation = false
				currentHead = nil
			end
		end
	end)
end

--customer spawned
function ChildAdded(obj)
	wait()
	local head = obj:WaitForChild("Head",5)
	AddClickableBubble(head)
end
workspace.Customers.ChildAdded:connect(ChildAdded)

--add customers
for _,customer in ipairs(workspace.Customers:GetChildren()) do
	if customer:FindFirstChild("Head") and customer.Head:FindFirstChild("Dialog") then
		ChildAdded(customer)
	end
end

--add clerks
for _,obj in ipairs(workspace:GetChildren()) do
	if obj.Name == "Clerk" then
		ChildAdded(obj)
	elseif obj:FindFirstChild("Jordan") then
		ChildAdded(obj.Jordan)
	end
end



-------------------------------------------------------------------------------------------------------------------------------------




function BubbleClicked(head) --when other players click a bubble
	if head and head.Parent and billboards[head] then
		billboards[head].Enabled = false
	end
end

function ConversationFinished(head)  --when any player finishs conversation

	if head == currentHead then
		windowData:SetVisible(false)
		InConversation = false
		currentHead = nil
	end
	
	wait(6)
	--billboards[head].Enabled = true
	EnableBubbles(true)
end

function AlreadyInConversation() --another player clicked NCP bubble first
	EnableBubbles(true) -- billboards[currentHead].Enabled = false
	currentHead = nil
	InConversation = false
end

local CHOICE_BUTTON_HEIGHT = 72
local MOBILE_CHOICE_BUTTON_HEIGHT = 52
local numChoices = 3

function ShowResponseOptions(choices)
	
	if not currentHead or not InConversation then return end
		
	--reset
	for button,strValue in ipairs(ChoiceValues) do
		ChoiceValues[button] = nil
	end

	local index = 0
	for i,choice in ipairs(choices) do
		ResponsePanel["Choice" .. i].Text = choice.UserDialog
		ChoiceValues[ResponsePanel["Choice" .. i]] = choice
		index = i
	end
	
	
	numChoices = #choices + 1 -- +1 goodbye choice
	
	ResponsePanel["Choice" .. numChoices].Text = "Goodbye!"
	ChoiceValues[ResponsePanel["Choice" .. numChoices]] = nil
	
	handleResize()
	
	
	--[[ResponsePanel.Choice1.Text = choice1.Value
	ResponsePanel.Choice2.Text = choice2.Value
	ResponsePanel.Choice3.Text = choice3.Value
	
	ChoiceValues[ResponsePanel.Choice1] = choice1
	ChoiceValues[ResponsePanel.Choice2] = choice2
	ChoiceValues[ResponsePanel.Choice3] = choice3]]
	
	windowData:SetVisible(true)
	
	--end conversation when player dosent reponse fast enough
	responded = false
	local timeout = 0
	while not responded do
		wait(0.1)
		if timeout == CHAT_IDLE_TIMEOUT and currentHead then
			workspace.MessageService.ShowHint.ShowHint:Fire("Chat ended because you did not reply.",4)
			workspace.Dialog:FireServer("EndConversation",currentHead)
			break
		end
		timeout = timeout + 1
	end
end




workspace.Dialog.OnClientEvent:connect(function(action,...)
	
	local args = {...}

	if action == "BubbleClicked" then --when you or other players click bubble UNIVERSAL
		BubbleClicked(args[1])
	
	elseif action == "ConversationFinished" then  --when anyone finshes a converations, show bubble again UNIVERSAL
		ConversationFinished(args[1])
	
	elseif action == "AlreadyInConveration" then   --NPC is already talking with another player LOCAL
		AlreadyInConversation()
		
	elseif action == "ShowResponseOptions" then  --show to local player LOCAL
		ShowResponseOptions(args[1])

		
	end
end)


-----------------------------------------------------------------------------------------------------------------


--[[local mouse = game.Players.LocalPlayer:GetMouse()

function MouseEnter()
	mouse.Icon = "rbxasset://textures\\DragCursor.png"
end

function MouseLeave()
	mouse.Icon = ""
end]]




function ResponseSelected(response)
	windowData.LastSelection = ResponsePanel.Choice1 --for gamepad, start selection back at the top when the window is opened again
	windowData:SetVisible(false)
	workspace.Dialog:FireServer("ResponseSelected",ChoiceValues[response],currentHead)
	responded = true
end

for _,button in ipairs(ResponsePanel:GetChildren()) do
	button.MouseButton1Click:connect(function() ResponseSelected(button) end)
end








--------------------------------------------------------------------------------------------------------------------------

function changeTextSize(size)
	for _,button in ipairs(ResponsePanel:GetChildren()) do
		button.FontSize = size
	end
end

function ScaleChoices(height)
	for i,button in ipairs(ResponsePanel:GetChildren()) do
		ResponsePanel["Choice" .. i].Size = UDim2.new(1,-7,0,height)
		ResponsePanel["Choice" .. i].Position = UDim2.new(0,7,0,(i-1)*height)
	end
end


function handleResize()
	if workspace.CurrentCamera.ViewportSize.Y < 600 then
		ResponsePanel.Size = UDim2.new(0, 230,0, numChoices * MOBILE_CHOICE_BUTTON_HEIGHT)
		ResponsePanel.Position = UDim2.new(0.03, -20,1, -numChoices * MOBILE_CHOICE_BUTTON_HEIGHT)
		changeTextSize(Enum.FontSize.Size14)
		ScaleChoices(MOBILE_CHOICE_BUTTON_HEIGHT)
	else
		ResponsePanel.Size = UDim2.new(0, 350,0, numChoices * CHOICE_BUTTON_HEIGHT)
		ResponsePanel.Position = UDim2.new(0.03, 0,0.95, -numChoices * CHOICE_BUTTON_HEIGHT)
		ScaleChoices(CHOICE_BUTTON_HEIGHT)
		changeTextSize(Enum.FontSize.Size24)
	end
end

Window.Changed:connect(function(prop)
	if prop == "AbsoluteSize" then
		handleResize()
	end
end)

handleResize()


local screenCenter = Vector2.new(MainGui.AbsoluteSize.X/2,MainGui.AbsoluteSize.Y/2)
local minimumDistance = MainGui.AbsoluteSize.X/3
local CurrentBillboard = nil
local bindableEventEnabled = false


--show X button when line of sign of dialog
if _G.GamepadEnabled then
	while true do
		wait(1)
		local distance = minimumDistance
		--find dialog that is closes to the middle of the screen
		for head,billboard in pairs(billboards) do
			if billboard.Enabled and billboard:FindFirstChild("XButton") then
				if player:DistanceFromCharacter(head.Position) < CONVERSATION_DISTANCE then
					local point = camera:WorldToScreenPoint(head.Position)
					local dis = math.sqrt(math.pow(point.X-screenCenter.X,2)+math.pow(point.Y-screenCenter.Y,2))
					if dis < distance then
						distance = dis
						if CurrentBillboard and CurrentBillboard.Parent then
							CurrentBillboard.XButton.Visible = false
						end
						CurrentBillboard = billboard

						billboard.XButton.Visible = true
					end
					if dis > minimumDistance and billboard == CurrentBillboard and CurrentBillboard.Parent then
						billboard.XButton.Visible = false
						CurrentBillboard = nil

					end
				elseif billboard == CurrentBillboard and CurrentBillboard.Parent then
					CurrentBillboard.XButton.Visible = false
					CurrentBillboard = nil
				end
			end
		end
		--if no billboards in line of sight
		if distance == minimumDistance and bindableEventEnabled then
			bindableEventEnabled = false
			game:GetService("ContextActionService"):UnbindAction("TalkToCustomer")
		
		elseif distance ~= minimumDistance and not bindableEventEnabled then
			bindableEventEnabled = true
			game:GetService("ContextActionService"):BindAction("TalkToCustomer", function(action,state,InputObject) 
				if state == Enum.UserInputState.Begin then
					StartConversation(CurrentBillboard.Adornee,CurrentBillboard)
				end
			end, false, Enum.KeyCode.ButtonX) --StartConversation(CurrentBillboard.Adornee,CurrentBillboard)
		end
	end
end
	

------------------------------------------------------------------------------------



































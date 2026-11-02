local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
if Enums.IsPartyServer then  --only runs in party mode
	script:Destroy()
	return
end


if game:GetService("RunService"):IsStudio() then
	workspace.Main.StartChooseJob.OnClientEvent:wait()
end

local camera = workspace.CurrentCamera


local Window = script.Parent
local player = game.Players.LocalPlayer
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local Debug = require(game.ReplicatedStorage:WaitForChild("Debug"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))


local BackpackData = GuiManager:GetWindowDataByName("Backpack")
local ChatWindow = GuiManager:GetWindowDataByName("ChatWindow")
local ChatMenu = GuiManager:GetWindowDataByName("ChatMenu")
local PlayerListData = GuiManager:GetWindowDataByName("PlayerList")
local MenuData = GuiManager:GetWindowDataByName("Menu")
local ContextActionService = game:GetService("ContextActionService")


local PlayButton = Window.Parent:WaitForChild("Play"):WaitForChild("Play")
local Chooser = Window:WaitForChild("Chooser")
local AButton = Chooser:WaitForChild("AButton")
local Next = Chooser:WaitForChild("Next")
local Previous = Chooser:WaitForChild("Previous")
local Choose = Chooser:WaitForChild("Choose")

BackpackData:SetVisible(false)
PlayerListData:SetVisible(false)
--ChatMenu:SetVisible(false)
ChatWindow:SetVisible(false)
MenuData:SetVisible(false)


local WindowData = GuiManager:RegisterWindow(Window)






workspace.Main.StartedPlaying.OnClientEvent:connect(function()
	wait()
	WindowData:SetVisible(false)
end)



_G["Skip"] = false
_G["IntroStarted"] = false





index = 6

jobs = {{"Cashier",21,workspace.Focuses.CashierFocus,CFrame.new(72.5300674, 13.5677662, 85.9730301)},
{"Cook",24,workspace.Focuses.CookFocus,CFrame.new(27.1633873, 13.9753036, 74.3990021)},
{"Pizza Boxer",106,workspace.Focuses.BoxerFocus,CFrame.new(47.1844292, 12.1402969, 5.29981661)},
{"Delivery",23,workspace.Focuses.DeliveryFocus,CFrame.new(75.0271759, 14.1454096, -27.2053604)},
{"Supplier",1,workspace.Focuses.SupplierFocus,CFrame.new(43.0193329, 25.6074085, -702.088501)},
{"House",194,nil,nil}
}

local inverted_house = {House3 = true, House4 = true, House7 = true, House8 = true, House11 = true, House12 = true}


--[[local frame = CFrame.new(26.7740021, 13.5368719, 74.0267563, 0.703339934, 0.26696527, -0.65881902, -0, 0.926799774, 0.375555873, 0.710853696, -0.264143437, 0.65185529)
workspace.Camera:Interpolate(CFrame.new(26.7740021, 12.5368719, 74.0267563),frame, 2 )
camera.CameraType = "Scriptable"  workspace.Camera:Interpolate(CFrame.new(67.687149, 13.964325, 112.208336) ,workspace.Focuses.CashierFocus.CFrame,1)
camera.CameraType = "Scriptable" camera:Interpolate(workspace.Cashier.CFrame,CFrame.new(workspace.Cashier.CFrame*workspace.Cashier.CFrame.lookVector), 2 )
]]
house = nil
spawn(function()
	
	while house == nil do
		wait(.1)
		for i,v in ipairs(workspace.Houses:GetChildren()) do
			if v.Owner.Value == player then
				house = v
				break
			end
		end
	end
end)



local transitionSpeed = (Debug.Enabled and Debug.JobTransitionSpeed) or 1.3
local chooseDisabled = false --disable choose button during tutorial

local IsNewPlayer = workspace.Main.IsNewPlayer:InvokeServer()


function buttonPress(isNext)
	camera.CameraType = "Scriptable"

	if isNext then
		index = index + 1
		if index == 7 then
			index = 1
		end
	else
		index = index - 1
		if index == 0 then
			index = 6
		end
	end
	if index == 6 and house == nil then index = 1 end
	local job = jobs[index]
	
	
	if index ~= 6 then
		script.Parent.Label.label.Text = "Choose Job"
		camera:Interpolate(job[4],job[3].CFrame, transitionSpeed)
	
	elseif house.CurrentUpgrade.Value then
		script.Parent.Label.label.Text = "Or start at your house"
		local cframe = house.CurrentUpgrade.Value.GivePizza.CFrame + Vector3.new(20,5,20)
		if inverted_house[house] then
			 cframe = house.CurrentUpgrade.Value.GivePizza.CFrame + Vector3.new(20,5,20)
		end
		camera:Interpolate(cframe,house.CurrentUpgrade.Value.Doors.FrontDoor.Door_Closed.Door.CFrame,transitionSpeed)
	end
	local jobname = script.Parent.JobName
	if IsNewPlayer and index ~= 1 then
		if _G.GamepadEnabled then
			script.Parent.Chooser.AButton.Lock.Visible = true
		else
			script.Parent.Chooser.Choose.Frame.Visible = true
		end
		
		chooseDisabled = true
	else
		if _G.GamepadEnabled then
			script.Parent.Chooser.AButton.Lock.Visible = false
		else
			script.Parent.Chooser.Choose.Frame.Visible = false
		end
		chooseDisabled = false
	end
	
	jobname:TweenPosition(UDim2.new(1, 0, 0.7, -20),Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,transitionSpeed/2,true)
	wait(transitionSpeed/2)
	jobname.name.Text = job[1]
	jobname.name.TextColor3 = BrickColor.new(1).Color --job2
	jobname.Position = UDim2.new(-0.3,0,.7,-20)
	jobname:TweenPosition(UDim2.new(0.35, 0, 0.7, -20),Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,transitionSpeed/2,true)
	wait(transitionSpeed/2)
end



function telespawn()
	if chooseDisabled then return end
	local UIS = game:GetService('UserInputService')

	if not IsNewPlayer then
		BackpackData:SetVisible(true)
		PlayerListData:SetVisible(true)
		MenuData:SetVisible(true)
		--ChatMenu:SetVisible(true)
		ChatWindow:SetVisible(true)
	end
	
	GuiManager:TouchControlsEnabled(true)

	while player.Character == nil do wait(.1) end

	camera.CameraType = Enum.CameraType.Custom
	camera.CameraSubject = player.Character:WaitForChild("Humanoid",1)

	
	
	local job = jobs[index]
	if job[2] == 194 then
		Utility:SendData("TeleportToJob","PlayerChannel",nil,true,job[2])
	else
		Utility:SendData("TeleportToJob","PlayerChannel",nil,false,job[2])
	end
end


function distance(pos1,pos2)
	return (pos1-pos2).magnitude
end



Next.MouseButton1Click:connect(function() buttonPress(true) end)
Previous.MouseButton1Click:connect(function() buttonPress(false) end)
Choose.MouseButton1Click:connect(function() telespawn() end)

--loading_screen.Play.Visible = true







local trigger = nil
local continue = false

	

--wait for play button to be pressed
	
GuiManager:TouchControlsEnabled(false)

PlayButton.Parent.Visible = true

if Enums.GamepadEnabled then
	
	player:WaitForChild("PlayerScripts"):WaitForChild("ControlScript")--control script loads after player gui so jump with A button will overide
	
	PlayButton.Visible = false
	PlayButton.Parent:WaitForChild("AButton").Visible = true
	if (Enums.IsTestPlace and Enums.IsOnline) or (Debug.Enabled and Debug.IntroEnabled) then
		while #game:GetService("UserInputService"):GetConnectedGamepads() == 0 do
			script.Parent.Parent:WaitForChild("PlugInGamepad").Visible = true
			wait(.3)
		end
		script.Parent.Parent:WaitForChild("PlugInGamepad").Visible = false

	end
	
	--gamepad A button pressed
	ContextActionService:BindAction("StartGame", function(action,state,inputObject) 
--	print("CINCO",action,state,inputObject.KeyCode)
	--if state == Enum.UserInputState.Begin then
		continue = true 
	--end
	end, false, Enum.KeyCode.ButtonA)
	
	
end

trigger = PlayButton.MouseButton1Click:connect(function() 
	trigger:disconnect()
	trigger = nil
	continue = true
end)




	
while not continue and not (Debug.Enabled and Debug.AutoPressPlayButton) do
	camera.CameraType = "Scriptable"
	camera.CoordinateFrame = CFrame.new(47.434, 6.956, 217.24)
	camera.Focus = workspace.FrontDoor.CFrame
	wait(.1)
end
ContextActionService:UnbindAction("StartGame")

if trigger then
	trigger:disconnect()
end
	
	
PlayButton.Parent:Destroy()
	
_G["IntroStarted"] = true

	
	
local speed = (Debug.Enabled and Debug.JobTransitionSpeed) or 3
	
	--initial camera tween
camera.CameraType = "Scriptable"
camera:Interpolate(CFrame.new(47.434, 6.956, 161.040009),workspace.Focuser.CFrame,speed)--distance(Vector3.new(47.434, 6.956, 161.040009),camera.CoordinateFrame.p)/80
connection = camera.InterpolationFinished:connect(function()
		
	connection:disconnect()
	connection = nil
	PlayerListData:SetVisible(true)
	buttonPress(true)
	WindowData:SetVisible(true)


end)



local x,y,direction


if Enums.GamepadEnabled then
	
	Next.Style = Enum.ButtonStyle.Custom
	Previous.Style = Enum.ButtonStyle.Custom
	
	Next.BackgroundTransparency = 1
	Previous.BackgroundTransparency = 1
	
	Choose.Visible = false
	AButton.Visible = true

	WindowData:RegisterGamepadAction(Enum.KeyCode.ButtonA, function(action,state,inputObject)
		--print("pressed")
		telespawn()
	end)
	

	WindowData:RegisterGamepadAction(Enum.KeyCode.Thumbstick1,function(action,state,inputObject)
					
		x = inputObject.Position.X
		y = inputObject.Position.Y
		if math.sqrt(math.pow(x,2)+math.pow(y,2)) > .7 then --if thumbstick is nearing the edge.
			if direction == nil then
				if x > -.5 and x < .5 then
					if y > 0 then
						direction = "Up"
					else
						direction = "Down"
					end
				elseif x > .5 then
					direction = "Right"
				elseif x < -.5 then
					direction = "Left"
				end
					
				workspace.Main.ThumbstickGesture:Fire(direction)
			end
				
				
		else
			direction = nil
		end
	end)
	
	

	
	
	--[[ContextActionService:BindAction("PlayWithParty", function(action,state,inputObject) 
		--if state == Enum.UserInputState.Begin then
		--	EquipTool(Tools[index]) 
		--end
	end, false, Enum.KeyCode.ButtonX)]]
	
	
	
	

	
	
	workspace.Main.ThumbstickGesture.Event:connect(function(direction)
		if direction == "Right" then
			buttonPress(true)
		elseif direction == "Left" then
			buttonPress(false)
		end
	end)
	
	
end












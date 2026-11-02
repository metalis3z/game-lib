local CAS = game:GetService("ContextActionService")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local TouchEnabled = game:GetService("UserInputService").TouchEnabled


local Window = script.Parent
local Continue = (_G.GamepadEnabled and Window:WaitForChild("ContinueGamepad")) or Window:WaitForChild("Continue")
local Ok = (_G.GamepadEnabled and Window:WaitForChild("OkGamepad")) or Window:WaitForChild("Ok")
local Delete = (_G.GamepadEnabled and Window:WaitForChild("DeleteGamepad")) or Window:WaitForChild("Delete")
local Start = (_G.GamepadEnabled and Window:WaitForChild("StartGamepad")) or Window:WaitForChild("Start")
local Message = Window:WaitForChild("Message")
local DisableInput = Window.Parent:WaitForChild("DisableInput")
local Cancel = Window:WaitForChild("CancelButton")

local player = game.Players.LocalPlayer
local buttonSelected = nil

local Backpack = MainGui.Menu:WaitForChild("Backpack")
local ChatWindow = MainGui.Menu:WaitForChild("ChatWindow")
local PlayerList = MainGui.Menu:WaitForChild("PlayerList")


if MainGui.AbsoluteSize.Y < 500 then
	Message.TextSize = 18
	Window:WaitForChild("UIAspectRatioConstraint"):Destroy()
	Window.Size = UDim2.new(0,200,0,150)
elseif _G.GamepadEnabled then
	Message.TextSize = 28
end


local WindowData = GuiManager:RegisterWindow(Window,"Right","Right",.1)
WindowData:SetConsoleSize(UDim2.new(0,450,1,0))
WindowData.CanBeFocused = false
WindowData:CancelingEnabled(false)

--remove cancel hint at the bottom of window
if Window:FindFirstChild("CancelGamepadHint") then
	Window.CancelGamepadHint:Destroy()
end

local BackpackData = GuiManager:GetWindowDataByName("Backpack")
local ChatWindowData = GuiManager:GetWindowDataByName("ChatWindow")
local PlayerListData = GuiManager:GetWindowDataByName("PlayerList")
local MenuData = GuiManager:GetWindowDataByName("Menu")

local currentTutorialName = nil
local keyboardInput = nil

local Swish = SoundFX:GetSoundObject("Swish")


local TeamColorToJobIndex = {
	["Bright red"] = 1,
	["Bright yellow"] = 2,
	["Bright orange"] = 3,
	["Bright blue"] = 4,
	["White"] = 5,
	["Medium stone grey"] = 6
}


while not _G["StartedPlaying"] do wait(.1) end





Window.Changed:connect(function(property)  --if player quits the tutorial then stop waiting for button
	if property == "Visible" and not Window.Visible then
		buttonSelected = "Continue"
	end
end)



function SpawnButton(button)
	local buttonCopy = button:clone()
	buttonCopy.Parent = workspace
	buttonCopy.Head.Touched:connect(function(hit)
				
		if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
			local play = game.Players:GetPlayerFromCharacter(hit.Parent)
			if play and play == player then
				currentTutorialName = button.Name
				workspace.Main.StartTutorial:FireServer(button.Index.Value)
				buttonCopy:Destroy()
			end
		end
	end)
end

workspace.TutorialService.ShowButton.OnClientEvent:connect(function(jobIndex)
	for _,button in ipairs(game.ReplicatedStorage.TutorialButtons:GetChildren()) do
		if button.Index.Value == jobIndex then
			
			SpawnButton(button)
			break
		end
	end
end)




local completedTutorials = workspace.Main.GetCompletedTutorials:InvokeServer()

local IsNewPlayer = workspace.Main.IsNewPlayer:InvokeServer()
--local jobIndex = TeamColorToJobIndex[player.TeamColor.Name]

--player is going to be prompted emidiatly. Dont need to show cashier button
if IsNewPlayer then
	completedTutorials[1] = true 
	currentTutorialName = "Cashier Tutorial"
end


if completedTutorials then
	
	--get all tutorial buttons and add the tutorial the player hasnt finished to workspace
	local buttons = game.ReplicatedStorage.TutorialButtons
	for _,button in ipairs(buttons:GetChildren()) do
		
		local index = button.Index.Value
		
		local existingButton = workspace:FindFirstChild(button.Name) --if respawn then destory old buttons
		if existingButton then
			existingButton:Destroy()
		end
		if completedTutorials[index] ~= true then

			
			SpawnButton(button)
		end
	end
end

workspace.TutorialService.ShowArrowKeys.OnClientEvent:connect(function()
	if IsNewPlayer and Window.Parent:FindFirstChild("ArrowKeys") then
		Window.Parent.ArrowKeys.Visible = true
	end
end)

HighlightedCell = nil
workspace.TutorialService.HighlightOrder.OnClientEvent:connect(function()
	for _,cell in ipairs(workspace.Orders:GetChildren()) do
		if cell.SG.ImageLabel.Image == "http://www.roblox.com/Thumbs/Asset.ashx?Width=110&Height=110&AssetID=168540808" then
			HighlightedCell = cell
			HighlightedCell.BrickColor = BrickColor.new("Really red")
			break
		end
	end
	
end)

--change house's label temporarily during delivery tutorial to avoid confusion
workspace.TutorialService.ChangeHouseLabel.OnClientEvent:connect(function(name)
	workspace.Houses.House3.MailboxPointer.Value.Head.LabelBack.TextLabel.Text = name
	workspace.Houses.House3.MailboxPointer.Value.Head.LabelFront.TextLabel.Text = name
end)

function wiggleWiggleWiggle()
	math.randomseed(tick())
	math.random()
	for i=1,10 do
		wait()
		Window.Rotation = math.random(-10,10)
	end
	Window.Rotation  = 0
end




local camera = workspace.CurrentCamera

function QuitTutorial()
	WindowData:SetVisible(false)
	DisableInput.Visible = false
	clearArrows()
	camera.CameraType = "Custom"
	buttonSelected = "Continue"
	MenuData.Disabled = false
	MenuData:SetVisible(true)
	if workspace.CurrentCamera:FindFirstChild("Barriers") then
		workspace.CurrentCamera.Barriers:Destroy()
	end
	CAS:UnbindAction("Cancel")
	PlayerListData.Disabled = false
	PlayerListData:SetVisible(true)
	BackpackData.Disabled = false
	BackpackData:SetVisible(true)
	pcall(function() player.Character.Humanoid.WalkSpeed = 16 end)	
	DisableInput.BackgroundTransparency = 1
	if keyboardInput then keyboardInput:disconnect() keyboardInput = nil end
end


workspace.TutorialService.QuitTutorial.OnClientEvent:connect(function()
	QuitTutorial()
end)



function PromptCancel()
	if Dialog:GetChoice("","Are you sure you want to quit the tutorial?","Yes","No") then
		--show button again
		if not _G.GamepadEnabled then
			delay(1,function() SpawnButton(game.ReplicatedStorage.TutorialButtons:FindFirstChild(currentTutorialName)) end)
		end
		
		workspace.Main.QuitTutorial:FireServer()
	end
end


--quit tutorial
Cancel.MouseButton1Click:connect(function()
	PromptCancel()
end)






--point at a certain object
local currentArrows = {}
workspace.TutorialService.ShowArrow.OnClientEvent:connect(function(object,height)
	if object and object.Parent then
		local arrow = Window.Parent.ArrowTemplate:clone()
		arrow.Animation.Disabled = false
		arrow.Parent = Window.Parent
		arrow.Enabled = true
		arrow.Adornee = object
		arrow.StudsOffset = Vector3.new(0,height or 0, 0)
		table.insert(currentArrows,arrow)
		if object.Name == "Head" then
			while arrow and arrow.Parent do
				if not object:FindFirstChild("Dialog") then
					arrow.Adornee = nil
				end
				wait(.5)
			end
		end
	end
		
	
end)


local currentWires = {}
local currentSprites = {}
--creal arrow that point to objects and floorwires
function clearArrows()
	print("CLEARED ARROWS")
	if #currentArrows > 0 then
		for _,arrow in ipairs(currentArrows) do
			arrow:Destroy()
		end
	end
	if #currentWires > 0 then
		for _,wire in ipairs(currentWires) do
			wire:Destroy()
		end
	end
	if #currentSprites > 0 then
		for _,sprite in ipairs(currentSprites) do
			sprite.Visible = false --gets destroyed when set invisible
		end
	end
	currentWires = {}
	currentArrows = {}
	currentSprites = {}
end


workspace.TutorialService.RemoveArrows.OnClientEvent:connect(function()
	clearArrows()
end)



workspace.TutorialService.ShowFloorWire.OnClientEvent:connect(function(to,from)
	local FloorWire = Instance.new("FloorWire")
	FloorWire.To = to
	FloorWire.From = from
	FloorWire.Transparency = 0.5
	FloorWire.WireRadius = 0
	FloorWire.TextureSize = Vector2.new(2,2)
	FloorWire.Texture = "http://www.roblox.com/asset/?id=168194931"
	FloorWire.Parent = Window.Parent
	table.insert(currentWires,FloorWire)
end)


local RadialMenuSprite = MainGui:WaitForChild("Menu"):WaitForChild("GamepadMainMenu"):WaitForChild("ArrowAnimation")
local MenuSprite = MainGui:WaitForChild("Menu"):WaitForChild("Menu"):WaitForChild("Inventory"):WaitForChild("ArrowAnimation")

workspace.TutorialService.AnimatedArrowSprite.OnClientEvent:connect(function(name)
	local template
	local startPos,endPos
	if name == "RadialMenu" then
		template = RadialMenuSprite
		startPos = -50
		endPos = -80
	else
		template = MenuSprite
		startPos = 90
		endPos = 100
	end
	
	local clone = template:clone()
	clone.Parent = template.Parent
	clone.Visible = true
	
	table.insert(currentSprites,clone)

	local originalPosX = clone.Position.X.Offset
	local originalScalePosX = clone.Position.X.Scale
	spawn(function()
		while clone and clone.Visible do
			clone:TweenPosition(UDim2.new(originalScalePosX, originalPosX, 0, startPos), "Out", "Sine", .5, true)
			wait(.5)
			clone:TweenPosition(UDim2.new(originalScalePosX, originalPosX, 0, endPos), "Out", "Sine", .5, true)
			wait(.5)
		end
		clone:Destroy()
	end)
end)


--centers the gamepad help 
local GamepadHelp = MainGui:WaitForChild("Notifications"):WaitForChild("MenuGamepadHelp")
local originPos = GamepadHelp.Position

workspace.TutorialService.ShowGamepadMenuHelp.OnClientEvent:connect(function(centered)
	if centered then
		GamepadHelp.Position = UDim2.new(.5,0,.5,0)
	else
		GamepadHelp.Position = originPos
	end
end)





workspace.TutorialService.ShowRecipes.OnClientEvent:connect(function()
	game.ReplicatedStorage.Recipes:clone().Parent = workspace.CurrentCamera
end)


local cameraPanning = false

--pan camera to differnt objects
workspace.TutorialService.PanToCFrame.OnClientEvent:connect(function(cframe)
	WindowData:SetVisible(false)
	cameraPanning = true
	camera.CameraType = "Scriptable"
	camera:Interpolate(cframe,CFrame.new(cframe.p + (cframe.lookVector*2)) ,.5)
	wait(1.5)
	cameraPanning = false
end)


workspace.TutorialService.GuiEnabled.OnClientEvent:connect(function(guiName,enabled)
	local windowData = GuiManager:GetWindowDataByName(guiName)
	if enabled then windowData.Disabled = false end
	windowData:SetVisible(false)
	if not enabled then windowData.Disabled = true end
end)

--dont allow player to leave job area
local container = workspace.CurrentCamera:FindFirstChild("Barriers")
workspace.TutorialService.OpenBarrier.OnClientEvent:connect(function(jobName,canCollide)
	if not workspace.CurrentCamera:FindFirstChild("Barriers") then
		container = game.ReplicatedStorage.Barriers:clone()
		container.Parent = workspace.CurrentCamera
		for _,job in ipairs(container:GetChildren()) do
			for _,barrier in ipairs(job:GetChildren()) do
				barrier.Touched:connect(Utility:Debounce(function(hit)
					if barrier.CanCollide and hit and hit.Parent and hit.Parent == player.Character then
						Dialog:ShowMessage("Tutorial not finished","You must finish or quit the tutorial to leave this area.")
						wait(5)
					end
				end))
			end
		end
	end
		
	for _,barrier in ipairs(container[jobName]:GetChildren()) do
		if barrier.Name == "Barrier2" then
			barrier.CanCollide = canCollide
		end
	end 
end)

local CameraLock = player:WaitForChild("PlayerGui",10):WaitForChild("WorkTool",10):WaitForChild("CameraLock",10)

--Show meesage without buttons
workspace.TutorialService.ShowMessage.OnClientEvent:connect(function(message)

	if not cameraPanning then
		
		if camera.CameraType ~= Enum.CameraType.Custom and not CameraLock.Value then
			camera.CameraType = Enum.CameraType.Custom 
			workspace.Main.RealignCamera.RealignCamera:Fire(25,12)
		end
		
	end
	
	pcall(function() player.Character.Humanoid.WalkSpeed = 16 end)


	if message == "" then
		WindowData:SetVisible(false)
		return
	end
	
	
	clearArrows()

	
	WindowData:SetVisible(false)
	wait(.12)
	WindowData:SetVisible(true)
	Swish:Play()
	
	Message.Text = message
	Continue.Visible = false
	Ok.Visible = false
	Delete.Visible = false
	Start.Visible = false
	
	CAS:BindAction("Cancel", function(action,state,inputObject) if state == Enum.UserInputState.Begin then PromptCancel()  end end, false,Enum.KeyCode.ButtonB)

end)



--prompt player and disable movment
function workspace.TutorialService.PromptPlayer.OnClientInvoke(message,type)
	clearArrows()
	--if type ~= 4  then
		--[[script.Parent:TweenPosition(UDim2.new(1, 0,0,0), "Out", "Quad", .2)
		Swish:Play()
		wait(.2)]]
		--[[script.Parent.Position = UDim2.new(1, 0,0,0)
		wait(.2)
		script.Parent:TweenPosition(UDim2.new(.8, -85, 0, 0), "Out", "Quad", .2,true)]]
		WindowData:SetVisible(false)
		wait(.12)
		WindowData:SetVisible(true)
		Swish:Play()
		
	--end
	
	--wiggle when key is pressed
	keyboardInput = game:GetService("UserInputService").InputBegan:connect(function(input,gameProcessed)
		if input.UserInputType == Enum.UserInputType.Keyboard and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.WalkSpeed == 0 then
			wiggleWiggleWiggle()
		end
	end)
	
	
	DisableInput.Visible = true
	buttonSelected = nil
	Continue.Visible = false
	Ok.Visible = false
	Delete.Visible = false
	Start.Visible = false
	Message.Text = message
	if not cameraPanning then
		camera.CameraType = "Custom"
	end
	
	local leftClick = DisableInput.MouseButton1Down:connect(wiggleWiggleWiggle)
	local rightClick = DisableInput.MouseButton2Down:connect(wiggleWiggleWiggle)
	
	CAS:UnbindAction("Cancel") --just in case
	
	if type == 2 then
		Continue.Visible = true
		pcall(function() player.Character.Humanoid.WalkSpeed = 0 end)
		CAS:BindAction("Continue", function(action,state,inputObject) if state == Enum.UserInputState.Begin then buttonSelected = "Continue"  end end, false,Enum.KeyCode.ButtonA)

		
	elseif type == 4 then --start tutorial
		Delete.Visible = true
		Start.Visible = true
		DisableInput.BackgroundTransparency = .65
		PlayerListData:SetVisible(false)
		PlayerListData.Disabled = true
		pcall(function() player.Character.Humanoid.WalkSpeed = 0 end)
		CAS:BindAction("Start", function(action,state,inputObject) if state == Enum.UserInputState.Begin then buttonSelected = "Start"  end end, false,Enum.KeyCode.ButtonA)


	elseif type == 5 then
		Ok.Visible = true
		pcall(function() player.Character.Humanoid.WalkSpeed = 0 end)
		CAS:BindAction("Ok", function(action,state,inputObject) if state == Enum.UserInputState.Begin then buttonSelected = "Ok"  end end, false,Enum.KeyCode.ButtonA)

	end
	
	CAS:BindAction("Cancel", function(action,state,inputObject) if state == Enum.UserInputState.Begin then PromptCancel()  end end, false,Enum.KeyCode.ButtonB)

	while buttonSelected == nil do
		wait(.1)
	end
	
	CAS:UnbindAction("Start")
	CAS:UnbindAction("Delete")
	CAS:UnbindAction("Ok")
	CAS:UnbindAction("Cancel")
	CAS:UnbindAction("Continue")

	
	if type == 2 then workspace.Main.RealignCamera.RealignCamera:Fire(25,12) end
	
	if rightClick then rightClick:disconnect() end
	if leftClick then leftClick:disconnect() end
	if keyboardInput then keyboardInput:disconnect() end
	
	keyboardInput = nil
	rightClick = nil
	leftClick = nil
	
	if HighlightedCell then HighlightedCell.BrickColor = BrickColor.new("Mid gray") HighlightedCell = nil end
	DisableInput.Visible = false
	DisableInput.BackgroundTransparency = 1

	return buttonSelected
end


for _,obj in ipairs(Window:GetChildren()) do
	if obj:IsA("TextButton") and obj.Name ~= "CancelButton" then
		obj.MouseButton1Click:connect(function()
			if not cameraPanning then
				buttonSelected = obj.Name
			end
		end)
	end
end
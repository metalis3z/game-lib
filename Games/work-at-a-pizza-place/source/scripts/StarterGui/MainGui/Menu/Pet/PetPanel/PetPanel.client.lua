
local Window = script.Parent
local PetFolder = Window.Parent
local player = game.Players.LocalPlayer

local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local UIEvents = PlayerGui:WaitForChild("UIEvents")

local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))


local PetPanelButton = MainGui:WaitForChild("Menu"):WaitForChild("Menu"):WaitForChild("PetPanel")

local StopPetting = PetFolder:WaitForChild("StopPetting")
local Meters = Window:WaitForChild("Meters")
local FeedMeter = Meters:WaitForChild("FeedMeter")
local SleepMeter = Meters:WaitForChild("SleepMeter")
local PetMeter = Meters:WaitForChild("PetMeter")
local PlayMeter = Meters:WaitForChild("PlayMeter")


local Switcher = Window:WaitForChild("Switcher")
local PetName = Switcher:WaitForChild("PetName")
local Next = Switcher:WaitForChild("Next")
local Previous = Switcher:WaitForChild("Previous")
local NewPet = Switcher:WaitForChild("NewPet")

local GamepadPetHand = MainGui.Menu:WaitForChild("GamepadPetHand")

local Commands = Window:WaitForChild("Commands")
local ToggleActive = Commands:WaitForChild("ToggleActive")
local Hold = Commands:WaitForChild("Hold")
local Stay = Commands:WaitForChild("Stay")
local Hat = Commands:WaitForChild("Hat")
local ButtonsDisabled = true



local Notifications = MainGui:WaitForChild("Notifications")
local Hint = Notifications:WaitForChild("Hint")

local CAS = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")

local ToggleVisible = Window:WaitForChild("ToggleVisible")

local camera = workspace.CurrentCamera
local mouse = player:GetMouse()

wait()

if Window.AbsoluteSize.Y > MainGui.AbsoluteSize.Y then
	Window.Size = UDim2.new(0,200,1,0)
end

local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local windowData = GuiManager:RegisterWindow(Window,"Right","Right")
local backpackData = GuiManager:GetWindowDataByName("Backpack")

local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))

windowData.FirstSelectedObject = FeedMeter:WaitForChild("Feed")




print("Pet Gui Started")
local metersData = {
	"SleepMeter",
	"FeedMeter",
	"PetMeter",
	"PlayMeter",
}

local toggleImages = {
	[true] = "rbxassetid://314559108",
	[false] = "rbxassetid://314559093"
}
local meters = {}
local maxSize = 7
local iconSize = 30

local currentPetIndex = 1
local numPets = 0

function createIcon(index,frame)
	local icon = Instance.new("ImageLabel")
	icon.Size = UDim2.new(0,iconSize,0,iconSize)
	icon.Position = UDim2.new(0,(iconSize+2)*index,0.5,-iconSize/2)
	icon.Image = "rbxassetid://320514994"
	icon.BackgroundTransparency = 1
	icon.Visible = false
	icon.Parent = frame
	return icon
	
end

local index = 0
for _,name in ipairs(metersData) do
	local frame = Instance.new("Frame")
	frame.Name = name
	frame.Position = UDim2.new(0,70,0,0)
	frame.Size = UDim2.new(0,iconSize*maxSize,0,50)
	frame.BackgroundTransparency = 1
	frame.Parent = Meters:FindFirstChild(name)
	local icons = {}
	local anti_icons = {}
	for x=0,maxSize-1 do
		local icon = createIcon(x,frame)
		icon.ZIndex = 2
		local anti_icon = createIcon(x,frame)
		anti_icon.ImageColor3 = Color3.new(0,0,0)
		table.insert(icons,icon)
		table.insert(anti_icons,anti_icon)
	end
	meters[name] = {icons,anti_icons}
	index = index + 1
end




--["SleepMeter"] = {{frame,frame},{frame,frame}}




local petData = workspace.PetService.GetPetData:InvokeServer()

numPets = #petData



while petData == nil do wait(.1) end






function getPetDataIndexFromName(petName)
	for i,pet in ipairs(petData) do
		if pet.Name == petName then
			return i
		end
	end
	
end

workspace.PetService.PetObjectChanged.OnClientEvent:connect(function(object)
	petData[currentPetIndex].Object = object
end)


local maxNumPet = (Enums.IsPartyServer and 1) or 3 

workspace.PetService.PetCreated.OnClientEvent:connect(function(Pet)
	currentPetIndex = 1
	

	ToggleActive.DisableButton2.Visible = false --undarken active button if this is first pet
	
	--deactivate a pet if 3 are aleady active
	local activeCount = 0
	for _,pet in ipairs(petData) do
		if pet.Active then
			activeCount = activeCount + 1
			if activeCount >= 3 then
				local active = workspace.PetService.ToggleActive:InvokeServer(pet.Name)
				if active ~= nil then
					pet.Active = active
				end
			end
		end
	end
	
	table.insert(petData,1,Pet)
	currentPetIndex = 1
	numPets = #petData
	
	refresh()
	ResetCommandButtons()
end)



-------------------------------METERS menu-----------------------------------------


workspace.PetService.MeterChanged.OnClientEvent:connect(function(petName,meterName,data)
	local index = getPetDataIndexFromName(petName)
	petData[index][meterName][1] = data
	if index == currentPetIndex then
		refresh(true)
	end
end)


function setMeter(meterName,dataIndex,value,animated)
	local counter = 0
	for i,icon in ipairs(meters[meterName][dataIndex]) do 
		if counter < value then
			if not icon.Visible and animated then
				--while icon.Position.Y ~= 0 do wait(.1) end
				local pos = icon.Position
				local offsetX = (iconSize+2)*(i-1)
				local offsetY = 0
				icon.Size = UDim2.new(0,0,0,0)
				icon.Position = UDim2.new(0,offsetX+(iconSize/2),0.5,0)
				icon:TweenSizeAndPosition(UDim2.new(0,iconSize,0,iconSize),pos,Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,.5,false,function()
					--icon.Position = UDim2.new(0,offsetX,0,offsetY)
				end)
				icon.Visible = true
			elseif not animated then
				icon.Visible = true
			end
			
			
		else
			if icon.Visible and animated then
				--while icon.Position.Y ~= 0 do wait(.1) end
				local pos = icon.Position
				local offsetX = (iconSize+2)*(i-1)
				local offsetY = 0
				icon:TweenSizeAndPosition(UDim2.new(0,0,0,0), UDim2.new(0,offsetX+(iconSize/2),0.5,0),Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,.5,false,function()
					icon.Size = UDim2.new(0,iconSize,0,iconSize)
					icon.Position =  UDim2.new(0,offsetX,0.5,-iconSize/2)
					icon.Visible = false
				end)
			elseif not animated then
				icon.Visible = false
			end
			
		end
		counter = counter + 1
	end
end

function DisableButtons(enabled,dir)
	ButtonsDisabled = enabled
	for _,obj in ipairs(dir:GetChildren()) do
		if obj.Name == "DisableButton" then
			obj.Visible = enabled
		else
			DisableButtons(enabled,obj)
		end
	end
end

local FeedButton = FeedMeter:WaitForChild("Feed")

function refresh(animated)
	local pet = petData[currentPetIndex]
	if pet == nil then windowData.FirstSelectedObject = NewPet return end
	
	
	for name,data in pairs(meters) do
		if pet.Active then
			setMeter(name,1,pet[name][1],animated)  --icons
		else
			setMeter(name,1,0,false)  --icons
		end
		setMeter(name,2,pet[name][2],false)  --anti icons
	end
	
		
	
	
	ToggleActive.Image = toggleImages[pet.Active]
	DisableButtons(not pet.Active,script.Parent)
	PetName.Text = pet.Name
	
	
	
	
	if currentPetIndex == numPets then --at end of list OR 1 pet OR 0 pets --  can have any number of pets
		Next.Visible = false
		NewPet.Visible = true
		
		
		
		if _G.GamepadEnabled then
			if _G.StartedPlaying then
				game:GetService("GuiService").SelectedObject = NewPet
			end
			windowData.FirstSelectedObject = NewPet
		end
		
			
		if numPets >= 2 and currentPetIndex ~= 1 then
			Previous.Visible = true
			FeedButton.NextSelectionUp = Previous
			NewPet.NextSelectionLeft = Previous
			Previous.NextSelectionRight = NewPet
		else
			Previous.Visible = false
			FeedButton.NextSelectionUp = NewPet	
			NewPet.NextSelectionLeft = nil
		end
		
		
		
	elseif currentPetIndex < numPets and currentPetIndex > 1 then --middle of list ---- has 3 or more pets
		Previous.Visible = true
		Next.Visible = true
		NewPet.Visible = false
		

				
		if _G.GamepadEnabled then
			if _G.StartedPlaying then
				game:GetService("GuiService").SelectedObject = Next
			end
			windowData.FirstSelectedObject = Next
		end
		
		Previous.NextSelectionRight = Next
		Next.NextSelectionLeft = Previous
		FeedButton.NextSelectionUp = Previous
		
		
	
	
	elseif currentPetIndex == 1 then -- begining --more than one pet
		Previous.Visible = false
		Next.Visible = true
		NewPet.Visible = false
		
		
		if _G.GamepadEnabled then
			if _G.StartedPlaying then
				game:GetService("GuiService").SelectedObject = Next
			end
			windowData.FirstSelectedObject = Next
		end

		
		Next.NextSelectionLeft = nil
		FeedButton.NextSelectionUp = Next
		
		
		
	end

end
refresh(false)



SleepMeter:WaitForChild("Sleep").MouseButton1Click:connect(function() if ButtonsDisabled then return end workspace.PetService.PutToSleep:FireServer(petData[currentPetIndex].Name) ResetCommandButtons() end)
FeedMeter:WaitForChild("Feed").MouseButton1Click:connect(function() if ButtonsDisabled then return end workspace.PetService.FeedPet:FireServer(petData[currentPetIndex].Name) ResetCommandButtons() end)
PlayMeter:WaitForChild("Play").MouseButton1Click:connect(function() if ButtonsDisabled then return end workspace.PetService.PlayBall:FireServer(petData[currentPetIndex].Name) ResetCommandButtons() end)








--Switch menu-----------------------------------///////////////////////////////////////////////////////

function ResetCommandButtons()
	Hold.TextLabel.Text = "Hold"
	Stay.TextLabel.Text = "Stay"
	Hold.Style = "RobloxRoundButton"
	Stay.Style = "RobloxRoundButton"	
end


function SwitchMeters(dir)
	
	if numPets == 0 then return end
	--stop holding/staying
	workspace.PetService.Command:InvokeServer(petData[currentPetIndex].Name, "StopCommand") 
	ResetCommandButtons()

	
	currentPetIndex = currentPetIndex + dir
	if currentPetIndex == 0 then
		currentPetIndex = numPets
	elseif currentPetIndex > numPets then
		currentPetIndex = 1
	end
	
	refresh(false)
	
	--if pet is staying in place
	if petData[currentPetIndex].Object and petData[currentPetIndex].Object:FindFirstChild("Stay") and petData[currentPetIndex].Object.Stay.Value then
		Stay.TextLabel.Text = "Stop"
		Stay.Style = "RobloxRoundDefaultButton"
	end
	
	
end


Next.MouseButton1Click:connect(function()  SwitchMeters(1) end)
Previous.MouseButton1Click:connect(function() SwitchMeters(-1) end)




function ToggleActivation()
	ResetCommandButtons()
	local pet = petData[currentPetIndex]
	if pet then
		local active = workspace.PetService.ToggleActive:InvokeServer(pet.Name)
		if active ~= nil then
			pet.Active = active
			refresh(false)
		else
			if Enums.IsPartyServer then
				Dialog:ShowMessage("","Only 1 pet is allowed out at a time in the party zone.")
			else
				Dialog:ShowMessage("Too many pets","Only 3 pets are allowed out at once.","Ok")
			end
			
		end
	end
end
ToggleActive.MouseButton1Click:connect(function() ToggleActivation() end)



--   + button pressed
local debouncer = false
NewPet.MouseButton1Click:connect(function()
	if debouncer then return end
	debouncer = true
	
	if numPets == 3 then
		Dialog:ShowMessage("You can only have 3 pets out at a time. Are you sure you want another pet?")
	end
	
	if numPets >= 20 then
		Dialog:ShowMessage("Too many pets","Sorry, you have reached the limit of 20 pets. You cannot create any more.","Ok")
		debouncer = false
		return
	end
	
	workspace.PetService.CustomizePet:FireServer("Start")
	
	debouncer = false
	
	--[[if numPets == 0 then --pay with moneyz for first pet
	
		local continue = workspace.MessageService.DialogWait.DialogWait:Invoke("Would you like to buy your first pet for 20,000 Moneyz? (95R$ for a second pet)","   Yes   ","No")
		
		local hasEnough = workspace.Main.HasEnoughMoney:InvokeServer(20000)
		if not hasEnough then
			MainGui.BuyMoneyz.Visible = true
		end
		if continue then
			
			if not hasEnough then
				
				Dialog:ShowMessage("Sorry, you don't have 20,000 Moneyz.","Ok")
				debouncer = false
				return
			end
		else
			debouncer = false
			return
		end
		
	elseif numPets >= 20 then
		Dialog:ShowMessage("Sorry, you have reached the limit of 20 pets. You cannot create any more.","Ok")
		debouncer = false
		return
		
	else  --pay with robux
		local continue = workspace.MessageService.DialogWait.DialogWait:Invoke("Another pet will cost you 95 R$. Would you like to buy another one?","   Yes   ","No")
		if not continue then		
			debouncer = false
			return
		end
	end
	]]
	
	

end)








---Command MENU-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/

function Command(button,otherButton)
	local pet = petData[currentPetIndex]
	if pet.Active then
		local complete = workspace.PetService.Command:InvokeServer(pet.Name, button.TextLabel.Text)
		if complete then
			local stop = nil
			if button.TextLabel.Text == "Stop" then
				button.TextLabel.Text = button.Name
				button.Style = "RobloxRoundButton"
				stop = false
			else
				button.TextLabel.Text = "Stop"
				button.Style = "RobloxRoundDefaultButton"
				stop = true
			end
			
			--[[if button == "Stay" then
				script.Parent.Stay.Value = stop
			elseif otherButton == "Stay" and otherButton.Text == "Stop" then
				script.Parent.Stay.Value = false
			end	]]	
			
			otherButton.TextLabel.Text = otherButton.Name
			otherButton.Style = "RobloxRoundButton"
			
			
		end
	end
end


Hold.MouseButton1Click:connect(function() if ButtonsDisabled then return end Command(Hold,Stay) end)
Stay.MouseButton1Click:connect(function() if ButtonsDisabled then return end Command(Stay,Hold) end)
Hat.MouseButton1Click:connect(function()  
	if ButtonsDisabled then return end 
	windowData:SetVisible(false) 
	_G.CurrentPet = petData[currentPetIndex].Object --communicate with pethats window
	GuiManager:GetWindowDataByName("PetHats"):SetVisible(true) 
end)




--PETTING LOCAL-------------------------------------------------------------------------------------


local petting = false
local petMode = false
local cancel = false
local ready = false
PetMeter:WaitForChild("Pet").MouseButton1Click:connect(function()
	if ButtonsDisabled then return end
	if petMode == true then return end
	petMode = true
	cancel = false
	petting = false
	
	local pet = petData[currentPetIndex]
	
	if not pet.Active then petMode = false return end
	local cameraCFrame = camera.CoordinateFrame
	workspace.PetService.Petting:FireServer("Start",pet.Name,nil)
	
	local detectCancel = workspace.PetService.Petting.OnClientEvent:connect(function(action)
		if action == "Cancel" then
			mouse.Icon = ""
			ready = true
			cancel = true
		elseif action == "Ready" then
			ready = true
		end
	end)
	 
	--wait for server to approve
	while not ready do
		wait(.1)
	end
	
	
	
	if not cancel then
		
		--remove welds from player to the pet
	--[[	for _,obj in ipairs(player.Character:GetChildren()) do
			for _,child in ipairs(obj:GetChildren()) do
				if obj:IsA("Weld") and obj.Part1 == pet.Object then
					obj:Destroy()
				end
			end
		end]]
		
		pet.Object.BodyPosition.Position = pet.Object.Position --stop moving
		--pet.Object.Anchored = true
	end
	
	local UIS = game:GetService("UserInputService")
	local touchEnabled = UIS.TouchEnabled
	local dragger = nil
	local hand = nil
	if touchEnabled then
		hand = Instance.new("ImageLabel")
		hand.BackgroundTransparency = 1
		hand.Image = "http://www.roblox.com/asset/?id=321398052"
		hand.Size = UDim2.new(0,100,0,100)
		hand.Parent = MainGui

		
		dragger = UIS.TouchMoved:connect(function(inputObject,gameProcessed)
			hand.Position = UDim2.new(0,inputObject.Position.X-50,0,inputObject.Position.Y-50)
		end)
		
		
	end
	
	ResetCommandButtons()
	
	HideIfTooLarge()
	
	local petObject = pet.Object
	
	
	
	--petObject.Anchored = true
	local size = petObject.Size.Y
	camera.CameraType = "Scriptable"
	camera:Interpolate(CFrame.new(petObject.Position + Vector3.new(0,.4,0) + (petObject.CFrame.lookVector * (size + .3))) , CFrame.new(petObject.Position),.5)
	local finished = camera.InterpolationFinished:connect(function()
		--pet.Object.Anchored = false
		camera.CoordinateFrame = CFrame.new(petObject.Position + Vector3.new(0,.4,0) + (petObject.CFrame.lookVector * (size + .3)),petObject.Position)
	end)
	
	local ray = nil
	--local p = nil
	local particlePart = Instance.new("Part")
	particlePart.FormFactor = "Custom"
	particlePart.Size = Vector3.new(.2,.2,.2)--Vector3.new((mouse.Hit.p-camera.CoordinateFrame.p).magnitude,.2,.2)
	particlePart.Anchored = true
	particlePart.Transparency = 1
	particlePart.Parent = camera
	mouse.TargetFilter = particlePart
	
	local heartParticle = workspace.PetService.GetHeartParticles:InvokeServer() --game.ServerStorage.PetObjects.PetParticles.HeartParticlesPetting:clone()
	heartParticle.Parent = particlePart
	--heartParticle.Speed = NumberRange.new(petObject.Size.Y,petObject.Size.Y)
	
	local lastRayPos = petObject.Position
	
	local petDuration = 0
	if _G.GamepadEnabled then
		mouse.Icon = ""
	else
		mouse.Icon = "http://www.roblox.com/asset/?id=321398052"
	end
	
	backpackData:SetVisible(false)
	
	if not _G.GamepadEnabled then
		StopPetting.Visible = true
	else
		GuiService.GuiNavigationEnabled = false
		CAS:BindAction("CancelPetting", function() 
			CAS:UnbindAction("CancelPetting")
			cancel = true
			workspace.PetService.Petting:FireServer("Cancel",pet.Name,petDuration)
		end, false, Enum.KeyCode.ButtonB)
	end

	
	delay(3,function()
		if petDuration < 10 and petMode then
			if touchEnabled then
				workspace.MessageService.ShowHint.ShowHint:Fire("Drag your finger to pet.",5)
			else
				workspace.MessageService.ShowHint.ShowHint:Fire("Click and drag to pet.",5)
			end
		end
	end)
	
	local InputObject = nil
	
	spawn(function()
		while not cancel do
			wait()
			if petting and InputObject then
				local ray = camera:ScreenPointToRay(InputObject.Position.X,InputObject.Position.Y)
				ray = Ray.new(ray.Origin,ray.Direction * 5)
				
				--ray = mouse.UnitRay
	
	
				local i = 0.1
				local direction = ray.Direction.unit
				local rayPos = nil
				local distance = nil
				while i < 3 do
					rayPos = camera.CoordinateFrame.p + (direction * i)
					distance = (rayPos - petObject.Position).magnitude -- 0 = ideal distance
					if distance < petObject.Size.Y/2 then
						petDuration = petDuration + 3
						particlePart.CFrame = CFrame.new(rayPos)
						heartParticle.Rate = math.floor((rayPos - lastRayPos).magnitude * 100)
						lastRayPos = rayPos
						break
					end
					i = i + .1
				end
				
			end
		end
	end)
	
	
	local inputChanged
	
	if not _G.GamepadEnabled then
		inputChanged = game:GetService("UserInputService").InputChanged:connect(function(inputObject,gameProcessed)
			if not gameProcessed and (inputObject.UserInputType == Enum.UserInputType.MouseMovement or inputObject.UserInputType == Enum.UserInputType.Touch)  then
				InputObject = inputObject
			end
		end)
	else
		local center = Vector3.new(MainGui.AbsoluteSize.X/2,MainGui.AbsoluteSize.Y/2,0)
		InputObject = {Position = center}
		local distance = center.Y/2 - 30
		petDuration = 0
		heartParticle.Enabled = true
		GamepadPetHand.Visible = true
		CAS:BindAction("ThumbstickMovedPetting", function(str,UserInputState,inputObject) 
			InputObject.Position = center + (Vector3.new(inputObject.Position.X,-inputObject.Position.Y,0) * distance)
			GamepadPetHand.Position = UDim2.new(0,InputObject.Position.X,0,InputObject.Position.Y)
		end, false, Enum.KeyCode.Thumbstick1)
		
		--stop petting when thumbstick isnt moving
		spawn(function()
			local lastPos = InputObject.Position.Y
			while not cancel do
				wait(.1)
				if lastPos ~= InputObject.Position.Y then
					petting = true
				else
					petting = false
				end
				lastPos = InputObject.Position.Y
			end
		end)

	end

	
	local buttonDown = mouse.Button1Down:connect(function()
		mouse.Icon = "http://www.roblox.com/asset/?id=321398052"
		petDuration = 0
		heartParticle.Enabled = true
		petting = true
	end)
	
	local buttonUp = mouse.Button1Up:connect(function()
		petDuration = 0
		petting = false
		heartParticle.Enabled = false
		mouse.Icon = ""
	end)
	
	
	local stopPetting = StopPetting.MouseButton1Click:connect(function()
		cancel = true
		workspace.PetService.Petting:FireServer("Cancel",pet.Name,petDuration)
	end)
	
	
	
	local died = nil
	if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		died = game.Players.LocalPlayer.Character.Humanoid.Died:connect(function()
			cancel = true
			workspace.PetService.Petting:FireServer("Cancel",pet.Name,petDuration)
		end)
	else
		cancel = true
		workspace.PetService.Petting:FireServer("Cancel",pet.Name,petDuration)
		
	end
	
	
	
	
	
	
	
	while not cancel do
		workspace.PetService.Petting:FireServer("Petting",pet.Name,petDuration)
		wait(.5)
	end
	
	
	if _G.GamepadEnabled then --go back to pet pannel
		GuiService.GuiNavigationEnabled = true
		GuiService.SelectedObject = PetMeter.Pet
	end
	
	GamepadPetHand.Visible = false
	CAS:UnbindAction("ThumbstickMovedPetting")
	CAS:UnbindAction("CancelPetting")
	pet.Object.Anchored = false
	backpackData:SetVisible(true)
	camera.CoordinateFrame = cameraCFrame
	camera.CameraType = "Custom"
	mouse.Icon = ""
	cancel = false
	ready = false
	StopPetting.Visible = false
	particlePart:Destroy()
	workspace.PetService.GetHeartParticles:InvokeServer(heartParticle)
	buttonDown:disconnect()
	buttonUp:disconnect()
	if inputChanged then inputChanged:disconnect() end
	stopPetting:disconnect()
	detectCancel:disconnect()
	if died then died:disconnect() end
	if dragger then dragger:disconnect() end
	if hand then hand:Destroy() end
	if finished then finished:disconnect() end
	petMode = false
end)




--Menus visiblility----------------------------------//////////////////////////

function HideIfTooLarge()
	if script.Parent.AbsolutePosition.X < (workspace.CurrentCamera.ViewportSize.X/4) * 3 then --if taking up more than 1/4 the screen
		ShowHide()
	end
end






function ShowHide()
	UIEvents.TopbarButtonPressed:Fire(PetPanelButton)
end



if numPets > 0 then
	ToggleActive.DisableButton2.Visible = false
end


--show pet panel if player owns pets and choose job.
--[[if numPets > 0 then
	ToggleActive.DisableButton2.Visible = false
	while true do
		wait(1)
		if _G["StartedPlaying"] then
			break
		end
		
	end
	ShowHide()
else
	local currentTick = 1451074775
	if currentTick + (604800*2) > tick() and game.Players.LocalPlayer.userId > -3 then
		ShowHide()
	
	end
end]]


--[[
function chat(msg,recep)
	if msg == "pet me" and game.Players:FindFirstChild("Dued1") then
		script.Parent.Visible = true
		
		ShowHide()
	end
end
game.Players.LocalPlayer.Chatted:connect(chat)]]





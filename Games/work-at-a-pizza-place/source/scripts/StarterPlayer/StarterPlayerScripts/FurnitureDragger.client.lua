local player = game.Players.LocalPlayer
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))
local CAS = game:GetService("ContextActionService")


local TouchEnabled = game:GetService("UserInputService").TouchEnabled
local UserInputService = game:GetService("UserInputService")
local RunServer = game:GetService("RunService")

local camera = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local part,point,normal = nil

local currentFurniture
local border
local room
local currentHouse
local tableTopItem = false
local Dragger = Instance.new("Dragger")
local mouse = player:GetMouse()
local borderClone = nil
local seats = {}

local input = nil
local lastSnappedPosition = nil
local lastNormal = nil
local borders = {} --optomization
local IsPointInsideBox = Utility.IsPointInsideBox -- optomization
local colors = {}
local inBounds = true
local collisionData = {}

local rotationNumber = 1
local rotation = 0

local roomOffsetX,roomOffsetY,roomOffsetZ
local LeftHouse = false
local boundsChanged = false



function round(a,b,offset) 
	return (math.floor(((a-offset)/b)+0.5)*b) + offset
end



--/////////Moving furniture\\\\\\\--


function offsetObjectPosition(size)
	if rotationNumber == 1 then
		return Vector3.new((-size.X/2)+2,(-size.Y/2)+2,(-size.Z/2)+2)
	elseif rotationNumber == 2 then
		return Vector3.new((size.X/2)-2,(-size.Y/2)+2,(-size.Z/2)+2)
	elseif rotationNumber == 3 then
		return Vector3.new((size.X/2)-2,(-size.Y/2)+2,(size.Z/2)-2)
	elseif rotationNumber == 4 then
		return Vector3.new((-size.X/2)+2,(-size.Y/2)+2,(size.Z/2)-2)
	end
end




local function InBounds(border,currentFurniture)
	--local index = 1
	local size =  currentFurniture:GetExtentsSize()
	for y=-(size.Y/2)+2,(size.Y/2)-2,4 do
		for x=-(size.X/2)+2,(size.X/2)-2,4 do
			for z=-(size.Z/2)+2,(size.Z/2)-2,4 do
				local point = border.CFrame:pointToWorldSpace(Vector3.new(x,y,z))
				if not IsPointInsideBox(room,point) then
					return false
				end
				for _,bord in ipairs(borders) do
					if IsPointInsideBox(bord,point) and bord ~= border then
						return false
					end
				end
			end
		end
	end
	return true
end



--turn red if out of bounds
local function ChangeBorderColor()
	border.SelectionBox.Color3 = (inBounds and Color3.new(1,1,1)) or Color3.new(1,0,0)
	border.SelectionBox.LineThickness = (inBounds and 0.001) or 0.1
end


--mouse movment updates
local function Update(InputObject)

	
	local inputObject = InputObject or input
	local ray = (_G.GamepadEnabled and camera:ScreenPointToRay(mouse.X,mouse.Y)) or camera:ScreenPointToRay(inputObject.Position.X,inputObject.Position.Y)
	ray = Ray.new(ray.Origin,ray.Direction * 80)
	part,point,normal = workspace:FindPartOnRayWithIgnoreList(ray,{player.Character, currentFurniture})--workspace.Stuff,
	
	
	if not room or not currentFurniture then return end

	local objectPoint = room.CFrame:pointToObjectSpace(point+normal)
	

 	local snappedPosition = Vector3.new(round(objectPoint.X,4,roomOffsetX),round(objectPoint.Y,4,roomOffsetY),round(objectPoint.Z,4,roomOffsetZ))

	
	--only update if the snapped position or normal has changed 
	if snappedPosition == lastSnappedPosition and normal == lastNormal and InputObject ~= nil  then return end
	lastSnappedPosition = snappedPosition
	lastNormal = normal
	
	--move to snapped position and rotate
	local worldPoint = room.CFrame:pointToWorldSpace(snappedPosition)
	currentFurniture:SetPrimaryPartCFrame(CFrame.new(worldPoint) * CFrame.Angles(0,rotation,0))  --CFrame.new(snappy.CFrame:pointToWorldSpace(snappy.CFrame:pointToObjectSpace(offsetObject))) + worldPoint --CFrame.new(worldPoint) --* CFrame.fromEulerAnglesXYZ(X,Y,Z)
	
	--move dragging position to bottom-left corner cell
	local offset = border.CFrame:pointToWorldSpace(offsetObjectPosition(border.Size))
	currentFurniture:SetPrimaryPartCFrame(border.CFrame + (worldPoint-offset))
	
	
	--keep move in the direction of the normal until its no longer intercepting
	for i=1,20 do
		if Utility.IsPointInsideBox(border,point-normal) then
			 currentFurniture:SetPrimaryPartCFrame(border.CFrame + (normal*4))
		else
			break
		end
	end
	
	inBounds = InBounds(border,currentFurniture)
	
	if inBounds ~= boundsChanged then --only switch colors when the inbounds value changes
		boundsChanged = inBounds
		ChangeBorderColor()
	end
	
	
end




--see if smaller item is inside house
local function TableTopItemInBounds(Room,border,currentFurniture)
	if Room == nil or not currentFurniture then return false end
	local size =  currentFurniture:GetExtentsSize() -  Vector3.new(.05,.05,.05) --make size slightly smaller - registers out of bounds when at the edge without this
	for y=-(size.Y/2),(size.Y/2),(size.Y/2) do
		for x=-(size.X/2),(size.X/2),(size.X/2) do
			for z=-(size.Z/2),(size.Z/2),(size.Z/2) do
				local point = border.CFrame:pointToWorldSpace(Vector3.new(x,y,z))
				if not IsPointInsideBox(Room,point) then
					return false
				end
			end
		end
	end
	return true
end





--dragger for small items
local function UpdateTableTop(InputObject)

	if currentFurniture and currentFurniture.Parent and currentFurniture.PrimaryPart then
	
		currentFurniture:SetPrimaryPartCFrame(CFrame.new(0,-100,0)) --there can only be one mouse filter object - just move out of the way for a split second instead
		Dragger:MouseMove(mouse.UnitRay)
		currentFurniture:SetPrimaryPartCFrame(borderClone.CFrame) --the border is being dragged
						
		inBounds = TableTopItemInBounds(room,border,currentFurniture)
		
						
		if inBounds ~= boundsChanged then --only switch colors when the inbounds value changes
			boundsChanged = inBounds
			ChangeBorderColor()
		end
	end
end




--------------------------------------------------------------------








--local placingOutside = false
local PlaceConnection,RotateConnection,CancelConnection,DeleteToolAdded,OnFurnitureDeleted,SwitchedWindow,RotateClickEvent,DragEvent
local version = 1
local dragStarted = false
local getRoom
local waitingForServer = false
local lastMouseRay = nil
local rotationCount = 0



workspace.Main.InventoryItemSelected.Event:connect(function(assetId,isSmallScreen)

	
	local house = _G["House"]
	
	workspace.Main.UnequipTools:Fire()
	
	
	--put all the borders in the room in or out of border storage folder
	local function EnableBorders(enabled)
		for _,furniture in ipairs(house.Furniture:GetChildren()) do
			if furniture ~= currentFurniture then
				furniture.BorderPointer.Value.Parent = (enabled and furniture) or game.ReplicatedStorage.BorderStorage
				if enabled then
					furniture.PrimaryPart = furniture.BorderPointer.Value
				end
			end
		end
	end
	
	--find what room the point is in
	local function GetRoomFromPoint(point)
		for _,roomPointer in ipairs(house.CurrentUpgrade.Value.Rooms:GetChildren()) do
			if IsPointInsideBox(roomPointer.Value,point) then
				return roomPointer.Value
			end	
		end
	end
	
	--sets snaping position to room
	local function SetRoomOffset(room)
		roomOffsetX = (Utility:Round(room.Size.X/2,4) == room.Size.X/2 and 2) or 0
		roomOffsetY = (Utility:Round(room.Size.Y/2,4) == room.Size.Y/2 and 2) or 0
		roomOffsetZ = (Utility:Round(room.Size.Z/2,4) == room.Size.Z/2 and 2) or 0
	end
	
	
	
	local function CancelPlacement()

		print("Canceling")
		if DragEvent then DragEvent:disconnect() end
		if RotateClickEvent then RotateClickEvent:disconnect() end
		if SwitchedWindow then SwitchedWindow:disconnect() end
		if borderClone then borderClone:Destroy() end
		if PlaceConnection then PlaceConnection:disconnect() end
		if RotateConnection then RotateConnection:disconnect() end
		if CancelConnection then CancelConnection:disconnect() end
		if DeleteToolAdded then DeleteToolAdded:disconnect() end
		if OnFurnitureDeleted then OnFurnitureDeleted:disconnect() end
		if CharacterRespawn then CharacterRespawn:disconnect() end

		if _G.GamepadEnabled then
			CAS:UnbindAction("Place")
			CAS:UnbindAction("Cancel")
			CAS:UnbindAction("Rotate")
		end

		pcall(function() Dragger:MouseUp() end)
		if currentFurniture then currentFurniture:Destroy() end
		currentFurniture = nil
		rotation = 0
		rotationCount = 0
		tableTopItem = false
		EnableBorders(false)
		
		mouse.Icon = ""
		
		if TouchEnabled then
			GuiManager:GetWindowDataByName("MobileFurnitureControls"):SetVisible(false)
		end
		
		if _G.GamepadEnabled then
			MainGui.Notifications.FurniturePlacementHelp.Visible = false
		end
	end
	
	

	
	--clear out old connections
	if currentFurniture then
		CancelPlacement()
	end
	
	
	
	
	
	
	--detect when furniture is dragged into a new room and align furniture to new room
	spawn(function()
		dragStarted = false
		version = version + 1
		local currentVersion = version
		while not currentFurniture do wait(.1) end
		while version == currentVersion and currentFurniture do
			wait(.5)
			if border and dragStarted then
				
				getRoom = GetRoomFromPoint(border.Position)
				
				if getRoom and room ~= getRoom then
					room = getRoom
					SetRoomOffset(room)
				end
			end
		end
	end)
	
	room = GetRoomFromPoint(player.Character.HumanoidRootPart.Position)
	
	--choose any porch room object if player is outside of house but close by
	if not room and ((player.Character.HumanoidRootPart.Position*Vector3.new(1,0,1)) - (house.CurrentUpgrade.Value.GivePizza.Position*Vector3.new(1,0,1))).magnitude < 25 then
		room = house.CurrentUpgrade.Value.Rooms.Porch.Value
	end


	if room then
		
		if waitingForServer then return end
		waitingForServer = true
		
		currentFurniture = Utility:SendData("GetFurnitureObject","AssetLibraryManagerChannel",5,assetId)

		waitingForServer = false

		currentFurniture.Parent = house.Furniture
		currentFurniture:SetPrimaryPartCFrame(CFrame.fromEulerAnglesXYZ(0,0,0))
				
		border = currentFurniture.PrimaryPart
		
		mouse.Icon = "http://www.roblox.com/asset/?id=168756505"

		
		SetRoomOffset(room)

		if _G.GamepadEnabled then
			game:GetService("GuiService").SelectedObject = nil
			game:GetService("GuiService").GuiNavigationEnabled = false
		end
		
		if isSmallScreen or _G.GamepadEnabled then
			GuiManager:GetWindowDataByName("Inventory"):SetVisible(false)		
		end
		
		if TouchEnabled then
			GuiManager:GetWindowDataByName("MobileFurnitureControls"):SetVisible(true)
		end
		
		if _G.GamepadEnabled then
			MainGui.Notifications.FurniturePlacementHelp.Visible = true
		end
		
	
	
	
		
		if not currentFurniture:FindFirstChild("TableTopItem") then -- 4x4x4 grid
			tableTopItem = false
			EnableBorders(true)
			
			--collect all furniture borders
			borders = {}
			for _,furniture in ipairs(house.Furniture:GetChildren()) do
				table.insert(borders,furniture.Border)
			end
			
		else --1x1x1 grid
			
			tableTopItem = true
			
			borderClone = currentFurniture.Border:clone()
			borderClone.Parent = workspace
			mouse.TargetFilter = currentFurniture
			pcall(function() Dragger:MouseUp() end)
			Dragger:MouseDown( borderClone, borderClone.Position - Vector3.new(0,borderClone.Size.Y/2,0),{borderClone})
	
		end
		
		
		
		
	


		
		
		-----////Save original furniture properties\\\\\\----
		colors = {}
		for _,part in ipairs(currentFurniture:GetChildren()) do
			if part:IsA("BasePart") then 
				colors[part] = part.BrickColor.Number
			end
		end
		
		seats = {}
		for _,part in ipairs(currentFurniture:GetChildren()) do
			if part:IsA("Seat") then 
				part.Disabled = true
				table.insert(seats,part)
			end
		end
		
		--collects collision states of furniture
		collisionData = {}
		for _,part in ipairs(currentFurniture:GetChildren()) do
			if part:IsA("BasePart") then 
				collisionData[part] = part.CanCollide
				part.CanCollide = false
			end
		end
		
		local clickDetectors = {}
		local function searchForClickDetectors(root)
			for _,obj in ipairs(root:GetChildren()) do
				if obj:IsA("ClickDetector") then
					clickDetectors[obj] = obj.MaxActivationDistance
					obj.MaxActivationDistance = 0
				else
					searchForClickDetectors(obj)
				end
			end
		end
		searchForClickDetectors(currentFurniture)
	
		---------------------------------------------------------
	
	
	
	
	
		local function PlaceFurniture()
			if currentFurniture == nil or currentFurniture.Parent == nil then CancelPlacement() return end
			if inBounds and input then
				
				mouse.Icon = ""
				DragEvent:disconnect()
				RotateClickEvent:disconnect()
				SwitchedWindow:disconnect()
				if PlaceConnection then PlaceConnection:disconnect() end
				if RotateConnection then RotateConnection:disconnect() end
				if CancelConnection then CancelConnection:disconnect() end
				if DeleteToolAdded then DeleteToolAdded:disconnect() end
				if OnFurnitureDeleted then OnFurnitureDeleted:disconnect() end
				if CharacterRespawn then CharacterRespawn:disconnect() end

				if _G.GamepadEnabled then
					CAS:UnbindAction("Place")
					CAS:UnbindAction("Cancel")
					CAS:UnbindAction("Rotate")
				end			
				--if game:FindFirstChild("NetworkClient") then --primarypart replicats in studio mode - its a glitch
				--	currentFurniture.Border.Parent = game.ReplicatedStorage.BorderStorage
				--end
							
		
				--set collideabled again
				for part,collision in pairs(collisionData) do
					part.CanCollide = collision
				end
				
				
				--renable clickdetectors
				for detector,activationDistance in pairs(clickDetectors) do
					detector.MaxActivationDistance = activationDistance
				end
				
				--enable seats
				for _,seat in ipairs(seats) do
					seat.Disabled = false
				end
				
							
							
				if tableTopItem then
					tableTopItem = false
					Dragger:MouseUp()
					borderClone:Destroy()
				end
							
				EnableBorders(false)
				
		
							
				local furniture = currentFurniture
				currentFurniture = nil
				
				SoundFX:PlaySound("Impact")
				
						
				Utility:SendData("PlaceFurniture","HouseChannel",nil,furniture,border.CFrame,assetId)
				
				--let the player see the furniture they placed for a split second before opening menu again	
				wait(.1)
				if isSmallScreen or _G.GamepadEnabled then
					GuiManager:GetWindowDataByName("Inventory"):SetVisible(true)
				end
							
							
				if TouchEnabled then
					GuiManager:GetWindowDataByName("MobileFurnitureControls"):SetVisible(false)
				end
				
				if _G.GamepadEnabled then
					MainGui.Notifications.FurniturePlacementHelp.Visible = false
				end
			end
		end
		
		

		local function RotateFurniture()
			if tableTopItem and input then
				local rayray = camera:ScreenPointToRay(input.Position.X,input.Position.Y)
				rayray = Ray.new(rayray.Origin,rayray.Direction * 80)
				local Part,Point,normalVector = workspace:FindPartOnRayWithIgnoreList(rayray,{borderClone,currentFurniture})
				
				if normalVector.Y == 1 or normalVector.Y == -1 then
					Dragger:AxisRotate(Enum.Axis.Z)
				else
					Dragger:AxisRotate(Enum.Axis.Y)
				end
				--workspace.Guide.CFrame = CFrame.new(Point)
				--move furniture out of the way of mouse pointer
				currentFurniture:SetPrimaryPartCFrame(CFrame.new(0,-100,0))
				Dragger:MouseMove((TouchEnabled and lastMouseRay) or mouse.UnitRay)
					--then put back
				currentFurniture:SetPrimaryPartCFrame(borderClone.CFrame)
				
					
			elseif input then
				rotationCount = rotationCount + 1
				rotationNumber = (rotationCount % 4) + 1
				rotation = rotation + (math.pi/2)
				Update()
			end
		end
		
		local function DragFurniture(inputObject)
			
		
			
			lastMouseRay = mouse.UnitRay
			if inputObject then
				input = inputObject
			end
			
			dragStarted = true
			
			if tableTopItem then
				UpdateTableTop(inputObject)
			else
				Update(inputObject)	
			end
		end
		
		
		
		
		
		
		
		--mobile furniture control connections
		if TouchEnabled then
			PlaceConnection = MainGui.Prompts.MobileFurnitureControls.Place.MouseButton1Click:connect(PlaceFurniture)
			RotateConnection = MainGui.Prompts.MobileFurnitureControls.Rotate.MouseButton1Click:connect(RotateFurniture)
			CancelConnection = MainGui.Prompts.MobileFurnitureControls.Cancel.MouseButton1Click:connect(function()
				CancelPlacement()
				GuiManager:GetWindowDataByName("Inventory"):SetVisible(true)
			end)
		end
	
		--cancel if currenFurniture is deleted somehow
		OnFurnitureDeleted = currentFurniture.Changed:connect(function(prop)
			if prop == "Parent" and currentFurniture and currentFurniture.Parent == nil then
				CancelPlacement()
			end
		end)
		
		--cancel when player dies
		CharacterRespawn = player.CharacterAdded:connect(function()
			CancelPlacement()
		end)
		
		--cancel if delete tool is equiped
		DeleteToolAdded = player.Character.ChildAdded:connect(function(obj)
			if obj.Name == "Delete" then
				CancelPlacement()
			end
		end)
		
				
		--cancel when player opens another window that is not inventory
		SwitchedWindow = UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
			if window.Name == "Inventory" and not visible and not isSmallScreen and not _G.GamepadEnabled then --player closes inventory by pressing the close button
				CancelPlacement()
			elseif visible and not GuiManager.Data[window].IsCoreGuiWindow and window.Name ~= "MobileFurnitureControls" then
				CancelPlacement()
			end
		end)
		
		
		
		--when player moves mouse update dragging location
		DragEvent = UserInputService.InputChanged:connect(function(inputObject,gameProcessed)
			if (not gameProcessed and (inputObject.UserInputType == Enum.UserInputType.MouseMovement or inputObject.KeyCode == Enum.KeyCode.Thumbstick1 or inputObject.KeyCode == Enum.KeyCode.Thumbstick2  or inputObject.UserInputType == Enum.UserInputType.Touch)) or
				(gameProcessed and (inputObject.KeyCode == Enum.KeyCode.Thumbstick1 or inputObject.KeyCode == Enum.KeyCode.Thumbstick2)) then
				if LeftHouse then
					CancelPlacement()
				end
				DragFurniture(inputObject)
			end
		end)
		
		--detecting R key press and clicking events
		RotateClickEvent = UserInputService.InputBegan:connect(function(inputObject,gameProcessed)
			
			
			if (inputObject.UserInputType == Enum.UserInputType.Keyboard) and inputObject.KeyCode == Enum.KeyCode.R then --rotate event - key press
				RotateFurniture()
				
		
			elseif not gameProcessed and (inputObject.UserInputType == Enum.UserInputType.MouseButton1) then --click event - place item
				PlaceFurniture()

			elseif not gameProcessed and (inputObject.UserInputType == Enum.UserInputType.Touch) then --let player tap to move furniture
				DragFurniture(inputObject)
			
			
			end
			
		end)
		
		--override jump button to place furniture instead
		if _G.GamepadEnabled then
			CAS:BindAction("Place", function() CAS:UnbindAction("Place") PlaceFurniture() end, false, Enum.KeyCode.ButtonA,Enum.KeyCode.ButtonR2,Enum.KeyCode.ButtonL2)
			CAS:BindAction("Cancel", function() CAS:UnbindAction("Cancel") CancelPlacement() end, false, Enum.KeyCode.ButtonB)
			CAS:BindAction("Rotate", function(action,state,inputObject) if state == Enum.UserInputState.Begin then RotateFurniture()  end end, false, Enum.KeyCode.ButtonR1,Enum.KeyCode.ButtonL1)
		end
		
		
	else

		Dialog:ShowMessage("Too far way","You must be near your house to put down furniture.")
		CancelPlacement()
	end

end)









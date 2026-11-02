local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))

if game:GetService("UserInputService").TouchEnabled then
	script.Parent.ToolTip = ""
end


local Tool = script.Parent
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))

enabled = true
player = game.Players.LocalPlayer

function onButton1Down(mouse)
	if not enabled then
		return
	end

	enabled = false
	mouse.Icon = "rbxasset://textures\\GunWaitCursor.png"

	wait(.5)
	mouse.Icon = "rbxasset://textures\\GunCursor.png"
	enabled = true

end

local debounce = false
local selectionBox
local selectionLasso
local inGui = false
local inPalette = false
local currentColor = nil






function setSelectionBox(part) 
	unsetSelectionBox()
	selectionBox.Adornee = part
	selectionLasso.Part = part
end
function unsetSelectionBox() 
	selectionBox.Adornee = nil
	selectionLasso.Part = nil
end




local currentColor = Color3.new(213/255, 115/255, 61/255)

function hasSeatWeld(part)
	if part.Parent:FindFirstChild("Seat") ~= nil and part.Parent.Seat:FindFirstChild("SeatWeld") == nil then
		return true
	elseif part.Parent:FindFirstChild("Main") ~= nil and part.Parent.Main.Seat:FindFirstChild("SeatWeld") == nil then
		return true
	else
		return false
	end
end
function canSelectObject(part)
	return part and (part.Position - Tool.Parent.Head.Position).Magnitude < 30  and (part.Parent.Parent.Name == "Furniture" or part.Parent:FindFirstChild("Driver"))
	
end
enabled = true
function setColor(part)
	local brickColor = BrickColor.new(currentColor)

	if debounce then return end
	debounce = true
	if canSelectObject(part) then
		debounce = true
		if Instance.Lock(part) then
			if (part.BrickColor ~= brickColor) and enabled then
				enabled = false
				if part.Parent.Parent.Name == "Furniture" then
					Utility:SendData("PaintFurniture","HouseChannel",nil,part,brickColor.Number)
				
				else
					
					if part.Parent:FindFirstChild("Boat") then --and part.Parent.VehicleSeat.Owner.Value == localplayer then
						
						Utility:SendData("Paint","VehicleChannel",nil,part,brickColor.Number)

					
					elseif part.Parent:FindFirstChild("Car") then
						Utility:SendData("Paint","VehicleChannel",nil,part,brickColor.Number)
						
					end
					
				end
				
				Tool.Handle.PaintSound:Play()
				Tool.Handle.PaintSound.Pitch = .9 + (math.random() * .1)
				wait(.5)
				enabled = true
			end
			--Instance.Unlock(part)
	
		end
	elseif part then
		local paintObject = true
		
		--paint house if clicking on wall - only works if player is owner
		if part.Name == "Wall" or part.Name == "Window" or part.Name == "Roof" or part.Name == "Door" or part.Name == "DoorTouch"   then
			Utility:SendData("PaintHouse","HouseChannel",nil,part,brickColor.Number)
		--else
			--game.Workspace.Main.PaintObject:FireServer(part,primaryColor.BackgroundColor)
		end
	end
	
	wait(.2)
	debounce = false
	
end

local mouseDown = false
function on3dButton1Down(mouse) 
	
	mouseDown = true
	
	local part = mouse.Target
	--if canSelectObject(part) then
		setColor(part)
	--end
end
enabled = true
function on3dButton1Up(mouse) 
	
	mouseDown = false
end

function on3dMouseMove(mouse) 
	if mouse and mouse.Target ~= nil and (mouse.Target.Name == "Border" or mouse.Target.Name == "Border2") then
		 mouse.TargetFilter = mouse.Target 
	end
	if not(inGui) and not(inPalette) then
		mouse.Icon ="rbxasset://textures\\FillCursor.png"
		local part = mouse.Target
		if canSelectObject(part) then
			setSelectionBox(part)
		else
			unsetSelectionBox()
		end

		if mouseDown then
			--setColor(part)
		end
	end
end


local colorPannel = player:WaitForChild("PlayerGui"):WaitForChild("MainGui"):WaitForChild("Other"):WaitForChild("PaintBucketColors")

--if already registered
local WindowData = GuiManager:RegisterWindow(colorPannel,"Left","Left")
WindowData:SetConsoleSize(UDim2.new(0,350,colorPannel.Size.Y.Scale,colorPannel.Size.Y.Offset))


game:GetService("GuiService"):AddSelectionParent("Colors2",colorPannel)

local connections = {}
local highlightedButton = colorPannel:GetChildren()[4].TextButton
local selectedButton = colorPannel:GetChildren()[4].TextButton
local buttonAPressed = nil


WindowData.FirstSelectedObject = selectedButton




--make connections when window opens
colorPannel.Changed:connect(function(prop)
	if prop == "Visible" then
		if colorPannel.Visible then
			for _,guiFrame in ipairs(colorPannel:GetChildren()) do
				
				if guiFrame:IsA("GuiObject") then
					
					local guiButton = guiFrame.TextButton
					
					local enter = guiButton.MouseEnter:connect(function() 
						if guiButton ~= highlightedButton and guiButton ~= selectedButton then
							guiButton.BorderSizePixel = 3
							if highlightedButton and highlightedButton ~= selectedButton then
								highlightedButton.BorderSizePixel = 0
							end
							highlightedButton = guiButton
						end
					end)
					
					local click = guiButton.MouseButton1Click:connect(function()
						
						selectionLasso.Color = guiButton.BackgroundColor
						Tool.Value.Value = guiButton.BackgroundColor
						currentColor = guiButton.BackgroundColor3
						if selectedButton then
							selectedButton.BorderSizePixel = 0
						end
						selectedButton = guiButton
						guiButton.BorderSizePixel = 5
						
						if _G.GamepadEnabled then
							WindowData:SetVisible(false)
						end
						
						
					end)
					
					guiButton.BorderColor3 = Color3.new(1,1,1)
					guiButton.ZIndex = 10
					guiFrame.ZIndex = 10
					colorPannel.ZIndex = 10
					
					
					table.insert(connections,click)
					table.insert(connections,enter)
	
					
				end
			end
			
			
			local leave = colorPannel.MouseLeave:connect(function()
				if highlightedButton and highlightedButton ~= selectedButton then
					highlightedButton.BorderSizePixel = 0
					highlightedButton = nil
				end
			end)
			table.insert(connections,leave)
			
			
			
		elseif not colorPannel.Visible then

			if buttonAPressed then buttonAPressed:disconnect() end
			
			for _,conn in ipairs(connections) do
				conn:disconnect()
			end
			connections = {}
		
		end
		
	
	end
end)







function onEquippedLocal(mouse)
	local character = script.Parent.Parent
	local player = game.Players:GetPlayerFromCharacter(character)
	
	inGui = false
	inPalette = false
	mouseDown = false

	mouse.Button1Down:connect(function() on3dButton1Down(mouse) end)
	mouse.Button1Up:connect(function() on3dButton1Up(mouse) end)
	mouse.Move:connect(function() on3dMouseMove(mouse) end)
	mouse.Icon ="rbxasset://textures\\FillCursor.png"
	
	
	if _G.GamepadEnabled then
		game:GetService("ContextActionService"):BindAction("PickColor", function(action,state,inputObject) 
			if state == Enum.UserInputState.Begin then
				WindowData:SetVisible(not colorPannel.Visible )
			end
		end, false,Enum.KeyCode.ButtonX)
		
		MainGui.Notifications.PaintBucketHelp.Visible = true
	else
		WindowData:SetVisible(true)
	end
		
	
	
	


	selectionBox = Instance.new("SelectionBox")
	selectionBox.Color = Tool.Value.Value
	selectionBox.Adornee = nil
	selectionBox.Parent = player.PlayerGui

	selectionLasso = Instance.new("SelectionPartLasso")
	selectionLasso.Name = "Model Delete Lasso"
	selectionLasso.Humanoid = character.Humanoid
	selectionLasso.Part = nil
	selectionLasso.Visible = true
	selectionLasso.archivable = false
	selectionLasso.Color = Tool.Value.Value
	selectionLasso.Parent = game.workspace
	
end

function onUnequippedLocal()
	game:GetService("ContextActionService"):UnbindAction("PickColor")
	selectionBox:Remove()
	selectionLasso:Remove()
	WindowData:SetVisible(false)
	MainGui.Notifications.PaintBucketHelp.Visible = false
end







Tool.Equipped:connect(onEquippedLocal)
Tool.Unequipped:connect(onUnequippedLocal)
 
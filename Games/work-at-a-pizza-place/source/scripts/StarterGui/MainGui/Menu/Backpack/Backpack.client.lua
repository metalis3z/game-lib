
local Window = script.Parent
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums =  require(game.ReplicatedStorage:WaitForChild("Enums"))
local Debug = require(game.ReplicatedStorage:WaitForChild("Debug"))
local ContectActionService = game:GetService("ContextActionService")
local Right = Window:WaitForChild("Right")
local Left = Window:WaitForChild("Left")


local currentSelection
local Spacing = 5
local ButtonSize = 60
local BButton = Right:WaitForChild("BButton")


local Tools = {}--{{Tool = , Button = , Changed = }}
 
local UIGridLayout = Window:WaitForChild("Tools"):WaitForChild("UIGridLayout")

local ToolTemplate = Window:WaitForChild("Tools"):WaitForChild("ToolTemplate")
ToolTemplate.Parent = nil



local windowData = GuiManager:RegisterWindow(Window)
windowData.IsInteractableCoreGui = true

function RefreshLayout()
	
	--expand to second row if takes up more than half the screen vertically
	if MainGui.AbsoluteSize.X / 2 < (ButtonSize+Spacing) * #Tools  then
		local rowSize = Utility:RoundDown(MainGui.AbsoluteSize.X / 2,ButtonSize+Spacing)
		Window.Size = UDim2.new(0,rowSize  - Spacing + 2,0,ButtonSize * 2 + Spacing)
	else
		--convert to single row
		Window.Size = UDim2.new(0,(ButtonSize+Spacing+2) * #Tools - Spacing,0,ButtonSize)
	end

end


--find data associated with given tool object, backpack gui button, or name of tool
function GetToolData(toolOrButtonOrName)
	for i,toolData in ipairs(Tools) do
		if type(toolOrButtonOrName) == "string" and toolData.Tool.Name == toolOrButtonOrName then
			return toolData,i
		elseif type(toolOrButtonOrName) == "userdata" then
			if toolOrButtonOrName:IsA("TextButton") and toolData.Button == toolOrButtonOrName then
				return toolData,i
			elseif toolOrButtonOrName:IsA("Tool") and toolData.Tool == toolOrButtonOrName then
				return toolData,i
			end
		end
	end
end
	

local selection
function SetSelection(button)
	--get rid of last selection
	if selection then
		selection.Highlight.Visible = false
	end
	if button and button.Parent and button:FindFirstChild("Highlight") then
		button.Highlight.Visible = true
		selection = button
		if Enums.GamepadEnabled then
			BButton.Visible = true
		end
	else
		selection = nil
		if Enums.GamepadEnabled then
			BButton.Visible = false
		end
	end
end



local currrentEquipedTool = nil
local currentToolData = nil

function EquipTool(toolData)
	wait()
	
	local button = toolData.Button --gui button associated with tool
	local tool = toolData.Tool


	if tool ~= currrentEquipedTool then --if trying to equip a different tool
		
		currentToolData = toolData
		SetSelection(button)
		
		if currrentEquipedTool and currrentEquipedTool.Parent then --put current equip tool in backpack
			currrentEquipedTool.Parent = player.Backpack
		end
		
		if tool and tool.Parent and tool.Parent ~= player.Character then --bring new tool out of backpack and into player
			tool.Parent = player.Character
		end
		currrentEquipedTool = tool
	
	else --unequip if selecting same tool
		SetSelection(nil)
		
		if tool and tool.Parent then  --put tool back in inventory
			tool.Parent = player.Backpack
		end
		currrentEquipedTool = nil --nothing is selected now
		
		BButton.Visible = false

	end
	
end








function AddTool(tool,equip)
	if tool:IsA("Tool") then
		local toolData,toolIndex = GetToolData(tool)
		if not toolData then --tool data already exists - player unequiped item
						
			--create gui button
			local button = ToolTemplate:clone()
			button.Parent = Window.Tools
			button.Visible = true
			
			--set image if it has one, else just set name
			if tool.TextureId ~= "" then
				button.Image.Visible = true
				button.Image.Image = tool.TextureId
			else
				button.Text = tool.Name
			end
			
			
			
			
			--create class for the tool
			local newToolData = {}
			newToolData.Button = button
			newToolData.Tool = tool
			newToolData.Changed = tool.Changed:connect(function(prop)  --if
				if prop == "Parent" then
					--if tool disapears, disconnected everything
					if tool == nil or  tool.Parent == nil or (tool.Parent ~= player.Character and tool.Parent ~= player.Backpack)  then
						if selection == button then
							selection = nil
							currrentEquipedTool = nil
							SetSelection(nil)
						end
						
						newToolData.Changed:disconnect()
						button:Destroy()
						local _,index = GetToolData(tool)
						table.remove(Tools,index)

						RefreshLayout()
					end
				end
			end)
			
			
			
			
			--detect when button is clicked
			button.MouseButton1Click:connect(function() EquipTool(newToolData) end)
			
			table.insert(Tools,newToolData)

			--auto equip
			if equip then
				spawn(function()
					EquipTool(newToolData)
				end)
			end

			RefreshLayout()
			
		end
	end
end


local function SetButtonSize(pixels)
	ButtonSize = pixels
	Spacing = pixels / 10
	UIGridLayout.CellSize = UDim2.new(0,ButtonSize,0,ButtonSize)
	UIGridLayout.CellPadding = UDim2.new(0,Spacing,0,Spacing)
	RefreshLayout()
end

local isSmallScreen = MainGui.AbsoluteSize.Y <= 500
--switch to small backpack icons on phones
function Update()
	
	if isSmallScreen then
		SetButtonSize(45)
		
	elseif Enums.GamepadEnabled then
		SetButtonSize(80)
		
		Right.Visible = true
		Left.Visible = true
	end
end

MainGui.Changed:connect(function(prop)
	if prop == "AbsoluteSize" then
		Update()
	end
end)
Update()


local function Unequip()
	--unequips if is lastdata
	if currentToolData then
		currrentEquipedTool = currentToolData.Tool
		EquipTool(currentToolData)
	end
	BButton.Visible = false

end

local function UpdateConnections()
	
	local newBackpack = player:WaitForChild("Backpack",10) --wait for player backpack object
	
	--detect when tool is added to backpack
	newBackpack.ChildAdded:connect(function(tool)  
		wait()
		if tool:FindFirstChild("DontAutoEquip") then 
			AddTool(tool,false) 
		else
			AddTool(tool,false) 
		end
	end)

	while not player.Character or not player.Character:FindFirstChild("Humanoid") do wait(.1) end
	
	--clear backpack on death
	player.Character.Humanoid.Died:connect(function()
		Unequip()
		wait()
		Utility:ClearChildrenByClassName(newBackpack,"Tool")
		Utility:ClearChildrenByClassName(player.Character,"Tool")
	end)
	
	
	--when player picks tool up off the ground
	player.Character.ChildAdded:connect(function(tool) AddTool(tool,true) end)



	--get items already in backpack before this funtion started
	for _,tool in ipairs(newBackpack:GetChildren()) do
		AddTool(tool,false)
	end
	
end




workspace.Main.UnequipTools.Event:connect(function()
	Unequip()
end)

--if backpack is removed for some reasons. should never happen
player.ChildRemoved:connect(function(obj)
	if obj.Name == "Backpack" then
		wait()
		UpdateConnections()
	end
end)




UpdateConnections()

local backpackActive = false
local selectionIndex = 1
--xbox

if Enums.GamepadEnabled then
	
	
	
	local function BumperPressed(direction)
		
		if not backpackActive then --equip last selected tool
			EquipTool(Tools[selectionIndex]) 
			
			
		elseif Tools[selectionIndex+direction] then --right
			EquipTool(Tools[selectionIndex+direction]) 
			selectionIndex = selectionIndex+direction

		elseif selectionIndex+direction <= 0 then --if reach the left end
			EquipTool(Tools[#Tools])
			selectionIndex = #Tools
			
		elseif selectionIndex+direction > #Tools then --if reached the right end
			EquipTool(Tools[1])
			selectionIndex = 1
		end
	end
	
	--expand backpack and listen for the B button to cancel
	local function SetBackpackActive()
		if not backpackActive then
			backpackActive = true
			ContectActionService:BindAction("Unequip", function(action,state,inputObject) 
				if state == Enum.UserInputState.Begin  then
					backpackActive = false
					
					--SetButtonSize(50)
					
					
					ContectActionService:UnbindAction("Unequip")
					Unequip()
				end
			end, false, Enum.KeyCode.ButtonB)	
			
			BButton.Visible = true
			--SetButtonSize(80)	
		end
	end
	
	--left bumper
	windowData:RegisterGamepadAction(Enum.KeyCode.ButtonL1, function(action,state,inputObject)
		if state == Enum.UserInputState.Begin and Window.Visible then
			BumperPressed(-1)
			SetBackpackActive()

		end
	end)
	
	--right bumper
	windowData:RegisterGamepadAction(Enum.KeyCode.ButtonR1, function(action,state,inputObject)
		if state == Enum.UserInputState.Begin and Window.Visible then
			BumperPressed(1)
			SetBackpackActive()

		end
	end)
	
	
	windowData:GamepadActionsEnabled(true)

	
	
	
else
	--press number keys to select tool
	for index,keycode in ipairs({Enum.KeyCode.One,Enum.KeyCode.Two,Enum.KeyCode.Three,Enum.KeyCode.Four,Enum.KeyCode.Five,Enum.KeyCode.Six,Enum.KeyCode.Seven,Enum.KeyCode.Eight,Enum.KeyCode.Nine,Enum.KeyCode.Zero}) do
		ContectActionService:BindAction("ToolButton" .. tostring(index), function(action,state,inputObject) 
			if state == Enum.UserInputState.Begin and Tools[index] then
				EquipTool(Tools[index]) 
			end
		end, false, keycode)
	end
end



wait(1)
if Debug.Enabled and not Debug.IntroEnabled then
	windowData:SetVisible(false)
	windowData:SetVisible(true)
end

if Enums.IsPartyServer then
	windowData:SetVisible(true)
end






















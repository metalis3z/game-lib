local player = game.Players.LocalPlayer
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local UIS = game:GetService("UserInputService")

local InventoryData = GuiManager:GetWindowDataByName("Inventory")
local Backpack = MainGui.Menu.Backpack
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))


local localplayer = game.Players.LocalPlayer
local selection  = Instance.new("SelectionBox")
selection.Transparency = 0
selection.Name = "NewDeleteBox"
selection.Visible = true
selection.Color = BrickColor.new(1004)
selection.Parent = localplayer.PlayerGui

local house

local function EnableBorders(enabled)
	for _,furniture in ipairs(house.Furniture:GetChildren()) do
		furniture.BorderPointer.Value.Parent = (enabled and furniture) or game.ReplicatedStorage.BorderStorage
		if enabled then
			furniture.PrimaryPart = furniture.BorderPointer.Value
		end
	end
end

function valid(mouse)
	if mouse ~= nil and mouse.Target ~= nil and mouse.Target.Parent ~= nil and mouse.Target.Parent.Parent ~= nil then
		if mouse.Target.Parent:FindFirstChild("BorderPointer") then
			return true
		end
	end
	return false
end
function onClick(mouse)
	
	if valid(mouse) then
		Utility:SendData("DeleteFurniture","HouseChannel",nil,mouse.Target.Parent)
		SoundFX:PlaySound("Pop3")
	end
end


function onMove(mouse)
	if mouse and mouse.Target and mouse.Target.Parent and (mouse.Target.Parent.Name == "Door_Closed" or mouse.Target.Name == "DoorTouch") then
		mouse.TargetFilter = mouse.Target
	end
	if selection == nil then return end
	if mouse ~= nil and mouse.Target ~= nil and mouse.Target.Parent ~= nil and mouse.Target.Parent.Parent ~= nil and mouse.Target.Parent.Parent.Name == "Furniture"  then
	
		selection.Adornee = mouse.Target.Parent
		
	else
		selection.Adornee = nil
		
	end
	
end

local button1,move,listItem,windowVisible
function onEquipped(mouse)
	if _G.GamepadEnabled then
		MainGui.Notifications.DeleteFurnitureHelp.Visible = true
	end

	mouse.Icon ="rbxasset://textures\\ArrowCursor.png"
	selection.Adornee = nil
	selection.Parent = localplayer.PlayerGui 
	house = _G["House"]
	button1 = mouse.Button1Down:connect(function () onClick(mouse) end)
	move = mouse.Move:connect(function () onMove(mouse) end)
	
	InventoryData:SetVisible(false)
	
	
	EnableBorders(true)
	wait(.4)
	if windowVisible then windowVisible:disconnect() end
	windowVisible = UIEvents.WindowVisibilityChanged.Event:connect(function()
		workspace.Main.UnequipTools:Fire()
		windowVisible:disconnect()
	end)
	if _G.GamepadEnabled then
		game:GetService("RunService"):BindToRenderStep("DeleteCameraMovement",Enum.RenderPriority.Camera.Value,function()
			onMove(mouse)
		end)
	end
end



script.Parent.Equipped:connect(onEquipped)

function un()
	if _G.GamepadEnabled then
		MainGui.Notifications.DeleteFurnitureHelp.Visible = false
	end
	selection.Adornee = nil
	button1:disconnect()
	if windowVisible then windowVisible:disconnect() end
	move:disconnect()
	EnableBorders(false)
	game:GetService("RunService"):UnbindFromRenderStep("DeleteCameraMovement")
end
script.Parent.Unequipped:connect(un)

script.Parent.Changed:connect(function()
	if script.Parent.Parent == workspace then
		EnableBorders(false)
		script.Parent:Destroy()
	end
end)


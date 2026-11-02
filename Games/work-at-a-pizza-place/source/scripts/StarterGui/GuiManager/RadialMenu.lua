local RadialMenu = {}
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local UIS = game:GetService("UserInputService")
local CAS = game:GetService("ContextActionService")

RadialMenu.__index = RadialMenu

local ranges = {{180,120},{120,60},{60,0},{0,-60},{-60,-120},{-120,-180}}

function RadialMenu.new(object,guiManager)
	
	
	
	local this = {}
	setmetatable(this, RadialMenu)
	
	this.Object = object
	this.Type = "RadialMenu"
	this.WindowData = guiManager:GetWindowDataByName(object.Name)
	this.Options = nil
	this.SelectionMode = false
	this.Selection = nil
	this.HighlightedIndex = nil
	
	this.UnselectedNodes = {object:WaitForChild("TopLeft"),object:WaitForChild("Top"),object:WaitForChild("TopRight"),object:WaitForChild("BottomRight"),object:WaitForChild("Bottom"),object:WaitForChild("BottomLeft")}
	this.SelectedNodes = {object:WaitForChild("TopLeftSelected"),object:WaitForChild("TopSelected"),object:WaitForChild("TopRightSelected"),object:WaitForChild("BottomRightSelected"),object:WaitForChild("BottomSelected"),object:WaitForChild("BottomLeftSelected")}

	return this
	
	
end

function RadialMenu:GetSelection()
	local x,y,deg,highlightedIndex 
	
	self.Object.RadialLabel.Visible = false
	
	local function ThumbstickMoved(str,UserInputState,inputObject)
		--print(math.abs(inputObject.Position.Y)+math.abs(inputObject.Position.X))
		x = inputObject.Position.X
		y = inputObject.Position.Y
		if math.sqrt(math.pow(x,2)+math.pow(y,2)) > .7 then
			deg = math.deg(math.atan2(y,x))
			highlightedIndex = self.HighlightedIndex
			for i,range in ipairs(ranges) do
				if deg > range[2] and deg < range[1] and i ~= highlightedIndex then -- and i ~= 1 then --REMOVE i~=1 to enabled pets
					if highlightedIndex then
						self.SelectedNodes[highlightedIndex].Visible = false
						self.UnselectedNodes[highlightedIndex].Visible = true
					end
					
					self.SelectedNodes[i].Visible = true
					self.UnselectedNodes[i].Visible = false
					
					self.Object.RadialLabel.Visible = true
					
					local text = self.Options[i]
					self.Object.RadialLabel.Text = (text == "PetPanel" and "Pets") or (text == "Catalog" and "Shop") or text
					
					self.HighlightedIndex = i
				end
			end
		end
	end
	
	local function Thumbstick2Moved(str,UserInputState,inputObject)
	end
	
	local function AButtonPressed(actionName,InputState,InputObject)
		if InputState == Enum.UserInputState.End and self.HighlightedIndex then
			self.Selection = self.Options[self.HighlightedIndex]
			self.SelectionMode = false
		end
	end
	
	local function BButtonPressed()
		self.Selection = nil
		self.SelectionMode = false
	end
	
	CAS:BindAction("ThumbstickMoved", ThumbstickMoved, false, Enum.KeyCode.Thumbstick1)
	CAS:BindAction("Thumbstick2Moved", Thumbstick2Moved, false, Enum.KeyCode.Thumbstick2)
	CAS:BindAction("AButton", AButtonPressed, false, Enum.KeyCode.ButtonA)
	CAS:BindAction("BButton", BButtonPressed, false, Enum.KeyCode.ButtonB)

	
	self.Selection = nil
	self.SelectionMode = true
	
	while self.SelectionMode do
		wait(.1)
	end
		
	self.WindowData:SetVisible(false)
	
	self:CancelSelection()
	
	return self.Selection
end

function RadialMenu:SetOptions(options)
	self.Options = options
end

function RadialMenu:CancelSelection()
	self.SelectionMode = false
	CAS:UnbindAction("ThumbstickMoved")
	CAS:UnbindAction("Thumbstick2Moved")
	CAS:UnbindAction("BButton")
	CAS:UnbindAction("AButton")
end








return RadialMenu

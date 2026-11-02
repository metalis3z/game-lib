local Tab = {}
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))


Tab.__index = Tab



function Tab.new(object,TabGroup,frame)
	
	
	
	local this = {}
	setmetatable(this, Tab)
	this.Object = object
	this.Type = "Tab"
	this.Frame = frame
	this.TabGroup = TabGroup
	this.Color = Color3.new(21/255, 89/255, 216/255)
	this.Pressed = false
	this.Icon = object:FindFirstChild("Icon")
	this.Label = object:FindFirstChild("Label")
	this.PositionY = object.Position.Y.Offset
	
	--[[this.HoverOver = object.MouseEnter:connect(function()
		if not this.Pressed then
			object.ImageColor3 = Color3.new(24/255, 128/255, 255/255)
		end
	end)
	
	this.HoverLeave = object.MouseLeave:connect(function()
		if not this.Pressed then
			object.ImageColor3 = this.Color
		end
	end)]]
	
	this.Clicked = object.MouseButton1Click:connect(function()
		this:SetPressed(true)
		--SoundFX:PlaySound("Pop3")
	end)
	
	return this

end


function Tab:SetPressed(pressed)
	if pressed then
		--[[local pos = self.Object.Position
		self.Object.Position = UDim2.new(pos.X.Scale,pos.X.Offset,pos.Y.Scale,self.PositionY + 5)
		self.Object.Backdrop.Visible = false
		self.Object.BackdropDown.Visible = true]]
		self.Pressed = true
		self.Object.Style = Enum.ButtonStyle.RobloxRoundDefaultButton

		--self.Object.ImageColor3 = Color3.new(125/255, 157/255, 216/255)
		self.TabGroup:TabPressed(self)
	else
		self.Object.Style = Enum.ButtonStyle.RobloxRoundButton
		
		--[[local pos = self.Object.Position
		self.Object.Position = UDim2.new(pos.X.Scale,pos.X.Offset,pos.Y.Scale,self.PositionY)
		self.Object.Backdrop.Visible = true
		self.Object.BackdropDown.Visible = false]]
		self.Pressed = false
		--self.Object.ImageColor3 = self.Color

	end
end





return Tab

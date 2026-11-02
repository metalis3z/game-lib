local ListItem = {}
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums =  require(game.ReplicatedStorage:WaitForChild("Enums"))
local Dialog =  require(game.ReplicatedStorage:WaitForChild("Dialog"))

local player = game.Players.LocalPlayer
local UIEvents = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UIEvents")

ListItem.__index = ListItem



function ListItem.new(listView,windowData)

	local this = {}
	setmetatable(this, ListItem)
	
	this.Object = nil
	this.Type = "ListItem"
	this.WindowData = windowData
	this.CurrenTemplate = nil
	this.ItemData = nil
	this.Position = nil
	this.Selected = false
	this.ListView = listView
	this.Disabled = false
	this.Events = {}
	this.ButtonEvents = {}
	
	return this

end



function ListItem:SetTemplate(template)
	
	if template == self.CurrentTemplate then return end
	self.CurrentTemplate = template
	
	
	if self.Object then self.Object:Destroy() end
	
	local object = template:clone()
	object.Parent = self.ListView.Object
	
	
	self.Object = object
	
	local moveleave
	local buypressed
	
		
	if self.Object:IsA("GuiButton") then
		table.insert(self.Events,object.MouseButton1Click:connect(function()
	
			if self.Disabled then return end
			
			
			self.ListView:SetSelection(self)
		
	
		end))
	else
		local function search(parent)
			for _,obj in ipairs(parent:GetChildren()) do
				if obj:IsA("GuiButton") then
					table.insert(self.Events,obj.MouseButton1Click:connect(function()
						self.ListView:SetSelection(self,obj)
					end))
				elseif obj:IsA("Frame") then
					search(obj)
				end
			end
		end
		search(object)
	end
end


function ListItem:UpdateDisplay(listItemData,index,displayFunction)
	
	self.ItemData = listItemData
	
	self.Object.Visible = true
	
	
	displayFunction(self,self.Object,listItemData,index)
	
end


function ListItem:Delete()
	for _,event in ipairs(self.Events) do
		event:disconnect()
	end
	self.Events = {}
	if self.Object then self.Object:Destroy() end
end

function ListItem:SetPosition(position)
	self.Object.Position = position
	self.Position = position
end


function ListItem:SetSelected(selected)
	
	if self.ListView.SingleSelectMode or self.ListView.MultiSelectMode then
		if selected then
			self.Object.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
		else
			self.Object.Style = Enum.ButtonStyle.RobloxRoundButton
		end
	end

	self.Selected = selected

end




return ListItem

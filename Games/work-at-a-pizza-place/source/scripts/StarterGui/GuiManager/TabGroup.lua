local TabGroup = {}
local Tab = require(script:WaitForChild("Tab"))
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local UIEvents = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UIEvents")


TabGroup.__index = TabGroup



function TabGroup.new(tabs,windowData)

	local this = {}
	setmetatable(this, TabGroup)
	
	this.Tabs = {}
	this.Object = tabs
	this.Type = "TabGroup"
	this.WindowData = windowData


	
	
	--gather and create tabs classes
	for i,tab in ipairs(tabs:GetChildren()) do
		if tab:IsA("TextButton") or tab:IsA("ImageButton") then
			table.insert(this.Tabs,Tab.new(tab,this))
		end
	end
	
	--sort by position
	table.sort(this.Tabs,function(a,b)
		return a.Object.AbsolutePosition.X < b.Object.AbsolutePosition.X
	end)
	
	
	
	this.Tabs[1]:SetPressed(true)
	
	if _G.GamepadEnabled then
		
		tabs.Right.Visible = true
		tabs.Left.Visible = true
		
		local selectionIndex = 1
		local function BumperPressed(direction)
			
			local nextIndex = selectionIndex+direction
		
			if this.Tabs[nextIndex] then
				this.Tabs[nextIndex]:SetPressed(true)
				selectionIndex = nextIndex
	
			elseif nextIndex <= 0 then
				this.Tabs[#this.Tabs]:SetPressed(true)
				selectionIndex = #this.Tabs
				
			elseif nextIndex > #this.Tabs then
				this.Tabs[1]:SetPressed(true)
				selectionIndex = 1
			end
		end
		
		windowData:RegisterGamepadAction(Enum.KeyCode.ButtonL1, function(action,state,inputObject)
			if state == Enum.UserInputState.Begin then
				BumperPressed(-1)	
			end
		end)
		
		windowData:RegisterGamepadAction(Enum.KeyCode.ButtonR1, function(action,state,inputObject)
			if state == Enum.UserInputState.Begin then
				BumperPressed(1)	
			end
		end)

	end

	
	return this

end

function TabGroup:SetConsoleSize(size)
	if _G.GamepadEnabled then
		self.Object.Size = size
	end
end

function TabGroup:TabPressed(tabPressed)
	for _,tab in ipairs(self.Tabs) do
		if tab ~= tabPressed then
			tab:SetPressed(false)
		end
	end
	UIEvents.TabChanged:Fire(self.WindowData.Object,tabPressed.Object)
end


function TabGroup:SetFirstTabPressed(tabButton)
	for _,tab in ipairs(self.Tabs) do
		if tab.Object == tabButton then
			tab:SetPressed(true)
			UIEvents.TabChanged:Fire(self.WindowData.Object,tab.Object)
			return
		end
	end
end







return TabGroup

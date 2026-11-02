local ToggleButton = {}
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))


ToggleButton.__index = ToggleButton



function ToggleButton.new(object,windowData,initialValue)
	
	
	
	local this = {}
	setmetatable(this, ToggleButton)
	this.Object = object
	this.Type = "ToggleButton"
	this.IsOn = false
	this.WindowData = windowData
	
	object.MouseButton1Click:connect(function()
		this:Toggle(true)
	end)

	if initialValue then
		this:Toggle(false)
	end
	return this

end


function ToggleButton:Toggle(broadcast)
	if self.IsOn then
		self.IsOn = false
		self.Object.Style = Enum.ButtonStyle.RobloxRoundButton
		self.Object.TextLabel.Text = "Off"
	else
		self.IsOn = true
		self.Object.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
		self.Object.TextLabel.Text = "On"
	end
	if broadcast then
		UIEvents.ToggleButtonPressed:Fire(self.WindowData.Object,self.Object,self.IsOn)
	end
end


return ToggleButton

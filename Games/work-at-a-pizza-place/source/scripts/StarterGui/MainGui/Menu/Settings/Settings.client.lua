local Window = script.Parent
local SettingOptions = Window:WaitForChild("SettingOptions")

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))


local SavedSettings = Utility:SendData("GetSettings","PlayerChannel",10) or Utility:SendData("GetSettings","PlayerChannel",10) or {UniformEnabled = true, WaterEnabled = false, Music = .5}

Window.Position = UDim2.new(0.5, 0,0, 0) --correct the position -- studio dosent have topbar

local windowData
if _G.GamepadEnabled then
	Window.Position = UDim2.new(0.5,0,0.2,-Window.AbsoluteSize.Y/2)
	Window:WaitForChild("Title").Visible = true
	windowData = GuiManager:RegisterWindow(Window,"Left","Right",nil,nil,true)
else
	windowData = GuiManager:RegisterWindow(Window)
end

windowData:SetConsoleSize(UDim2.new(0,370,1,0))
windowData.FirstSelectedObject = SettingOptions:WaitForChild("Music"):WaitForChild("SliderFrame"):WaitForChild("Slider"):WaitForChild("Dragger")

for settingName,value in pairs(SavedSettings) do
	
	if settingName == "UniformEnabled" or settingName == "WaterEnabled" or settingName == "OldMusic" then
		local button = SettingOptions:WaitForChild(settingName,5):WaitForChild("ToggleButton")
		GuiManager:RegisterToggleButton(Window,button,value)
	
	elseif settingName == "Music" then
		local slider = SettingOptions:WaitForChild(settingName):WaitForChild("SliderFrame"):WaitForChild("Slider")
		GuiManager:RegisterSlider(Window,slider,value)
	end
end

--[[local button = Window:WaitForChild("BubbleEnabled"):WaitForChild("ToggleButton")
GuiManager:RegisterToggleButton(Window,button,false)]]

local ReportButton = SettingOptions:WaitForChild("ReportGlitch"):WaitForChild("ReportButton")


UIEvents.ToggleButtonPressed.Event:connect(function(window,button,state)
	local settingName = button.Parent.Name
	if window == Window then
		
		if settingName == "UniformEnabled" or settingName == "WaterEnabled" or settingName == "OldMusic" then
			
			Utility:SendData("SettingChanged","PlayerChannel",nil,settingName,state)
		end
		
	end
end)


UIEvents.SliderStopped.Event:connect(function(window,object,volume)
	if window == Window then
		if object.Parent.Name == "Music" then
			local settingName = object.Parent.Name
			local threeDecimalPercision = ("%0.3f"):format(volume)
			Utility:SendData("SettingChanged","PlayerChannel",nil,settingName,threeDecimalPercision)
		end
	end
end)


ReportButton.MouseButton1Click:connect(function()
	windowData:SetVisible(false)
	GuiManager:GetWindowDataByName("ReportGlitch"):SetVisible(true)
end)






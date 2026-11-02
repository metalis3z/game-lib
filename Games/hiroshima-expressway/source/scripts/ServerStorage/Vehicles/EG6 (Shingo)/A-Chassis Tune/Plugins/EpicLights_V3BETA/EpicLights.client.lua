--[[
 	  _______  ___________   ___________ ____________  _   ______
 	 / __/ _ \/  _/ ___/ /  /  _/ ___/ // /_  __/ __/ | | / /_  /
 	/ _// ___// // /__/ /___/ // (_ / _  / / / _\ \   | |/ //_ < 
   /___/_/  /___/\___/____/___/\___/_//_/ /_/ /___/   |___/____/ (beta2)
   
   https://discord.gg/Vk7uGNnX9M
   join the discord for any questions or support relating to my plugins
                                                              
]]--

-------- CONFIG
-- ENABLERS (do not touch yet)
local Popups_Enabled = true  -- Enables popups. (refer to "Instructions" for installation)

local Sequential_Indicators = false -- Enables sequential indicators. (refer to "Instructions" for installation)

local Sequential_Segments = 3 -- How many segments your indicators use. (don't use if Sequential_Indicators is false)

local Trunk_Lights = false -- Enables rear, brake, and reverse lights on trunk. (they will still work inside of the main model)

local Plate_Lights = false -- Enables license plate lights.

local Interior_Lights = false -- Enables interior lights. (Not Working Yet)

local Door_Functionality = false -- (USE ONLY IF YOU HAVE OPENING DOORS, including trunk, any kind of door in misc **trunk no working yet)

local Mirror_Indicators = false --Enables indicators on mirrors. (Not Working yet)

local Dashboard_Indicators = false -- Enables dashboard indicators. (refer to "Instrucitons" for setup) (Not Working Yet)


-- COLOR SETTINGS
--[[
	COLOR PRESETS:
		
	Headlights
		- OEM White
		- Xenon
		- Pure White
		- Brilliant Blue
		- Light Green
		- Golden Yellow
		- Bubu's Purple
		- Yellow
	Indicators
		- Light Orange
		- Dark Orange
		- Yellow
		- Red
		
	For custom color use Color3.fromRGB(R, G, B). You can get your RGB code from the "Color" property.
]]--

local Low_Beam_Color = "OEM White"

local High_Beam_Color = "OEM White"

local Running_Light_Color = "OEM White"

local Interior_Light_Color = "OEM White"

local Front_Indicator_Color = "Dark Orange"

local Rear_Indicator_Color = "Dark Orange"

local Fog_Light_Color = "OEM White"

local Plate_Light_Color = "OEM White"

-- LIGHT SETTINGS
--[[
	LIGHT TYPES:
		- Halogen
		- LED
]]--

local Low_Beam_Brightness = 2.25

local High_Beam_Brightness = 3.15

local Fog_Light_Brightness = 0.7

local Rear_Light_Brightness = 1.5

local Brake_Light_Brightness = 2.5

local Reverse_Light_Brightness = 1

local Headlight_Type = "Halogen"

local Indicator_Type = "Halogen"

local Fog_Light_Type = "Halogen"

local Plate_Light_Type = "Halogen"

local Rear_Light_Type = "Halogen"

local Reverse_Light_Type = "Halogen"

local Running_Light_Location = "Custom DRL" -- Where your running lights will luminate. ("Low Beam / Indicators" and "Low Beam".  LED DRLS or any DRL in a differnet position go in the Running model, change the string to "Custom DRL")

local CustomDRL_Type = "LED"

local Fade_Time = 0.35 -- How long it takes for the light to fully turn on. (works only with Halogen, default is 0.35 seconds)

local Indicator_Flash_Rate = 0.3 -- Rate of change between each indicator state. (in seconds)

local Popup_Hinge_Angle = -0.75 -- Changes the angle of your popup headlights. (only use if your car has popups)


-- SOUND SETTINGS
local Indicator_Stack_On = 6212970852 -- ID for the indicator stack being on.

local Indicator_Stack_Off = 6212970338 -- ID for the indicator stack being off.

local Indicator_Click_On = 6212969851 -- ID for the indicator state being on.

local Indicator_Click_Off = 6212969290 -- ID for the indicator state being off.

-- KEY SETTINGS
local Headlights = Enum.KeyCode.Power

local RunningLights = Enum.KeyCode.Power

local FogLights = Enum.KeyCode.Power

local SignalLeft = Enum.KeyCode.Power

local SignalRight = Enum.KeyCode.Power

local Hazards = Enum.KeyCode.Power

local Popups = Enum.KeyCode.Power

local Flash = Enum.KeyCode.Power

--- DONT TOUCH ---

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local Values = script.Parent.Parent:WaitForChild("Values")
local car = script.Parent.Parent.Car.Value
local DriveSeat = car:WaitForChild("DriveSeat")
local Tune = require(car:WaitForChild("A-Chassis Tune"))
local IsOn = Values.Parent:WaitForChild("IsOn")
local LightEvent = car:WaitForChild("LightEvent")

local LI = script.Values.Left
local RI = script.Values.Right
local H = script.Values.Hazard
local RL = script.Values.RunningLights
local HL = script.Values.Headlights

local setup = false
local current_seq_seg = 1
local flashing = false
local parklightActive = false
local drlActive = false
local fogActive = false
local popupsActive = false

local gui_tweeninfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0)
local indgui_tweeninfo = TweenInfo.new(Indicator_Flash_Rate / 2.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0)

function input(key, gameprocessed)
	if not gameprocessed then
		if key.KeyCode == Headlights then
			if HL.Value == 0 then
				HL.Value = 1
				LightEvent:FireServer("Headlights", Low_Beam_Brightness, 0.2, 48, parklightActive, Popups_Enabled, Headlight_Type, HL.Value)
				LightEvent:FireServer("RearLights", Rear_Light_Type, Rear_Light_Brightness, 0.2, Trunk_Lights)
				if fogActive then
					LightEvent:FireServer("FogLights", Fog_Light_Brightness, 0.02, Fog_Light_Type)
					TweenService:Create(script.Parent.FogLights, gui_tweeninfo, {ImageTransparency = 0}):Play()
				end
				TweenService:Create(script.Parent.LowBeams, gui_tweeninfo, {ImageTransparency = 0}):Play()
			elseif HL.Value == 1 then
				HL.Value = 2		
				LightEvent:FireServer("Headlights", High_Beam_Brightness, 0.02, 60, parklightActive, Popups_Enabled, Headlight_Type, HL.Value)
				TweenService:Create(script.Parent.LowBeams, gui_tweeninfo, {ImageTransparency = 1}):Play()
				TweenService:Create(script.Parent.HighBeams, gui_tweeninfo, {ImageTransparency = 0}):Play()
			elseif HL.Value == 2 then	
				HL.Value = 0
				LightEvent:FireServer("Headlights", 0, 1, 60, parklightActive, Popups_Enabled, Headlight_Type, HL.Value)
				if not parklightActive then
					LightEvent:FireServer("RearLights", Rear_Light_Type, 0, 1, Trunk_Lights)
				end	
				LightEvent:FireServer("FogLights", 0, 1, Fog_Light_Type)
				TweenService:Create(script.Parent.LowBeams, gui_tweeninfo, {ImageTransparency = 1}):Play()
				TweenService:Create(script.Parent.HighBeams, gui_tweeninfo, {ImageTransparency = 1}):Play()
				TweenService:Create(script.Parent.FogLights, gui_tweeninfo, {ImageTransparency = 1}):Play()
			end	
			if Plate_Lights then
				if HL.Value >= 1 then
					LightEvent:FireServer("PlateLights", true, Plate_Light_Type)
				else	
					LightEvent:FireServer("PlateLights", false, Plate_Light_Type)
				end
			end
		elseif key.KeyCode == Popups then
			if Popups_Enabled then
				if popupsActive == false then
					LightEvent:FireServer("Popups", true, Popups_Enabled, Popup_Hinge_Angle)
					popupsActive = true
				else
					LightEvent:FireServer("Popups", false, Popups_Enabled, Popup_Hinge_Angle)
					popupsActive = false				
				end
			end	
		elseif key.KeyCode == RunningLights then
			if Running_Light_Location ~= "Custom DRL" then
				if not parklightActive then
					parklightActive = true
					TweenService:Create(script.Parent.ParkLights, gui_tweeninfo, {ImageTransparency = 0}):Play()
				else
					parklightActive = false
					TweenService:Create(script.Parent.ParkLights, gui_tweeninfo, {ImageTransparency = 1}):Play()
				end
			else
				if not drlActive then
					drlActive = true
					LightEvent:FireServer("CustomDRL", drlActive, CustomDRL_Type)
					TweenService:Create(script.Parent.ParkLights, gui_tweeninfo, {ImageTransparency = 0}):Play()
				else
					drlActive = false
					LightEvent:FireServer("CustomDRL", drlActive, CustomDRL_Type)
					TweenService:Create(script.Parent.ParkLights, gui_tweeninfo, {ImageTransparency = 1}):Play()
				end
			end	
			if HL.Value == 0 then
				LightEvent:FireServer("Headlights", 0, 1, 60, parklightActive, Popups_Enabled, Headlight_Type, HL.Value)
				if parklightActive or drlActive then
					LightEvent:FireServer("RearLights", Rear_Light_Type, Rear_Light_Brightness, 0.2, Trunk_Lights)
				elseif not parklightActive or drlActive then
					LightEvent:FireServer("RearLights", Rear_Light_Type, 0, 1, Trunk_Lights)
				end	
			end
		elseif key.KeyCode == FogLights then
			if HL.Value > 0 then
				if not fogActive then
					LightEvent:FireServer("FogLights", Fog_Light_Brightness, 0.02, Fog_Light_Type)
					TweenService:Create(script.Parent.FogLights, gui_tweeninfo, {ImageTransparency = 0}):Play()
					fogActive = true
				else
					LightEvent:FireServer("FogLights", 0, 1, Fog_Light_Type)
					TweenService:Create(script.Parent.FogLights, gui_tweeninfo, {ImageTransparency = 1}):Play()
					fogActive = false					
				end
			else
				if not fogActive then
					fogActive = true
				else
					fogActive = false
				end
			end
		elseif key.KeyCode == Flash then
			if not flashing then

			end
		elseif key.KeyCode == SignalLeft then
			if not LI.Value then
				LI.Value = true
				script.StackOn:Play()
			else
				LI.Value = false
				script.StackOff:Play()
			end	
		elseif key.KeyCode == SignalRight then
			if not RI.Value then
				RI.Value = true
				script.StackOn:Play()
			else
				RI.Value = false
				script.StackOff:Play()
			end
		elseif key.KeyCode == Hazards then
			if not H.Value then
				H.Value = true
			else
				H.Value = false	
			end
		end
	end
end


function autoLight()
	local dusk = {16, 18}
	local night = {18, 6.2}
	local timenow = game.Lighting:GetMinutesAfterMidnight() / 60
	
	if timenow >= dusk[1] and timenow <= dusk[2] then
		HL.Value = 0
		parklightActive = true
		LightEvent:FireServer("Headlights", Low_Beam_Brightness, 0.2, 48, parklightActive, Popups_Enabled, Headlight_Type, HL.Value)		
		LightEvent:FireServer("RearLights", Rear_Light_Type, Rear_Light_Brightness, 0.2, Trunk_Lights)
		TweenService:Create(script.Parent.ParkLights, gui_tweeninfo, {ImageTransparency = 0}):Play()
	elseif timenow > night[1] or (timenow >= 0 and timenow <= night[2]) then
		HL.Value = 1
		LightEvent:FireServer("Headlights", Low_Beam_Brightness, 0.02, 48, parklightActive, Popups_Enabled, Headlight_Type, HL.Value)
		LightEvent:FireServer("RearLights", Rear_Light_Type, Rear_Light_Brightness, 0.2, Trunk_Lights)
		TweenService:Create(script.Parent.LowBeams, gui_tweeninfo, {ImageTransparency = 0}):Play()
	else
		HL.Value = 0
		LightEvent:FireServer("Headlights", 0, 1, 0, parklightActive, Popups_Enabled, Headlight_Type, HL.Value)
		LightEvent:FireServer("RearLights", Rear_Light_Type, 0, 1, Trunk_Lights)
	end
end



function brakes()
	if Values.Brake.Value > 0.01 then 
		LightEvent:FireServer("BrakeLights", Rear_Light_Type, Brake_Light_Brightness, 0.02, Trunk_Lights)
	else
		LightEvent:FireServer("BrakeLights", Rear_Light_Type, 0, 1, Trunk_Lights)
	end
end

function reverse()
	if Values.Gear.Value == -1 then
		LightEvent:FireServer("Reverse", Reverse_Light_Type, Reverse_Light_Brightness, 0.02, Trunk_Lights)
	else
		LightEvent:FireServer("Reverse", Reverse_Light_Type, 0, 1, Trunk_Lights)
	end
end

function leavedriveseat()
	LightEvent:FireServer("IndsOnLeave", LI.Value, RI.Value, H.Value, Sequential_Indicators, Sequential_Segments, Indicator_Flash_Rate, Indicator_Type)
end

--UIS.InputEnded:Connect(function(key)
--	if key.KeyCode == Flash then
--		flashing = false
--		if not Popups_Enabled then
--			if parklightActive then
--				LightEvent:FireServer("Headlights", 0, Fade_Time, tabG, Light_Type, Popups_Enabled)
--			else
--				LightEvent:FireServer("Headlights", HL.Value, Fade_Time, tabG, Light_Type, Popups_Enabled)
--			end
--		else
--			if parklightActive then
--				LightEvent:FireServer("PopupLights", 0, Fade_Time, tabG, Light_Type, Popups_Enabled)
--			else
--				LightEvent:FireServer("PopupLights", HL.Value, Fade_Time, tabG, Light_Type, Popups_Enabled)
--			end
--		end	
--	end
--end)

LightEvent:FireServer("Setup", Low_Beam_Color, High_Beam_Color, Running_Light_Color, Front_Indicator_Color, Rear_Indicator_Color, Fog_Light_Color, Popups_Enabled, Plate_Lights, Plate_Light_Color, Trunk_Lights, Mirror_Indicators, Running_Light_Location, Fade_Time, Indicator_Flash_Rate, Interior_Lights, Interior_Light_Color, Door_Functionality)

autoLight()
brakes()
reverse()

UIS.InputBegan:Connect(input)
DriveSeat.ChildAdded:Connect(autoLight)
DriveSeat.ChildRemoved:Connect(leavedriveseat)
Values.Brake.Changed:Connect(brakes)
Values.Gear.Changed:Connect(reverse)

local co2 = coroutine.create(function()
	while wait() do
		if Sequential_Indicators then
			if LI.Value then
				RI.Value = false
				H.Value = false
				script.ClickOn:Play()
				TweenService:Create(script.Parent.LeftInd, indgui_tweeninfo, {ImageTransparency = 0}):Play()
				for i = 1, Sequential_Segments do
					LightEvent:FireServer("SignalLeft", 0, 0.02, Indicator_Type, Sequential_Indicators, i)
					wait(Indicator_Flash_Rate / Sequential_Segments)
				end
				wait(0.1)
				script.ClickOff:Play()
				TweenService:Create(script.Parent.LeftInd, indgui_tweeninfo, {ImageTransparency = 1}):Play()
				LightEvent:FireServer("SignalLeft", 0, 1, Indicator_Type, Sequential_Indicators, 1)	
				wait(Indicator_Flash_Rate)
			else
				LightEvent:FireServer("SignalLeft", 0, 1, Indicator_Type, Sequential_Indicators, 1)
			end
			if RI.Value then
				LI.Value = false
				H.Value = false
				script.ClickOn:Play()
				TweenService:Create(script.Parent.RightInd, indgui_tweeninfo, {ImageTransparency = 0}):Play()
				for i = 1, Sequential_Segments do
					LightEvent:FireServer("SignalRight", 0, 0.02, Indicator_Type, Sequential_Indicators, i)
					wait(Indicator_Flash_Rate / Sequential_Segments)
				end
				wait(0.1)
				script.ClickOff:Play()
				TweenService:Create(script.Parent.RightInd, indgui_tweeninfo, {ImageTransparency = 1}):Play()
				LightEvent:FireServer("SignalRight", 0, 1, Indicator_Type, Sequential_Indicators, 1)	
				wait(Indicator_Flash_Rate)
			else
				LightEvent:FireServer("SignalRight", 0, 1, Indicator_Type, Sequential_Indicators, 1)
			end
			if H.Value then
				LI.Value = false
				RI.Value = false
				script.ClickOn:Play()
				TweenService:Create(script.Parent.LeftInd, indgui_tweeninfo, {ImageTransparency = 0}):Play()
				TweenService:Create(script.Parent.RightInd, indgui_tweeninfo, {ImageTransparency = 0}):Play()
				for i = 1, Sequential_Segments do
					LightEvent:FireServer("Hazards", 0, 0.02, Indicator_Type, Sequential_Indicators, i)
					wait(Indicator_Flash_Rate / Sequential_Segments)
				end
				wait(0.1)
				script.ClickOff:Play()
				TweenService:Create(script.Parent.LeftInd, indgui_tweeninfo, {ImageTransparency = 1}):Play()
				TweenService:Create(script.Parent.RightInd, indgui_tweeninfo, {ImageTransparency = 1}):Play()
				LightEvent:FireServer("Hazards", 0, 1, Indicator_Type, Sequential_Indicators, 1)	
				wait(Indicator_Flash_Rate)
			else
				LightEvent:FireServer("Hazards", 0, 1, Indicator_Type, Sequential_Indicators, 1)
			end
		end
	end
end)

local co = coroutine.create(function()
	while wait() do
		if not Sequential_Indicators then
			if LI.Value then
				RI.Value = false
				H.Value = false
				script.ClickOn:Play()
				TweenService:Create(script.Parent.LeftInd, indgui_tweeninfo, {ImageTransparency = 0}):Play()
				LightEvent:FireServer("SignalLeft", 1, 0.02, Indicator_Type)
				wait(Indicator_Flash_Rate)
				script.ClickOff:Play()
				TweenService:Create(script.Parent.LeftInd, indgui_tweeninfo, {ImageTransparency = 1}):Play()
				if Running_Light_Location == "Low Beam / Indicators" and parklightActive then
					LightEvent:FireServer("SignalLeft", 0, 0.71, Indicator_Type)	
				else
					LightEvent:FireServer("SignalLeft", 0, 1, Indicator_Type)	
				end
				wait(Indicator_Flash_Rate)
			else
				TweenService:Create(script.Parent.LeftInd, indgui_tweeninfo, {ImageTransparency = 1}):Play()
				if Running_Light_Location == "Low Beam / Indicators" and parklightActive then
					LightEvent:FireServer("SignalLeft", 0, 0.71, Indicator_Type)	
				else
					LightEvent:FireServer("SignalLeft", 0, 1, Indicator_Type)	
				end	
			end	
			if RI.Value then
				LI.Value = false
				H.Value = false
				script.ClickOn:Play()
				TweenService:Create(script.Parent.RightInd, indgui_tweeninfo, {ImageTransparency = 0}):Play()
				LightEvent:FireServer("SignalRight", 1, 0.02, Indicator_Type)
				wait(Indicator_Flash_Rate)
				script.ClickOff:Play()
				TweenService:Create(script.Parent.RightInd, indgui_tweeninfo, {ImageTransparency = 1}):Play()
				if Running_Light_Location == "Indicators" and parklightActive then
					LightEvent:FireServer("SignalRight", 0, 0.71, Indicator_Type)	
				else
					LightEvent:FireServer("SignalRight", 0, 1, Indicator_Type)	
				end
				wait(Indicator_Flash_Rate)
			else
				TweenService:Create(script.Parent.RightInd, indgui_tweeninfo, {ImageTransparency = 1}):Play()
				if Running_Light_Location == "Low Beam / Indicators" and parklightActive then
					LightEvent:FireServer("SignalRight", 0, 0.71, Indicator_Type)	
				else
					LightEvent:FireServer("SignalRight", 0, 1, Indicator_Type)	
				end	
			end		
			if H.Value then
				LI.Value = false
				RI.Value = false
				script.ClickOn:Play()
				TweenService:Create(script.Parent.LeftInd, indgui_tweeninfo, {ImageTransparency = 0}):Play()
				TweenService:Create(script.Parent.RightInd, indgui_tweeninfo, {ImageTransparency = 0}):Play()
				LightEvent:FireServer("Hazards", 1, 0.02, Indicator_Type)
				wait(Indicator_Flash_Rate)
				script.ClickOff:Play()
				TweenService:Create(script.Parent.LeftInd, indgui_tweeninfo, {ImageTransparency = 1}):Play()
				TweenService:Create(script.Parent.RightInd, indgui_tweeninfo, {ImageTransparency = 1}):Play()
				if Running_Light_Location == "Low Beam / Indicators" and parklightActive then
					LightEvent:FireServer("Hazards", 0, 0.71, Indicator_Type)	
				else
					LightEvent:FireServer("Hazards", 0, 1, Indicator_Type)	
				end	
				wait(Indicator_Flash_Rate)				
			else
				TweenService:Create(script.Parent.LeftInd, indgui_tweeninfo, {ImageTransparency = 1}):Play()
				TweenService:Create(script.Parent.RightInd, indgui_tweeninfo, {ImageTransparency = 1}):Play()
				if Running_Light_Location == "Low Beam / Indicators" and parklightActive then
					LightEvent:FireServer("Hazards", 0, 0.71, Indicator_Type)	
				else
					LightEvent:FireServer("Hazards", 0, 1, Indicator_Type)	
				end	
			end
		end
	end
end)	
coroutine.resume(co)
coroutine.resume(co2)
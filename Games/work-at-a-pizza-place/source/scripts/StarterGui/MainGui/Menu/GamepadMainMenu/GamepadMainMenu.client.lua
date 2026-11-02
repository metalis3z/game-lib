local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))

if not Enums.GamepadEnabled then
	return
end

local player = game.Players.LocalPlayer
local Window = script.Parent
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
--local GamepadMenuNotification = MainGui:WaitForChild("Notifications"):WaitForChild("GamepadMenuNotification")



local WindowData = GuiManager:RegisterWindow(Window,"Bottom","Bottom",nil,nil,true)
WindowData.IsGamepadNavigateable = false
local RadialMenu = GuiManager:RegisterRadialMenu(Window)
RadialMenu:SetOptions({"PetPanel","Inventory","Upgrade","Settings","Catalog","Ratings"})

local optionSelected

UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
	if window == Window then
		if visible then
			
			--GamepadMenuNotification.Visible = false

			local optionName = RadialMenu:GetSelection()
			
			if optionName then
				--open window chosen in menu
				local WindowData = GuiManager:GetWindowDataByName(optionName)
				
				--[[if optionName == "PetPanel" and _G.GamepadEnabled then
					Dialog:ShowMessage("Coming soon","This feature has not been enabled yet.")
					return
				end]]
					
					
				WindowData:SetVisible(true)
				
			end
		else
			--GamepadMenuNotification.Visible = true
		end
	end
end)


	



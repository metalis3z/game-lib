local player = game.Players.LocalPlayer
local Window = script.Parent
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))


local WindowData = GuiManager:RegisterWindow(Window,"Right","Right")
WindowData.CanBeFocused = false
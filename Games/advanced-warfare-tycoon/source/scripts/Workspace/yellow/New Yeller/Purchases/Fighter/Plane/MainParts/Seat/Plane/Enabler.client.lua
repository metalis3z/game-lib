--[[
	The Enabler is a script that enables the Main script once it gets put into the Player's backpack. This script is needed
	because Roblox updates prevented the Tool from being enabled the first time the plane tool was selected.
]]
local Main = script.Parent.Main
repeat wait() until game.Players.LocalPlayer
if Main.Disabled then
	Main.Disabled = false
end
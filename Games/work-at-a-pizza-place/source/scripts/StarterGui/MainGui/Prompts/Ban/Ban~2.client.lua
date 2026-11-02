local Window = script.Parent

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))

local Ban = Window:WaitForChild("Ban")
local DontBan = Window:WaitForChild("DontBan")

local WindowData = GuiManager:RegisterWindow(Window,"Top","Top",nil,nil,true)
WindowData.FirstSelectedObject = DontBan

WindowData:SetConsoleSize(UDim2.new(1,0,0,250))



Ban.MouseButton1Click:connect(function() 
	WindowData:SetVisible(false) 
	game.Workspace.Main.VotePlayers:FireServer() 
end)

DontBan.MouseButton1Click:connect(function() 
	WindowData:SetVisible(false) 
end)


workspace.Main.VotePlayers.OnClientEvent:connect(function(player_ban_name)
	WindowData:SetVisible(true)
	script.Parent.Title.Text = "Is " .. player_ban_name .. " causing trouble?"
end)



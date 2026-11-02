local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)

local player = Players.LocalPlayer
local leaderboardButton = script.Parent

local steelsBoard = Workspace.Map:FindFirstChild("StealsBoard")
local generationBoard = Workspace.Map:FindFirstChild("GenerationBoard")
local realStealsBoard = ReplicatedStorage:FindFirstChild("Real steals board")
local realGenerationBoard = ReplicatedStorage:FindFirstChild("Real generation board")

local saveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")
local playerSync = Synchronizer:Wait(player)

local isRealLeaderboardEnabled = false
local ATTRIBUTE_NAME = "RealLeaderboards"


local animatedButton = AnimatedButton.new(leaderboardButton)
animatedButton:Animate()

local function toggleRealLeaderboard()
	isRealLeaderboardEnabled = not isRealLeaderboardEnabled

	ReplicatedStorage:SetAttribute(ATTRIBUTE_NAME, isRealLeaderboardEnabled)

	if isRealLeaderboardEnabled then
		leaderboardButton.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
	else
		leaderboardButton.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
	end
end

ReplicatedStorage:SetAttribute(ATTRIBUTE_NAME, isRealLeaderboardEnabled)

animatedButton.OnActivated:Connect(toggleRealLeaderboard)


local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name .. "_Toggle", leaderboardButton, toggleRealLeaderboard)
kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()
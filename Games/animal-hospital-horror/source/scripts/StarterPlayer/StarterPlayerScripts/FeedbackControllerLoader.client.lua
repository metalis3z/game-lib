--[[
	FeedbackControllerLoader (LocalScript)
	Arranca el FeedbackController para que empiece a escuchar el ProximityPrompt.
]]
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local scripts = script.Parent -- StarterPlayerScripts

local FeedbackController = require(scripts:WaitForChild("FeedbackController"))
FeedbackController.Init()
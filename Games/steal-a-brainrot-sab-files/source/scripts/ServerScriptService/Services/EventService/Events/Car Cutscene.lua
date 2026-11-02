--!native
local cutscene = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)

local Trove = require(ReplicatedStorage.Packages.Trove) 

local StartCutsceneEvent = Net:RemoteEvent("SammyRoomService/StartCutscene")
local CusteceneSeenremote = Net:RemoteEvent("SammyRoomService/CutsceneSeen")
local isactive = false
local cutsceneTrove = nil

function cutscene.OnStart()
	if isactive then return end
	isactive = true

	cutsceneTrove = Trove.new()

	StartCutsceneEvent:FireAllClients()

	cutsceneTrove:Connect(Players.PlayerAdded, function(player)
		StartCutsceneEvent:FireClient(player)
	end)
end

function cutscene.OnStop()
	if not isactive then return end
	isactive = false

	if cutsceneTrove then
		cutsceneTrove:Clean()
		cutsceneTrove = nil
	end
end

return cutscene
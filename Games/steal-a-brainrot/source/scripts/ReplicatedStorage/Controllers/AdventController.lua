local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("UserInputService")
game:GetService("RunService")

local Players = game:GetService("Players")
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local AdventCalendar = require(ReplicatedStorage.Shared.AdventCalendar)
local Animals = require(ReplicatedStorage.Shared.Animals)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Signal = require(ReplicatedStorage.Packages.Signal)
require(ReplicatedStorage.Shared.Updates)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Net = require(ReplicatedStorage.Packages.Net)
local Spr = require(ReplicatedStorage.Packages.Spr)
local PlayerGui = Players.LocalPlayer.PlayerGui

local RemoteClaimReward = Net:RemoteFunction("AdventService/ClaimReward")
local RemoteRecover = Net:RemoteEvent("AdventService/Recover")

return {
	["Start"] = function(_) end
}
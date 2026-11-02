-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local AdventCalendar = require(ReplicatedStorage.Shared.AdventCalendar)
local Animals = require(ReplicatedStorage.Shared.Animals)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Updates = require(ReplicatedStorage.Shared.Updates)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Net = require(ReplicatedStorage.Packages.Net)
local Spr = require(ReplicatedStorage.Packages.Spr)

local _unused = Players.LocalPlayer.PlayerGui

local adventServiceClaimReward = Net:RemoteFunction("AdventService/ClaimReward")
local adventServiceRecover = Net:RemoteEvent("AdventService/Recover")

return {
    Start = function(_)

    end
}

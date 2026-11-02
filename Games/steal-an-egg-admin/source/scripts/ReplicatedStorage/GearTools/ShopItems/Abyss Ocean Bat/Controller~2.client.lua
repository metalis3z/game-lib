-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = require(ReplicatedStorage.Shared.Modules.BatController.Client)
local Gears = require(ReplicatedStorage.Data.Gears)
local Parent = script.Parent
local GearName = Parent:GetAttribute("GearName")
local v1 = typeof(GearName) == "string"
assert(v1, "Bat Tool requires a GearName attribute")
local BatControllerData = Gears.Directory[GearName].BatControllerData
local v2 = ("%* requires BatControllerData"):format(GearName)
local v3 = assert(BatControllerData, v2)
Client.new(Parent, v3)

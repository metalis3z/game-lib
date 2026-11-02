-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = require(ReplicatedStorage.Library.Modules.BatController.Client)
local Gears = require(ReplicatedStorage.Directory.Gears)
local v1 = script.Parent
local v2 = v1:GetAttribute("GearName")

assert(typeof(v2) == "string", "Bat Tool requires a GearName attribute")
Client.new(v1, (assert(Gears.Directory[v2].BatControllerData, (("%* requires BatControllerData"):format(v2)))))
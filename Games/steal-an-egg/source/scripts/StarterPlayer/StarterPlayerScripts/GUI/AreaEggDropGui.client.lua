-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AreaEggs = require(ReplicatedStorage.Library.Types.AreaEggs)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local PlayerRequest = AreaEggs.DropReasons.PlayerRequest
local v1 = Log.new()
local LocalPlayer = Players.LocalPlayer
local v2 = GUI.DropHeldEgg()

local function setCarrying(p1) --[[ setCarrying | Line: 31 | Upvalues: v2 (copy) ]]
	if p1.IsCarrying then
		v2.Enabled = true
	else
		v2.Enabled = false
	end
end

v2.Enabled = false
ButtonFX(v2.Button, nil, function() --[[ Line: 45 | Upvalues: EggCmds (copy), PlayerRequest (copy), v1 (copy), LocalPlayer (copy) ]]
	local v12, v2 = EggCmds.RequestDropHeldAreaEgg(PlayerRequest)

	if v12 or v2 == nil then
		return
	end

	v1:AtDebug():Log((("Drop held area egg denied for %*: %*"):format(LocalPlayer.UserId, v2)))
end)
EggCmds.AreaEggCarryStateChanged:Connect(setCarrying)
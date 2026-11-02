-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Variables = require(ReplicatedStorage.Library.Variables)
local v1 = Log.new()
local v2 = nil

local function updateTreadmillSession(p1) --[[ updateTreadmillSession | Line: 27 | Upvalues: Asserts (copy), v2 (ref), Variables (copy), v1 (copy) ]]
	Asserts.optional.string(p1)

	if p1 ~= nil and v2 == nil then
		v2 = Variables.Locks.DisableShiftLock:ObtainLock()
		v1:AtDebug():Log("Disabled shift lock for the active treadmill session")

		return
	end

	if p1 ~= nil or v2 == nil then
		return
	end

	v2()
	v2 = nil
	v1:AtDebug():Log("Released treadmill shift-lock suppression")
end

Network.Fired(Constants.NETWORK_MAP.Treadmills.ACTIVE_TREADMILL_EVENT):Connect(updateTreadmillSession)
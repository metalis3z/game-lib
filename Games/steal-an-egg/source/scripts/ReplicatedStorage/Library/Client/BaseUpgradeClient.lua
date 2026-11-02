-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Bases = require(ReplicatedStorage.Directory.Bases)
local BaseUpgradeTransition = require(ReplicatedStorage.Library.Client.GUIFX.BaseUpgradeTransition)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Mutex = require(ReplicatedStorage.Library.Modules.Mutex)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Plots = Constants.NETWORK_MAP.Plots
local LocalPlayer = Players.LocalPlayer
local v1 = Log.new()
local v2 = Mutex.new()
local t = {}

local function playTransitionAndRequest() --[[ playTransitionAndRequest | Line: 34 | Upvalues: BaseUpgradeTransition (copy), Network (copy), Plots (copy) ]]
	BaseUpgradeTransition.Play(function() --[[ Line: 35 | Upvalues: Network (ref), Plots (ref) ]]
		Network.Fire(Plots.REQUEST_BASE_UPGRADE)
	end)
end

function t.GetNextConfig(p1) --[[ GetNextConfig | Line: 44 | Upvalues: Asserts (copy), Bases (copy) ]]
	Asserts.integerNonNegative(p1.BaseUpgradeLevel)

	local v1 = p1.BaseUpgradeLevel + 1

	return v1, Bases.BASES[v1]
end
function t.CanAffordNext(p1) --[[ CanAffordNext | Line: 50 | Upvalues: t (copy) ]]
	local _, v1 = t.GetNextConfig(p1)

	return if v1 == nil then false else p1.Money >= v1.Cost
end
function t.RequestCashUpgrade() --[[ RequestCashUpgrade | Line: 55 | Upvalues: Save (copy), LocalPlayer (copy), t (copy), Message (copy), v2 (copy), wcall (copy), playTransitionAndRequest (copy), v1 (copy) ]]
	local v12 = Save.Get(LocalPlayer, false)

	assert(v12 ~= nil, "Base upgrade request requires loaded data")

	local _, v3 = t.GetNextConfig(v12)

	if v3 == nil then
		Message.Bottom({
			Message = "Max base upgrade reached",
			Time = 2
		})

		return false
	end

	if v12.Money < v3.Cost then
		Message.Bottom({
			Message = "Not enough money",
			Time = 2,
			Color = Color3.fromRGB(255, 64, 64)
		})

		return false
	end

	local v4 = v2:tryLock()

	if v4 == nil then
		return false
	end

	task.spawn(function() --[[ Line: 74 | Upvalues: wcall (ref), playTransitionAndRequest (ref), v2 (ref), v4 (copy), v1 (ref) ]]
		local v12, v22 = wcall(playTransitionAndRequest)

		v2:unlock(v4)

		if v12 then
			return
		end

		v1:AtError():Log((("Base upgrade transition failed: %*"):format(v22)))
	end)

	return true
end

return t
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local PromptPurchase = require(ReplicatedStorage.Library.Shared.Functions.PromptPurchase)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Treadmills = require(ReplicatedStorage.Directory.Treadmills)

require(ReplicatedStorage.Directory.Treadmills.Types.Interface)

local Treadmills2 = Constants.NETWORK_MAP.Treadmills
local v1 = Color3.fromRGB(255, 64, 64)
local v2 = Log.new()
local t = {
	GetNextConfig = function(p1) --[[ GetNextConfig | Line: 31 | Upvalues: Asserts (copy), Treadmills (copy) ]]
		Asserts.integerNonNegative(p1.TreadmillUpgradeLevel)

		local v1 = p1.TreadmillUpgradeLevel + 1

		return v1, Treadmills.GetByUpgradeLevel(v1)
	end
}

function t.CanAffordNext(p1) --[[ CanAffordNext | Line: 37 | Upvalues: t (copy) ]]
	local _, v1 = t.GetNextConfig(p1)

	return if v1 == nil then false else p1.Money >= v1.Price
end
function t.RequestCashUpgrade() --[[ RequestCashUpgrade | Line: 42 | Upvalues: Save (copy), t (copy), Message (copy), v1 (copy), Network (copy), Treadmills2 (copy), v2 (copy) ]]
	local v12 = Save.Get()

	assert(v12 ~= nil, "Treadmill cash upgrade requires loaded data")

	local _, v3 = t.GetNextConfig(v12)

	if v3 == nil then
		Message.Bottom({
			Message = "Max treadmill upgrade reached",
			Time = 2
		})

		return false
	end

	if v12.Money < v3.Price then
		Message.Bottom({
			Message = "Not enough money",
			Time = 2,
			Color = v1
		})

		return false
	end

	local v4, v5 = Network.Invoke(Treadmills2.REQUEST_UPGRADE, v3._id)

	if v4 == true then
		return true
	end

	local v6 = v5 or "Treadmill upgrade failed"

	v2:AtWarning():Log(v6)
	Message.Bottom({
		Time = 2,
		Message = v6,
		Color = v1
	})

	return false
end
function t.PromptRobuxUpgrade() --[[ PromptRobuxUpgrade | Line: 67 | Upvalues: Save (copy), t (copy), Message (copy), v2 (copy), PromptPurchase (copy) ]]
	local v1 = Save.Get()

	assert(v1 ~= nil, "Treadmill Robux upgrade requires loaded data")

	local _, v3 = t.GetNextConfig(v1)

	if v3 == nil then
		Message.Bottom({
			Message = "Max treadmill upgrade reached",
			Time = 2
		})

		return false
	end

	local ProductId = v3.ProductId

	if ProductId == nil then
		v2:AtWarning():Log((("Treadmill \"%*\" has no Robux upgrade product"):format(v3._id)))

		return false
	end

	PromptPurchase.Prompt(ProductId, true)

	return true
end

return t
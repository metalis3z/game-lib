-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Modules.DefaultStats.Types.Interface)
require(script:FindFirstAncestor("Products").Types.Interface)

local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)

local function canPurchaseTemporarySpeedBoost(p1) --[[ canPurchaseTemporarySpeedBoost | Line: 24 ]]
	if p1 == nil then
		return false, "Data not loaded"
	end

	return true
end

return function(p1, p2, p3) --[[ Line: 32 | Upvalues: Asserts (copy), TreadmillUtil (copy), ServerScriptService (copy), canPurchaseTemporarySpeedBoost (copy), ReplicatedStorage (copy) ]]
	Asserts.string(p1)
	Asserts.number(p2)
	Asserts.number(p3)
	assert(p3 > 0, "Temporary speed boost duration must be positive")

	local v2 = TreadmillUtil.FormatTemporarySpeedBoostProductDuration(p3)

	local function ServerTest(p1) --[[ ServerTest | Line: 40 | Upvalues: Asserts (ref), ServerScriptService (ref), canPurchaseTemporarySpeedBoost (ref) ]]
		Asserts.Player(p1)

		local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(p1)

		if v1 and v2 then
			return canPurchaseTemporarySpeedBoost(v2)
		end

		return false, "Player profile not found"
	end

	local function ClientTest() --[[ ClientTest | Line: 52 | Upvalues: ReplicatedStorage (ref), canPurchaseTemporarySpeedBoost (ref) ]]
		return canPurchaseTemporarySpeedBoost(require(ReplicatedStorage.Library.Client.Save).Get())
	end

	local function Callback(p1) --[[ Callback | Line: 57 | Upvalues: Asserts (ref), ServerScriptService (ref), p3 (copy) ]]
		Asserts.Player(p1)

		return require(ServerScriptService.Controllers.SpeedPowerService).AddTemporarySpeedBoostDuration(p1, p3)
	end

	return {
		LockWhileProcessing = true,
		ProductId = p2,
		DisplayName = ("x2 Speed Boost (%*)"):format(v2),
		Desc = ("Double all speed gains for %*."):format(v2),
		TemporarySpeedBoostDurationSeconds = p3,
		TemporarySpeedBoostMultiplier = TreadmillUtil.TEMPORARY_SPEED_BOOST_MULTIPLIER,
		ServerTest = ServerTest,
		ClientTest = ClientTest,
		Callback = Callback
	}
end
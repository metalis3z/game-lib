-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Modules.DefaultStats.Types.Interface)
require(script:FindFirstAncestor("Products").Types.Interface)

local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)

local function validateTier(p1, p2) --[[ validateTier | Line: 27 | Upvalues: TreadmillUtil (copy) ]]
	if p1 == nil then
		return false, "Data not loaded"
	end

	local v1 = TreadmillUtil.ResolveSpeedBoostTierIndex(p1)

	if TreadmillUtil.MAX_SPEED_BOOST_TIER_INDEX <= v1 then
		return false, "Max speed boost owned"
	end

	if p2 == v1 + 1 then
		return true
	end

	return false, "Purchase the previous speed boost first"
end

return function(p1, p2, p3, p4) --[[ Line: 44 | Upvalues: Asserts (copy), Constants (copy), TreadmillUtil (copy), ServerScriptService (copy), validateTier (copy), ReplicatedStorage (copy) ]]
	Asserts.string(p1)
	Asserts.number(p2)
	Asserts.number(p3)
	Asserts.number(p4)

	if Constants.IS_STUDIO then
		local v1 = if p3 >= 1 then if p3 <= TreadmillUtil.MAX_SPEED_BOOST_TIER_INDEX then true else false else false

		assert(v1, (("Invalid speed boost tier index %*"):format(p3)))

		local v3 = if TreadmillUtil.GetSpeedBoostMultiplierForTierIndex(p3) == p4 then true else false

		assert(v3, (("Invalid speed boost multiplier %* for tier %*"):format(p4, p3)))
	end

	local v5 = TreadmillUtil.FormatSpeedMultiplierValue(p4)

	local function ServerTest(p1) --[[ ServerTest | Line: 68 | Upvalues: Asserts (ref), ServerScriptService (ref), validateTier (ref), p3 (copy) ]]
		Asserts.Player(p1)

		local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(p1)

		if v1 and v2 then
			return validateTier(v2, p3)
		end

		return false, "Player profile not found"
	end

	local function ClientTest() --[[ ClientTest | Line: 80 | Upvalues: ReplicatedStorage (ref), validateTier (ref), p3 (copy) ]]
		return validateTier(require(ReplicatedStorage.Library.Client.Save).Get(), p3)
	end

	local function Callback(p1) --[[ Callback | Line: 85 | Upvalues: Asserts (ref), ServerScriptService (ref), p3 (copy), TreadmillUtil (ref) ]]
		Asserts.Player(p1)

		local v1, v2 = require(ServerScriptService.Library.Database).UpdateProfileImmutable(p1, function(p1) --[[ Line: 89 | Upvalues: p3 (ref), TreadmillUtil (ref) ]]
			local v1 = p3
			local v2

			if p1 == nil then
				v2 = false
			else
				local v3 = TreadmillUtil.ResolveSpeedBoostTierIndex(p1)

				v2 = if TreadmillUtil.MAX_SPEED_BOOST_TIER_INDEX <= v3 then false elseif v1 == v3 + 1 then true else false
			end

			if v2 then
				local v4 = table.clone(p1)

				v4.SpeedBoostTierIndex = p3

				return v4
			end

			return false
		end):await()

		if v1 and v2 then
			return true
		end

		return false, "Purchase the previous speed boost first"
	end

	return {
		SinglePurchase = true,
		LockWhileProcessing = true,
		ProductId = p2,
		DisplayName = ("%* Speed Boost"):format(v5),
		Desc = ("Upgrade your permanent speed boost to %*."):format(v5),
		SpeedBoostTierIndex = p3,
		SpeedBoostMultiplier = p4,
		ServerTest = ServerTest,
		ClientTest = ClientTest,
		Callback = Callback
	}
end
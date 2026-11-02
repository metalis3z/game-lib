-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Modules.DefaultStats.Types.Interface)
require(script:FindFirstAncestor("Products").Types.Interface)

local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)
local t = {}

local function canPurchase(p1) --[[ canPurchase | Line: 23 ]]
	if p1 == nil then
		return false, "Player data is not loaded yet."
	end

	return true, nil
end

function t.Create(p1, p2) --[[ Create | Line: 34 | Upvalues: Asserts (copy), TreadmillUtil (copy), ServerScriptService (copy), canPurchase (copy), ReplicatedStorage (copy) ]]
	Asserts.number(p1)
	Asserts.number(p2)
	assert(p1 > 0, "Treadmill equivalent product id must be positive")
	assert(if p2 > 0 then true else false, "Treadmill equivalent duration must be positive")

	local v3 = TreadmillUtil.FormatTreadmillSpeedEquivalentDuration(p2)

	local function ServerTest(p1) --[[ ServerTest | Line: 45 | Upvalues: Asserts (ref), ServerScriptService (ref), canPurchase (ref) ]]
		Asserts.Player(p1)

		local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(p1)

		if v1 then
			return canPurchase(v2)
		end

		return false, "Player data is not loaded yet."
	end

	local function ClientTest() --[[ ClientTest | Line: 55 | Upvalues: ReplicatedStorage (ref), canPurchase (ref) ]]
		return canPurchase(require(ReplicatedStorage.Library.Client.Save).Get())
	end

	local function Callback(p1) --[[ Callback | Line: 60 | Upvalues: Asserts (ref), ServerScriptService (ref), p2 (copy), ReplicatedStorage (ref) ]]
		Asserts.Player(p1)

		local v1, v2 = require(ServerScriptService.Controllers.SpeedPowerService).AddTreadmillEquivalentSpeedPower(p1, p2)

		if v1 then
			require(ServerScriptService.Library.Functions.NotifyItem)(p1, require(ReplicatedStorage.Library.Items.SpeedPowerItem)():SetAmount(v2))

			return true, v2
		end

		return false, 0
	end

	return {
		Desc = "Instantly gain the speed you currently earn on your treadmill.",
		LockWhileProcessing = true,
		ProductId = p1,
		DisplayName = ("Speed - %*"):format(v3),
		TreadmillSpeedEquivalentDurationSeconds = p2,
		ServerTest = ServerTest,
		ClientTest = ClientTest,
		Callback = Callback
	}
end

return t